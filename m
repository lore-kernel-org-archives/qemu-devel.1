Received: from eggs.gnu.org ([2001:4830:134:3::10]:37616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gH81z-0003DC-Dw
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gH81u-000397-Oo
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:32 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43669 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1gH81k-0002GS-0E
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:22 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 14:55:10 +0100
Message-Id: <1540821315-28346-2-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540821315-28346-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1540821315-28346-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 1/6] Define MIPS_ABI_FP_UNKNOWN macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, laurent@vivier.eu

From: Stefan Markovic <smarkovic@wavecomp.com>

Add MIPS_ABI_FP_UNKNOWN as QEMU internal value to represent
unknown fp_abi (based on kernel mips/include/asm/elf.h definition)

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 include/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index 5f45f9b..c151164 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -87,6 +87,8 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_MACH_LS3A     0x00a20000  /* ST Microelectronics Loongson 3A */
 #define EF_MIPS_MACH          0x00ff0000  /* EF_MIPS_MACH_xxx selection mask */
 
+#define MIPS_ABI_FP_UNKNOWN   (-1)        /* Unknown FP ABI (internal)       */
+
 #define MIPS_ABI_FP_ANY       0x0         /* FP ABI doesn't matter           */
 #define MIPS_ABI_FP_DOUBLE    0x1         /* -mdouble-float                  */
 #define MIPS_ABI_FP_SINGLE    0x2         /* -msingle-float                  */
-- 
1.9.1
