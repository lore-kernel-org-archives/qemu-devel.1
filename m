Received: from eggs.gnu.org ([2001:4830:134:3::10]:48523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxQ-0002WH-0m
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxM-0002Kh-Ow
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:51 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:61189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceMxM-0002KS-ES
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:48 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:22:22 +0100
Message-Id: <20170216142227.27448-10-laurent@vivier.eu>
In-Reply-To: <20170216142227.27448-1-laurent@vivier.eu>
References: <20170216142227.27448-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 09/14] linux-user: Update m68k syscall
 definitions to match Linux 4.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>

From: Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20170116224915.19430-2-glaubitz@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/m68k/syscall_nr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/m68k/syscall_nr.h b/linux-user/m68k/syscall_nr.h
index 4b50fb2..d239551 100644
--- a/linux-user/m68k/syscall_nr.h
+++ b/linux-user/m68k/syscall_nr.h
@@ -376,3 +376,6 @@
 #define TARGET_NR_userfaultfd           373
 #define TARGET_NR_membarrier            374
 #define TARGET_NR_mlock2                375
+#define TARGET_NR_copy_file_range       376
+#define TARGET_NR_preadv2               377
+#define TARGET_NR_pwritev2              378
-- 
2.9.3
