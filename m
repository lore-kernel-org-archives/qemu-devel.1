Received: from eggs.gnu.org ([2001:4830:134:3::10]:42498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chmkY-0001Dn-C3
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 19:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chmkV-0005uh-7Z
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 19:31:42 -0500
Message-Id: <cover.1488068248.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 26 Feb 2017 01:17:28 +0100
Subject: [Qemu-devel] [PATCH v2 00/14] Improvements for SM501 display
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Second try, addressing review comments.

BALATON Zoltan (14):
  sm501: Fixed code style and a few typos in comments
  sm501: Use defines instead of constants where available
  sm501: QOMify
  sm501: Get rid of base address in draw_hwc_line
  sm501: Add emulation of chip connected via PCI
  sm501: Add missing arbitration control register
  sm501: Fix device endianness
  sm501: Fix hardware cursor
  sm501: Misc clean ups
  sm501: Add support for panel layer
  sm501: Add some more missing registers
  sm501: Implement reading 2D engine registers
  sm501: Add reset function and vmstate descriptor
  ppc: Add SM501 device in config for ppc and ppcemb targets

 default-configs/ppc-softmmu.mak    |    1 +
 default-configs/ppcemb-softmmu.mak |    1 +
 hw/display/sm501.c                 | 1718 ++++++++++++++++++++++--------------
 hw/display/sm501_template.h        |   94 +-
 hw/sh4/r2d.c                       |   11 +-
 include/hw/devices.h               |    5 -
 6 files changed, 1089 insertions(+), 741 deletions(-)

-- 
2.7.4
