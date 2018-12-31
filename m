Received: from eggs.gnu.org ([208.118.235.92]:57352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz1H-0005qU-Fl
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz19-00045y-Bf
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60624 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz18-0003rS-FW
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:16 +0100
Message-Id: <1546268200-26966-21-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 20/44] disas: nanoMIPS: Fix an FP-related
 misnomer 1
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

Rename NMD::extract_fd_10_9_8_7_6(uint64 instruction) to
NMD::extract_fd_15_14_13_12_11(uint64 instruction).

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 142 ++++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |   2 +-
 2 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 281d8d9..bff1900 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1446,7 +1446,7 @@ uint64 NMD::extract_u_3_8__s2(uint64 instruction)
 }
 
 
-uint64 NMD::extract_fd_10_9_8_7_6(uint64 instruction)
+uint64 NMD::extract_fd_15_14_13_12_11(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 11, 5);
@@ -1757,7 +1757,7 @@ std::string NMD::ADD_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -1782,7 +1782,7 @@ std::string NMD::ADD_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3604,7 +3604,7 @@ std::string NMD::CMP_AF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3628,7 +3628,7 @@ std::string NMD::CMP_AF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3652,7 +3652,7 @@ std::string NMD::CMP_EQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3698,7 +3698,7 @@ std::string NMD::CMP_EQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3722,7 +3722,7 @@ std::string NMD::CMP_LE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3768,7 +3768,7 @@ std::string NMD::CMP_LE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3792,7 +3792,7 @@ std::string NMD::CMP_LT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3838,7 +3838,7 @@ std::string NMD::CMP_LT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3862,7 +3862,7 @@ std::string NMD::CMP_NE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3886,7 +3886,7 @@ std::string NMD::CMP_NE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3910,7 +3910,7 @@ std::string NMD::CMP_OR_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3934,7 +3934,7 @@ std::string NMD::CMP_OR_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3958,7 +3958,7 @@ std::string NMD::CMP_SAF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3982,7 +3982,7 @@ std::string NMD::CMP_SAF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4006,7 +4006,7 @@ std::string NMD::CMP_SEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4030,7 +4030,7 @@ std::string NMD::CMP_SEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4054,7 +4054,7 @@ std::string NMD::CMP_SLE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4078,7 +4078,7 @@ std::string NMD::CMP_SLE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4102,7 +4102,7 @@ std::string NMD::CMP_SLT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4126,7 +4126,7 @@ std::string NMD::CMP_SLT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4150,7 +4150,7 @@ std::string NMD::CMP_SNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4174,7 +4174,7 @@ std::string NMD::CMP_SNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4198,7 +4198,7 @@ std::string NMD::CMP_SOR_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4222,7 +4222,7 @@ std::string NMD::CMP_SOR_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4246,7 +4246,7 @@ std::string NMD::CMP_SUEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4270,7 +4270,7 @@ std::string NMD::CMP_SUEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4294,7 +4294,7 @@ std::string NMD::CMP_SULE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4318,7 +4318,7 @@ std::string NMD::CMP_SULE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4342,7 +4342,7 @@ std::string NMD::CMP_SULT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4366,7 +4366,7 @@ std::string NMD::CMP_SULT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4390,7 +4390,7 @@ std::string NMD::CMP_SUN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4414,7 +4414,7 @@ std::string NMD::CMP_SUNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4438,7 +4438,7 @@ std::string NMD::CMP_SUNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4462,7 +4462,7 @@ std::string NMD::CMP_SUN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4486,7 +4486,7 @@ std::string NMD::CMP_UEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4510,7 +4510,7 @@ std::string NMD::CMP_UEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4534,7 +4534,7 @@ std::string NMD::CMP_ULE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4558,7 +4558,7 @@ std::string NMD::CMP_ULE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4582,7 +4582,7 @@ std::string NMD::CMP_ULT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4606,7 +4606,7 @@ std::string NMD::CMP_ULT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4630,7 +4630,7 @@ std::string NMD::CMP_UN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4654,7 +4654,7 @@ std::string NMD::CMP_UNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4678,7 +4678,7 @@ std::string NMD::CMP_UNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4702,7 +4702,7 @@ std::string NMD::CMP_UN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -5698,7 +5698,7 @@ std::string NMD::DIV_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -5722,7 +5722,7 @@ std::string NMD::DIV_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9533,7 +9533,7 @@ std::string NMD::MADDF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9557,7 +9557,7 @@ std::string NMD::MADDF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9701,7 +9701,7 @@ std::string NMD::MAX_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9725,7 +9725,7 @@ std::string NMD::MAX_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9749,7 +9749,7 @@ std::string NMD::MAXA_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9773,7 +9773,7 @@ std::string NMD::MAXA_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10077,7 +10077,7 @@ std::string NMD::MIN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10101,7 +10101,7 @@ std::string NMD::MIN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10125,7 +10125,7 @@ std::string NMD::MINA_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10149,7 +10149,7 @@ std::string NMD::MINA_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10461,7 +10461,7 @@ std::string NMD::MSUBF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10485,7 +10485,7 @@ std::string NMD::MSUBF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10929,7 +10929,7 @@ std::string NMD::MUL_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -11001,7 +11001,7 @@ std::string NMD::MUL_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13417,7 +13417,7 @@ std::string NMD::SEL_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13441,7 +13441,7 @@ std::string NMD::SEL_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13465,7 +13465,7 @@ std::string NMD::SELEQZ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13489,7 +13489,7 @@ std::string NMD::SELEQZ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13513,7 +13513,7 @@ std::string NMD::SELNEZ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13537,7 +13537,7 @@ std::string NMD::SELNEZ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -14743,7 +14743,7 @@ std::string NMD::SUB_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -14767,7 +14767,7 @@ std::string NMD::SUB_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index d3722f6..d595092 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -176,7 +176,7 @@ private:
     uint64 extract_ct_25_24_23_22_21(uint64 instruction);
     uint64 extract_eu_3_2_1_0(uint64 instruction);
     uint64 extract_eu_6_5_4_3_2_1_0(uint64 instruction);
-    uint64 extract_fd_10_9_8_7_6(uint64 instruction);
+    uint64 extract_fd_15_14_13_12_11(uint64 instruction);
     uint64 extract_fs_15_14_13_12_11(uint64 instruction);
     uint64 extract_ft_15_14_13_12_11(uint64 instruction);
     uint64 extract_ft_20_19_18_17_16(uint64 instruction);
-- 
2.7.4
