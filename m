Received: from eggs.gnu.org ([208.118.235.92]:57279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz1A-0005jh-OJ
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz18-000450-Ua
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:12 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60628 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz18-0003rg-JX
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:10 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:23 +0100
Message-Id: <1546268200-26966-28-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 27/44] disas: nanoMIPS: Rename the decoder of
 'gpr3.src.store' gpr encoding type
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

Rename the decoder of 'gpr3.src.store' gpr encoding type in nanoMIPS
disassembler.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 10 +++++-----
 disas/nanomips.h   |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 30988f8..7c56162 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -349,7 +349,7 @@ uint64 NMD::decode_gpr_gpr3(uint64 d)
 }
 
 
-uint64 NMD::encode_gpr3_store(uint64 d)
+uint64 NMD::decode_gpr_gpr3_src_store(uint64 d)
 {
     static uint64 register_list[] = {  0, 17, 18, 19,  4,  5,  6,  7 };
     return renumber_registers(d, register_list,
@@ -12786,7 +12786,7 @@ std::string NMD::SB_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 u_value = extract_u_1_0(instruction);
 
-    std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
+    std::string rtz3 = GPR(decode_gpr_gpr3_src_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
     std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
@@ -13632,7 +13632,7 @@ std::string NMD::SH_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 u_value = extract_u_2_1__s1(instruction);
 
-    std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
+    std::string rtz3 = GPR(decode_gpr_gpr3_src_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
     std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
@@ -15206,7 +15206,7 @@ std::string NMD::SW_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 u_value = extract_u_3_2_1_0__s2(instruction);
 
-    std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
+    std::string rtz3 = GPR(decode_gpr_gpr3_src_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
     std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
@@ -15253,7 +15253,7 @@ std::string NMD::SW_GP16_(uint64 instruction)
     uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
     uint64 rtz3_value = extract_rtz3_9_8_7(instruction);
 
-    std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
+    std::string rtz3 = GPR(decode_gpr_gpr3_src_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
 
     return img::format("SW %s, %s($%d)", rtz3, u, 28);
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 78f8f9b..757915c 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -106,7 +106,7 @@ private:
     uint64 renumber_registers(uint64 index, uint64 *register_list,
                               size_t register_list_size);
     uint64 decode_gpr_gpr3(uint64 d);
-    uint64 encode_gpr3_store(uint64 d);
+    uint64 decode_gpr_gpr3_src_store(uint64 d);
     uint64 encode_rd1_from_rd(uint64 d);
     uint64 encode_gpr4_zero(uint64 d);
     uint64 encode_gpr4(uint64 d);
-- 
2.7.4
