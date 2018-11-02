Received: from eggs.gnu.org ([2001:4830:134:3::10]:50178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId4G-0007by-Gp
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId4A-0002nX-PQ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:17:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gId41-0002Zn-7I
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:16:57 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gId3p-0003ZA-Js
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 17:16:41 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Nov 2018 17:16:28 +0000
Message-Id: <20181102171638.24069-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 00/10] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is a respin of my pull request from earlier this week:
 * versal board compile failure fixed
 * a few new patches:
  - MAINTAINERS file fix
  - use ARRAY_SIZE macro in xilinx_zynq
  - avoid an array overrun in strongarm GPIO irq handling
  - fix an assert running KVM on an aarch64-only host

The following changes since commit 69e2d03843412b9c076515b3aa9a71db161b6a1a:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-for-master-3.1-sf1' into staging (2018-11-02 13:16:13 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181102

for you to fetch changes up to 6f16da53ffe4567c0353f85055df04860eb4e6fc:

  hw/arm: versal: Add a virtual Xilinx Versal board (2018-11-02 14:11:31 +0000)

----------------------------------------------------------------
target-arm queue:
 * microbit: Add the UART to our nRF51 SoC model
 * Add a virtual Xilinx Versal board "xlnx-versal-virt"
 * hw/arm/virt: Set VIRT_COMPAT_3_0 compat
 * MAINTAINERS: Remove bouncing email in ARM ACPI
 * strongarm: mask off high[31:28] bits from dir and state registers
 * target/arm: Conditionalize some asserts on aarch32 support
 * hw/arm/xilinx_zynq: Use the ARRAY_SIZE macro

----------------------------------------------------------------
Edgar E. Iglesias (2):
      hw/arm: versal: Add a model of Xilinx Versal SoC
      hw/arm: versal: Add a virtual Xilinx Versal board

Eric Auger (1):
      hw/arm/virt: Set VIRT_COMPAT_3_0 compat

Julia Suvorova (3):
      hw/char: Implement nRF51 SoC UART
      hw/arm/nrf51_soc: Connect UART to nRF51 SoC
      tests/boot-serial-test: Add microbit board testcase

Philippe Mathieu-Daudé (2):
      MAINTAINERS: Remove bouncing email in ARM ACPI
      hw/arm/xilinx_zynq: Use the ARRAY_SIZE macro

Prasad J Pandit (1):
      strongarm: mask off high[31:28] bits from dir and state registers

Richard Henderson (1):
      target/arm: Conditionalize some asserts on aarch32 support

 hw/arm/Makefile.objs                |   1 +
 hw/char/Makefile.objs               |   1 +
 include/hw/arm/nrf51_soc.h          |   3 +
 include/hw/arm/xlnx-versal.h        | 122 +++++++++
 include/hw/char/nrf51_uart.h        |  78 ++++++
 target/arm/cpu.h                    |   5 +
 hw/arm/microbit.c                   |   2 +
 hw/arm/nrf51_soc.c                  |  20 ++
 hw/arm/strongarm.c                  |   4 +-
 hw/arm/virt.c                       |   4 +
 hw/arm/xilinx_zynq.c                |   2 +-
 hw/arm/xlnx-versal-virt.c           | 494 ++++++++++++++++++++++++++++++++++++
 hw/arm/xlnx-versal.c                | 323 +++++++++++++++++++++++
 hw/char/nrf51_uart.c                | 330 ++++++++++++++++++++++++
 target/arm/cpu.c                    |  15 +-
 tests/boot-serial-test.c            |  19 ++
 MAINTAINERS                         |   1 -
 default-configs/aarch64-softmmu.mak |   1 +
 hw/char/trace-events                |   4 +
 19 files changed, 1423 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/arm/xlnx-versal.h
 create mode 100644 include/hw/char/nrf51_uart.h
 create mode 100644 hw/arm/xlnx-versal-virt.c
 create mode 100644 hw/arm/xlnx-versal.c
 create mode 100644 hw/char/nrf51_uart.c
