Received: from eggs.gnu.org ([2001:4830:134:3::10]:42466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTY-00008e-He
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTV-00014N-9f
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:56 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:37312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHTV-00013q-44
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:53 -0400
Received: by mail-pl0-x22f.google.com with SMTP id w19-v6so11866691plq.4
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:17:53 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:05 +1200
Message-Id: <1527034517-7851-19-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 18/30] RISC-V: Add missing free for
 plic_hart_config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ad03113e0f72..321fa6e8122a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -385,6 +385,8 @@ static void riscv_virt_board_init(MachineState *machine)
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, SIFIVE_PLIC(s->plic)->irqs[UART0_IRQ], 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    g_free(plic_hart_config);
 }
 
 static void riscv_virt_board_machine_init(MachineClass *mc)
-- 
2.7.0
