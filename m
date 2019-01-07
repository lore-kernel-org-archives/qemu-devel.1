Received: from eggs.gnu.org ([209.51.188.92]:45948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoC-0004lE-OZ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoB-0001XN-Ls
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoB-0001Tz-EO
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id g67so1517978wmd.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:40 +0000
Message-Id: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/37] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue: the big things here are the new nRF51
(microbit) devices and Luc's gdbstub multiprocess work.

thanks
-- PMM

The following changes since commit a29644590f95166c8a13e5797f8e7701134b31d0:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-01-05' into staging (2019-01-07 11:55:52 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190107

for you to fetch changes up to f831f955d420966471f5f8b316ba50d2523b1ff0:

  Support u-boot noload images for arm as used by, NetBSD/evbarm GENERIC kernel. (2019-01-07 15:46:20 +0000)

----------------------------------------------------------------
target-arm queue:
 * Support u-boot 'noload' images for Arm (as used by NetBSD/evbarm GENERIC kernel)
 * hw/misc/tz-mpc: Fix value of BLK_MAX register
 * target/arm: Emit barriers for A32/T32 load-acquire/store-release insns
 * nRF51 SoC: add timer, GPIO, RNG peripherals
 * hw/arm/allwinner-a10: Add the 'A' SRAM and the SRAM controller
 * cpus.c: Fix race condition in cpu_stop_current()
 * hw/arm: versal: Plug memory leaks
 * Allow M profile boards to run even if -kernel not specified
 * gdbstub: Add multiprocess extension support for use when the
   board has multiple CPUs of different types (like the Xilinx Zynq boards)
 * target/arm: Don't decode S bit in SVE brk[ab] merging insns
 * target/arm: Convert ARM_TBFLAG_* to FIELDs

----------------------------------------------------------------
Edgar E. Iglesias (1):
      hw/arm: versal: Plug memory leaks

Luc Michel (16):
      hw/cpu: introduce CPU clusters
      gdbstub: introduce GDB processes
      gdbstub: add multiprocess support to '?' packets
      gdbstub: add multiprocess support to 'H' and 'T' packets
      gdbstub: add multiprocess support to vCont packets
      gdbstub: add multiprocess support to 'sC' packets
      gdbstub: add multiprocess support to (f|s)ThreadInfo and ThreadExtraInfo
      gdbstub: add multiprocess support to Xfer:features:read:
      gdbstub: add multiprocess support to gdb_vm_state_change()
      gdbstub: add multiprocess support to 'D' packets
      gdbstub: add support for extended mode packet
      gdbstub: add support for vAttach packets
      gdbstub: processes initialization on new peer connection
      gdbstub: gdb_set_stop_cpu: ignore request when process is not attached
      gdbstub: add multiprocess extension support
      arm/xlnx-zynqmp: put APUs and RPUs in separate CPU clusters

Nick Hudson (1):
      Support u-boot noload images for arm as used by, NetBSD/evbarm GENERIC kernel.

Peter Maydell (3):
      cpus.c: Fix race condition in cpu_stop_current()
      target/arm: Emit barriers for A32/T32 load-acquire/store-release insns
      hw/misc/tz-mpc: Fix value of BLK_MAX register

Philippe Mathieu-Daudé (1):
      hw/arm/allwinner-a10: Add the 'A' SRAM and the SRAM controller

Richard Henderson (2):
      target/arm: Convert ARM_TBFLAG_* to FIELDs
      target/arm: SVE brk[ab] merging does not have s bit

Stefan Hajnoczi (1):
      Revert "armv7m: Guard against no -kernel argument"

