Received: from eggs.gnu.org ([208.118.235.92]:47866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZx-0001kv-DP
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZt-0002RV-D6
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:05 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51255 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcWZt-00020o-38
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:01 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 27 Dec 2018 15:22:59 +0100
Message-Id: <1545920586-17815-20-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 19/26] disas: nanoMIPS: Rename the decoder
 of 'gpr2.reg1' gpr encoding type
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

Rename the decoder of 'gpr2.reg1' gpr encoding type in nanoMIPS
disassembler.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 6 +++---
 disas/nanomips.h   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 6578aa3..80f50fc 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -467,7 +467,7 @@ uint64 NMD::decode_gpr_gpr4(uint64 d)
 }
 
 
-uint64 NMD::encode_rd2_reg1(uint64 d)
+uint64 NMD::decode_gpr_gpr2_reg1(uint64 d)
 {
     static uint64 register_list[] = {  4,  5,  6,  7 };
     return renumber_registers(d, register_list,
@@ -10441,7 +10441,7 @@ std::string NMD::MOVEP(uint64 instruction)
     uint64 rd2_value = extract_rd2_3_8(instruction);
     uint64 rsz4_value = extract_rsz4_4_2_1_0(instruction);
 
-    std::string rd2 = GPR(encode_rd2_reg1(rd2_value));
+    std::string rd2 = GPR(decode_gpr_gpr2_reg1(rd2_value));
     std::string re2 = GPR(encode_rd2_reg2(rd2_value));
     /* !!!!!!!!!! - no conversion function */
     std::string rsz4 = GPR(decode_gpr_gpr4_zero(rsz4_value));
@@ -10470,7 +10470,7 @@ std::string NMD::MOVEP_REV_(uint64 instruction)
 
     std::string rs4 = GPR(decode_gpr_gpr4(rs4_value));
     std::string rt4 = GPR(decode_gpr_gpr4(rt4_value));
-    std::string rd2 = GPR(encode_rd2_reg1(rd2_value));
+    std::string rd2 = GPR(decode_gpr_gpr2_reg1(rd2_value));
     std::string rs2 = GPR(encode_rd2_reg2(rd2_value));
     /* !!!!!!!!!! - no conversion function */
 
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 917f33e..4c31392 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -110,7 +110,7 @@ private:
     uint64 encode_rd1_from_rd(uint64 d);
     uint64 decode_gpr_gpr4_zero(uint64 d);
     uint64 decode_gpr_gpr4(uint64 d);
-    uint64 encode_rd2_reg1(uint64 d);
+    uint64 decode_gpr_gpr2_reg1(uint64 d);
     uint64 encode_rd2_reg2(uint64 d);
 
     uint64 copy(uint64 d);
-- 
2.7.4
