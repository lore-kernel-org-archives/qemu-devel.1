Received: from eggs.gnu.org ([2001:4830:134:3::10]:59508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmp-0008MD-Sd
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmo-000633-Rj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:31 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmo-00060G-KO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:30 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmh-00073Q-2U
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:23 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:25:57 +0000
Message-Id: <20180309172622.4277-1-peter.maydell@linaro.org>
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

Arm pullreq for the 2.12 codefreeze...

thanks
-- PMM

The following changes since commit b39b61e410022f96ceb53d4381d25cba5126ac44:

  memory: fix flatview_access_valid RCU read lock/unlock imbalance (2018-03-09 15:55:20 +0000)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180309

for you to fetch changes up to 076a0fc32a73a9b960e0f73f04a531bc1bd94308:

  MAINTAINERS: Add entries for SD (SDHCI, SDBus, SDCard) (2018-03-09 17:09:45 +0000)

----------------------------------------------------------------
target-arm queue:
 * i.MX: Add i.MX7 SOC implementation and i.MX7 Sabre board
 * Report the correct core count in A53 L2CTLR on the ZynqMP board
 * linux-user: preliminary SVE support work (signal handling)
 * hw/arm/boot: fix memory leak in case of error loading ELF file
 * hw/arm/boot: avoid reading off end of buffer if passed very
   small image file
 * hw/arm: Use more CONFIG switches for the object files
 * target/arm: Add "-cpu max" support
 * hw/arm/virt: Support -machine gic-version=max
 * hw/sd: improve debug tracing
 * hw/sd: sdcard: Add the Tuning Command (CMD 19)
 * MAINTAINERS: add Philippe as odd-fixes maintainer for SD

----------------------------------------------------------------
Alistair Francis (2):
      target/arm: Add a core count property
      hw/arm: Set the core count for Xilinx's ZynqMP

Andrey Smirnov (3):
      pci: Add support for Designware IP block
      i.MX: Add i.MX7 SOC implementation.
      Implement support for i.MX7 Sabre board

Marc-André Lureau (2):
      arm: fix load ELF error leak
      arm: avoid heap-buffer-overflow in load_aarch64_image

Peter Maydell (6):
      target/arm: Query host CPU features on-demand at instance init
      target/arm: Move definition of 'host' cpu type into cpu.c
      target/arm: Add "-cpu max" support
      target/arm: Make 'any' CPU just an alias for 'max'
      hw/arm/virt: Add "max" to the list of CPU types "virt" supports
      hw/arm/virt: Support -machine gic-version=max

Philippe Mathieu-Daudé (6):
      sdcard: Do not trace CMD55, except when we already expect an ACMD
      sdcard: Display command name when tracing CMD/ACMD
      sdcard: Display which protocol is used when tracing (SD or SPI)
      sdcard: Add the Tuning Command (CMD19)
      sdhci: Fix a typo in comment
      MAINTAINERS: Add entries for SD (SDHCI, SDBus, SDCard)

Richard Henderson (5):
      linux-user: Implement aarch64 PR_SVE_SET/GET_VL
      aarch64-linux-user: Split out helpers for guest signal handling
      aarch64-linux-user: Remove struct target_aux_context
      aarch64-linux-user: Add support for EXTRA signal frame records
      aarch64-linux-user: Add support for SVE signal frame records

Thomas Huth (1):
      hw/arm: Use more CONFIG switches for the object files

 hw/arm/Makefile.objs                |  31 +-
 hw/pci-host/Makefile.objs           |   2 +
 hw/sd/Makefile.objs                 |   2 +-
 hw/sd/sdmmc-internal.h              |  24 ++
 include/hw/arm/fsl-imx7.h           | 222 +++++++++++
 include/hw/pci-host/designware.h    | 102 +++++
 include/hw/pci/pci_ids.h            |   2 +
 linux-user/aarch64/target_syscall.h |   3 +
 target/arm/cpu-qom.h                |   2 +
 target/arm/cpu.h                    |  11 +
 target/arm/kvm_arm.h                |  35 +-
 hw/arm/boot.c                       |   4 +-
 hw/arm/fsl-imx7.c                   | 582 ++++++++++++++++++++++++++++
 hw/arm/mcimx7d-sabre.c              |  90 +++++
 hw/arm/virt.c                       |  30 +-
 hw/arm/xlnx-zynqmp.c                |   2 +
 hw/pci-host/designware.c            | 754 ++++++++++++++++++++++++++++++++++++
 hw/sd/sd.c                          |  55 ++-
 hw/sd/sdhci.c                       |   4 +-
 hw/sd/sdmmc-internal.c              |  72 ++++
 linux-user/signal.c                 | 415 ++++++++++++++++----
 linux-user/syscall.c                |  27 ++
 target/arm/cpu.c                    | 103 ++++-
 target/arm/cpu64.c                  | 113 ++++--
 target/arm/kvm.c                    |  53 +--
 target/arm/kvm32.c                  |   8 +-
 target/arm/kvm64.c                  |   8 +-
 MAINTAINERS                         |   8 +
 default-configs/arm-softmmu.mak     |   9 +
 hw/sd/trace-events                  |   8 +-
 30 files changed, 2583 insertions(+), 198 deletions(-)
 create mode 100644 include/hw/arm/fsl-imx7.h
 create mode 100644 include/hw/pci-host/designware.h
 create mode 100644 hw/arm/fsl-imx7.c
 create mode 100644 hw/arm/mcimx7d-sabre.c
 create mode 100644 hw/pci-host/designware.c
 create mode 100644 hw/sd/sdmmc-internal.c
