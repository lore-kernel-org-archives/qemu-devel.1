Received: from eggs.gnu.org ([2001:4830:134:3::10]:38968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8083a5a2a=Alistair.Francis@wdc.com>)
	id 1g89te-0008ME-52
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8083a5a2a=Alistair.Francis@wdc.com>)
	id 1g89tW-0007tw-Jg
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:06:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=8083a5a2a=Alistair.Francis@wdc.com>)
	id 1g89tU-0007p7-MN
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:06:45 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 4 Oct 2018 20:06:38 +0000
Message-ID: <8323df439d7937e910b31c301b243aafb954aba9.1538683492.git.alistair.francis@wdc.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1538683492.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 3/5] riscv: Enable VGA and PCIE_VGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "stephen@eideticom.com" <stephen@eideticom.com>, "palmer@sifive.com" <palmer@sifive.com>

Enable compile support for VGA devices. This allows the user to conenct
a display by adding '-device bochs-display -display sdl' to their
command line argument.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv32-softmmu.mak | 3 +++
 default-configs/riscv64-softmmu.mak | 3 +++
 hw/riscv/virt.c                     | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-=
softmmu.mak
index 3e3d195f37..05fae82f1b 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -9,3 +9,6 @@ CONFIG_CADENCE=3Dy
=20
 CONFIG_PCI_GENERIC=3Dy
 CONFIG_PCI_XILINX=3Dy
+
+CONFIG_VGA=3Dy
+CONFIG_VGA_PCI=3Dy
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-=
softmmu.mak
index 3e3d195f37..05fae82f1b 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -9,3 +9,6 @@ CONFIG_CADENCE=3Dy
=20
 CONFIG_PCI_GENERIC=3Dy
 CONFIG_PCI_XILINX=3Dy
+
+CONFIG_VGA=3Dy
+CONFIG_VGA_PCI=3Dy
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9bd2c10581..62a953aa2b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -437,8 +437,8 @@ static void riscv_virt_board_init(MachineState *machine=
)
     }
=20
     gpex_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
-                           memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
-                           qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), tr=
ue);
+                   memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
+                   qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true);
=20
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
--=20
2.17.1
