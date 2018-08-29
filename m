Received: from eggs.gnu.org ([2001:4830:134:3::10]:40780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4hy-0001gl-NY
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4ht-0004H3-9B
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:56:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4ht-0004EQ-0A
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:56:41 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 29 Aug 2018 10:56:28 -0700
Message-Id: <49a3344977c4953bc7d341cc22fae36c0258e8a6.1535565338.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1535565338.git.alistair.francis@wdc.com>
References: <cover.1535565338.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/7] hw/riscv/spike: Set the soc device tree
 node as a simple-bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair.francis@wdc.com, alistair23@gmail.com

To allow Linux to enumerate devices on the /soc/ node set it as a
"simple-bus".

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/spike.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index c8c056c50b..eb857c434e 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -90,7 +90,7 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/soc");
     qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "ucbbar,spike-bare-soc");
+    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-- 
2.17.1
