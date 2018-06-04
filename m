Received: from eggs.gnu.org ([2001:4830:134:3::10]:39017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHq-0002AV-Kq
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHn-0005xN-Ax
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHn-0005wI-0z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:43 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:20:04 +0200
Message-Id: <20180604152015.13359-7-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 06/17] linux-user: move arm/aarch64/m68k fcntl
 definitions to [arm|aarch64|m68k]/target_fcntl.h
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180529194207.31503-5-laurent@vivier.eu>
---
 linux-user/aarch64/target_fcntl.h | 5 +++++
 linux-user/arm/target_fcntl.h     | 6 ++++++
 linux-user/m68k/target_fcntl.h    | 6 ++++++
 linux-user/syscall_defs.h         | 7 +------
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
index 59be406280..efdf6e5f05 100644
--- a/linux-user/aarch64/target_fcntl.h
+++ b/linux-user/aarch64/target_fcntl.h
@@ -7,5 +7,10 @@
 
 #ifndef AARCH64_TARGET_FCNTL_H
 #define AARCH64_TARGET_FCNTL_H
+
+#define TARGET_O_DIRECTORY      040000 /* must be a directory */
+#define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
+#define TARGET_O_DIRECT        0200000 /* direct disk access hint */
+
 #include "../generic/fcntl.h"
 #endif
diff --git a/linux-user/arm/target_fcntl.h b/linux-user/arm/target_fcntl.h
index ca819df519..c8ff6b2505 100644
--- a/linux-user/arm/target_fcntl.h
+++ b/linux-user/arm/target_fcntl.h
@@ -7,5 +7,11 @@
 
 #ifndef ARM_TARGET_FCNTL_H
 #define ARM_TARGET_FCNTL_H
+
+#define TARGET_O_DIRECTORY      040000 /* must be a directory */
+#define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
+#define TARGET_O_DIRECT        0200000 /* direct disk access hint */
+#define TARGET_O_LARGEFILE     0400000
+
 #include "../generic/fcntl.h"
 #endif
diff --git a/linux-user/m68k/target_fcntl.h b/linux-user/m68k/target_fcntl.h
index 4328c60d22..068bc3243e 100644
--- a/linux-user/m68k/target_fcntl.h
+++ b/linux-user/m68k/target_fcntl.h
@@ -7,5 +7,11 @@
 
 #ifndef M68K_TARGET_FCNTL_H
 #define M68K_TARGET_FCNTL_H
+
+#define TARGET_O_DIRECTORY      040000 /* must be a directory */
+#define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
+#define TARGET_O_DIRECT        0200000 /* direct disk access hint */
+#define TARGET_O_LARGEFILE     0400000
+
 #include "../generic/fcntl.h"
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 46d2353254..3d13cdd654 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2438,12 +2438,7 @@ struct target_statfs64 {
 #define TARGET_F_GETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 8)
 #define TARGET_F_NOTIFY  (TARGET_F_LINUX_SPECIFIC_BASE+2)
 
-#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_AARCH64)
-#define TARGET_O_DIRECTORY      040000 /* must be a directory */
-#define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
-#define TARGET_O_DIRECT        0200000 /* direct disk access hint */
-#define TARGET_O_LARGEFILE     0400000
-#elif defined(TARGET_MIPS)
+#if defined(TARGET_MIPS)
 #define TARGET_O_APPEND         0x0008
 #define TARGET_O_DSYNC          0x0010
 #define TARGET_O_NONBLOCK       0x0080
-- 
2.14.3
