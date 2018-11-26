Received: from eggs.gnu.org ([2001:4830:134:3::10]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gR7SW-0003JC-VD
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 22:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gR7SS-0001ul-2u
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 22:21:16 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 26 Nov 2018 11:20:38 +0800
Message-Id: <20181126032038.22044-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH] riscv/cpu: use device_class_set_parent_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: mjc@sifive.com, palmer@sifive.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, philmd@redhat.com, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 target/riscv/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a025a0a3ba..5e8a2cb2ba 100644
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
2.17.1
