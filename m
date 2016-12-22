Received: from eggs.gnu.org ([2001:4830:134:3::10]:37832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DO-0007lG-48
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DJ-0007Ba-4O
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DI-0007BI-U9
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:25 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:48 +0100
Message-Id: <20161222152300.32395-14-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/25] block: drop remaining legacy aio
 functions in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>

From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>

Commit 87f68d318222563822b5c6b28192215fc4b4e441 (block: drop aio
functions that operate on the main AioContext) drops qemu_aio_wait
function references mostly while leaves these behind, clean up them.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Message-Id: <1480566640-27264-3-git-send-email-baiyaowei@cmss.chinamobile.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/aio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index c7ae27c..ca551e3 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -195,8 +195,8 @@ QEMUBH *aio_bh_new(AioContext *ctx, QEMUBHFunc *cb, void *opaque);
  * aio_notify: Force processing of pending events.
  *
  * Similar to signaling a condition variable, aio_notify forces
- * aio_wait to exit, so that the next call will re-examine pending events.
- * The caller of aio_notify will usually call aio_wait again very soon,
+ * aio_poll to exit, so that the next call will re-examine pending events.
+ * The caller of aio_notify will usually call aio_poll again very soon,
  * or go through another iteration of the GLib main loop.  Hence, aio_notify
  * also has the side effect of recalculating the sets of file descriptors
  * that the main loop waits for.
-- 
2.9.3
