Received: from eggs.gnu.org ([2001:4830:134:3::10]:45394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINVc-0003WJ-BP
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINVZ-0001yC-21
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:08:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINVY-0001vG-Ky
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:08:00 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Mon, 14 May 2018 17:07:48 -0700
Message-Id: <17631408b4e0beb01cce1747f97cc825a3484890.1526342674.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1526342674.git.alistair.francis@wdc.com>
References: <cover.1526342674.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 5/7] hw/riscv/sifive_u: Set the interrupt
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
Reviewed-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f438a72c27..f71527eaff 100644
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
