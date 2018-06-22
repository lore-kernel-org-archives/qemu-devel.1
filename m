Received: from eggs.gnu.org ([2001:4830:134:3::10]:44250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRka-0000Oe-00
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRkW-0004kO-Qe
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:29:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRkW-0004k3-9i
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:29:36 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 22 Jun 2018 12:28:14 -0700
Message-Id: <cover.1529695276.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, alistair23@gmail.com, palmer@sifive.com, mjc@sifive.com




Alistair Francis (5):
  hw/riscv/virtio: Set the soc device tree node as a simple-bus
  hw/riscv/virt: Increase the number of interrupts
  hw/riscv/virt: Connect the Xilinx PCIe
  hw/riscv/virt: Connect a VGA PCIe device
  riscv64-softmmu.mak: Build Virtio Block support

 default-configs/riscv32-softmmu.mak |  6 +++
 default-configs/riscv64-softmmu.mak |  8 ++++
 hw/riscv/virt.c                     | 73 ++++++++++++++++++++++++++++-
 include/hw/riscv/virt.h             |  6 ++-
 4 files changed, 90 insertions(+), 3 deletions(-)

-- 
2.17.1
