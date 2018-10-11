Received: from eggs.gnu.org ([2001:4830:134:3::10]:53291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ6S-0007Fh-AL
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ6N-0008FK-Eu
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:26:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60982 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gAZ6N-0008EM-4W
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:25:59 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 11 Oct 2018 13:22:25 +0200
Message-Id: <1539256947-22807-21-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 20/22] target/mips: Add DEC feature to
 mips32r6-generic CPU
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

Set Config5.DEC Dual Endian Capability bit of mips32r6-generic CPU.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate_init.inc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index b94a09e..e390205 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -428,7 +428,8 @@ const mips_def_t mips_defs[] =
                        (1 << CP0C3_RXI) | (1U << CP0C3_M),
         .CP0_Config4 = MIPS_CONFIG4 | (0xfc << CP0C4_KScrExist) |
                        (3 << CP0C4_IE) | (1U << CP0C4_M),
-        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_LLB),
+        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_DEC) |
+                       (1 << CP0C5_LLB),
         .CP0_Config5_rw_bitmask = (1 << CP0C5_SBRI) | (1 << CP0C5_FRE) |
                                   (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask = 0,
-- 
2.7.4
