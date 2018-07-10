Received: from eggs.gnu.org ([2001:4830:134:3::10]:41452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgVt-0004Wh-9M
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgVq-0008Fe-5t
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:17 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:48835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgVp-0008Es-Ol
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:14 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Mon,  9 Jul 2018 17:27:59 -0700
Message-Id: <2ab3ad45e569dfb484c125e5dc46613081c71389.1531182400.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1531182400.git.alistair.francis@wdc.com>
References: <cover.1531182400.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/6] hw/riscv/virtio: Set the soc device
 tree node as a simple-bus
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

To allow Linux to ennumerate devices on the /soc/ node set it as a
"simple-bus".

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index aeada2498d..5336166f6d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -121,7 +121,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/soc");
     qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "riscv-virtio-soc");
+    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-- 
2.17.1
