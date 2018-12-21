Received: from eggs.gnu.org ([2001:4830:134:3::10]:53018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNHO-0001fT-Si
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNHN-0004Ew-J8
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:04:02 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gaNHN-00046f-6M
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:04:01 -0500
Received: by mail-qt1-x842.google.com with SMTP id l12so6163727qtf.8
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 08:03:44 -0800 (PST)
Date: Fri, 21 Dec 2018 08:02:59 -0800
Message-Id: <20181221160307.14819-7-palmer@sifive.com>
In-Reply-To: <20181221160307.14819-1-palmer@sifive.com>
References: <20181221160307.14819-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 06/14] sifive_u: Set 'clock-frequency' DT
 property for SiFive UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>, Anup Patel <anup.patel@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Anup Patel <anup@brainfault.org>

The 'clock-frequency' DT property is required by U-Boot to compute
the divider value. This patch sets the 'clock-frequency' DT property
of the SiFive UART device tree node (similar to virt machine).

Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5c41ee5017e4..849fa2e6311a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -241,6 +241,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_UART0].base,
         0x0, memmap[SIFIVE_U_UART0].size);
+    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
+                          SIFIVE_U_CLOCK_FREQ / 2);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupts", 1);
 
-- 
2.18.1
