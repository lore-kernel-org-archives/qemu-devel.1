Received: from eggs.gnu.org ([208.118.235.92]:48019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoPH-0000q6-Pe
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoPB-0003Hq-HM
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:15 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49212 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcoPB-00034p-3W
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:09 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 28 Dec 2018 10:25:20 +0100
Message-Id: <1545989148-13582-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 13/41] disas: nanoMIPS: Remove functions that
 are not used
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

Some functions were not used at all. Compiler doesn't complain
since they are class memebers. Remove them - no future usage is
planned.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 208 -----------------------------------------------------
 disas/nanomips.h   |  25 -------
 2 files changed, 233 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index e082a3f..4784530 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -856,23 +856,6 @@ uint64 NMD::extract_stripe_6(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil17il0bs1Fmsb0(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 17, 1);
-    return value;
-}
-
-
-uint64 NMD::extr_xil2il0bs1_il15il0bs1Fmsb0(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 2, 1);
-    value |= extract_bits(instruction, 15, 1);
-    return value;
-}
-
-
 uint64 NMD::extract_ac_13_12(uint64 instruction)
 {
     uint64 value = 0;
@@ -923,14 +906,6 @@ uint64 NMD::extract_shift_5_4_3_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil10il0bs6Fmsb5(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 10, 6);
-    return value;
-}
-
-
 uint64 NMD::extract_count_19_18_17_16(uint64 instruction)
 {
     uint64 value = 0;
@@ -947,15 +922,6 @@ uint64 NMD::extract_code_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil10il0bs4_il22il0bs4Fmsb3(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 10, 4);
-    value |= extract_bits(instruction, 22, 4);
-    return value;
-}
-
-
 uint64 NMD::extract_u_11_10_9_8_7_6_5_4_3_2_1_0(uint64 instruction)
 {
     uint64 value = 0;
@@ -980,14 +946,6 @@ uint64 NMD::extr_uil3il3bs18Fmsb20(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil12il0bs1Fmsb0(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 12, 1);
-    return value;
-}
-
-
 uint64 NMD::extr_uil0il2bs4Fmsb5(uint64 instruction)
 {
     uint64 value = 0;
@@ -1012,14 +970,6 @@ uint64 NMD::extr_uil0il2bs3Fmsb4(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil10il0bs1Fmsb0(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 10, 1);
-    return value;
-}
-
-
 uint64 NMD::extract_rd3_3_2_1(uint64 instruction)
 {
     uint64 value = 0;
@@ -1052,22 +1002,6 @@ uint64 NMD::extract_ru_7_6_5_4_3(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil21il0bs5Fmsb4(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 21, 5);
-    return value;
-}
-
-
-uint64 NMD::extr_xil9il0bs3Fmsb2(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 9, 3);
-    return value;
-}
-
-
 uint64 NMD::extract_u_17_to_0(uint64 instruction)
 {
     uint64 value = 0;
@@ -1076,15 +1010,6 @@ uint64 NMD::extract_u_17_to_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil14il0bs1_il15il0bs1Fmsb0(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 14, 1);
-    value |= extract_bits(instruction, 15, 1);
-    return value;
-}
-
-
 uint64 NMD::extract_rsz4_4_2_1_0(uint64 instruction)
 {
     uint64 value = 0;
@@ -1094,14 +1019,6 @@ uint64 NMD::extract_rsz4_4_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil24il0bs1Fmsb0(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 24, 1);
-    return value;
-}
-
-
 int64 NMD::extr_sil0il21bs1_il1il1bs20Tmsb21(uint64 instruction)
 {
     int64 value = 0;
@@ -1154,15 +1071,6 @@ int64 NMD::extract_shift_21_20_19_18_17_16(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil6il0bs3_il10il0bs1Fmsb2(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 6, 3);
-    value |= extract_bits(instruction, 10, 1);
-    return value;
-}
-
-
 uint64 NMD::extract_rd2_3_8(uint64 instruction)
 {
     uint64 value = 0;
@@ -1172,14 +1080,6 @@ uint64 NMD::extract_rd2_3_8(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil16il0bs5Fmsb4(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 16, 5);
-    return value;
-}
-
-
 uint64 NMD::extract_code_17_to_0(uint64 instruction)
 {
     uint64 value = 0;
@@ -1188,14 +1088,6 @@ uint64 NMD::extract_code_17_to_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil0il0bs12Fmsb11(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 0, 12);
-    return value;
-}
-
-
 uint64 NMD::extract_size_20_19_18_17_16(uint64 instruction)
 {
     uint64 value = 0;
@@ -1264,15 +1156,6 @@ uint64 NMD::extract_hs_20_19_18_17_16(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil10il0bs1_il14il0bs2Fmsb1(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 10, 1);
-    value |= extract_bits(instruction, 14, 2);
-    return value;
-}
-
-
 uint64 NMD::extract_sel_13_12_11(uint64 instruction)
 {
     uint64 value = 0;
@@ -1289,14 +1172,6 @@ uint64 NMD::extract_lsb_4_3_2_1_0(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil14il0bs2Fmsb1(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 14, 2);
-    return value;
-}
-
-
 uint64 NMD::extract_gp_2(uint64 instruction)
 {
     uint64 value = 0;
@@ -1337,14 +1212,6 @@ uint64 NMD::extract_cs_20_19_18_17_16(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil16il0bs10Fmsb9(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 16, 10);
-    return value;
-}
-
-
 uint64 NMD::extract_rt4_9_7_6_5(uint64 instruction)
 {
     uint64 value = 0;
@@ -1370,14 +1237,6 @@ uint64 NMD::extr_uil0il2bs6Fmsb7(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil17il0bs9Fmsb8(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 17, 9);
-    return value;
-}
-
-
 uint64 NMD::extract_sa_15_14_13(uint64 instruction)
 {
     uint64 value = 0;
@@ -1468,15 +1327,6 @@ uint64 NMD::extract_bit_16_15_14_13_12_11(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil10il0bs1_il11il0bs5Fmsb4(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 10, 1);
-    value |= extract_bits(instruction, 11, 5);
-    return value;
-}
-
-
 uint64 NMD::extract_mask_20_19_18_17_16_15_14(uint64 instruction)
 {
     uint64 value = 0;
@@ -1537,22 +1387,6 @@ uint64 NMD::extract_u_20_19_18_17_16_15_14_13(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil15il0bs1Fmsb0(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 15, 1);
-    return value;
-}
-
-
-uint64 NMD::extr_xil11il0bs5Fmsb4(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 11, 5);
-    return value;
-}
-
-
 uint64 NMD::extr_uil2il2bs16Fmsb17(uint64 instruction)
 {
     uint64 value = 0;
@@ -1595,15 +1429,6 @@ int64 NMD::extr_sil0il25bs1_il1il1bs24Tmsb25(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil0il0bs3_il4il0bs1Fmsb2(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 0, 3);
-    value |= extract_bits(instruction, 4, 1);
-    return value;
-}
-
-
 uint64 NMD::extract_u_1_0(uint64 instruction)
 {
     uint64 value = 0;
@@ -1621,15 +1446,6 @@ uint64 NMD::extr_uil3il3bs1_il8il2bs1Fmsb3(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil9il0bs3_il16il0bs5Fmsb4(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 9, 3);
-    value |= extract_bits(instruction, 16, 5);
-    return value;
-}
-
-
 uint64 NMD::extract_fd_10_9_8_7_6(uint64 instruction)
 {
     uint64 value = 0;
@@ -1638,14 +1454,6 @@ uint64 NMD::extract_fd_10_9_8_7_6(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil6il0bs3Fmsb2(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 6, 3);
-    return value;
-}
-
-
 uint64 NMD::extr_uil0il2bs5Fmsb6(uint64 instruction)
 {
     uint64 value = 0;
@@ -1679,14 +1487,6 @@ uint64 NMD::extract_ct_25_24_23_22_21(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil11il0bs1Fmsb0(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 11, 1);
-    return value;
-}
-
-
 uint64 NMD::extr_uil2il2bs19Fmsb20(uint64 instruction)
 {
     uint64 value = 0;
@@ -1713,14 +1513,6 @@ uint64 NMD::extr_uil0il1bs4Fmsb4(uint64 instruction)
 }
 
 
-uint64 NMD::extr_xil9il0bs2Fmsb1(uint64 instruction)
-{
-    uint64 value = 0;
-    value |= extract_bits(instruction, 9, 2);
-    return value;
-}
-
-
 
 bool NMD::ADDIU_32__cond(uint64 instruction)
 {
diff --git a/disas/nanomips.h b/disas/nanomips.h
index c7477c2..4defd35 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -245,31 +245,6 @@ private:
     uint64 extr_uil3il3bs1_il8il2bs1Fmsb3(uint64 instruction);
     uint64 extr_uil3il3bs9Fmsb11(uint64 instruction);
     uint64 extr_uil4il4bs4Fmsb7(uint64 instruction);
-    uint64 extr_xil0il0bs12Fmsb11(uint64 instruction);
-    uint64 extr_xil0il0bs3_il4il0bs1Fmsb2(uint64 instruction);
-    uint64 extr_xil10il0bs1Fmsb0(uint64 instruction);
-    uint64 extr_xil10il0bs1_il11il0bs5Fmsb4(uint64 instruction);
-    uint64 extr_xil10il0bs1_il14il0bs2Fmsb1(uint64 instruction);
-    uint64 extr_xil10il0bs4_il22il0bs4Fmsb3(uint64 instruction);
-    uint64 extr_xil10il0bs6Fmsb5(uint64 instruction);
-    uint64 extr_xil11il0bs1Fmsb0(uint64 instruction);
-    uint64 extr_xil11il0bs5Fmsb4(uint64 instruction);
-    uint64 extr_xil12il0bs1Fmsb0(uint64 instruction);
-    uint64 extr_xil14il0bs1_il15il0bs1Fmsb0(uint64 instruction);
-    uint64 extr_xil14il0bs2Fmsb1(uint64 instruction);
-    uint64 extr_xil15il0bs1Fmsb0(uint64 instruction);
-    uint64 extr_xil16il0bs10Fmsb9(uint64 instruction);
-    uint64 extr_xil16il0bs5Fmsb4(uint64 instruction);
-    uint64 extr_xil17il0bs1Fmsb0(uint64 instruction);
-    uint64 extr_xil17il0bs9Fmsb8(uint64 instruction);
-    uint64 extr_xil21il0bs5Fmsb4(uint64 instruction);
-    uint64 extr_xil24il0bs1Fmsb0(uint64 instruction);
-    uint64 extr_xil2il0bs1_il15il0bs1Fmsb0(uint64 instruction);
-    uint64 extr_xil6il0bs3Fmsb2(uint64 instruction);
-    uint64 extr_xil6il0bs3_il10il0bs1Fmsb2(uint64 instruction);
-    uint64 extr_xil9il0bs2Fmsb1(uint64 instruction);
-    uint64 extr_xil9il0bs3Fmsb2(uint64 instruction);
-    uint64 extr_xil9il0bs3_il16il0bs5Fmsb4(uint64 instruction);
 
     bool ADDIU_32__cond(uint64 instruction);
     bool ADDIU_RS5__cond(uint64 instruction);
-- 
2.7.4
