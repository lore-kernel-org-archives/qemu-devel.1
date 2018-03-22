Received: from eggs.gnu.org ([2001:4830:134:3::10]:53317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ez8Er-0004bj-VQ
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ez8Er-0004F0-1b
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:59:14 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ez8Eq-0004DL-OL
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 17:59:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 22 Mar 2018 22:58:30 +0100
Message-Id: <20180322215833.7713-3-laurent@vivier.eu>
In-Reply-To: <20180322215833.7713-1-laurent@vivier.eu>
References: <20180322215833.7713-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 2/5] linux-user: remove unneeded
 #ifdef in signal.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2c08ca14cf..514145b299 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -253,17 +253,15 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
     return 0;
 }
 
-#if !defined(TARGET_OPENRISC) && !defined(TARGET_NIOS2)
 /* Just set the guest's signal mask to the specified value; the
  * caller is assumed to have called block_signals() already.
  */
-static void set_sigmask(const sigset_t *set)
+static __attribute__((unused)) void set_sigmask(const sigset_t *set)
 {
     TaskState *ts = (TaskState *)thread_cpu->opaque;
 
     ts->signal_mask = *set;
 }
-#endif
 
 /* siginfo conversion */
 
@@ -533,8 +531,7 @@ static void force_sig(int sig)
  * up the signal frame. oldsig is the signal we were trying to handle
  * at the point of failure.
  */
-#if !defined(TARGET_RISCV)
-static void force_sigsegv(int oldsig)
+static __attribute__((unused)) void force_sigsegv(int oldsig)
 {
     if (oldsig == SIGSEGV) {
         /* Make sure we don't try to deliver the signal again; this will
@@ -545,8 +542,6 @@ static void force_sigsegv(int oldsig)
     force_sig(TARGET_SIGSEGV);
 }
 
-#endif
-
 /* abort execution with signal */
 static void QEMU_NORETURN dump_core_and_abort(int target_sig)
 {
-- 
2.14.3
