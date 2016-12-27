Received: from eggs.gnu.org ([2001:4830:134:3::10]:35192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZE-0001Yp-Ci
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZD-00017X-Ay
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:32 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZD-00014K-3A
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:31 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZ5-0003pe-FS
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:21:23 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:20:52 +0000
Message-Id: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/25] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

First target-arm pull for 2.9; nothing particularly exciting here.

thanks
-- PMM

The following changes since commit a470b33259bf82ef2336bfcd5d07640562d3f63b:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2016-12-22 19:23:51 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20161227

for you to fetch changes up to 91db4642f868cf2e591b62d31a19d35b02ea791e:

  target-arm: Add VBAR support to ARM1176 CPUs (2016-12-27 14:59:30 +0000)

----------------------------------------------------------------
target-arm queue:
 * add VBAR support to ARM1176 CPUs
 * hw/i2c: add NULL check to i2c slave init callbacks
 * pxa2xx.c: fix trailing whitespace
 * aspeed: various cleanups
 * aspeed: add romulus-bmc board
 * virt: add 2.9 machine type
 * gicv3: don't signal Pending+Active interrupts to CPU
 * gicv3: fix incorrect usage of fieldoffset
 * arm: log AArch64 exception returns
 * gicv3: fix aff3 field in typer register
 * aarch64: fix ldst_single_struct on BE hosts
 * aarch64: fix vec_reg_offset on BE hosts
 * arm: fix Cortex-A8 MVFR1 register value
 * cadence_uart: check if receiver timeout counter disabled
 * cadence_uart: check register values on migration

----------------------------------------------------------------
Alastair D'Silva (2):
      hw/arm: remove trailing whitespace
      hw/i2c: Add a NULL check for i2c slave init callbacks

Alistair Francis (1):
      cadence_uart: Check baud rate generator and divider values on migration

Andrew Gacek (1):
      cadence_uart: Check if receiver timeout counter is disabled

Andrew Jones (1):
      hw/intc/arm_gicv3_common: fix aff3 in typer

Cédric Le Goater (13):
      m25p80: add support for the mx66l1g45g
      aspeed: QOMify the CPU object and attach it to the SoC
      aspeed: remove cannot_destroy_with_object_finalize_yet
      aspeed: attach the second SPI controller object to the SoC
      aspeed: extend the board configuration with flash models
      aspeed: add support for the romulus-bmc board
      aspeed: add a memory region for SRAM
      aspeed: add the definitions for the AST2400 A1 SoC
      aspeed: change SoC revision of the palmetto-bmc machine
      aspeed/scu: fix SCU region size
      aspeed/smc: improve segment register support
      aspeed/smc: set the number of flash modules for the FMC controller
      target-arm: Add VBAR support to ARM1176 CPUs

Julian Brown (1):
      Correct value of ARM Cortex-A8 MVFR1 register.

Peter Maydell (4):
      target-arm: Log AArch64 exception returns
      hw/intc/arm_gicv3: Remove incorrect usage of fieldoffset
      hw/intc/arm_gicv3: Don't signal Pending+Active interrupts to CPU
      hw/arm/virt: add 2.9 machine type

Richard Henderson (2):
      target-arm: Fix aarch64 vec_reg_offset
      target-arm: Fix aarch64 disas_ldst_single_struct

 include/hw/arm/aspeed_soc.h  |  4 +-
 include/hw/compat.h          |  3 ++
 include/hw/misc/aspeed_scu.h |  1 +
 target/arm/cpu.h             |  1 +
 hw/arm/aspeed.c              | 70 ++++++++++++++++++++++++++++++--
 hw/arm/aspeed_soc.c          | 95 +++++++++++++++++++++++++++++++++-----------
 hw/arm/pxa2xx.c              |  9 +----
 hw/arm/tosa.c                |  7 ----
 hw/arm/virt.c                | 19 ++++++++-
 hw/arm/z2.c                  |  7 ----
 hw/block/m25p80.c            |  1 +
 hw/char/cadence_uart.c       | 14 +++++--
 hw/i2c/core.c                |  6 ++-
 hw/intc/arm_gicv3.c          |  5 +++
 hw/intc/arm_gicv3_common.c   |  3 +-
 hw/intc/arm_gicv3_cpuif.c    | 13 +++---
 hw/misc/aspeed_scu.c         |  4 +-
 hw/misc/aspeed_sdmc.c        |  3 ++
 hw/ssi/aspeed_smc.c          | 17 ++++----
 hw/timer/ds1338.c            |  6 ---
 target/arm/cpu.c             | 11 ++++-
 target/arm/helper.c          | 19 ++++++---
 target/arm/op_helper.c       |  9 +++++
 target/arm/translate-a64.c   |  7 ++--
 24 files changed, 245 insertions(+), 89 deletions(-)
