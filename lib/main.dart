import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MessagesScreen(),
    );
  }
}

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _selectedIndex = 1;
  late ScrollController _scrollController;
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _showScrollToTop = _scrollController.offset > 200;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Messages'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              controller: _scrollController,
              children: [
                SizedBox(height: 10),
                _buildSectionHeader('Me'),
                _buildContactTile('Syed Taha Ali'),
                SizedBox(height: 10),
                _buildSectionHeader('Frequently contacted'),
                _buildContactTile('Azhar Sir Syed'),
                _buildContactTile('Mama'),
                _buildContactTile('Rao Noman, TPS'),
                _buildContactTile('Rayhaan'),
                _buildContactTile('Taha Shakeel'),
                SizedBox(height: 10),
                _buildSectionHeader('Groups'),
                _buildContactTile('Groups'),
                SizedBox(height: 10),
                _buildSectionHeader('&'),
                _buildContactTile('<Fast> Ammar Khan'),
                _buildContactTile('<Fast> Arhum'),
                SizedBox(height: 400),
              ],
            ),
          ),

          // Alphabet Pane
          Positioned(
            right: 10,
            top: 40,
            bottom: 100,
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.grey),
                  SizedBox(height: 5),
                  Icon(Icons.group, color: Colors.grey),
                  SizedBox(height: 5),
                  Text('&', style: _alphabetStyle()),
                  SizedBox(height: 5),
                  ...List.generate(
                    26,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        String.fromCharCode(65 + index),
                        style: _alphabetStyle(),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('#', style: _alphabetStyle()),
                ],
              ),
            ),
          ),

          // Floating Chat Button
          Positioned(
            bottom: 30,
            right: 70,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {},
              child: Icon(Icons.message, color: Colors.white),
            ),
          ),

          // Scroll to Top Button (Now Centered at Bottom)
          if (_showScrollToTop)
            Positioned(
              bottom: 50,
              left: MediaQuery.of(context).size.width / 2 -
                  25, // Center horizontally
              child: FloatingActionButton(
                backgroundColor: Colors.grey[300],
                onPressed: _scrollToTop,
                child: Icon(Icons.keyboard_arrow_up, color: Colors.black),
              ),
            ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    'Conversations',
                    style: TextStyle(
                      color: _selectedIndex == 0 ? Colors.blue : Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  Positioned(
                    right: -30,
                    top: -5,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.blue,
                      child: Text(
                        '31',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Contacts',
                    style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.blue : Colors.black54,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                      decorationThickness: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create contact tiles
  Widget _buildContactTile(String name) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
              ),
            ],
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            tileColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                name[0], // Get the first letter of the name
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              radius: 22,
            ),
            title: Text(name),
          ),
        ),
      ],
    );
  }

  // Helper function to create section headers
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

  // Helper function for alphabet styling
  TextStyle _alphabetStyle() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    );
  }
}
