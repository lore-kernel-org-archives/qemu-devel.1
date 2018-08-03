Received: from eggs.gnu.org ([2001:4830:134:3::10]:49485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1flTkK-0005xv-Aw
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 02:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1flTkJ-0001Le-Hd
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 02:39:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  3 Aug 2018 14:39:17 +0800
Message-Id: <20180803063917.30292-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] aio-posix: Improve comment around marking node
 deleted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

The counter is for qemu_lockcnt_inc/dec sections (read side),
qemu_lockcnt_lock/unlock is for the write side.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 util/aio-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 118bf5784b..9ca20d8cd9 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -232,7 +232,7 @@ void aio_set_fd_handler(AioContext *ctx,
             g_source_remove_poll(&ctx->source, &node->pfd);
         }
 
-        /* If the lock is held, just mark the node as deleted */
+        /* If a read is in progress, just mark the node as deleted */
         if (qemu_lockcnt_count(&ctx->list_lock)) {
             node->deleted = 1;
             node->pfd.revents = 0;
-- 
2.17.1
