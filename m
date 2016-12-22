Received: from eggs.gnu.org ([2001:4830:134:3::10]:37802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DK-0007a1-5e
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DI-0007B2-0G
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DH-0007Ab-Q3
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:23 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:47 +0100
Message-Id: <20161222152300.32395-13-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/25] main-loop: update comment for
 qemu_mutex_lock/unlock_iothread
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

Commit 49cf57281b7 (vl: delay thread initialization after daemonization)
makes the global mutex is taken after daemonization instead before
daemonization by qemu_init_main_loop().

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Message-Id: <1480566640-27264-2-git-send-email-baiyaowei@cmss.chinamobile.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/main-loop.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 470f600..a9d4f23 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -238,7 +238,7 @@ bool qemu_mutex_iothread_locked(void);
  * qemu_mutex_lock_iothread: Lock the main loop mutex.
  *
  * This function locks the main loop mutex.  The mutex is taken by
- * qemu_init_main_loop and always taken except while waiting on
+ * main() in vl.c and always taken except while waiting on
  * external events (such as with select).  The mutex should be taken
  * by threads other than the main loop thread when calling
  * qemu_bh_new(), qemu_set_fd_handler() and basically all other
@@ -253,7 +253,7 @@ void qemu_mutex_lock_iothread(void);
  * qemu_mutex_unlock_iothread: Unlock the main loop mutex.
  *
  * This function unlocks the main loop mutex.  The mutex is taken by
- * qemu_init_main_loop and always taken except while waiting on
+ * main() in vl.c and always taken except while waiting on
  * external events (such as with select).  The mutex should be unlocked
  * as soon as possible by threads other than the main loop thread,
  * because it prevents the main loop from processing callbacks,
-- 
2.9.3
