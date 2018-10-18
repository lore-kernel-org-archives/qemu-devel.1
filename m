Received: from eggs.gnu.org ([2001:4830:134:3::10]:44361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDDMK-0000aW-Q7
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDDMD-0005cg-OD
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:20 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56676 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDDM6-00043n-Qy
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:11 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 18 Oct 2018 20:47:27 +0200
Message-Id: <1539888473-16340-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 02/28] elf: Fix PT_MIPS_XXX constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Fix existing and add missing PT_MIPS_XXX constants in elf.h.
This is copied from kernel header arch/mips/include/asm/elf.h.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 include/elf.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/elf.h b/include/elf.h
index 312f68a..decf210 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -28,8 +28,11 @@ typedef int64_t  Elf64_Sxword;
 #define PT_PHDR    6
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
-#define PT_MIPS_REGINFO		0x70000000
-#define PT_MIPS_OPTIONS		0x70000001
+
+#define PT_MIPS_REGINFO   0x70000000
+#define PT_MIPS_RTPROC    0x70000001
+#define PT_MIPS_OPTIONS   0x70000002
+#define PT_MIPS_ABIFLAGS  0x70000003
 
 /* Flags in the e_flags field of the header */
 /* MIPS architecture level. */
-- 
2.7.4
