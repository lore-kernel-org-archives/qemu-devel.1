Received: from eggs.gnu.org ([2001:4830:134:3::10]:33349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djiSh-0005FC-EA
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djiSg-0000OF-IX
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:53:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:42056
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djiSg-0000NA-6l
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:53:30 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Mon, 21 Aug 2017 16:55:19 +0800
Message-ID: <1503305719-2512-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1503305719-2512-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1503305719-2512-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V4 3/3] net/colo-compare.c: Fix comments and
 scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index a8ccac7..e8af8bb 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -44,7 +44,7 @@
   + CompareState ++
   |               |
   +---------------+   +---------------+         +---------------+
-  |conn list      +--->conn           +--------->conn           |
+  |   conn list   + - >      conn     + ------- >      conn     + -- > .......
   +---------------+   +---------------+         +---------------+
   |               |     |           |             |          |
   +---------------+ +---v----+  +---v----+    +---v----+ +---v----+
@@ -75,14 +75,14 @@ typedef struct CompareState {
     SocketReadState sec_rs;
     bool vnet_hdr;
 
-    /* connection list: the connections belonged to this NIC could be found
-     * in this list.
-     * element type: Connection
+    /*
+     * Record the connection that through the NIC
+     * Element type: Connection
      */
     GQueue conn_list;
-    /* hashtable to save connection */
+    /* Record the connection without repetition */
     GHashTable *connection_track_table;
-    /* compare thread, a thread for each NIC */
+    /* This thread just do packet compare job */
     QemuThread thread;
 
     GMainContext *worker_context;
@@ -444,8 +444,11 @@ static int colo_old_packet_check_one_conn(Connection *conn,
                                  (GCompareFunc)colo_old_packet_check_one);
 
     if (result) {
-        /* do checkpoint will flush old packet */
-        /* TODO: colo_notify_checkpoint();*/
+        /* Do checkpoint will flush old packet */
+        /*
+         * TODO: Notify colo frame to do checkpoint.
+         * colo_compare_inconsistent_notify();
+         */
         return 0;
     }
 
-- 
2.7.4
