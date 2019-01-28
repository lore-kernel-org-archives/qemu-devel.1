Received: from eggs.gnu.org ([209.51.188.92]:40790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN3-0002Zr-Sw
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN1-0008Dm-PS
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:10:57 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBMz-00084P-QX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:10:55 -0500
Received: by mail-wr1-x435.google.com with SMTP id 96so19192103wrb.2
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:10:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.10.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:10:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:21 +0000
Message-Id: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/26] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Arm queue. I'll probably end up doing another later this week.

thanks
-- PMM

The following changes since commit 5f39a91dbd9a186edb999afd4d17524f4b1da14f:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-01-28 12:54:06 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190128

for you to fetch changes up to dc192cb2d851c51ebd8d8e1a3b6b14ce9d16efc7:

  gdbstub: Simplify gdb_get_cpu_pid() to use cpu->cluster_index (2019-01-28 18:03:16 +0000)

----------------------------------------------------------------
target-arm queue:
 * Fix validation of 32-bit address spaces for aa32 (fixes an assert introduced in ba97be9f4a4)
 * v8m: Ensure IDAU is respected if SAU is disabled
 * gdbstub: fix gdb_get_cpu(s, pid, tid) when pid and/or tid are 0
 * exec.c: Use correct attrs in cpu_memory_rw_debug()
 * accel/tcg/user-exec: Don't parse aarch64 insns to test for read vs write
 * target/arm: Don't clear supported PMU events when initializing PMCEID1
 * memory: add memory_region_flush_rom_device()
 * microbit: Add nRF51 non-volatile memories
 * microbit: Add stub NRF51 TWI magnetometer/accelerometer detection
 * tests/microbit-test: extend testing of microbit devices
 * checkpatch: Don't emit spurious warnings about block comments
 * aspeed/smc: misc bug fixes
 * xlnx-zynqmp: Don't create rpu-cluster if there are no RPUs
 * xlnx-zynqmp: Realize cluster after putting RPUs in it
 * accel/tcg: Add cluster number to TCG TB hash so differently configured
   CPUs don't pick up cached TBs for the wrong kind of CPU

----------------------------------------------------------------
Aaron Lindsay OS (1):
      target/arm: Don't clear supported PMU events when initializing PMCEID1

Cédric Le Goater (4):
      aspeed/smc: fix default read value
      aspeed/smc: define registers for all possible CS
      aspeed/smc: Add dummy data register
      aspeed/smc: snoop SPI transfers to fake dummy cycles

Julia Suvorova (3):
      tests/libqtest: Introduce qtest_init_with_serial()
      tests/microbit-test: Make test independent of global_qtest
      tests/microbit-test: Check nRF51 UART functionality

Luc Michel (1):
      gdbstub: fix gdb_get_cpu(s, pid, tid) when pid and/or tid are 0

Peter Maydell (8):
      exec.c: Use correct attrs in cpu_memory_rw_debug()
      accel/tcg/user-exec: Don't parse aarch64 insns to test for read vs write
      checkpatch: Don't emit spurious warnings about block comments
      xlnx-zynqmp: Don't create rpu-cluster if there are no RPUs
      hw/arm/xlnx-zynqmp: Realize cluster after putting RPUs in it
      qom/cpu: Add cluster_index to CPUState
      accel/tcg: Add cluster number to TCG TB hash
      gdbstub: Simplify gdb_get_cpu_pid() to use cpu->cluster_index

Richard Henderson (1):
      target/arm: Fix validation of 32-bit address spaces for aa32

Stefan Hajnoczi (3):
      tests/microbit-test: add TWI stub device test
      MAINTAINERS: update microbit ARM board files
      memory: add memory_region_flush_rom_device()

Steffen Görtz (4):
      arm: Stub out NRF51 TWI magnetometer/accelerometer detection
      hw/nvram/nrf51_nvm: Add nRF51 non-volatile memories
      arm: Instantiate NRF51 special NVM's and NVMC
      tests/microbit-test: Add tests for nRF51 NVMC

Thomas Roth (1):
      target/arm: v8m: Ensure IDAU is respected if SAU is disabled

 hw/i2c/Makefile.objs          |   1 +
 hw/nvram/Makefile.objs        |   1 +
 include/exec/exec-all.h       |   4 +-
 include/exec/memory.h         |  18 ++
 include/hw/arm/nrf51.h        |   2 +
 include/hw/arm/nrf51_soc.h    |   3 +
 include/hw/cpu/cluster.h      |  24 +++
 include/hw/i2c/microbit_i2c.h |  42 ++++
 include/hw/nvram/nrf51_nvm.h  |  64 ++++++
 include/hw/ssi/aspeed_smc.h   |   3 +
 include/qom/cpu.h             |   7 +
 target/arm/cpu.h              |  11 +-
 tests/libqtest.h              |  11 +
 accel/tcg/cpu-exec.c          |   3 +
 accel/tcg/translate-all.c     |   3 +
 accel/tcg/user-exec.c         |  66 ++++--
 exec.c                        |  19 +-
 gdbstub.c                     | 120 +++++------
 hw/arm/microbit.c             |  16 ++
 hw/arm/nrf51_soc.c            |  41 ++--
 hw/arm/xlnx-zynqmp.c          |   9 +-
 hw/cpu/cluster.c              |  46 +++++
 hw/i2c/microbit_i2c.c         | 127 ++++++++++++
 hw/nvram/nrf51_nvm.c          | 381 +++++++++++++++++++++++++++++++++++
 hw/ssi/aspeed_smc.c           | 128 +++++++++++-
 qom/cpu.c                     |   1 +
 target/arm/cpu.c              |   3 +-
 target/arm/helper.c           |  67 +++---
 tests/libqtest.c              |  25 +++
 tests/microbit-test.c         | 458 ++++++++++++++++++++++++++++++++----------
 MAINTAINERS                   |   8 +-
 scripts/checkpatch.pl         |   2 +-
 32 files changed, 1459 insertions(+), 255 deletions(-)
 create mode 100644 include/hw/i2c/microbit_i2c.h
 create mode 100644 include/hw/nvram/nrf51_nvm.h
 create mode 100644 hw/i2c/microbit_i2c.c
 create mode 100644 hw/nvram/nrf51_nvm.c
