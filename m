Received: from eggs.gnu.org ([2001:4830:134:3::10]:53290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ6S-0007Fg-AC
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ6N-0008FQ-IT
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:26:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60989 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gAZ6N-0008Eh-8I
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:25:59 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 11 Oct 2018 13:22:26 +0200
Message-Id: <1539256947-22807-22-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 21/22] target/mips: Add MSA ASE to
 MIPS64R2-generic CPU
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

From: Yongbok Kim <yongbok.kim@mips.com>

Add MSA ASE to MIPS64R2-generic CPU.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate_init.inc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index e390205..e05bd6f 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -620,7 +620,10 @@ const mips_def_t mips_defs[] =
                        (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
         .CP0_Config2 = MIPS_CONFIG2,
-        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA),
+        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA) | (1 << CP0C3_MSAP),
+        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M),
+        .CP0_Config4_rw_bitmask = 0,
+        .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn),
         .CP0_LLAddr_rw_bitmask = 0,
         .CP0_LLAddr_shift = 0,
         .SYNCI_Step = 32,
@@ -634,7 +637,7 @@ const mips_def_t mips_defs[] =
         .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 36,
-        .insn_flags = CPU_MIPS64R2 | ASE_MIPS3D,
+        .insn_flags = CPU_MIPS64R2 | ASE_MIPS3D | ASE_MSA,
         .mmu_type = MMU_TYPE_R4000,
     },
     {
-- 
2.7.4
