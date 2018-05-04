Received: from eggs.gnu.org ([2001:4830:134:3::10]:44056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh4i-0006cS-0f
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh4e-0006I5-SY
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:03 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh4e-0006Ga-8d
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:00 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri,  4 May 2018 13:12:45 -0700
Message-Id: <cover.1525464177.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/4] RISC-V: SoCify the SiFive boards and
 connect the
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

This series has two tasks:
 1. To conver the SiFive U and E machines into SoCs and boards
 2. To connect the Cadence GEM device to teh SiFive U board

After this series the SiFive E and U boards have their SoCs split into
seperate QEMU objects, which can be used on future boards if desired.

The RISC-V Virt and Spike boards have not been converted. They haven't
been converted as they aren't physical boards, so it doesn't make a
whole lot of sense to split them into an SoC and board. The only
disadvantage with this is that they now differ to the SiFive boards.

This series also connect the Cadence GEM device to the SiFive U board.
There are some interrupt line changes requried before this is possible.

Based-on: <1524699938-6764-1-git-send-email-mjc@sifive.com>

Alistair Francis (4):
  hw/riscv/sifive_u: Create a U54 SoC object
  hw/riscv/sifive_plic: Use gpios instead of irqs
  hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device
  hw/riscv/sifive_e: Create a E31 SoC object

 default-configs/riscv32-softmmu.mak |   1 +
 default-configs/riscv64-softmmu.mak |   1 +
 hw/riscv/sifive_e.c                 |  97 +++++++++++++++++------
 hw/riscv/sifive_plic.c              |   5 +-
 hw/riscv/sifive_u.c                 | 119 +++++++++++++++++++++++-----
 include/hw/riscv/sifive_e.h         |  16 +++-
 include/hw/riscv/sifive_u.h         |  22 ++++-
 7 files changed, 205 insertions(+), 56 deletions(-)

-- 
2.17.0
