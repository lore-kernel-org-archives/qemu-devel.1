Received: from eggs.gnu.org ([209.51.188.92]:46546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aU-0002tu-Ru
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aS-0002et-T9
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:02 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36391 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gn1aS-0002W7-Hh
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:00 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 25 Jan 2019 14:31:30 +0100
Message-Id: <1548423098-31864-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 06/14] disas: nanoMIPS: Amend DSP instructions
 related comments
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

Amend some DSP instructions related comments.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 119 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 44 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 17f4c22..f90f1a9 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1836,7 +1836,8 @@ std::string NMD::ABS_S(uint64 instruction)
 
 
 /*
- * ABSQ_S.PH rt, rs - Find Absolute Value of Two Fractional Halfwords
+ * [DSP] ABSQ_S.PH rt, rs - Find absolute value of two fractional halfwords
+ *         with 16-bit saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -1857,7 +1858,8 @@ std::string NMD::ABSQ_S_PH(uint64 instruction)
 
 
 /*
- * ABSQ_S.QB rt, rs - Find Absolute Value of Four Fractional Byte Values
+ * [DSP] ABSQ_S.QB rt, rs - Find absolute value of four fractional byte values
+ *         with 8-bit saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -1878,7 +1880,8 @@ std::string NMD::ABSQ_S_QB(uint64 instruction)
 
 
 /*
- *
+ * [DSP] ABSQ_S.W rt, rs - Find absolute value of fractional word with 32-bit
+ *         saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -2233,7 +2236,7 @@ std::string NMD::ADDIUPC_48_(uint64 instruction)
 
 
 /*
- * ADDQ.PH rd, rt, rs - Add Fractional Halfword Vectors
+ * [DSP] ADDQ.PH rd, rt, rs - Add fractional halfword vectors
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -2257,7 +2260,8 @@ std::string NMD::ADDQ_PH(uint64 instruction)
 
 
 /*
- * ADDQ_S.PH rd, rt, rs - Add Fractional Halfword Vectors
+ * [DSP] ADDQ_S.PH rd, rt, rs - Add fractional halfword vectors with 16-bit
+ *         saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -2281,7 +2285,7 @@ std::string NMD::ADDQ_S_PH(uint64 instruction)
 
 
 /*
- * ADDQ_S.W rd, rt, rs - Add Fractional Words
+ * [DSP] ADDQ_S.W rd, rt, rs - Add fractional words with 32-bit saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -2305,8 +2309,8 @@ std::string NMD::ADDQ_S_W(uint64 instruction)
 
 
 /*
- * ADDQH.PH rd, rt, rs - Add Fractional Halfword Vectors And Shift Right
- *                       to Halve Results
+ * [DSP] ADDQH.PH rd, rt, rs - Add fractional halfword vectors and shift
+ *         right to halve results
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -2330,8 +2334,8 @@ std::string NMD::ADDQH_PH(uint64 instruction)
 
 
 /*
- * ADDQH_R.PH rd, rt, rs - Add Fractional Halfword Vectors And Shift Right
- *                         to Halve Results
+ * [DSP] ADDQH_R.PH rd, rt, rs - Add fractional halfword vectors and shift
+ *         right to halve results with rounding
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -2355,7 +2359,8 @@ std::string NMD::ADDQH_R_PH(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] ADDQH_R.W rd, rt, rs - Add fractional words and shift right to halve
+ *         results with rounding
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -2379,7 +2384,8 @@ std::string NMD::ADDQH_R_W(uint64 instruction)
 
 
 /*
- * ADDQH.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] ADDQH.W rd, rt, rs - Add fractional words and shift right to halve
+ *         results
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -2403,7 +2409,7 @@ std::string NMD::ADDQH_W(uint64 instruction)
 
 
 /*
- * ADDSC rd, rt, rs - Add Signed Word and Set Carry Bit
+ * [DSP] ADDSC rd, rt, rs - Add two signed words and set carry bit
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -2496,7 +2502,7 @@ std::string NMD::ADDU_4X4_(uint64 instruction)
 
 
 /*
- * ADDU.PH rd, rt, rs - Unsigned Add Integer Halfwords
+ * [DSP] ADDU.PH rd, rt, rs - Add two pairs of unsigned halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -2544,7 +2550,8 @@ std::string NMD::ADDU_QB(uint64 instruction)
 
 
 /*
- * ADDU_S.PH rd, rt, rs - Unsigned Add Integer Halfwords
+ * [DSP] ADDU_S.PH rd, rt, rs - Add two pairs of unsigned halfwords with 16-bit
+ *         saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -7848,7 +7855,7 @@ std::string NMD::INS(uint64 instruction)
 
 
 /*
- *
+ * [DSP] INSV - Insert bit field variable
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -9698,7 +9705,8 @@ std::string NMD::LWXS_32_(uint64 instruction)
 
 
 /*
- *
+ * [DSP] MADD ac, rs, rt - Multiply two words and add to the specified
+ *         accumulator
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -9770,7 +9778,8 @@ std::string NMD::MADDF_S(uint64 instruction)
 
 
 /*
- *
+ * [DSP] MADDU ac, rs, rt - Multiply two unsigned words and add to the
+ *         specified accumulator
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -9794,7 +9803,8 @@ std::string NMD::MADDU_DSP_(uint64 instruction)
 
 
 /*
- *
+ * [DSP] MAQ_S.W.PHL ac, rs, rt - Multiply the left-most single vector
+ *         fractional halfword elements with accumulation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -9818,7 +9828,8 @@ std::string NMD::MAQ_S_W_PHL(uint64 instruction)
 
 
 /*
- *
+ * [DSP] MAQ_S.W.PHR ac, rs, rt - Multiply the right-most single vector
+ *         fractional halfword elements with accumulation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -9842,7 +9853,8 @@ std::string NMD::MAQ_S_W_PHR(uint64 instruction)
 
 
 /*
- *
+ * [DSP] MAQ_SA.W.PHL ac, rs, rt - Multiply the left-most single vector
+ *         fractional halfword elements with saturating accumulation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -9866,7 +9878,8 @@ std::string NMD::MAQ_SA_W_PHL(uint64 instruction)
 
 
 /*
- *
+ * [DSP] MAQ_SA.W.PHR ac, rs, rt - Multiply the right-most single vector
+ *         fractional halfword elements with saturating accumulation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11722,7 +11735,8 @@ std::string NMD::ORI(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PACKRL.PH rd, rs, rt - Pack a word using the right halfword from one
+ *         source register and left halfword from another source register
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11764,7 +11778,8 @@ std::string NMD::PAUSE(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PICK.PH rd, rs, rt - Pick a vector of halfwords based on condition
+ *         code bits
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11788,7 +11803,8 @@ std::string NMD::PICK_PH(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PICK.QB rd, rs, rt - Pick a vector of byte values based on condition
+ *         code bits
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11812,7 +11828,8 @@ std::string NMD::PICK_QB(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECEQ.W.PHL rt, rs - Expand the precision of the left-most element
+ *         of a paired halfword
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11834,7 +11851,8 @@ std::string NMD::PRECEQ_W_PHL(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECEQ.W.PHR rt, rs - Expand the precision of the right-most element
+ *         of a paired halfword
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11856,7 +11874,8 @@ std::string NMD::PRECEQ_W_PHR(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECEQU.PH.QBLA rt, rs - Expand the precision of the two
+ *         left-alternate elements of a quad byte vector
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11878,7 +11897,8 @@ std::string NMD::PRECEQU_PH_QBLA(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECEQU.PH.QBL rt, rs - Expand the precision of the two left-most
+ *         elements of a quad byte vector
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11900,7 +11920,8 @@ std::string NMD::PRECEQU_PH_QBL(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECEQU.PH.QBRA rt, rs - Expand the precision of the two
+ *         right-alternate elements of a quad byte vector
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11922,7 +11943,8 @@ std::string NMD::PRECEQU_PH_QBRA(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECEQU.PH.QBR rt, rs - Expand the precision of the two right-most
+ *         elements of a quad byte vector
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11944,7 +11966,9 @@ std::string NMD::PRECEQU_PH_QBR(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECEU.PH.QBLA rt, rs - Expand the precision of the two
+ *         left-alternate elements of a quad byte vector to four unsigned
+ *         halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11966,7 +11990,8 @@ std::string NMD::PRECEU_PH_QBLA(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECEU.PH.QBL rt, rs - Expand the precision of the two left-most
+ *         elements of a quad byte vector to form unsigned halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -11988,7 +12013,9 @@ std::string NMD::PRECEU_PH_QBL(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECEU.PH.QBRA rt, rs - Expand the precision of the two
+ *         right-alternate elements of a quad byte vector to form four
+ *         unsigned halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -12010,7 +12037,8 @@ std::string NMD::PRECEU_PH_QBRA(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * [DSP] PRECEU.PH.QBR rt, rs - Expand the precision of the two right-most
+ *         elements of a quad byte vector to form unsigned halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15202,7 +15230,7 @@ std::string NMD::SUBU_32_(uint64 instruction)
 
 
 /*
- * SUBU.PH rd, rs, rt - Subtract Unsigned Integer Halfwords
+ * [DSP] SUBU.PH rd, rs, rt - Subtract unsigned unsigned halfwords
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15226,7 +15254,7 @@ std::string NMD::SUBU_PH(uint64 instruction)
 
 
 /*
- * SUBU.QB rd, rs, rt - Subtract Unsigned Quad Byte Vector
+ * [DSP] SUBU.QB rd, rs, rt - Subtract unsigned quad byte vectors
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15250,7 +15278,8 @@ std::string NMD::SUBU_QB(uint64 instruction)
 
 
 /*
- * SUBU_S.PH rd, rs, rt - Subtract Unsigned Integer Halfwords (saturating)
+ * [DSP] SUBU_S.PH rd, rs, rt - Subtract unsigned unsigned halfwords with
+ *         8-bit saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15274,7 +15303,8 @@ std::string NMD::SUBU_S_PH(uint64 instruction)
 
 
 /*
- * SUBU_S.QB rd, rs, rt - Subtract Unsigned Quad Byte Vector (saturating)
+ * [DSP] SUBU_S.QB rd, rs, rt - Subtract unsigned quad byte vectors with
+ *         8-bit saturation
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15298,8 +15328,8 @@ std::string NMD::SUBU_S_QB(uint64 instruction)
 
 
 /*
- * SUBUH.QB rd, rs, rt - Subtract Unsigned Bytes And Right Shift to Halve
- *                         Results
+ * [DSP] SUBUH.QB rd, rs, rt - Subtract unsigned bytes and right shift
+ *         to halve results
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -15323,8 +15353,8 @@ std::string NMD::SUBUH_QB(uint64 instruction)
 
 
 /*
- * SUBUH_R.QB rd, rs, rt - Subtract Unsigned Bytes And Right Shift to Halve
- *                           Results (rounding)
+ * [DSP] SUBUH_R.QB rd, rs, rt - Subtract unsigned bytes and right shift
+ *         to halve results with rounding
  *
  *   3         2         1
  *  10987654321098765432109876543210
@@ -16412,7 +16442,8 @@ std::string NMD::WAIT(uint64 instruction)
 
 
 /*
- * WRDSP rt, mask - Write Fields to DSPControl Register from a GPR
+ * [DSP] WRDSP rt, mask - Write selected fields from a GPR to the DSPControl
+ *         register
  *
  *   3         2         1
  *  10987654321098765432109876543210
-- 
2.7.4
