Received: from eggs.gnu.org ([2001:4830:134:3::10]:36581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cfV3R-0000Bh-Nn
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cfV3O-0008Pl-3T
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:13:45 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:63609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1cfV3N-0008P1-SY
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:13:42 -0500
Message-Id: <cover.1487522123.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 19 Feb 2017 17:35:23 +0100
Subject: [Qemu-devel] [PATCH 00/10] Improvements for sm501 display
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

This series improves the sm501 display controller emulation fixing
endianness problems that caused mixed up colors in LE hosts, fix hardware
cursor and adding panel layer support and some missing registers. The
first few patches update the code style and QOMify the device before
changes are made to it in subsequent patches.

Including qemu-trivial list as well, both because some of the patches
are trivial and also I'm not sure how actively maintained this part is
so that also may need attention from the trivial list to get this merged.

The changes were tested with sh4 image at
https://people.debian.org/~aurel32/qemu/sh4/
which accepts video= kernel parameter to excercise different screen modes.

BALATON Zoltan (10):
  sm501: Fixed code style and a few typos in comments
  sm501: Use defines instead of constants where available
  sm501: QOMify
  sm501: Add emulation of chip connected via PCI
  sm501: Add missing arbitration control register
  sm501: Fix device endianness
  sm501: Fix hardware cursor
  sm501: Add support for panel layer
  sm501: Add some more missing registers
  ppc: Add SM501 device in config for ppc and ppcemb targets

 default-configs/ppc-softmmu.mak    |    1 +
 default-configs/ppcemb-softmmu.mak |    1 +
 hw/display/sm501.c                 | 1546 ++++++++++++++++++++----------------
 hw/display/sm501_template.h        |   92 +--
 hw/sh4/r2d.c                       |   11 +-
 include/hw/devices.h               |    5 -
 6 files changed, 920 insertions(+), 736 deletions(-)

-- 
2.7.4
