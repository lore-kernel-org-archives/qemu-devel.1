Received: from eggs.gnu.org ([2001:4830:134:3::10]:41410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXo-00022H-OH
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXn-0000WU-Q2
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:56 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dSKXn-0000W0-Il
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:55 -0400
Received: by mail-lf0-x242.google.com with SMTP id f28so17185976lfi.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:54:55 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  4 Jul 2017 11:54:34 +0200
Message-Id: <1499162088-1562-4-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
References: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 03/17] target-microblaze: Don't hard code 0xb
 as initial MB version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Don't hard code 0xb as initial MB version.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index af70faa..4bc77df 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -152,8 +152,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                        | PVR0_USE_HW_MUL_MASK \
                        | PVR0_USE_EXC_MASK \
                        | PVR0_USE_ICACHE_MASK \
-                       | PVR0_USE_DCACHE_MASK \
-                       | (0xb << 8);
+                       | PVR0_USE_DCACHE_MASK;
     env->pvr.regs[2] = PVR2_D_OPB_MASK \
                         | PVR2_D_LMB_MASK \
                         | PVR2_I_OPB_MASK \
-- 
2.7.4
