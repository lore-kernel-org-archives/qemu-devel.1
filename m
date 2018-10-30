Received: from eggs.gnu.org ([2001:4830:134:3::10]:49994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHXp0-0001CM-G0
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHXot-0002nr-GM
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:28:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44243 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gHXot-0002iJ-2P
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:28:47 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 30 Oct 2018 18:28:17 +0100
Message-Id: <1540920498-5133-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540920498-5133-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540920498-5133-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 4/5] target/mips: Remove some spurious
 R5900-related comments
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

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove some spurious R5900-related comments. Very similar comments
are in the vicinity of the area in question, and in file translate.c.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate_init.inc.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index 85da4a2..cab2003 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -411,18 +411,6 @@ const mips_def_t mips_defs[] =
         .mmu_type = MMU_TYPE_R4000,
     },
     {
-        /*
-         * The Toshiba TX System RISC TX79 Core Architecture manual
-         *
-         * https://wiki.qemu.org/File:C790.pdf
-         *
-         * describes the C790 processor that is a follow-up to the R5900.
-         * There are a few notable differences in that the R5900 FPU
-         *
-         * - is not IEEE 754-1985 compliant,
-         * - does not implement double format, and
-         * - its machine code is nonstandard.
-         */
         .name = "R5900",
         .CP0_PRid = 0x00002E00,
         /* No L2 cache, icache size 32k, dcache size 32k, uncached coherency. */
-- 
2.7.4
