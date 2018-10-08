Received: from eggs.gnu.org ([2001:4830:134:3::10]:35000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aE3-0004my-CQ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aE0-0007sA-6w
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:25:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49719)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aDz-0007rB-TO
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:25:48 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 8 Oct 2018 18:25:45 +0000
Message-ID: <1813e888a55667b7097df2a75fa626c98390240d.1539023064.git.alistair.francis@wdc.com>
References: <cover.1539023064.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1539023064.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 4/5] RISC-V: Add missing free for
 plic_hart_config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

From: Michael Clark <mjc@sifive.com>

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 005169eabc..6bd723dc3a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -385,6 +385,8 @@ static void riscv_virt_board_init(MachineState *machine=
)
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    g_free(plic_hart_config);
 }
=20
 static void riscv_virt_board_machine_init(MachineClass *mc)
--=20
2.17.1
