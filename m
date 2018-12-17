Received: from eggs.gnu.org ([2001:4830:134:3::10]:48568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYvY5-0004Hd-7x
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYvXw-00049k-Sq
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:17 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37179 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gYvXv-00044v-OW
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:08 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 17 Dec 2018 17:13:47 +0100
Message-Id: <20181217161347.4270-6-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181217161347.4270-1-aleksandar.markovic@rt-rk.com>
References: <20181217161347.4270-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 4/5] disas: nanoMIPS: Fix order of some
 invocations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, smarkovic@wavecomp.com, amarkovic@wavecomp.com

Rename some functions that have names hard to understand.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 112 ++++++++++++++++++++++-----------------------
 disas/nanomips.h   |  32 ++++++-------
 2 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 9e876305f1..477df84d93 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -683,7 +683,7 @@ uint64 NMD::extract_shift3_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil3il3bs9Fmsb11(uint64 instruction)
+uint64 NMD::extract_u_11_10_9_8_7_6_5_4_3__s3(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 3, 9) << 3;
@@ -707,7 +707,7 @@ uint64 NMD::extract_rtz3_9_8_7(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil1il1bs17Fmsb17(uint64 instruction)
+uint64 NMD::extract_u_17_to_1__s1(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 1, 17) << 1;
@@ -767,7 +767,7 @@ uint64 NMD::extract_shift_4_3_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_shiftxil7il1bs4Fmsb4(uint64 instruction)
+uint64 NMD::extract_shiftx_10_9_8_7__s1(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 7, 4) << 1;
@@ -836,7 +836,7 @@ uint64 NMD::extract_rs_20_19_18_17_16(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil1il1bs2Fmsb2(uint64 instruction)
+uint64 NMD::extract_u_2_1__s1(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 1, 2) << 1;
@@ -934,7 +934,7 @@ uint64 NMD::extract_rs_4_3_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil3il3bs18Fmsb20(uint64 instruction)
+uint64 NMD::extract_u_20_to_3__s3(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 3, 18) << 3;
@@ -942,7 +942,7 @@ uint64 NMD::extr_uil3il3bs18Fmsb20(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il2bs4Fmsb5(uint64 instruction)
+uint64 NMD::extract_u_3_2_1_0__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 4) << 2;
@@ -958,7 +958,7 @@ uint64 NMD::extract_cofun_25_24_23(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il2bs3Fmsb4(uint64 instruction)
+uint64 NMD::extract_u_2_1_0__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 3) << 2;
@@ -1225,7 +1225,7 @@ uint64 NMD::extract_msbt_10_9_8_7_6(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il2bs6Fmsb7(uint64 instruction)
+uint64 NMD::extract_u_5_4_3_2_1_0__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 6) << 2;
@@ -1259,7 +1259,7 @@ uint64 NMD::extract_rs3_6_5_4(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il32bs32Fmsb63(uint64 instruction)
+uint64 NMD::extract_u_31_to_0__s32(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 32) << 32;
@@ -1307,7 +1307,7 @@ uint64 NMD::extract_op_25_24_23_22_21(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il2bs7Fmsb8(uint64 instruction)
+uint64 NMD::extract_u_6_5_4_3_2_1_0__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 7) << 2;
@@ -1339,7 +1339,7 @@ uint64 NMD::extract_eu_3_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil4il4bs4Fmsb7(uint64 instruction)
+uint64 NMD::extract_u_7_6_5_4__s4(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 4, 4) << 4;
@@ -1383,7 +1383,7 @@ uint64 NMD::extract_u_20_19_18_17_16_15_14_13(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil2il2bs16Fmsb17(uint64 instruction)
+uint64 NMD::extract_u_17_to_2__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 2, 16) << 2;
@@ -1433,7 +1433,7 @@ uint64 NMD::extract_u_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil3il3bs1_il8il2bs1Fmsb3(uint64 instruction)
+uint64 NMD::extract_u_3_8__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 3, 1) << 3;
@@ -1450,7 +1450,7 @@ uint64 NMD::extract_fd_10_9_8_7_6(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il2bs5Fmsb6(uint64 instruction)
+uint64 NMD::extract_u_4_3_2_1_0__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 5) << 2;
@@ -1483,7 +1483,7 @@ uint64 NMD::extract_ct_25_24_23_22_21(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil2il2bs19Fmsb20(uint64 instruction)
+uint64 NMD::extract_u_20_to_2__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 2, 19) << 2;
@@ -1501,7 +1501,7 @@ int64 NMD::extract_s_4_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il1bs4Fmsb4(uint64 instruction)
+uint64 NMD::extract_u_3_2_1_0__s1(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 4) << 1;
@@ -1535,7 +1535,7 @@ bool NMD::BEQC_16__cond(uint64 instruction)
 {
     uint64 rs3 = extract_rs3_6_5_4(instruction);
     uint64 rt3 = extract_rt3_9_8_7(instruction);
-    uint64 u = extr_uil0il1bs4Fmsb4(instruction);
+    uint64 u = extract_u_3_2_1_0__s1(instruction);
     return rs3 < rt3 && u != 0;
 }
 
@@ -1544,7 +1544,7 @@ bool NMD::BNEC_16__cond(uint64 instruction)
 {
     uint64 rs3 = extract_rs3_6_5_4(instruction);
     uint64 rt3 = extract_rt3_9_8_7(instruction);
-    uint64 u = extr_uil0il1bs4Fmsb4(instruction);
+    uint64 u = extract_u_3_2_1_0__s1(instruction);
     return rs3 >= rt3 && u != 0;
 }
 
@@ -1558,7 +1558,7 @@ bool NMD::MOVE_cond(uint64 instruction)
 
 bool NMD::P16_BR1_cond(uint64 instruction)
 {
-    uint64 u = extr_uil0il1bs4Fmsb4(instruction);
+    uint64 u = extract_u_3_2_1_0__s1(instruction);
     return u != 0;
 }
 
@@ -1886,7 +1886,7 @@ std::string NMD::ADDIU_GP_B_(uint64 instruction)
 std::string NMD::ADDIU_GP_W_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil2il2bs19Fmsb20(instruction);
+    uint64 u_value = extract_u_20_to_2__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -1929,7 +1929,7 @@ std::string NMD::ADDIU_NEG_(uint64 instruction)
  */
 std::string NMD::ADDIU_R1_SP_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il2bs6Fmsb7(instruction);
+    uint64 u_value = extract_u_5_4_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
@@ -1950,7 +1950,7 @@ std::string NMD::ADDIU_R1_SP_(uint64 instruction)
  */
 std::string NMD::ADDIU_R2_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il2bs3Fmsb4(instruction);
+    uint64 u_value = extract_u_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -2870,7 +2870,7 @@ std::string NMD::BC2NEZC(uint64 instruction)
  */
 std::string NMD::BEQC_16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il1bs4Fmsb4(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -3156,7 +3156,7 @@ std::string NMD::BLTUC(uint64 instruction)
  */
 std::string NMD::BNEC_16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il1bs4Fmsb4(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -5791,7 +5791,7 @@ std::string NMD::DLSA(uint64 instruction)
 std::string NMD::DLUI_48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    uint64 u_value = extr_uil0il32bs32Fmsb63(instruction);
+    uint64 u_value = extract_u_31_to_0__s32(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8062,7 +8062,7 @@ std::string NMD::LBX(uint64 instruction)
 std::string NMD::LD_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil3il3bs18Fmsb20(instruction);
+    uint64 u_value = extract_u_20_to_3__s3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8132,7 +8132,7 @@ std::string NMD::LD_U12_(uint64 instruction)
 std::string NMD::LDC1_GP_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 u_value = extr_uil2il2bs16Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8369,7 +8369,7 @@ std::string NMD::LDXS(uint64 instruction)
  */
 std::string NMD::LH_16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil1il1bs2Fmsb2(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -8394,7 +8394,7 @@ std::string NMD::LH_16_(uint64 instruction)
 std::string NMD::LH_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil1il1bs17Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_1__s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8487,7 +8487,7 @@ std::string NMD::LHE(uint64 instruction)
  */
 std::string NMD::LHU_16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil1il1bs2Fmsb2(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -8512,7 +8512,7 @@ std::string NMD::LHU_16_(uint64 instruction)
 std::string NMD::LHU_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil1il1bs17Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_1__s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8937,7 +8937,7 @@ std::string NMD::LUI(uint64 instruction)
  */
 std::string NMD::LW_16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il2bs4Fmsb5(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -8963,7 +8963,7 @@ std::string NMD::LW_4X4_(uint64 instruction)
 {
     uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rt4_value = extract_rt4_9_7_6_5(instruction);
-    uint64 u_value = extr_uil3il3bs1_il8il2bs1Fmsb3(instruction);
+    uint64 u_value = extract_u_3_8__s2(instruction);
 
     std::string rt4 = GPR(encode_gpr4(rt4_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8986,7 +8986,7 @@ std::string NMD::LW_4X4_(uint64 instruction)
 std::string NMD::LW_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil2il2bs19Fmsb20(instruction);
+    uint64 u_value = extract_u_20_to_2__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9007,7 +9007,7 @@ std::string NMD::LW_GP_(uint64 instruction)
  */
 std::string NMD::LW_GP16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il2bs7Fmsb8(instruction);
+    uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
@@ -9054,7 +9054,7 @@ std::string NMD::LW_S9_(uint64 instruction)
 std::string NMD::LW_SP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_9_8_7_6_5(instruction);
-    uint64 u_value = extr_uil0il2bs5Fmsb6(instruction);
+    uint64 u_value = extract_u_4_3_2_1_0__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9100,7 +9100,7 @@ std::string NMD::LW_U12_(uint64 instruction)
 std::string NMD::LWC1_GP_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 u_value = extr_uil2il2bs16Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9314,7 +9314,7 @@ std::string NMD::LWPC_48_(uint64 instruction)
 std::string NMD::LWU_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil2il2bs16Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -12325,7 +12325,7 @@ std::string NMD::RESTORE_32_(uint64 instruction)
 {
     uint64 count_value = extract_count_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
     uint64 gp_value = extract_gp_2(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
@@ -12348,7 +12348,7 @@ std::string NMD::RESTORE_JRC_16_(uint64 instruction)
 {
     uint64 count_value = extract_count_3_2_1_0(instruction);
     uint64 rt1_value = extract_rtl_11(instruction);
-    uint64 u_value = extr_uil4il4bs4Fmsb7(instruction);
+    uint64 u_value = extract_u_7_6_5_4__s4(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     return img::format("RESTORE.JRC %s%s", u,
@@ -12370,7 +12370,7 @@ std::string NMD::RESTORE_JRC_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 count_value = extract_count_19_18_17_16(instruction);
-    uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
     uint64 gp_value = extract_gp_2(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
@@ -12392,7 +12392,7 @@ std::string NMD::RESTORE_JRC_32_(uint64 instruction)
 std::string NMD::RESTOREF(uint64 instruction)
 {
     uint64 count_value = extract_count_19_18_17_16(instruction);
-    uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     std::string count = IMMEDIATE(copy(count_value));
@@ -12507,7 +12507,7 @@ std::string NMD::ROTX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 shiftx_value = extr_shiftxil7il1bs4Fmsb4(instruction);
+    uint64 shiftx_value = extract_shiftx_10_9_8_7__s1(instruction);
     uint64 stripe_value = extract_stripe_6(instruction);
     uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
@@ -12668,7 +12668,7 @@ std::string NMD::SAVE_16_(uint64 instruction)
 {
     uint64 count_value = extract_count_3_2_1_0(instruction);
     uint64 rt1_value = extract_rtl_11(instruction);
-    uint64 u_value = extr_uil4il4bs4Fmsb7(instruction);
+    uint64 u_value = extract_u_7_6_5_4__s4(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     return img::format("SAVE %s%s", u,
@@ -12690,7 +12690,7 @@ std::string NMD::SAVE_32_(uint64 instruction)
 {
     uint64 count_value = extract_count_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
     uint64 gp_value = extract_gp_2(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
@@ -12712,7 +12712,7 @@ std::string NMD::SAVE_32_(uint64 instruction)
 std::string NMD::SAVEF(uint64 instruction)
 {
     uint64 count_value = extract_count_19_18_17_16(instruction);
-    uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     std::string count = IMMEDIATE(copy(count_value));
@@ -13020,7 +13020,7 @@ std::string NMD::SCWPE(uint64 instruction)
 std::string NMD::SD_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil3il3bs18Fmsb20(instruction);
+    uint64 u_value = extract_u_20_to_3__s3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -13130,7 +13130,7 @@ std::string NMD::SDBBP_32_(uint64 instruction)
 std::string NMD::SDC1_GP_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 u_value = extr_uil2il2bs16Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -13580,7 +13580,7 @@ std::string NMD::SEQI(uint64 instruction)
 std::string NMD::SH_16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extr_uil1il1bs2Fmsb2(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
@@ -13604,7 +13604,7 @@ std::string NMD::SH_16_(uint64 instruction)
 std::string NMD::SH_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil1il1bs17Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_1__s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15154,7 +15154,7 @@ std::string NMD::SUBUH_R_QB(uint64 instruction)
 std::string NMD::SW_16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extr_uil0il2bs4Fmsb5(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
@@ -15179,7 +15179,7 @@ std::string NMD::SW_4X4_(uint64 instruction)
 {
     uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rtz4_value = extract_rtz4_9_7_6_5(instruction);
-    uint64 u_value = extr_uil3il3bs1_il8il2bs1Fmsb3(instruction);
+    uint64 u_value = extract_u_3_8__s2(instruction);
 
     std::string rtz4 = GPR(encode_gpr4_zero(rtz4_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15202,7 +15202,7 @@ std::string NMD::SW_4X4_(uint64 instruction)
 std::string NMD::SW_GP16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extr_uil0il2bs7Fmsb8(instruction);
+    uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15224,7 +15224,7 @@ std::string NMD::SW_GP16_(uint64 instruction)
 std::string NMD::SW_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil2il2bs19Fmsb20(instruction);
+    uint64 u_value = extract_u_20_to_2__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15270,7 +15270,7 @@ std::string NMD::SW_S9_(uint64 instruction)
 std::string NMD::SW_SP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_9_8_7_6_5(instruction);
-    uint64 u_value = extr_uil0il2bs5Fmsb6(instruction);
+    uint64 u_value = extract_u_4_3_2_1_0__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15316,7 +15316,7 @@ std::string NMD::SW_U12_(uint64 instruction)
 std::string NMD::SWC1_GP_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 u_value = extr_uil2il2bs16Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 0089f17d7b..e5b8093ddf 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -218,7 +218,7 @@ private:
     uint64 extract_shift_20_19_18_17_16(uint64 instruction);
     uint64 extract_shift_10_9_8_7_6(uint64 instruction);
     uint64 extract_shiftx_11_10_9_8_7_6(uint64 instruction);
-    uint64 extr_shiftxil7il1bs4Fmsb4(uint64 instruction);
+    uint64 extract_shiftx_10_9_8_7__s1(uint64 instruction);
     uint64 extract_size_20_19_18_17_16(uint64 instruction);
     uint64 extract_stripe_6(uint64 instruction);
     uint64 extract_stype_20_19_18_17_16(uint64 instruction);
@@ -227,24 +227,24 @@ private:
     uint64 extract_u_15_to_0(uint64 instruction);
     uint64 extract_u_17_to_0(uint64 instruction);
     uint64 extract_u_1_0(uint64 instruction);
-    uint64 extr_uil0il1bs4Fmsb4(uint64 instruction);
-    uint64 extr_uil0il2bs3Fmsb4(uint64 instruction);
-    uint64 extr_uil0il2bs4Fmsb5(uint64 instruction);
-    uint64 extr_uil0il2bs5Fmsb6(uint64 instruction);
-    uint64 extr_uil0il2bs6Fmsb7(uint64 instruction);
-    uint64 extr_uil0il2bs7Fmsb8(uint64 instruction);
-    uint64 extr_uil0il32bs32Fmsb63(uint64 instruction);
+    uint64 extract_u_3_2_1_0__s1(uint64 instruction);
+    uint64 extract_u_2_1_0__s2(uint64 instruction);
+    uint64 extract_u_3_2_1_0__s2(uint64 instruction);
+    uint64 extract_u_4_3_2_1_0__s2(uint64 instruction);
+    uint64 extract_u_5_4_3_2_1_0__s2(uint64 instruction);
+    uint64 extract_u_6_5_4_3_2_1_0__s2(uint64 instruction);
+    uint64 extract_u_31_to_0__s32(uint64 instruction);
     uint64 extract_u_10(uint64 instruction);
     uint64 extract_u_17_16_15_14_13_12_11(uint64 instruction);
     uint64 extract_u_20_19_18_17_16_15_14_13(uint64 instruction);
-    uint64 extr_uil1il1bs17Fmsb17(uint64 instruction);
-    uint64 extr_uil1il1bs2Fmsb2(uint64 instruction);
-    uint64 extr_uil2il2bs16Fmsb17(uint64 instruction);
-    uint64 extr_uil2il2bs19Fmsb20(uint64 instruction);
-    uint64 extr_uil3il3bs18Fmsb20(uint64 instruction);
-    uint64 extr_uil3il3bs1_il8il2bs1Fmsb3(uint64 instruction);
-    uint64 extr_uil3il3bs9Fmsb11(uint64 instruction);
-    uint64 extr_uil4il4bs4Fmsb7(uint64 instruction);
+    uint64 extract_u_17_to_1__s1(uint64 instruction);
+    uint64 extract_u_2_1__s1(uint64 instruction);
+    uint64 extract_u_17_to_2__s2(uint64 instruction);
+    uint64 extract_u_20_to_2__s2(uint64 instruction);
+    uint64 extract_u_20_to_3__s3(uint64 instruction);
+    uint64 extract_u_3_8__s2(uint64 instruction);
+    uint64 extract_u_11_10_9_8_7_6_5_4_3__s3(uint64 instruction);
+    uint64 extract_u_7_6_5_4__s4(uint64 instruction);
 
     bool ADDIU_32__cond(uint64 instruction);
     bool ADDIU_RS5__cond(uint64 instruction);
-- 
2.17.1
