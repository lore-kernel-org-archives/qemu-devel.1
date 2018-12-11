Received: from eggs.gnu.org ([2001:4830:134:3::10]:35660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87679fe4f=Alistair.Francis@wdc.com>)
	id 1gWqeY-0005kZ-R1
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87679fe4f=Alistair.Francis@wdc.com>)
	id 1gWqeT-0006Ar-S3
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:37:21 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 11 Dec 2018 22:37:07 +0000
Message-ID: <cover.1544567709.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v8 0/4] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "stephen@eideticom.com" <stephen@eideticom.com>, "palmer@sifive.com" <palmer@sifive.com>

This series is now ready to be merged, all of the patches are reviewed
and tested.

Palmer can you take this with all the other RISC-V patches sent during
the freeze?

V8:
 - Drop SiFive U support
 - Drop legacy -nic support
 - Small other review changes
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


Alistair Francis (4):
  hw/riscv/virt: Increase the number of interrupts
  hw/riscv/virt: Adjust memory layout spacing
  hw/riscv/virt: Connect the gpex PCIe
  riscv: Enable VGA and PCIE_VGA

 default-configs/riscv32-softmmu.mak |   8 +-
 default-configs/riscv64-softmmu.mak |   8 +-
 hw/riscv/virt.c                     | 147 ++++++++++++++++++++++++++--
 include/hw/riscv/virt.h             |  15 ++-
 4 files changed, 165 insertions(+), 13 deletions(-)

--=20
2.19.1
