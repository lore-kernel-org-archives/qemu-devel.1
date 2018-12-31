Received: from eggs.gnu.org ([208.118.235.92]:57386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz1J-0005tp-SL
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz19-00046B-D5
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:21 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60631 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz18-0003ri-K5
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:20 +0100
Message-Id: <1546268200-26966-25-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 24/44] disas: nanoMIPS: Fix order of more
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix order of extraction function invocations so that extraction
goes from MSB side to LSB side of the given instruction coding
content. This is desireable because of consistency and easier
visual spotting of errors.

After this patch, all such invocations should be in the desired
order.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 260 ++++++++++++++++++++++++++---------------------------
 1 file changed, 130 insertions(+), 130 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index aa33434..e9018ea 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1708,8 +1708,8 @@ std::string NMD::ABSQ_S_W(uint64 instruction)
 std::string NMD::ACLR(uint64 instruction)
 {
     uint64 bit_value = extract_bit_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string bit = IMMEDIATE(copy(bit_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -1954,9 +1954,9 @@ std::string NMD::ADDIU_R1_SP_(uint64 instruction)
  */
 std::string NMD::ADDIU_R2_(uint64 instruction)
 {
-    uint64 u_value = extract_u_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_2_1_0__s2(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string rs3 = GPR(encode_gpr3(rs3_value));
@@ -2613,8 +2613,8 @@ std::string NMD::APPEND(uint64 instruction)
 std::string NMD::ASET(uint64 instruction)
 {
     uint64 bit_value = extract_bit_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string bit = IMMEDIATE(copy(bit_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -2786,8 +2786,8 @@ std::string NMD::BC_32_(uint64 instruction)
  */
 std::string NMD::BC1EQZC(uint64 instruction)
 {
-    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
@@ -2808,8 +2808,8 @@ std::string NMD::BC1EQZC(uint64 instruction)
  */
 std::string NMD::BC1NEZC(uint64 instruction)
 {
-    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
@@ -2830,8 +2830,8 @@ std::string NMD::BC1NEZC(uint64 instruction)
  */
 std::string NMD::BC2EQZC(uint64 instruction)
 {
-    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 ct_value = extract_ct_25_24_23_22_21(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string ct = CPR(copy(ct_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
@@ -2852,8 +2852,8 @@ std::string NMD::BC2EQZC(uint64 instruction)
  */
 std::string NMD::BC2NEZC(uint64 instruction)
 {
-    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 ct_value = extract_ct_25_24_23_22_21(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string ct = CPR(copy(ct_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
@@ -2874,9 +2874,9 @@ std::string NMD::BC2NEZC(uint64 instruction)
  */
 std::string NMD::BEQC_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_3_2_1_0__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s1(instruction);
 
     std::string rs3 = GPR(encode_rs3_and_check_rs3_lt_rt3(rs3_value));
     std::string rt3 = GPR(encode_gpr3(rt3_value));
@@ -2899,8 +2899,8 @@ std::string NMD::BEQC_16_(uint64 instruction)
 std::string NMD::BEQC_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string rt = GPR(copy(rt_value));
@@ -2923,8 +2923,8 @@ std::string NMD::BEQC_32_(uint64 instruction)
 std::string NMD::BEQIC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -2946,8 +2946,8 @@ std::string NMD::BEQIC(uint64 instruction)
  */
 std::string NMD::BEQZC_16_(uint64 instruction)
 {
-    int64 s_value = extract_s__se7_0_6_5_4_3_2_1_s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
+    int64 s_value = extract_s__se7_0_6_5_4_3_2_1_s1(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 2);
@@ -2969,8 +2969,8 @@ std::string NMD::BEQZC_16_(uint64 instruction)
 std::string NMD::BGEC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string rt = GPR(copy(rt_value));
@@ -2993,8 +2993,8 @@ std::string NMD::BGEC(uint64 instruction)
 std::string NMD::BGEIC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -3017,8 +3017,8 @@ std::string NMD::BGEIC(uint64 instruction)
 std::string NMD::BGEIUC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -3041,8 +3041,8 @@ std::string NMD::BGEIUC(uint64 instruction)
 std::string NMD::BGEUC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string rt = GPR(copy(rt_value));
@@ -3065,8 +3065,8 @@ std::string NMD::BGEUC(uint64 instruction)
 std::string NMD::BLTC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string rt = GPR(copy(rt_value));
@@ -3089,8 +3089,8 @@ std::string NMD::BLTC(uint64 instruction)
 std::string NMD::BLTIC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -3113,8 +3113,8 @@ std::string NMD::BLTIC(uint64 instruction)
 std::string NMD::BLTIUC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -3137,8 +3137,8 @@ std::string NMD::BLTIUC(uint64 instruction)
 std::string NMD::BLTUC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string rt = GPR(copy(rt_value));
@@ -3160,9 +3160,9 @@ std::string NMD::BLTUC(uint64 instruction)
  */
 std::string NMD::BNEC_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_3_2_1_0__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s1(instruction);
 
     std::string rs3 = GPR(encode_rs3_and_check_rs3_ge_rt3(rs3_value));
     std::string rt3 = GPR(encode_gpr3(rt3_value));
@@ -3185,8 +3185,8 @@ std::string NMD::BNEC_16_(uint64 instruction)
 std::string NMD::BNEC_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string rt = GPR(copy(rt_value));
@@ -3209,8 +3209,8 @@ std::string NMD::BNEC_32_(uint64 instruction)
 std::string NMD::BNEIC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -3232,8 +3232,8 @@ std::string NMD::BNEIC(uint64 instruction)
  */
 std::string NMD::BNEZC_16_(uint64 instruction)
 {
-    int64 s_value = extract_s__se7_0_6_5_4_3_2_1_s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
+    int64 s_value = extract_s__se7_0_6_5_4_3_2_1_s1(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 2);
@@ -3334,9 +3334,9 @@ std::string NMD::BRSC(uint64 instruction)
  */
 std::string NMD::CACHE(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 op_value = extract_op_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string op = IMMEDIATE(copy(op_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -3358,9 +3358,9 @@ std::string NMD::CACHE(uint64 instruction)
  */
 std::string NMD::CACHEE(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 op_value = extract_op_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string op = IMMEDIATE(copy(op_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -7085,9 +7085,9 @@ std::string NMD::EVPE(uint64 instruction)
 std::string NMD::EXT(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 msbd_value = extract_msbt_10_9_8_7_6(instruction);
     uint64 lsb_value = extract_lsb_4_3_2_1_0(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -7111,9 +7111,9 @@ std::string NMD::EXT(uint64 instruction)
 std::string NMD::EXTD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
+    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7137,9 +7137,9 @@ std::string NMD::EXTD(uint64 instruction)
 std::string NMD::EXTD32(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
+    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7163,8 +7163,8 @@ std::string NMD::EXTD32(uint64 instruction)
 std::string NMD::EXTPDP(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 size_value = extract_size_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7211,8 +7211,8 @@ std::string NMD::EXTPDPV(uint64 instruction)
 std::string NMD::EXTP(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 size_value = extract_size_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7452,9 +7452,9 @@ std::string NMD::EXTRV_W(uint64 instruction)
 std::string NMD::EXTW(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
+    uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7630,9 +7630,9 @@ std::string NMD::HYPCALL_16_(uint64 instruction)
 std::string NMD::INS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 msbd_value = extract_msbt_10_9_8_7_6(instruction);
     uint64 lsb_value = extract_lsb_4_3_2_1_0(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -7781,9 +7781,9 @@ std::string NMD::JRC(uint64 instruction)
  */
 std::string NMD::LB_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_1_0(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_1_0(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -7828,8 +7828,8 @@ std::string NMD::LB_GP_(uint64 instruction)
 std::string NMD::LB_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -7876,8 +7876,8 @@ std::string NMD::LB_U12_(uint64 instruction)
 std::string NMD::LBE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -7899,9 +7899,9 @@ std::string NMD::LBE(uint64 instruction)
  */
 std::string NMD::LBU_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_1_0(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_1_0(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -7946,8 +7946,8 @@ std::string NMD::LBU_GP_(uint64 instruction)
 std::string NMD::LBU_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -7994,8 +7994,8 @@ std::string NMD::LBU_U12_(uint64 instruction)
 std::string NMD::LBUE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8088,8 +8088,8 @@ std::string NMD::LD_GP_(uint64 instruction)
 std::string NMD::LD_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8157,9 +8157,9 @@ std::string NMD::LDC1_GP_(uint64 instruction)
  */
 std::string NMD::LDC1_S9_(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8182,8 +8182,8 @@ std::string NMD::LDC1_S9_(uint64 instruction)
 std::string NMD::LDC1_U12_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8206,8 +8206,8 @@ std::string NMD::LDC1_U12_(uint64 instruction)
 std::string NMD::LDC1XS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -8230,8 +8230,8 @@ std::string NMD::LDC1XS(uint64 instruction)
 std::string NMD::LDC1X(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -8253,9 +8253,9 @@ std::string NMD::LDC1X(uint64 instruction)
  */
 std::string NMD::LDC2(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ct_value = extract_ct_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ct = CPR(copy(ct_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8278,9 +8278,9 @@ std::string NMD::LDC2(uint64 instruction)
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
@@ -8373,9 +8373,9 @@ std::string NMD::LDXS(uint64 instruction)
  */
 std::string NMD::LH_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8420,8 +8420,8 @@ std::string NMD::LH_GP_(uint64 instruction)
 std::string NMD::LH_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8468,8 +8468,8 @@ std::string NMD::LH_U12_(uint64 instruction)
 std::string NMD::LHE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8491,9 +8491,9 @@ std::string NMD::LHE(uint64 instruction)
  */
 std::string NMD::LHU_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8538,8 +8538,8 @@ std::string NMD::LHU_GP_(uint64 instruction)
 std::string NMD::LHU_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8586,8 +8586,8 @@ std::string NMD::LHU_U12_(uint64 instruction)
 std::string NMD::LHUE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8705,8 +8705,8 @@ std::string NMD::LHX(uint64 instruction)
  */
 std::string NMD::LI_16_(uint64 instruction)
 {
-    uint64 eu_value = extract_eu_6_5_4_3_2_1_0(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
+    uint64 eu_value = extract_eu_6_5_4_3_2_1_0(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string eu = IMMEDIATE(encode_eu_from_s_li16(eu_value));
@@ -8750,8 +8750,8 @@ std::string NMD::LI_48_(uint64 instruction)
 std::string NMD::LL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8774,8 +8774,8 @@ std::string NMD::LL(uint64 instruction)
 std::string NMD::LLD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_s3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_s3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8822,8 +8822,8 @@ std::string NMD::LLDP(uint64 instruction)
 std::string NMD::LLE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8894,9 +8894,9 @@ std::string NMD::LLWPE(uint64 instruction)
 std::string NMD::LSA(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 u2_value = extract_u2_10_9(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -8941,9 +8941,9 @@ std::string NMD::LUI(uint64 instruction)
  */
 std::string NMD::LW_16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8965,8 +8965,8 @@ std::string NMD::LW_16_(uint64 instruction)
  */
 std::string NMD::LW_4X4_(uint64 instruction)
 {
-    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rt4_value = extract_rt4_9_7_6_5(instruction);
+    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 u_value = extract_u_3_8__s2(instruction);
 
     std::string rt4 = GPR(encode_gpr4(rt4_value));
@@ -9011,8 +9011,8 @@ std::string NMD::LW_GP_(uint64 instruction)
  */
 std::string NMD::LW_GP16_(uint64 instruction)
 {
-    uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
+    uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9034,8 +9034,8 @@ std::string NMD::LW_GP16_(uint64 instruction)
 std::string NMD::LW_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -9125,9 +9125,9 @@ std::string NMD::LWC1_GP_(uint64 instruction)
  */
 std::string NMD::LWC1_S9_(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -9150,8 +9150,8 @@ std::string NMD::LWC1_S9_(uint64 instruction)
 std::string NMD::LWC1_U12_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9174,8 +9174,8 @@ std::string NMD::LWC1_U12_(uint64 instruction)
 std::string NMD::LWC1X(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -9198,8 +9198,8 @@ std::string NMD::LWC1X(uint64 instruction)
 std::string NMD::LWC1XS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -9221,9 +9221,9 @@ std::string NMD::LWC1XS(uint64 instruction)
  */
 std::string NMD::LWC2(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ct_value = extract_ct_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ct = CPR(copy(ct_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -9246,8 +9246,8 @@ std::string NMD::LWC2(uint64 instruction)
 std::string NMD::LWE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -9270,9 +9270,9 @@ std::string NMD::LWE(uint64 instruction)
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
@@ -9340,8 +9340,8 @@ std::string NMD::LWU_GP_(uint64 instruction)
 std::string NMD::LWU_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -10311,9 +10311,9 @@ std::string NMD::MOVE_BALC(uint64 instruction)
  */
 std::string NMD::MOVEP(uint64 instruction)
 {
-    uint64 rsz4_value = extract_rsz4_4_2_1_0(instruction);
     uint64 rtz4_value = extract_rtz4_9_7_6_5(instruction);
     uint64 rd2_value = extract_rd2_3_8(instruction);
+    uint64 rsz4_value = extract_rsz4_4_2_1_0(instruction);
 
     std::string rd2 = GPR(encode_rd2_reg1(rd2_value));
     std::string re2 = GPR(encode_rd2_reg2(rd2_value));
@@ -10338,9 +10338,9 @@ std::string NMD::MOVEP(uint64 instruction)
  */
 std::string NMD::MOVEP_REV_(uint64 instruction)
 {
-    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rt4_value = extract_rt4_9_7_6_5(instruction);
     uint64 rd2_value = extract_rd2_3_8(instruction);
+    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
 
     std::string rs4 = GPR(encode_gpr4(rs4_value));
     std::string rt4 = GPR(encode_gpr4(rt4_value));
@@ -10905,8 +10905,8 @@ std::string NMD::MUL_32_(uint64 instruction)
  */
 std::string NMD::MUL_4X4_(uint64 instruction)
 {
-    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rt4_value = extract_rt4_9_7_6_5(instruction);
+    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
 
     std::string rs4 = GPR(encode_gpr4(rs4_value));
     std::string rt4 = GPR(encode_gpr4(rt4_value));
@@ -11866,8 +11866,8 @@ std::string NMD::PRECR_QB_PH(uint64 instruction)
 std::string NMD::PRECR_SRA_PH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -11890,8 +11890,8 @@ std::string NMD::PRECR_SRA_PH_W(uint64 instruction)
 std::string NMD::PRECR_SRA_R_PH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -12057,9 +12057,9 @@ std::string NMD::PREF_U12_(uint64 instruction)
  */
 std::string NMD::PREFE(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 hint_value = extract_hint_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string hint = IMMEDIATE(copy(hint_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12082,8 +12082,8 @@ std::string NMD::PREFE(uint64 instruction)
 std::string NMD::PREPEND(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -12327,8 +12327,8 @@ std::string NMD::REPLV_QB(uint64 instruction)
  */
 std::string NMD::RESTORE_32_(uint64 instruction)
 {
-    uint64 count_value = extract_count_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 count_value = extract_count_19_18_17_16(instruction);
     uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
     uint64 gp_value = extract_gp_2(instruction);
 
@@ -12350,9 +12350,9 @@ std::string NMD::RESTORE_32_(uint64 instruction)
  */
 std::string NMD::RESTORE_JRC_16_(uint64 instruction)
 {
-    uint64 count_value = extract_count_3_2_1_0(instruction);
     uint64 rt1_value = extract_rtl_11(instruction);
     uint64 u_value = extract_u_7_6_5_4__s4(instruction);
+    uint64 count_value = extract_count_3_2_1_0(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     return img::format("RESTORE.JRC %s%s", u,
@@ -12670,9 +12670,9 @@ std::string NMD::RSQRT_S(uint64 instruction)
  */
 std::string NMD::SAVE_16_(uint64 instruction)
 {
-    uint64 count_value = extract_count_3_2_1_0(instruction);
     uint64 rt1_value = extract_rtl_11(instruction);
     uint64 u_value = extract_u_7_6_5_4__s4(instruction);
+    uint64 count_value = extract_count_3_2_1_0(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     return img::format("SAVE %s%s", u,
@@ -12738,8 +12738,8 @@ std::string NMD::SAVEF(uint64 instruction)
 std::string NMD::SB_16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extract_u_1_0(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_1_0(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -12784,8 +12784,8 @@ std::string NMD::SB_GP_(uint64 instruction)
 std::string NMD::SB_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12832,8 +12832,8 @@ std::string NMD::SB_U12_(uint64 instruction)
 std::string NMD::SBE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12880,8 +12880,8 @@ std::string NMD::SBX(uint64 instruction)
 std::string NMD::SC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12904,8 +12904,8 @@ std::string NMD::SC(uint64 instruction)
 std::string NMD::SCD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_s3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_s3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12952,8 +12952,8 @@ std::string NMD::SCDP(uint64 instruction)
 std::string NMD::SCE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13046,8 +13046,8 @@ std::string NMD::SD_GP_(uint64 instruction)
 std::string NMD::SD_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13155,9 +13155,9 @@ std::string NMD::SDC1_GP_(uint64 instruction)
  */
 std::string NMD::SDC1_S9_(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13180,8 +13180,8 @@ std::string NMD::SDC1_S9_(uint64 instruction)
 std::string NMD::SDC1_U12_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -13204,8 +13204,8 @@ std::string NMD::SDC1_U12_(uint64 instruction)
 std::string NMD::SDC1X(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -13228,8 +13228,8 @@ std::string NMD::SDC1X(uint64 instruction)
 std::string NMD::SDC1XS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -13252,8 +13252,8 @@ std::string NMD::SDC1XS(uint64 instruction)
 std::string NMD::SDC2(uint64 instruction)
 {
     uint64 cs_value = extract_cs_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string cs = CPR(copy(cs_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13276,9 +13276,9 @@ std::string NMD::SDC2(uint64 instruction)
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
@@ -13584,8 +13584,8 @@ std::string NMD::SEQI(uint64 instruction)
 std::string NMD::SH_16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -13630,8 +13630,8 @@ std::string NMD::SH_GP_(uint64 instruction)
 std::string NMD::SH_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13678,8 +13678,8 @@ std::string NMD::SH_U12_(uint64 instruction)
 std::string NMD::SHE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -13818,8 +13818,8 @@ std::string NMD::SHLL_S_PH(uint64 instruction)
 std::string NMD::SHLL_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -13938,8 +13938,8 @@ std::string NMD::SHLLV_S_W(uint64 instruction)
 std::string NMD::SHRA_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -13962,8 +13962,8 @@ std::string NMD::SHRA_PH(uint64 instruction)
 std::string NMD::SHRA_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -13986,8 +13986,8 @@ std::string NMD::SHRA_QB(uint64 instruction)
 std::string NMD::SHRA_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14010,8 +14010,8 @@ std::string NMD::SHRA_R_PH(uint64 instruction)
 std::string NMD::SHRA_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14034,8 +14034,8 @@ std::string NMD::SHRA_R_QB(uint64 instruction)
 std::string NMD::SHRA_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14178,8 +14178,8 @@ std::string NMD::SHRAV_R_W(uint64 instruction)
 std::string NMD::SHRL_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14202,8 +14202,8 @@ std::string NMD::SHRL_PH(uint64 instruction)
 std::string NMD::SHRL_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14341,9 +14341,9 @@ std::string NMD::SIGRIE(uint64 instruction)
  */
 std::string NMD::SLL_16_(uint64 instruction)
 {
-    uint64 shift3_value = extract_shift3_2_1_0(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 shift3_value = extract_shift3_2_1_0(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string rs3 = GPR(encode_gpr3(rs3_value));
@@ -14645,9 +14645,9 @@ std::string NMD::SRAV(uint64 instruction)
  */
 std::string NMD::SRL_16_(uint64 instruction)
 {
-    uint64 shift3_value = extract_shift3_2_1_0(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 shift3_value = extract_shift3_2_1_0(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string rs3 = GPR(encode_gpr3(rs3_value));
@@ -15158,8 +15158,8 @@ std::string NMD::SUBUH_R_QB(uint64 instruction)
 std::string NMD::SW_16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15181,8 +15181,8 @@ std::string NMD::SW_16_(uint64 instruction)
  */
 std::string NMD::SW_4X4_(uint64 instruction)
 {
-    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rtz4_value = extract_rtz4_9_7_6_5(instruction);
+    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 u_value = extract_u_3_8__s2(instruction);
 
     std::string rtz4 = GPR(encode_gpr4_zero(rtz4_value));
@@ -15205,8 +15205,8 @@ std::string NMD::SW_4X4_(uint64 instruction)
  */
 std::string NMD::SW_GP16_(uint64 instruction)
 {
-    uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
     uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
+    uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15341,9 +15341,9 @@ std::string NMD::SWC1_GP_(uint64 instruction)
  */
 std::string NMD::SWC1_S9_(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -15366,8 +15366,8 @@ std::string NMD::SWC1_S9_(uint64 instruction)
 std::string NMD::SWC1_U12_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15390,8 +15390,8 @@ std::string NMD::SWC1_U12_(uint64 instruction)
 std::string NMD::SWC1X(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -15414,8 +15414,8 @@ std::string NMD::SWC1X(uint64 instruction)
 std::string NMD::SWC1XS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string rs = GPR(copy(rs_value));
@@ -15438,8 +15438,8 @@ std::string NMD::SWC1XS(uint64 instruction)
 std::string NMD::SWC2(uint64 instruction)
 {
     uint64 cs_value = extract_cs_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string cs = CPR(copy(cs_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -15462,8 +15462,8 @@ std::string NMD::SWC2(uint64 instruction)
 std::string NMD::SWE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -15486,9 +15486,9 @@ std::string NMD::SWE(uint64 instruction)
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
@@ -15601,8 +15601,8 @@ std::string NMD::SYNC(uint64 instruction)
  */
 std::string NMD::SYNCI(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string s = IMMEDIATE(copy(s_value));
     std::string rs = GPR(copy(rs_value));
@@ -15623,8 +15623,8 @@ std::string NMD::SYNCI(uint64 instruction)
  */
 std::string NMD::SYNCIE(uint64 instruction)
 {
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string s = IMMEDIATE(copy(s_value));
     std::string rs = GPR(copy(rs_value));
@@ -16032,9 +16032,9 @@ std::string NMD::TRUNC_W_S(uint64 instruction)
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
@@ -16058,8 +16058,8 @@ std::string NMD::UALDM(uint64 instruction)
 std::string NMD::UALH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -16082,9 +16082,9 @@ std::string NMD::UALH(uint64 instruction)
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
@@ -16108,9 +16108,9 @@ std::string NMD::UALWM(uint64 instruction)
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
@@ -16134,8 +16134,8 @@ std::string NMD::UASDM(uint64 instruction)
 std::string NMD::UASH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -16158,9 +16158,9 @@ std::string NMD::UASH(uint64 instruction)
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
