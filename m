Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fII4Z-0005E2-Ic
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fII4V-0005Dn-Vq
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:19:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fII4V-0005BW-Lu
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:19:43 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 14 May 2018 20:19:22 +0200
Message-Id: <20180514181928.18034-2-laurent@vivier.eu>
In-Reply-To: <20180514181928.18034-1-laurent@vivier.eu>
References: <20180514181928.18034-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/7] linux-user: define correct fcntl() values
 for sparc
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
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20180509231123.20864-2-laurent@vivier.eu>
---
 linux-user/syscall_defs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 361bb83a29..ec3f561685 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2441,6 +2441,15 @@ struct target_statfs64 {
 #define TARGET_F_SETLKW        7
 #define TARGET_F_GETOWN        11       /*  for sockets. */
 #define TARGET_F_SETOWN        12       /*  for sockets. */
+#elif defined(TARGET_SPARC)
+#define TARGET_F_RDLCK         1
+#define TARGET_F_WRLCK         2
+#define TARGET_F_UNLCK         3
+#define TARGET_F_GETOWN        5       /*  for sockets. */
+#define TARGET_F_SETOWN        6       /*  for sockets. */
+#define TARGET_F_GETLK         7
+#define TARGET_F_SETLK         8
+#define TARGET_F_SETLKW        9
 #else
 #define TARGET_F_GETLK         5
 #define TARGET_F_SETLK         6
-- 
2.14.3
