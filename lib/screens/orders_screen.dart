import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;

import '../widgets/order-item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  // @override
  // void didChangeDependencies() {
  //   setState(() {
  //         _isLoading = true;
  //       });
  //   Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(), builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (dataSnapshot.error != null) {
            //error handling
            return Center(child: Text('Error occured',),);
          } else {
            return Consumer<Orders>(builder: (ctx, orderData, child) => ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),);
          }
        }
      },), 
    );
  }
}
