Received: from eggs.gnu.org ([2001:4830:134:3::10]:49389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=709ee912d=Alistair.Francis@wdc.com>)
	id 1fYEVS-00048V-4z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=709ee912d=Alistair.Francis@wdc.com>)
	id 1fYEVP-0000qC-1C
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:45:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=709ee912d=Alistair.Francis@wdc.com>)
	id 1fYEVO-0000fX-60
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:45:22 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 27 Jun 2018 10:44:32 -0700
Message-Id: <20180627174435.31800-5-alistair.francis@wdc.com>
In-Reply-To: <20180627174435.31800-1-alistair.francis@wdc.com>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 4/7] hw/riscv/sifive_u: Set the soc device tree
 node as a simple-bus
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
