Received: from eggs.gnu.org ([208.118.235.92]:44939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gbTui-0003xg-6O
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 12:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gbTub-00043N-Rj
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 12:21:12 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:58109 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gbTua-00041e-V6
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 12:21:05 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 24 Dec 2018 18:19:35 +0100
Message-Id: <1545671976-13630-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545671976-13630-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545671976-13630-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 10/11] disas: nanoMIPS: Fix order of more
 invocations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix order of extraction function invocations so that extraction
goes from MSB side to LSB side of the given instruction coding
content. This is desireable because of consistency and easier
visual spotting of errors.

After this patch, all such invocations should be in the desired
order.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 208 ++++++++++++++++++++++++++---------------------------
 1 file changed, 104 insertions(+), 104 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 372af90..a3f997f 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -7081,9 +7081,9 @@ std::string NMD::EVPE(uint64 instruction)
 std::string NMD::EXT(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 msbd_value = extract_msbt_10_9_8_7_6(instruction);
     uint64 lsb_value = extract_lsb_4_3_2_1_0(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -7107,9 +7107,9 @@ std::string NMD::EXT(uint64 instruction)
 std::string NMD::EXTD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
+    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7133,9 +7133,9 @@ std::string NMD::EXTD(uint64 instruction)
 std::string NMD::EXTD32(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
+    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7159,8 +7159,8 @@ std::string NMD::EXTD32(uint64 instruction)
 std::string NMD::EXTPDP(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 size_value = extract_size_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7207,8 +7207,8 @@ std::string NMD::EXTPDPV(uint64 instruction)
 std::string NMD::EXTP(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 size_value = extract_size_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7448,9 +7448,9 @@ std::string NMD::EXTRV_W(uint64 instruction)
 std::string NMD::EXTW(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
+    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7626,9 +7626,9 @@ std::string NMD::HYPCALL_16_(uint64 instruction)
 std::string NMD::INS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 msbd_value = extract_msbt_10_9_8_7_6(instruction);
     uint64 lsb_value = extract_lsb_4_3_2_1_0(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -7777,9 +7777,9 @@ std::string NMD::JRC(uint64 instruction)
  */
 std::string NMD::LB_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_1_0(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_1_0(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -7824,8 +7824,8 @@ std::string NMD::LB_GP_(uint64 instruction)
 std::string NMD::LB_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -7872,8 +7872,8 @@ std::string NMD::LB_U12_(uint64 instruction)
 std::string NMD::LBE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -7895,9 +7895,9 @@ std::string NMD::LBE(uint64 instruction)
  */
 std::string NMD::LBU_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_1_0(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_1_0(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -7942,8 +7942,8 @@ std::string NMD::LBU_GP_(uint64 instruction)
 std::string NMD::LBU_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -7990,8 +7990,8 @@ std::string NMD::LBU_U12_(uint64 instruction)
 std::string NMD::LBUE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8084,8 +8084,8 @@ std::string NMD::LD_GP_(uint64 instruction)
 std::string NMD::LD_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8153,9 +8153,9 @@ std::string NMD::LDC1_GP_(uint64 instruction)
  */
 std::string NMD::LDC1_S9_(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8178,8 +8178,8 @@ std::string NMD::LDC1_S9_(uint64 instruction)
 std::string NMD::LDC1_U12_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8202,8 +8202,8 @@ std::string NMD::LDC1_U12_(uint64 instruction)
 std::string NMD::LDC1XS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -8226,8 +8226,8 @@ std::string NMD::LDC1XS(uint64 instruction)
 std::string NMD::LDC1X(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -8249,9 +8249,9 @@ std::string NMD::LDC1X(uint64 instruction)
  */
 std::string NMD::LDC2(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ct_value = extract_ct_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ct = CPR(copy(ct_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8274,9 +8274,9 @@ std::string NMD::LDC2(uint64 instruction)
 std::string NMD::LDM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
+    uint64 count3_value = extract_count3_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8369,9 +8369,9 @@ std::string NMD::LDXS(uint64 instruction)
  */
 std::string NMD::LH_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8416,8 +8416,8 @@ std::string NMD::LH_GP_(uint64 instruction)
 std::string NMD::LH_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8464,8 +8464,8 @@ std::string NMD::LH_U12_(uint64 instruction)
 std::string NMD::LHE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8487,9 +8487,9 @@ std::string NMD::LHE(uint64 instruction)
  */
 std::string NMD::LHU_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8534,8 +8534,8 @@ std::string NMD::LHU_GP_(uint64 instruction)
 std::string NMD::LHU_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8582,8 +8582,8 @@ std::string NMD::LHU_U12_(uint64 instruction)
 std::string NMD::LHUE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8701,8 +8701,8 @@ std::string NMD::LHX(uint64 instruction)
  */
 std::string NMD::LI_16_(uint64 instruction)
 {
-    uint64 eu_value = extract_eu_6_5_4_3_2_1_0(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
+    uint64 eu_value = extract_eu_6_5_4_3_2_1_0(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string eu = IMMEDIATE(encode_eu_from_s_li16(eu_value));
@@ -8746,8 +8746,8 @@ std::string NMD::LI_48_(uint64 instruction)
 std::string NMD::LL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8770,8 +8770,8 @@ std::string NMD::LL(uint64 instruction)
 std::string NMD::LLD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_s3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_s3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8818,8 +8818,8 @@ std::string NMD::LLDP(uint64 instruction)
 std::string NMD::LLE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8890,9 +8890,9 @@ std::string NMD::LLWPE(uint64 instruction)
 std::string NMD::LSA(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 u2_value = extract_u2_10_9(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -8937,9 +8937,9 @@ std::string NMD::LUI(uint64 instruction)
  */
 std::string NMD::LW_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9007,8 +9007,8 @@ std::string NMD::LW_GP_(uint64 instruction)
  */
 std::string NMD::LW_GP16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
+    uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9030,8 +9030,8 @@ std::string NMD::LW_GP16_(uint64 instruction)
 std::string NMD::LW_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -9121,9 +9121,9 @@ std::string NMD::LWC1_GP_(uint64 instruction)
  */
 std::string NMD::LWC1_S9_(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -9146,8 +9146,8 @@ std::string NMD::LWC1_S9_(uint64 instruction)
 std::string NMD::LWC1_U12_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9170,8 +9170,8 @@ std::string NMD::LWC1_U12_(uint64 instruction)
 std::string NMD::LWC1X(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -9194,8 +9194,8 @@ std::string NMD::LWC1X(uint64 instruction)
 std::string NMD::LWC1XS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -9217,9 +9217,9 @@ std::string NMD::LWC1XS(uint64 instruction)
  */
 std::string NMD::LWC2(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ct_value = extract_ct_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ct = CPR(copy(ct_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -9242,8 +9242,8 @@ std::string NMD::LWC2(uint64 instruction)
 std::string NMD::LWE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -9266,9 +9266,9 @@ std::string NMD::LWE(uint64 instruction)
 std::string NMD::LWM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
+    uint64 count3_value = extract_count3_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -9336,8 +9336,8 @@ std::string NMD::LWU_GP_(uint64 instruction)
 std::string NMD::LWU_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -10307,9 +10307,9 @@ std::string NMD::MOVE_BALC(uint64 instruction)
  */
 std::string NMD::MOVEP(uint64 instruction)
 {
-    uint64 rsz4_value = extract_rsz4_4_2_1_0(instruction);
     uint64 rtz4_value = extract_rtz4_9_7_6_5(instruction);
     uint64 rd2_value = extract_rd2_3_8(instruction);
+    uint64 rsz4_value = extract_rsz4_4_2_1_0(instruction);
 
     std::string rd2 = GPR(encode_rd2_reg1(rd2_value));
     std::string re2 = GPR(encode_rd2_reg2(rd2_value));
@@ -10334,9 +10334,9 @@ std::string NMD::MOVEP(uint64 instruction)
  */
 std::string NMD::MOVEP_REV_(uint64 instruction)
 {
-    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rt4_value = extract_rt4_9_7_6_5(instruction);
     uint64 rd2_value = extract_rd2_3_8(instruction);
+    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
 
     std::string rs4 = GPR(encode_gpr4(rs4_value));
     std::string rt4 = GPR(encode_gpr4(rt4_value));
@@ -10901,8 +10901,8 @@ std::string NMD::MUL_32_(uint64 instruction)
  */
 std::string NMD::MUL_4X4_(uint64 instruction)
 {
-    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rt4_value = extract_rt4_9_7_6_5(instruction);
+    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
 
     std::string rs4 = GPR(encode_gpr4(rs4_value));
     std::string rt4 = GPR(encode_gpr4(rt4_value));
@@ -11862,8 +11862,8 @@ std::string NMD::PRECR_QB_PH(uint64 instruction)
 std::string NMD::PRECR_SRA_PH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -11886,8 +11886,8 @@ std::string NMD::PRECR_SRA_PH_W(uint64 instruction)
 std::string NMD::PRECR_SRA_R_PH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -12053,9 +12053,9 @@ std::string NMD::PREF_U12_(uint64 instruction)
  */
 std::string NMD::PREFE(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 hint_value = extract_hint_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string hint = IMMEDIATE(copy(hint_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12078,8 +12078,8 @@ std::string NMD::PREFE(uint64 instruction)
 std::string NMD::PREPEND(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -12323,8 +12323,8 @@ std::string NMD::REPLV_QB(uint64 instruction)
  */
 std::string NMD::RESTORE_32_(uint64 instruction)
 {
-    uint64 count_value = extract_count_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 count_value = extract_count_19_18_17_16(instruction);
     uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
     uint64 gp_value = extract_gp_2(instruction);
 
@@ -12346,9 +12346,9 @@ std::string NMD::RESTORE_32_(uint64 instruction)
  */
 std::string NMD::RESTORE_JRC_16_(uint64 instruction)
 {
-    uint64 count_value = extract_count_3_2_1_0(instruction);
     uint64 rt1_value = extract_rtl_11(instruction);
     uint64 u_value = extract_u_7_6_5_4__s4(instruction);
+    uint64 count_value = extract_count_3_2_1_0(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     return img::format("RESTORE.JRC %s%s", u,
@@ -12666,9 +12666,9 @@ std::string NMD::RSQRT_S(uint64 instruction)
  */
 std::string NMD::SAVE_16_(uint64 instruction)
 {
-    uint64 count_value = extract_count_3_2_1_0(instruction);
     uint64 rt1_value = extract_rtl_11(instruction);
     uint64 u_value = extract_u_7_6_5_4__s4(instruction);
+    uint64 count_value = extract_count_3_2_1_0(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     return img::format("SAVE %s%s", u,
@@ -12734,8 +12734,8 @@ std::string NMD::SAVEF(uint64 instruction)
 std::string NMD::SB_16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extract_u_1_0(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_1_0(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -12780,8 +12780,8 @@ std::string NMD::SB_GP_(uint64 instruction)
 std::string NMD::SB_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12828,8 +12828,8 @@ std::string NMD::SB_U12_(uint64 instruction)
 std::string NMD::SBE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12876,8 +12876,8 @@ std::string NMD::SBX(uint64 instruction)
 std::string NMD::SC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12900,8 +12900,8 @@ std::string NMD::SC(uint64 instruction)
 std::string NMD::SCD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_s3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_s3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12948,8 +12948,8 @@ std::string NMD::SCDP(uint64 instruction)
 std::string NMD::SCE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13042,8 +13042,8 @@ std::string NMD::SD_GP_(uint64 instruction)
 std::string NMD::SD_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13151,9 +13151,9 @@ std::string NMD::SDC1_GP_(uint64 instruction)
  */
 std::string NMD::SDC1_S9_(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13176,8 +13176,8 @@ std::string NMD::SDC1_S9_(uint64 instruction)
 std::string NMD::SDC1_U12_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -13200,8 +13200,8 @@ std::string NMD::SDC1_U12_(uint64 instruction)
 std::string NMD::SDC1X(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -13224,8 +13224,8 @@ std::string NMD::SDC1X(uint64 instruction)
 std::string NMD::SDC1XS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -13248,8 +13248,8 @@ std::string NMD::SDC1XS(uint64 instruction)
 std::string NMD::SDC2(uint64 instruction)
 {
     uint64 cs_value = extract_cs_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string cs = CPR(copy(cs_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13272,9 +13272,9 @@ std::string NMD::SDC2(uint64 instruction)
 std::string NMD::SDM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
+    uint64 count3_value = extract_count3_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13580,8 +13580,8 @@ std::string NMD::SEQI(uint64 instruction)
 std::string NMD::SH_16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -13626,8 +13626,8 @@ std::string NMD::SH_GP_(uint64 instruction)
 std::string NMD::SH_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13674,8 +13674,8 @@ std::string NMD::SH_U12_(uint64 instruction)
 std::string NMD::SHE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13814,8 +13814,8 @@ std::string NMD::SHLL_S_PH(uint64 instruction)
 std::string NMD::SHLL_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -13934,8 +13934,8 @@ std::string NMD::SHLLV_S_W(uint64 instruction)
 std::string NMD::SHRA_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -13958,8 +13958,8 @@ std::string NMD::SHRA_PH(uint64 instruction)
 std::string NMD::SHRA_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -13982,8 +13982,8 @@ std::string NMD::SHRA_QB(uint64 instruction)
 std::string NMD::SHRA_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14006,8 +14006,8 @@ std::string NMD::SHRA_R_PH(uint64 instruction)
 std::string NMD::SHRA_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14030,8 +14030,8 @@ std::string NMD::SHRA_R_QB(uint64 instruction)
 std::string NMD::SHRA_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14174,8 +14174,8 @@ std::string NMD::SHRAV_R_W(uint64 instruction)
 std::string NMD::SHRL_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14198,8 +14198,8 @@ std::string NMD::SHRL_PH(uint64 instruction)
 std::string NMD::SHRL_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14337,9 +14337,9 @@ std::string NMD::SIGRIE(uint64 instruction)
  */
 std::string NMD::SLL_16_(uint64 instruction)
 {
-    uint64 shift3_value = extract_shift3_2_1_0(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 shift3_value = extract_shift3_2_1_0(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string rs3 = GPR(encode_gpr3(rs3_value));
@@ -14641,9 +14641,9 @@ std::string NMD::SRAV(uint64 instruction)
  */
 std::string NMD::SRL_16_(uint64 instruction)
 {
-    uint64 shift3_value = extract_shift3_2_1_0(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 shift3_value = extract_shift3_2_1_0(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string rs3 = GPR(encode_gpr3(rs3_value));
@@ -15154,8 +15154,8 @@ std::string NMD::SUBUH_R_QB(uint64 instruction)
 std::string NMD::SW_16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15177,8 +15177,8 @@ std::string NMD::SW_16_(uint64 instruction)
  */
 std::string NMD::SW_4X4_(uint64 instruction)
 {
-    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rtz4_value = extract_rtz4_9_7_6_5(instruction);
+    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 u_value = extract_u_3_8__s2(instruction);
 
     std::string rtz4 = GPR(encode_gpr4_zero(rtz4_value));
@@ -15201,8 +15201,8 @@ std::string NMD::SW_4X4_(uint64 instruction)
  */
 std::string NMD::SW_GP16_(uint64 instruction)
 {
-    uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
     uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
+    uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15337,9 +15337,9 @@ std::string NMD::SWC1_GP_(uint64 instruction)
  */
 std::string NMD::SWC1_S9_(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -15362,8 +15362,8 @@ std::string NMD::SWC1_S9_(uint64 instruction)
 std::string NMD::SWC1_U12_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15386,8 +15386,8 @@ std::string NMD::SWC1_U12_(uint64 instruction)
 std::string NMD::SWC1X(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -15410,8 +15410,8 @@ std::string NMD::SWC1X(uint64 instruction)
 std::string NMD::SWC1XS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -15434,8 +15434,8 @@ std::string NMD::SWC1XS(uint64 instruction)
 std::string NMD::SWC2(uint64 instruction)
 {
     uint64 cs_value = extract_cs_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string cs = CPR(copy(cs_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -15458,8 +15458,8 @@ std::string NMD::SWC2(uint64 instruction)
 std::string NMD::SWE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -15482,9 +15482,9 @@ std::string NMD::SWE(uint64 instruction)
 std::string NMD::SWM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
+    uint64 count3_value = extract_count3_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -15597,8 +15597,8 @@ std::string NMD::SYNC(uint64 instruction)
  */
 std::string NMD::SYNCI(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string s = IMMEDIATE(copy(s_value));
     std::string rs = GPR(copy(rs_value));
@@ -15619,8 +15619,8 @@ std::string NMD::SYNCI(uint64 instruction)
  */
 std::string NMD::SYNCIE(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string s = IMMEDIATE(copy(s_value));
     std::string rs = GPR(copy(rs_value));
@@ -16028,9 +16028,9 @@ std::string NMD::TRUNC_W_S(uint64 instruction)
 std::string NMD::UALDM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
+    uint64 count3_value = extract_count3_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -16054,8 +16054,8 @@ std::string NMD::UALDM(uint64 instruction)
 std::string NMD::UALH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -16078,9 +16078,9 @@ std::string NMD::UALH(uint64 instruction)
 std::string NMD::UALWM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
+    uint64 count3_value = extract_count3_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -16104,9 +16104,9 @@ std::string NMD::UALWM(uint64 instruction)
 std::string NMD::UASDM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
+    uint64 count3_value = extract_count3_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -16130,8 +16130,8 @@ std::string NMD::UASDM(uint64 instruction)
 std::string NMD::UASH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -16154,9 +16154,9 @@ std::string NMD::UASH(uint64 instruction)
 std::string NMD::UASWM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
+    uint64 count3_value = extract_count3_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
-- 
2.7.4
