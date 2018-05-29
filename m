Received: from eggs.gnu.org ([2001:4830:134:3::10]:38065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVs-0004If-Dx
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVr-0000XI-Ec
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:32 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fNkVr-0000Wk-4b
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:31 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 29 May 2018 21:42:05 +0200
Message-Id: <20180529194207.31503-14-laurent@vivier.eu>
In-Reply-To: <20180529194207.31503-1-laurent@vivier.eu>
References: <20180529194207.31503-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 13/15] linux-user: move alpha signal
 definitions to alpha/target_signal.h
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

No code change.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/target_signal.h | 45 +++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h        | 51 ++--------------------------------------
 2 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/linux-user/alpha/target_signal.h b/linux-user/alpha/target_signal.h
index e6f2f04911..cd63d59fde 100644
--- a/linux-user/alpha/target_signal.h
+++ b/linux-user/alpha/target_signal.h
@@ -1,6 +1,43 @@
 #ifndef ALPHA_TARGET_SIGNAL_H
 #define ALPHA_TARGET_SIGNAL_H
 
+#define TARGET_SIGHUP            1
+#define TARGET_SIGINT            2
+#define TARGET_SIGQUIT           3
+#define TARGET_SIGILL            4
+#define TARGET_SIGTRAP           5
+#define TARGET_SIGABRT           6
+#define TARGET_SIGSTKFLT         7 /* actually SIGEMT */
+#define TARGET_SIGFPE            8
+#define TARGET_SIGKILL           9
+#define TARGET_SIGBUS           10
+#define TARGET_SIGSEGV          11
+#define TARGET_SIGSYS           12
+#define TARGET_SIGPIPE          13
+#define TARGET_SIGALRM          14
+#define TARGET_SIGTERM          15
+#define TARGET_SIGURG           16
+#define TARGET_SIGSTOP          17
+#define TARGET_SIGTSTP          18
+#define TARGET_SIGCONT          19
+#define TARGET_SIGCHLD          20
+#define TARGET_SIGTTIN          21
+#define TARGET_SIGTTOU          22
+#define TARGET_SIGIO            23
+#define TARGET_SIGXCPU          24
+#define TARGET_SIGXFSZ          25
+#define TARGET_SIGVTALRM        26
+#define TARGET_SIGPROF          27
+#define TARGET_SIGWINCH         28
+#define TARGET_SIGPWR           29 /* actually SIGINFO */
+#define TARGET_SIGUSR1          30
+#define TARGET_SIGUSR2          31
+#define TARGET_SIGRTMIN         32
+
+#define TARGET_SIG_BLOCK         1
+#define TARGET_SIG_UNBLOCK       2
+#define TARGET_SIG_SETMASK       3
+
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -17,6 +54,14 @@ typedef struct target_sigaltstack {
 #define TARGET_SS_ONSTACK	1
 #define TARGET_SS_DISABLE	2
 
+#define TARGET_SA_ONSTACK       0x00000001
+#define TARGET_SA_RESTART       0x00000002
+#define TARGET_SA_NOCLDSTOP     0x00000004
+#define TARGET_SA_NODEFER       0x00000008
+#define TARGET_SA_RESETHAND     0x00000010
+#define TARGET_SA_NOCLDWAIT     0x00000020 /* not supported yet */
+#define TARGET_SA_SIGINFO       0x00000040
+
 #define TARGET_MINSIGSTKSZ	4096
 #define TARGET_SIGSTKSZ		16384
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 360d37c9c0..8436875005 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -426,15 +426,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     || defined(TARGET_TILEGX) || defined(TARGET_HPPA) || defined(TARGET_NIOS2) \
     || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
 
-#if defined(TARGET_ALPHA)
-#define TARGET_SA_ONSTACK	0x00000001
-#define TARGET_SA_RESTART	0x00000002
-#define TARGET_SA_NOCLDSTOP	0x00000004
-#define TARGET_SA_NODEFER	0x00000008
-#define TARGET_SA_RESETHAND	0x00000010
-#define TARGET_SA_NOCLDWAIT	0x00000020 /* not supported yet */
-#define TARGET_SA_SIGINFO	0x00000040
-#elif defined(TARGET_HPPA)
+#if defined(TARGET_HPPA)
 #define TARGET_SA_ONSTACK       0x00000001
 #define TARGET_SA_RESETHAND     0x00000004
 #define TARGET_SA_NOCLDSTOP     0x00000008
@@ -450,46 +442,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_ARCH_HAS_SA_RESTORER 1
 #endif
 
-#if defined(TARGET_ALPHA)
-
-#define TARGET_SIGHUP            1
-#define TARGET_SIGINT            2
-#define TARGET_SIGQUIT           3
-#define TARGET_SIGILL            4
-#define TARGET_SIGTRAP           5
-#define TARGET_SIGABRT           6
-#define TARGET_SIGSTKFLT         7 /* actually SIGEMT */
-#define TARGET_SIGFPE            8
-#define TARGET_SIGKILL           9
-#define TARGET_SIGBUS           10
-#define TARGET_SIGSEGV          11
-#define TARGET_SIGSYS           12
-#define TARGET_SIGPIPE          13
-#define TARGET_SIGALRM          14
-#define TARGET_SIGTERM          15
-#define TARGET_SIGURG           16
-#define TARGET_SIGSTOP          17
-#define TARGET_SIGTSTP          18
-#define TARGET_SIGCONT          19
-#define TARGET_SIGCHLD          20
-#define TARGET_SIGTTIN          21
-#define TARGET_SIGTTOU          22
-#define TARGET_SIGIO            23
-#define TARGET_SIGXCPU          24
-#define TARGET_SIGXFSZ          25
-#define TARGET_SIGVTALRM        26
-#define TARGET_SIGPROF          27
-#define TARGET_SIGWINCH         28
-#define TARGET_SIGPWR           29 /* actually SIGINFO */
-#define TARGET_SIGUSR1          30
-#define TARGET_SIGUSR2          31
-#define TARGET_SIGRTMIN         32
-
-#define TARGET_SIG_BLOCK         1
-#define TARGET_SIG_UNBLOCK       2
-#define TARGET_SIG_SETMASK       3
-
-#elif defined(TARGET_HPPA)
+#if defined(TARGET_HPPA)
 
 #define TARGET_SIGHUP           1
 #define TARGET_SIGINT           2
-- 
2.14.3
