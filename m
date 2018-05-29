Received: from eggs.gnu.org ([2001:4830:134:3::10]:36997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDG-0001Y4-QG
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDF-00043J-U2
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:46 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:44546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDF-00042s-Mt
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:45 -0400
Received: by mail-wr0-x236.google.com with SMTP id y15-v6so24693169wrg.11
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:45 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:52 +0200
Message-Id: <20180529105011.1914-20-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 19/38] target-microblaze: dec_msr: Fix MTS to
 FSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Fix moves to FSR. Not only bit 31 is accessible.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6a270fbece..6f2cafa88a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -533,11 +533,9 @@ static void dec_msr(DisasContext *dc)
                 break;
             case SR_EAR:
             case SR_ESR:
+            case SR_FSR:
                 tcg_gen_mov_i32(cpu_SR[sr], cpu_R[dc->ra]);
                 break;
-            case 0x7:
-                tcg_gen_andi_i32(cpu_SR[SR_FSR], cpu_R[dc->ra], 31);
-                break;
             case 0x800:
                 tcg_gen_st_i32(cpu_R[dc->ra],
                                cpu_env, offsetof(CPUMBState, slr));
-- 
2.14.1
