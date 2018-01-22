Received: from eggs.gnu.org ([2001:4830:134:3::10]:42532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edaFu-0002kZ-Dg
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edaFp-0007Dr-U1
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1edaFp-0007DY-L9
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:09 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 22 Jan 2018 12:26:57 +0100
Message-Id: <1516620426-18530-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] CPU hotplug test,
 __FUNCTION__ and some fprintf patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>

The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc7=
8f:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-01-19 16:35:25 +0000)

are available in the git repository at:

  https://github.com/huth/qemu.git tags/pull-request-2018-01-22

for you to fetch changes up to 1081ed2c4b71b5fe8bd31f6de8cdaa630c8acfd3:

  hw/isa: Replace fprintf(stderr, "*\n" with error_report() (2018-01-22 0=
9:51:00 +0100)

----------------------------------------------------------------
Pull request for various patches that have been reviewed and
laying on the mailing list for a while, but where apparently
no maintainer currently feels responsible for picking up.
----------------------------------------------------------------
Alistair Francis (5):
      Replace all occurances of __FUNCTION__ with __func__
      Fixes after renaming __FUNCTION__ to __func__
      hw/bt: Replace fprintf(stderr, "*\n" with error_report()
      hw/ipmi: Replace fprintf(stderr, "*\n" with error_report()
      hw/isa: Replace fprintf(stderr, "*\n" with error_report()

Thomas Huth (4):
      tests: Rename pc-cpu-test.c to cpu-plug-test.c
      tests/cpu-plug-test: Check the CPU hot-plugging with device_add, to=
o
      tests/cpu-plug-test: Check CPU hot-plugging on ppc64, too
      tests/cpu-plug-test: Test CPU hot-plugging on s390x

 hw/arm/nseries.c           |   2 +-
 hw/arm/omap1.c             |  46 ++++----
 hw/arm/omap2.c             |  12 +-
 hw/arm/palm.c              |  14 +--
 hw/arm/pxa2xx.c            |  46 ++++----
 hw/arm/pxa2xx_gpio.c       |   6 +-
 hw/arm/pxa2xx_pic.c        |   4 +-
 hw/arm/tosa.c              |  10 +-
 hw/audio/hda-codec.c       |  10 +-
 hw/audio/intel-hda.c       |  28 ++---
 hw/audio/wm8750.c          |   4 +-
 hw/block/nand.c            |   4 +-
 hw/block/onenand.c         |   8 +-
 hw/bt/core.c               |  15 ++-
 hw/bt/hci-csr.c            |  21 ++--
 hw/bt/hci.c                |  46 ++++----
 hw/bt/hid.c                |   4 +-
 hw/bt/l2cap.c              |  49 +++++----
 hw/bt/sdp.c                |  11 +-
 hw/display/blizzard.c      |  18 +--
 hw/display/omap_dss.c      |   6 +-
 hw/display/pxa2xx_lcd.c    |  14 +--
 hw/display/qxl-render.c    |   6 +-
 hw/display/qxl.h           |   2 +-
 hw/display/tc6393xb.c      |   2 +-
 hw/display/xenfb.c         |   2 +-
 hw/dma/omap_dma.c          |  26 ++---
 hw/dma/pxa2xx_dma.c        |  14 +--
 hw/gpio/max7310.c          |   8 +-
 hw/gpio/omap_gpio.c        |   2 +-
 hw/i2c/omap_i2c.c          |   6 +-
 hw/ide/ahci.c              |   2 +-
 hw/ide/microdrive.c        |   4 +-
 hw/input/lm832x.c          |   6 +-
 hw/input/pxa2xx_keypad.c   |   6 +-
 hw/input/tsc2005.c         |   8 +-
 hw/input/tsc210x.c         |   4 +-
 hw/intc/omap_intc.c        |   2 +-
 hw/ipmi/ipmi_bmc_extern.c  |   5 +-
 hw/isa/isa-bus.c           |   7 +-
 hw/isa/vt82c686.c          |   2 +-
 hw/mips/gt64xxx_pci.c      |   2 +-
 hw/misc/cbus.c             |  12 +-
 hw/misc/omap_clk.c         |   4 +-
 hw/misc/omap_gpmc.c        |   6 +-
 hw/misc/omap_l4.c          |   4 +-
 hw/misc/omap_sdrc.c        |   2 +-
 hw/misc/omap_tap.c         |   6 +-
 hw/misc/tmp105.c           |   2 +-
 hw/pci-host/bonito.c       |   2 +-
 hw/ssi/omap_spi.c          |   6 +-
 hw/timer/omap_gptimer.c    |   6 +-
 hw/timer/twl92230.c        |   6 +-
 hw/usb/desc.c              |   2 +-
 hw/usb/dev-bluetooth.c     |   4 +-
 hw/usb/hcd-musb.c          |   4 +-
 hw/usb/tusb6010.c          |  14 +--
 hw/xenpv/xen_domainbuild.c |  16 +--
 hw/xenpv/xen_machine_pv.c  |   2 +-
 include/hw/arm/omap.h      |  10 +-
 include/hw/arm/sharpsl.h   |   2 +-
 memory_mapping.c           |   2 +-
 migration/block.c          |   4 +-
 tests/Makefile.include     |   6 +-
 tests/cpu-plug-test.c      | 267 +++++++++++++++++++++++++++++++++++++++=
++++++
 tests/pc-cpu-test.c        | 135 -----------------------
 ui/cursor.c                |   6 +-
 ui/spice-display.c         |   4 +-
 68 files changed, 580 insertions(+), 448 deletions(-)
 create mode 100644 tests/cpu-plug-test.c
 delete mode 100644 tests/pc-cpu-test.c

Alistair Francis (5):
  Replace all occurances of __FUNCTION__ with __func__
  Fixes after renaming __FUNCTION__ to __func__
  hw/bt: Replace fprintf(stderr, "*\n" with error_report()
  hw/ipmi: Replace fprintf(stderr, "*\n" with error_report()
  hw/isa: Replace fprintf(stderr, "*\n" with error_report()

Thomas Huth (4):
  tests: Rename pc-cpu-test.c to cpu-plug-test.c
  tests/cpu-plug-test: Check the CPU hot-plugging with device_add, too
  tests/cpu-plug-test: Check CPU hot-plugging on ppc64, too
  tests/cpu-plug-test: Test CPU hot-plugging on s390x

 hw/arm/nseries.c           |   2 +-
 hw/arm/omap1.c             |  46 ++++----
 hw/arm/omap2.c             |  12 +-
 hw/arm/palm.c              |  14 +--
 hw/arm/pxa2xx.c            |  46 ++++----
 hw/arm/pxa2xx_gpio.c       |   6 +-
 hw/arm/pxa2xx_pic.c        |   4 +-
 hw/arm/tosa.c              |  10 +-
 hw/audio/hda-codec.c       |  10 +-
 hw/audio/intel-hda.c       |  28 ++---
 hw/audio/wm8750.c          |   4 +-
 hw/block/nand.c            |   4 +-
 hw/block/onenand.c         |   8 +-
 hw/bt/core.c               |  15 ++-
 hw/bt/hci-csr.c            |  21 ++--
 hw/bt/hci.c                |  46 ++++----
 hw/bt/hid.c                |   4 +-
 hw/bt/l2cap.c              |  49 +++++----
 hw/bt/sdp.c                |  11 +-
 hw/display/blizzard.c      |  18 +--
 hw/display/omap_dss.c      |   6 +-
 hw/display/pxa2xx_lcd.c    |  14 +--
 hw/display/qxl-render.c    |   6 +-
 hw/display/qxl.h           |   2 +-
 hw/display/tc6393xb.c      |   2 +-
 hw/display/xenfb.c         |   2 +-
 hw/dma/omap_dma.c          |  26 ++---
 hw/dma/pxa2xx_dma.c        |  14 +--
 hw/gpio/max7310.c          |   8 +-
 hw/gpio/omap_gpio.c        |   2 +-
 hw/i2c/omap_i2c.c          |   6 +-
 hw/ide/ahci.c              |   2 +-
 hw/ide/microdrive.c        |   4 +-
 hw/input/lm832x.c          |   6 +-
 hw/input/pxa2xx_keypad.c   |   6 +-
 hw/input/tsc2005.c         |   8 +-
 hw/input/tsc210x.c         |   4 +-
 hw/intc/omap_intc.c        |   2 +-
 hw/ipmi/ipmi_bmc_extern.c  |   5 +-
 hw/isa/isa-bus.c           |   7 +-
 hw/isa/vt82c686.c          |   2 +-
 hw/mips/gt64xxx_pci.c      |   2 +-
 hw/misc/cbus.c             |  12 +-
 hw/misc/omap_clk.c         |   4 +-
 hw/misc/omap_gpmc.c        |   6 +-
 hw/misc/omap_l4.c          |   4 +-
 hw/misc/omap_sdrc.c        |   2 +-
 hw/misc/omap_tap.c         |   6 +-
 hw/misc/tmp105.c           |   2 +-
 hw/pci-host/bonito.c       |   2 +-
 hw/ssi/omap_spi.c          |   6 +-
 hw/timer/omap_gptimer.c    |   6 +-
 hw/timer/twl92230.c        |   6 +-
 hw/usb/desc.c              |   2 +-
 hw/usb/dev-bluetooth.c     |   4 +-
 hw/usb/hcd-musb.c          |   4 +-
 hw/usb/tusb6010.c          |  14 +--
 hw/xenpv/xen_domainbuild.c |  16 +--
 hw/xenpv/xen_machine_pv.c  |   2 +-
 include/hw/arm/omap.h      |  10 +-
 include/hw/arm/sharpsl.h   |   2 +-
 memory_mapping.c           |   2 +-
 migration/block.c          |   4 +-
 tests/Makefile.include     |   6 +-
 tests/cpu-plug-test.c      | 267 +++++++++++++++++++++++++++++++++++++++=
++++++
 tests/pc-cpu-test.c        | 135 -----------------------
 ui/cursor.c                |   6 +-
 ui/spice-display.c         |   4 +-
 68 files changed, 580 insertions(+), 448 deletions(-)
 create mode 100644 tests/cpu-plug-test.c
 delete mode 100644 tests/pc-cpu-test.c

--=20
1.8.3.1
