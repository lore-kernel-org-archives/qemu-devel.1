Received: from eggs.gnu.org ([2001:4830:134:3::10]:44278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRkn-0000Wo-At
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRkk-0004mq-3n
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:29:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRkj-0004mh-NM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:29:50 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 22 Jun 2018 12:29:36 -0700
Message-Id: <f4c9f5748a557905ac8201d3c56411df914b074a.1529695276.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1529695276.git.alistair.francis@wdc.com>
References: <cover.1529695276.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/5] hw/riscv/virtio: Set the soc device
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
Cc: alistair.francis@wdc.com, alistair23@gmail.com, palmer@sifive.com, mjc@sifive.com

To allow Linux to ennumerate devices on the /soc/ node set it as a
"simple-bus".

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bdd75722eb..a95ccb2825 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -120,7 +120,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/soc");
     qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
-    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "riscv-virtio-soc");
+    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-- 
2.17.1
