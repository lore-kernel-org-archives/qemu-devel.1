Received: from eggs.gnu.org ([208.118.235.92]:48274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrb-0004bV-LX
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrZ-00081n-KZ
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:59 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833]:34801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gcCrZ-0007rW-C0
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:57 -0500
Received: by mail-qt1-x833.google.com with SMTP id r14so17897998qtp.1
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 09:20:37 -0800 (PST)
Date: Wed, 26 Dec 2018 09:20:04 -0800
Message-Id: <20181226172005.26990-14-palmer@sifive.com>
In-Reply-To: <20181226172005.26990-1-palmer@sifive.com>
References: <20181226172005.26990-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 13/14] riscv/cpu: use
 device_class_set_parent_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, Palmer Dabbelt <palmer@sifive.com>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a025a0a3baac..5e8a2cb2ba61 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -330,8 +330,8 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     CPUClass *cc = CPU_CLASS(c);
     DeviceClass *dc = DEVICE_CLASS(c);
 
-    mcc->parent_realize = dc->realize;
-    dc->realize = riscv_cpu_realize;
+    device_class_set_parent_realize(dc, riscv_cpu_realize,
+                                    &mcc->parent_realize);
 
     mcc->parent_reset = cc->reset;
     cc->reset = riscv_cpu_reset;
-- 
2.18.1
