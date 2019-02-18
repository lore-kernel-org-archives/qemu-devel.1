Received: from eggs.gnu.org ([209.51.188.92]:54268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gvkuq-00054o-Fo
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gvkuj-0001yx-DO
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:08 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43889 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gvkui-0001xL-W7
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:01 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 18 Feb 2019 16:31:36 +0100
Message-Id: <1550503897-31141-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 6/7] disas: nanoMIPS: Correct comments to
 handlers of some DSP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, peter.maydell@linaro.org, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Correct comments to handlers of some DSP instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 128 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 67 insertions(+), 61 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index f90f1a9..33fb045 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -10183,14 +10183,13 @@ std::string NMD::MFHGC0(uint64 instruction)
 
 
 /*
- *
+ * [DSP] MFHI rs, ac - Move from HI register
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000     xxxxx  00000001111111
  *     rt -----
- *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MFHI_DSP_(uint64 instruction)
 {
@@ -10231,14 +10230,13 @@ std::string NMD::MFHTR(uint64 instruction)
 
 
 /*
- *
+ * [DSP] MFLO rs, ac - Move from HI register
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000     xxxxx  01000001111111
  *     rt -----
- *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MFLO_DSP_(uint64 instruction)
 {
@@ -10399,7 +10397,7 @@ std::string NMD::MOD(uint64 instruction)
 
 
 /*
- *
+ * [DSP] MODSUB rd, rs, rt - Modular subtraction on an index value
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -10427,7 +10425,7 @@ std::string NMD::MODSUB(uint64 instruction)
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000               x1010010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -10639,14 +10637,14 @@ std::string NMD::MOVZ(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MSUB ac, rs, rt - Multiply word and subtract from accumulator
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000            10101010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MSUB_DSP_(uint64 instruction)
 {
@@ -10711,14 +10709,13 @@ std::string NMD::MSUBF_S(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
- *
+ * [DSP] MSUBU ac, rs, rt - Multiply word and add to
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000            11101010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MSUBU_DSP_(uint64 instruction)
 {
@@ -10919,14 +10916,13 @@ std::string NMD::MTHGC0(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MTHI rs, ac - Move to HI register
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
- *     rt -----
+ *  001000xxxxx       10000001111111
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MTHI_DSP_(uint64 instruction)
 {
@@ -10941,14 +10937,13 @@ std::string NMD::MTHI_DSP_(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MTHLIP rs, ac - Copy LO to HI and a GPR to LO and increment pos by 32
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
- *     rt -----
+ *  001000xxxxx       00001001111111
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MTHLIP(uint64 instruction)
 {
@@ -10989,14 +10984,13 @@ std::string NMD::MTHTR(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MTLO rs, ac - Move to LO register
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
- *     rt -----
+ *  001000xxxxx       11000001111111
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MTLO_DSP_(uint64 instruction)
 {
@@ -11155,11 +11149,12 @@ std::string NMD::MUL_D(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MUL.PH rd, rs, rt - Multiply vector integer half words to same size
+ *   products
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               00000101101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -11179,11 +11174,12 @@ std::string NMD::MUL_PH(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MUL_S.PH rd, rs, rt - Multiply vector integer half words to same size
+ *   products (saturated)
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               10000101101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -11227,11 +11223,12 @@ std::string NMD::MUL_S(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULEQ_S.W.PHL rd, rs, rt - Multiply vector fractional left halfwords
+ *   to expanded width products
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               x0000100101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -11251,11 +11248,12 @@ std::string NMD::MULEQ_S_W_PHL(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULEQ_S.W.PHR rd, rs, rt - Multiply vector fractional right halfwords
+ *   to expanded width products
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               x0001100101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -11275,11 +11273,12 @@ std::string NMD::MULEQ_S_W_PHR(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULEU_S.PH.QBL rd, rs, rt - Multiply vector fractional left bytes
+ *   by halfwords to halfword products
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               x0010010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -11299,11 +11298,12 @@ std::string NMD::MULEU_S_PH_QBL(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULEU_S.PH.QBR rd, rs, rt - Multiply vector fractional right bytes
+ *   by halfwords to halfword products
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               x0011010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -11323,11 +11323,12 @@ std::string NMD::MULEU_S_PH_QBR(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULQ_RS.PH rd, rs, rt - Multiply vector fractional halfwords
+ *   to fractional halfword products
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               x0100010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -11347,11 +11348,12 @@ std::string NMD::MULQ_RS_PH(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULQ_RS.W rd, rs, rt - Multiply fractional words to same size
+ *   product with saturation and rounding
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               x0110010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -11371,11 +11373,12 @@ std::string NMD::MULQ_RS_W(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULQ_S.PH rd, rs, rt - Multiply fractional halfwords to same size
+ *   products
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               x0101010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -11395,11 +11398,12 @@ std::string NMD::MULQ_S_PH(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULQ_S.W rd, rs, rt - Multiply fractional words to same size product
+ *   with saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               x0111010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -11419,14 +11423,15 @@ std::string NMD::MULQ_S_W(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULSA.W.PH ac, rs, rt - Multiply and subtract vector integer halfword
+ *   elements and accumulate
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000            10110010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MULSA_W_PH(uint64 instruction)
 {
@@ -11443,14 +11448,15 @@ std::string NMD::MULSA_W_PH(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULSAQ_S.W.PH ac, rs, rt - Multiply and subtract vector fractional
+ *   halfwords and accumulate
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000            11110010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MULSAQ_S_W_PH(uint64 instruction)
 {
@@ -11467,14 +11473,14 @@ std::string NMD::MULSAQ_S_W_PH(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULT ac, rs, rt - Multiply word
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000            00110010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MULT_DSP_(uint64 instruction)
 {
@@ -11491,14 +11497,14 @@ std::string NMD::MULT_DSP_(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MULTU ac, rs, rt - Multiply unsigned word
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000            01110010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::MULTU_DSP_(uint64 instruction)
 {
-- 
2.7.4
