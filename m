Received: from eggs.gnu.org ([2001:4830:134:3::10]:58424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAF-00081Q-5y
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAE-0001Bd-AO
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklAE-0001BG-4N
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:30 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:46 +0800
Message-Id: <1488777954-4578-12-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 11/19] net/colo-compare: Fix memory free
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

We use g_queue_init() to init s->conn_list, so we should use g_queue_clear()
to instead of g_queue_free().

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
