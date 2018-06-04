Received: from eggs.gnu.org ([2001:4830:134:3::10]:39181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHy-0002Gx-3P
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHw-0006BD-QI
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:54 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHw-000699-HI
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:52 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:20:14 +0200
Message-Id: <20180604152015.13359-17-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 16/17] linux-user: move hppa signal definitions
 to hppa/target_signal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

No code change.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180529194207.31503-15-laurent@vivier.eu>
---
 linux-user/hppa/target_signal.h | 46 ++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h       | 52 -----------------------------------------
 2 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index 1beae6485a..ba159ff8d0 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -1,6 +1,44 @@
 #ifndef HPPA_TARGET_SIGNAL_H
 #define HPPA_TARGET_SIGNAL_H
 
+#define TARGET_SIGHUP           1
+#define TARGET_SIGINT           2
+#define TARGET_SIGQUIT          3
+#define TARGET_SIGILL           4
+#define TARGET_SIGTRAP          5
+#define TARGET_SIGABRT          6
+#define TARGET_SIGIOT           6
+#define TARGET_SIGSTKFLT        7
+#define TARGET_SIGFPE           8
+#define TARGET_SIGKILL          9
+#define TARGET_SIGBUS          10
+#define TARGET_SIGSEGV         11
+#define TARGET_SIGXCPU         12
+#define TARGET_SIGPIPE         13
+#define TARGET_SIGALRM         14
+#define TARGET_SIGTERM         15
+#define TARGET_SIGUSR1         16
+#define TARGET_SIGUSR2         17
+#define TARGET_SIGCHLD         18
+#define TARGET_SIGPWR          19
+#define TARGET_SIGVTALRM       20
+#define TARGET_SIGPROF         21
+#define TARGET_SIGIO           22
+#define TARGET_SIGPOLL         TARGET_SIGIO
+#define TARGET_SIGWINCH        23
+#define TARGET_SIGSTOP         24
+#define TARGET_SIGTSTP         25
+#define TARGET_SIGCONT         26
+#define TARGET_SIGTTIN         27
+#define TARGET_SIGTTOU         28
+#define TARGET_SIGURG          29
+#define TARGET_SIGXFSZ         30
+#define TARGET_SIGSYS          31
+
+#define TARGET_SIG_BLOCK       0
+#define TARGET_SIG_UNBLOCK     1
+#define TARGET_SIG_SETMASK     2
+
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -16,6 +54,14 @@ typedef struct target_sigaltstack {
 #define TARGET_SS_ONSTACK	1
 #define TARGET_SS_DISABLE	2
 
+#define TARGET_SA_ONSTACK       0x00000001
+#define TARGET_SA_RESETHAND     0x00000004
+#define TARGET_SA_NOCLDSTOP     0x00000008
+#define TARGET_SA_SIGINFO       0x00000010
+#define TARGET_SA_NODEFER       0x00000020
+#define TARGET_SA_RESTART       0x00000040
+#define TARGET_SA_NOCLDWAIT     0x00000080
+
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ		8192
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 8436875005..e2896ae1b3 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -426,64 +426,12 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     || defined(TARGET_TILEGX) || defined(TARGET_HPPA) || defined(TARGET_NIOS2) \
     || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
 
-#if defined(TARGET_HPPA)
-#define TARGET_SA_ONSTACK       0x00000001
-#define TARGET_SA_RESETHAND     0x00000004
-#define TARGET_SA_NOCLDSTOP     0x00000008
-#define TARGET_SA_SIGINFO       0x00000010
-#define TARGET_SA_NODEFER       0x00000020
-#define TARGET_SA_RESTART       0x00000040
-#define TARGET_SA_NOCLDWAIT     0x00000080
-#endif
-
 #include "target_signal.h"
 
 #ifdef TARGET_SA_RESTORER
 #define TARGET_ARCH_HAS_SA_RESTORER 1
 #endif
 
-#if defined(TARGET_HPPA)
-
-#define TARGET_SIGHUP           1
-#define TARGET_SIGINT           2
-#define TARGET_SIGQUIT          3
-#define TARGET_SIGILL           4
-#define TARGET_SIGTRAP          5
-#define TARGET_SIGABRT          6
-#define TARGET_SIGIOT           6
-#define TARGET_SIGSTKFLT        7
-#define TARGET_SIGFPE           8
-#define TARGET_SIGKILL          9
-#define TARGET_SIGBUS          10
-#define TARGET_SIGSEGV         11
-#define TARGET_SIGXCPU         12
-#define TARGET_SIGPIPE         13
-#define TARGET_SIGALRM         14
-#define TARGET_SIGTERM         15
-#define TARGET_SIGUSR1         16
-#define TARGET_SIGUSR2         17
-#define TARGET_SIGCHLD         18
-#define TARGET_SIGPWR          19
-#define TARGET_SIGVTALRM       20
-#define TARGET_SIGPROF         21
-#define TARGET_SIGIO           22
-#define TARGET_SIGPOLL         TARGET_SIGIO
-#define TARGET_SIGWINCH        23
-#define TARGET_SIGSTOP         24
-#define TARGET_SIGTSTP         25
-#define TARGET_SIGCONT         26
-#define TARGET_SIGTTIN         27
-#define TARGET_SIGTTOU         28
-#define TARGET_SIGURG          29
-#define TARGET_SIGXFSZ         30
-#define TARGET_SIGSYS          31
-
-#define TARGET_SIG_BLOCK       0
-#define TARGET_SIG_UNBLOCK     1
-#define TARGET_SIG_SETMASK     2
-
-#endif
-
 #if defined(TARGET_ALPHA)
 struct target_old_sigaction {
     abi_ulong _sa_handler;
-- 
2.14.3
