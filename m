Received: from eggs.gnu.org ([2001:4830:134:3::10]:49751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=715e8d879=Alistair.Francis@wdc.com>)
	id 1faOGl-00084Z-8K
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=715e8d879=Alistair.Francis@wdc.com>)
	id 1faOGi-0005l1-8n
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:35:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=715e8d879=Alistair.Francis@wdc.com>)
	id 1faOGi-0005ir-0V
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:35:08 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue,  3 Jul 2018 09:34:43 -0700
Message-Id: <20180703163446.9943-5-alistair.francis@wdc.com>
In-Reply-To: <20180703163446.9943-1-alistair.francis@wdc.com>
References: <20180703163446.9943-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL v3 4/7] hw/riscv/sifive_u: Set the soc device
 tree node as a simple-bus
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

To allow Linux to ennumerate devices on the /soc/ node set it as a
"simple-bus".

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3883d7ff9c..f438a72c27 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -97,7 +97,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/soc");
     qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "ucbbar,spike-bare-soc");
+    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-- 
2.17.1
