Received: from eggs.gnu.org ([2001:4830:134:3::10]:33614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumb-0007GY-VH
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYuma-00061m-HB
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:58 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYuma-0005dk-8R
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:56 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumS-0004TZ-OL
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:53:48 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:52:52 +0100
Message-Id: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/55] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hopefully last target-arm queue before softfreeze;
this one's largest part is the remainder of the SVE patches,
but there are a selection of other minor things too.

thanks
-- PMM

The following changes since commit 109b25045b3651f9c5d02c3766c0b3ff63e6d193:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-06-29 12:30:29 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180629

for you to fetch changes up to 802abf4024d23e48d45373ac3f2b580124b54b47:

  target/arm: Add ID_ISAR6 (2018-06-29 15:30:54 +0100)

----------------------------------------------------------------
target-arm queue:
 * last of the SVE patches; SVE is now enabled for aarch64 linux-user
 * sd: Don't trace SDRequest crc field (coverity bugfix)
 * target/arm: Mark PMINTENSET accesses as possibly doing IO
 * clean up v7VE feature bit handling
 * i.mx7d: minor cleanups
 * target/arm: support reading of CNT[VCT|FRQ]_EL0 from user-space
 * target/arm: Implement ARMv8.2-DotProd
 * virt: add addresses to dt node names (which stops dtc from
   complaining that they're not correctly named)
 * cleanups: replace error_setg(&error_fatal) by error_report() + exit()

----------------------------------------------------------------
Aaron Lindsay (3):
      target/arm: Add ARM_FEATURE_V7VE for v7 Virtualization Extensions
      target/arm: Remove redundant DIV detection for KVM
      target/arm: Mark PMINTENSET accesses as possibly doing IO

Alex Bennée (1):
      target/arm: support reading of CNT[VCT|FRQ]_EL0 from user-space

Eric Auger (3):
      device_tree: Add qemu_fdt_node_unit_path
      hw/arm/virt: Silence dtc /intc warnings
      hw/arm/virt: Silence dtc /memory warning

Jean-Christophe Dubois (3):
      i.mx7d: Remove unused header files
      i.mx7d: Change SRC unimplemented device name from sdma to src
      i.mx7d: Change IRQ number type from hwaddr to int

Peter Maydell (1):
      sd: Don't trace SDRequest crc field

Philippe Mathieu-Daudé (4):
      hw/block/fdc: Replace error_setg(&error_abort) by assert()
      hw/arm/sysbus-fdt: Replace error_setg(&error_fatal) by error_report() + exit()
      device_tree: Replace error_setg(&error_fatal) by error_report() + exit()
      sdcard: Use the ldst API

Richard Henderson (40):
      target/arm: Implement SVE Memory Contiguous Load Group
      target/arm: Implement SVE Contiguous Load, first-fault and no-fault
      target/arm: Implement SVE Memory Contiguous Store Group
      target/arm: Implement SVE load and broadcast quadword
      target/arm: Implement SVE integer convert to floating-point
      target/arm: Implement SVE floating-point arithmetic (predicated)
      target/arm: Implement SVE FP Multiply-Add Group
      target/arm: Implement SVE Floating Point Accumulating Reduction Group
      target/arm: Implement SVE load and broadcast element
      target/arm: Implement SVE store vector/predicate register
      target/arm: Implement SVE scatter stores
      target/arm: Implement SVE prefetches
      target/arm: Implement SVE gather loads
      target/arm: Implement SVE first-fault gather loads
      target/arm: Implement SVE scatter store vector immediate
      target/arm: Implement SVE floating-point compare vectors
      target/arm: Implement SVE floating-point arithmetic with immediate
      target/arm: Implement SVE Floating Point Multiply Indexed Group
      target/arm: Implement SVE FP Fast Reduction Group
      target/arm: Implement SVE Floating Point Unary Operations - Unpredicated Group
      target/arm: Implement SVE FP Compare with Zero Group
      target/arm: Implement SVE floating-point trig multiply-add coefficient
      target/arm: Implement SVE floating-point convert precision
      target/arm: Implement SVE floating-point convert to integer
      target/arm: Implement SVE floating-point round to integral value
      target/arm: Implement SVE floating-point unary operations
      target/arm: Implement SVE MOVPRFX
      target/arm: Implement SVE floating-point complex add
      target/arm: Implement SVE fp complex multiply add
      target/arm: Pass index to AdvSIMD FCMLA (indexed)
      target/arm: Implement SVE fp complex multiply add (indexed)
      target/arm: Implement SVE dot product (vectors)
      target/arm: Implement SVE dot product (indexed)
      target/arm: Enable SVE for aarch64-linux-user
      target/arm: Implement ARMv8.2-DotProd
      target/arm: Fix SVE signed division vs x86 overflow exception
      target/arm: Fix SVE system register access checks
      target/arm: Prune a57 features from max
      target/arm: Prune a15 features from max
      target/arm: Add ID_ISAR6

 include/sysemu/device_tree.h |   16 +
 target/arm/cpu.h             |    3 +
 target/arm/helper-sve.h      |  682 +++++++++++++++
 target/arm/helper.h          |   44 +-
 device_tree.c                |   78 +-
 hw/arm/boot.c                |   41 +-
 hw/arm/fsl-imx7.c            |    8 +-
 hw/arm/mcimx7d-sabre.c       |    2 -
 hw/arm/sysbus-fdt.c          |   53 +-
 hw/arm/virt.c                |   70 +-
 hw/block/fdc.c               |    9 +-
 hw/sd/bcm2835_sdhost.c       |   13 +-
 hw/sd/core.c                 |    2 +-
 hw/sd/milkymist-memcard.c    |    3 +-
 hw/sd/omap_mmc.c             |    6 +-
 hw/sd/pl181.c                |   11 +-
 hw/sd/sdhci.c                |   15 +-
 hw/sd/ssi-sd.c               |    6 +-
 linux-user/elfload.c         |    2 +
 target/arm/cpu.c             |   36 +-
 target/arm/cpu64.c           |   13 +-
 target/arm/helper.c          |   44 +-
 target/arm/kvm32.c           |   27 +-
 target/arm/sve_helper.c      | 1875 +++++++++++++++++++++++++++++++++++++++++-
 target/arm/translate-a64.c   |   62 +-
 target/arm/translate-sve.c   | 1688 ++++++++++++++++++++++++++++++++++++-
 target/arm/translate.c       |  102 ++-
 target/arm/vec_helper.c      |  311 ++++++-
 hw/sd/trace-events           |    2 +-
 target/arm/sve.decode        |  427 ++++++++++
 30 files changed, 5394 insertions(+), 257 deletions(-)
