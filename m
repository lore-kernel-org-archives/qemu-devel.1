Received: from eggs.gnu.org ([2001:4830:134:3::10]:49753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=715e8d879=Alistair.Francis@wdc.com>)
	id 1faOGl-00084a-8T
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=715e8d879=Alistair.Francis@wdc.com>)
	id 1faOGh-0005kE-7o
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:35:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=715e8d879=Alistair.Francis@wdc.com>)
	id 1faOGg-0005jL-NX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:35:07 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue,  3 Jul 2018 09:34:39 -0700
Message-Id: <20180703163446.9943-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, mjc@sifive.com
Cc: f4bug@amsat.org, alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>

The following changes since commit f988c7e191141e92de2059d04a5f9a9bb01f399c:

  Merge remote-tracking branch 'remotes/shorne/tags/pull-or-20180703' into staging (2018-07-03 16:04:41 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180703

for you to fetch changes up to 41fd29c43424cb3d660231ba75e9f52246639b08:

  hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device (2018-07-03 09:31:35 -0700)

----------------------------------------------------------------
RISC-V: SoCify SiFive boards and connect GEM

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

----------------------------------------------------------------
Alistair Francis (7):
      hw/riscv/sifive_u: Create a SiFive U SoC object
      hw/riscv/sifive_e: Create a SiFive E SoC object
      hw/riscv/sifive_plic: Use gpios instead of irqs
      hw/riscv/sifive_u: Set the soc device tree node as a simple-bus
      hw/riscv/sifive_u: Set the interrupt controler number of interrupts
      hw/riscv/sifive_u: Move the uart device tree node under /soc/
      hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device

 default-configs/riscv32-softmmu.mak |   2 +
 default-configs/riscv64-softmmu.mak |   2 +
 hw/riscv/sifive_e.c                 | 102 +++++++++++++++++-------
 hw/riscv/sifive_plic.c              |   6 +-
 hw/riscv/sifive_u.c                 | 151 +++++++++++++++++++++++++++++-------
 hw/riscv/virt.c                     |   4 +-
 include/hw/riscv/sifive_e.h         |  16 +++-
 include/hw/riscv/sifive_plic.h      |   1 -
 include/hw/riscv/sifive_u.h         |  25 +++++-
 9 files changed, 241 insertions(+), 68 deletions(-)
