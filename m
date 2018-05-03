Received: from eggs.gnu.org ([2001:4830:134:3::10]:55417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAPR-0001PF-NS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAPM-0005Eq-4m
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:20:17 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAPL-0005Eg-TS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:20:12 -0400
Received: by mail-lf0-x241.google.com with SMTP id m18-v6so24928596lfb.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:20:11 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:19:22 +0200
Message-Id: <20180503091922.28733-30-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-1-edgar.iglesias@gmail.com>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 29/29] target-microblaze: Allow address
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Allow address sizes between 32 and 64 bits.

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
