Received: from eggs.gnu.org ([2001:4830:134:3::10]:39015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHq-0002AU-K5
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHp-0005zg-B1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHp-0005xy-0y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:45 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:20:05 +0200
Message-Id: <20180604152015.13359-8-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 07/17] linux-user: move mips/mips64 fcntl
 definitions to mips/target_fcntl.h
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
Message-Id: <20180529194207.31503-6-laurent@vivier.eu>
---
 linux-user/mips/target_fcntl.h | 27 +++++++++++++++++++++++++++
 linux-user/syscall_defs.h      | 31 ++-----------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/linux-user/mips/target_fcntl.h b/linux-user/mips/target_fcntl.h
index 5404245068..000527cc95 100644
--- a/linux-user/mips/target_fcntl.h
+++ b/linux-user/mips/target_fcntl.h
@@ -7,5 +7,32 @@
 
 #ifndef MIPS_TARGET_FCNTL_H
 #define MIPS_TARGET_FCNTL_H
+
+#define TARGET_O_APPEND         0x0008
+#define TARGET_O_DSYNC          0x0010
+#define TARGET_O_NONBLOCK       0x0080
+#define TARGET_O_CREAT          0x0100  /* not fcntl */
+#define TARGET_O_TRUNC          0x0200  /* not fcntl */
+#define TARGET_O_EXCL           0x0400  /* not fcntl */
+#define TARGET_O_NOCTTY         0x0800  /* not fcntl */
+#define TARGET_FASYNC           0x1000  /* fcntl, for BSD compatibility */
+#define TARGET_O_LARGEFILE      0x2000  /* allow large file opens */
+#define TARGET___O_SYNC         0x4000
+#define TARGET_O_DIRECT         0x8000  /* direct disk access hint */
+
+#define TARGET_F_GETLK         14
+#define TARGET_F_SETLK         6
+#define TARGET_F_SETLKW        7
+
+#define TARGET_F_SETOWN        24       /*  for sockets. */
+#define TARGET_F_GETOWN        23       /*  for sockets. */
+
+#define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
+#define TARGET_ARCH_FLOCK64_PAD
+
+#define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
+#define TARGET_F_SETLK64       34
+#define TARGET_F_SETLKW64      35
+
 #include "../generic/fcntl.h"
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3d13cdd654..44a590d2c9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2407,13 +2407,7 @@ struct target_statfs64 {
 };
 #endif
 
-#if defined(TARGET_MIPS)
-#define TARGET_F_GETLK         14
-#define TARGET_F_SETLK         6
-#define TARGET_F_SETLKW        7
-#define TARGET_F_SETOWN        24       /*  for sockets. */
-#define TARGET_F_GETOWN        23       /*  for sockets. */
-#elif defined(TARGET_SPARC)
+#if defined(TARGET_SPARC)
 #define TARGET_F_RDLCK         1
 #define TARGET_F_WRLCK         2
 #define TARGET_F_UNLCK         3
@@ -2424,12 +2418,6 @@ struct target_statfs64 {
 #define TARGET_F_SETLKW        9
 #endif
 
-#if defined(TARGET_MIPS)
-#define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
-#define TARGET_F_SETLK64       34
-#define TARGET_F_SETLKW64      35
-#endif
-
 #define TARGET_F_LINUX_SPECIFIC_BASE 1024
 #define TARGET_F_SETLEASE (TARGET_F_LINUX_SPECIFIC_BASE + 0)
 #define TARGET_F_GETLEASE (TARGET_F_LINUX_SPECIFIC_BASE + 1)
@@ -2438,19 +2426,7 @@ struct target_statfs64 {
 #define TARGET_F_GETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 8)
 #define TARGET_F_NOTIFY  (TARGET_F_LINUX_SPECIFIC_BASE+2)
 
-#if defined(TARGET_MIPS)
-#define TARGET_O_APPEND         0x0008
-#define TARGET_O_DSYNC          0x0010
-#define TARGET_O_NONBLOCK       0x0080
-#define TARGET_O_CREAT          0x0100  /* not fcntl */
-#define TARGET_O_TRUNC          0x0200  /* not fcntl */
-#define TARGET_O_EXCL           0x0400  /* not fcntl */
-#define TARGET_O_NOCTTY         0x0800  /* not fcntl */
-#define TARGET_FASYNC           0x1000  /* fcntl, for BSD compatibility */
-#define TARGET_O_LARGEFILE      0x2000  /* allow large file opens */
-#define TARGET___O_SYNC         0x4000
-#define TARGET_O_DIRECT         0x8000  /* direct disk access hint */
-#elif defined (TARGET_PPC)
+#if defined (TARGET_PPC)
 #define TARGET_O_DIRECTORY      040000 /* must be a directory */
 #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
 #define TARGET_O_LARGEFILE     0200000
@@ -2481,9 +2457,6 @@ struct target_statfs64 {
 #if defined(TARGET_SPARC)
 #define TARGET_ARCH_FLOCK_PAD abi_short __unused;
 #define TARGET_ARCH_FLOCK64_PAD abi_short __unused;
-#elif defined(TARGET_MIPS)
-#define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
-#define TARGET_ARCH_FLOCK64_PAD
 #endif
 
 #include "target_fcntl.h"
-- 
2.14.3
