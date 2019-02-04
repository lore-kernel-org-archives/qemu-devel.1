Received: from eggs.gnu.org ([209.51.188.92]:49784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnVl-0000Yb-0m
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnVi-0000DG-Qj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:18:44 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 00:18:04 +0100
Message-Id: <20190204231815.29661-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/11] hw: Remove "hw/devices.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Beniamino Galvani <b.galvani@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

As his first comment describes itself, the "hw/devices.h" contains
declarations for "Devices that have nowhere better to go."
This series remove it, creating new headers for devices covered there.
MAINTAINERS is updated.
I also included 2 cleanups while working on this, in "qemu/typedefs.h"
and "hw/net/ne2000-isa.h" header guard.

v2:
- added R-b, T-b tags
- addressed many review comments from Thomas

v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00611.html

Phil.

Philippe Mathieu-Daud=C3=A9 (11):
  hw/arm/aspeed: Use TYPE_TMP105/TYPE_PCA9552 instead of hardcoded
    string
  hw: Remove unused 'hw/devices.h' include
  hw/devices: Move TC6393XB declarations into a new header
  hw/devices: Move Blizzard declarations into a new header
  hw/devices: Move CBus declarations into a new header
  hw/devices: Move Gamepad declarations into a new header
  hw/devices: Move TI touchscreen declarations into a new header
  hw/devices: Move LAN9118 declarations into a new header
  hw/net/ne2000-isa: Add guards to the header
  hw/net/lan9118: Export TYPE_LAN9118 and use it instead of hardcoded
    string
  hw/devices: Move SMSC 91C111 declaration into a new header

 MAINTAINERS                              |  7 +++
 hw/alpha/typhoon.c                       |  1 -
 hw/arm/allwinner-a10.c                   |  1 -
 hw/arm/aspeed.c                          | 13 +++--
 hw/arm/collie.c                          |  1 -
 hw/arm/cubieboard.c                      |  1 -
 hw/arm/exynos4_boards.c                  |  3 +-
 hw/arm/gumstix.c                         |  2 +-
 hw/arm/highbank.c                        |  1 -
 hw/arm/integratorcp.c                    |  2 +-
 hw/arm/kzm.c                             |  2 +-
 hw/arm/mainstone.c                       |  2 +-
 hw/arm/mps2-tz.c                         |  4 +-
 hw/arm/mps2.c                            |  2 +-
 hw/arm/musicpal.c                        |  1 -
 hw/arm/nrf51_soc.c                       |  1 -
 hw/arm/nseries.c                         |  4 +-
 hw/arm/palm.c                            |  2 +-
 hw/arm/realview.c                        |  3 +-
 hw/arm/spitz.c                           |  1 -
 hw/arm/stellaris.c                       |  2 +-
 hw/arm/tosa.c                            |  2 +-
 hw/arm/versatilepb.c                     |  2 +-
 hw/arm/vexpress.c                        |  2 +-
 hw/arm/virt.c                            |  1 -
 hw/arm/z2.c                              |  1 -
 hw/display/blizzard.c                    |  2 +-
 hw/display/sm501.c                       |  1 -
 hw/display/tc6393xb.c                    |  2 +-
 hw/hppa/dino.c                           |  1 -
 hw/input/stellaris_input.c               |  2 +-
 hw/input/tsc2005.c                       |  2 +-
 hw/input/tsc210x.c                       |  4 +-
 hw/intc/allwinner-a10-pic.c              |  1 -
 hw/lm32/lm32_boards.c                    |  1 -
 hw/lm32/milkymist.c                      |  1 -
 hw/microblaze/petalogix_ml605_mmu.c      |  1 -
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 -
 hw/misc/cbus.c                           |  2 +-
 hw/net/dp8393x.c                         |  1 -
 hw/net/lan9118.c                         |  3 +-
 hw/net/smc91c111.c                       |  2 +-
 hw/ppc/virtex_ml507.c                    |  1 -
 hw/sh4/r2d.c                             |  1 -
 hw/tricore/tricore_testboard.c           |  1 -
 hw/usb/tusb6010.c                        |  1 -
 include/hw/arm/omap.h                    |  6 +--
 include/hw/devices.h                     | 63 ------------------------
 include/hw/display/blizzard.h            | 22 +++++++++
 include/hw/display/tc6393xb.h            | 26 ++++++++++
 include/hw/input/gamepad.h               | 21 ++++++++
 include/hw/input/tsc2xxx.h               | 38 ++++++++++++++
 include/hw/misc/cbus.h                   | 32 ++++++++++++
 include/hw/net/lan9118.h                 | 21 ++++++++
 include/hw/net/ne2000-isa.h              |  6 +++
 include/hw/net/smc91c111.h               | 19 +++++++
 include/qemu/typedefs.h                  |  1 -
 57 files changed, 230 insertions(+), 120 deletions(-)
 delete mode 100644 include/hw/devices.h
 create mode 100644 include/hw/display/blizzard.h
 create mode 100644 include/hw/display/tc6393xb.h
 create mode 100644 include/hw/input/gamepad.h
 create mode 100644 include/hw/input/tsc2xxx.h
 create mode 100644 include/hw/misc/cbus.h
 create mode 100644 include/hw/net/lan9118.h
 create mode 100644 include/hw/net/smc91c111.h

--=20
2.20.1
