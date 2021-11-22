import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _theme = "Light";
  var _themeData = ThemeData.light();
  String _value = "";

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = (prefs.getString("theme") ?? "Light");
      _themeData = _theme == "Dark" ? ThemeData.dark() : ThemeData.light();
    });
  }

  _setTheme(theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = theme;
      _themeData = theme == "Dark" ? ThemeData.dark() : ThemeData.light();
      prefs.setString("theme", theme);
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Shared Preferences App"),
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "Light",
                          child: Text("Light"),
                        ),
                        PopupMenuItem(
                          value: "Dark",
                          child: Text("Dark"),
                        ),
                      ],
                  onSelected: (item) => {_setTheme(item)}),
            ],
          ),
          body: Column(
            children: [Text("Clique nos três pontinhos para escolher o tema")],
          )),
    );
  }
}
