Received: from eggs.gnu.org ([2001:4830:134:3::10]:36236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f3JJr-0000oz-1y
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f3JJn-00043G-V1
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:37:39 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f3JJn-00041S-MH
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:37:35 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  3 Apr 2018 12:35:40 +0200
Message-Id: <20180403103540.7303-4-laurent@vivier.eu>
In-Reply-To: <20180403103540.7303-1-laurent@vivier.eu>
References: <20180403103540.7303-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/3] linux-user: fix TARGET___O_TMPFILE for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180402102453.9883-3-laurent@vivier.eu>
---
 linux-user/syscall_defs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7473be518b..23f5bccf0e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2565,6 +2565,7 @@ struct target_statfs64 {
 #define TARGET_O_CLOEXEC      0x400000
 #define TARGET___O_SYNC       0x800000
 #define TARGET_O_PATH        0x1000000
+#define TARGET___O_TMPFILE   0x2000000
 #endif
 
 /* <asm-generic/fcntl.h> values follow.  */
-- 
2.14.3
