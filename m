Received: from eggs.gnu.org ([2001:4830:134:3::10]:35402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZf-00080l-4M
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZd-0004vy-7z
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:35:59 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54764
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZc-0004sa-TO
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:35:57 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 13 Oct 2017 14:32:08 +0800
Message-ID: <20171013063209.15617-4-maozy.fnst@cn.fujitsu.com>
In-Reply-To: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
References: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/4] colo-compare: Fix comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 net/colo-compare.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 5d2429b..ccdcba2 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -480,7 +480,9 @@ static void colo_old_packet_check(void *opaque)
 
 /*
  * Called from the compare thread on the primary
- * for compare connection
+ * for compare packet with secondary list of the
+ * specified connection when a new packet was
+ * queued to it.
  */
 static void colo_compare_connection(void *opaque, void *user_data)
 {
@@ -738,7 +740,7 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
                          pri_rs->packet_len,
                          pri_rs->vnet_hdr_len);
     } else {
-        /* compare connection */
+        /* compare packet in the specified connection */
         colo_compare_connection(conn, s);
     }
 }
@@ -751,7 +753,7 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
     if (packet_enqueue(s, SECONDARY_IN, &conn)) {
         trace_colo_compare_main("secondary: unsupported packet in");
     } else {
-        /* compare connection */
+        /* compare packet in the specified connection */
         colo_compare_connection(conn, s);
     }
 }
-- 
2.9.4
