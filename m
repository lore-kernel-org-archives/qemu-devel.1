Received: from eggs.gnu.org ([2001:4830:134:3::10]:47803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g8Rv7-0008GG-CN
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g8Rv6-0006R4-Kd
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:21:37 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41565 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1g8Rv6-0005n7-Ca
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:21:36 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  5 Oct 2018 17:19:48 +0200
Message-Id: <1538752793-6875-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1538752793-6875-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1538752793-6875-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 2/7] elf: Add MIPS_ABI_FP_XXX constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Stefan Markovic <smarkovic@wavecomp.com>

Add MIPS_ABI_FP_XXX constants to elf.h. The source of information
is kernel header arch/mips/include/asm/elf.h.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 include/elf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index decf210..eb5958d 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -87,6 +87,14 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_MACH_LS3A     0x00a20000  /* ST Microelectronics Loongson 3A */
 #define EF_MIPS_MACH          0x00ff0000  /* EF_MIPS_MACH_xxx selection mask */
 
+#define MIPS_ABI_FP_ANY       0x0         /* FP ABI doesn't matter           */
+#define MIPS_ABI_FP_DOUBLE    0x1         /* -mdouble-float                  */
+#define MIPS_ABI_FP_SINGLE    0x2         /* -msingle-float                  */
+#define MIPS_ABI_FP_SOFT      0x3         /* -msoft-float                    */
+#define MIPS_ABI_FP_OLD_64    0x4         /* -mips32r2 -mfp64                */
+#define MIPS_ABI_FP_XX        0x5         /* -mfpxx                          */
+#define MIPS_ABI_FP_64        0x6         /* -mips32r2 -mfp64                */
+#define MIPS_ABI_FP_64A       0x7         /* -mips32r2 -mfp64 -mno-odd-spreg */
 
 /* These constants define the different elf file types */
 #define ET_NONE   0
-- 
2.7.4
