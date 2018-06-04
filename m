Received: from eggs.gnu.org ([2001:4830:134:3::10]:39153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHw-0002Fp-C8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHt-00064U-1c
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:52 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHs-000634-Oa
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:48 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:20:06 +0200
Message-Id: <20180604152015.13359-9-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 08/17] linux-user: move ppc fcntl definitions to
 ppc/target_fcntl.h
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
Message-Id: <20180529194207.31503-7-laurent@vivier.eu>
---
 linux-user/ppc/target_fcntl.h | 6 ++++++
 linux-user/syscall_defs.h     | 7 +------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/linux-user/ppc/target_fcntl.h b/linux-user/ppc/target_fcntl.h
index 627d547289..d74ab710cf 100644
--- a/linux-user/ppc/target_fcntl.h
+++ b/linux-user/ppc/target_fcntl.h
@@ -7,5 +7,11 @@
 
 #ifndef PPC_TARGET_FCNTL_H
 #define PPC_TARGET_FCNTL_H
+
+#define TARGET_O_DIRECTORY      040000 /* must be a directory */
+#define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
+#define TARGET_O_LARGEFILE     0200000
+#define TARGET_O_DIRECT        0400000 /* direct disk access hint */
+
 #include "../generic/fcntl.h"
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 44a590d2c9..a434edadf8 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2426,12 +2426,7 @@ struct target_statfs64 {
 #define TARGET_F_GETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 8)
 #define TARGET_F_NOTIFY  (TARGET_F_LINUX_SPECIFIC_BASE+2)
 
-#if defined (TARGET_PPC)
-#define TARGET_O_DIRECTORY      040000 /* must be a directory */
-#define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
-#define TARGET_O_LARGEFILE     0200000
-#define TARGET_O_DIRECT        0400000 /* direct disk access hint */
-#elif defined (TARGET_SPARC)
+#if defined (TARGET_SPARC)
 #define TARGET_O_APPEND         0x0008
 #define TARGET_FASYNC           0x0040  /* fcntl, for BSD compatibility */
 #define TARGET_O_CREAT          0x0200  /* not fcntl */
-- 
2.14.3
