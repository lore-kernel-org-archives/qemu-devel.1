Received: from eggs.gnu.org ([209.51.188.92]:58707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbLI-0007YZ-BR
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbLG-0003FI-D7
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:06:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:39487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbLF-0003Eo-VR
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:06:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id y8so6724275wmi.4
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:06:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.06.54
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:06:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:06 +0000
Message-Id: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/47] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As promised, more Arm patches. The big thing in here is the
MPS2-AN521 board model.

thanks
-- PMM

The following changes since commit cfe6c547690b06fbce54a6d0f7b05dd7f18e36ea:

  Merge remote-tracking branch 'remotes/xanclic/tags/pull-block-2019-01-31' into staging (2019-01-31 19:26:09 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190201

for you to fetch changes up to 7743b70ffe7a8ce168adce2cf50ad156b1fefb8c:

  tests/microbit-test: Add tests for nRF51 NVMC (2019-02-01 15:32:17 +0000)

----------------------------------------------------------------
target-arm queue:
 * New machine mps2-an521 -- this is a model of the AN521 FPGA image for the MPS2 devboard
 * Fix various places where we failed to UNDEF invalid A64 instructions
 * Don't UNDEF a valid FCMLA on 32-bit inputs
 * Fix some bugs in the newly-added PAuth implementation
 * microbit: Implement NVMC non-volatile memory controller

----------------------------------------------------------------
Aaron Lindsay OS (2):
      target/arm: Send interrupts on PMU counter overflow
      target/arm: Add a timer to predict PMU counter overflow

Julia Suvorova (1):
      arm: Clarify the logic of set_pc()

Peter Maydell (33):
      armv7m: Don't assume the NVIC's CPU is CPU 0
      armv7m: Make cpu object a child of the armv7m container
      armv7m: Pass through start-powered-off CPU property
      hw/arm/iotkit: Rename IoTKit to ARMSSE
      hw/arm/iotkit: Refactor into abstract base class and subclass
      hw/arm/iotkit: Rename 'iotkit' local variables and functions
      hw/arm/iotkit: Rename files to hw/arm/armsse.[ch]
      hw/misc/iotkit-secctl: Support 4 internal MPCs
      hw/arm/armsse: Make number of SRAM banks parameterised
      hw/arm/armsse: Make SRAM bank size configurable
      hw/arm/armsse: Support dual-CPU configuration
      hw/arm/armsse: Give each CPU its own view of memory
      hw/arm/armsse: Put each CPU in its own cluster object
      iotkit-sysinfo: Make SYS_VERSION and SYS_CONFIG configurable
      hw/arm/armsse: Add unimplemented-device stubs for MHUs
      hw/arm/armsse: Add unimplemented-device stubs for PPUs
      hw/arm/armsse: Add unimplemented-device stub for cache control registers
      hw/arm/armsse: Add unimplemented-device stub for CPU local control registers
      hw/misc/armsse-cpuid: Implement SSE-200 CPU_IDENTITY register block
      hw/arm/armsse: Add CPU_IDENTITY block to SSE-200
      hw/arm/armsse: Add SSE-200 model
      hw/arm/mps2-tz: Add IRQ infrastructure to support SSE-200
      hw/arm/mps2-tz: Add mps2-an521 model
      target/arm/translate-a64: Don't underdecode system instructions
      target/arm/translate-a64: Don't underdecode PRFM
      target/arm/translate-a64: Don't underdecode SIMD ld/st multiple
      target/arm/translate-a64: Don't underdecode SIMD ld/st single
      target/arm/translate-a64: Don't underdecode add/sub extended register
      target/arm/translate-a64: Don't underdecode FP insns
      target/arm/translate-a64: Don't underdecode SDOT and UDOT
      exec.c: Don't reallocate IOMMUNotifiers that are in use
      target/arm/translate-a64: Fix FCMLA decoding error
      target/arm/translate-a64: Fix mishandling of size in FCMLA decode

Remi Denis-Courmont (2):
      target/arm: fix AArch64 virtual address space size
      target/arm: fix decoding of B{,L}RA{A,B}

Richard Henderson (5):
      target/arm: Enable API, APK bits in SCR, HCR
      target/arm: Always enable pac keys for user-only
      aarch64-linux-user: Update HWCAP bits from linux 5.0-rc1
      aarch64-linux-user: Enable HWCAP bits for PAuth
      linux-user: Initialize aarch64 pac keys

Steffen Görtz (3):
      hw/nvram/nrf51_nvm: Add nRF51 non-volatile memories
      arm: Instantiate NRF51 special NVM's and NVMC
      tests/microbit-test: Add tests for nRF51 NVMC

kumar sourav (1):
      hw/arm/nrf51_soc: set object owner in memory_region_init_ram

 hw/arm/Makefile.objs                  |    2 +-
 hw/misc/Makefile.objs                 |    1 +
 hw/nvram/Makefile.objs                |    1 +
 include/hw/arm/{iotkit.h => armsse.h} |  113 ++-
 include/hw/arm/armv7m.h               |    1 +
 include/hw/arm/nrf51_soc.h            |    2 +
 include/hw/misc/armsse-cpuid.h        |   41 ++
 include/hw/misc/iotkit-secctl.h       |    6 +-
 include/hw/misc/iotkit-sysinfo.h      |    6 +
 include/hw/nvram/nrf51_nvm.h          |   64 ++
 include/qom/cpu.h                     |   16 +-
 linux-user/aarch64/target_syscall.h   |    2 +
 target/arm/cpu.h                      |   12 +-
 exec.c                                |   10 +-
 hw/arm/armsse.c                       | 1241 +++++++++++++++++++++++++++++++++
 hw/arm/armv7m.c                       |   23 +-
 hw/arm/boot.c                         |    4 -
 hw/arm/iotkit.c                       |  759 --------------------
 hw/arm/mps2-tz.c                      |  121 +++-
 hw/arm/nrf51_soc.c                    |   44 +-
 hw/intc/armv7m_nvic.c                 |    3 +-
 hw/misc/armsse-cpuid.c                |  134 ++++
 hw/misc/iotkit-secctl.c               |    5 +-
 hw/misc/iotkit-sysinfo.c              |   15 +-
 hw/nvram/nrf51_nvm.c                  |  388 +++++++++++
 linux-user/aarch64/cpu_loop.c         |   31 +-
 linux-user/elfload.c                  |   10 +
 target/arm/arm-powerctl.c             |    3 -
 target/arm/cpu.c                      |   41 +-
 target/arm/cpu64.c                    |   75 --
 target/arm/helper.c                   |  139 +++-
 target/arm/translate-a64.c            |   59 +-
 tests/microbit-test.c                 |  108 +++
 MAINTAINERS                           |    6 +-
 default-configs/arm-softmmu.mak       |    3 +-
 hw/misc/trace-events                  |    4 +
 36 files changed, 2552 insertions(+), 941 deletions(-)
 rename include/hw/arm/{iotkit.h => armsse.h} (53%)
 create mode 100644 include/hw/misc/armsse-cpuid.h
 create mode 100644 include/hw/nvram/nrf51_nvm.h
 create mode 100644 hw/arm/armsse.c
 delete mode 100644 hw/arm/iotkit.c
 create mode 100644 hw/misc/armsse-cpuid.c
 create mode 100644 hw/nvram/nrf51_nvm.c
