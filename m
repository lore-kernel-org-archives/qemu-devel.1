Received: from eggs.gnu.org ([2001:4830:134:3::10]:57710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhk-0004mw-MY
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhj-0000ok-Ov
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:12:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eEQhj-0000oI-IL
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:11:59 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2017 10:11:34 +0800
Message-Id: <1510625498-4821-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] colo-compare: Fix comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
2.7.4
