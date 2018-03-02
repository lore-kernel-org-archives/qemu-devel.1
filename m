Received: from eggs.gnu.org ([2001:4830:134:3::10]:43235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWS-0002ki-If
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWR-0004k3-8X
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWR-0004jE-04
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWP-0001IH-6s
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:41 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:01 +0000
Message-Id: <20180302110640.28004-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/39] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Second pull request of the week; mostly RTH's support for some
new-in-v8.1/v8.3 instructions, and my v8M board model.

thanks
-- PMM

The following changes since commit 427cbc7e4136a061628cb4315cc8182ea36d772f:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-03-01 18:46:41 +0000)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180302

for you to fetch changes up to e66a67bf28e1b4fce2e3d72a2610dbd48d9d3078:

  target/arm: Enable ARM_FEATURE_V8_FCMA (2018-03-02 11:03:45 +0000)

----------------------------------------------------------------
target-arm queue:
 * implement FCMA and RDM v8.1 and v8.3 instructions
 * enable Cortex-M33 v8M core, and provide new mps2-an505 board model
   that uses it
 * decodetree: Propagate return value from translate subroutines
 * xlnx-zynqmp: Implement the RTC device

----------------------------------------------------------------
Alistair Francis (3):
      xlnx-zynqmp-rtc: Initial commit
      xlnx-zynqmp-rtc: Add basic time support
      xlnx-zynqmp: Connect the RTC device

Peter Maydell (19):
      loader: Add new load_ramdisk_as()
      hw/arm/boot: Honour CPU's address space for image loads
      hw/arm/armv7m: Honour CPU's address space for image loads
      target/arm: Define an IDAU interface
      armv7m: Forward idau property to CPU object
      target/arm: Define init-svtor property for the reset secure VTOR value
      armv7m: Forward init-svtor property to CPU object
      target/arm: Add Cortex-M33
      hw/misc/unimp: Move struct to header file
      include/hw/or-irq.h: Add missing include guard
      qdev: Add new qdev_init_gpio_in_named_with_opaque()
      hw/core/split-irq: Device that splits IRQ lines
      hw/misc/mps2-fpgaio: FPGA control block for MPS2 AN505
      hw/misc/tz-ppc: Model TrustZone peripheral protection controller
      hw/misc/iotkit-secctl: Arm IoT Kit security controller initial skeleton
      hw/misc/iotkit-secctl: Add handling for PPCs
      hw/misc/iotkit-secctl: Add remaining simple registers
      hw/arm/iotkit: Model Arm IOT Kit
      mps2-an505: New board model: MPS2 with AN505 Cortex-M33 FPGA image

Richard Henderson (17):
      decodetree: Propagate return value from translate subroutines
      target/arm: Add ARM_FEATURE_V8_RDM
      target/arm: Refactor disas_simd_indexed decode
      target/arm: Refactor disas_simd_indexed size checks
      target/arm: Decode aa64 armv8.1 scalar three same extra
      target/arm: Decode aa64 armv8.1 three same extra
      target/arm: Decode aa64 armv8.1 scalar/vector x indexed element
      target/arm: Decode aa32 armv8.1 three same
      target/arm: Decode aa32 armv8.1 two reg and a scalar
      target/arm: Enable ARM_FEATURE_V8_RDM
      target/arm: Add ARM_FEATURE_V8_FCMA
      target/arm: Decode aa64 armv8.3 fcadd
      target/arm: Decode aa64 armv8.3 fcmla
      target/arm: Decode aa32 armv8.3 3-same
      target/arm: Decode aa32 armv8.3 2-reg-index
      target/arm: Decode t32 simd 3reg and 2reg_scalar extension
      target/arm: Enable ARM_FEATURE_V8_FCMA

 hw/arm/Makefile.objs               |   2 +
 hw/core/Makefile.objs              |   1 +
 hw/misc/Makefile.objs              |   4 +
 hw/timer/Makefile.objs             |   1 +
 target/arm/Makefile.objs           |   2 +-
 include/hw/arm/armv7m.h            |   5 +
 include/hw/arm/iotkit.h            | 109 ++++++
 include/hw/arm/xlnx-zynqmp.h       |   2 +
 include/hw/core/split-irq.h        |  57 +++
 include/hw/irq.h                   |   4 +-
 include/hw/loader.h                |  12 +-
 include/hw/misc/iotkit-secctl.h    | 103 ++++++
 include/hw/misc/mps2-fpgaio.h      |  43 +++
 include/hw/misc/tz-ppc.h           | 101 ++++++
 include/hw/misc/unimp.h            |  10 +
 include/hw/or-irq.h                |   5 +
 include/hw/qdev-core.h             |  30 +-
 include/hw/timer/xlnx-zynqmp-rtc.h |  86 +++++
 target/arm/cpu.h                   |   8 +
 target/arm/helper.h                |  31 ++
 target/arm/idau.h                  |  61 ++++
 hw/arm/armv7m.c                    |  35 +-
 hw/arm/boot.c                      | 119 ++++---
 hw/arm/iotkit.c                    | 598 +++++++++++++++++++++++++++++++
 hw/arm/mps2-tz.c                   | 503 ++++++++++++++++++++++++++
 hw/arm/xlnx-zynqmp.c               |  14 +
 hw/core/loader.c                   |   8 +-
 hw/core/qdev.c                     |   8 +-
 hw/core/split-irq.c                |  89 +++++
 hw/misc/iotkit-secctl.c            | 704 +++++++++++++++++++++++++++++++++++++
 hw/misc/mps2-fpgaio.c              | 176 ++++++++++
 hw/misc/tz-ppc.c                   | 302 ++++++++++++++++
 hw/misc/unimp.c                    |  10 -
 hw/timer/xlnx-zynqmp-rtc.c         | 272 ++++++++++++++
 linux-user/elfload.c               |   2 +
 target/arm/cpu.c                   |  66 +++-
 target/arm/cpu64.c                 |   2 +
 target/arm/helper.c                |  28 +-
 target/arm/translate-a64.c         | 514 +++++++++++++++++++++------
 target/arm/translate.c             | 275 +++++++++++++--
 target/arm/vec_helper.c            | 429 ++++++++++++++++++++++
 default-configs/arm-softmmu.mak    |   5 +
 hw/misc/trace-events               |  24 ++
 hw/timer/trace-events              |   3 +
 scripts/decodetree.py              |   5 +-
 45 files changed, 4668 insertions(+), 200 deletions(-)
 create mode 100644 include/hw/arm/iotkit.h
 create mode 100644 include/hw/core/split-irq.h
 create mode 100644 include/hw/misc/iotkit-secctl.h
 create mode 100644 include/hw/misc/mps2-fpgaio.h
 create mode 100644 include/hw/misc/tz-ppc.h
 create mode 100644 include/hw/timer/xlnx-zynqmp-rtc.h
 create mode 100644 target/arm/idau.h
 create mode 100644 hw/arm/iotkit.c
 create mode 100644 hw/arm/mps2-tz.c
 create mode 100644 hw/core/split-irq.c
 create mode 100644 hw/misc/iotkit-secctl.c
 create mode 100644 hw/misc/mps2-fpgaio.c
 create mode 100644 hw/misc/tz-ppc.c
 create mode 100644 hw/timer/xlnx-zynqmp-rtc.c
 create mode 100644 target/arm/vec_helper.c
