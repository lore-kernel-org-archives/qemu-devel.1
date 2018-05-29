Received: from eggs.gnu.org ([2001:4830:134:3::10]:37971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVo-0004F6-ES
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVl-0000Si-Cx
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fNkVl-0000QQ-4T
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 29 May 2018 21:41:54 +0200
Message-Id: <20180529194207.31503-3-laurent@vivier.eu>
In-Reply-To: <20180529194207.31503-1-laurent@vivier.eu>
References: <20180529194207.31503-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 02/15] linux-user: move alpha fcntl definitions
 to alpha/target_fcntl.h
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
 linux-user/alpha/target_fcntl.h | 29 +++++++++++++++++++++++++++++
 linux-user/syscall_defs.h       | 32 ++------------------------------
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/linux-user/alpha/target_fcntl.h b/linux-user/alpha/target_fcntl.h
index bb603ff28c..2617e73472 100644
--- a/linux-user/alpha/target_fcntl.h
+++ b/linux-user/alpha/target_fcntl.h
@@ -7,5 +7,34 @@
 
 #ifndef ALPHA_TARGET_FCNTL_H
 #define ALPHA_TARGET_FCNTL_H
+
+#define TARGET_O_NONBLOCK           04
+#define TARGET_O_APPEND            010
+#define TARGET_O_CREAT           01000 /* not fcntl */
+#define TARGET_O_TRUNC           02000 /* not fcntl */
+#define TARGET_O_EXCL            04000 /* not fcntl */
+#define TARGET_O_NOCTTY         010000 /* not fcntl */
+#define TARGET_O_DSYNC          040000
+#define TARGET_O_LARGEFILE           0 /* not necessary, always 64-bit */
+#define TARGET_O_DIRECTORY     0100000 /* must be a directory */
+#define TARGET_O_NOFOLLOW      0200000 /* don't follow links */
+#define TARGET_O_DIRECT       02000000 /* direct disk access hint */
+#define TARGET_O_NOATIME      04000000
+#define TARGET_O_CLOEXEC     010000000
+#define TARGET___O_SYNC      020000000
+#define TARGET_O_PATH        040000000
+
+#define TARGET_F_GETLK         7
+#define TARGET_F_SETLK         8
+#define TARGET_F_SETLKW        9
+#define TARGET_F_SETOWN        5       /*  for sockets. */
+#define TARGET_F_GETOWN        6       /*  for sockets. */
+
+#define TARGET_F_RDLCK         1
+#define TARGET_F_WRLCK         2
+#define TARGET_F_UNLCK         8
+#define TARGET_F_EXLCK         16
+#define TARGET_F_SHLCK         32
+
 #include "../generic/fcntl.h"
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 9969f21ba1..d8318ebd27 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2407,19 +2407,7 @@ struct target_statfs64 {
 };
 #endif
 
-#if defined(TARGET_ALPHA)
-#define TARGET_F_GETLK         7
-#define TARGET_F_SETLK         8
-#define TARGET_F_SETLKW        9
-#define TARGET_F_SETOWN        5       /*  for sockets. */
-#define TARGET_F_GETOWN        6       /*  for sockets. */
-
-#define TARGET_F_RDLCK         1
-#define TARGET_F_WRLCK         2
-#define TARGET_F_UNLCK         8
-#define TARGET_F_EXLCK         16
-#define TARGET_F_SHLCK         32
-#elif defined(TARGET_MIPS)
+#if defined(TARGET_MIPS)
 #define TARGET_F_GETLK         14
 #define TARGET_F_SETLK         6
 #define TARGET_F_SETLKW        7
@@ -2468,23 +2456,7 @@ struct target_statfs64 {
 #define TARGET_F_GETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 8)
 #define TARGET_F_NOTIFY  (TARGET_F_LINUX_SPECIFIC_BASE+2)
 
-#if defined(TARGET_ALPHA)
-#define TARGET_O_NONBLOCK           04
-#define TARGET_O_APPEND            010
-#define TARGET_O_CREAT           01000 /* not fcntl */
-#define TARGET_O_TRUNC           02000 /* not fcntl */
-#define TARGET_O_EXCL            04000 /* not fcntl */
-#define TARGET_O_NOCTTY         010000 /* not fcntl */
-#define TARGET_O_DSYNC          040000
-#define TARGET_O_LARGEFILE           0 /* not necessary, always 64-bit */
-#define TARGET_O_DIRECTORY     0100000 /* must be a directory */
-#define TARGET_O_NOFOLLOW      0200000 /* don't follow links */
-#define TARGET_O_DIRECT       02000000 /* direct disk access hint */
-#define TARGET_O_NOATIME      04000000
-#define TARGET_O_CLOEXEC     010000000
-#define TARGET___O_SYNC      020000000
-#define TARGET_O_PATH        040000000
-#elif defined(TARGET_HPPA)
+#if defined(TARGET_HPPA)
 #define TARGET_O_NONBLOCK    000200004 /* HPUX has separate NDELAY & NONBLOCK */
 #define TARGET_O_APPEND      000000010
 #define TARGET_O_CREAT       000000400 /* not fcntl */
-- 
2.14.3
