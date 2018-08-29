Received: from eggs.gnu.org ([2001:4830:134:3::10]:40731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4hn-0001YX-7Z
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4hh-00045B-LE
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:56:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4hh-00044h-BE
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:56:29 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 29 Aug 2018 10:56:18 -0700
Message-Id: <534ecb78a2478b7d9a72e7f4cd7f90423bcbec01.1535565338.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1535565338.git.alistair.francis@wdc.com>
References: <cover.1535565338.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 1/7] hw/riscv/virtio: Set the soc device
 tree node as a simple-bus
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 248bbdffd3..e8ba4d192d 100644
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
