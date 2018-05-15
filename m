Received: from eggs.gnu.org ([2001:4830:134:3::10]:45210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINUa-0002nM-5T
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINUX-0006u9-0K
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:07:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=666685086=Alistair.Francis@wdc.com>)
	id 1fINUW-0006mU-Di
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:06:56 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Mon, 14 May 2018 17:06:36 -0700
Message-Id: <cover.1526342674.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/7] RISC-V: SoCify SiFive boards and
 connect GEM
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


This series has three tasks:
 1. To convert the SiFive U and E machines into SoCs and boards
 2. To connect the Cadence GEM device to the SiFive U board
 3. Fix some device tree problems with the SiFive U board

After this series the SiFive E and U boards have their SoCs split into
seperate QEMU objects, which can be used on future boards if desired.

The RISC-V Virt and Spike boards have not been converted. They haven't
been converted as they aren't physical boards, so it doesn't make a
whole lot of sense to split them into an SoC and board. The only
disadvantage with this is that they now differ to the SiFive boards.

This series also connect the Cadence GEM device to the SiFive U board.
There are some interrupt line changes requried before this is possible.

V3:
 - Generalise the SoC names
V2:
 - Use the new GPIOs everywhere in the board
 - Add the GEM device tree node
 - Fix some device tree problems identified



Alistair Francis (7):
  hw/riscv/sifive_u: Create a SiFive U SoC object
  hw/riscv/sifive_e: Create a SiFive E SoC object
  hw/riscv/sifive_plic: Use gpios instead of irqs
  hw/riscv/sifive_u: Set the soc device tree node as a simple-bus
  hw/riscv/sifive_u: Set the interrupt controler number of interrupts
  hw/riscv/sifive_u: Move the uart device tree node under /soc/
  hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device

 default-configs/riscv32-softmmu.mak |   1 +
 default-configs/riscv64-softmmu.mak |   1 +
 hw/riscv/sifive_e.c                 | 102 ++++++++++++++-----
 hw/riscv/sifive_plic.c              |   6 +-
 hw/riscv/sifive_u.c                 | 151 +++++++++++++++++++++++-----
 hw/riscv/virt.c                     |   4 +-
 include/hw/riscv/sifive_e.h         |  16 ++-
 include/hw/riscv/sifive_plic.h      |   1 -
 include/hw/riscv/sifive_u.h         |  25 ++++-
 9 files changed, 239 insertions(+), 68 deletions(-)

-- 
2.17.0