Steffen Görtz (11):
      qtest: Add set_irq_in command to set IRQ/GPIO level
      arm: Add header to host common definition for nRF51 SOC peripherals
      hw/misc/nrf51_rng: Add NRF51 random number generator peripheral
      arm: Instantiate NRF51 random number generator
      hw/gpio/nrf51_gpio: Add nRF51 GPIO peripheral
      arm: Instantiate NRF51 general purpose I/O
      tests/microbit-test: Add Tests for nRF51 GPIO
      hw/timer/nrf51_timer: Add nRF51 Timer peripheral
      arm: Instantiate NRF51 Timers
      tests/microbit-test: Add Tests for nRF51 Timer
      arm: Add Clock peripheral stub to NRF51 SOC

Thomas Huth (1):
      MAINTAINERS: Add ARM-related files for hw/[misc|input|timer]/

 Makefile.objs                  |   1 +
 hw/cpu/Makefile.objs           |   2 +-
 hw/gpio/Makefile.objs          |   1 +
 hw/misc/Makefile.objs          |   1 +
 hw/timer/Makefile.objs         |   1 +
 tests/Makefile.include         |   2 +
 hw/core/uboot_image.h          |   1 +
 include/hw/arm/allwinner-a10.h |   1 +
 include/hw/arm/nrf51.h         |  45 +++
 include/hw/arm/nrf51_soc.h     |   9 +
 include/hw/arm/xlnx-zynqmp.h   |   3 +
 include/hw/char/nrf51_uart.h   |   1 -
 include/hw/cpu/cluster.h       |  58 ++++
 include/hw/gpio/nrf51_gpio.h   |  69 +++++
 include/hw/loader.h            |   7 +-
 include/hw/misc/nrf51_rng.h    |  83 +++++
 include/hw/timer/nrf51_timer.h |  80 +++++
 target/arm/cpu.h               | 102 ++-----
 tests/libqtest.h               |  13 +
 cpus.c                         |   3 +-
 gdbstub.c                      | 672 ++++++++++++++++++++++++++++++++++++-----
 hw/arm/allwinner-a10.c         |   6 +
 hw/arm/armv7m.c                |   5 -
 hw/arm/boot.c                  |   8 +-
 hw/arm/nrf51_soc.c             | 117 +++++--
 hw/arm/xlnx-versal-virt.c      |   2 +
 hw/arm/xlnx-zynqmp.c           |  23 +-
 hw/core/loader.c               |  19 +-
 hw/cpu/cluster.c               |  50 +++
 hw/gpio/nrf51_gpio.c           | 300 ++++++++++++++++++
 hw/microblaze/boot.c           |   2 +-
 hw/misc/nrf51_rng.c            | 262 ++++++++++++++++
 hw/misc/tz-mpc.c               |   2 +-
 hw/nios2/boot.c                |   2 +-
 hw/ppc/e500.c                  |   1 +
 hw/ppc/ppc440_bamboo.c         |   2 +-
 hw/ppc/sam460ex.c              |   2 +-
 hw/timer/nrf51_timer.c         | 393 ++++++++++++++++++++++++
 qtest.c                        |  43 +++
 target/arm/helper.c            |  49 ++-
 target/arm/translate-a64.c     |  22 +-
 target/arm/translate.c         |  73 +++--
 tests/libqtest.c               |  10 +
 tests/microbit-test.c          | 255 ++++++++++++++++
 MAINTAINERS                    |  18 +-
 hw/gpio/trace-events           |   7 +
 hw/timer/trace-events          |   5 +
 target/arm/sve.decode          |   5 +-
 48 files changed, 2567 insertions(+), 271 deletions(-)
 create mode 100644 include/hw/arm/nrf51.h
 create mode 100644 include/hw/cpu/cluster.h
 create mode 100644 include/hw/gpio/nrf51_gpio.h
 create mode 100644 include/hw/misc/nrf51_rng.h
 create mode 100644 include/hw/timer/nrf51_timer.h
 create mode 100644 hw/cpu/cluster.c
 create mode 100644 hw/gpio/nrf51_gpio.c
 create mode 100644 hw/misc/nrf51_rng.c
 create mode 100644 hw/timer/nrf51_timer.c
 create mode 100644 tests/microbit-test.c
 create mode 100644 hw/gpio/trace-events
