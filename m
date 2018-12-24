Received: from eggs.gnu.org ([208.118.235.92]:44937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gbTui-0003xe-6H
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 12:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gbTub-000432-Dx
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 12:21:12 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:58086 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gbTua-00040n-9a
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 12:21:05 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 24 Dec 2018 18:19:32 +0100
Message-Id: <1545671976-13630-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545671976-13630-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545671976-13630-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 07/11] disas: nanoMIPS: Fix an FP-related
 misnomer 2
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

-uint64 NMD::extract_fs_15_14_13_12_11(uint64 instruction)
+uint64 NMD::extract_fs_20_19_18_17_16(uint64 instruction)

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 242 ++++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |   2 +-
 2 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 9682725..8f6db93 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1110,7 +1110,7 @@ uint64 NMD::extract_u_15_to_0(uint64 instruction)
 }
 
 
-uint64 NMD::extract_fs_15_14_13_12_11(uint64 instruction)
+uint64 NMD::extract_fs_20_19_18_17_16(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 16, 5);
@@ -1598,7 +1598,7 @@ bool NMD::SLTU_cond(uint64 instruction)
 std::string NMD::ABS_D(uint64 instruction)
 {
     uint64 fd_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string fs = FPR(copy(fs_value));
     std::string fd = FPR(copy(fd_value));
@@ -1620,7 +1620,7 @@ std::string NMD::ABS_D(uint64 instruction)
 std::string NMD::ABS_S(uint64 instruction)
 {
     uint64 fd_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string fs = FPR(copy(fs_value));
     std::string fd = FPR(copy(fd_value));
@@ -1752,7 +1752,7 @@ std::string NMD::ADD(uint64 instruction)
 std::string NMD::ADD_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -1777,7 +1777,7 @@ std::string NMD::ADD_D(uint64 instruction)
 std::string NMD::ADD_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -3379,7 +3379,7 @@ std::string NMD::CACHEE(uint64 instruction)
 std::string NMD::CEIL_L_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3401,7 +3401,7 @@ std::string NMD::CEIL_L_D(uint64 instruction)
 std::string NMD::CEIL_L_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3423,7 +3423,7 @@ std::string NMD::CEIL_L_S(uint64 instruction)
 std::string NMD::CEIL_W_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3445,7 +3445,7 @@ std::string NMD::CEIL_W_D(uint64 instruction)
 std::string NMD::CEIL_W_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3511,7 +3511,7 @@ std::string NMD::CFC2(uint64 instruction)
 std::string NMD::CLASS_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3533,7 +3533,7 @@ std::string NMD::CLASS_D(uint64 instruction)
 std::string NMD::CLASS_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3599,7 +3599,7 @@ std::string NMD::CLZ(uint64 instruction)
 std::string NMD::CMP_AF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3623,7 +3623,7 @@ std::string NMD::CMP_AF_D(uint64 instruction)
 std::string NMD::CMP_AF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3647,7 +3647,7 @@ std::string NMD::CMP_AF_S(uint64 instruction)
 std::string NMD::CMP_EQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3693,7 +3693,7 @@ std::string NMD::CMP_EQ_PH(uint64 instruction)
 std::string NMD::CMP_EQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3717,7 +3717,7 @@ std::string NMD::CMP_EQ_S(uint64 instruction)
 std::string NMD::CMP_LE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3763,7 +3763,7 @@ std::string NMD::CMP_LE_PH(uint64 instruction)
 std::string NMD::CMP_LE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3787,7 +3787,7 @@ std::string NMD::CMP_LE_S(uint64 instruction)
 std::string NMD::CMP_LT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3833,7 +3833,7 @@ std::string NMD::CMP_LT_PH(uint64 instruction)
 std::string NMD::CMP_LT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3857,7 +3857,7 @@ std::string NMD::CMP_LT_S(uint64 instruction)
 std::string NMD::CMP_NE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3881,7 +3881,7 @@ std::string NMD::CMP_NE_D(uint64 instruction)
 std::string NMD::CMP_NE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3905,7 +3905,7 @@ std::string NMD::CMP_NE_S(uint64 instruction)
 std::string NMD::CMP_OR_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3929,7 +3929,7 @@ std::string NMD::CMP_OR_D(uint64 instruction)
 std::string NMD::CMP_OR_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3953,7 +3953,7 @@ std::string NMD::CMP_OR_S(uint64 instruction)
 std::string NMD::CMP_SAF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3977,7 +3977,7 @@ std::string NMD::CMP_SAF_D(uint64 instruction)
 std::string NMD::CMP_SAF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4001,7 +4001,7 @@ std::string NMD::CMP_SAF_S(uint64 instruction)
 std::string NMD::CMP_SEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4025,7 +4025,7 @@ std::string NMD::CMP_SEQ_D(uint64 instruction)
 std::string NMD::CMP_SEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4049,7 +4049,7 @@ std::string NMD::CMP_SEQ_S(uint64 instruction)
 std::string NMD::CMP_SLE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4073,7 +4073,7 @@ std::string NMD::CMP_SLE_D(uint64 instruction)
 std::string NMD::CMP_SLE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4097,7 +4097,7 @@ std::string NMD::CMP_SLE_S(uint64 instruction)
 std::string NMD::CMP_SLT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4121,7 +4121,7 @@ std::string NMD::CMP_SLT_D(uint64 instruction)
 std::string NMD::CMP_SLT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4145,7 +4145,7 @@ std::string NMD::CMP_SLT_S(uint64 instruction)
 std::string NMD::CMP_SNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4169,7 +4169,7 @@ std::string NMD::CMP_SNE_D(uint64 instruction)
 std::string NMD::CMP_SNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4193,7 +4193,7 @@ std::string NMD::CMP_SNE_S(uint64 instruction)
 std::string NMD::CMP_SOR_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4217,7 +4217,7 @@ std::string NMD::CMP_SOR_D(uint64 instruction)
 std::string NMD::CMP_SOR_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4241,7 +4241,7 @@ std::string NMD::CMP_SOR_S(uint64 instruction)
 std::string NMD::CMP_SUEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4265,7 +4265,7 @@ std::string NMD::CMP_SUEQ_D(uint64 instruction)
 std::string NMD::CMP_SUEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4289,7 +4289,7 @@ std::string NMD::CMP_SUEQ_S(uint64 instruction)
 std::string NMD::CMP_SULE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4313,7 +4313,7 @@ std::string NMD::CMP_SULE_D(uint64 instruction)
 std::string NMD::CMP_SULE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4337,7 +4337,7 @@ std::string NMD::CMP_SULE_S(uint64 instruction)
 std::string NMD::CMP_SULT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4361,7 +4361,7 @@ std::string NMD::CMP_SULT_D(uint64 instruction)
 std::string NMD::CMP_SULT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4385,7 +4385,7 @@ std::string NMD::CMP_SULT_S(uint64 instruction)
 std::string NMD::CMP_SUN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4409,7 +4409,7 @@ std::string NMD::CMP_SUN_D(uint64 instruction)
 std::string NMD::CMP_SUNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4433,7 +4433,7 @@ std::string NMD::CMP_SUNE_D(uint64 instruction)
 std::string NMD::CMP_SUNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4457,7 +4457,7 @@ std::string NMD::CMP_SUNE_S(uint64 instruction)
 std::string NMD::CMP_SUN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4481,7 +4481,7 @@ std::string NMD::CMP_SUN_S(uint64 instruction)
 std::string NMD::CMP_UEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4505,7 +4505,7 @@ std::string NMD::CMP_UEQ_D(uint64 instruction)
 std::string NMD::CMP_UEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4529,7 +4529,7 @@ std::string NMD::CMP_UEQ_S(uint64 instruction)
 std::string NMD::CMP_ULE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4553,7 +4553,7 @@ std::string NMD::CMP_ULE_D(uint64 instruction)
 std::string NMD::CMP_ULE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4577,7 +4577,7 @@ std::string NMD::CMP_ULE_S(uint64 instruction)
 std::string NMD::CMP_ULT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4601,7 +4601,7 @@ std::string NMD::CMP_ULT_D(uint64 instruction)
 std::string NMD::CMP_ULT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4625,7 +4625,7 @@ std::string NMD::CMP_ULT_S(uint64 instruction)
 std::string NMD::CMP_UN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4649,7 +4649,7 @@ std::string NMD::CMP_UN_D(uint64 instruction)
 std::string NMD::CMP_UNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4673,7 +4673,7 @@ std::string NMD::CMP_UNE_D(uint64 instruction)
 std::string NMD::CMP_UNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4697,7 +4697,7 @@ std::string NMD::CMP_UNE_S(uint64 instruction)
 std::string NMD::CMP_UN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4995,7 +4995,7 @@ std::string NMD::CTC2(uint64 instruction)
 std::string NMD::CVT_D_L(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5017,7 +5017,7 @@ std::string NMD::CVT_D_L(uint64 instruction)
 std::string NMD::CVT_D_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5039,7 +5039,7 @@ std::string NMD::CVT_D_S(uint64 instruction)
 std::string NMD::CVT_D_W(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5061,7 +5061,7 @@ std::string NMD::CVT_D_W(uint64 instruction)
 std::string NMD::CVT_L_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5083,7 +5083,7 @@ std::string NMD::CVT_L_D(uint64 instruction)
 std::string NMD::CVT_L_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5105,7 +5105,7 @@ std::string NMD::CVT_L_S(uint64 instruction)
 std::string NMD::CVT_S_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5127,7 +5127,7 @@ std::string NMD::CVT_S_D(uint64 instruction)
 std::string NMD::CVT_S_L(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5149,7 +5149,7 @@ std::string NMD::CVT_S_L(uint64 instruction)
 std::string NMD::CVT_S_PL(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5171,7 +5171,7 @@ std::string NMD::CVT_S_PL(uint64 instruction)
 std::string NMD::CVT_S_PU(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5193,7 +5193,7 @@ std::string NMD::CVT_S_PU(uint64 instruction)
 std::string NMD::CVT_S_W(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5215,7 +5215,7 @@ std::string NMD::CVT_S_W(uint64 instruction)
 std::string NMD::CVT_W_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5237,7 +5237,7 @@ std::string NMD::CVT_W_D(uint64 instruction)
 std::string NMD::CVT_W_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5693,7 +5693,7 @@ std::string NMD::DIV(uint64 instruction)
 std::string NMD::DIV_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -5717,7 +5717,7 @@ std::string NMD::DIV_D(uint64 instruction)
 std::string NMD::DIV_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -5837,7 +5837,7 @@ std::string NMD::DMFC0(uint64 instruction)
 std::string NMD::DMFC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -5977,7 +5977,7 @@ std::string NMD::DMTC0(uint64 instruction)
 std::string NMD::DMTC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -7474,7 +7474,7 @@ std::string NMD::EXTW(uint64 instruction)
 std::string NMD::FLOOR_L_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -7496,7 +7496,7 @@ std::string NMD::FLOOR_L_D(uint64 instruction)
 std::string NMD::FLOOR_L_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -7518,7 +7518,7 @@ std::string NMD::FLOOR_L_S(uint64 instruction)
 std::string NMD::FLOOR_W_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -7540,7 +7540,7 @@ std::string NMD::FLOOR_W_D(uint64 instruction)
 std::string NMD::FLOOR_W_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -9528,7 +9528,7 @@ std::string NMD::MADD_DSP_(uint64 instruction)
 std::string NMD::MADDF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9552,7 +9552,7 @@ std::string NMD::MADDF_D(uint64 instruction)
 std::string NMD::MADDF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9696,7 +9696,7 @@ std::string NMD::MAQ_SA_W_PHR(uint64 instruction)
 std::string NMD::MAX_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9720,7 +9720,7 @@ std::string NMD::MAX_D(uint64 instruction)
 std::string NMD::MAX_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9744,7 +9744,7 @@ std::string NMD::MAX_S(uint64 instruction)
 std::string NMD::MAXA_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9768,7 +9768,7 @@ std::string NMD::MAXA_D(uint64 instruction)
 std::string NMD::MAXA_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9816,7 +9816,7 @@ std::string NMD::MFC0(uint64 instruction)
 std::string NMD::MFC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -9908,7 +9908,7 @@ std::string NMD::MFHC0(uint64 instruction)
 std::string NMD::MFHC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -10072,7 +10072,7 @@ std::string NMD::MFTR(uint64 instruction)
 std::string NMD::MIN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10096,7 +10096,7 @@ std::string NMD::MIN_D(uint64 instruction)
 std::string NMD::MIN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10120,7 +10120,7 @@ std::string NMD::MIN_S(uint64 instruction)
 std::string NMD::MINA_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10144,7 +10144,7 @@ std::string NMD::MINA_D(uint64 instruction)
 std::string NMD::MINA_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10240,7 +10240,7 @@ std::string NMD::MODU(uint64 instruction)
 std::string NMD::MOV_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -10262,7 +10262,7 @@ std::string NMD::MOV_D(uint64 instruction)
 std::string NMD::MOV_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -10456,7 +10456,7 @@ std::string NMD::MSUB_DSP_(uint64 instruction)
 std::string NMD::MSUBF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10480,7 +10480,7 @@ std::string NMD::MSUBF_D(uint64 instruction)
 std::string NMD::MSUBF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10552,7 +10552,7 @@ std::string NMD::MTC0(uint64 instruction)
 std::string NMD::MTC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -10644,7 +10644,7 @@ std::string NMD::MTHC0(uint64 instruction)
 std::string NMD::MTHC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -10924,7 +10924,7 @@ std::string NMD::MUL_4X4_(uint64 instruction)
 std::string NMD::MUL_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10996,7 +10996,7 @@ std::string NMD::MUL_S_PH(uint64 instruction)
 std::string NMD::MUL_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -11332,7 +11332,7 @@ std::string NMD::MULU(uint64 instruction)
 std::string NMD::NEG_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -11354,7 +11354,7 @@ std::string NMD::NEG_D(uint64 instruction)
 std::string NMD::NEG_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12192,7 +12192,7 @@ std::string NMD::RDPGPR(uint64 instruction)
 std::string NMD::RECIP_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12214,7 +12214,7 @@ std::string NMD::RECIP_D(uint64 instruction)
 std::string NMD::RECIP_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12414,7 +12414,7 @@ std::string NMD::RESTOREF(uint64 instruction)
 std::string NMD::RINT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12436,7 +12436,7 @@ std::string NMD::RINT_D(uint64 instruction)
 std::string NMD::RINT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12535,7 +12535,7 @@ std::string NMD::ROTX(uint64 instruction)
 std::string NMD::ROUND_L_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12557,7 +12557,7 @@ std::string NMD::ROUND_L_D(uint64 instruction)
 std::string NMD::ROUND_L_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12579,7 +12579,7 @@ std::string NMD::ROUND_L_S(uint64 instruction)
 std::string NMD::ROUND_W_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12601,7 +12601,7 @@ std::string NMD::ROUND_W_D(uint64 instruction)
 std::string NMD::ROUND_W_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12623,7 +12623,7 @@ std::string NMD::ROUND_W_S(uint64 instruction)
 std::string NMD::RSQRT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12645,7 +12645,7 @@ std::string NMD::RSQRT_D(uint64 instruction)
 std::string NMD::RSQRT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -13412,7 +13412,7 @@ std::string NMD::SEH(uint64 instruction)
 std::string NMD::SEL_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13436,7 +13436,7 @@ std::string NMD::SEL_D(uint64 instruction)
 std::string NMD::SEL_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13460,7 +13460,7 @@ std::string NMD::SEL_S(uint64 instruction)
 std::string NMD::SELEQZ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13484,7 +13484,7 @@ std::string NMD::SELEQZ_D(uint64 instruction)
 std::string NMD::SELEQZ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13508,7 +13508,7 @@ std::string NMD::SELEQZ_S(uint64 instruction)
 std::string NMD::SELNEZ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13532,7 +13532,7 @@ std::string NMD::SELNEZ_D(uint64 instruction)
 std::string NMD::SELNEZ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -14550,7 +14550,7 @@ std::string NMD::SPECIAL2(uint64 instruction)
 std::string NMD::SQRT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -14572,7 +14572,7 @@ std::string NMD::SQRT_D(uint64 instruction)
 std::string NMD::SQRT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -14738,7 +14738,7 @@ std::string NMD::SUB(uint64 instruction)
 std::string NMD::SUB_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -14762,7 +14762,7 @@ std::string NMD::SUB_D(uint64 instruction)
 std::string NMD::SUB_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -15940,7 +15940,7 @@ std::string NMD::TNE(uint64 instruction)
 std::string NMD::TRUNC_L_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -15962,7 +15962,7 @@ std::string NMD::TRUNC_L_D(uint64 instruction)
 std::string NMD::TRUNC_L_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -15984,7 +15984,7 @@ std::string NMD::TRUNC_L_S(uint64 instruction)
 std::string NMD::TRUNC_W_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -16006,7 +16006,7 @@ std::string NMD::TRUNC_W_D(uint64 instruction)
 std::string NMD::TRUNC_W_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 15d3ffd..c6e2221 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -177,7 +177,7 @@ private:
     uint64 extract_eu_3_2_1_0(uint64 instruction);
     uint64 extract_eu_6_5_4_3_2_1_0(uint64 instruction);
     uint64 extract_fd_15_14_13_12_11(uint64 instruction);
-    uint64 extract_fs_15_14_13_12_11(uint64 instruction);
+    uint64 extract_fs_20_19_18_17_16(uint64 instruction);
     uint64 extract_ft_15_14_13_12_11(uint64 instruction);
     uint64 extract_ft_20_19_18_17_16(uint64 instruction);
     uint64 extract_gp_2(uint64 instruction);
-- 
2.7.4
