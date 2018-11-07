Received: from eggs.gnu.org ([2001:4830:134:3::10]:54367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=842139a6e=Alistair.Francis@wdc.com>)
	id 1gKVkC-00071y-6p
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 16:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=842139a6e=Alistair.Francis@wdc.com>)
	id 1gKVk7-0004NE-88
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 16:52:12 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 7 Nov 2018 21:51:45 +0000
Message-ID: <1793576616012e06e68cd9e0215eb907ff2ef12b.1541627403.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH for 3.1 v1 1/1] hw/riscv/virt: Free the test
 device tree node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@sifive.com" <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4a137a503c..2b38f89070 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -240,6 +240,7 @@ static void *create_fdt(RISCVVirtState *s, const struct=
 MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[VIRT_TEST].base,
         0x0, memmap[VIRT_TEST].size);
+    g_free(nodename);
=20
     nodename =3D g_strdup_printf("/uart@%lx",
         (long)memmap[VIRT_UART0].base);
--=20
2.19.1
