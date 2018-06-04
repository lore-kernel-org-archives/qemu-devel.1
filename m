Received: from eggs.gnu.org ([2001:4830:134:3::10]:39154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHw-0002Fq-CN
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHu-00066I-3Z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:52 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHt-00064Q-QA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:50 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:20:15 +0200
Message-Id: <20180604152015.13359-18-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 17/17] linux-user: remove useless #if
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

Remove a "#if defined(XX) || defined(YY) || ..." with all available
targets

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180529194207.31503-16-laurent@vivier.eu>
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
