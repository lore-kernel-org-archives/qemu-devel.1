Received: from eggs.gnu.org ([2001:4830:134:3::10]:58111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXt-0000ET-Cg
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXp-0002Eb-5z
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXo-0002AQ-RI
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:37 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue,  4 Sep 2018 16:14:41 -0700
Message-Id: <20180904231442.18932-9-alistair.francis@wdc.com>
In-Reply-To: <20180904231442.18932-1-alistair.francis@wdc.com>
References: <20180904231442.18932-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 8/9] hw/riscv/spike: Set the soc device tree
 node as a simple-bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>

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
