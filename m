Received: from eggs.gnu.org ([209.51.188.92]:54250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gvkuo-00053O-S7
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gvkul-00021E-3F
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:06 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:44007 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gvkuk-0001z9-Hr
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:02 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 18 Feb 2019 16:31:37 +0100
Message-Id: <1550503897-31141-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 7/7] disas: nanoMIPS: Fix a function misnomer
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

Rename function extract_ac_13_12() to extract_ac_15_14().

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 96 +++++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |  2 +-
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 33fb045..db6d4c6 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1058,7 +1058,7 @@ uint64 NMD::extract_stripe_6(uint64 instruction)
 }
 
 
-uint64 NMD::extract_ac_13_12(uint64 instruction)
+uint64 NMD::extract_ac_15_14(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 14, 2);
@@ -6375,7 +6375,7 @@ std::string NMD::DPA_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6399,7 +6399,7 @@ std::string NMD::DPAQ_SA_L_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6423,7 +6423,7 @@ std::string NMD::DPAQ_S_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6447,7 +6447,7 @@ std::string NMD::DPAQX_SA_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6471,7 +6471,7 @@ std::string NMD::DPAQX_S_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6495,7 +6495,7 @@ std::string NMD::DPAU_H_QBL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6519,7 +6519,7 @@ std::string NMD::DPAU_H_QBR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6543,7 +6543,7 @@ std::string NMD::DPAX_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6567,7 +6567,7 @@ std::string NMD::DPS_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6591,7 +6591,7 @@ std::string NMD::DPSQ_SA_L_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6615,7 +6615,7 @@ std::string NMD::DPSQ_S_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6639,7 +6639,7 @@ std::string NMD::DPSQX_SA_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6663,7 +6663,7 @@ std::string NMD::DPSQX_S_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6687,7 +6687,7 @@ std::string NMD::DPSU_H_QBL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6711,7 +6711,7 @@ std::string NMD::DPSU_H_QBR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6735,7 +6735,7 @@ std::string NMD::DPSX_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -7373,7 +7373,7 @@ std::string NMD::EXTPDP(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 size_value = extract_size_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7397,7 +7397,7 @@ std::string NMD::EXTPDPV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7421,7 +7421,7 @@ std::string NMD::EXTP(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 size_value = extract_size_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7445,7 +7445,7 @@ std::string NMD::EXTPV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7469,7 +7469,7 @@ std::string NMD::EXTR_RS_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7493,7 +7493,7 @@ std::string NMD::EXTR_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7517,7 +7517,7 @@ std::string NMD::EXTR_S_H(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7541,7 +7541,7 @@ std::string NMD::EXTR_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7565,7 +7565,7 @@ std::string NMD::EXTRV_RS_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7589,7 +7589,7 @@ std::string NMD::EXTRV_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7613,7 +7613,7 @@ std::string NMD::EXTRV_S_H(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7637,7 +7637,7 @@ std::string NMD::EXTRV_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -9719,7 +9719,7 @@ std::string NMD::MADD_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9792,7 +9792,7 @@ std::string NMD::MADDU_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9817,7 +9817,7 @@ std::string NMD::MAQ_S_W_PHL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9842,7 +9842,7 @@ std::string NMD::MAQ_S_W_PHR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9867,7 +9867,7 @@ std::string NMD::MAQ_SA_W_PHL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9892,7 +9892,7 @@ std::string NMD::MAQ_SA_W_PHR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -10194,7 +10194,7 @@ std::string NMD::MFHGC0(uint64 instruction)
 std::string NMD::MFHI_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -10241,7 +10241,7 @@ std::string NMD::MFHTR(uint64 instruction)
 std::string NMD::MFLO_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -10650,7 +10650,7 @@ std::string NMD::MSUB_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -10721,7 +10721,7 @@ std::string NMD::MSUBU_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -10927,7 +10927,7 @@ std::string NMD::MTHGC0(uint64 instruction)
 std::string NMD::MTHI_DSP_(uint64 instruction)
 {
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string ac = AC(copy(ac_value));
@@ -10948,7 +10948,7 @@ std::string NMD::MTHI_DSP_(uint64 instruction)
 std::string NMD::MTHLIP(uint64 instruction)
 {
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string ac = AC(copy(ac_value));
@@ -10995,7 +10995,7 @@ std::string NMD::MTHTR(uint64 instruction)
 std::string NMD::MTLO_DSP_(uint64 instruction)
 {
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string ac = AC(copy(ac_value));
@@ -11437,7 +11437,7 @@ std::string NMD::MULSA_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -11462,7 +11462,7 @@ std::string NMD::MULSAQ_S_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -11486,7 +11486,7 @@ std::string NMD::MULT_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -11510,7 +11510,7 @@ std::string NMD::MULTU_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -13938,7 +13938,7 @@ std::string NMD::SHE(uint64 instruction)
 std::string NMD::SHILO(uint64 instruction)
 {
     int64 shift_value = extract_shift__se5_21_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string shift = IMMEDIATE(copy(shift_value));
     std::string ac = AC(copy(ac_value));
@@ -13960,7 +13960,7 @@ std::string NMD::SHILO(uint64 instruction)
 std::string NMD::SHILOV(uint64 instruction)
 {
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
+    uint64 ac_value = extract_ac_15_14(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string ac = AC(copy(ac_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 6482eda..243c3e3 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -159,7 +159,7 @@ private:
     int64 extract_s__se31_0_11_to_2_20_to_12_s12(uint64 instruction);
     int64 extract_shift__se5_21_20_19_18_17_16(uint64 instruction);
 
-    uint64 extract_ac_13_12(uint64 instruction);
+    uint64 extract_ac_15_14(uint64 instruction);
     uint64 extract_bit_16_15_14_13_12_11(uint64 instruction);
     uint64 extract_bit_23_22_21(uint64 instruction);
     uint64 extract_c0s_20_19_18_17_16(uint64 instruction);
-- 
2.7.4
