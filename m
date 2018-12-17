Received: from eggs.gnu.org ([2001:4830:134:3::10]:48500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYvXv-00046d-2n
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYvXr-00045r-Ux
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:06 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36752 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gYvXo-0003Uw-J5
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:01 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 17 Dec 2018 17:13:44 +0100
Message-Id: <20181217161347.4270-3-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181217161347.4270-1-aleksandar.markovic@rt-rk.com>
References: <20181217161347.4270-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/5] disas: nanoMIPS: Remove functions that are
 not used
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

Some functions were not used at all. Compiler doesn't complain
since they are class memebers. Remove them - no future usage is
planned.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 208 ---------------------------------------------
 disas/nanomips.h   |  25 ------
 2 files changed, 233 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index f9ef0a25f4..935c2dee3c 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -852,23 +852,6 @@ uint64 NMD::extract_stripe_6(uint64 instruction)
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
@@ -919,14 +902,6 @@ uint64 NMD::extract_shift_5_4_3_2_1_0(uint64 instruction)
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
@@ -943,15 +918,6 @@ uint64 NMD::extract_code_2_1_0(uint64 instruction)
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
@@ -976,14 +942,6 @@ uint64 NMD::extr_uil3il3bs18Fmsb20(uint64 instruction)
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
@@ -1008,14 +966,6 @@ uint64 NMD::extr_uil0il2bs3Fmsb4(uint64 instruction)
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
@@ -1048,22 +998,6 @@ uint64 NMD::extract_ru_7_6_5_4_3(uint64 instruction)
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
@@ -1072,15 +1006,6 @@ uint64 NMD::extract_u_17_to_0(uint64 instruction)
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
@@ -1090,14 +1015,6 @@ uint64 NMD::extract_rsz4_4_2_1_0(uint64 instruction)
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
@@ -1150,15 +1067,6 @@ int64 NMD::extract_shift_21_20_19_18_17_16(uint64 instruction)
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
@@ -1168,14 +1076,6 @@ uint64 NMD::extract_rd2_3_8(uint64 instruction)
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
@@ -1184,14 +1084,6 @@ uint64 NMD::extract_code_17_to_0(uint64 instruction)
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
@@ -1260,15 +1152,6 @@ uint64 NMD::extract_hs_20_19_18_17_16(uint64 instruction)
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
@@ -1285,14 +1168,6 @@ uint64 NMD::extract_lsb_4_3_2_1_0(uint64 instruction)
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
@@ -1333,14 +1208,6 @@ uint64 NMD::extract_cs_20_19_18_17_16(uint64 instruction)
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
@@ -1366,14 +1233,6 @@ uint64 NMD::extr_uil0il2bs6Fmsb7(uint64 instruction)
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
@@ -1464,15 +1323,6 @@ uint64 NMD::extract_bit_16_15_14_13_12_11(uint64 instruction)
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
@@ -1533,22 +1383,6 @@ uint64 NMD::extract_u_20_19_18_17_16_15_14_13(uint64 instruction)
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
@@ -1591,15 +1425,6 @@ int64 NMD::extr_sil0il25bs1_il1il1bs24Tmsb25(uint64 instruction)
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
@@ -1617,15 +1442,6 @@ uint64 NMD::extr_uil3il3bs1_il8il2bs1Fmsb3(uint64 instruction)
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
@@ -1634,14 +1450,6 @@ uint64 NMD::extract_fd_10_9_8_7_6(uint64 instruction)
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
@@ -1675,14 +1483,6 @@ uint64 NMD::extract_ct_25_24_23_22_21(uint64 instruction)
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
@@ -1709,14 +1509,6 @@ uint64 NMD::extr_uil0il1bs4Fmsb4(uint64 instruction)
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
index 3df138d63f..611eeebaae 100644
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
2.17.1
