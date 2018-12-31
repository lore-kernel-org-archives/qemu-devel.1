Received: from eggs.gnu.org ([208.118.235.92]:57362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz1H-0005qf-LS
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz19-00045r-Bl
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:19 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60625 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz18-0003rT-Eg
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:19 +0100
Message-Id: <1546268200-26966-24-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 23/44] disas: nanoMIPS: Name more functions
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

Rename more functions that have names that are hard to understand.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 212 ++++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |  28 +++----
 2 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 69b6e99..aa33434 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -719,7 +719,7 @@ uint64 NMD::extract_u_17_to_1__s1(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil11il0bs10Tmsb9(uint64 instruction)
+int64 NMD::extract_s__se9_20_19_18_17_16_15_14_13_12_11(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 11, 10);
@@ -728,7 +728,7 @@ int64 NMD::extr_sil11il0bs10Tmsb9(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil0il11bs1_il1il1bs10Tmsb11(uint64 instruction)
+int64 NMD::extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 0, 1) << 11;
@@ -795,7 +795,7 @@ uint64 NMD::extract_count3_14_13_12(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil0il31bs1_il2il21bs10_il12il12bs9Tmsb31(uint64 instruction)
+int64 NMD::extract_s__se31_0_11_to_2_20_to_12_s12(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 0, 1) << 31;
@@ -806,7 +806,7 @@ int64 NMD::extr_sil0il31bs1_il2il21bs10_il12il12bs9Tmsb31(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil0il7bs1_il1il1bs6Tmsb7(uint64 instruction)
+int64 NMD::extract_s__se7_0_6_5_4_3_2_1_s1(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 0, 1) << 7;
@@ -880,7 +880,7 @@ uint64 NMD::extract_rdl_25_24(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil0il10bs1_il1il1bs9Tmsb10(uint64 instruction)
+int64 NMD::extract_s__se10_0_9_8_7_6_5_4_3_2_1_s1(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 0, 1) << 10;
@@ -1019,7 +1019,7 @@ uint64 NMD::extract_rsz4_4_2_1_0(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil0il21bs1_il1il1bs20Tmsb21(uint64 instruction)
+int64 NMD::extract_s__se21_0_20_to_1_s1(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 0, 1) << 21;
@@ -1062,7 +1062,7 @@ uint64 NMD::extract_rt_41_40_39_38_37(uint64 instruction)
 }
 
 
-int64 NMD::extract_shift_21_20_19_18_17_16(uint64 instruction)
+int64 NMD::extract_shift__se5_21_20_19_18_17_16(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 16, 6);
@@ -1096,7 +1096,7 @@ uint64 NMD::extract_size_20_19_18_17_16(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil2il2bs6_il15il8bs1Tmsb8(uint64 instruction)
+int64 NMD::extract_s__se8_15_7_6_5_4_3_2_s2(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 2, 6) << 2;
@@ -1122,7 +1122,7 @@ uint64 NMD::extract_fs_20_19_18_17_16(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil0il0bs8_il15il8bs1Tmsb8(uint64 instruction)
+int64 NMD::extract_s__se8_15_7_6_5_4_3_2_1_0(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 0, 8);
@@ -1245,7 +1245,7 @@ uint64 NMD::extract_sa_15_14_13(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil0il14bs1_il1il1bs13Tmsb14(uint64 instruction)
+int64 NMD::extract_s__se14_0_13_to_1_s1(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 0, 1) << 14;
@@ -1351,7 +1351,7 @@ uint64 NMD::extract_u_7_6_5_4__s4(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil3il3bs5_il15il8bs1Tmsb8(uint64 instruction)
+int64 NMD::extract_s__se8_15_7_6_5_4_3_s3(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 3, 5) << 3;
@@ -1369,7 +1369,7 @@ uint64 NMD::extract_ft_15_14_13_12_11(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil0il16bs16_il16il0bs16Tmsb31(uint64 instruction)
+int64 NMD::extract_s__se31_15_to_0_31_to_16(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 0, 16) << 16;
@@ -1419,7 +1419,7 @@ uint64 NMD::extract_code_1_0(uint64 instruction)
 }
 
 
-int64 NMD::extr_sil0il25bs1_il1il1bs24Tmsb25(uint64 instruction)
+int64 NMD::extract_s__se25_0_24_to_1_s1(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 0, 1) << 25;
@@ -1495,7 +1495,7 @@ uint64 NMD::extract_u_20_to_2__s2(uint64 instruction)
 }
 
 
-int64 NMD::extract_s_4_2_1_0(uint64 instruction)
+int64 NMD::extract_s__se3_4_2_1_0(uint64 instruction)
 {
     int64 value = 0;
     value |= extract_bits(instruction, 0, 3);
@@ -1708,7 +1708,7 @@ std::string NMD::ABSQ_S_W(uint64 instruction)
 std::string NMD::ACLR(uint64 instruction)
 {
     uint64 bit_value = extract_bit_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string bit = IMMEDIATE(copy(bit_value));
@@ -1827,7 +1827,7 @@ std::string NMD::ADDIU_32_(uint64 instruction)
 std::string NMD::ADDIU_48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    int64 s_value = extr_sil0il16bs16_il16il0bs16Tmsb31(instruction);
+    int64 s_value = extract_s__se31_15_to_0_31_to_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -1848,7 +1848,7 @@ std::string NMD::ADDIU_48_(uint64 instruction)
 std::string NMD::ADDIU_GP48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    int64 s_value = extr_sil0il16bs16_il16il0bs16Tmsb31(instruction);
+    int64 s_value = extract_s__se31_15_to_0_31_to_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -1977,7 +1977,7 @@ std::string NMD::ADDIU_R2_(uint64 instruction)
 std::string NMD::ADDIU_RS5_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_9_8_7_6_5(instruction);
-    int64 s_value = extract_s_4_2_1_0(instruction);
+    int64 s_value = extract_s__se3_4_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -1999,7 +1999,7 @@ std::string NMD::ADDIU_RS5_(uint64 instruction)
 std::string NMD::ADDIUPC_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il21bs1_il1il1bs20Tmsb21(instruction);
+    int64 s_value = extract_s__se21_0_20_to_1_s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
@@ -2021,7 +2021,7 @@ std::string NMD::ADDIUPC_32_(uint64 instruction)
 std::string NMD::ADDIUPC_48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    int64 s_value = extr_sil0il16bs16_il16il0bs16Tmsb31(instruction);
+    int64 s_value = extract_s__se31_15_to_0_31_to_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 6);
@@ -2475,7 +2475,7 @@ std::string NMD::ADDWC(uint64 instruction)
 std::string NMD::ALUIPC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il31bs1_il2il21bs10_il12il12bs9Tmsb31(instruction);
+    int64 s_value = extract_s__se31_0_11_to_2_20_to_12_s12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
@@ -2613,7 +2613,7 @@ std::string NMD::APPEND(uint64 instruction)
 std::string NMD::ASET(uint64 instruction)
 {
     uint64 bit_value = extract_bit_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string bit = IMMEDIATE(copy(bit_value));
@@ -2636,7 +2636,7 @@ std::string NMD::ASET(uint64 instruction)
  */
 std::string NMD::BALC_16_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il10bs1_il1il1bs9Tmsb10(instruction);
+    int64 s_value = extract_s__se10_0_9_8_7_6_5_4_3_2_1_s1(instruction);
 
     std::string s = ADDRESS(encode_s_from_address(s_value), 2);
 
@@ -2656,7 +2656,7 @@ std::string NMD::BALC_16_(uint64 instruction)
  */
 std::string NMD::BALC_32_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il25bs1_il1il1bs24Tmsb25(instruction);
+    int64 s_value = extract_s__se25_0_24_to_1_s1(instruction);
 
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
 
@@ -2700,7 +2700,7 @@ std::string NMD::BBEQZC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 bit_value = extract_bit_16_15_14_13_12_11(instruction);
-    int64 s_value = extr_sil0il11bs1_il1il1bs10Tmsb11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string bit = IMMEDIATE(copy(bit_value));
@@ -2724,7 +2724,7 @@ std::string NMD::BBNEZC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 bit_value = extract_bit_16_15_14_13_12_11(instruction);
-    int64 s_value = extr_sil0il11bs1_il1il1bs10Tmsb11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string bit = IMMEDIATE(copy(bit_value));
@@ -2746,7 +2746,7 @@ std::string NMD::BBNEZC(uint64 instruction)
  */
 std::string NMD::BC_16_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il10bs1_il1il1bs9Tmsb10(instruction);
+    int64 s_value = extract_s__se10_0_9_8_7_6_5_4_3_2_1_s1(instruction);
 
     std::string s = ADDRESS(encode_s_from_address(s_value), 2);
 
@@ -2766,7 +2766,7 @@ std::string NMD::BC_16_(uint64 instruction)
  */
 std::string NMD::BC_32_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il25bs1_il1il1bs24Tmsb25(instruction);
+    int64 s_value = extract_s__se25_0_24_to_1_s1(instruction);
 
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
 
@@ -2786,7 +2786,7 @@ std::string NMD::BC_32_(uint64 instruction)
  */
 std::string NMD::BC1EQZC(uint64 instruction)
 {
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -2808,7 +2808,7 @@ std::string NMD::BC1EQZC(uint64 instruction)
  */
 std::string NMD::BC1NEZC(uint64 instruction)
 {
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -2830,7 +2830,7 @@ std::string NMD::BC1NEZC(uint64 instruction)
  */
 std::string NMD::BC2EQZC(uint64 instruction)
 {
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 ct_value = extract_ct_25_24_23_22_21(instruction);
 
     std::string ct = CPR(copy(ct_value));
@@ -2852,7 +2852,7 @@ std::string NMD::BC2EQZC(uint64 instruction)
  */
 std::string NMD::BC2NEZC(uint64 instruction)
 {
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 ct_value = extract_ct_25_24_23_22_21(instruction);
 
     std::string ct = CPR(copy(ct_value));
@@ -2899,7 +2899,7 @@ std::string NMD::BEQC_16_(uint64 instruction)
 std::string NMD::BEQC_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rs = GPR(copy(rs_value));
@@ -2923,7 +2923,7 @@ std::string NMD::BEQC_32_(uint64 instruction)
 std::string NMD::BEQIC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il11bs1_il1il1bs10Tmsb11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -2946,7 +2946,7 @@ std::string NMD::BEQIC(uint64 instruction)
  */
 std::string NMD::BEQZC_16_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il7bs1_il1il1bs6Tmsb7(instruction);
+    int64 s_value = extract_s__se7_0_6_5_4_3_2_1_s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
@@ -2969,7 +2969,7 @@ std::string NMD::BEQZC_16_(uint64 instruction)
 std::string NMD::BGEC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rs = GPR(copy(rs_value));
@@ -2993,7 +2993,7 @@ std::string NMD::BGEC(uint64 instruction)
 std::string NMD::BGEIC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il11bs1_il1il1bs10Tmsb11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -3017,7 +3017,7 @@ std::string NMD::BGEIC(uint64 instruction)
 std::string NMD::BGEIUC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il11bs1_il1il1bs10Tmsb11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -3041,7 +3041,7 @@ std::string NMD::BGEIUC(uint64 instruction)
 std::string NMD::BGEUC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rs = GPR(copy(rs_value));
@@ -3065,7 +3065,7 @@ std::string NMD::BGEUC(uint64 instruction)
 std::string NMD::BLTC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rs = GPR(copy(rs_value));
@@ -3089,7 +3089,7 @@ std::string NMD::BLTC(uint64 instruction)
 std::string NMD::BLTIC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il11bs1_il1il1bs10Tmsb11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -3113,7 +3113,7 @@ std::string NMD::BLTIC(uint64 instruction)
 std::string NMD::BLTIUC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il11bs1_il1il1bs10Tmsb11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -3137,7 +3137,7 @@ std::string NMD::BLTIUC(uint64 instruction)
 std::string NMD::BLTUC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rs = GPR(copy(rs_value));
@@ -3185,7 +3185,7 @@ std::string NMD::BNEC_16_(uint64 instruction)
 std::string NMD::BNEC_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rs = GPR(copy(rs_value));
@@ -3209,7 +3209,7 @@ std::string NMD::BNEC_32_(uint64 instruction)
 std::string NMD::BNEIC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il11bs1_il1il1bs10Tmsb11(instruction);
+    int64 s_value = extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(instruction);
     uint64 u_value = extract_u_17_16_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -3232,7 +3232,7 @@ std::string NMD::BNEIC(uint64 instruction)
  */
 std::string NMD::BNEZC_16_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il7bs1_il1il1bs6Tmsb7(instruction);
+    int64 s_value = extract_s__se7_0_6_5_4_3_2_1_s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
 
     std::string rt3 = GPR(encode_gpr3(rt3_value));
@@ -3254,7 +3254,7 @@ std::string NMD::BNEZC_16_(uint64 instruction)
  */
 std::string NMD::BPOSGE32C(uint64 instruction)
 {
-    int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
+    int64 s_value = extract_s__se14_0_13_to_1_s1(instruction);
 
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
 
@@ -3334,7 +3334,7 @@ std::string NMD::BRSC(uint64 instruction)
  */
 std::string NMD::CACHE(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 op_value = extract_op_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -3358,7 +3358,7 @@ std::string NMD::CACHE(uint64 instruction)
  */
 std::string NMD::CACHEE(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 op_value = extract_op_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -5263,7 +5263,7 @@ std::string NMD::CVT_W_S(uint64 instruction)
 std::string NMD::DADDIU_48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    int64 s_value = extr_sil0il16bs16_il16il0bs16Tmsb31(instruction);
+    int64 s_value = extract_s__se31_15_to_0_31_to_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -7828,7 +7828,7 @@ std::string NMD::LB_GP_(uint64 instruction)
 std::string NMD::LB_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -7876,7 +7876,7 @@ std::string NMD::LB_U12_(uint64 instruction)
 std::string NMD::LBE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -7946,7 +7946,7 @@ std::string NMD::LBU_GP_(uint64 instruction)
 std::string NMD::LBU_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -7994,7 +7994,7 @@ std::string NMD::LBU_U12_(uint64 instruction)
 std::string NMD::LBUE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -8088,7 +8088,7 @@ std::string NMD::LD_GP_(uint64 instruction)
 std::string NMD::LD_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -8157,7 +8157,7 @@ std::string NMD::LDC1_GP_(uint64 instruction)
  */
 std::string NMD::LDC1_S9_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -8253,7 +8253,7 @@ std::string NMD::LDC1X(uint64 instruction)
  */
 std::string NMD::LDC2(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ct_value = extract_ct_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -8279,7 +8279,7 @@ std::string NMD::LDM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -8304,7 +8304,7 @@ std::string NMD::LDM(uint64 instruction)
 std::string NMD::LDPC_48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    int64 s_value = extr_sil0il16bs16_il16il0bs16Tmsb31(instruction);
+    int64 s_value = extract_s__se31_15_to_0_31_to_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 6);
@@ -8420,7 +8420,7 @@ std::string NMD::LH_GP_(uint64 instruction)
 std::string NMD::LH_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -8468,7 +8468,7 @@ std::string NMD::LH_U12_(uint64 instruction)
 std::string NMD::LHE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -8538,7 +8538,7 @@ std::string NMD::LHU_GP_(uint64 instruction)
 std::string NMD::LHU_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -8586,7 +8586,7 @@ std::string NMD::LHU_U12_(uint64 instruction)
 std::string NMD::LHUE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -8728,7 +8728,7 @@ std::string NMD::LI_16_(uint64 instruction)
 std::string NMD::LI_48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    int64 s_value = extr_sil0il16bs16_il16il0bs16Tmsb31(instruction);
+    int64 s_value = extract_s__se31_15_to_0_31_to_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -8750,7 +8750,7 @@ std::string NMD::LI_48_(uint64 instruction)
 std::string NMD::LL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil2il2bs6_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -8774,7 +8774,7 @@ std::string NMD::LL(uint64 instruction)
 std::string NMD::LLD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil3il3bs5_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_s3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -8822,7 +8822,7 @@ std::string NMD::LLDP(uint64 instruction)
 std::string NMD::LLE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil2il2bs6_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -8920,7 +8920,7 @@ std::string NMD::LSA(uint64 instruction)
 std::string NMD::LUI(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il31bs1_il2il21bs10_il12il12bs9Tmsb31(instruction);
+    int64 s_value = extract_s__se31_0_11_to_2_20_to_12_s12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -9034,7 +9034,7 @@ std::string NMD::LW_GP16_(uint64 instruction)
 std::string NMD::LW_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -9125,7 +9125,7 @@ std::string NMD::LWC1_GP_(uint64 instruction)
  */
 std::string NMD::LWC1_S9_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -9221,7 +9221,7 @@ std::string NMD::LWC1XS(uint64 instruction)
  */
 std::string NMD::LWC2(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ct_value = extract_ct_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -9246,7 +9246,7 @@ std::string NMD::LWC2(uint64 instruction)
 std::string NMD::LWE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -9271,7 +9271,7 @@ std::string NMD::LWM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -9296,7 +9296,7 @@ std::string NMD::LWM(uint64 instruction)
 std::string NMD::LWPC_48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    int64 s_value = extr_sil0il16bs16_il16il0bs16Tmsb31(instruction);
+    int64 s_value = extract_s__se31_15_to_0_31_to_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 6);
@@ -9340,7 +9340,7 @@ std::string NMD::LWU_GP_(uint64 instruction)
 std::string NMD::LWU_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -10289,7 +10289,7 @@ std::string NMD::MOVE_BALC(uint64 instruction)
 {
     uint64 rtz4_value = extract_rtz4_27_26_25_23_22_21(instruction);
     uint64 rd1_value = extract_rdl_25_24(instruction);
-    int64 s_value = extr_sil0il21bs1_il1il1bs20Tmsb21(instruction);
+    int64 s_value = extract_s__se21_0_20_to_1_s1(instruction);
 
     std::string rd1 = GPR(encode_rd1_from_rd(rd1_value));
     std::string rtz4 = GPR(encode_gpr4_zero(rtz4_value));
@@ -12011,7 +12011,7 @@ std::string NMD::PREF_S9_(uint64 instruction)
 {
     uint64 hint_value = extract_hint_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
 
     std::string hint = IMMEDIATE(copy(hint_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12057,7 +12057,7 @@ std::string NMD::PREF_U12_(uint64 instruction)
  */
 std::string NMD::PREFE(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 hint_value = extract_hint_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -12240,7 +12240,7 @@ std::string NMD::RECIP_S(uint64 instruction)
 std::string NMD::REPL_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil11il0bs10Tmsb9(instruction);
+    int64 s_value = extract_s__se9_20_19_18_17_16_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12784,7 +12784,7 @@ std::string NMD::SB_GP_(uint64 instruction)
 std::string NMD::SB_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -12832,7 +12832,7 @@ std::string NMD::SB_U12_(uint64 instruction)
 std::string NMD::SBE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -12880,7 +12880,7 @@ std::string NMD::SBX(uint64 instruction)
 std::string NMD::SC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil2il2bs6_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -12904,7 +12904,7 @@ std::string NMD::SC(uint64 instruction)
 std::string NMD::SCD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil3il3bs5_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_s3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -12952,7 +12952,7 @@ std::string NMD::SCDP(uint64 instruction)
 std::string NMD::SCE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil2il2bs6_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_s2(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -13046,7 +13046,7 @@ std::string NMD::SD_GP_(uint64 instruction)
 std::string NMD::SD_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -13155,7 +13155,7 @@ std::string NMD::SDC1_GP_(uint64 instruction)
  */
 std::string NMD::SDC1_S9_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -13252,7 +13252,7 @@ std::string NMD::SDC1XS(uint64 instruction)
 std::string NMD::SDC2(uint64 instruction)
 {
     uint64 cs_value = extract_cs_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string cs = CPR(copy(cs_value));
@@ -13277,7 +13277,7 @@ std::string NMD::SDM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -13302,7 +13302,7 @@ std::string NMD::SDM(uint64 instruction)
 std::string NMD::SDPC_48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    int64 s_value = extr_sil0il16bs16_il16il0bs16Tmsb31(instruction);
+    int64 s_value = extract_s__se31_15_to_0_31_to_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 6);
@@ -13630,7 +13630,7 @@ std::string NMD::SH_GP_(uint64 instruction)
 std::string NMD::SH_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -13678,7 +13678,7 @@ std::string NMD::SH_U12_(uint64 instruction)
 std::string NMD::SHE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -13701,7 +13701,7 @@ std::string NMD::SHE(uint64 instruction)
  */
 std::string NMD::SHILO(uint64 instruction)
 {
-    int64 shift_value = extract_shift_21_20_19_18_17_16(instruction);
+    int64 shift_value = extract_shift__se5_21_20_19_18_17_16(instruction);
     uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string shift = IMMEDIATE(copy(shift_value));
@@ -15250,7 +15250,7 @@ std::string NMD::SW_GP_(uint64 instruction)
 std::string NMD::SW_S9_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -15341,7 +15341,7 @@ std::string NMD::SWC1_GP_(uint64 instruction)
  */
 std::string NMD::SWC1_S9_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -15438,7 +15438,7 @@ std::string NMD::SWC1XS(uint64 instruction)
 std::string NMD::SWC2(uint64 instruction)
 {
     uint64 cs_value = extract_cs_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string cs = CPR(copy(cs_value));
@@ -15462,7 +15462,7 @@ std::string NMD::SWC2(uint64 instruction)
 std::string NMD::SWE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -15487,7 +15487,7 @@ std::string NMD::SWM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -15512,7 +15512,7 @@ std::string NMD::SWM(uint64 instruction)
 std::string NMD::SWPC_48_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_41_40_39_38_37(instruction);
-    int64 s_value = extr_sil0il16bs16_il16il0bs16Tmsb31(instruction);
+    int64 s_value = extract_s__se31_15_to_0_31_to_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 6);
@@ -15601,7 +15601,7 @@ std::string NMD::SYNC(uint64 instruction)
  */
 std::string NMD::SYNCI(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string s = IMMEDIATE(copy(s_value));
@@ -15623,7 +15623,7 @@ std::string NMD::SYNCI(uint64 instruction)
  */
 std::string NMD::SYNCIE(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string s = IMMEDIATE(copy(s_value));
@@ -16033,7 +16033,7 @@ std::string NMD::UALDM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -16058,7 +16058,7 @@ std::string NMD::UALDM(uint64 instruction)
 std::string NMD::UALH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -16083,7 +16083,7 @@ std::string NMD::UALWM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -16109,7 +16109,7 @@ std::string NMD::UASDM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -16134,7 +16134,7 @@ std::string NMD::UASDM(uint64 instruction)
 std::string NMD::UASH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
@@ -16159,7 +16159,7 @@ std::string NMD::UASWM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 count3_value = extract_count3_14_13_12(instruction);
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
+    int64 s_value = extract_s__se8_15_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index cf15625..86f673c 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -143,20 +143,20 @@ private:
     std::string CPR(uint64 reg);
     std::string ADDRESS(uint64 value, int instruction_size);
 
-    int64 extract_s_4_2_1_0(uint64 instruction);
-    int64 extr_sil0il0bs8_il15il8bs1Tmsb8(uint64 instruction);
-    int64 extr_sil0il10bs1_il1il1bs9Tmsb10(uint64 instruction);
-    int64 extr_sil0il11bs1_il1il1bs10Tmsb11(uint64 instruction);
-    int64 extr_sil0il14bs1_il1il1bs13Tmsb14(uint64 instruction);
-    int64 extr_sil0il16bs16_il16il0bs16Tmsb31(uint64 instruction);
-    int64 extr_sil0il21bs1_il1il1bs20Tmsb21(uint64 instruction);
-    int64 extr_sil0il25bs1_il1il1bs24Tmsb25(uint64 instruction);
-    int64 extr_sil0il31bs1_il2il21bs10_il12il12bs9Tmsb31(uint64 instruction);
-    int64 extr_sil0il7bs1_il1il1bs6Tmsb7(uint64 instruction);
-    int64 extr_sil11il0bs10Tmsb9(uint64 instruction);
-    int64 extract_shift_21_20_19_18_17_16(uint64 instruction);
-    int64 extr_sil2il2bs6_il15il8bs1Tmsb8(uint64 instruction);
-    int64 extr_sil3il3bs5_il15il8bs1Tmsb8(uint64 instruction);
+    int64 extract_s__se3_4_2_1_0(uint64 instruction);
+    int64 extract_s__se7_0_6_5_4_3_2_1_s1(uint64 instruction);
+    int64 extract_s__se8_15_7_6_5_4_3_s3(uint64 instruction);
+    int64 extract_s__se8_15_7_6_5_4_3_2_s2(uint64 instruction);
+    int64 extract_s__se8_15_7_6_5_4_3_2_1_0(uint64 instruction);
+    int64 extract_s__se9_20_19_18_17_16_15_14_13_12_11(uint64 instruction);
+    int64 extract_s__se10_0_9_8_7_6_5_4_3_2_1_s1(uint64 instruction);
+    int64 extract_s__se11_0_10_9_8_7_6_5_4_3_2_1_0_s1(uint64 instruction);
+    int64 extract_s__se14_0_13_to_1_s1(uint64 instruction);
+    int64 extract_s__se21_0_20_to_1_s1(uint64 instruction);
+    int64 extract_s__se25_0_24_to_1_s1(uint64 instruction);
+    int64 extract_s__se31_15_to_0_31_to_16(uint64 instruction);
+    int64 extract_s__se31_0_11_to_2_20_to_12_s12(uint64 instruction);
+    int64 extract_shift__se5_21_20_19_18_17_16(uint64 instruction);
 
     uint64 extract_ac_13_12(uint64 instruction);
     uint64 extract_bit_16_15_14_13_12_11(uint64 instruction);
-- 
2.7.4
