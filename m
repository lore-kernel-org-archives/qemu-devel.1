Received: from eggs.gnu.org ([2001:4830:134:3::10]:41318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg0SK-0007OU-JV
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg0SG-0003wJ-43
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:45:32 -0500
Received: from [59.151.112.132] (port=14264 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg0SF-0003ve-OO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:45:28 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 21 Feb 2017 10:44:01 +0800
Message-ID: <1487645041-28919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] net/colo-compare: Fix memory free error
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
---
 net/colo-compare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 162fd6a..cf8c4c9 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -715,7 +715,7 @@ static void colo_compare_finalize(Object *obj)
     qemu_chr_fe_deinit(&s->chr_sec_in);
     qemu_chr_fe_deinit(&s->chr_out);
 
-    g_queue_free(&s->conn_list);
+    g_queue_clear(&s->conn_list);
 
     if (qemu_thread_is_self(&s->thread)) {
         /* compare connection */
-- 
2.7.4
