Received: from eggs.gnu.org ([208.118.235.92]:52575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcomp-0008N3-T6
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoPD-0003KW-Or
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:27:09 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49269 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcoPC-00036V-E4
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 28 Dec 2018 10:25:22 +0100
Message-Id: <1545989148-13582-16-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 15/41] disas: nanoMIPS: Fix order of some
 invocations
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

Fix order of extraction function invocations so that extraction
goes from MSB side to LSB side of the given instruction coding
content. This is desireable because of consistency and easier
visual spotting of errors.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 776 ++++++++++++++++++++++++++---------------------------
 1 file changed, 388 insertions(+), 388 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 2abf18d..d8829f5 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1601,8 +1601,8 @@ bool NMD::SLTU_cond(uint64 instruction)
  */
 std::string NMD::ABS_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string fs = FPR(copy(fs_value));
     std::string fd = FPR(copy(fd_value));
@@ -1623,8 +1623,8 @@ std::string NMD::ABS_D(uint64 instruction)
  */
 std::string NMD::ABS_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string fs = FPR(copy(fs_value));
     std::string fd = FPR(copy(fd_value));
@@ -1731,8 +1731,8 @@ std::string NMD::ACLR(uint64 instruction)
 std::string NMD::ADD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -1804,8 +1804,8 @@ std::string NMD::ADD_S(uint64 instruction)
 std::string NMD::ADDIU_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_15_to_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_15_to_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -1911,8 +1911,8 @@ std::string NMD::ADDIU_GP_W_(uint64 instruction)
 std::string NMD::ADDIU_NEG_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -2043,8 +2043,8 @@ std::string NMD::ADDIUPC_48_(uint64 instruction)
 std::string NMD::ADDQ_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2067,8 +2067,8 @@ std::string NMD::ADDQ_PH(uint64 instruction)
 std::string NMD::ADDQ_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2091,8 +2091,8 @@ std::string NMD::ADDQ_S_PH(uint64 instruction)
 std::string NMD::ADDQ_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2116,8 +2116,8 @@ std::string NMD::ADDQ_S_W(uint64 instruction)
 std::string NMD::ADDQH_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2141,8 +2141,8 @@ std::string NMD::ADDQH_PH(uint64 instruction)
 std::string NMD::ADDQH_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2165,8 +2165,8 @@ std::string NMD::ADDQH_R_PH(uint64 instruction)
 std::string NMD::ADDQH_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2189,8 +2189,8 @@ std::string NMD::ADDQH_R_W(uint64 instruction)
 std::string NMD::ADDQH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2213,8 +2213,8 @@ std::string NMD::ADDQH_W(uint64 instruction)
 std::string NMD::ADDSC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2260,8 +2260,8 @@ std::string NMD::ADDU_16_(uint64 instruction)
 std::string NMD::ADDU_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2283,8 +2283,8 @@ std::string NMD::ADDU_32_(uint64 instruction)
  */
 std::string NMD::ADDU_4X4_(uint64 instruction)
 {
-    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 rt4_value = extract_rt4_9_7_6_5(instruction);
+    uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
 
     std::string rs4 = GPR(encode_gpr4(rs4_value));
     std::string rt4 = GPR(encode_gpr4(rt4_value));
@@ -2306,8 +2306,8 @@ std::string NMD::ADDU_4X4_(uint64 instruction)
 std::string NMD::ADDU_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2330,8 +2330,8 @@ std::string NMD::ADDU_PH(uint64 instruction)
 std::string NMD::ADDU_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2354,8 +2354,8 @@ std::string NMD::ADDU_QB(uint64 instruction)
 std::string NMD::ADDU_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2378,8 +2378,8 @@ std::string NMD::ADDU_S_PH(uint64 instruction)
 std::string NMD::ADDU_S_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2403,8 +2403,8 @@ std::string NMD::ADDU_S_QB(uint64 instruction)
 std::string NMD::ADDUH_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2428,8 +2428,8 @@ std::string NMD::ADDUH_QB(uint64 instruction)
 std::string NMD::ADDUH_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2451,8 +2451,8 @@ std::string NMD::ADDUH_R_QB(uint64 instruction)
 std::string NMD::ADDWC(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2518,8 +2518,8 @@ std::string NMD::AND_16_(uint64 instruction)
 std::string NMD::AND_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -2565,8 +2565,8 @@ std::string NMD::ANDI_16_(uint64 instruction)
 std::string NMD::ANDI_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -2589,8 +2589,8 @@ std::string NMD::ANDI_32_(uint64 instruction)
 std::string NMD::APPEND(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 sa_value = extract_sa_15_14_13_12_11(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -3382,8 +3382,8 @@ std::string NMD::CACHEE(uint64 instruction)
  */
 std::string NMD::CEIL_L_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3404,8 +3404,8 @@ std::string NMD::CEIL_L_D(uint64 instruction)
  */
 std::string NMD::CEIL_L_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3426,8 +3426,8 @@ std::string NMD::CEIL_L_S(uint64 instruction)
  */
 std::string NMD::CEIL_W_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3448,8 +3448,8 @@ std::string NMD::CEIL_W_D(uint64 instruction)
  */
 std::string NMD::CEIL_W_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3470,8 +3470,8 @@ std::string NMD::CEIL_W_S(uint64 instruction)
  */
 std::string NMD::CFC1(uint64 instruction)
 {
-    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string cs = CPR(copy(cs_value));
@@ -3492,8 +3492,8 @@ std::string NMD::CFC1(uint64 instruction)
  */
 std::string NMD::CFC2(uint64 instruction)
 {
-    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string cs = CPR(copy(cs_value));
@@ -3514,8 +3514,8 @@ std::string NMD::CFC2(uint64 instruction)
  */
 std::string NMD::CLASS_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3536,8 +3536,8 @@ std::string NMD::CLASS_D(uint64 instruction)
  */
 std::string NMD::CLASS_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -3602,9 +3602,9 @@ std::string NMD::CLZ(uint64 instruction)
  */
 std::string NMD::CMP_AF_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3626,9 +3626,9 @@ std::string NMD::CMP_AF_D(uint64 instruction)
  */
 std::string NMD::CMP_AF_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3650,9 +3650,9 @@ std::string NMD::CMP_AF_S(uint64 instruction)
  */
 std::string NMD::CMP_EQ_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3696,9 +3696,9 @@ std::string NMD::CMP_EQ_PH(uint64 instruction)
  */
 std::string NMD::CMP_EQ_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3720,9 +3720,9 @@ std::string NMD::CMP_EQ_S(uint64 instruction)
  */
 std::string NMD::CMP_LE_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3766,9 +3766,9 @@ std::string NMD::CMP_LE_PH(uint64 instruction)
  */
 std::string NMD::CMP_LE_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3790,9 +3790,9 @@ std::string NMD::CMP_LE_S(uint64 instruction)
  */
 std::string NMD::CMP_LT_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3836,9 +3836,9 @@ std::string NMD::CMP_LT_PH(uint64 instruction)
  */
 std::string NMD::CMP_LT_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3860,9 +3860,9 @@ std::string NMD::CMP_LT_S(uint64 instruction)
  */
 std::string NMD::CMP_NE_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3884,9 +3884,9 @@ std::string NMD::CMP_NE_D(uint64 instruction)
  */
 std::string NMD::CMP_NE_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3908,9 +3908,9 @@ std::string NMD::CMP_NE_S(uint64 instruction)
  */
 std::string NMD::CMP_OR_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3932,9 +3932,9 @@ std::string NMD::CMP_OR_D(uint64 instruction)
  */
 std::string NMD::CMP_OR_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3956,9 +3956,9 @@ std::string NMD::CMP_OR_S(uint64 instruction)
  */
 std::string NMD::CMP_SAF_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -3980,9 +3980,9 @@ std::string NMD::CMP_SAF_D(uint64 instruction)
  */
 std::string NMD::CMP_SAF_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4004,9 +4004,9 @@ std::string NMD::CMP_SAF_S(uint64 instruction)
  */
 std::string NMD::CMP_SEQ_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4028,9 +4028,9 @@ std::string NMD::CMP_SEQ_D(uint64 instruction)
  */
 std::string NMD::CMP_SEQ_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4052,9 +4052,9 @@ std::string NMD::CMP_SEQ_S(uint64 instruction)
  */
 std::string NMD::CMP_SLE_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4076,9 +4076,9 @@ std::string NMD::CMP_SLE_D(uint64 instruction)
  */
 std::string NMD::CMP_SLE_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4100,9 +4100,9 @@ std::string NMD::CMP_SLE_S(uint64 instruction)
  */
 std::string NMD::CMP_SLT_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4124,9 +4124,9 @@ std::string NMD::CMP_SLT_D(uint64 instruction)
  */
 std::string NMD::CMP_SLT_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4148,9 +4148,9 @@ std::string NMD::CMP_SLT_S(uint64 instruction)
  */
 std::string NMD::CMP_SNE_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4172,9 +4172,9 @@ std::string NMD::CMP_SNE_D(uint64 instruction)
  */
 std::string NMD::CMP_SNE_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4196,9 +4196,9 @@ std::string NMD::CMP_SNE_S(uint64 instruction)
  */
 std::string NMD::CMP_SOR_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4220,9 +4220,9 @@ std::string NMD::CMP_SOR_D(uint64 instruction)
  */
 std::string NMD::CMP_SOR_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4244,9 +4244,9 @@ std::string NMD::CMP_SOR_S(uint64 instruction)
  */
 std::string NMD::CMP_SUEQ_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4268,9 +4268,9 @@ std::string NMD::CMP_SUEQ_D(uint64 instruction)
  */
 std::string NMD::CMP_SUEQ_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4292,9 +4292,9 @@ std::string NMD::CMP_SUEQ_S(uint64 instruction)
  */
 std::string NMD::CMP_SULE_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4316,9 +4316,9 @@ std::string NMD::CMP_SULE_D(uint64 instruction)
  */
 std::string NMD::CMP_SULE_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4340,9 +4340,9 @@ std::string NMD::CMP_SULE_S(uint64 instruction)
  */
 std::string NMD::CMP_SULT_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4364,9 +4364,9 @@ std::string NMD::CMP_SULT_D(uint64 instruction)
  */
 std::string NMD::CMP_SULT_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4388,9 +4388,9 @@ std::string NMD::CMP_SULT_S(uint64 instruction)
  */
 std::string NMD::CMP_SUN_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4412,9 +4412,9 @@ std::string NMD::CMP_SUN_D(uint64 instruction)
  */
 std::string NMD::CMP_SUNE_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4436,9 +4436,9 @@ std::string NMD::CMP_SUNE_D(uint64 instruction)
  */
 std::string NMD::CMP_SUNE_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4460,9 +4460,9 @@ std::string NMD::CMP_SUNE_S(uint64 instruction)
  */
 std::string NMD::CMP_SUN_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4484,9 +4484,9 @@ std::string NMD::CMP_SUN_S(uint64 instruction)
  */
 std::string NMD::CMP_UEQ_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4508,9 +4508,9 @@ std::string NMD::CMP_UEQ_D(uint64 instruction)
  */
 std::string NMD::CMP_UEQ_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4532,9 +4532,9 @@ std::string NMD::CMP_UEQ_S(uint64 instruction)
  */
 std::string NMD::CMP_ULE_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4556,9 +4556,9 @@ std::string NMD::CMP_ULE_D(uint64 instruction)
  */
 std::string NMD::CMP_ULE_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4580,9 +4580,9 @@ std::string NMD::CMP_ULE_S(uint64 instruction)
  */
 std::string NMD::CMP_ULT_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4604,9 +4604,9 @@ std::string NMD::CMP_ULT_D(uint64 instruction)
  */
 std::string NMD::CMP_ULT_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4628,9 +4628,9 @@ std::string NMD::CMP_ULT_S(uint64 instruction)
  */
 std::string NMD::CMP_UN_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4652,9 +4652,9 @@ std::string NMD::CMP_UN_D(uint64 instruction)
  */
 std::string NMD::CMP_UNE_D(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4676,9 +4676,9 @@ std::string NMD::CMP_UNE_D(uint64 instruction)
  */
 std::string NMD::CMP_UNE_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4700,9 +4700,9 @@ std::string NMD::CMP_UNE_S(uint64 instruction)
  */
 std::string NMD::CMP_UN_S(uint64 instruction)
 {
-    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
+    uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
     std::string fs = FPR(copy(fs_value));
@@ -4725,8 +4725,8 @@ std::string NMD::CMP_UN_S(uint64 instruction)
 std::string NMD::CMPGDU_EQ_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -4749,8 +4749,8 @@ std::string NMD::CMPGDU_EQ_QB(uint64 instruction)
 std::string NMD::CMPGDU_LE_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -4773,8 +4773,8 @@ std::string NMD::CMPGDU_LE_QB(uint64 instruction)
 std::string NMD::CMPGDU_LT_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -4797,8 +4797,8 @@ std::string NMD::CMPGDU_LT_QB(uint64 instruction)
 std::string NMD::CMPGU_EQ_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -4821,8 +4821,8 @@ std::string NMD::CMPGU_EQ_QB(uint64 instruction)
 std::string NMD::CMPGU_LE_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -4845,8 +4845,8 @@ std::string NMD::CMPGU_LE_QB(uint64 instruction)
 std::string NMD::CMPGU_LT_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -4954,8 +4954,8 @@ std::string NMD::COP2_1(uint64 instruction)
  */
 std::string NMD::CTC1(uint64 instruction)
 {
-    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string cs = CPR(copy(cs_value));
@@ -4976,8 +4976,8 @@ std::string NMD::CTC1(uint64 instruction)
  */
 std::string NMD::CTC2(uint64 instruction)
 {
-    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string cs = CPR(copy(cs_value));
@@ -4998,8 +4998,8 @@ std::string NMD::CTC2(uint64 instruction)
  */
 std::string NMD::CVT_D_L(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5020,8 +5020,8 @@ std::string NMD::CVT_D_L(uint64 instruction)
  */
 std::string NMD::CVT_D_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5042,8 +5042,8 @@ std::string NMD::CVT_D_S(uint64 instruction)
  */
 std::string NMD::CVT_D_W(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5064,8 +5064,8 @@ std::string NMD::CVT_D_W(uint64 instruction)
  */
 std::string NMD::CVT_L_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5086,8 +5086,8 @@ std::string NMD::CVT_L_D(uint64 instruction)
  */
 std::string NMD::CVT_L_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5108,8 +5108,8 @@ std::string NMD::CVT_L_S(uint64 instruction)
  */
 std::string NMD::CVT_S_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5130,8 +5130,8 @@ std::string NMD::CVT_S_D(uint64 instruction)
  */
 std::string NMD::CVT_S_L(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5152,8 +5152,8 @@ std::string NMD::CVT_S_L(uint64 instruction)
  */
 std::string NMD::CVT_S_PL(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5174,8 +5174,8 @@ std::string NMD::CVT_S_PL(uint64 instruction)
  */
 std::string NMD::CVT_S_PU(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5196,8 +5196,8 @@ std::string NMD::CVT_S_PU(uint64 instruction)
  */
 std::string NMD::CVT_S_W(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5218,8 +5218,8 @@ std::string NMD::CVT_S_W(uint64 instruction)
  */
 std::string NMD::CVT_W_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5240,8 +5240,8 @@ std::string NMD::CVT_W_D(uint64 instruction)
  */
 std::string NMD::CVT_W_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -5285,8 +5285,8 @@ std::string NMD::DADDIU_48_(uint64 instruction)
 std::string NMD::DADDIU_NEG_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -5309,8 +5309,8 @@ std::string NMD::DADDIU_NEG_(uint64 instruction)
 std::string NMD::DADDIU_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -5333,8 +5333,8 @@ std::string NMD::DADDIU_U12_(uint64 instruction)
 std::string NMD::DADD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -5357,8 +5357,8 @@ std::string NMD::DADD(uint64 instruction)
 std::string NMD::DADDU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -5425,8 +5425,8 @@ std::string NMD::DCLZ(uint64 instruction)
 std::string NMD::DDIV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -5449,8 +5449,8 @@ std::string NMD::DDIV(uint64 instruction)
 std::string NMD::DDIVU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -5491,9 +5491,9 @@ std::string NMD::DERET(uint64 instruction)
 std::string NMD::DEXTM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 msbd_value = extract_msbt_10_9_8_7_6(instruction);
     uint64 lsb_value = extract_lsb_4_3_2_1_0(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -5517,9 +5517,9 @@ std::string NMD::DEXTM(uint64 instruction)
 std::string NMD::DEXT(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 msbd_value = extract_msbt_10_9_8_7_6(instruction);
     uint64 lsb_value = extract_lsb_4_3_2_1_0(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -5543,9 +5543,9 @@ std::string NMD::DEXT(uint64 instruction)
 std::string NMD::DEXTU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 msbd_value = extract_msbt_10_9_8_7_6(instruction);
     uint64 lsb_value = extract_lsb_4_3_2_1_0(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -5569,9 +5569,9 @@ std::string NMD::DEXTU(uint64 instruction)
 std::string NMD::DINSM(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 msbd_value = extract_msbt_10_9_8_7_6(instruction);
     uint64 lsb_value = extract_lsb_4_3_2_1_0(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -5597,9 +5597,9 @@ std::string NMD::DINSM(uint64 instruction)
 std::string NMD::DINS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 msbd_value = extract_msbt_10_9_8_7_6(instruction);
     uint64 lsb_value = extract_lsb_4_3_2_1_0(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -5625,9 +5625,9 @@ std::string NMD::DINS(uint64 instruction)
 std::string NMD::DINSU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 msbd_value = extract_msbt_10_9_8_7_6(instruction);
     uint64 lsb_value = extract_lsb_4_3_2_1_0(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -5673,8 +5673,8 @@ std::string NMD::DI(uint64 instruction)
 std::string NMD::DIV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -5696,8 +5696,8 @@ std::string NMD::DIV(uint64 instruction)
  */
 std::string NMD::DIV_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -5720,8 +5720,8 @@ std::string NMD::DIV_D(uint64 instruction)
  */
 std::string NMD::DIV_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -5745,8 +5745,8 @@ std::string NMD::DIV_S(uint64 instruction)
 std::string NMD::DIVU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -5769,9 +5769,9 @@ std::string NMD::DIVU(uint64 instruction)
 std::string NMD::DLSA(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 u2_value = extract_u2_10_9(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -5862,8 +5862,8 @@ std::string NMD::DMFC1(uint64 instruction)
  */
 std::string NMD::DMFC2(uint64 instruction)
 {
-    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string cs = CPR(copy(cs_value));
@@ -5909,8 +5909,8 @@ std::string NMD::DMFGC0(uint64 instruction)
 std::string NMD::DMOD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -5933,8 +5933,8 @@ std::string NMD::DMOD(uint64 instruction)
 std::string NMD::DMODU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -6002,8 +6002,8 @@ std::string NMD::DMTC1(uint64 instruction)
  */
 std::string NMD::DMTC2(uint64 instruction)
 {
-    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string cs = CPR(copy(cs_value));
@@ -6069,8 +6069,8 @@ std::string NMD::DMT(uint64 instruction)
 std::string NMD::DMUH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -6093,8 +6093,8 @@ std::string NMD::DMUH(uint64 instruction)
 std::string NMD::DMUHU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -6117,8 +6117,8 @@ std::string NMD::DMUHU(uint64 instruction)
 std::string NMD::DMUL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -6141,8 +6141,8 @@ std::string NMD::DMUL(uint64 instruction)
 std::string NMD::DMULU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -6165,8 +6165,8 @@ std::string NMD::DMULU(uint64 instruction)
 std::string NMD::DPA_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6189,8 +6189,8 @@ std::string NMD::DPA_W_PH(uint64 instruction)
 std::string NMD::DPAQ_SA_L_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6213,8 +6213,8 @@ std::string NMD::DPAQ_SA_L_W(uint64 instruction)
 std::string NMD::DPAQ_S_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6237,8 +6237,8 @@ std::string NMD::DPAQ_S_W_PH(uint64 instruction)
 std::string NMD::DPAQX_SA_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6261,8 +6261,8 @@ std::string NMD::DPAQX_SA_W_PH(uint64 instruction)
 std::string NMD::DPAQX_S_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6285,8 +6285,8 @@ std::string NMD::DPAQX_S_W_PH(uint64 instruction)
 std::string NMD::DPAU_H_QBL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6309,8 +6309,8 @@ std::string NMD::DPAU_H_QBL(uint64 instruction)
 std::string NMD::DPAU_H_QBR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6333,8 +6333,8 @@ std::string NMD::DPAU_H_QBR(uint64 instruction)
 std::string NMD::DPAX_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6357,8 +6357,8 @@ std::string NMD::DPAX_W_PH(uint64 instruction)
 std::string NMD::DPS_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6381,8 +6381,8 @@ std::string NMD::DPS_W_PH(uint64 instruction)
 std::string NMD::DPSQ_SA_L_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6405,8 +6405,8 @@ std::string NMD::DPSQ_SA_L_W(uint64 instruction)
 std::string NMD::DPSQ_S_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6429,8 +6429,8 @@ std::string NMD::DPSQ_S_W_PH(uint64 instruction)
 std::string NMD::DPSQX_SA_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6453,8 +6453,8 @@ std::string NMD::DPSQX_SA_W_PH(uint64 instruction)
 std::string NMD::DPSQX_S_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6477,8 +6477,8 @@ std::string NMD::DPSQX_S_W_PH(uint64 instruction)
 std::string NMD::DPSU_H_QBL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6501,8 +6501,8 @@ std::string NMD::DPSU_H_QBL(uint64 instruction)
 std::string NMD::DPSU_H_QBR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6525,8 +6525,8 @@ std::string NMD::DPSU_H_QBR(uint64 instruction)
 std::string NMD::DPSX_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -6549,8 +6549,8 @@ std::string NMD::DPSX_W_PH(uint64 instruction)
 std::string NMD::DROTR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -6573,8 +6573,8 @@ std::string NMD::DROTR(uint64 instruction)
 std::string NMD::DROTR32(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -6597,8 +6597,8 @@ std::string NMD::DROTR32(uint64 instruction)
 std::string NMD::DROTRV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -6621,9 +6621,9 @@ std::string NMD::DROTRV(uint64 instruction)
 std::string NMD::DROTX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_5_4_3_2_1_0(instruction);
-    uint64 shiftx_value = extract_shiftx_11_10_9_8_7_6(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shiftx_value = extract_shiftx_11_10_9_8_7_6(instruction);
+    uint64 shift_value = extract_shift_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -6647,8 +6647,8 @@ std::string NMD::DROTX(uint64 instruction)
 std::string NMD::DSLL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -6671,8 +6671,8 @@ std::string NMD::DSLL(uint64 instruction)
 std::string NMD::DSLL32(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -6695,8 +6695,8 @@ std::string NMD::DSLL32(uint64 instruction)
 std::string NMD::DSLLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -6719,8 +6719,8 @@ std::string NMD::DSLLV(uint64 instruction)
 std::string NMD::DSRA(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -6743,8 +6743,8 @@ std::string NMD::DSRA(uint64 instruction)
 std::string NMD::DSRA32(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -6767,8 +6767,8 @@ std::string NMD::DSRA32(uint64 instruction)
 std::string NMD::DSRAV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -6791,8 +6791,8 @@ std::string NMD::DSRAV(uint64 instruction)
 std::string NMD::DSRL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -6815,8 +6815,8 @@ std::string NMD::DSRL(uint64 instruction)
 std::string NMD::DSRL32(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -6839,8 +6839,8 @@ std::string NMD::DSRL32(uint64 instruction)
 std::string NMD::DSRLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -6863,8 +6863,8 @@ std::string NMD::DSRLV(uint64 instruction)
 std::string NMD::DSUB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -6887,8 +6887,8 @@ std::string NMD::DSUB(uint64 instruction)
 std::string NMD::DSUBU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7112,8 +7112,8 @@ std::string NMD::EXTD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7138,8 +7138,8 @@ std::string NMD::EXTD32(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7187,8 +7187,8 @@ std::string NMD::EXTPDP(uint64 instruction)
 std::string NMD::EXTPDPV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7235,8 +7235,8 @@ std::string NMD::EXTP(uint64 instruction)
 std::string NMD::EXTPV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7355,8 +7355,8 @@ std::string NMD::EXTR_W(uint64 instruction)
 std::string NMD::EXTRV_RS_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7379,8 +7379,8 @@ std::string NMD::EXTRV_RS_W(uint64 instruction)
 std::string NMD::EXTRV_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7403,8 +7403,8 @@ std::string NMD::EXTRV_R_W(uint64 instruction)
 std::string NMD::EXTRV_S_H(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7427,8 +7427,8 @@ std::string NMD::EXTRV_S_H(uint64 instruction)
 std::string NMD::EXTRV_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ac = AC(copy(ac_value));
@@ -7453,8 +7453,8 @@ std::string NMD::EXTW(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
     uint64 shift_value = extract_shift_10_9_8_7_6(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7477,8 +7477,8 @@ std::string NMD::EXTW(uint64 instruction)
  */
 std::string NMD::FLOOR_L_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -7499,8 +7499,8 @@ std::string NMD::FLOOR_L_D(uint64 instruction)
  */
 std::string NMD::FLOOR_L_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -7521,8 +7521,8 @@ std::string NMD::FLOOR_L_S(uint64 instruction)
  */
 std::string NMD::FLOOR_W_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -7543,8 +7543,8 @@ std::string NMD::FLOOR_W_D(uint64 instruction)
  */
 std::string NMD::FLOOR_W_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -7566,8 +7566,8 @@ std::string NMD::FLOOR_W_S(uint64 instruction)
 std::string NMD::FORK(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -7852,8 +7852,8 @@ std::string NMD::LB_S9_(uint64 instruction)
 std::string NMD::LB_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -7970,8 +7970,8 @@ std::string NMD::LBU_S9_(uint64 instruction)
 std::string NMD::LBU_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8018,8 +8018,8 @@ std::string NMD::LBUE(uint64 instruction)
 std::string NMD::LBUX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -8042,8 +8042,8 @@ std::string NMD::LBUX(uint64 instruction)
 std::string NMD::LBX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -8112,8 +8112,8 @@ std::string NMD::LD_S9_(uint64 instruction)
 std::string NMD::LD_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8326,8 +8326,8 @@ std::string NMD::LDPC_48_(uint64 instruction)
 std::string NMD::LDX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -8350,8 +8350,8 @@ std::string NMD::LDX(uint64 instruction)
 std::string NMD::LDXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -8444,8 +8444,8 @@ std::string NMD::LH_S9_(uint64 instruction)
 std::string NMD::LH_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8562,8 +8562,8 @@ std::string NMD::LHU_S9_(uint64 instruction)
 std::string NMD::LHU_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -8610,8 +8610,8 @@ std::string NMD::LHUE(uint64 instruction)
 std::string NMD::LHUX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -8634,8 +8634,8 @@ std::string NMD::LHUX(uint64 instruction)
 std::string NMD::LHUXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -8658,8 +8658,8 @@ std::string NMD::LHUXS(uint64 instruction)
 std::string NMD::LHXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -8682,8 +8682,8 @@ std::string NMD::LHXS(uint64 instruction)
 std::string NMD::LHX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -8798,8 +8798,8 @@ std::string NMD::LLD(uint64 instruction)
 std::string NMD::LLDP(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ru = GPR(copy(ru_value));
@@ -8846,8 +8846,8 @@ std::string NMD::LLE(uint64 instruction)
 std::string NMD::LLWP(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ru = GPR(copy(ru_value));
@@ -8870,8 +8870,8 @@ std::string NMD::LLWP(uint64 instruction)
 std::string NMD::LLWPE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ru = GPR(copy(ru_value));
@@ -9080,8 +9080,8 @@ std::string NMD::LW_SP_(uint64 instruction)
 std::string NMD::LW_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9364,8 +9364,8 @@ std::string NMD::LWU_S9_(uint64 instruction)
 std::string NMD::LWU_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -9388,8 +9388,8 @@ std::string NMD::LWU_U12_(uint64 instruction)
 std::string NMD::LWUX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -9412,8 +9412,8 @@ std::string NMD::LWUX(uint64 instruction)
 std::string NMD::LWUXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -9436,8 +9436,8 @@ std::string NMD::LWUXS(uint64 instruction)
 std::string NMD::LWX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -9459,9 +9459,9 @@ std::string NMD::LWX(uint64 instruction)
  */
 std::string NMD::LWXS_16_(uint64 instruction)
 {
-    uint64 rd3_value = extract_rd3_3_2_1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 rd3_value = extract_rd3_3_2_1(instruction);
 
     std::string rd3 = GPR(encode_gpr3(rd3_value));
     std::string rs3 = GPR(encode_gpr3(rs3_value));
@@ -9484,8 +9484,8 @@ std::string NMD::LWXS_16_(uint64 instruction)
 std::string NMD::LWXS_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -9508,8 +9508,8 @@ std::string NMD::LWXS_32_(uint64 instruction)
 std::string NMD::MADD_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9531,8 +9531,8 @@ std::string NMD::MADD_DSP_(uint64 instruction)
  */
 std::string NMD::MADDF_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9555,8 +9555,8 @@ std::string NMD::MADDF_D(uint64 instruction)
  */
 std::string NMD::MADDF_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9580,8 +9580,8 @@ std::string NMD::MADDF_S(uint64 instruction)
 std::string NMD::MADDU_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9604,8 +9604,8 @@ std::string NMD::MADDU_DSP_(uint64 instruction)
 std::string NMD::MAQ_S_W_PHL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9628,8 +9628,8 @@ std::string NMD::MAQ_S_W_PHL(uint64 instruction)
 std::string NMD::MAQ_S_W_PHR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9652,8 +9652,8 @@ std::string NMD::MAQ_S_W_PHR(uint64 instruction)
 std::string NMD::MAQ_SA_W_PHL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9676,8 +9676,8 @@ std::string NMD::MAQ_SA_W_PHL(uint64 instruction)
 std::string NMD::MAQ_SA_W_PHR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -9699,8 +9699,8 @@ std::string NMD::MAQ_SA_W_PHR(uint64 instruction)
  */
 std::string NMD::MAX_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9723,8 +9723,8 @@ std::string NMD::MAX_D(uint64 instruction)
  */
 std::string NMD::MAX_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9747,8 +9747,8 @@ std::string NMD::MAX_S(uint64 instruction)
  */
 std::string NMD::MAXA_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9771,8 +9771,8 @@ std::string NMD::MAXA_D(uint64 instruction)
  */
 std::string NMD::MAXA_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -9841,8 +9841,8 @@ std::string NMD::MFC1(uint64 instruction)
  */
 std::string NMD::MFC2(uint64 instruction)
 {
-    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string cs = CPR(copy(cs_value));
@@ -9933,8 +9933,8 @@ std::string NMD::MFHC1(uint64 instruction)
  */
 std::string NMD::MFHC2(uint64 instruction)
 {
-    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string cs = CPR(copy(cs_value));
@@ -10075,8 +10075,8 @@ std::string NMD::MFTR(uint64 instruction)
  */
 std::string NMD::MIN_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10099,8 +10099,8 @@ std::string NMD::MIN_D(uint64 instruction)
  */
 std::string NMD::MIN_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10123,8 +10123,8 @@ std::string NMD::MIN_S(uint64 instruction)
  */
 std::string NMD::MINA_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10147,8 +10147,8 @@ std::string NMD::MINA_D(uint64 instruction)
  */
 std::string NMD::MINA_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10172,8 +10172,8 @@ std::string NMD::MINA_S(uint64 instruction)
 std::string NMD::MOD(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -10196,8 +10196,8 @@ std::string NMD::MOD(uint64 instruction)
 std::string NMD::MODSUB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -10220,8 +10220,8 @@ std::string NMD::MODSUB(uint64 instruction)
 std::string NMD::MODU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -10243,8 +10243,8 @@ std::string NMD::MODU(uint64 instruction)
  */
 std::string NMD::MOV_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -10265,8 +10265,8 @@ std::string NMD::MOV_D(uint64 instruction)
  */
 std::string NMD::MOV_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -10287,9 +10287,9 @@ std::string NMD::MOV_S(uint64 instruction)
  */
 std::string NMD::MOVE_BALC(uint64 instruction)
 {
+    uint64 rtz4_value = extract_rtz4_27_26_25_23_22_21(instruction);
     uint64 rd1_value = extract_rdl_25_24(instruction);
     int64 s_value = extr_sil0il21bs1_il1il1bs20Tmsb21(instruction);
-    uint64 rtz4_value = extract_rtz4_27_26_25_23_22_21(instruction);
 
     std::string rd1 = GPR(encode_rd1_from_rd(rd1_value));
     std::string rtz4 = GPR(encode_gpr4_zero(rtz4_value));
@@ -10388,8 +10388,8 @@ std::string NMD::MOVE(uint64 instruction)
 std::string NMD::MOVN(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -10412,8 +10412,8 @@ std::string NMD::MOVN(uint64 instruction)
 std::string NMD::MOVZ(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -10436,8 +10436,8 @@ std::string NMD::MOVZ(uint64 instruction)
 std::string NMD::MSUB_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -10459,8 +10459,8 @@ std::string NMD::MSUB_DSP_(uint64 instruction)
  */
 std::string NMD::MSUBF_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10483,8 +10483,8 @@ std::string NMD::MSUBF_D(uint64 instruction)
  */
 std::string NMD::MSUBF_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10508,8 +10508,8 @@ std::string NMD::MSUBF_S(uint64 instruction)
 std::string NMD::MSUBU_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -10577,8 +10577,8 @@ std::string NMD::MTC1(uint64 instruction)
  */
 std::string NMD::MTC2(uint64 instruction)
 {
-    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string cs = CPR(copy(cs_value));
@@ -10669,8 +10669,8 @@ std::string NMD::MTHC1(uint64 instruction)
  */
 std::string NMD::MTHC2(uint64 instruction)
 {
-    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 cs_value = extract_cs_20_19_18_17_16(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string cs = CPR(copy(cs_value));
@@ -10715,8 +10715,8 @@ std::string NMD::MTHGC0(uint64 instruction)
  */
 std::string NMD::MTHI_DSP_(uint64 instruction)
 {
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string ac = AC(copy(ac_value));
@@ -10737,8 +10737,8 @@ std::string NMD::MTHI_DSP_(uint64 instruction)
  */
 std::string NMD::MTHLIP(uint64 instruction)
 {
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string ac = AC(copy(ac_value));
@@ -10785,8 +10785,8 @@ std::string NMD::MTHTR(uint64 instruction)
  */
 std::string NMD::MTLO_DSP_(uint64 instruction)
 {
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string rs = GPR(copy(rs_value));
     std::string ac = AC(copy(ac_value));
@@ -10834,8 +10834,8 @@ std::string NMD::MTTR(uint64 instruction)
 std::string NMD::MUH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -10858,8 +10858,8 @@ std::string NMD::MUH(uint64 instruction)
 std::string NMD::MUHU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -10882,8 +10882,8 @@ std::string NMD::MUHU(uint64 instruction)
 std::string NMD::MUL_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -10927,8 +10927,8 @@ std::string NMD::MUL_4X4_(uint64 instruction)
  */
 std::string NMD::MUL_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -10952,8 +10952,8 @@ std::string NMD::MUL_D(uint64 instruction)
 std::string NMD::MUL_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -10976,8 +10976,8 @@ std::string NMD::MUL_PH(uint64 instruction)
 std::string NMD::MUL_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -10999,8 +10999,8 @@ std::string NMD::MUL_S_PH(uint64 instruction)
  */
 std::string NMD::MUL_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -11024,8 +11024,8 @@ std::string NMD::MUL_S(uint64 instruction)
 std::string NMD::MULEQ_S_W_PHL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11048,8 +11048,8 @@ std::string NMD::MULEQ_S_W_PHL(uint64 instruction)
 std::string NMD::MULEQ_S_W_PHR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11072,8 +11072,8 @@ std::string NMD::MULEQ_S_W_PHR(uint64 instruction)
 std::string NMD::MULEU_S_PH_QBL(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11096,8 +11096,8 @@ std::string NMD::MULEU_S_PH_QBL(uint64 instruction)
 std::string NMD::MULEU_S_PH_QBR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11120,8 +11120,8 @@ std::string NMD::MULEU_S_PH_QBR(uint64 instruction)
 std::string NMD::MULQ_RS_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11144,8 +11144,8 @@ std::string NMD::MULQ_RS_PH(uint64 instruction)
 std::string NMD::MULQ_RS_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11168,8 +11168,8 @@ std::string NMD::MULQ_RS_W(uint64 instruction)
 std::string NMD::MULQ_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11192,8 +11192,8 @@ std::string NMD::MULQ_S_PH(uint64 instruction)
 std::string NMD::MULQ_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11216,8 +11216,8 @@ std::string NMD::MULQ_S_W(uint64 instruction)
 std::string NMD::MULSA_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -11240,8 +11240,8 @@ std::string NMD::MULSA_W_PH(uint64 instruction)
 std::string NMD::MULSAQ_S_W_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -11264,8 +11264,8 @@ std::string NMD::MULSAQ_S_W_PH(uint64 instruction)
 std::string NMD::MULT_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -11288,8 +11288,8 @@ std::string NMD::MULT_DSP_(uint64 instruction)
 std::string NMD::MULTU_DSP_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ac_value = extract_ac_13_12(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ac_value = extract_ac_13_12(instruction);
 
     std::string ac = AC(copy(ac_value));
     std::string rs = GPR(copy(rs_value));
@@ -11312,8 +11312,8 @@ std::string NMD::MULTU_DSP_(uint64 instruction)
 std::string NMD::MULU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11335,8 +11335,8 @@ std::string NMD::MULU(uint64 instruction)
  */
 std::string NMD::NEG_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -11357,8 +11357,8 @@ std::string NMD::NEG_D(uint64 instruction)
  */
 std::string NMD::NEG_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -11416,8 +11416,8 @@ std::string NMD::NOP_32_(uint64 instruction)
 std::string NMD::NOR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11484,8 +11484,8 @@ std::string NMD::OR_16_(uint64 instruction)
 std::string NMD::OR_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11508,8 +11508,8 @@ std::string NMD::OR_32_(uint64 instruction)
 std::string NMD::ORI(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -11532,8 +11532,8 @@ std::string NMD::ORI(uint64 instruction)
 std::string NMD::PACKRL_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11574,8 +11574,8 @@ std::string NMD::PAUSE(uint64 instruction)
 std::string NMD::PICK_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11598,8 +11598,8 @@ std::string NMD::PICK_PH(uint64 instruction)
 std::string NMD::PICK_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11842,8 +11842,8 @@ std::string NMD::PRECEU_PH_QBR(uint64 instruction)
 std::string NMD::PRECR_QB_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11914,8 +11914,8 @@ std::string NMD::PRECR_SRA_R_PH_W(uint64 instruction)
 std::string NMD::PRECRQ_PH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11938,8 +11938,8 @@ std::string NMD::PRECRQ_PH_W(uint64 instruction)
 std::string NMD::PRECRQ_QB_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11962,8 +11962,8 @@ std::string NMD::PRECRQ_QB_PH(uint64 instruction)
 std::string NMD::PRECRQ_RS_PH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -11986,8 +11986,8 @@ std::string NMD::PRECRQ_RS_PH_W(uint64 instruction)
 std::string NMD::PRECRQU_S_QB_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -12009,9 +12009,9 @@ std::string NMD::PRECRQU_S_QB_PH(uint64 instruction)
  */
 std::string NMD::PREF_S9_(uint64 instruction)
 {
-    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
     uint64 hint_value = extract_hint_25_24_23_22_21(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    int64 s_value = extr_sil0il0bs8_il15il8bs1Tmsb8(instruction);
 
     std::string hint = IMMEDIATE(copy(hint_value));
     std::string s = IMMEDIATE(copy(s_value));
@@ -12034,8 +12034,8 @@ std::string NMD::PREF_S9_(uint64 instruction)
 std::string NMD::PREF_U12_(uint64 instruction)
 {
     uint64 hint_value = extract_hint_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string hint = IMMEDIATE(copy(hint_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -12195,8 +12195,8 @@ std::string NMD::RDPGPR(uint64 instruction)
  */
 std::string NMD::RECIP_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12217,8 +12217,8 @@ std::string NMD::RECIP_D(uint64 instruction)
  */
 std::string NMD::RECIP_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12372,8 +12372,8 @@ std::string NMD::RESTORE_JRC_16_(uint64 instruction)
  */
 std::string NMD::RESTORE_JRC_32_(uint64 instruction)
 {
-    uint64 count_value = extract_count_19_18_17_16(instruction);
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
+    uint64 count_value = extract_count_19_18_17_16(instruction);
     uint64 u_value = extr_uil3il3bs9Fmsb11(instruction);
     uint64 gp_value = extract_gp_2(instruction);
 
@@ -12417,8 +12417,8 @@ std::string NMD::RESTOREF(uint64 instruction)
  */
 std::string NMD::RINT_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12439,8 +12439,8 @@ std::string NMD::RINT_D(uint64 instruction)
  */
 std::string NMD::RINT_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12462,8 +12462,8 @@ std::string NMD::RINT_S(uint64 instruction)
 std::string NMD::ROTR(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -12486,8 +12486,8 @@ std::string NMD::ROTR(uint64 instruction)
 std::string NMD::ROTRV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -12510,10 +12510,10 @@ std::string NMD::ROTRV(uint64 instruction)
 std::string NMD::ROTX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
+    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
     uint64 shiftx_value = extr_shiftxil7il1bs4Fmsb4(instruction);
     uint64 stripe_value = extract_stripe_6(instruction);
-    uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -12538,8 +12538,8 @@ std::string NMD::ROTX(uint64 instruction)
  */
 std::string NMD::ROUND_L_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12560,8 +12560,8 @@ std::string NMD::ROUND_L_D(uint64 instruction)
  */
 std::string NMD::ROUND_L_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12582,8 +12582,8 @@ std::string NMD::ROUND_L_S(uint64 instruction)
  */
 std::string NMD::ROUND_W_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12604,8 +12604,8 @@ std::string NMD::ROUND_W_D(uint64 instruction)
  */
 std::string NMD::ROUND_W_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12626,8 +12626,8 @@ std::string NMD::ROUND_W_S(uint64 instruction)
  */
 std::string NMD::RSQRT_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12648,8 +12648,8 @@ std::string NMD::RSQRT_D(uint64 instruction)
  */
 std::string NMD::RSQRT_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -12808,8 +12808,8 @@ std::string NMD::SB_S9_(uint64 instruction)
 std::string NMD::SB_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -12856,8 +12856,8 @@ std::string NMD::SBE(uint64 instruction)
 std::string NMD::SBX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -12928,8 +12928,8 @@ std::string NMD::SCD(uint64 instruction)
 std::string NMD::SCDP(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ru = GPR(copy(ru_value));
@@ -12976,8 +12976,8 @@ std::string NMD::SCE(uint64 instruction)
 std::string NMD::SCWP(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ru = GPR(copy(ru_value));
@@ -13000,8 +13000,8 @@ std::string NMD::SCWP(uint64 instruction)
 std::string NMD::SCWPE(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 ru_value = extract_ru_7_6_5_4_3(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string ru = GPR(copy(ru_value));
@@ -13070,8 +13070,8 @@ std::string NMD::SD_S9_(uint64 instruction)
 std::string NMD::SD_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -13324,8 +13324,8 @@ std::string NMD::SDPC_48_(uint64 instruction)
 std::string NMD::SDXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -13348,8 +13348,8 @@ std::string NMD::SDXS(uint64 instruction)
 std::string NMD::SDX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -13415,8 +13415,8 @@ std::string NMD::SEH(uint64 instruction)
  */
 std::string NMD::SEL_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13439,8 +13439,8 @@ std::string NMD::SEL_D(uint64 instruction)
  */
 std::string NMD::SEL_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13463,8 +13463,8 @@ std::string NMD::SEL_S(uint64 instruction)
  */
 std::string NMD::SELEQZ_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13487,8 +13487,8 @@ std::string NMD::SELEQZ_D(uint64 instruction)
  */
 std::string NMD::SELEQZ_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13511,8 +13511,8 @@ std::string NMD::SELEQZ_S(uint64 instruction)
  */
 std::string NMD::SELNEZ_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13535,8 +13535,8 @@ std::string NMD::SELNEZ_D(uint64 instruction)
  */
 std::string NMD::SELNEZ_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -13560,8 +13560,8 @@ std::string NMD::SELNEZ_S(uint64 instruction)
 std::string NMD::SEQI(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -13654,8 +13654,8 @@ std::string NMD::SH_S9_(uint64 instruction)
 std::string NMD::SH_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -13842,8 +13842,8 @@ std::string NMD::SHLL_S_W(uint64 instruction)
 std::string NMD::SHLLV_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -13866,8 +13866,8 @@ std::string NMD::SHLLV_PH(uint64 instruction)
 std::string NMD::SHLLV_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -13890,8 +13890,8 @@ std::string NMD::SHLLV_QB(uint64 instruction)
 std::string NMD::SHLLV_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -13914,8 +13914,8 @@ std::string NMD::SHLLV_S_PH(uint64 instruction)
 std::string NMD::SHLLV_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -14058,8 +14058,8 @@ std::string NMD::SHRA_R_W(uint64 instruction)
 std::string NMD::SHRAV_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -14082,8 +14082,8 @@ std::string NMD::SHRAV_PH(uint64 instruction)
 std::string NMD::SHRAV_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -14106,8 +14106,8 @@ std::string NMD::SHRAV_QB(uint64 instruction)
 std::string NMD::SHRAV_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -14130,8 +14130,8 @@ std::string NMD::SHRAV_R_PH(uint64 instruction)
 std::string NMD::SHRAV_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -14154,8 +14154,8 @@ std::string NMD::SHRAV_R_QB(uint64 instruction)
 std::string NMD::SHRAV_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -14226,8 +14226,8 @@ std::string NMD::SHRL_QB(uint64 instruction)
 std::string NMD::SHRLV_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -14250,8 +14250,8 @@ std::string NMD::SHRLV_PH(uint64 instruction)
 std::string NMD::SHRLV_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rt = GPR(copy(rt_value));
@@ -14274,8 +14274,8 @@ std::string NMD::SHRLV_QB(uint64 instruction)
 std::string NMD::SHX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14298,8 +14298,8 @@ std::string NMD::SHX(uint64 instruction)
 std::string NMD::SHXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14366,8 +14366,8 @@ std::string NMD::SLL_16_(uint64 instruction)
 std::string NMD::SLL_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14390,8 +14390,8 @@ std::string NMD::SLL_32_(uint64 instruction)
 std::string NMD::SLLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14414,8 +14414,8 @@ std::string NMD::SLLV(uint64 instruction)
 std::string NMD::SLT(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14438,8 +14438,8 @@ std::string NMD::SLT(uint64 instruction)
 std::string NMD::SLTI(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14462,8 +14462,8 @@ std::string NMD::SLTI(uint64 instruction)
 std::string NMD::SLTIU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14486,8 +14486,8 @@ std::string NMD::SLTIU(uint64 instruction)
 std::string NMD::SLTU(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14510,8 +14510,8 @@ std::string NMD::SLTU(uint64 instruction)
 std::string NMD::SOV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14553,8 +14553,8 @@ std::string NMD::SPECIAL2(uint64 instruction)
  */
 std::string NMD::SQRT_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -14575,8 +14575,8 @@ std::string NMD::SQRT_D(uint64 instruction)
  */
 std::string NMD::SQRT_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -14622,8 +14622,8 @@ std::string NMD::SRA(uint64 instruction)
 std::string NMD::SRAV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14670,8 +14670,8 @@ std::string NMD::SRL_16_(uint64 instruction)
 std::string NMD::SRL_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 shift_value = extract_shift_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
@@ -14694,8 +14694,8 @@ std::string NMD::SRL_32_(uint64 instruction)
 std::string NMD::SRLV(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14718,8 +14718,8 @@ std::string NMD::SRLV(uint64 instruction)
 std::string NMD::SUB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14741,8 +14741,8 @@ std::string NMD::SUB(uint64 instruction)
  */
 std::string NMD::SUB_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -14765,8 +14765,8 @@ std::string NMD::SUB_D(uint64 instruction)
  */
 std::string NMD::SUB_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 fd_value = extract_fd_10_9_8_7_6(instruction);
 
     std::string fd = FPR(copy(fd_value));
@@ -14790,8 +14790,8 @@ std::string NMD::SUB_S(uint64 instruction)
 std::string NMD::SUBQ_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14815,8 +14815,8 @@ std::string NMD::SUBQ_PH(uint64 instruction)
 std::string NMD::SUBQ_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14840,8 +14840,8 @@ std::string NMD::SUBQ_S_PH(uint64 instruction)
 std::string NMD::SUBQ_S_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14865,8 +14865,8 @@ std::string NMD::SUBQ_S_W(uint64 instruction)
 std::string NMD::SUBQH_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14890,8 +14890,8 @@ std::string NMD::SUBQH_PH(uint64 instruction)
 std::string NMD::SUBQH_R_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14915,8 +14915,8 @@ std::string NMD::SUBQH_R_PH(uint64 instruction)
 std::string NMD::SUBQH_R_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14940,8 +14940,8 @@ std::string NMD::SUBQH_R_W(uint64 instruction)
 std::string NMD::SUBQH_W(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -14963,9 +14963,9 @@ std::string NMD::SUBQH_W(uint64 instruction)
  */
 std::string NMD::SUBU_16_(uint64 instruction)
 {
-    uint64 rd3_value = extract_rd3_3_2_1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
+    uint64 rd3_value = extract_rd3_3_2_1(instruction);
 
     std::string rd3 = GPR(encode_gpr3(rd3_value));
     std::string rs3 = GPR(encode_gpr3(rs3_value));
@@ -14988,8 +14988,8 @@ std::string NMD::SUBU_16_(uint64 instruction)
 std::string NMD::SUBU_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -15012,8 +15012,8 @@ std::string NMD::SUBU_32_(uint64 instruction)
 std::string NMD::SUBU_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -15036,8 +15036,8 @@ std::string NMD::SUBU_PH(uint64 instruction)
 std::string NMD::SUBU_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -15060,8 +15060,8 @@ std::string NMD::SUBU_QB(uint64 instruction)
 std::string NMD::SUBU_S_PH(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -15084,8 +15084,8 @@ std::string NMD::SUBU_S_PH(uint64 instruction)
 std::string NMD::SUBU_S_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -15109,8 +15109,8 @@ std::string NMD::SUBU_S_QB(uint64 instruction)
 std::string NMD::SUBUH_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -15134,8 +15134,8 @@ std::string NMD::SUBUH_QB(uint64 instruction)
 std::string NMD::SUBUH_R_QB(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -15296,8 +15296,8 @@ std::string NMD::SW_SP_(uint64 instruction)
 std::string NMD::SW_U12_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string u = IMMEDIATE(copy(u_value));
@@ -15534,8 +15534,8 @@ std::string NMD::SWPC_48_(uint64 instruction)
 std::string NMD::SWX(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -15558,8 +15558,8 @@ std::string NMD::SWX(uint64 instruction)
 std::string NMD::SWXS(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -15943,8 +15943,8 @@ std::string NMD::TNE(uint64 instruction)
  */
 std::string NMD::TRUNC_L_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -15965,8 +15965,8 @@ std::string NMD::TRUNC_L_D(uint64 instruction)
  */
 std::string NMD::TRUNC_L_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -15987,8 +15987,8 @@ std::string NMD::TRUNC_L_S(uint64 instruction)
  */
 std::string NMD::TRUNC_W_D(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -16009,8 +16009,8 @@ std::string NMD::TRUNC_W_D(uint64 instruction)
  */
 std::string NMD::TRUNC_W_S(uint64 instruction)
 {
-    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
     uint64 ft_value = extract_ft_20_19_18_17_16(instruction);
+    uint64 fs_value = extract_fs_15_14_13_12_11(instruction);
 
     std::string ft = FPR(copy(ft_value));
     std::string fs = FPR(copy(fs_value));
@@ -16287,8 +16287,8 @@ std::string NMD::XOR_16_(uint64 instruction)
 std::string NMD::XOR_32_(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 rd_value = extract_rd_15_14_13_12_11(instruction);
 
     std::string rd = GPR(copy(rd_value));
     std::string rs = GPR(copy(rs_value));
@@ -16311,8 +16311,8 @@ std::string NMD::XOR_32_(uint64 instruction)
 std::string NMD::XORI(uint64 instruction)
 {
     uint64 rt_value = extract_rt_25_24_23_22_21(instruction);
-    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
     uint64 rs_value = extract_rs_20_19_18_17_16(instruction);
+    uint64 u_value = extract_u_11_10_9_8_7_6_5_4_3_2_1_0(instruction);
 
     std::string rt = GPR(copy(rt_value));
     std::string rs = GPR(copy(rs_value));
-- 
2.7.4
