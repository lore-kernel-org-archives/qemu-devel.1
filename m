Received: from eggs.gnu.org ([2001:4830:134:3::10]:42247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=711c09436=Alistair.Francis@wdc.com>)
	id 1fYx6Y-00047K-GW
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=711c09436=Alistair.Francis@wdc.com>)
	id 1fYx6U-0003WM-Kh
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:22:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=711c09436=Alistair.Francis@wdc.com>)
	id 1fYx6U-0003Uq-78
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:22:38 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 29 Jun 2018 10:22:14 -0700
Message-Id: <20180629172215.29475-7-alistair.francis@wdc.com>
In-Reply-To: <20180629172215.29475-1-alistair.francis@wdc.com>
References: <20180629172215.29475-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL v2 6/7] hw/riscv/sifive_u: Move the uart device
 tree node under /soc/
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
2.17.1
