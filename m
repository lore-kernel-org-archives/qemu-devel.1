Received: from eggs.gnu.org ([2001:4830:134:3::10]:51388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKs9-0008RF-JT
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKs4-0008T0-GM
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:11:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKs4-0008RW-2n
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:11:36 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 16 Aug 2018 09:11:23 -0700
Message-Id: <cover.1534435831.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/6] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair.francis@wdc.com, alistair23@gmail.com

V3:
 - Remove Makefile config changes
 - Connect a network adapter to the virt device
V2:
 - Use the gpex PCIe host for virt
 - Add support for SiFive U PCIe


Alistair Francis (6):
  hw/riscv/virtio: Set the soc device tree node as a simple-bus
  hw/riscv/virt: Increase the number of interrupts
  hw/riscv/virt: Connect the gpex PCIe
  hw/riscv/virt: Connect a VGA PCIe device
  hw/riscv/sifive_u: Connect the Xilinx PCIe
  hw/riscv/virt: Connect a VirtIO net PCIe device

 default-configs/riscv32-softmmu.mak |  8 +++
 default-configs/riscv64-softmmu.mak |  8 +++
 hw/riscv/sifive_u.c                 | 64 ++++++++++++++++++++++++
 hw/riscv/virt.c                     | 76 ++++++++++++++++++++++++++++-
 include/hw/riscv/sifive_u.h         |  4 +-
 include/hw/riscv/virt.h             |  6 ++-
 6 files changed, 162 insertions(+), 4 deletions(-)

-- 
2.17.1
