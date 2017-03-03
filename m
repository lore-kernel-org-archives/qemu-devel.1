Received: from eggs.gnu.org ([2001:4830:134:3::10]:55656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjcMK-0006I9-8F
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjcMG-0001Cx-9T
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:50:16 -0500
Message-Id: <cover.1488504063.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 3 Mar 2017 02:21:03 +0100
Subject: [Qemu-devel] [PATCH v3 00/13] Improvements for SM501 display
 controller emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

Third version addressing points that came up in review of v2.

BALATON Zoltan (13):
  sm501: Fixed code style and a few typos in comments
  sm501: Use defined constants instead of literal values where available
  sm501: Add missing arbitration control register
  sm501: QOMify
  sm501: Get rid of base address in draw_hwc_line
  sm501: Add emulation of chip connected via PCI
  sm501: Fix device endianness
  sm501: Fix hardware cursor
  sm501: Misc clean ups
  sm501: Add support for panel layer
  sm501: Add some more missing registers
  sm501: Add vmstate descriptor
  ppc: Add SM501 device in config for ppc and ppcemb targets

 default-configs/ppc-softmmu.mak    |    1 +
 default-configs/ppcemb-softmmu.mak |    1 +
 hw/display/sm501.c                 | 1757 ++++++++++++++++++++++--------------
 hw/display/sm501_template.h        |   94 +-
 hw/sh4/r2d.c                       |   11 +-
 include/hw/devices.h               |    5 -
 include/hw/pci/pci_ids.h           |    3 +
 7 files changed, 1130 insertions(+), 742 deletions(-)

-- 
2.7.4
