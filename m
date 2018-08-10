Received: from eggs.gnu.org ([2001:4830:134:3::10]:59115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8P-0002SZ-1q
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8O-0005eh-9D
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foD8O-0005dy-2U
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:40 -0400
Received: by mail-pf1-x441.google.com with SMTP id x17-v6so4974310pfh.5
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:31:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 10 Aug 2018 12:31:28 -0700
Message-Id: <20180810193129.1556-6-richard.henderson@linaro.org>
In-Reply-To: <20180810193129.1556-1-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/6] target/arm: Fix aa64 FCADD and FCMLA decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

These insns require u=1; failed to include that in the switch
cases.  This probably happened during one of the rebases just
before final commit.

Fixes: d17b7cdcf4e
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4a0ca8c906..8a24278d79 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11427,12 +11427,12 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
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
2.17.1
