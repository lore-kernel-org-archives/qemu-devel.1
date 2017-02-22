Received: from eggs.gnu.org ([2001:4830:134:3::10]:54677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgPIv-0006nN-5T
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 00:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgPIp-0006XK-RL
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 00:17:27 -0500
Received: from [59.151.112.132] (port=38450 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgPIp-0006X5-En
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 00:17:23 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 22 Feb 2017 13:16:06 +0800
Message-ID: <1487740566-15302-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2] net/colo-compare: Fix memory free error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

We use g_queue_init() to init s->conn_list, so we should use g_queue_clear()
to instead of g_queue_free().

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index a6fc2ff..300f017 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -729,7 +729,7 @@ static void colo_compare_finalize(Object *obj)
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
 
-    g_queue_free(&s->conn_list);
+    g_queue_clear(&s->conn_list);
 
     g_hash_table_destroy(s->connection_track_table);
     g_free(s->pri_indev);
-- 
2.7.4
