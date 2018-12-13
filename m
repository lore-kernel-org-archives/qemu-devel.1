Received: from eggs.gnu.org ([2001:4830:134:3::10]:51091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87864c7eb=Alistair.Francis@wdc.com>)
	id 1gXVqT-0000qH-A5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87864c7eb=Alistair.Francis@wdc.com>)
	id 1gXVqP-00069J-An
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:36:25 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 13 Dec 2018 18:36:17 +0000
Message-ID: <b67c23ca669530709501412a8daf4bb7f90ecc8c.1544726124.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/1] sifive_u: Set 'clock-frequency' DT
 property for SiFive UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, Anup Patel <Anup.Patel@wdc.com>

From: Anup Patel <anup@brainfault.org>

The 'clock-frequency' DT property is required by U-Boot to compute
the divider value. This patch sets the 'clock-frequency' DT property
of the SiFive UART device tree node (similar to virt machine).

Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ef07df2442..f30bbfd1d6 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -225,6 +225,8 @@ static void create_fdt(SiFiveUState *s, const struct Me=
mmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_UART0].base,
         0x0, memmap[SIFIVE_U_UART0].size);
+    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
+                          SIFIVE_U_CLOCK_FREQ / 2);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle=
);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupts", 1);
=20
--=20
2.19.1
