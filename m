Received: from eggs.gnu.org ([2001:4830:134:3::10]:37475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYwPU-0006ke-3O
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYwPO-0004ty-L8
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:10:28 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42464 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gYwPM-0004rZ-Ks
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:10:21 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 17 Dec 2018 18:10:05 +0100
Message-Id: <20181217171007.5007-4-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181217171007.5007-1-aleksandar.markovic@rt-rk.com>
References: <20181217171007.5007-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 3/5] disas: nanoMIPS: Fix a function misnomer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, smarkovic@wavecomp.com, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix wrong name of a function. The convention in this file is that
names of extraction functions should reflect bit patterns they are
extracting.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 264 ++++++++++++++++++++++-----------------------
 disas/nanomips.h   |   2 +-
 2 files changed, 133 insertions(+), 133 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 935c2dee3c..cfad1ec845 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1391,7 +1391,7 @@ uint64 NMD::extr_uil2il2bs16Fmsb17(uint64 instruction)
 }
 
 
-uint64 NMD::extract_rd_20_19_18_17_16(uint64 instruction)
+uint64 NMD::extract_rd_15_14_13_12_11(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 11, 5);
@@ -1579,7 +1579,7 @@ bool NMD::PREFE_cond(uint64 instruction)
 
 bool NMD::SLTU_cond(uint64 instruction)
 {
-    uint64 rd = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd = extract_rd_15_14_13_12_11(instruction);
     return rd != 0;
 }
 
