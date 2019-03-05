Received: from eggs.gnu.org ([209.51.188.92]:47010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1ESk-0001Al-8s
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1ESg-00027F-Le
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:46 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49596 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1ESg-00019L-4p
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:42 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue,  5 Mar 2019 19:05:13 +0100
Message-Id: <1551809127-3658-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 01/15] disas: nanoMIPS: Correct comments to
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Correct comments to handlers of some DSP instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1551800076-8104-2-git-send-email-aleksandar.markovic@rt-rk.com>
---
 disas/nanomips.cpp | 434 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 230 insertions(+), 204 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index f090f61..1491379 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -3452,14 +3452,14 @@ std::string NMD::BNEZC_16_(uint64 instruction)
 
 
 /*
- *
+ * [DSP] BPOSGE32C offset - Branch on greater than or equal to value 32 in
+ *   DSPControl Pos field
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
- *     rt -----
- *          rs -----
- *               rd -----
+ *  100010xxxxx0010001
+ *            s[13:1] -------------
+ *                           s[14] -
  */
 std::string NMD::BPOSGE32C(uint64 instruction)
 {
@@ -3872,14 +3872,13 @@ std::string NMD::CMP_EQ_D(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMP.EQ.PH rs, rt - Compare vectors of signed integer halfword values
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000          xxxxxx0000000101
  *     rt -----
  *          rs -----
- *               rd -----
  */
 std::string NMD::CMP_EQ_PH(uint64 instruction)
 {
@@ -3942,14 +3941,13 @@ std::string NMD::CMP_LE_D(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMP.LE.PH rs, rt - Compare vectors of signed integer halfword values
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000          xxxxxx0010000101
  *     rt -----
  *          rs -----
- *               rd -----
  */
 std::string NMD::CMP_LE_PH(uint64 instruction)
 {
@@ -4012,14 +4010,13 @@ std::string NMD::CMP_LT_D(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMP.LT.PH rs, rt - Compare vectors of signed integer halfword values
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000          xxxxxx0001000101
  *     rt -----
  *          rs -----
- *               rd -----
  */
 std::string NMD::CMP_LT_PH(uint64 instruction)
 {
@@ -4922,11 +4919,12 @@ std::string NMD::CMP_UN_S(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMPGDU.EQ.QB rd, rs, rt - Compare unsigned vector of
+ *   four bytes and write result to GPR and DSPControl
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000               x0110000101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -4946,11 +4944,12 @@ std::string NMD::CMPGDU_EQ_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMPGDU.LE.QB rd, rs, rt - Compare unsigned vector of
+ *   four bytes and write result to GPR and DSPControl
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000               x1000000101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -4970,11 +4969,12 @@ std::string NMD::CMPGDU_LE_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMPGDU.EQ.QB rd, rs, rt - Compare unsigned vector of
+ *   four bytes and write result to GPR and DSPControl
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000               x0111000101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -4994,11 +4994,12 @@ std::string NMD::CMPGDU_LT_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMPGU.EQ.QB rd, rs, rt - Compare vectors of unsigned
+ *   byte values and write result to a GPR
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000               x0011000101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -5018,11 +5019,12 @@ std::string NMD::CMPGU_EQ_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMPGU.LE.QB rd, rs, rt - Compare vectors of unsigned
+ *   byte values and write result to a GPR
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000               x0101000101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -5042,11 +5044,12 @@ std::string NMD::CMPGU_LE_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMPGU.LT.QB rd, rs, rt - Compare vectors of unsigned
+ *   byte values and write result to a GPR
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000               x0100000101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -5066,14 +5069,14 @@ std::string NMD::CMPGU_LT_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMPU.EQ.QB rd, rs, rt - Compare vectors of unsigned
+ *   byte values
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000          xxxxxx1001000101
  *     rt -----
  *          rs -----
- *               rd -----
  */
 std::string NMD::CMPU_EQ_QB(uint64 instruction)
 {
@@ -5088,14 +5091,14 @@ std::string NMD::CMPU_EQ_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMPU.LE.QB rd, rs, rt - Compare vectors of unsigned
+ *   byte values
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000          xxxxxx1011000101
  *     rt -----
  *          rs -----
- *               rd -----
  */
 std::string NMD::CMPU_LE_QB(uint64 instruction)
 {
@@ -5110,14 +5113,14 @@ std::string NMD::CMPU_LE_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] CMPU.LT.QB rd, rs, rt - Compare vectors of unsigned
+ *   byte values
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000          xxxxxx1010000101
  *     rt -----
  *          rs -----
- *               rd -----
  */
 std::string NMD::CMPU_LT_QB(uint64 instruction)
 {
@@ -6362,14 +6365,15 @@ std::string NMD::DMULU(uint64 instruction)
 
 
 /*
- *
+ * [DSP] DPA.W.PH ac, rs, rt - Dot product with accumulate on
+ *   vector integer halfword elements
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000            00000010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::DPA_W_PH(uint64 instruction)
 {
@@ -7456,14 +7460,15 @@ std::string NMD::EXTPV(uint64 instruction)
 
 
 /*
- *
+ * [DSP] EXTR_RS.W rt, ac, shift - Extract word value from accumulator to GPR
+ *   with right shift
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000            10111001111111
  *     rt -----
- *          rs -----
- *               rd -----
+ *       shift -----
+ *               ac --
  */
 std::string NMD::EXTR_RS_W(uint64 instruction)
 {
@@ -7480,14 +7485,15 @@ std::string NMD::EXTR_RS_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] EXTR_R.W rt, ac, shift - Extract word value from accumulator to GPR
+ *   with right shift
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000            01111001111111
  *     rt -----
- *          rs -----
- *               rd -----
+ *       shift -----
+ *               ac --
  */
 std::string NMD::EXTR_R_W(uint64 instruction)
 {
@@ -7504,14 +7510,15 @@ std::string NMD::EXTR_R_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] EXTR_S.H rt, ac, shift - Extract halfword value from accumulator
+ *   to GPR with right shift and saturate
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000            11111001111111
  *     rt -----
- *          rs -----
- *               rd -----
+ *       shift -----
+ *               ac --
  */
 std::string NMD::EXTR_S_H(uint64 instruction)
 {
@@ -7528,14 +7535,15 @@ std::string NMD::EXTR_S_H(uint64 instruction)
 
 
 /*
- *
+ * [DSP] EXTR.W rt, ac, shift - Extract word value from accumulator to GPR
+ *   with right shift
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000            00111001111111
  *     rt -----
- *          rs -----
- *               rd -----
+ *       shift -----
+ *               ac --
  */
 std::string NMD::EXTR_W(uint64 instruction)
 {
@@ -7552,14 +7560,15 @@ std::string NMD::EXTR_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] EXTRV_RS.W rt, ac, rs - Extract word value with variable
+ *   right shift from accumulator to GPR
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000            10111010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::EXTRV_RS_W(uint64 instruction)
 {
@@ -7576,14 +7585,15 @@ std::string NMD::EXTRV_RS_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] EXTRV_R.W rt, ac, rs - Extract word value with variable
+ *   right shift from accumulator to GPR
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000            01111010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::EXTRV_R_W(uint64 instruction)
 {
@@ -7600,14 +7610,15 @@ std::string NMD::EXTRV_R_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] EXTRV_S.H rt, ac, rs - Extract halfword value variable from
+ *   accumulator to GPR with right shift and saturate
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000            11111010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::EXTRV_S_H(uint64 instruction)
 {
@@ -7624,14 +7635,15 @@ std::string NMD::EXTRV_S_H(uint64 instruction)
 
 
 /*
- *
+ * [DSP] EXTRV.W rt, ac, rs - Extract word value with variable
+ *   right shift from accumulator to GPR
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000            00111010111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               ac --
  */
 std::string NMD::EXTRV_W(uint64 instruction)
 {
@@ -7855,14 +7867,13 @@ std::string NMD::INS(uint64 instruction)
 
 
 /*
- * [DSP] INSV - Insert bit field variable
+ * [DSP] INSV rt, rs - Insert bit field variable
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000          0100000100111111
  *     rt -----
  *          rs -----
- *               rd -----
  */
 std::string NMD::INSV(uint64 instruction)
 {
@@ -10183,14 +10194,13 @@ std::string NMD::MFHGC0(uint64 instruction)
 
 
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
@@ -10231,14 +10241,13 @@ std::string NMD::MFHTR(uint64 instruction)
 
 
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
@@ -10399,7 +10408,7 @@ std::string NMD::MOD(uint64 instruction)
 
 
 /*
- *
+ * [DSP] MODSUB rd, rs, rt - Modular subtraction on an index value
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -10427,7 +10436,7 @@ std::string NMD::MODSUB(uint64 instruction)
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000               x1010010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -10639,14 +10648,14 @@ std::string NMD::MOVZ(uint64 instruction)
 
 
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
@@ -10711,14 +10720,14 @@ std::string NMD::MSUBF_S(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] MSUBU ac, rs, rt - Multiply word and add to accumulator
  *
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
@@ -10919,14 +10928,13 @@ std::string NMD::MTHGC0(uint64 instruction)
 
 
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
@@ -10941,14 +10949,13 @@ std::string NMD::MTHI_DSP_(uint64 instruction)
 
 
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
@@ -10989,14 +10996,13 @@ std::string NMD::MTHTR(uint64 instruction)
 
 
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
@@ -11155,11 +11161,12 @@ std::string NMD::MUL_D(uint64 instruction)
 
 
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
@@ -11179,11 +11186,12 @@ std::string NMD::MUL_PH(uint64 instruction)
 
 
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
@@ -11227,11 +11235,12 @@ std::string NMD::MUL_S(uint64 instruction)
 
 
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
@@ -11251,11 +11260,12 @@ std::string NMD::MULEQ_S_W_PHL(uint64 instruction)
 
 
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
@@ -11275,11 +11285,12 @@ std::string NMD::MULEQ_S_W_PHR(uint64 instruction)
 
 
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
@@ -11299,11 +11310,12 @@ std::string NMD::MULEU_S_PH_QBL(uint64 instruction)
 
 
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
@@ -11323,11 +11335,12 @@ std::string NMD::MULEU_S_PH_QBR(uint64 instruction)
 
 
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
@@ -11347,11 +11360,12 @@ std::string NMD::MULQ_RS_PH(uint64 instruction)
 
 
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
@@ -11371,11 +11385,12 @@ std::string NMD::MULQ_RS_W(uint64 instruction)
 
 
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
@@ -11395,11 +11410,12 @@ std::string NMD::MULQ_S_PH(uint64 instruction)
 
 
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
@@ -11419,14 +11435,15 @@ std::string NMD::MULQ_S_W(uint64 instruction)
 
 
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
@@ -11443,14 +11460,15 @@ std::string NMD::MULSA_W_PH(uint64 instruction)
 
 
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
@@ -11467,14 +11485,14 @@ std::string NMD::MULSAQ_S_W_PH(uint64 instruction)
 
 
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
@@ -11491,14 +11509,14 @@ std::string NMD::MULT_DSP_(uint64 instruction)
 
 
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
@@ -12060,11 +12078,12 @@ std::string NMD::PRECEU_PH_QBR(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECR.QB.PH rd, rs, rt - Reduce the precision of four integer
+ *   halfwords to four bytes
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               00010001101
+ *  001000               x0001101101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -12084,7 +12103,8 @@ std::string NMD::PRECR_QB_PH(uint64 instruction)
 
 
 /*
- *
+ * [DSP] PRECR_SRA.PH.W rt, rs, sa - Reduce the precision of two integer
+ *   words to halfwords after a right shift
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -12108,7 +12128,8 @@ std::string NMD::PRECR_SRA_PH_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] PRECR_SRA_R.PH.W rt, rs, sa - Reduce the precision of two integer
+ *   words to halfwords after a right shift with rounding
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -12132,7 +12153,8 @@ std::string NMD::PRECR_SRA_R_PH_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] PRECRQ.PH.W rd, rs, rt - Reduce the precision of fractional
+ *   words to fractional halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -12156,11 +12178,12 @@ std::string NMD::PRECRQ_PH_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] PRECRQ.QB.PH rd, rs, rt - Reduce the precision of four fractional
+ *   halfwords to four bytes
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000               x0010101101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -12180,7 +12203,8 @@ std::string NMD::PRECRQ_QB_PH(uint64 instruction)
 
 
 /*
- *
+ * [DSP] PRECRQ_RS.PH.W rd, rs, rt - Reduce the precision of fractional
+ *   words to halfwords with rounding and saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -12204,7 +12228,8 @@ std::string NMD::PRECRQ_RS_PH_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] PRECRQU_S.QB.PH rd, rs, rt - Reduce the precision of fractional
+ *   halfwords to unsigned bytes with saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -12300,7 +12325,7 @@ std::string NMD::PREFE(uint64 instruction)
 
 
 /*
- *
+ * [DSP] PREPEND rt, rs, sa - Right shift and prepend bits to the MSB
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -12324,14 +12349,13 @@ std::string NMD::PREPEND(uint64 instruction)
 
 
 /*
- *
+ * [DSP] RADDU.W.QB rt, rs - Unsigned reduction add of vector quad bytes
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000          1111000100111111
  *     rt -----
  *          rs -----
- *               rd -----
  */
 std::string NMD::RADDU_W_QB(uint64 instruction)
 {
@@ -12346,14 +12370,13 @@ std::string NMD::RADDU_W_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] RDDSP rt, mask - Read DSPControl register fields to a GPR
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000            00011001111111
  *     rt -----
- *          rs -----
- *               rd -----
+ *        mask -------
  */
 std::string NMD::RDDSP(uint64 instruction)
 {
@@ -12458,14 +12481,14 @@ std::string NMD::RECIP_S(uint64 instruction)
 
 
 /*
- *
+ * [DSP] REPL.PH rd, s - Replicate immediate integer into all vector element
+ *   positions
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000               x0000111101
  *     rt -----
- *          rs -----
- *               rd -----
+ *           s ----------
  */
 std::string NMD::REPL_PH(uint64 instruction)
 {
@@ -12480,14 +12503,14 @@ std::string NMD::REPL_PH(uint64 instruction)
 
 
 /*
- *
+ * [DSP] REPL.QB rd, u - Replicate immediate integer into all vector element
+ *   positions
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000             x010111111111
  *     rt -----
- *          rs -----
- *               rd -----
+ *           u --------
  */
 std::string NMD::REPL_QB(uint64 instruction)
 {
@@ -12502,14 +12525,14 @@ std::string NMD::REPL_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] REPLV.PH rt, rs - Replicate a halfword into all vector element
+ *   positions
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000          0000001100111111
  *     rt -----
  *          rs -----
- *               rd -----
  */
 std::string NMD::REPLV_PH(uint64 instruction)
 {
@@ -12524,14 +12547,13 @@ std::string NMD::REPLV_PH(uint64 instruction)
 
 
 /*
- *
+ * [DSP] REPLV.QB rt, rs - Replicate byte into all vector element positions
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               x1110000101
+ *  001000          0001001100111111
  *     rt -----
  *          rs -----
- *               rd -----
  */
 std::string NMD::REPLV_QB(uint64 instruction)
 {
@@ -13920,8 +13942,8 @@ std::string NMD::SHE(uint64 instruction)
 
 
 /*
- * SHILO ac, shift - Shift an Accumulator Value Leaving the Result in the Same
- *                     Accumulator
+ * [DSP] SHILO ac, shift - Shift an accumulator value leaving the result in
+ *   the same accumulator
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -13942,8 +13964,8 @@ std::string NMD::SHILO(uint64 instruction)
 
 
 /*
- * SHILOV ac, rs - Variable Shift of Accumulator Value Leaving the Result in
- *                   the Same Accumulator
+ * [DSP] SHILOV ac, rs - Variable shift of accumulator value leaving the result
+ *   in the same accumulator
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -13964,7 +13986,7 @@ std::string NMD::SHILOV(uint64 instruction)
 
 
 /*
- * SHLL.PH rt, rs, sa - Shift Left Logical Vector Pair Halfwords
+ * [DSP] SHLL.PH rt, rs, sa - Shift left logical vector pair halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -13988,7 +14010,7 @@ std::string NMD::SHLL_PH(uint64 instruction)
 
 
 /*
- * SHLL.QB rt, rs, sa - Shift Left Logical Vector Quad Bytes
+ * [DSP] SHLL.QB rt, rs, sa - Shift left logical vector quad bytes
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -14012,7 +14034,8 @@ std::string NMD::SHLL_QB(uint64 instruction)
 
 
 /*
- * SHLL_S.PH rt, rs, sa - Shift Left Logical Vector Pair Halfwords (saturated)
+ * [DSP] SHLL_S.PH rt, rs, sa - Shift left logical vector pair halfwords
+ *   with saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -14036,14 +14059,14 @@ std::string NMD::SHLL_S_PH(uint64 instruction)
 
 
 /*
- *
+ * [DSP] SHLL_S.PH rt, rs, sa - Shift left logical word with saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               01001001101
+ *  001000               x1111110101
  *     rt -----
  *          rs -----
- *               rd -----
+ *               sa -----
  */
 std::string NMD::SHLL_S_W(uint64 instruction)
 {
@@ -14060,11 +14083,12 @@ std::string NMD::SHLL_S_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] SHLLV.PH rd, rt, rs - Shift left logical variable vector pair
+ *   halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               01001001101
+ *  001000               01110001101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -14084,11 +14108,11 @@ std::string NMD::SHLLV_PH(uint64 instruction)
 
 
 /*
- *
+ * [DSP] SHLLV_S.QB rd, rt, rs - Shift left logical variable vector quad bytes
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               01001001101
+ *  001000               x1110010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -14108,11 +14132,12 @@ std::string NMD::SHLLV_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] SHLLV.PH rd, rt, rs - Shift left logical variable vector pair
+ *   halfwords with saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               01001001101
+ *  001000               11110001101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -14132,11 +14157,11 @@ std::string NMD::SHLLV_S_PH(uint64 instruction)
 
 
 /*
- *
+ * [DSP] SHLLV_S.W rd, rt, rs - Shift left logical variable vector word
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               01001001101
+ *  001000               x1111010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -14396,14 +14421,14 @@ std::string NMD::SHRAV_R_W(uint64 instruction)
 
 
 /*
- *
+ * [DSP] SHRL.PH rt, rs, sa - Shift right logical two halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               01001001101
+ *  001000              001111111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               sa ----
  */
 std::string NMD::SHRL_PH(uint64 instruction)
 {
@@ -14420,14 +14445,14 @@ std::string NMD::SHRL_PH(uint64 instruction)
 
 
 /*
- *
+ * [DSP] SHRL.QB rt, rs, sa - Shift right logical vector quad bytes
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               01001001101
+ *  001000             1100001111111
  *     rt -----
  *          rs -----
- *               rd -----
+ *               sa ---
  */
 std::string NMD::SHRL_QB(uint64 instruction)
 {
@@ -14444,11 +14469,12 @@ std::string NMD::SHRL_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] SHLLV.PH rd, rt, rs - Shift right logical variable vector pair of
+ *   halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               01001001101
+ *  001000               x1100010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -14468,11 +14494,11 @@ std::string NMD::SHRLV_PH(uint64 instruction)
 
 
 /*
- *
+ * [DSP] SHLLV.QB rd, rt, rs - Shift right logical variable vector quad bytes
  *
  *   3         2         1
  *  10987654321098765432109876543210
- *  001000               01001001101
+ *  001000               x1101010101
  *     rt -----
  *          rs -----
  *               rd -----
@@ -15032,8 +15058,8 @@ std::string NMD::SUBQ_PH(uint64 instruction)
 
 
 /*
- * SUBQH.PH rd, rt, rs - Subtract Fractional Halfword Vectors And Shift Right
- *                         to Halve Results
+ * [DSP] SUBQ.S.PH rd, rt, rs - Subtract fractional halfword vectors and shift
+ *   right to halve results
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15057,8 +15083,8 @@ std::string NMD::SUBQ_S_PH(uint64 instruction)
 
 
 /*
- * SUBQH.PH rd, rt, rs - Subtract Fractional Halfword Vectors And Shift Right
- *                         to Halve Results
+ * [DSP] SUBQ.S.W rd, rt, rs - Subtract fractional halfword vectors and shift
+ *   right to halve results
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15082,8 +15108,8 @@ std::string NMD::SUBQ_S_W(uint64 instruction)
 
 
 /*
- * SUBQH.PH rd, rt, rs - Subtract Fractional Halfword Vectors And Shift Right
- *                         to Halve Results
+ * [DSP] SUBQH.PH rd, rt, rs - Subtract fractional halfword vectors and shift
+ *   right to halve results
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15107,8 +15133,8 @@ std::string NMD::SUBQH_PH(uint64 instruction)
 
 
 /*
- * SUBQH.PH rd, rt, rs - Subtract Fractional Halfword Vectors And Shift Right
- *                         to Halve Results
+ * [DSP] SUBQH_R.PH rd, rt, rs - Subtract fractional halfword vectors and shift
+ *   right to halve results
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15132,8 +15158,8 @@ std::string NMD::SUBQH_R_PH(uint64 instruction)
 
 
 /*
- * SUBQH_R.PH rd, rt, rs - Subtract Fractional Halfword Vectors And Shift Right
- *                           to Halve Results (rounding)
+ * [DSP] SUBQH_R.W rd, rt, rs - Subtract fractional halfword vectors and shift
+ *   right to halve results with rounding
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15157,8 +15183,8 @@ std::string NMD::SUBQH_R_W(uint64 instruction)
 
 
 /*
- * SUBQH.W rd, rs, rt - Subtract Fractional Words And Shift Right to Halve
- *                        Results
+ * [DSP] SUBQH.W rd, rs, rt - Subtract fractional words and shift right to
+ *   halve results
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15279,7 +15305,7 @@ std::string NMD::SUBU_QB(uint64 instruction)
 
 /*
  * [DSP] SUBU_S.PH rd, rs, rt - Subtract unsigned unsigned halfwords with
- *         8-bit saturation
+ *   8-bit saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15304,7 +15330,7 @@ std::string NMD::SUBU_S_PH(uint64 instruction)
 
 /*
  * [DSP] SUBU_S.QB rd, rs, rt - Subtract unsigned quad byte vectors with
- *         8-bit saturation
+ *   8-bit saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15329,7 +15355,7 @@ std::string NMD::SUBU_S_QB(uint64 instruction)
 
 /*
  * [DSP] SUBUH.QB rd, rs, rt - Subtract unsigned bytes and right shift
- *         to halve results
+ *   to halve results
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15354,7 +15380,7 @@ std::string NMD::SUBUH_QB(uint64 instruction)
 
 /*
  * [DSP] SUBUH_R.QB rd, rs, rt - Subtract unsigned bytes and right shift
- *         to halve results with rounding
+ *   to halve results with rounding
  *
  *   3         2         1
  *  10987654321098765432109876543210
-- 
2.7.4
