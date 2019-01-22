Received: from eggs.gnu.org ([209.51.188.92]:53336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gm1CJ-0002fX-NQ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gm1CF-0001LB-RI
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:54:55 -0500
Message-Id: <cover.1548160772.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 22 Jan 2019 13:39:32 +0100
Subject: [Qemu-devel] [PATCH 0/3] via-ide clean ups and native mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>

Hello,

This implements native PCI ATA mode for via-ida device model which is
what most guests expect and want to use instead of the current legacy
compatibility mode which nothing seems to depend on. Also rename some
functions to via_ide to make this device truely independent from the
VIA 82C686B chip as it can be used independently as well.

This is on top of my previous CMD646 cleanup series.

Regards,
BALATON Zoltan

BALATON Zoltan (3):
  ide/via: Remove vt82c686b_init_ports() function
  ide/via: Rename functions to match device name
  ide/via: Implement and use native PCI IDE mode

 hw/ide/via.c            | 87 ++++++++++++++++++++++++++++++-------------------
 hw/mips/mips_fulong2e.c |  2 +-
 include/hw/ide.h        |  2 +-
 3 files changed, 55 insertions(+), 36 deletions(-)

-- 
2.13.7
