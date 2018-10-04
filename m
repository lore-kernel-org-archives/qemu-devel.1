Received: from eggs.gnu.org ([2001:4830:134:3::10]:38749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8083a5a2a=Alistair.Francis@wdc.com>)
	id 1g89tE-0008Aa-At
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8083a5a2a=Alistair.Francis@wdc.com>)
	id 1g89t8-0007cJ-HY
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:06:27 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=8083a5a2a=Alistair.Francis@wdc.com>)
	id 1g89t0-0007Yw-CM
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:06:15 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 4 Oct 2018 20:06:08 +0000
Message-ID: <cover.1538683492.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
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

V5:
 - Rebase
 - Include pci.mak in the default configs
V4:
 - Fix the spike device tree
 - Don't use stdvga device
V3:
 - Remove Makefile config changes
 - Connect a network adapter to the virt device
V2:
 - Use the gpex PCIe host for virt
 - Add support for SiFive U PCIe


Alistair Francis (5):
  hw/riscv/virt: Increase the number of interrupts
  hw/riscv/virt: Connect the gpex PCIe
  riscv: Enable VGA and PCIE_VGA
  hw/riscv/sifive_u: Connect the Xilinx PCIe
  hw/riscv/virt: Connect a VirtIO net PCIe device

 default-configs/riscv32-softmmu.mak | 10 +++-
 default-configs/riscv64-softmmu.mak | 10 +++-
 hw/riscv/sifive_u.c                 | 64 +++++++++++++++++++++++++
 hw/riscv/virt.c                     | 72 +++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u.h         |  4 +-
 include/hw/riscv/virt.h             |  6 ++-
 6 files changed, 161 insertions(+), 5 deletions(-)

--=20
2.17.1
