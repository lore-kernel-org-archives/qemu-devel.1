Received: from eggs.gnu.org ([2001:4830:134:3::10]:53931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1XT-0003X0-3A
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1XR-0000yK-MN
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:39 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1XR-0000xh-9w
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:37 -0400
Received: by mail-wm0-x243.google.com with SMTP id f8-v6so4257136wmc.4
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:52:37 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:38 +0200
Message-Id: <20180516185146.30708-31-edgar.iglesias@gmail.com>
In-Reply-To: <20180516185146.30708-1-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 30/38] target-microblaze: Allow address
 sizes between 32 and 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Allow address sizes between 32 and 64 bits.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index d0649fdaaa..8c1f850ab1 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -155,9 +155,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (cpu->cfg.addr_size != 32) {
-        error_setg(errp, "addr-size %d is out of range. "
-                   "Only 32bit is supported.",
+    if (cpu->cfg.addr_size < 32 || cpu->cfg.addr_size > 64) {
+        error_setg(errp, "addr-size %d is out of range (32 - 64)",
                    cpu->cfg.addr_size);
         return;
     }
-- 
2.14.1
