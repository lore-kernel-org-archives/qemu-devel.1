Received: from eggs.gnu.org ([2001:4830:134:3::10]:37553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOkn8-0007SH-91
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOkn7-0000hm-Cn
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:12:30 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Jun 2018 15:12:17 +0100
Message-Id: <20180601141223.26630-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/6] More conversions away from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, qemu-block@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>

Half a dozen miscellaneous conversions away from old_mmio usage
in the MemoryRegionOps struct. This leaves us with only 10
remaining in the tree.

NB: mips parts tested only via 'make check'.

thanks
-- PMM

Peter Maydell (6):
  hw/sh/sh7750: Convert away from old_mmio
  hw/m68k/mcf5206: Convert away from old_mmio
  hw/block/pflash_cfi02: Convert away from old_mmio
  hw/watchdog/wdt_i6300esb: Convert away from old_mmio
  hw/input/pckbd: Convert away from old_mmio
  hw/char/parallel: Convert away from old_mmio

 hw/block/pflash_cfi02.c    | 97 +++++++-------------------------------
 hw/char/parallel.c         | 50 +++++---------------
 hw/input/pckbd.c           | 14 +++---
 hw/m68k/mcf5206.c          | 48 ++++++++++++++-----
 hw/sh4/sh7750.c            | 44 +++++++++++++----
 hw/watchdog/wdt_i6300esb.c | 48 ++++++++++++++-----
 6 files changed, 145 insertions(+), 156 deletions(-)

-- 
2.17.1
