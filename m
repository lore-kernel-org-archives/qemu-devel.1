Received: from eggs.gnu.org ([2001:4830:134:3::10]:59226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQr-0000xS-2h
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQp-0002Dq-Ms
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:20 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQo-00021R-V2
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQi-0000Bj-8f
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:36 +0100
Message-Id: <20180816133438.17061-29-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 28/30] target/arm: Fix aa64 FCADD and FCMLA
 decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

These insns require u=1; failed to include that in the switch
cases.  This probably happened during one of the rebases just
before final commit.

Fixes: d17b7cdcf4e
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180810193129.1556-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b29dc49c4f8..8ca3876707c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11423,12 +11423,12 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = ARM_FEATURE_V8_DOTPROD;
         break;
-    case 0x8: /* FCMLA, #0 */
-    case 0x9: /* FCMLA, #90 */
-    case 0xa: /* FCMLA, #180 */
-    case 0xb: /* FCMLA, #270 */
-    case 0xc: /* FCADD, #90 */
-    case 0xe: /* FCADD, #270 */
+    case 0x18: /* FCMLA, #0 */
+    case 0x19: /* FCMLA, #90 */
+    case 0x1a: /* FCMLA, #180 */
+    case 0x1b: /* FCMLA, #270 */
+    case 0x1c: /* FCADD, #90 */
+    case 0x1e: /* FCADD, #270 */
         if (size == 0
             || (size == 1 && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))
             || (size == 3 && !is_q)) {
-- 
2.18.0
