Received: from eggs.gnu.org ([2001:4830:134:3::10]:45350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINVP-0003Ix-1N
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINVL-0001H0-SP
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:07:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINVL-0001Cm-FX
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:07:47 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Mon, 14 May 2018 17:07:34 -0700
Message-Id: <17b6d0aba8f00cf598c066de7aac478c32323415.1526342674.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1526342674.git.alistair.francis@wdc.com>
References: <cover.1526342674.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/7] hw/riscv/sifive_u: Set the soc device
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
2.17.0
