Received: from eggs.gnu.org ([209.51.188.92]:55272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaPk-000323-6C
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaPf-0002SX-49
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:08:08 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:52 +0000
Message-Id: <20190215100058.20015-12-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 11/17] target/ppc: Remove vscr_nj and vscr_sat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

From: Richard Henderson <richard.henderson@linaro.org>

These macros are no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2c22292e7f..a62f628d28 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -688,8 +688,6 @@ enum {
 /* Vector status and control register */
 #define VSCR_NJ		16 /* Vector non-java */
 #define VSCR_SAT	0 /* Vector saturation */
-#define vscr_nj		(((env->vscr) >> VSCR_NJ)	& 0x1)
-#define vscr_sat	(((env->vscr) >> VSCR_SAT)	& 0x1)
 
 /*****************************************************************************/
 /* BookE e500 MMU registers */
-- 
2.11.0
