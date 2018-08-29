Received: from eggs.gnu.org ([2001:4830:134:3::10]:40698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4hd-0001UD-PM
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4hY-00040s-Je
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:56:25 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4hX-0003zW-Te
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:56:20 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 29 Aug 2018 10:56:06 -0700
Message-Id: <cover.1535565338.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/7] Connect a PCIe host and graphics
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

V4:
 - Fix the spike device tree
 - Don't use stdvga device
V3:
 - Remove Makefile config changes
 - Connect a network adapter to the virt device
V2:
 - Use the gpex PCIe host for virt
 - Add support for SiFive U PCIe


Alistair Francis (7):
  hw/riscv/virtio: Set the soc device tree node as a simple-bus
  hw/riscv/spike: Set the soc device tree node as a simple-bus
  hw/riscv/virt: Increase the number of interrupts
  hw/riscv/virt: Connect the gpex PCIe
  riscv: Enable VGA and PCIE_VGA
  hw/riscv/sifive_u: Connect the Xilinx PCIe
  hw/riscv/virt: Connect a VirtIO net PCIe device

 default-configs/riscv32-softmmu.mak |  8 ++++
 default-configs/riscv64-softmmu.mak |  8 ++++
 hw/riscv/sifive_u.c                 | 64 +++++++++++++++++++++++++
 hw/riscv/spike.c                    |  2 +-
 hw/riscv/virt.c                     | 74 ++++++++++++++++++++++++++++-
 include/hw/riscv/sifive_u.h         |  4 +-
 include/hw/riscv/virt.h             |  6 ++-
 7 files changed, 161 insertions(+), 5 deletions(-)

-- 
2.17.1
