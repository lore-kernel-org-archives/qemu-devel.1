Received: from eggs.gnu.org ([208.118.235.92]:52359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcon1-00088D-7j
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoPD-0003KG-MT
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:34 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49273 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcoPC-00036p-Nt
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 28 Dec 2018 10:25:26 +0100
Message-Id: <1545989148-13582-20-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 19/41] disas: nanoMIPS: Fix an FP-related
 misnomer 3
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

Rename NMD::extract_ft_20_19_18_17_16(uint64 instruction) to
NMD::extract_ft_25_24_23_22_21(uint64 instruction).

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 258 ++++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |   2 +-
 2 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index b9ad0f7..69b6e99 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1188,7 +1188,7 @@ uint64 NMD::extract_rt3_9_8_7(uint64 instruction)
 }
 
 
-uint64 NMD::extract_ft_20_19_18_17_16(uint64 instruction)
+uint64 NMD::extract_ft_25_24_23_22_21(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 21, 5);
@@ -1601,7 +1601,7 @@ bool NMD::SLTU_cond(uint64 instruction)
  */
 std::string NMD::ABS_D(uint64 instruction)
 {
-    uint64 fd_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fd_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string fs = FPR(copy(fs_value));
@@ -1623,7 +1623,7 @@ std::string NMD::ABS_D(uint64 instruction)
  */
 std::string NMD::ABS_S(uint64 instruction)
 {
-    uint64 fd_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fd_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string fs = FPR(copy(fs_value));
@@ -1755,7 +1755,7 @@ std::string NMD::ADD(uint64 instruction)
  */
 std::string NMD::ADD_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -1780,7 +1780,7 @@ std::string NMD::ADD_D(uint64 instruction)
  */
 std::string NMD::ADD_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -2787,7 +2787,7 @@ std::string NMD::BC_32_(uint64 instruction)
 std::string NMD::BC1EQZC(uint64 instruction)
 {
     int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
@@ -2809,7 +2809,7 @@ std::string NMD::BC1EQZC(uint64 instruction)
 std::string NMD::BC1NEZC(uint64 instruction)
 {
     int64 s_value = extr_sil0il14bs1_il1il1bs13Tmsb14(instruction);
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
@@ -3382,7 +3382,7 @@ std::string NMD::CACHEE(uint64 instruction)
  */
 std::string NMD::CEIL_L_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -3404,7 +3404,7 @@ std::string NMD::CEIL_L_D(uint64 instruction)
  */
 std::string NMD::CEIL_L_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -3426,7 +3426,7 @@ std::string NMD::CEIL_L_S(uint64 instruction)
  */
 std::string NMD::CEIL_W_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -3448,7 +3448,7 @@ std::string NMD::CEIL_W_D(uint64 instruction)
  */
 std::string NMD::CEIL_W_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -3514,7 +3514,7 @@ std::string NMD::CFC2(uint64 instruction)
  */
 std::string NMD::CLASS_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -3536,7 +3536,7 @@ std::string NMD::CLASS_D(uint64 instruction)
  */
 std::string NMD::CLASS_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -3602,7 +3602,7 @@ std::string NMD::CLZ(uint64 instruction)
  */
 std::string NMD::CMP_AF_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3626,7 +3626,7 @@ std::string NMD::CMP_AF_D(uint64 instruction)
  */
 std::string NMD::CMP_AF_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3650,7 +3650,7 @@ std::string NMD::CMP_AF_S(uint64 instruction)
  */
 std::string NMD::CMP_EQ_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3696,7 +3696,7 @@ std::string NMD::CMP_EQ_PH(uint64 instruction)
  */
 std::string NMD::CMP_EQ_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3720,7 +3720,7 @@ std::string NMD::CMP_EQ_S(uint64 instruction)
  */
 std::string NMD::CMP_LE_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3766,7 +3766,7 @@ std::string NMD::CMP_LE_PH(uint64 instruction)
  */
 std::string NMD::CMP_LE_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3790,7 +3790,7 @@ std::string NMD::CMP_LE_S(uint64 instruction)
  */
 std::string NMD::CMP_LT_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3836,7 +3836,7 @@ std::string NMD::CMP_LT_PH(uint64 instruction)
  */
 std::string NMD::CMP_LT_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3860,7 +3860,7 @@ std::string NMD::CMP_LT_S(uint64 instruction)
  */
 std::string NMD::CMP_NE_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3884,7 +3884,7 @@ std::string NMD::CMP_NE_D(uint64 instruction)
  */
 std::string NMD::CMP_NE_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3908,7 +3908,7 @@ std::string NMD::CMP_NE_S(uint64 instruction)
  */
 std::string NMD::CMP_OR_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3932,7 +3932,7 @@ std::string NMD::CMP_OR_D(uint64 instruction)
  */
 std::string NMD::CMP_OR_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3956,7 +3956,7 @@ std::string NMD::CMP_OR_S(uint64 instruction)
  */
 std::string NMD::CMP_SAF_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -3980,7 +3980,7 @@ std::string NMD::CMP_SAF_D(uint64 instruction)
  */
 std::string NMD::CMP_SAF_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4004,7 +4004,7 @@ std::string NMD::CMP_SAF_S(uint64 instruction)
  */
 std::string NMD::CMP_SEQ_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4028,7 +4028,7 @@ std::string NMD::CMP_SEQ_D(uint64 instruction)
  */
 std::string NMD::CMP_SEQ_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4052,7 +4052,7 @@ std::string NMD::CMP_SEQ_S(uint64 instruction)
  */
 std::string NMD::CMP_SLE_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4076,7 +4076,7 @@ std::string NMD::CMP_SLE_D(uint64 instruction)
  */
 std::string NMD::CMP_SLE_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4100,7 +4100,7 @@ std::string NMD::CMP_SLE_S(uint64 instruction)
  */
 std::string NMD::CMP_SLT_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4124,7 +4124,7 @@ std::string NMD::CMP_SLT_D(uint64 instruction)
  */
 std::string NMD::CMP_SLT_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4148,7 +4148,7 @@ std::string NMD::CMP_SLT_S(uint64 instruction)
  */
 std::string NMD::CMP_SNE_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4172,7 +4172,7 @@ std::string NMD::CMP_SNE_D(uint64 instruction)
  */
 std::string NMD::CMP_SNE_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4196,7 +4196,7 @@ std::string NMD::CMP_SNE_S(uint64 instruction)
  */
 std::string NMD::CMP_SOR_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4220,7 +4220,7 @@ std::string NMD::CMP_SOR_D(uint64 instruction)
  */
 std::string NMD::CMP_SOR_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4244,7 +4244,7 @@ std::string NMD::CMP_SOR_S(uint64 instruction)
  */
 std::string NMD::CMP_SUEQ_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4268,7 +4268,7 @@ std::string NMD::CMP_SUEQ_D(uint64 instruction)
  */
 std::string NMD::CMP_SUEQ_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4292,7 +4292,7 @@ std::string NMD::CMP_SUEQ_S(uint64 instruction)
  */
 std::string NMD::CMP_SULE_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4316,7 +4316,7 @@ std::string NMD::CMP_SULE_D(uint64 instruction)
  */
 std::string NMD::CMP_SULE_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4340,7 +4340,7 @@ std::string NMD::CMP_SULE_S(uint64 instruction)
  */
 std::string NMD::CMP_SULT_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4364,7 +4364,7 @@ std::string NMD::CMP_SULT_D(uint64 instruction)
  */
 std::string NMD::CMP_SULT_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4388,7 +4388,7 @@ std::string NMD::CMP_SULT_S(uint64 instruction)
  */
 std::string NMD::CMP_SUN_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4412,7 +4412,7 @@ std::string NMD::CMP_SUN_D(uint64 instruction)
  */
 std::string NMD::CMP_SUNE_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4436,7 +4436,7 @@ std::string NMD::CMP_SUNE_D(uint64 instruction)
  */
 std::string NMD::CMP_SUNE_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4460,7 +4460,7 @@ std::string NMD::CMP_SUNE_S(uint64 instruction)
  */
 std::string NMD::CMP_SUN_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4484,7 +4484,7 @@ std::string NMD::CMP_SUN_S(uint64 instruction)
  */
 std::string NMD::CMP_UEQ_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4508,7 +4508,7 @@ std::string NMD::CMP_UEQ_D(uint64 instruction)
  */
 std::string NMD::CMP_UEQ_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4532,7 +4532,7 @@ std::string NMD::CMP_UEQ_S(uint64 instruction)
  */
 std::string NMD::CMP_ULE_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4556,7 +4556,7 @@ std::string NMD::CMP_ULE_D(uint64 instruction)
  */
 std::string NMD::CMP_ULE_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4580,7 +4580,7 @@ std::string NMD::CMP_ULE_S(uint64 instruction)
  */
 std::string NMD::CMP_ULT_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4604,7 +4604,7 @@ std::string NMD::CMP_ULT_D(uint64 instruction)
  */
 std::string NMD::CMP_ULT_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4628,7 +4628,7 @@ std::string NMD::CMP_ULT_S(uint64 instruction)
  */
 std::string NMD::CMP_UN_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4652,7 +4652,7 @@ std::string NMD::CMP_UN_D(uint64 instruction)
  */
 std::string NMD::CMP_UNE_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4676,7 +4676,7 @@ std::string NMD::CMP_UNE_D(uint64 instruction)
  */
 std::string NMD::CMP_UNE_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4700,7 +4700,7 @@ std::string NMD::CMP_UNE_S(uint64 instruction)
  */
 std::string NMD::CMP_UN_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -4998,7 +4998,7 @@ std::string NMD::CTC2(uint64 instruction)
  */
 std::string NMD::CVT_D_L(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5020,7 +5020,7 @@ std::string NMD::CVT_D_L(uint64 instruction)
  */
 std::string NMD::CVT_D_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5042,7 +5042,7 @@ std::string NMD::CVT_D_S(uint64 instruction)
  */
 std::string NMD::CVT_D_W(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5064,7 +5064,7 @@ std::string NMD::CVT_D_W(uint64 instruction)
  */
 std::string NMD::CVT_L_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5086,7 +5086,7 @@ std::string NMD::CVT_L_D(uint64 instruction)
  */
 std::string NMD::CVT_L_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5108,7 +5108,7 @@ std::string NMD::CVT_L_S(uint64 instruction)
  */
 std::string NMD::CVT_S_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5130,7 +5130,7 @@ std::string NMD::CVT_S_D(uint64 instruction)
  */
 std::string NMD::CVT_S_L(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5152,7 +5152,7 @@ std::string NMD::CVT_S_L(uint64 instruction)
  */
 std::string NMD::CVT_S_PL(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5174,7 +5174,7 @@ std::string NMD::CVT_S_PL(uint64 instruction)
  */
 std::string NMD::CVT_S_PU(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5196,7 +5196,7 @@ std::string NMD::CVT_S_PU(uint64 instruction)
  */
 std::string NMD::CVT_S_W(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5218,7 +5218,7 @@ std::string NMD::CVT_S_W(uint64 instruction)
  */
 std::string NMD::CVT_W_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5240,7 +5240,7 @@ std::string NMD::CVT_W_D(uint64 instruction)
  */
 std::string NMD::CVT_W_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -5696,7 +5696,7 @@ std::string NMD::DIV(uint64 instruction)
  */
 std::string NMD::DIV_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -5720,7 +5720,7 @@ std::string NMD::DIV_D(uint64 instruction)
  */
 std::string NMD::DIV_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -7477,7 +7477,7 @@ std::string NMD::EXTW(uint64 instruction)
  */
 std::string NMD::FLOOR_L_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -7499,7 +7499,7 @@ std::string NMD::FLOOR_L_D(uint64 instruction)
  */
 std::string NMD::FLOOR_L_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -7521,7 +7521,7 @@ std::string NMD::FLOOR_L_S(uint64 instruction)
  */
 std::string NMD::FLOOR_W_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -7543,7 +7543,7 @@ std::string NMD::FLOOR_W_D(uint64 instruction)
  */
 std::string NMD::FLOOR_W_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -8135,7 +8135,7 @@ std::string NMD::LD_U12_(uint64 instruction)
  */
 std::string NMD::LDC1_GP_(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -8158,7 +8158,7 @@ std::string NMD::LDC1_GP_(uint64 instruction)
 std::string NMD::LDC1_S9_(uint64 instruction)
 {
     int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -8181,7 +8181,7 @@ std::string NMD::LDC1_S9_(uint64 instruction)
  */
 std::string NMD::LDC1_U12_(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -9103,7 +9103,7 @@ std::string NMD::LW_U12_(uint64 instruction)
  */
 std::string NMD::LWC1_GP_(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -9126,7 +9126,7 @@ std::string NMD::LWC1_GP_(uint64 instruction)
 std::string NMD::LWC1_S9_(uint64 instruction)
 {
     int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -9149,7 +9149,7 @@ std::string NMD::LWC1_S9_(uint64 instruction)
  */
 std::string NMD::LWC1_U12_(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -9531,7 +9531,7 @@ std::string NMD::MADD_DSP_(uint64 instruction)
  */
 std::string NMD::MADDF_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -9555,7 +9555,7 @@ std::string NMD::MADDF_D(uint64 instruction)
  */
 std::string NMD::MADDF_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -9699,7 +9699,7 @@ std::string NMD::MAQ_SA_W_PHR(uint64 instruction)
  */
 std::string NMD::MAX_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -9723,7 +9723,7 @@ std::string NMD::MAX_D(uint64 instruction)
  */
 std::string NMD::MAX_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -9747,7 +9747,7 @@ std::string NMD::MAX_S(uint64 instruction)
  */
 std::string NMD::MAXA_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -9771,7 +9771,7 @@ std::string NMD::MAXA_D(uint64 instruction)
  */
 std::string NMD::MAXA_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -10075,7 +10075,7 @@ std::string NMD::MFTR(uint64 instruction)
  */
 std::string NMD::MIN_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -10099,7 +10099,7 @@ std::string NMD::MIN_D(uint64 instruction)
  */
 std::string NMD::MIN_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -10123,7 +10123,7 @@ std::string NMD::MIN_S(uint64 instruction)
  */
 std::string NMD::MINA_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -10147,7 +10147,7 @@ std::string NMD::MINA_D(uint64 instruction)
  */
 std::string NMD::MINA_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -10243,7 +10243,7 @@ std::string NMD::MODU(uint64 instruction)
  */
 std::string NMD::MOV_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -10265,7 +10265,7 @@ std::string NMD::MOV_D(uint64 instruction)
  */
 std::string NMD::MOV_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -10459,7 +10459,7 @@ std::string NMD::MSUB_DSP_(uint64 instruction)
  */
 std::string NMD::MSUBF_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -10483,7 +10483,7 @@ std::string NMD::MSUBF_D(uint64 instruction)
  */
 std::string NMD::MSUBF_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -10927,7 +10927,7 @@ std::string NMD::MUL_4X4_(uint64 instruction)
  */
 std::string NMD::MUL_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -10999,7 +10999,7 @@ std::string NMD::MUL_S_PH(uint64 instruction)
  */
 std::string NMD::MUL_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -11335,7 +11335,7 @@ std::string NMD::MULU(uint64 instruction)
  */
 std::string NMD::NEG_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -11357,7 +11357,7 @@ std::string NMD::NEG_D(uint64 instruction)
  */
 std::string NMD::NEG_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -12195,7 +12195,7 @@ std::string NMD::RDPGPR(uint64 instruction)
  */
 std::string NMD::RECIP_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -12217,7 +12217,7 @@ std::string NMD::RECIP_D(uint64 instruction)
  */
 std::string NMD::RECIP_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -12417,7 +12417,7 @@ std::string NMD::RESTOREF(uint64 instruction)
  */
 std::string NMD::RINT_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -12439,7 +12439,7 @@ std::string NMD::RINT_D(uint64 instruction)
  */
 std::string NMD::RINT_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -12538,7 +12538,7 @@ std::string NMD::ROTX(uint64 instruction)
  */
 std::string NMD::ROUND_L_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -12560,7 +12560,7 @@ std::string NMD::ROUND_L_D(uint64 instruction)
  */
 std::string NMD::ROUND_L_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -12582,7 +12582,7 @@ std::string NMD::ROUND_L_S(uint64 instruction)
  */
 std::string NMD::ROUND_W_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -12604,7 +12604,7 @@ std::string NMD::ROUND_W_D(uint64 instruction)
  */
 std::string NMD::ROUND_W_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -12626,7 +12626,7 @@ std::string NMD::ROUND_W_S(uint64 instruction)
  */
 std::string NMD::RSQRT_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -12648,7 +12648,7 @@ std::string NMD::RSQRT_D(uint64 instruction)
  */
 std::string NMD::RSQRT_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -13133,7 +13133,7 @@ std::string NMD::SDBBP_32_(uint64 instruction)
  */
 std::string NMD::SDC1_GP_(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -13156,7 +13156,7 @@ std::string NMD::SDC1_GP_(uint64 instruction)
 std::string NMD::SDC1_S9_(uint64 instruction)
 {
     int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -13179,7 +13179,7 @@ std::string NMD::SDC1_S9_(uint64 instruction)
  */
 std::string NMD::SDC1_U12_(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -13415,7 +13415,7 @@ std::string NMD::SEH(uint64 instruction)
  */
 std::string NMD::SEL_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -13439,7 +13439,7 @@ std::string NMD::SEL_D(uint64 instruction)
  */
 std::string NMD::SEL_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -13463,7 +13463,7 @@ std::string NMD::SEL_S(uint64 instruction)
  */
 std::string NMD::SELEQZ_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -13487,7 +13487,7 @@ std::string NMD::SELEQZ_D(uint64 instruction)
  */
 std::string NMD::SELEQZ_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -13511,7 +13511,7 @@ std::string NMD::SELEQZ_S(uint64 instruction)
  */
 std::string NMD::SELNEZ_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -13535,7 +13535,7 @@ std::string NMD::SELNEZ_D(uint64 instruction)
  */
 std::string NMD::SELNEZ_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -14553,7 +14553,7 @@ std::string NMD::SPECIAL2(uint64 instruction)
  */
 std::string NMD::SQRT_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -14575,7 +14575,7 @@ std::string NMD::SQRT_D(uint64 instruction)
  */
 std::string NMD::SQRT_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -14741,7 +14741,7 @@ std::string NMD::SUB(uint64 instruction)
  */
 std::string NMD::SUB_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -14765,7 +14765,7 @@ std::string NMD::SUB_D(uint64 instruction)
  */
 std::string NMD::SUB_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
@@ -15319,7 +15319,7 @@ std::string NMD::SW_U12_(uint64 instruction)
  */
 std::string NMD::SWC1_GP_(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 u_value = extract_u_17_to_2__s2(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -15342,7 +15342,7 @@ std::string NMD::SWC1_GP_(uint64 instruction)
 std::string NMD::SWC1_S9_(uint64 instruction)
 {
     int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -15365,7 +15365,7 @@ std::string NMD::SWC1_S9_(uint64 instruction)
  */
 std::string NMD::SWC1_U12_(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
@@ -15943,7 +15943,7 @@ std::string NMD::TNE(uint64 instruction)
  */
 std::string NMD::TRUNC_L_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -15965,7 +15965,7 @@ std::string NMD::TRUNC_L_D(uint64 instruction)
  */
 std::string NMD::TRUNC_L_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -15987,7 +15987,7 @@ std::string NMD::TRUNC_L_S(uint64 instruction)
  */
 std::string NMD::TRUNC_W_D(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -16009,7 +16009,7 @@ std::string NMD::TRUNC_W_D(uint64 instruction)
  */
 std::string NMD::TRUNC_W_S(uint64 instruction)
 {
-    uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 ft_value = extract_ft_25_24_23_22_21(instruction);
     uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index fad70d2..cf15625 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -179,7 +179,7 @@ private:
     uint64 extract_fd_15_14_13_12_11(uint64 instruction);
     uint64 extract_fs_20_19_18_17_16(uint64 instruction);
     uint64 extract_ft_15_14_13_12_11(uint64 instruction);
-    uint64 extract_ft_20_19_18_17_16(uint64 instruction);
+    uint64 extract_ft_25_24_23_22_21(uint64 instruction);
     uint64 extract_gp_2(uint64 instruction);
     uint64 extract_hint_25_24_23_22_21(uint64 instruction);
     uint64 extract_hs_20_19_18_17_16(uint64 instruction);
-- 
2.7.4
