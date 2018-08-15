Received: from eggs.gnu.org ([2001:4830:134:3::10]:57058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFb-0007Jz-Dn
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFa-0001t2-Mf
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35490 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmFa-0001qx-F2
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:34 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:48 +0800
Message-Id: <20180815031248.14908-18-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 17/17] aio-posix: Improve comment around marking
 node deleted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The counter is for qemu_lockcnt_inc/dec sections (read side),
qemu_lockcnt_lock/unlock is for the write side.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180803063917.30292-1-famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 util/aio-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index b5c609b68b..131ba6b4a8 100644
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
