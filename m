Received: from eggs.gnu.org ([2001:4830:134:3::10]:37189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWR-0002QH-2J
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWP-00045C-RE
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:55 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWP-00043I-K1
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:53 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWH-0001Le-ON
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:45 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:23 +0000
Message-Id: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 00/21] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue: nothing hugely exciting here, the
bulk is Andrew's virt-acpi-build refactorings.

thanks
-- PMM

The following changes since commit ffe22bf51065dd33022cf91f77a821d1f11c250d:

  Merge remote-tracking branch 'remotes/gonglei/tags/cryptodev-next-20161224' into staging (2017-01-06 15:18:09 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170109

for you to fetch changes up to 556899fc1965d82f5c4a3ba6a0be3b1193e2c4b2:

  hw/ssi/imx_spi.c: Remove MSGDATA register support (2017-01-09 11:50:23 +0000)

----------------------------------------------------------------
target-arm queue:
 * i2c: Allow I2C devices to NAK start events
 * hw/char: QOM'ify exynos4210_uart.c
 * clean up and refactor virt-acpi-build.c
 * virt-acpi-build: Don't incorrectly claim architectural timer
   to be edge-triggered
 * m25p80: Don't let rogue SPI controllers cause buffer overruns
 * imx_spi: Remove broken MSGDATA register support

----------------------------------------------------------------
Andrew Jones (14):
      hw/arm/virt-acpi-build: add all missing cpu_to_le's
      hw/arm/virt-acpi-build: name GIC CPU Interface Structure appropriately
      hw/arm/virt-acpi-build: gtdt: improve flag naming
      hw/arm/virt-acpi-build: fadt: improve flag naming
      hw/arm/virt: parameter passing cleanups
      hw/arm/virt: use VirtMachineState.gic_version
      hw/arm/virt: eliminate struct VirtGuestInfoState
      hw/arm/virt: remove include/hw/arm/virt-acpi-build.h
      hw/arm/virt: move VirtMachineState/Class to virt.h
      hw/arm/virt: pass VirtMachineState instead of VirtGuestInfo
      hw/arm/virt-acpi-build: remove redundant members from VirtGuestInfo
      hw/arm/virt-acpi-build: don't save VirtGuestInfo on AcpiBuildState
      hw/arm/virt: remove VirtGuestInfo
      hw/arm/virt-acpi-build: Don't incorrectly claim architectural timer to be edge-triggered

Corey Minyard (1):
      i2c: Allow I2C devices to NAK start events

Jean-Christophe Dubois (2):
      m25p80: don't let rogue SPI controllers cause buffer overruns
      hw/ssi/imx_spi.c: Remove MSGDATA register support

Peter Maydell (3):
      hw/arm/virt: Merge VirtBoardInfo and VirtMachineState
      hw/arm/virt: Rename 'vbi' variables to 'vms'
      hw/arm/virt: Don't incorrectly claim architectural timer to be edge-triggered

xiaoqiang zhao (1):
      hw/char: QOM'ify exynos4210_uart.c

 include/hw/acpi/acpi-defs.h      |  33 +-
 include/hw/arm/virt-acpi-build.h |  47 ---
 include/hw/arm/virt.h            |  41 ++-
 include/hw/i2c/i2c.h             |  16 +-
 hw/arm/pxa2xx.c                  |   4 +-
 hw/arm/tosa.c                    |   4 +-
 hw/arm/virt-acpi-build.c         | 134 ++++----
 hw/arm/virt.c                    | 691 ++++++++++++++++++---------------------
 hw/arm/z2.c                      |   4 +-
 hw/audio/wm8750.c                |   4 +-
 hw/block/m25p80.c                |  29 +-
 hw/char/exynos4210_uart.c        |  16 +-
 hw/display/ssd0303.c             |   4 +-
 hw/gpio/max7310.c                |   4 +-
 hw/i2c/core.c                    |  31 +-
 hw/i2c/i2c-ddc.c                 |   4 +-
 hw/i2c/smbus.c                   |  13 +-
 hw/input/lm832x.c                |   4 +-
 hw/misc/tmp105.c                 |   3 +-
 hw/ssi/imx_spi.c                 |  11 +-
 hw/timer/ds1338.c                |   4 +-
 hw/timer/twl92230.c              |   4 +-
 MAINTAINERS                      |   2 -
 23 files changed, 572 insertions(+), 535 deletions(-)
 delete mode 100644 include/hw/arm/virt-acpi-build.h
