Received: from eggs.gnu.org ([208.118.235.92]:38544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UL-0004np-NP
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UK-00080l-1B
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:57 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46262 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6UJ-0007gm-Mz
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:55 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:08:08 +0100
Message-Id: <1546535297-11040-36-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 35/44] disas: nanoMIPS: Rename the decoder of
 'gpr2.reg2' gpr encoding type
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

Rename the decoder of 'gpr2.reg2' gpr encoding type in nanoMIPS
disassembler.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 6 +++---
 disas/nanomips.h   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index c3b2bec..06d2400 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -498,7 +498,7 @@ uint64 NMD::decode_gpr_gpr2_reg1(uint64 d)
 }
 
 
-uint64 NMD::encode_rd2_reg2(uint64 d)
+uint64 NMD::decode_gpr_gpr2_reg2(uint64 d)
 {
     static uint64 register_list[] = {  5,  6,  7,  8 };
     return renumber_registers(d, register_list,
@@ -10468,7 +10468,7 @@ std::string NMD::MOVEP(uint64 instruction)
     uint64 rsz4_value = extract_rsz4_4_2_1_0(instruction);
 
     std::string rd2 = GPR(decode_gpr_gpr2_reg1(rd2_value));
-    std::string re2 = GPR(encode_rd2_reg2(rd2_value));
+    std::string re2 = GPR(decode_gpr_gpr2_reg2(rd2_value));
     /* !!!!!!!!!! - no conversion function */
     std::string rsz4 = GPR(decode_gpr_gpr4_zero(rsz4_value));
     std::string rtz4 = GPR(decode_gpr_gpr4_zero(rtz4_value));
@@ -10497,7 +10497,7 @@ std::string NMD::MOVEP_REV_(uint64 instruction)
     std::string rs4 = GPR(decode_gpr_gpr4(rs4_value));
     std::string rt4 = GPR(decode_gpr_gpr4(rt4_value));
     std::string rd2 = GPR(decode_gpr_gpr2_reg1(rd2_value));
-    std::string rs2 = GPR(encode_rd2_reg2(rd2_value));
+    std::string rs2 = GPR(decode_gpr_gpr2_reg2(rd2_value));
     /* !!!!!!!!!! - no conversion function */
 
     return img::format("MOVEP %s, %s, %s, %s", rs4, rt4, rd2, rs2);
diff --git a/disas/nanomips.h b/disas/nanomips.h
index d928757..9df1ab2 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -111,7 +111,7 @@ private:
     uint64 decode_gpr_gpr4_zero(uint64 d);
     uint64 decode_gpr_gpr4(uint64 d);
     uint64 decode_gpr_gpr2_reg1(uint64 d);
-    uint64 encode_rd2_reg2(uint64 d);
+    uint64 decode_gpr_gpr2_reg2(uint64 d);
 
     uint64 copy(uint64 d);
     int64 copy(int64 d);
-- 
2.7.4
