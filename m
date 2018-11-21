Received: from eggs.gnu.org ([2001:4830:134:3::10]:58111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856724ab1=Alistair.Francis@wdc.com>)
	id 1gPVtR-0004NZ-P3
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856724ab1=Alistair.Francis@wdc.com>)
	id 1gPVtM-0006pI-8i
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:02:25 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 21 Nov 2018 17:02:08 +0000
Message-ID: <cover.1542819633.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH for-3.2 v7 0/6] Connect a PCIe host and
 graphics support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "abologna@redhat.com" <abologna@redhat.com>, "logang@deltatee.com" <logang@deltatee.com>

V7:
 - Fix the GPEX memory mapping thanks to Bin Meng
 - Fix the interrupt mapping thanks to Logan Gunthorpe
V6:
 - Fix the interrupt issue for the GPEX device
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


Alistair Francis (6):
  hw/riscv/virt: Increase the number of interrupts
  hw/riscv/virt: Adjust memory layout spacing
  hw/riscv/virt: Connect the gpex PCIe
  riscv: Enable VGA and PCIE_VGA
  hw/riscv/sifive_u: Connect the Xilinx PCIe
  hw/riscv/virt: Connect a VirtIO net PCIe device

 default-configs/riscv32-softmmu.mak |  10 +-
 default-configs/riscv64-softmmu.mak |  10 +-
 hw/riscv/sifive_u.c                 |  64 +++++++++++
 hw/riscv/virt.c                     | 161 ++++++++++++++++++++++++++--
 include/hw/riscv/sifive_u.h         |   4 +-
 include/hw/riscv/virt.h             |  15 ++-
 6 files changed, 250 insertions(+), 14 deletions(-)

--=20
2.19.1
