Received: from eggs.gnu.org ([2001:4830:134:3::10]:42145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=711c09436=Alistair.Francis@wdc.com>)
	id 1fYx6R-00044w-5Z
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=711c09436=Alistair.Francis@wdc.com>)
	id 1fYx6N-0003KC-7W
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:22:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=711c09436=Alistair.Francis@wdc.com>)
	id 1fYx6M-0003Ft-GD
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:22:31 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 29 Jun 2018 10:22:08 -0700
Message-Id: <20180629172215.29475-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 0/7] riscv-pull queue
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

The following changes since commit 75507f1aba6feb73ae43329922d51571550b9128:

  Merge remote-tracking branch 'remotes/berrange/tags/min-glib-pull-request' into staging (2018-06-29 15:04:20 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180629

for you to fetch changes up to e4847c96685e210649e6ec90fecd732a744dad75:

  hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device (2018-06-29 09:51:05 -0700)

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

 default-configs/riscv32-softmmu.mak |   3 +-
 default-configs/riscv64-softmmu.mak |   3 +-
 hw/riscv/sifive_e.c                 | 102 +++++++++++++++++-------
 hw/riscv/sifive_plic.c              |   6 +-
 hw/riscv/sifive_u.c                 | 151 +++++++++++++++++++++++++++++-------
 hw/riscv/virt.c                     |   4 +-
 include/hw/riscv/sifive_e.h         |  16 +++-
 include/hw/riscv/sifive_plic.h      |   1 -
 include/hw/riscv/sifive_u.h         |  25 +++++-
 9 files changed, 241 insertions(+), 70 deletions(-)
