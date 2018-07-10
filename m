Received: from eggs.gnu.org ([2001:4830:134:3::10]:41334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgVh-0004Nt-Ar
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgVe-00087c-6r
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgVd-000856-IK
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:02 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Mon,  9 Jul 2018 17:27:47 -0700
Message-Id: <cover.1531182400.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/6] Connect a PCIe host and graphics
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
Cc: alistair.francis@wdc.com, alistair23@gmail.com, mjc@sifive.com

V2:
 - Use the gpex PCIe host for virt
 - Add support for SiFive U PCIe


Alistair Francis (6):
  hw/riscv/virtio: Set the soc device tree node as a simple-bus
  hw/riscv/virt: Increase the number of interrupts
  hw/riscv/virt: Connect the gpex PCIe
  hw/riscv/virt: Connect a VGA PCIe device
  hw/riscv/sifive_u: Connect the Xilinx PCIe
  riscv64-softmmu.mak: Build Virtio Block support

 default-configs/riscv32-softmmu.mak |  7 ++++
 default-configs/riscv64-softmmu.mak |  9 ++++
 hw/riscv/sifive_u.c                 | 64 ++++++++++++++++++++++++++++
 hw/riscv/virt.c                     | 65 ++++++++++++++++++++++++++++-
 include/hw/riscv/sifive_u.h         |  4 +-
 include/hw/riscv/virt.h             |  6 ++-
 6 files changed, 151 insertions(+), 4 deletions(-)

-- 
2.17.1