@@ -1727,7 +1727,7 @@ std::string NMD::ACLR(uint64 instruction)
 std::string NMD::ADD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2039,7 +2039,7 @@ std::string NMD::ADDIUPC_48_(uint64 instruction)
 std::string NMD::ADDQ_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2063,7 +2063,7 @@ std::string NMD::ADDQ_PH(uint64 instruction)
 std::string NMD::ADDQ_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2087,7 +2087,7 @@ std::string NMD::ADDQ_S_PH(uint64 instruction)
 std::string NMD::ADDQ_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2112,7 +2112,7 @@ std::string NMD::ADDQ_S_W(uint64 instruction)
 std::string NMD::ADDQH_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2137,7 +2137,7 @@ std::string NMD::ADDQH_PH(uint64 instruction)
 std::string NMD::ADDQH_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2161,7 +2161,7 @@ std::string NMD::ADDQH_R_PH(uint64 instruction)
 std::string NMD::ADDQH_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2185,7 +2185,7 @@ std::string NMD::ADDQH_R_W(uint64 instruction)
 std::string NMD::ADDQH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2209,7 +2209,7 @@ std::string NMD::ADDQH_W(uint64 instruction)
 std::string NMD::ADDSC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2256,7 +2256,7 @@ std::string NMD::ADDU_16_(uint64 instruction)
 std::string NMD::ADDU_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2302,7 +2302,7 @@ std::string NMD::ADDU_4X4_(uint64 instruction)
 std::string NMD::ADDU_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2326,7 +2326,7 @@ std::string NMD::ADDU_PH(uint64 instruction)
 std::string NMD::ADDU_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2350,7 +2350,7 @@ std::string NMD::ADDU_QB(uint64 instruction)
 std::string NMD::ADDU_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2374,7 +2374,7 @@ std::string NMD::ADDU_S_PH(uint64 instruction)
 std::string NMD::ADDU_S_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2399,7 +2399,7 @@ std::string NMD::ADDU_S_QB(uint64 instruction)
 std::string NMD::ADDUH_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2424,7 +2424,7 @@ std::string NMD::ADDUH_QB(uint64 instruction)
 std::string NMD::ADDUH_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2447,7 +2447,7 @@ std::string NMD::ADDUH_R_QB(uint64 instruction)
 std::string NMD::ADDWC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -2514,7 +2514,7 @@ std::string NMD::AND_16_(uint64 instruction)
 std::string NMD::AND_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4721,7 +4721,7 @@ std::string NMD::CMP_UN_S(uint64 instruction)
 std::string NMD::CMPGDU_EQ_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4745,7 +4745,7 @@ std::string NMD::CMPGDU_EQ_QB(uint64 instruction)
 std::string NMD::CMPGDU_LE_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4769,7 +4769,7 @@ std::string NMD::CMPGDU_LE_QB(uint64 instruction)
 std::string NMD::CMPGDU_LT_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4793,7 +4793,7 @@ std::string NMD::CMPGDU_LT_QB(uint64 instruction)
 std::string NMD::CMPGU_EQ_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4817,7 +4817,7 @@ std::string NMD::CMPGU_EQ_QB(uint64 instruction)
 std::string NMD::CMPGU_LE_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -4841,7 +4841,7 @@ std::string NMD::CMPGU_LE_QB(uint64 instruction)
 std::string NMD::CMPGU_LT_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5329,7 +5329,7 @@ std::string NMD::DADDIU_U12_(uint64 instruction)
 std::string NMD::DADD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5353,7 +5353,7 @@ std::string NMD::DADD(uint64 instruction)
 std::string NMD::DADDU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5421,7 +5421,7 @@ std::string NMD::DCLZ(uint64 instruction)
 std::string NMD::DDIV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5445,7 +5445,7 @@ std::string NMD::DDIV(uint64 instruction)
 std::string NMD::DDIVU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5669,7 +5669,7 @@ std::string NMD::DI(uint64 instruction)
 std::string NMD::DIV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5741,7 +5741,7 @@ std::string NMD::DIV_S(uint64 instruction)
 std::string NMD::DIVU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5765,7 +5765,7 @@ std::string NMD::DIVU(uint64 instruction)
 std::string NMD::DLSA(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 u2_value = extract_u2_10_9(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -5905,7 +5905,7 @@ std::string NMD::DMFGC0(uint64 instruction)
 std::string NMD::DMOD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -5929,7 +5929,7 @@ std::string NMD::DMOD(uint64 instruction)
 std::string NMD::DMODU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6065,7 +6065,7 @@ std::string NMD::DMT(uint64 instruction)
 std::string NMD::DMUH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6089,7 +6089,7 @@ std::string NMD::DMUH(uint64 instruction)
 std::string NMD::DMUHU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6113,7 +6113,7 @@ std::string NMD::DMUHU(uint64 instruction)
 std::string NMD::DMUL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6137,7 +6137,7 @@ std::string NMD::DMUL(uint64 instruction)
 std::string NMD::DMULU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6593,7 +6593,7 @@ std::string NMD::DROTR32(uint64 instruction)
 std::string NMD::DROTRV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6691,7 +6691,7 @@ std::string NMD::DSLL32(uint64 instruction)
 std::string NMD::DSLLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6763,7 +6763,7 @@ std::string NMD::DSRA32(uint64 instruction)
 std::string NMD::DSRAV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6835,7 +6835,7 @@ std::string NMD::DSRL32(uint64 instruction)
 std::string NMD::DSRLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6859,7 +6859,7 @@ std::string NMD::DSRLV(uint64 instruction)
 std::string NMD::DSUB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -6883,7 +6883,7 @@ std::string NMD::DSUB(uint64 instruction)
 std::string NMD::DSUBU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -7108,7 +7108,7 @@ std::string NMD::EXTD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -7134,7 +7134,7 @@ std::string NMD::EXTD32(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -7449,7 +7449,7 @@ std::string NMD::EXTW(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -7562,7 +7562,7 @@ std::string NMD::FLOOR_W_S(uint64 instruction)
 std::string NMD::FORK(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8014,7 +8014,7 @@ std::string NMD::LBUE(uint64 instruction)
 std::string NMD::LBUX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8038,7 +8038,7 @@ std::string NMD::LBUX(uint64 instruction)
 std::string NMD::LBX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8322,7 +8322,7 @@ std::string NMD::LDPC_48_(uint64 instruction)
 std::string NMD::LDX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8346,7 +8346,7 @@ std::string NMD::LDX(uint64 instruction)
 std::string NMD::LDXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8606,7 +8606,7 @@ std::string NMD::LHUE(uint64 instruction)
 std::string NMD::LHUX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8630,7 +8630,7 @@ std::string NMD::LHUX(uint64 instruction)
 std::string NMD::LHUXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8654,7 +8654,7 @@ std::string NMD::LHUXS(uint64 instruction)
 std::string NMD::LHXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8678,7 +8678,7 @@ std::string NMD::LHXS(uint64 instruction)
 std::string NMD::LHX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -8890,7 +8890,7 @@ std::string NMD::LLWPE(uint64 instruction)
 std::string NMD::LSA(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 u2_value = extract_u2_10_9(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -9384,7 +9384,7 @@ std::string NMD::LWU_U12_(uint64 instruction)
 std::string NMD::LWUX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -9408,7 +9408,7 @@ std::string NMD::LWUX(uint64 instruction)
 std::string NMD::LWUXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -9432,7 +9432,7 @@ std::string NMD::LWUXS(uint64 instruction)
 std::string NMD::LWX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -9480,7 +9480,7 @@ std::string NMD::LWXS_16_(uint64 instruction)
 std::string NMD::LWXS_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10168,7 +10168,7 @@ std::string NMD::MINA_S(uint64 instruction)
 std::string NMD::MOD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10192,7 +10192,7 @@ std::string NMD::MOD(uint64 instruction)
 std::string NMD::MODSUB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10216,7 +10216,7 @@ std::string NMD::MODSUB(uint64 instruction)
 std::string NMD::MODU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10384,7 +10384,7 @@ std::string NMD::MOVE(uint64 instruction)
 std::string NMD::MOVN(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10408,7 +10408,7 @@ std::string NMD::MOVN(uint64 instruction)
 std::string NMD::MOVZ(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10830,7 +10830,7 @@ std::string NMD::MTTR(uint64 instruction)
 std::string NMD::MUH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10854,7 +10854,7 @@ std::string NMD::MUH(uint64 instruction)
 std::string NMD::MUHU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10878,7 +10878,7 @@ std::string NMD::MUHU(uint64 instruction)
 std::string NMD::MUL_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10948,7 +10948,7 @@ std::string NMD::MUL_D(uint64 instruction)
 std::string NMD::MUL_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -10972,7 +10972,7 @@ std::string NMD::MUL_PH(uint64 instruction)
 std::string NMD::MUL_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11020,7 +11020,7 @@ std::string NMD::MUL_S(uint64 instruction)
 std::string NMD::MULEQ_S_W_PHL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11044,7 +11044,7 @@ std::string NMD::MULEQ_S_W_PHL(uint64 instruction)
 std::string NMD::MULEQ_S_W_PHR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11068,7 +11068,7 @@ std::string NMD::MULEQ_S_W_PHR(uint64 instruction)
 std::string NMD::MULEU_S_PH_QBL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11092,7 +11092,7 @@ std::string NMD::MULEU_S_PH_QBL(uint64 instruction)
 std::string NMD::MULEU_S_PH_QBR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11116,7 +11116,7 @@ std::string NMD::MULEU_S_PH_QBR(uint64 instruction)
 std::string NMD::MULQ_RS_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11140,7 +11140,7 @@ std::string NMD::MULQ_RS_PH(uint64 instruction)
 std::string NMD::MULQ_RS_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11164,7 +11164,7 @@ std::string NMD::MULQ_RS_W(uint64 instruction)
 std::string NMD::MULQ_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11188,7 +11188,7 @@ std::string NMD::MULQ_S_PH(uint64 instruction)
 std::string NMD::MULQ_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11308,7 +11308,7 @@ std::string NMD::MULTU_DSP_(uint64 instruction)
 std::string NMD::MULU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11412,7 +11412,7 @@ std::string NMD::NOP_32_(uint64 instruction)
 std::string NMD::NOR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11480,7 +11480,7 @@ std::string NMD::OR_16_(uint64 instruction)
 std::string NMD::OR_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11528,7 +11528,7 @@ std::string NMD::ORI(uint64 instruction)
 std::string NMD::PACKRL_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11570,7 +11570,7 @@ std::string NMD::PAUSE(uint64 instruction)
 std::string NMD::PICK_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11594,7 +11594,7 @@ std::string NMD::PICK_PH(uint64 instruction)
 std::string NMD::PICK_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11838,7 +11838,7 @@ std::string NMD::PRECEU_PH_QBR(uint64 instruction)
 std::string NMD::PRECR_QB_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11910,7 +11910,7 @@ std::string NMD::PRECR_SRA_R_PH_W(uint64 instruction)
 std::string NMD::PRECRQ_PH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11934,7 +11934,7 @@ std::string NMD::PRECRQ_PH_W(uint64 instruction)
 std::string NMD::PRECRQ_QB_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11958,7 +11958,7 @@ std::string NMD::PRECRQ_QB_PH(uint64 instruction)
 std::string NMD::PRECRQ_RS_PH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -11982,7 +11982,7 @@ std::string NMD::PRECRQ_RS_PH_W(uint64 instruction)
 std::string NMD::PRECRQU_S_QB_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -12482,7 +12482,7 @@ std::string NMD::ROTR(uint64 instruction)
 std::string NMD::ROTRV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -12852,7 +12852,7 @@ std::string NMD::SBE(uint64 instruction)
 std::string NMD::SBX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13320,7 +13320,7 @@ std::string NMD::SDPC_48_(uint64 instruction)
 std::string NMD::SDXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13344,7 +13344,7 @@ std::string NMD::SDXS(uint64 instruction)
 std::string NMD::SDX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13838,7 +13838,7 @@ std::string NMD::SHLL_S_W(uint64 instruction)
 std::string NMD::SHLLV_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13862,7 +13862,7 @@ std::string NMD::SHLLV_PH(uint64 instruction)
 std::string NMD::SHLLV_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13886,7 +13886,7 @@ std::string NMD::SHLLV_QB(uint64 instruction)
 std::string NMD::SHLLV_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -13910,7 +13910,7 @@ std::string NMD::SHLLV_S_PH(uint64 instruction)
 std::string NMD::SHLLV_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14054,7 +14054,7 @@ std::string NMD::SHRA_R_W(uint64 instruction)
 std::string NMD::SHRAV_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14078,7 +14078,7 @@ std::string NMD::SHRAV_PH(uint64 instruction)
 std::string NMD::SHRAV_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14102,7 +14102,7 @@ std::string NMD::SHRAV_QB(uint64 instruction)
 std::string NMD::SHRAV_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14126,7 +14126,7 @@ std::string NMD::SHRAV_R_PH(uint64 instruction)
 std::string NMD::SHRAV_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14150,7 +14150,7 @@ std::string NMD::SHRAV_R_QB(uint64 instruction)
 std::string NMD::SHRAV_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14222,7 +14222,7 @@ std::string NMD::SHRL_QB(uint64 instruction)
 std::string NMD::SHRLV_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14246,7 +14246,7 @@ std::string NMD::SHRLV_PH(uint64 instruction)
 std::string NMD::SHRLV_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14270,7 +14270,7 @@ std::string NMD::SHRLV_QB(uint64 instruction)
 std::string NMD::SHX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14294,7 +14294,7 @@ std::string NMD::SHX(uint64 instruction)
 std::string NMD::SHXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14386,7 +14386,7 @@ std::string NMD::SLL_32_(uint64 instruction)
 std::string NMD::SLLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14410,7 +14410,7 @@ std::string NMD::SLLV(uint64 instruction)
 std::string NMD::SLT(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14482,7 +14482,7 @@ std::string NMD::SLTIU(uint64 instruction)
 std::string NMD::SLTU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14506,7 +14506,7 @@ std::string NMD::SLTU(uint64 instruction)
 std::string NMD::SOV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14618,7 +14618,7 @@ std::string NMD::SRA(uint64 instruction)
 std::string NMD::SRAV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14690,7 +14690,7 @@ std::string NMD::SRL_32_(uint64 instruction)
 std::string NMD::SRLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14714,7 +14714,7 @@ std::string NMD::SRLV(uint64 instruction)
 std::string NMD::SUB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14786,7 +14786,7 @@ std::string NMD::SUB_S(uint64 instruction)
 std::string NMD::SUBQ_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14811,7 +14811,7 @@ std::string NMD::SUBQ_PH(uint64 instruction)
 std::string NMD::SUBQ_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14836,7 +14836,7 @@ std::string NMD::SUBQ_S_PH(uint64 instruction)
 std::string NMD::SUBQ_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14861,7 +14861,7 @@ std::string NMD::SUBQ_S_W(uint64 instruction)
 std::string NMD::SUBQH_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14886,7 +14886,7 @@ std::string NMD::SUBQH_PH(uint64 instruction)
 std::string NMD::SUBQH_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14911,7 +14911,7 @@ std::string NMD::SUBQH_R_PH(uint64 instruction)
 std::string NMD::SUBQH_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14936,7 +14936,7 @@ std::string NMD::SUBQH_R_W(uint64 instruction)
 std::string NMD::SUBQH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -14984,7 +14984,7 @@ std::string NMD::SUBU_16_(uint64 instruction)
 std::string NMD::SUBU_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15008,7 +15008,7 @@ std::string NMD::SUBU_32_(uint64 instruction)
 std::string NMD::SUBU_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15032,7 +15032,7 @@ std::string NMD::SUBU_PH(uint64 instruction)
 std::string NMD::SUBU_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15056,7 +15056,7 @@ std::string NMD::SUBU_QB(uint64 instruction)
 std::string NMD::SUBU_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15080,7 +15080,7 @@ std::string NMD::SUBU_S_PH(uint64 instruction)
 std::string NMD::SUBU_S_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15105,7 +15105,7 @@ std::string NMD::SUBU_S_QB(uint64 instruction)
 std::string NMD::SUBUH_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15130,7 +15130,7 @@ std::string NMD::SUBUH_QB(uint64 instruction)
 std::string NMD::SUBUH_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15530,7 +15530,7 @@ std::string NMD::SWPC_48_(uint64 instruction)
 std::string NMD::SWX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -15554,7 +15554,7 @@ std::string NMD::SWX(uint64 instruction)
 std::string NMD::SWXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
@@ -16283,7 +16283,7 @@ std::string NMD::XOR_16_(uint64 instruction)
 std::string NMD::XOR_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 611eeebaae..0089f17d7b 100644
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
2.17.1
