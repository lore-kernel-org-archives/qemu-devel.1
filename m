Received: from eggs.gnu.org ([2001:4830:134:3::10]:38080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVs-0004JC-TX
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVs-0000Xm-9f
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:33 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fNkVs-0000XE-0X
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:32 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 29 May 2018 21:42:07 +0200
Message-Id: <20180529194207.31503-16-laurent@vivier.eu>
In-Reply-To: <20180529194207.31503-1-laurent@vivier.eu>
References: <20180529194207.31503-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 15/15] linux-user: remove useless #if
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

Remove a "#if defined(XX) || defined(YY) || ..." with all available
targets

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall_defs.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e2896ae1b3..40bb60ef4c 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -418,14 +418,6 @@ struct target_sigaction;
 int do_sigaction(int sig, const struct target_sigaction *act,
                  struct target_sigaction *oact);
 
-#if defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_SPARC) \
-    || defined(TARGET_PPC) || defined(TARGET_MIPS) || defined(TARGET_SH4) \
-    || defined(TARGET_M68K) || defined(TARGET_ALPHA) || defined(TARGET_CRIS) \
-    || defined(TARGET_MICROBLAZE) \
-    || defined(TARGET_S390X) || defined(TARGET_OPENRISC) \
-    || defined(TARGET_TILEGX) || defined(TARGET_HPPA) || defined(TARGET_NIOS2) \
-    || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
-
 #include "target_signal.h"
 
 #ifdef TARGET_SA_RESTORER
@@ -666,8 +658,6 @@ typedef struct target_siginfo {
 #define TARGET_TRAP_BRANCH      (3)     /* process taken branch trap */
 #define TARGET_TRAP_HWBKPT      (4)     /* hardware breakpoint/watchpoint */
 
-#endif /* defined(TARGET_I386) || defined(TARGET_ARM) */
-
 struct target_rlimit {
         abi_ulong   rlim_cur;
         abi_ulong   rlim_max;
-- 
2.14.3
