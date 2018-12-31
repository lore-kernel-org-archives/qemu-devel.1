Received: from eggs.gnu.org ([208.118.235.92]:57484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz1T-000677-59
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz1P-0004OZ-C4
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:30 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60635 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz1H-0003yx-Lx
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:21 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:25 +0100
Message-Id: <1546268200-26966-30-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 29/44] disas: nanoMIPS: Rename the decoder of
 'gpr4' gpr encoding type
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

Rename the decoder of 'gpr4' gpr encoding type in nanoMIPS
disassembler.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 20 ++++++++++----------
 disas/nanomips.h   |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 1c313f3..5f6c93c 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -406,7 +406,7 @@ uint64 NMD::encode_gpr4_zero(uint64 d)
 }
 
 
-uint64 NMD::encode_gpr4(uint64 d)
+uint64 NMD::decode_gpr_gpr4(uint64 d)
 {
     static uint64 register_list[] = {  8,  9, 10, 11,  4,  5,  6,  7,
                                       16, 17, 18, 19, 20, 21, 22, 23 };
@@ -2363,8 +2363,8 @@ std::string NMD::ADDU_4X4_(uint64 instruction)
     uint64 rt4_value = extract_rt4_9_7_6_5(instruction);
     uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
 
-    std::string rs4 = GPR(encode_gpr4(rs4_value));
-    std::string rt4 = GPR(encode_gpr4(rt4_value));
+    std::string rs4 = GPR(decode_gpr_gpr4(rs4_value));
+    std::string rt4 = GPR(decode_gpr_gpr4(rt4_value));
 
     return img::format("ADDU %s, %s", rs4, rt4);
 }
@@ -9046,9 +9046,9 @@ std::string NMD::LW_4X4_(uint64 instruction)
     uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 u_value = extract_u_3_8__s2(instruction);
 
-    std::string rt4 = GPR(encode_gpr4(rt4_value));
+    std::string rt4 = GPR(decode_gpr_gpr4(rt4_value));
     std::string u = IMMEDIATE(copy(u_value));
-    std::string rs4 = GPR(encode_gpr4(rs4_value));
+    std::string rs4 = GPR(decode_gpr_gpr4(rs4_value));
 
     return img::format("LW %s, %s(%s)", rt4, u, rs4);
 }
@@ -10419,8 +10419,8 @@ std::string NMD::MOVEP_REV_(uint64 instruction)
     uint64 rd2_value = extract_rd2_3_8(instruction);
     uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
 
-    std::string rs4 = GPR(encode_gpr4(rs4_value));
-    std::string rt4 = GPR(encode_gpr4(rt4_value));
+    std::string rs4 = GPR(decode_gpr_gpr4(rs4_value));
+    std::string rt4 = GPR(decode_gpr_gpr4(rt4_value));
     std::string rd2 = GPR(encode_rd2_reg1(rd2_value));
     std::string rs2 = GPR(encode_rd2_reg2(rd2_value));
     /* !!!!!!!!!! - no conversion function */
@@ -10985,8 +10985,8 @@ std::string NMD::MUL_4X4_(uint64 instruction)
     uint64 rt4_value = extract_rt4_9_7_6_5(instruction);
     uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
 
-    std::string rs4 = GPR(encode_gpr4(rs4_value));
-    std::string rt4 = GPR(encode_gpr4(rt4_value));
+    std::string rs4 = GPR(decode_gpr_gpr4(rs4_value));
+    std::string rt4 = GPR(decode_gpr_gpr4(rt4_value));
 
     return img::format("MUL %s, %s", rs4, rt4);
 }
@@ -15264,7 +15264,7 @@ std::string NMD::SW_4X4_(uint64 instruction)
 
     std::string rtz4 = GPR(encode_gpr4_zero(rtz4_value));
     std::string u = IMMEDIATE(copy(u_value));
-    std::string rs4 = GPR(encode_gpr4(rs4_value));
+    std::string rs4 = GPR(decode_gpr_gpr4(rs4_value));
 
     return img::format("SW %s, %s(%s)", rtz4, u, rs4);
 }
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 757915c..109b131 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -109,7 +109,7 @@ private:
     uint64 decode_gpr_gpr3_src_store(uint64 d);
     uint64 encode_rd1_from_rd(uint64 d);
     uint64 encode_gpr4_zero(uint64 d);
-    uint64 encode_gpr4(uint64 d);
+    uint64 decode_gpr_gpr4(uint64 d);
     uint64 encode_rd2_reg1(uint64 d);
     uint64 encode_rd2_reg2(uint64 d);
 
-- 
2.7.4
