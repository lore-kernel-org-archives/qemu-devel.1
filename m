Received: from eggs.gnu.org ([2001:4830:134:3::10]:51620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1J81-0005es-0O
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1J7y-000519-QP
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:56:37 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:30666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1d1J7y-00050G-KM
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:56:34 -0400
Message-Id: <cover.1492721026.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 20 Apr 2017 22:43:46 +0200
Subject: [Qemu-devel] [PATCH v5 00/13] Improvements for SM501 display
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

Addressing all last review comments so hopefully this can get merged
now that tree is thawed.

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
  ppc: Add SM501 device in ppc softmmu targets default configs

 default-configs/ppc-softmmu.mak    |    1 +
 default-configs/ppc64-softmmu.mak  |    1 +
 default-configs/ppcemb-softmmu.mak |    1 +
 hw/display/sm501.c                 | 1784 ++++++++++++++++++++++--------------
 hw/display/sm501_template.h        |   90 +-
 hw/sh4/r2d.c                       |   11 +-
 include/hw/devices.h               |    5 -
 include/hw/pci/pci_ids.h           |    3 +
 8 files changed, 1150 insertions(+), 746 deletions(-)

-- 
2.7.4
