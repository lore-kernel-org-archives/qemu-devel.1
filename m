Received: from eggs.gnu.org ([2001:4830:134:3::10]:39096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHt-0002D0-SR
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHs-000643-Rf
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:49 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHs-00062M-I1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:48 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:20:12 +0200
Message-Id: <20180604152015.13359-15-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 14/17] linux-user: move openrisc signal
 definitions to openrisc/target_signal.h
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
Message-Id: <20180529194207.31503-13-laurent@vivier.eu>
---
 linux-user/openrisc/target_signal.h |  8 ++++++++
 linux-user/syscall_defs.h           | 10 +---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
index 3ccbb974d9..c352a8b333 100644
--- a/linux-user/openrisc/target_signal.h
+++ b/linux-user/openrisc/target_signal.h
@@ -13,6 +13,14 @@ typedef struct target_sigaltstack {
 #define TARGET_SS_ONSTACK     1
 #define TARGET_SS_DISABLE     2
 
+#define TARGET_SA_NOCLDSTOP    0x00000001
+#define TARGET_SA_NOCLDWAIT    0x00000002
+#define TARGET_SA_SIGINFO      0x00000004
+#define TARGET_SA_ONSTACK      0x08000000
+#define TARGET_SA_RESTART      0x10000000
+#define TARGET_SA_NODEFER      0x40000000
+#define TARGET_SA_RESETHAND    0x80000000
+
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 21d3ef5559..360d37c9c0 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -426,15 +426,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     || defined(TARGET_TILEGX) || defined(TARGET_HPPA) || defined(TARGET_NIOS2) \
     || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
 
-#if defined(TARGET_OPENRISC)
-#define TARGET_SA_NOCLDSTOP    0x00000001
-#define TARGET_SA_NOCLDWAIT    0x00000002
-#define TARGET_SA_SIGINFO      0x00000004
-#define TARGET_SA_ONSTACK      0x08000000
-#define TARGET_SA_RESTART      0x10000000
-#define TARGET_SA_NODEFER      0x40000000
-#define TARGET_SA_RESETHAND    0x80000000
-#elif defined(TARGET_ALPHA)
+#if defined(TARGET_ALPHA)
 #define TARGET_SA_ONSTACK	0x00000001
 #define TARGET_SA_RESTART	0x00000002
 #define TARGET_SA_NOCLDSTOP	0x00000004
-- 
2.14.3
