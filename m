Received: from eggs.gnu.org ([2001:4830:134:3::10]:51258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=662fb86e2=Alistair.Francis@wdc.com>)
	id 1fHHSj-00068D-Cz
	for qemu-devel@nongnu.org; Fri, 11 May 2018 19:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=662fb86e2=Alistair.Francis@wdc.com>)
	id 1fHHSe-0000rY-GB
	for qemu-devel@nongnu.org; Fri, 11 May 2018 19:28:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=662fb86e2=Alistair.Francis@wdc.com>)
	id 1fHHSe-0000qV-3n
	for qemu-devel@nongnu.org; Fri, 11 May 2018 19:28:28 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 11 May 2018 16:28:16 -0700
Message-Id: <983ec72e6da807c6297e1bf12a8cc6ec02223c9e.1526081108.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1526081108.git.alistair.francis@wdc.com>
References: <cover.1526081108.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 5/7] hw/riscv/sifive_u: Set the interrupt
 controler number of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, alistair23@gmail.com, mjc@sifive.com

Set the interrupt-controller ndev to the correct number taken from the
HiFive Unleashed board.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 859f43c6f9..50389cdc90 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -187,7 +187,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         0x0, memmap[SIFIVE_U_PLIC].size);
     qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
-    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 4);
+    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
     qemu_fdt_setprop_cells(fdt, nodename, "phandle", 2);
     qemu_fdt_setprop_cells(fdt, nodename, "linux,phandle", 2);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
-- 
2.17.0
