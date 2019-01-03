Received: from eggs.gnu.org ([208.118.235.92]:38461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UI-0004jJ-Na
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6U9-0007ih-7l
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:54 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46169 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6U8-0007Qw-3K
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:44 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:07:50 +0100
Message-Id: <1546535297-11040-18-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 17/44] disas: nanoMIPS: Fix a function
 misnomer
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

Fix wrong function name. The convention in these files is that names of
extraction functions should reflect bit patterns they are extracting.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 264 ++++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |   2 +-
 2 files changed, 133 insertions(+), 133 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 4784530..2abf18d 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1395,7 +1395,7 @@ uint64 NMD::extr_uil2il2bs16Fmsb17(uint64 instruction)
 }
 
 
-uint64 NMD::extract_rd_20_19_18_17_16(uint64 instruction)
+uint64 NMD::extract_rd_15_14_13_12_11(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 11, 5);
@@ -1583,7 +1583,7 @@ bool NMD::PREFE_cond(uint64 instruction)
 
 bool NMD::SLTU_cond(uint64 instruction)
 {
-    uint64 rd = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd = extract_rd_15_14_13_12_11(instruction);
     return rd != 0;
 }
 
@@ -1731,7 +1731,7 @@ std::string NMD::ACLR(uint64 instruction)
 std::string NMD::ADD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2043,7 +2043,7 @@ std::string NMD::ADDIUPC_48_(uint64 instruction)
 std::string NMD::ADDQ_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2067,7 +2067,7 @@ std::string NMD::ADDQ_PH(uint64 instruction)
 std::string NMD::ADDQ_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2091,7 +2091,7 @@ std::string NMD::ADDQ_S_PH(uint64 instruction)
 std::string NMD::ADDQ_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2116,7 +2116,7 @@ std::string NMD::ADDQ_S_W(uint64 instruction)
 std::string NMD::ADDQH_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2141,7 +2141,7 @@ std::string NMD::ADDQH_PH(uint64 instruction)
 std::string NMD::ADDQH_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2165,7 +2165,7 @@ std::string NMD::ADDQH_R_PH(uint64 instruction)
 std::string NMD::ADDQH_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2189,7 +2189,7 @@ std::string NMD::ADDQH_R_W(uint64 instruction)
 std::string NMD::ADDQH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2213,7 +2213,7 @@ std::string NMD::ADDQH_W(uint64 instruction)
 std::string NMD::ADDSC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2260,7 +2260,7 @@ std::string NMD::ADDU_16_(uint64 instruction)
 std::string NMD::ADDU_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2306,7 +2306,7 @@ std::string NMD::ADDU_4X4_(uint64 instruction)
 std::string NMD::ADDU_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2330,7 +2330,7 @@ std::string NMD::ADDU_PH(uint64 instruction)
 std::string NMD::ADDU_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2354,7 +2354,7 @@ std::string NMD::ADDU_QB(uint64 instruction)
 std::string NMD::ADDU_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2378,7 +2378,7 @@ std::string NMD::ADDU_S_PH(uint64 instruction)
 std::string NMD::ADDU_S_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2403,7 +2403,7 @@ std::string NMD::ADDU_S_QB(uint64 instruction)
 std::string NMD::ADDUH_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2428,7 +2428,7 @@ std::string NMD::ADDUH_QB(uint64 instruction)
 std::string NMD::ADDUH_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2451,7 +2451,7 @@ std::string NMD::ADDUH_R_QB(uint64 instruction)
 std::string NMD::ADDWC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2518,7 +2518,7 @@ std::string NMD::AND_16_(uint64 instruction)
 std::string NMD::AND_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4725,7 +4725,7 @@ std::string NMD::CMP_UN_S(uint64 instruction)
 std::string NMD::CMPGDU_EQ_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4749,7 +4749,7 @@ std::string NMD::CMPGDU_EQ_QB(uint64 instruction)
 std::string NMD::CMPGDU_LE_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4773,7 +4773,7 @@ std::string NMD::CMPGDU_LE_QB(uint64 instruction)
 std::string NMD::CMPGDU_LT_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4797,7 +4797,7 @@ std::string NMD::CMPGDU_LT_QB(uint64 instruction)
 std::string NMD::CMPGU_EQ_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4821,7 +4821,7 @@ std::string NMD::CMPGU_EQ_QB(uint64 instruction)
 std::string NMD::CMPGU_LE_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4845,7 +4845,7 @@ std::string NMD::CMPGU_LE_QB(uint64 instruction)
 std::string NMD::CMPGU_LT_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5333,7 +5333,7 @@ std::string NMD::DADDIU_U12_(uint64 instruction)
 std::string NMD::DADD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5357,7 +5357,7 @@ std::string NMD::DADD(uint64 instruction)
 std::string NMD::DADDU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5425,7 +5425,7 @@ std::string NMD::DCLZ(uint64 instruction)
 std::string NMD::DDIV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5449,7 +5449,7 @@ std::string NMD::DDIV(uint64 instruction)
 std::string NMD::DDIVU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5673,7 +5673,7 @@ std::string NMD::DI(uint64 instruction)
 std::string NMD::DIV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5745,7 +5745,7 @@ std::string NMD::DIV_S(uint64 instruction)
 std::string NMD::DIVU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5769,7 +5769,7 @@ std::string NMD::DIVU(uint64 instruction)
 std::string NMD::DLSA(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 u2_value = extract_u2_10_9(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -5909,7 +5909,7 @@ std::string NMD::DMFGC0(uint64 instruction)
 std::string NMD::DMOD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5933,7 +5933,7 @@ std::string NMD::DMOD(uint64 instruction)
 std::string NMD::DMODU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6069,7 +6069,7 @@ std::string NMD::DMT(uint64 instruction)
 std::string NMD::DMUH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6093,7 +6093,7 @@ std::string NMD::DMUH(uint64 instruction)
 std::string NMD::DMUHU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6117,7 +6117,7 @@ std::string NMD::DMUHU(uint64 instruction)
 std::string NMD::DMUL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6141,7 +6141,7 @@ std::string NMD::DMUL(uint64 instruction)
 std::string NMD::DMULU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6597,7 +6597,7 @@ std::string NMD::DROTR32(uint64 instruction)
 std::string NMD::DROTRV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6695,7 +6695,7 @@ std::string NMD::DSLL32(uint64 instruction)
 std::string NMD::DSLLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6767,7 +6767,7 @@ std::string NMD::DSRA32(uint64 instruction)
 std::string NMD::DSRAV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6839,7 +6839,7 @@ std::string NMD::DSRL32(uint64 instruction)
 std::string NMD::DSRLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6863,7 +6863,7 @@ std::string NMD::DSRLV(uint64 instruction)
 std::string NMD::DSUB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6887,7 +6887,7 @@ std::string NMD::DSUB(uint64 instruction)
 std::string NMD::DSUBU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -7112,7 +7112,7 @@ std::string NMD::EXTD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -7138,7 +7138,7 @@ std::string NMD::EXTD32(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -7453,7 +7453,7 @@ std::string NMD::EXTW(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -7566,7 +7566,7 @@ std::string NMD::FLOOR_W_S(uint64 instruction)
 std::string NMD::FORK(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8018,7 +8018,7 @@ std::string NMD::LBUE(uint64 instruction)
 std::string NMD::LBUX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8042,7 +8042,7 @@ std::string NMD::LBUX(uint64 instruction)
 std::string NMD::LBX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8326,7 +8326,7 @@ std::string NMD::LDPC_48_(uint64 instruction)
 std::string NMD::LDX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8350,7 +8350,7 @@ std::string NMD::LDX(uint64 instruction)
 std::string NMD::LDXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8610,7 +8610,7 @@ std::string NMD::LHUE(uint64 instruction)
 std::string NMD::LHUX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8634,7 +8634,7 @@ std::string NMD::LHUX(uint64 instruction)
 std::string NMD::LHUXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8658,7 +8658,7 @@ std::string NMD::LHUXS(uint64 instruction)
 std::string NMD::LHXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8682,7 +8682,7 @@ std::string NMD::LHXS(uint64 instruction)
 std::string NMD::LHX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8894,7 +8894,7 @@ std::string NMD::LLWPE(uint64 instruction)
 std::string NMD::LSA(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 u2_value = extract_u2_10_9(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -9388,7 +9388,7 @@ std::string NMD::LWU_U12_(uint64 instruction)
 std::string NMD::LWUX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -9412,7 +9412,7 @@ std::string NMD::LWUX(uint64 instruction)
 std::string NMD::LWUXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -9436,7 +9436,7 @@ std::string NMD::LWUXS(uint64 instruction)
 std::string NMD::LWX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -9484,7 +9484,7 @@ std::string NMD::LWXS_16_(uint64 instruction)
 std::string NMD::LWXS_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10172,7 +10172,7 @@ std::string NMD::MINA_S(uint64 instruction)
 std::string NMD::MOD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10196,7 +10196,7 @@ std::string NMD::MOD(uint64 instruction)
 std::string NMD::MODSUB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10220,7 +10220,7 @@ std::string NMD::MODSUB(uint64 instruction)
 std::string NMD::MODU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10388,7 +10388,7 @@ std::string NMD::MOVE(uint64 instruction)
 std::string NMD::MOVN(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10412,7 +10412,7 @@ std::string NMD::MOVN(uint64 instruction)
 std::string NMD::MOVZ(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10834,7 +10834,7 @@ std::string NMD::MTTR(uint64 instruction)
 std::string NMD::MUH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10858,7 +10858,7 @@ std::string NMD::MUH(uint64 instruction)
 std::string NMD::MUHU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10882,7 +10882,7 @@ std::string NMD::MUHU(uint64 instruction)
 std::string NMD::MUL_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10952,7 +10952,7 @@ std::string NMD::MUL_D(uint64 instruction)
 std::string NMD::MUL_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10976,7 +10976,7 @@ std::string NMD::MUL_PH(uint64 instruction)
 std::string NMD::MUL_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11024,7 +11024,7 @@ std::string NMD::MUL_S(uint64 instruction)
 std::string NMD::MULEQ_S_W_PHL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11048,7 +11048,7 @@ std::string NMD::MULEQ_S_W_PHL(uint64 instruction)
 std::string NMD::MULEQ_S_W_PHR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11072,7 +11072,7 @@ std::string NMD::MULEQ_S_W_PHR(uint64 instruction)
 std::string NMD::MULEU_S_PH_QBL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11096,7 +11096,7 @@ std::string NMD::MULEU_S_PH_QBL(uint64 instruction)
 std::string NMD::MULEU_S_PH_QBR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11120,7 +11120,7 @@ std::string NMD::MULEU_S_PH_QBR(uint64 instruction)
 std::string NMD::MULQ_RS_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11144,7 +11144,7 @@ std::string NMD::MULQ_RS_PH(uint64 instruction)
 std::string NMD::MULQ_RS_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11168,7 +11168,7 @@ std::string NMD::MULQ_RS_W(uint64 instruction)
 std::string NMD::MULQ_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11192,7 +11192,7 @@ std::string NMD::MULQ_S_PH(uint64 instruction)
 std::string NMD::MULQ_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11312,7 +11312,7 @@ std::string NMD::MULTU_DSP_(uint64 instruction)
 std::string NMD::MULU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11416,7 +11416,7 @@ std::string NMD::NOP_32_(uint64 instruction)
 std::string NMD::NOR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11484,7 +11484,7 @@ std::string NMD::OR_16_(uint64 instruction)
 std::string NMD::OR_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11532,7 +11532,7 @@ std::string NMD::ORI(uint64 instruction)
 std::string NMD::PACKRL_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11574,7 +11574,7 @@ std::string NMD::PAUSE(uint64 instruction)
 std::string NMD::PICK_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11598,7 +11598,7 @@ std::string NMD::PICK_PH(uint64 instruction)
 std::string NMD::PICK_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11842,7 +11842,7 @@ std::string NMD::PRECEU_PH_QBR(uint64 instruction)
 std::string NMD::PRECR_QB_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11914,7 +11914,7 @@ std::string NMD::PRECR_SRA_R_PH_W(uint64 instruction)
 std::string NMD::PRECRQ_PH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11938,7 +11938,7 @@ std::string NMD::PRECRQ_PH_W(uint64 instruction)
 std::string NMD::PRECRQ_QB_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11962,7 +11962,7 @@ std::string NMD::PRECRQ_QB_PH(uint64 instruction)
 std::string NMD::PRECRQ_RS_PH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11986,7 +11986,7 @@ std::string NMD::PRECRQ_RS_PH_W(uint64 instruction)
 std::string NMD::PRECRQU_S_QB_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -12486,7 +12486,7 @@ std::string NMD::ROTR(uint64 instruction)
 std::string NMD::ROTRV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -12856,7 +12856,7 @@ std::string NMD::SBE(uint64 instruction)
 std::string NMD::SBX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13324,7 +13324,7 @@ std::string NMD::SDPC_48_(uint64 instruction)
 std::string NMD::SDXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13348,7 +13348,7 @@ std::string NMD::SDXS(uint64 instruction)
 std::string NMD::SDX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13842,7 +13842,7 @@ std::string NMD::SHLL_S_W(uint64 instruction)
 std::string NMD::SHLLV_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13866,7 +13866,7 @@ std::string NMD::SHLLV_PH(uint64 instruction)
 std::string NMD::SHLLV_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13890,7 +13890,7 @@ std::string NMD::SHLLV_QB(uint64 instruction)
 std::string NMD::SHLLV_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13914,7 +13914,7 @@ std::string NMD::SHLLV_S_PH(uint64 instruction)
 std::string NMD::SHLLV_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14058,7 +14058,7 @@ std::string NMD::SHRA_R_W(uint64 instruction)
 std::string NMD::SHRAV_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14082,7 +14082,7 @@ std::string NMD::SHRAV_PH(uint64 instruction)
 std::string NMD::SHRAV_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14106,7 +14106,7 @@ std::string NMD::SHRAV_QB(uint64 instruction)
 std::string NMD::SHRAV_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14130,7 +14130,7 @@ std::string NMD::SHRAV_R_PH(uint64 instruction)
 std::string NMD::SHRAV_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14154,7 +14154,7 @@ std::string NMD::SHRAV_R_QB(uint64 instruction)
 std::string NMD::SHRAV_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14226,7 +14226,7 @@ std::string NMD::SHRL_QB(uint64 instruction)
 std::string NMD::SHRLV_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14250,7 +14250,7 @@ std::string NMD::SHRLV_PH(uint64 instruction)
 std::string NMD::SHRLV_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14274,7 +14274,7 @@ std::string NMD::SHRLV_QB(uint64 instruction)
 std::string NMD::SHX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14298,7 +14298,7 @@ std::string NMD::SHX(uint64 instruction)
 std::string NMD::SHXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14390,7 +14390,7 @@ std::string NMD::SLL_32_(uint64 instruction)
 std::string NMD::SLLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14414,7 +14414,7 @@ std::string NMD::SLLV(uint64 instruction)
 std::string NMD::SLT(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14486,7 +14486,7 @@ std::string NMD::SLTIU(uint64 instruction)
 std::string NMD::SLTU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14510,7 +14510,7 @@ std::string NMD::SLTU(uint64 instruction)
 std::string NMD::SOV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14622,7 +14622,7 @@ std::string NMD::SRA(uint64 instruction)
 std::string NMD::SRAV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14694,7 +14694,7 @@ std::string NMD::SRL_32_(uint64 instruction)
 std::string NMD::SRLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14718,7 +14718,7 @@ std::string NMD::SRLV(uint64 instruction)
 std::string NMD::SUB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14790,7 +14790,7 @@ std::string NMD::SUB_S(uint64 instruction)
 std::string NMD::SUBQ_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14815,7 +14815,7 @@ std::string NMD::SUBQ_PH(uint64 instruction)
 std::string NMD::SUBQ_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14840,7 +14840,7 @@ std::string NMD::SUBQ_S_PH(uint64 instruction)
 std::string NMD::SUBQ_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14865,7 +14865,7 @@ std::string NMD::SUBQ_S_W(uint64 instruction)
 std::string NMD::SUBQH_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14890,7 +14890,7 @@ std::string NMD::SUBQH_PH(uint64 instruction)
 std::string NMD::SUBQH_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14915,7 +14915,7 @@ std::string NMD::SUBQH_R_PH(uint64 instruction)
 std::string NMD::SUBQH_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14940,7 +14940,7 @@ std::string NMD::SUBQH_R_W(uint64 instruction)
 std::string NMD::SUBQH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14988,7 +14988,7 @@ std::string NMD::SUBU_16_(uint64 instruction)
 std::string NMD::SUBU_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15012,7 +15012,7 @@ std::string NMD::SUBU_32_(uint64 instruction)
 std::string NMD::SUBU_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15036,7 +15036,7 @@ std::string NMD::SUBU_PH(uint64 instruction)
 std::string NMD::SUBU_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15060,7 +15060,7 @@ std::string NMD::SUBU_QB(uint64 instruction)
 std::string NMD::SUBU_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15084,7 +15084,7 @@ std::string NMD::SUBU_S_PH(uint64 instruction)
 std::string NMD::SUBU_S_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15109,7 +15109,7 @@ std::string NMD::SUBU_S_QB(uint64 instruction)
 std::string NMD::SUBUH_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15134,7 +15134,7 @@ std::string NMD::SUBUH_QB(uint64 instruction)
 std::string NMD::SUBUH_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15534,7 +15534,7 @@ std::string NMD::SWPC_48_(uint64 instruction)
 std::string NMD::SWX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15558,7 +15558,7 @@ std::string NMD::SWX(uint64 instruction)
 std::string NMD::SWXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -16287,7 +16287,7 @@ std::string NMD::XOR_16_(uint64 instruction)
 std::string NMD::XOR_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 4defd35..f04a1a8 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -191,7 +191,7 @@ private:
     uint64 extract_rdl_25_24(uint64 instruction);
     uint64 extract_rd2_3_8(uint64 instruction);
     uint64 extract_rd3_3_2_1(uint64 instruction);
-    uint64 extract_rd_20_19_18_17_16(uint64 instruction);
+    uint64 extract_rd_15_14_13_12_11(uint64 instruction);
     uint64 extract_rs3_6_5_4(uint64 instruction);
     uint64 extract_rs4_4_2_1_0(uint64 instruction);
     uint64 extract_rs_4_3_2_1_0(uint64 instruction);
-- 
2.7.4
