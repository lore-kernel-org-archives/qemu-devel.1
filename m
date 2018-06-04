Received: from eggs.gnu.org ([2001:4830:134:3::10]:39073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHt-0002Cj-B7
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHr-00062Z-D0
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:49 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHq-00060s-WD
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:47 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:20:03 +0200
Message-Id: <20180604152015.13359-6-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 05/17] linux-user: move hppa fcntl definitions
 to hppa/target_fcntl.h
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
Message-Id: <20180529194207.31503-4-laurent@vivier.eu>
---
 linux-user/hppa/target_fcntl.h | 31 +++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h      | 34 +---------------------------------
 2 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/linux-user/hppa/target_fcntl.h b/linux-user/hppa/target_fcntl.h
index aa282a5ce8..bd966a59b8 100644
--- a/linux-user/hppa/target_fcntl.h
+++ b/linux-user/hppa/target_fcntl.h
@@ -7,5 +7,36 @@
 
 #ifndef HPPA_TARGET_FCNTL_H
 #define HPPA_TARGET_FCNTL_H
+
+#define TARGET_O_NONBLOCK    000200004 /* HPUX has separate NDELAY & NONBLOCK */
+#define TARGET_O_APPEND      000000010
+#define TARGET_O_CREAT       000000400 /* not fcntl */
+#define TARGET_O_EXCL        000002000 /* not fcntl */
+#define TARGET_O_NOCTTY      000400000 /* not fcntl */
+#define TARGET_O_DSYNC       001000000
+#define TARGET_O_LARGEFILE   000004000
+#define TARGET_O_DIRECTORY   000010000 /* must be a directory */
+#define TARGET_O_NOFOLLOW    000000200 /* don't follow links */
+#define TARGET_O_NOATIME     004000000
+#define TARGET_O_CLOEXEC     010000000
+#define TARGET___O_SYNC      000100000
+#define TARGET_O_PATH        020000000
+
+#define TARGET_F_RDLCK         1
+#define TARGET_F_WRLCK         2
+#define TARGET_F_UNLCK         3
+
+#define TARGET_F_GETLK64       8       /*  using 'struct flock64' */
+#define TARGET_F_SETLK64       9
+#define TARGET_F_SETLKW64      10
+
+#define TARGET_F_GETLK         5
+#define TARGET_F_SETLK         6
+#define TARGET_F_SETLKW        7
+#define TARGET_F_GETOWN        11       /*  for sockets. */
+#define TARGET_F_SETOWN        12       /*  for sockets. */
+#define TARGET_F_SETSIG        13      /*  for sockets. */
+#define TARGET_F_GETSIG        14      /*  for sockets. */
+
 #include "../generic/fcntl.h"
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index d8318ebd27..46d2353254 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2413,15 +2413,6 @@ struct target_statfs64 {
 #define TARGET_F_SETLKW        7
 #define TARGET_F_SETOWN        24       /*  for sockets. */
 #define TARGET_F_GETOWN        23       /*  for sockets. */
-#elif defined(TARGET_HPPA)
-#define TARGET_F_RDLCK         1
-#define TARGET_F_WRLCK         2
-#define TARGET_F_UNLCK         3
-#define TARGET_F_GETLK         5
-#define TARGET_F_SETLK         6
-#define TARGET_F_SETLKW        7
-#define TARGET_F_GETOWN        11       /*  for sockets. */
-#define TARGET_F_SETOWN        12       /*  for sockets. */
 #elif defined(TARGET_SPARC)
 #define TARGET_F_RDLCK         1
 #define TARGET_F_WRLCK         2
@@ -2433,19 +2424,10 @@ struct target_statfs64 {
 #define TARGET_F_SETLKW        9
 #endif
 
-#if defined(TARGET_HPPA)
-#define TARGET_F_SETSIG        13      /*  for sockets. */
-#define TARGET_F_GETSIG        14      /*  for sockets. */
-#endif
-
 #if defined(TARGET_MIPS)
 #define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
 #define TARGET_F_SETLK64       34
 #define TARGET_F_SETLKW64      35
-#elif defined(TARGET_HPPA)
-#define TARGET_F_GETLK64       8       /*  using 'struct flock64' */
-#define TARGET_F_SETLK64       9
-#define TARGET_F_SETLKW64      10
 #endif
 
 #define TARGET_F_LINUX_SPECIFIC_BASE 1024
@@ -2456,21 +2438,7 @@ struct target_statfs64 {
 #define TARGET_F_GETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 8)
 #define TARGET_F_NOTIFY  (TARGET_F_LINUX_SPECIFIC_BASE+2)
 
-#if defined(TARGET_HPPA)
-#define TARGET_O_NONBLOCK    000200004 /* HPUX has separate NDELAY & NONBLOCK */
-#define TARGET_O_APPEND      000000010
-#define TARGET_O_CREAT       000000400 /* not fcntl */
-#define TARGET_O_EXCL        000002000 /* not fcntl */
-#define TARGET_O_NOCTTY      000400000 /* not fcntl */
-#define TARGET_O_DSYNC       001000000
-#define TARGET_O_LARGEFILE   000004000
-#define TARGET_O_DIRECTORY   000010000 /* must be a directory */
-#define TARGET_O_NOFOLLOW    000000200 /* don't follow links */
-#define TARGET_O_NOATIME     004000000
-#define TARGET_O_CLOEXEC     010000000
-#define TARGET___O_SYNC      000100000
-#define TARGET_O_PATH        020000000
-#elif defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_AARCH64)
+#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_AARCH64)
 #define TARGET_O_DIRECTORY      040000 /* must be a directory */
 #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
 #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
-- 
2.14.3
