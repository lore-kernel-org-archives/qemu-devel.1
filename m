Received: from eggs.gnu.org ([209.51.188.92]:43788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goS3t-0005Or-DD
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goS3j-0001Lf-LJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:00:17 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goS3j-0001Ja-8I
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:00:07 -0500
Received: by mail-wm1-x332.google.com with SMTP id g67so17445573wmd.2
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 04:00:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a8sm4717974wme.23.2019.01.29.04.00.03
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 29 Jan 2019 04:00:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 12:00:02 +0000
Message-Id: <20190129120002.3866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/23] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v2: dropped patches that add the microbit nRF51 non-volatile memories
and the test case for them.

thanks
-- PMM


The following changes since commit 3a183e330dbd7dbcac3841737ac874979552cca2:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190128' into staging (2019-01-28 16:26:47 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190129

for you to fetch changes up to 46f5abc0a2566ac3dc954eeb62fd625f0eaca120:

  gdbstub: Simplify gdb_get_cpu_pid() to use cpu->cluster_index (2019-01-29 11:46:06 +0000)

----------------------------------------------------------------
target-arm queue:
 * Fix validation of 32-bit address spaces for aa32 (fixes an assert introduced in ba97be9f4a4)
 * v8m: Ensure IDAU is respected if SAU is disabled
 * gdbstub: fix gdb_get_cpu(s, pid, tid) when pid and/or tid are 0
 * exec.c: Use correct attrs in cpu_memory_rw_debug()
 * accel/tcg/user-exec: Don't parse aarch64 insns to test for read vs write
 * target/arm: Don't clear supported PMU events when initializing PMCEID1
 * memory: add memory_region_flush_rom_device()
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

Steffen Görtz (1):
      arm: Stub out NRF51 TWI magnetometer/accelerometer detection

Thomas Roth (1):
      target/arm: v8m: Ensure IDAU is respected if SAU is disabled

 hw/i2c/Makefile.objs          |   1 +
 include/exec/exec-all.h       |   4 +-
 include/exec/memory.h         |  18 +++
 include/hw/arm/nrf51.h        |   2 +
 include/hw/arm/nrf51_soc.h    |   1 +
 include/hw/cpu/cluster.h      |  24 +++
 include/hw/i2c/microbit_i2c.h |  42 +++++
 include/hw/ssi/aspeed_smc.h   |   3 +
 include/qom/cpu.h             |   7 +
 target/arm/cpu.h              |  11 +-
 tests/libqtest.h              |  11 ++
 accel/tcg/cpu-exec.c          |   3 +
 accel/tcg/translate-all.c     |   3 +
 accel/tcg/user-exec.c         |  66 ++++++--
 exec.c                        |  19 ++-
 gdbstub.c                     | 120 ++++++---------
 hw/arm/microbit.c             |  16 ++
 hw/arm/xlnx-zynqmp.c          |   9 +-
 hw/cpu/cluster.c              |  46 ++++++
 hw/i2c/microbit_i2c.c         | 127 +++++++++++++++
 hw/ssi/aspeed_smc.c           | 128 ++++++++++++++-
 qom/cpu.c                     |   1 +
 target/arm/cpu.c              |   3 +-
 target/arm/helper.c           |  67 ++++----
 tests/libqtest.c              |  25 +++
 tests/microbit-test.c         | 350 +++++++++++++++++++++++++++++-------------
 MAINTAINERS                   |   8 +-
 scripts/checkpatch.pl         |   2 +-
 28 files changed, 874 insertions(+), 243 deletions(-)
 create mode 100644 include/hw/i2c/microbit_i2c.h
 create mode 100644 hw/i2c/microbit_i2c.c
