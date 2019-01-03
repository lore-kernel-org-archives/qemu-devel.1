Received: from eggs.gnu.org ([208.118.235.92]:38553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UM-0004oZ-9S
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UK-00081J-C9
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:58 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46264 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6UK-0007hr-36
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:56 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:08:10 +0100
Message-Id: <1546535297-11040-38-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 37/44] disas: nanoMIPS: Rename the decoder of
 'gpr1' gpr encoding type
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

Rename the decoder of 'gpr1' gpr encoding type in nanoMIPS
disassembler.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 4 ++--
 disas/nanomips.h   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index fe0c4af..6f15821 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -389,7 +389,7 @@ uint64 NMD::decode_gpr_gpr3_src_store(uint64 d)
 }
 
 
-uint64 NMD::encode_rd1_from_rd(uint64 d)
+uint64 NMD::decode_gpr_gpr1(uint64 d)
 {
     static uint64 register_list[] = {  4,  5 };
     return renumber_registers(d, register_list,
@@ -10465,7 +10465,7 @@ std::string NMD::MOVE_BALC(uint64 instruction)
     uint64 rd1_value = extract_rdl_25_24(instruction);
     int64 s_value = extract_s__se21_0_20_to_1_s1(instruction);
 
-    std::string rd1 = GPR(encode_rd1_from_rd(rd1_value));
+    std::string rd1 = GPR(decode_gpr_gpr1(rd1_value));
     std::string rtz4 = GPR(decode_gpr_gpr4_zero(rtz4_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
 
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 9df1ab2..d6a6e3f 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -107,7 +107,7 @@ private:
                               size_t register_list_size);
     uint64 decode_gpr_gpr3(uint64 d);
     uint64 decode_gpr_gpr3_src_store(uint64 d);
-    uint64 encode_rd1_from_rd(uint64 d);
+    uint64 decode_gpr_gpr1(uint64 d);
     uint64 decode_gpr_gpr4_zero(uint64 d);
     uint64 decode_gpr_gpr4(uint64 d);
     uint64 decode_gpr_gpr2_reg1(uint64 d);
-- 
2.7.4
