Received: from eggs.gnu.org ([2001:4830:134:3::10]:45436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINVn-0003eB-EP
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINVk-0002ZA-9H
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:08:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINVj-0002WS-SR
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:08:12 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Mon, 14 May 2018 17:08:00 -0700
Message-Id: <17849c31b5b8e57e2ae61852edae8791f672801c.1526342674.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1526342674.git.alistair.francis@wdc.com>
References: <cover.1526342674.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 6/7] hw/riscv/sifive_u: Move the uart device
 tree node under /soc/
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f71527eaff..46459cd368 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -194,7 +194,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
-    nodename = g_strdup_printf("/uart@%lx",
+    nodename = g_strdup_printf("/soc/uart@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
-- 
2.17.0
