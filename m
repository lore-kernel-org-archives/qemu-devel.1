Received: from eggs.gnu.org ([2001:4830:134:3::10]:39633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhcg-0006dv-HZ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhcc-0006Yu-2b
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:31:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhcb-0006Un-Oj
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:31:49 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 11 Oct 2018 20:31:46 +0000
Message-ID: <20181011203115.18666-4-alistair.francis@wdc.com>
References: <20181011203115.18666-1-alistair.francis@wdc.com>
In-Reply-To: <20181011203115.18666-1-alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PULL 03/10] riscv: Enable VGA and PCIE_VGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>

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
