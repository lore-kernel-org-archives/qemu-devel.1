Received: from eggs.gnu.org ([208.118.235.92]:57363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz1H-0005qo-NW
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz19-00045I-3S
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60621 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz18-0003rG-DD
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:10 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:15 +0100
Message-Id: <1546268200-26966-20-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 19/44] disas: nanoMIPS: Name some functions
 in a more descriptive way
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

Rename some functions that have names that are hard to understand.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 112 ++++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |  32 +++++++--------
 2 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index d8829f5..281d8d9 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -687,7 +687,7 @@ uint64 NMD::extract_shift3_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil3il3bs9Fmsb11(uint64 instruction)
+uint64 NMD::extract_u_11_10_9_8_7_6_5_4_3__s3(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 3, 9) << 3;
@@ -711,7 +711,7 @@ uint64 NMD::extract_rtz3_9_8_7(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil1il1bs17Fmsb17(uint64 instruction)
+uint64 NMD::extract_u_17_to_1__s1(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 1, 17) << 1;
@@ -771,7 +771,7 @@ uint64 NMD::extract_shift_4_3_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_shiftxil7il1bs4Fmsb4(uint64 instruction)
+uint64 NMD::extract_shiftx_10_9_8_7__s1(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 7, 4) << 1;
@@ -840,7 +840,7 @@ uint64 NMD::extract_rs_20_19_18_17_16(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil1il1bs2Fmsb2(uint64 instruction)
+uint64 NMD::extract_u_2_1__s1(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 1, 2) << 1;
@@ -938,7 +938,7 @@ uint64 NMD::extract_rs_4_3_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil3il3bs18Fmsb20(uint64 instruction)
+uint64 NMD::extract_u_20_to_3__s3(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 3, 18) << 3;
@@ -946,7 +946,7 @@ uint64 NMD::extr_uil3il3bs18Fmsb20(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il2bs4Fmsb5(uint64 instruction)
+uint64 NMD::extract_u_3_2_1_0__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 4) << 2;
@@ -962,7 +962,7 @@ uint64 NMD::extract_cofun_25_24_23(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il2bs3Fmsb4(uint64 instruction)
+uint64 NMD::extract_u_2_1_0__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 3) << 2;
@@ -1229,7 +1229,7 @@ uint64 NMD::extract_msbt_10_9_8_7_6(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il2bs6Fmsb7(uint64 instruction)
+uint64 NMD::extract_u_5_4_3_2_1_0__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 6) << 2;
@@ -1263,7 +1263,7 @@ uint64 NMD::extract_rs3_6_5_4(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il32bs32Fmsb63(uint64 instruction)
+uint64 NMD::extract_u_31_to_0__s32(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 32) << 32;
@@ -1311,7 +1311,7 @@ uint64 NMD::extract_op_25_24_23_22_21(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il2bs7Fmsb8(uint64 instruction)
+uint64 NMD::extract_u_6_5_4_3_2_1_0__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 7) << 2;
@@ -1343,7 +1343,7 @@ uint64 NMD::extract_eu_3_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil4il4bs4Fmsb7(uint64 instruction)
+uint64 NMD::extract_u_7_6_5_4__s4(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 4, 4) << 4;
@@ -1387,7 +1387,7 @@ uint64 NMD::extract_u_20_19_18_17_16_15_14_13(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil2il2bs16Fmsb17(uint64 instruction)
+uint64 NMD::extract_u_17_to_2__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 2, 16) << 2;
@@ -1437,7 +1437,7 @@ uint64 NMD::extract_u_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil3il3bs1_il8il2bs1Fmsb3(uint64 instruction)
+uint64 NMD::extract_u_3_8__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 3, 1) << 3;
@@ -1454,7 +1454,7 @@ uint64 NMD::extract_fd_10_9_8_7_6(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il2bs5Fmsb6(uint64 instruction)
+uint64 NMD::extract_u_4_3_2_1_0__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 5) << 2;
@@ -1487,7 +1487,7 @@ uint64 NMD::extract_ct_25_24_23_22_21(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil2il2bs19Fmsb20(uint64 instruction)
+uint64 NMD::extract_u_20_to_2__s2(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 2, 19) << 2;
@@ -1505,7 +1505,7 @@ int64 NMD::extract_s_4_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_uil0il1bs4Fmsb4(uint64 instruction)
+uint64 NMD::extract_u_3_2_1_0__s1(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 0, 4) << 1;
@@ -1539,7 +1539,7 @@ bool NMD::BEQC_16__cond(uint64 instruction)
 {
     uint64 rs3 = extract_rs3_6_5_4(instruction);
     uint64 rt3 = extract_rt3_9_8_7(instruction);
-    uint64 u = extr_uil0il1bs4Fmsb4(instruction);
+    uint64 u = extract_u_3_2_1_0__s1(instruction);
     return rs3 < rt3 && u != 0;
 }
 
@@ -1548,7 +1548,7 @@ bool NMD::BNEC_16__cond(uint64 instruction)
 {
     uint64 rs3 = extract_rs3_6_5_4(instruction);
     uint64 rt3 = extract_rt3_9_8_7(instruction);
-    uint64 u = extr_uil0il1bs4Fmsb4(instruction);
+    uint64 u = extract_u_3_2_1_0__s1(instruction);
     return rs3 >= rt3 && u != 0;
 }
 
@@ -1562,7 +1562,7 @@ bool NMD::MOVE_cond(uint64 instruction)
 
 bool NMD::P16_BR1_cond(uint64 instruction)
 {
-    uint64 u = extr_uil0il1bs4Fmsb4(instruction);
+    uint64 u = extract_u_3_2_1_0__s1(instruction);
     return u != 0;
 }
 
@@ -1890,7 +1890,7 @@ std::string NMD::ADDIU_GP_B_(uint64 instruction)
 std::string NMD::ADDIU_GP_W_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil2il2bs19Fmsb20(instruction);
+    uint64 u_value = extract_u_20_to_2__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -1933,7 +1933,7 @@ std::string NMD::ADDIU_NEG_(uint64 instruction)
  */
 std::string NMD::ADDIU_R1_SP_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il2bs6Fmsb7(instruction);
+    uint64 u_value = extract_u_5_4_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
@@ -1954,7 +1954,7 @@ std::string NMD::ADDIU_R1_SP_(uint64 instruction)
  */
 std::string NMD::ADDIU_R2_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il2bs3Fmsb4(instruction);
+    uint64 u_value = extract_u_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -2874,7 +2874,7 @@ std::string NMD::BC2NEZC(uint64 instruction)
  */
 std::string NMD::BEQC_16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il1bs4Fmsb4(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -3160,7 +3160,7 @@ std::string NMD::BLTUC(uint64 instruction)
  */
 std::string NMD::BNEC_16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il1bs4Fmsb4(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -5795,7 +5795,7 @@ std::string NMD::DLSA(uint64 instruction)
 std::string NMD::DLUI_48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    uint64 u_value = extr_uil0il32bs32Fmsb63(instruction);
+    uint64 u_value = extract_u_31_to_0__s32(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8066,7 +8066,7 @@ std::string NMD::LBX(uint64 instruction)
 std::string NMD::LD_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil3il3bs18Fmsb20(instruction);
+    uint64 u_value = extract_u_20_to_3__s3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8136,7 +8136,7 @@ std::string NMD::LD_U12_(uint64 instruction)
 std::string NMD::LDC1_GP_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 u_value = extr_uil2il2bs16Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8373,7 +8373,7 @@ std::string NMD::LDXS(uint64 instruction)
  */
 std::string NMD::LH_16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil1il1bs2Fmsb2(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -8398,7 +8398,7 @@ std::string NMD::LH_16_(uint64 instruction)
 std::string NMD::LH_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil1il1bs17Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_1__s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8491,7 +8491,7 @@ std::string NMD::LHE(uint64 instruction)
  */
 std::string NMD::LHU_16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil1il1bs2Fmsb2(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -8516,7 +8516,7 @@ std::string NMD::LHU_16_(uint64 instruction)
 std::string NMD::LHU_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil1il1bs17Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_1__s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8941,7 +8941,7 @@ std::string NMD::LUI(uint64 instruction)
  */
 std::string NMD::LW_16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il2bs4Fmsb5(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
@@ -8967,7 +8967,7 @@ std::string NMD::LW_4X4_(uint64 instruction)
 {
     uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rt4_value = extract_rt4_9_7_6_5(instruction);
-    uint64 u_value = extr_uil3il3bs1_il8il2bs1Fmsb3(instruction);
+    uint64 u_value = extract_u_3_8__s2(instruction);
 
     std::string rt4 = GPR(encode_gpr4(rt4_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8990,7 +8990,7 @@ std::string NMD::LW_4X4_(uint64 instruction)
 std::string NMD::LW_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil2il2bs19Fmsb20(instruction);
+    uint64 u_value = extract_u_20_to_2__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9011,7 +9011,7 @@ std::string NMD::LW_GP_(uint64 instruction)
  */
 std::string NMD::LW_GP16_(uint64 instruction)
 {
-    uint64 u_value = extr_uil0il2bs7Fmsb8(instruction);
+    uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
@@ -9058,7 +9058,7 @@ std::string NMD::LW_S9_(uint64 instruction)
 std::string NMD::LW_SP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_9_8_7_6_5(instruction);
-    uint64 u_value = extr_uil0il2bs5Fmsb6(instruction);
+    uint64 u_value = extract_u_4_3_2_1_0__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9104,7 +9104,7 @@ std::string NMD::LW_U12_(uint64 instruction)
 std::string NMD::LWC1_GP_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 u_value = extr_uil2il2bs16Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9318,7 +9318,7 @@ std::string NMD::LWPC_48_(uint64 instruction)
 std::string NMD::LWU_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil2il2bs16Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -12329,7 +12329,7 @@ std::string NMD::RESTORE_32_(uint64 instruction)
 {
     uint64 count_value = extract_count_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
     uint64 gp_value = extract_gp_2(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
@@ -12352,7 +12352,7 @@ std::string NMD::RESTORE_JRC_16_(uint64 instruction)
 {
     uint64 count_value = extract_count_3_2_1_0(instruction);
     uint64 rt1_value = extract_rtl_11(instruction);
-    uint64 u_value = extr_uil4il4bs4Fmsb7(instruction);
+    uint64 u_value = extract_u_7_6_5_4__s4(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     return img::format("RESTORE.JRC %s%s", u,
@@ -12374,7 +12374,7 @@ std::string NMD::RESTORE_JRC_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 count_value = extract_count_19_18_17_16(instruction);
-    uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
     uint64 gp_value = extract_gp_2(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
@@ -12396,7 +12396,7 @@ std::string NMD::RESTORE_JRC_32_(uint64 instruction)
 std::string NMD::RESTOREF(uint64 instruction)
 {
     uint64 count_value = extract_count_19_18_17_16(instruction);
-    uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     std::string count = IMMEDIATE(copy(count_value));
@@ -12511,7 +12511,7 @@ std::string NMD::ROTX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    uint64 shiftx_value = extr_shiftxil7il1bs4Fmsb4(instruction);
+    uint64 shiftx_value = extract_shiftx_10_9_8_7__s1(instruction);
     uint64 stripe_value = extract_stripe_6(instruction);
     uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
@@ -12672,7 +12672,7 @@ std::string NMD::SAVE_16_(uint64 instruction)
 {
     uint64 count_value = extract_count_3_2_1_0(instruction);
     uint64 rt1_value = extract_rtl_11(instruction);
-    uint64 u_value = extr_uil4il4bs4Fmsb7(instruction);
+    uint64 u_value = extract_u_7_6_5_4__s4(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     return img::format("SAVE %s%s", u,
@@ -12694,7 +12694,7 @@ std::string NMD::SAVE_32_(uint64 instruction)
 {
     uint64 count_value = extract_count_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
     uint64 gp_value = extract_gp_2(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
@@ -12716,7 +12716,7 @@ std::string NMD::SAVE_32_(uint64 instruction)
 std::string NMD::SAVEF(uint64 instruction)
 {
     uint64 count_value = extract_count_19_18_17_16(instruction);
-    uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3__s3(instruction);
 
     std::string u = IMMEDIATE(copy(u_value));
     std::string count = IMMEDIATE(copy(count_value));
@@ -13024,7 +13024,7 @@ std::string NMD::SCWPE(uint64 instruction)
 std::string NMD::SD_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil3il3bs18Fmsb20(instruction);
+    uint64 u_value = extract_u_20_to_3__s3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -13134,7 +13134,7 @@ std::string NMD::SDBBP_32_(uint64 instruction)
 std::string NMD::SDC1_GP_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 u_value = extr_uil2il2bs16Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -13584,7 +13584,7 @@ std::string NMD::SEQI(uint64 instruction)
 std::string NMD::SH_16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extr_uil1il1bs2Fmsb2(instruction);
+    uint64 u_value = extract_u_2_1__s1(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
@@ -13608,7 +13608,7 @@ std::string NMD::SH_16_(uint64 instruction)
 std::string NMD::SH_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil1il1bs17Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_1__s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15158,7 +15158,7 @@ std::string NMD::SUBUH_R_QB(uint64 instruction)
 std::string NMD::SW_16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extr_uil0il2bs4Fmsb5(instruction);
+    uint64 u_value = extract_u_3_2_1_0__s2(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
@@ -15183,7 +15183,7 @@ std::string NMD::SW_4X4_(uint64 instruction)
 {
     uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rtz4_value = extract_rtz4_9_7_6_5(instruction);
-    uint64 u_value = extr_uil3il3bs1_il8il2bs1Fmsb3(instruction);
+    uint64 u_value = extract_u_3_8__s2(instruction);
 
     std::string rtz4 = GPR(encode_gpr4_zero(rtz4_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15206,7 +15206,7 @@ std::string NMD::SW_4X4_(uint64 instruction)
 std::string NMD::SW_GP16_(uint64 instruction)
 {
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
-    uint64 u_value = extr_uil0il2bs7Fmsb8(instruction);
+    uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15228,7 +15228,7 @@ std::string NMD::SW_GP16_(uint64 instruction)
 std::string NMD::SW_GP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extr_uil2il2bs19Fmsb20(instruction);
+    uint64 u_value = extract_u_20_to_2__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15274,7 +15274,7 @@ std::string NMD::SW_S9_(uint64 instruction)
 std::string NMD::SW_SP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_9_8_7_6_5(instruction);
-    uint64 u_value = extr_uil0il2bs5Fmsb6(instruction);
+    uint64 u_value = extract_u_4_3_2_1_0__s2(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15320,7 +15320,7 @@ std::string NMD::SW_U12_(uint64 instruction)
 std::string NMD::SWC1_GP_(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 u_value = extr_uil2il2bs16Fmsb17(instruction);
+    uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string u = IMMEDIATE(copy(u_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index f04a1a8..d3722f6 100644
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
2.7.4
