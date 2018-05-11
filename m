Received: from eggs.gnu.org ([2001:4830:134:3::10]:51301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=662fb86e2=Alistair.Francis@wdc.com>)
	id 1fHHSv-0007RJ-6i
	for qemu-devel@nongnu.org; Fri, 11 May 2018 19:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=662fb86e2=Alistair.Francis@wdc.com>)
	id 1fHHSq-0000zF-9k
	for qemu-devel@nongnu.org; Fri, 11 May 2018 19:28:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=662fb86e2=Alistair.Francis@wdc.com>)
	id 1fHHSp-0000yR-Tv
	for qemu-devel@nongnu.org; Fri, 11 May 2018 19:28:40 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 11 May 2018 16:28:28 -0700
Message-Id: <bef3e1502d6417c1d533cbf12a032a2963ea4424.1526081108.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1526081108.git.alistair.francis@wdc.com>
References: <cover.1526081108.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 6/7] hw/riscv/sifive_u: Move the uart device
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
---
 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 50389cdc90..540d53bf2f 100644
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
