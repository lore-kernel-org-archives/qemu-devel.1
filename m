Received: from eggs.gnu.org ([2001:4830:134:3::10]:37136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDZ-0001oW-At
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDY-0004GS-JL
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:05 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:39229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDY-0004G3-DV
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:04 -0400
Received: by mail-wm0-x22c.google.com with SMTP id f8-v6so39343918wmc.4
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:51:04 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:50:03 +0200
Message-Id: <20180529105011.1914-31-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 30/38] target-microblaze: Allow address sizes
 between 32 and 64 bits
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

Allow address sizes between 32 and 64 bits.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 71fc8d09fe..9b546a2c18 100644
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
