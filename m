Received: from eggs.gnu.org ([2001:4830:134:3::10]:49447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=709ee912d=Alistair.Francis@wdc.com>)
	id 1fYEVW-0004AK-6K
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=709ee912d=Alistair.Francis@wdc.com>)
	id 1fYEVT-00014R-1Z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:45:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=709ee912d=Alistair.Francis@wdc.com>)
	id 1fYEVS-0000fX-Ju
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:45:26 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 27 Jun 2018 10:44:33 -0700
Message-Id: <20180627174435.31800-6-alistair.francis@wdc.com>
In-Reply-To: <20180627174435.31800-1-alistair.francis@wdc.com>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 5/7] hw/riscv/sifive_u: Set the interrupt
 controler number of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, mjc@sifive.com
Cc: f4bug@amsat.org, alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>

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
2.17.1
