Received: from eggs.gnu.org ([208.118.235.92]:57359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz1H-0005qb-Kv
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz19-00045Z-78
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:19 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60623 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz18-0003rO-EI
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:17 +0100
Message-Id: <1546268200-26966-22-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 21/44] disas: nanoMIPS: Fix an FP-related
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename NMD::extract_fs_15_14_13_12_11(uint64 instruction) to
NMD::extract_fs_20_19_18_17_16(uint64 instruction).

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 242 ++++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |   2 +-
 2 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index bff1900..b9ad0f7 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1114,7 +1114,7 @@ uint64 NMD::extract_u_15_to_0(uint64 instruction)
 }
 
 
-uint64 NMD::extract_fs_15_14_13_12_11(uint64 instruction)
+uint64 NMD::extract_fs_20_19_18_17_16(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 16, 5);
@@ -1602,7 +1602,7 @@ bool NMD::SLTU_cond(uint64 instruction)
 std::string NMD::ABS_D(uint64 instruction)
 {
     uint64 fd_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string fs = FPR(copy(fs_value));
     std::string fd = FPR(copy(fd_value));
@@ -1624,7 +1624,7 @@ std::string NMD::ABS_D(uint64 instruction)
 std::string NMD::ABS_S(uint64 instruction)
 {
     uint64 fd_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string fs = FPR(copy(fs_value));
     std::string fd = FPR(copy(fd_value));
@@ -1756,7 +1756,7 @@ std::string NMD::ADD(uint64 instruction)
 std::string NMD::ADD_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -1781,7 +1781,7 @@ std::string NMD::ADD_D(uint64 instruction)
 std::string NMD::ADD_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
@@ -3383,7 +3383,7 @@ std::string NMD::CACHEE(uint64 instruction)
 std::string NMD::CEIL_L_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3405,7 +3405,7 @@ std::string NMD::CEIL_L_D(uint64 instruction)
 std::string NMD::CEIL_L_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3427,7 +3427,7 @@ std::string NMD::CEIL_L_S(uint64 instruction)
 std::string NMD::CEIL_W_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3449,7 +3449,7 @@ std::string NMD::CEIL_W_D(uint64 instruction)
 std::string NMD::CEIL_W_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3515,7 +3515,7 @@ std::string NMD::CFC2(uint64 instruction)
 std::string NMD::CLASS_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3537,7 +3537,7 @@ std::string NMD::CLASS_D(uint64 instruction)
 std::string NMD::CLASS_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3603,7 +3603,7 @@ std::string NMD::CLZ(uint64 instruction)
 std::string NMD::CMP_AF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3627,7 +3627,7 @@ std::string NMD::CMP_AF_D(uint64 instruction)
 std::string NMD::CMP_AF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3651,7 +3651,7 @@ std::string NMD::CMP_AF_S(uint64 instruction)
 std::string NMD::CMP_EQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3697,7 +3697,7 @@ std::string NMD::CMP_EQ_PH(uint64 instruction)
 std::string NMD::CMP_EQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3721,7 +3721,7 @@ std::string NMD::CMP_EQ_S(uint64 instruction)
 std::string NMD::CMP_LE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3767,7 +3767,7 @@ std::string NMD::CMP_LE_PH(uint64 instruction)
 std::string NMD::CMP_LE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3791,7 +3791,7 @@ std::string NMD::CMP_LE_S(uint64 instruction)
 std::string NMD::CMP_LT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3837,7 +3837,7 @@ std::string NMD::CMP_LT_PH(uint64 instruction)
 std::string NMD::CMP_LT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3861,7 +3861,7 @@ std::string NMD::CMP_LT_S(uint64 instruction)
 std::string NMD::CMP_NE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3885,7 +3885,7 @@ std::string NMD::CMP_NE_D(uint64 instruction)
 std::string NMD::CMP_NE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3909,7 +3909,7 @@ std::string NMD::CMP_NE_S(uint64 instruction)
 std::string NMD::CMP_OR_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3933,7 +3933,7 @@ std::string NMD::CMP_OR_D(uint64 instruction)
 std::string NMD::CMP_OR_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3957,7 +3957,7 @@ std::string NMD::CMP_OR_S(uint64 instruction)
 std::string NMD::CMP_SAF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -3981,7 +3981,7 @@ std::string NMD::CMP_SAF_D(uint64 instruction)
 std::string NMD::CMP_SAF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4005,7 +4005,7 @@ std::string NMD::CMP_SAF_S(uint64 instruction)
 std::string NMD::CMP_SEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4029,7 +4029,7 @@ std::string NMD::CMP_SEQ_D(uint64 instruction)
 std::string NMD::CMP_SEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4053,7 +4053,7 @@ std::string NMD::CMP_SEQ_S(uint64 instruction)
 std::string NMD::CMP_SLE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4077,7 +4077,7 @@ std::string NMD::CMP_SLE_D(uint64 instruction)
 std::string NMD::CMP_SLE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4101,7 +4101,7 @@ std::string NMD::CMP_SLE_S(uint64 instruction)
 std::string NMD::CMP_SLT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4125,7 +4125,7 @@ std::string NMD::CMP_SLT_D(uint64 instruction)
 std::string NMD::CMP_SLT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4149,7 +4149,7 @@ std::string NMD::CMP_SLT_S(uint64 instruction)
 std::string NMD::CMP_SNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4173,7 +4173,7 @@ std::string NMD::CMP_SNE_D(uint64 instruction)
 std::string NMD::CMP_SNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4197,7 +4197,7 @@ std::string NMD::CMP_SNE_S(uint64 instruction)
 std::string NMD::CMP_SOR_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4221,7 +4221,7 @@ std::string NMD::CMP_SOR_D(uint64 instruction)
 std::string NMD::CMP_SOR_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4245,7 +4245,7 @@ std::string NMD::CMP_SOR_S(uint64 instruction)
 std::string NMD::CMP_SUEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4269,7 +4269,7 @@ std::string NMD::CMP_SUEQ_D(uint64 instruction)
 std::string NMD::CMP_SUEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4293,7 +4293,7 @@ std::string NMD::CMP_SUEQ_S(uint64 instruction)
 std::string NMD::CMP_SULE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4317,7 +4317,7 @@ std::string NMD::CMP_SULE_D(uint64 instruction)
 std::string NMD::CMP_SULE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4341,7 +4341,7 @@ std::string NMD::CMP_SULE_S(uint64 instruction)
 std::string NMD::CMP_SULT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4365,7 +4365,7 @@ std::string NMD::CMP_SULT_D(uint64 instruction)
 std::string NMD::CMP_SULT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4389,7 +4389,7 @@ std::string NMD::CMP_SULT_S(uint64 instruction)
 std::string NMD::CMP_SUN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4413,7 +4413,7 @@ std::string NMD::CMP_SUN_D(uint64 instruction)
 std::string NMD::CMP_SUNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4437,7 +4437,7 @@ std::string NMD::CMP_SUNE_D(uint64 instruction)
 std::string NMD::CMP_SUNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4461,7 +4461,7 @@ std::string NMD::CMP_SUNE_S(uint64 instruction)
 std::string NMD::CMP_SUN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4485,7 +4485,7 @@ std::string NMD::CMP_SUN_S(uint64 instruction)
 std::string NMD::CMP_UEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4509,7 +4509,7 @@ std::string NMD::CMP_UEQ_D(uint64 instruction)
 std::string NMD::CMP_UEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4533,7 +4533,7 @@ std::string NMD::CMP_UEQ_S(uint64 instruction)
 std::string NMD::CMP_ULE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4557,7 +4557,7 @@ std::string NMD::CMP_ULE_D(uint64 instruction)
 std::string NMD::CMP_ULE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4581,7 +4581,7 @@ std::string NMD::CMP_ULE_S(uint64 instruction)
 std::string NMD::CMP_ULT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4605,7 +4605,7 @@ std::string NMD::CMP_ULT_D(uint64 instruction)
 std::string NMD::CMP_ULT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4629,7 +4629,7 @@ std::string NMD::CMP_ULT_S(uint64 instruction)
 std::string NMD::CMP_UN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4653,7 +4653,7 @@ std::string NMD::CMP_UN_D(uint64 instruction)
 std::string NMD::CMP_UNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4677,7 +4677,7 @@ std::string NMD::CMP_UNE_D(uint64 instruction)
 std::string NMD::CMP_UNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4701,7 +4701,7 @@ std::string NMD::CMP_UNE_S(uint64 instruction)
 std::string NMD::CMP_UN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -4999,7 +4999,7 @@ std::string NMD::CTC2(uint64 instruction)
 std::string NMD::CVT_D_L(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5021,7 +5021,7 @@ std::string NMD::CVT_D_L(uint64 instruction)
 std::string NMD::CVT_D_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5043,7 +5043,7 @@ std::string NMD::CVT_D_S(uint64 instruction)
 std::string NMD::CVT_D_W(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5065,7 +5065,7 @@ std::string NMD::CVT_D_W(uint64 instruction)
 std::string NMD::CVT_L_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5087,7 +5087,7 @@ std::string NMD::CVT_L_D(uint64 instruction)
 std::string NMD::CVT_L_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5109,7 +5109,7 @@ std::string NMD::CVT_L_S(uint64 instruction)
 std::string NMD::CVT_S_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5131,7 +5131,7 @@ std::string NMD::CVT_S_D(uint64 instruction)
 std::string NMD::CVT_S_L(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5153,7 +5153,7 @@ std::string NMD::CVT_S_L(uint64 instruction)
 std::string NMD::CVT_S_PL(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5175,7 +5175,7 @@ std::string NMD::CVT_S_PL(uint64 instruction)
 std::string NMD::CVT_S_PU(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5197,7 +5197,7 @@ std::string NMD::CVT_S_PU(uint64 instruction)
 std::string NMD::CVT_S_W(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5219,7 +5219,7 @@ std::string NMD::CVT_S_W(uint64 instruction)
 std::string NMD::CVT_W_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5241,7 +5241,7 @@ std::string NMD::CVT_W_D(uint64 instruction)
 std::string NMD::CVT_W_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5697,7 +5697,7 @@ std::string NMD::DIV(uint64 instruction)
 std::string NMD::DIV_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -5721,7 +5721,7 @@ std::string NMD::DIV_D(uint64 instruction)
 std::string NMD::DIV_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -5841,7 +5841,7 @@ std::string NMD::DMFC0(uint64 instruction)
 std::string NMD::DMFC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -5981,7 +5981,7 @@ std::string NMD::DMTC0(uint64 instruction)
 std::string NMD::DMTC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -7478,7 +7478,7 @@ std::string NMD::EXTW(uint64 instruction)
 std::string NMD::FLOOR_L_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -7500,7 +7500,7 @@ std::string NMD::FLOOR_L_D(uint64 instruction)
 std::string NMD::FLOOR_L_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -7522,7 +7522,7 @@ std::string NMD::FLOOR_L_S(uint64 instruction)
 std::string NMD::FLOOR_W_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -7544,7 +7544,7 @@ std::string NMD::FLOOR_W_D(uint64 instruction)
 std::string NMD::FLOOR_W_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -9532,7 +9532,7 @@ std::string NMD::MADD_DSP_(uint64 instruction)
 std::string NMD::MADDF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9556,7 +9556,7 @@ std::string NMD::MADDF_D(uint64 instruction)
 std::string NMD::MADDF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9700,7 +9700,7 @@ std::string NMD::MAQ_SA_W_PHR(uint64 instruction)
 std::string NMD::MAX_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9724,7 +9724,7 @@ std::string NMD::MAX_D(uint64 instruction)
 std::string NMD::MAX_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9748,7 +9748,7 @@ std::string NMD::MAX_S(uint64 instruction)
 std::string NMD::MAXA_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9772,7 +9772,7 @@ std::string NMD::MAXA_D(uint64 instruction)
 std::string NMD::MAXA_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9820,7 +9820,7 @@ std::string NMD::MFC0(uint64 instruction)
 std::string NMD::MFC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -9912,7 +9912,7 @@ std::string NMD::MFHC0(uint64 instruction)
 std::string NMD::MFHC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -10076,7 +10076,7 @@ std::string NMD::MFTR(uint64 instruction)
 std::string NMD::MIN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10100,7 +10100,7 @@ std::string NMD::MIN_D(uint64 instruction)
 std::string NMD::MIN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10124,7 +10124,7 @@ std::string NMD::MIN_S(uint64 instruction)
 std::string NMD::MINA_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10148,7 +10148,7 @@ std::string NMD::MINA_D(uint64 instruction)
 std::string NMD::MINA_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10244,7 +10244,7 @@ std::string NMD::MODU(uint64 instruction)
 std::string NMD::MOV_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -10266,7 +10266,7 @@ std::string NMD::MOV_D(uint64 instruction)
 std::string NMD::MOV_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -10460,7 +10460,7 @@ std::string NMD::MSUB_DSP_(uint64 instruction)
 std::string NMD::MSUBF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10484,7 +10484,7 @@ std::string NMD::MSUBF_D(uint64 instruction)
 std::string NMD::MSUBF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10556,7 +10556,7 @@ std::string NMD::MTC0(uint64 instruction)
 std::string NMD::MTC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -10648,7 +10648,7 @@ std::string NMD::MTHC0(uint64 instruction)
 std::string NMD::MTHC1(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string fs = FPR(copy(fs_value));
@@ -10928,7 +10928,7 @@ std::string NMD::MUL_4X4_(uint64 instruction)
 std::string NMD::MUL_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -11000,7 +11000,7 @@ std::string NMD::MUL_S_PH(uint64 instruction)
 std::string NMD::MUL_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -11336,7 +11336,7 @@ std::string NMD::MULU(uint64 instruction)
 std::string NMD::NEG_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -11358,7 +11358,7 @@ std::string NMD::NEG_D(uint64 instruction)
 std::string NMD::NEG_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12196,7 +12196,7 @@ std::string NMD::RDPGPR(uint64 instruction)
 std::string NMD::RECIP_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12218,7 +12218,7 @@ std::string NMD::RECIP_D(uint64 instruction)
 std::string NMD::RECIP_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12418,7 +12418,7 @@ std::string NMD::RESTOREF(uint64 instruction)
 std::string NMD::RINT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12440,7 +12440,7 @@ std::string NMD::RINT_D(uint64 instruction)
 std::string NMD::RINT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12539,7 +12539,7 @@ std::string NMD::ROTX(uint64 instruction)
 std::string NMD::ROUND_L_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12561,7 +12561,7 @@ std::string NMD::ROUND_L_D(uint64 instruction)
 std::string NMD::ROUND_L_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12583,7 +12583,7 @@ std::string NMD::ROUND_L_S(uint64 instruction)
 std::string NMD::ROUND_W_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12605,7 +12605,7 @@ std::string NMD::ROUND_W_D(uint64 instruction)
 std::string NMD::ROUND_W_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12627,7 +12627,7 @@ std::string NMD::ROUND_W_S(uint64 instruction)
 std::string NMD::RSQRT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12649,7 +12649,7 @@ std::string NMD::RSQRT_D(uint64 instruction)
 std::string NMD::RSQRT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -13416,7 +13416,7 @@ std::string NMD::SEH(uint64 instruction)
 std::string NMD::SEL_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13440,7 +13440,7 @@ std::string NMD::SEL_D(uint64 instruction)
 std::string NMD::SEL_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13464,7 +13464,7 @@ std::string NMD::SEL_S(uint64 instruction)
 std::string NMD::SELEQZ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13488,7 +13488,7 @@ std::string NMD::SELEQZ_D(uint64 instruction)
 std::string NMD::SELEQZ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13512,7 +13512,7 @@ std::string NMD::SELEQZ_S(uint64 instruction)
 std::string NMD::SELNEZ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13536,7 +13536,7 @@ std::string NMD::SELNEZ_D(uint64 instruction)
 std::string NMD::SELNEZ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -14554,7 +14554,7 @@ std::string NMD::SPECIAL2(uint64 instruction)
 std::string NMD::SQRT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -14576,7 +14576,7 @@ std::string NMD::SQRT_D(uint64 instruction)
 std::string NMD::SQRT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -14742,7 +14742,7 @@ std::string NMD::SUB(uint64 instruction)
 std::string NMD::SUB_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -14766,7 +14766,7 @@ std::string NMD::SUB_D(uint64 instruction)
 std::string NMD::SUB_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
     uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -15944,7 +15944,7 @@ std::string NMD::TNE(uint64 instruction)
 std::string NMD::TRUNC_L_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -15966,7 +15966,7 @@ std::string NMD::TRUNC_L_D(uint64 instruction)
 std::string NMD::TRUNC_L_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -15988,7 +15988,7 @@ std::string NMD::TRUNC_L_S(uint64 instruction)
 std::string NMD::TRUNC_W_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -16010,7 +16010,7 @@ std::string NMD::TRUNC_W_D(uint64 instruction)
 std::string NMD::TRUNC_W_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fs_value = extract_fs_20_19_18_17_16(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index d595092..fad70d2 100644
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
