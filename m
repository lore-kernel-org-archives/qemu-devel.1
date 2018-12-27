Received: from eggs.gnu.org ([208.118.235.92]:47663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZl-0001Z2-7V
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZg-0001wI-JA
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:23:53 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51178 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcWZg-0001pB-18
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:23:48 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 27 Dec 2018 15:22:46 +0100
Message-Id: <1545920586-17815-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 06/26] disas: nanoMIPS: Fix an FP-related
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
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename NMD::extract_fd_10_9_8_7_6(uint64 instruction) to
NMD::extract_fd_15_14_13_12_11(uint64 instruction).

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 142 ++++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |   2 +-
 2 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 477df84..9682725 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1442,7 +1442,7 @@ uint64 NMD::extract_u_3_8__s2(uint64 instruction)
 }
 
 
-uint64 NMD::extract_fd_10_9_8_7_6(uint64 instruction)
+uint64 NMD::extract_fd_15_14_13_12_11(uint64 instruction)
 {
     uint64 value = 0;
     value |= extract_bits(instruction, 11, 5);
@@ -1753,7 +1753,7 @@ std::string NMD::ADD_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -1778,7 +1778,7 @@ std::string NMD::ADD_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3600,7 +3600,7 @@ std::string NMD::CMP_AF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3624,7 +3624,7 @@ std::string NMD::CMP_AF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3648,7 +3648,7 @@ std::string NMD::CMP_EQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3694,7 +3694,7 @@ std::string NMD::CMP_EQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3718,7 +3718,7 @@ std::string NMD::CMP_LE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3764,7 +3764,7 @@ std::string NMD::CMP_LE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3788,7 +3788,7 @@ std::string NMD::CMP_LT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3834,7 +3834,7 @@ std::string NMD::CMP_LT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3858,7 +3858,7 @@ std::string NMD::CMP_NE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3882,7 +3882,7 @@ std::string NMD::CMP_NE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3906,7 +3906,7 @@ std::string NMD::CMP_OR_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3930,7 +3930,7 @@ std::string NMD::CMP_OR_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3954,7 +3954,7 @@ std::string NMD::CMP_SAF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3978,7 +3978,7 @@ std::string NMD::CMP_SAF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4002,7 +4002,7 @@ std::string NMD::CMP_SEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4026,7 +4026,7 @@ std::string NMD::CMP_SEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4050,7 +4050,7 @@ std::string NMD::CMP_SLE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4074,7 +4074,7 @@ std::string NMD::CMP_SLE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4098,7 +4098,7 @@ std::string NMD::CMP_SLT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4122,7 +4122,7 @@ std::string NMD::CMP_SLT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4146,7 +4146,7 @@ std::string NMD::CMP_SNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4170,7 +4170,7 @@ std::string NMD::CMP_SNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4194,7 +4194,7 @@ std::string NMD::CMP_SOR_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4218,7 +4218,7 @@ std::string NMD::CMP_SOR_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4242,7 +4242,7 @@ std::string NMD::CMP_SUEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4266,7 +4266,7 @@ std::string NMD::CMP_SUEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4290,7 +4290,7 @@ std::string NMD::CMP_SULE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4314,7 +4314,7 @@ std::string NMD::CMP_SULE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4338,7 +4338,7 @@ std::string NMD::CMP_SULT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4362,7 +4362,7 @@ std::string NMD::CMP_SULT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4386,7 +4386,7 @@ std::string NMD::CMP_SUN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4410,7 +4410,7 @@ std::string NMD::CMP_SUNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4434,7 +4434,7 @@ std::string NMD::CMP_SUNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4458,7 +4458,7 @@ std::string NMD::CMP_SUN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4482,7 +4482,7 @@ std::string NMD::CMP_UEQ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4506,7 +4506,7 @@ std::string NMD::CMP_UEQ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4530,7 +4530,7 @@ std::string NMD::CMP_ULE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4554,7 +4554,7 @@ std::string NMD::CMP_ULE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4578,7 +4578,7 @@ std::string NMD::CMP_ULT_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4602,7 +4602,7 @@ std::string NMD::CMP_ULT_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4626,7 +4626,7 @@ std::string NMD::CMP_UN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4650,7 +4650,7 @@ std::string NMD::CMP_UNE_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4674,7 +4674,7 @@ std::string NMD::CMP_UNE_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4698,7 +4698,7 @@ std::string NMD::CMP_UN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -5694,7 +5694,7 @@ std::string NMD::DIV_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -5718,7 +5718,7 @@ std::string NMD::DIV_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9529,7 +9529,7 @@ std::string NMD::MADDF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9553,7 +9553,7 @@ std::string NMD::MADDF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9697,7 +9697,7 @@ std::string NMD::MAX_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9721,7 +9721,7 @@ std::string NMD::MAX_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9745,7 +9745,7 @@ std::string NMD::MAXA_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -9769,7 +9769,7 @@ std::string NMD::MAXA_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10073,7 +10073,7 @@ std::string NMD::MIN_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10097,7 +10097,7 @@ std::string NMD::MIN_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10121,7 +10121,7 @@ std::string NMD::MINA_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10145,7 +10145,7 @@ std::string NMD::MINA_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10457,7 +10457,7 @@ std::string NMD::MSUBF_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10481,7 +10481,7 @@ std::string NMD::MSUBF_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10925,7 +10925,7 @@ std::string NMD::MUL_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -10997,7 +10997,7 @@ std::string NMD::MUL_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13413,7 +13413,7 @@ std::string NMD::SEL_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13437,7 +13437,7 @@ std::string NMD::SEL_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13461,7 +13461,7 @@ std::string NMD::SELEQZ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13485,7 +13485,7 @@ std::string NMD::SELEQZ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13509,7 +13509,7 @@ std::string NMD::SELNEZ_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -13533,7 +13533,7 @@ std::string NMD::SELNEZ_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -14739,7 +14739,7 @@ std::string NMD::SUB_D(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -14763,7 +14763,7 @@ std::string NMD::SUB_S(uint64 instruction)
 {
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
     uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
+    uint64 fd_value = extract_fd_15_14_13_12_11(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
diff --git a/disas/nanomips.h b/disas/nanomips.h
index e5b8093..15d3ffd 100644
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
