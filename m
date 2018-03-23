Received: from eggs.gnu.org ([2001:4830:134:3::10]:49089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlK-00017K-JP
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlJ-0004Cl-IC
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:02 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ezRlJ-0004CA-Ay
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:01 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlH-0007dP-Eh
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:49:59 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 18:49:48 +0000
Message-Id: <20180323184958.14252-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/10] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ten arm-related bug fixes for 2.12...

thanks
-- PMM

The following changes since commit 4c2c1015905fa1d616750dfe024b4c0b35875950:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20180323' into staging (2018-03-23 10:20:54 +0000)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180323

for you to fetch changes up to 548f514cf89dd9ab39c0cb4c063097bccf141fdd:

  target/arm: Always set FAR to a known unknown value for debug exceptions (2018-03-23 18:26:46 +0000)

----------------------------------------------------------------
target-arm queue:
 * arm/translate-a64: don't lose interrupts after unmasking via write to DAIF
 * sdhci: fix incorrect use of Error *
 * hw/intc/arm_gicv3: Fix secure-GIC NS ICC_PMR and ICC_RPR accesses
 * hw/arm/bcm2836: Use the Cortex-A7 instead of Cortex-A15
 * i.MX: Support serial RS-232 break properly
 * mach-virt: Set VM's SMBIOS system version to mc->name
 * target/arm: Honour MDCR_EL2.TDE when routing exceptions due to BKPT/BRK
 * target/arm: Factor out code to calculate FSR for debug exceptions
 * target/arm: Set FSR for BKPT, BRK when raising exception
 * target/arm: Always set FAR to a known unknown value for debug exceptions

----------------------------------------------------------------
Paolo Bonzini (1):
      sdhci: fix incorrect use of Error *

Peter Maydell (6):
      hw/intc/arm_gicv3: Fix secure-GIC NS ICC_PMR and ICC_RPR accesses
      hw/arm/bcm2836: Use the Cortex-A7 instead of Cortex-A15
      target/arm: Honour MDCR_EL2.TDE when routing exceptions due to BKPT/BRK
      target/arm: Factor out code to calculate FSR for debug exceptions
      target/arm: Set FSR for BKPT, BRK when raising exception
      target/arm: Always set FAR to a known unknown value for debug exceptions

Trent Piepho (1):
      i.MX: Support serial RS-232 break properly

Victor Kamensky (1):
      arm/translate-a64: treat DISAS_UPDATE as variant of DISAS_EXIT

Wei Huang (1):
      mach-virt: Set VM's SMBIOS system version to mc->name

 include/hw/arm/virt.h        |  1 +
 include/hw/char/imx_serial.h |  1 +
 target/arm/helper.h          |  1 +
 target/arm/internals.h       | 25 +++++++++++++++++++++++++
 hw/arm/bcm2836.c             |  2 +-
 hw/arm/raspi.c               |  2 +-
 hw/arm/virt.c                |  8 +++++++-
 hw/char/imx_serial.c         |  5 ++++-
 hw/intc/arm_gicv3_cpuif.c    |  6 +++---
 hw/sd/sdhci.c                |  4 ++--
 target/arm/helper.c          |  1 -
 target/arm/op_helper.c       | 33 ++++++++++++++++++++++-----------
 target/arm/translate-a64.c   | 21 ++++++++++++++++-----
 target/arm/translate.c       | 19 ++++++++++++++-----
 14 files changed, 98 insertions(+), 31 deletions(-)
