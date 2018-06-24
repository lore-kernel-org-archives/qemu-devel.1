Received: from eggs.gnu.org ([2001:4830:134:3::10]:42146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwII-0003jk-L8
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwID-0003gZ-NM
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:06:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 24 Jun 2018 01:05:53 -0300
Message-Id: <20180624040609.17572-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/16] hw/arm: use qemu_log_mask instead of
 fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

Hi,

This series is another collection of trivial patches from
different stagnating branches, OMAP and Stellaris. Time to
share before loosing them.

Regards,

Phil.

Patches missing review: 1, 9, 11, 12, 15, 16

Since v2: addressed Thomas Huth comments
- fixed incorrect "<< 2" using "* 8"
- fixed fmt string on 32-bit arch (Thomas)
- keep <tab> comments aligned but use spaces (4) to satisfy checkpatch
- replaced OMAP_BAD_REG() macro
- fixed a typo
- remove a cast using HWADDR_PRIx
- added Thomas R-b

Since v1:
- added Alistair R-b
- addressed Thomas Huth comments
- added one more change in smc91c111
- fixed gptm_write()

v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06324.html
v2: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06645.html

[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/16:[0002] [FC] 'hw/input/pckbd: Use qemu_log_mask(GUEST_ERROR) instead of fprintf'
002/16:[----] [--] 'hw/input/tsc2005: Use qemu_log_mask(GUEST_ERROR) instead of fprintf'
003/16:[----] [--] 'hw/dma/omap_dma: Use qemu_log_mask(UNIMP) instead of printf'
004/16:[----] [--] 'hw/dma/omap_dma: Use qemu_log_mask(GUEST_ERROR) instead of fprintf'
005/16:[----] [--] 'hw/ssi/omap_spi: Use qemu_log_mask(GUEST_ERROR) instead of fprintf'
006/16:[----] [--] 'hw/sd/omap_mmc: Use qemu_log_mask(UNIMP) instead of printf'
007/16:[0004] [FC] 'hw/i2c/omap_i2c: Use qemu_log_mask(UNIMP) instead of fprintf'
008/16:[----] [--] 'hw/arm/omap1: Use qemu_log_mask(GUEST_ERROR) instead of fprintf'
009/16:[0011] [FC] 'hw/arm/omap: Use qemu_log_mask(GUEST_ERROR) instead of fprintf'
010/16:[----] [--] 'hw/arm/stellaris: Use qemu_log_mask(UNIMP) instead of fprintf'
011/16:[down] 'hw/net/stellaris_enet: Fix a typo'
012/16:[0008] [FC] 'hw/net/stellaris_enet: Use qemu_log_mask(GUEST_ERROR) instead of hw_error'
013/16:[----] [--] 'hw/net/smc91c111: Use qemu_log_mask(GUEST_ERROR) instead of hw_error'
014/16:[----] [--] 'hw/net/smc91c111: Use qemu_log_mask(UNIMP) instead of fprintf'
015/16:[----] [--] 'hw/arm/stellaris: Fix gptm_write() error message'
016/16:[down] 'hw/arm/stellaris: Use HWADDR_PRIx to display register address'

Philippe Mathieu-Daudé (16):
  hw/input/pckbd: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
  hw/input/tsc2005: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
  hw/dma/omap_dma: Use qemu_log_mask(UNIMP) instead of printf
  hw/dma/omap_dma: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
  hw/ssi/omap_spi: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
  hw/sd/omap_mmc: Use qemu_log_mask(UNIMP) instead of printf
  hw/i2c/omap_i2c: Use qemu_log_mask(UNIMP) instead of fprintf
  hw/arm/omap1: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
  hw/arm/omap: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
  hw/arm/stellaris: Use qemu_log_mask(UNIMP) instead of fprintf
  hw/net/stellaris_enet: Fix a typo
  hw/net/stellaris_enet: Use qemu_log_mask(GUEST_ERROR) instead of hw_error
  hw/net/smc91c111: Use qemu_log_mask(GUEST_ERROR) instead of hw_error
  hw/net/smc91c111: Use qemu_log_mask(UNIMP) instead of fprintf
  hw/arm/stellaris: Fix gptm_write() error message
  hw/arm/stellaris: Use HWADDR_PRIx to display register address

 include/hw/arm/omap.h   | 30 ++++--------------
 hw/arm/omap1.c          | 18 +++++++----
 hw/arm/stellaris.c      |  8 +++--
 hw/dma/omap_dma.c       | 70 ++++++++++++++++++++++++++---------------
 hw/i2c/omap_i2c.c       | 20 +++++++-----
 hw/input/pckbd.c        |  4 ++-
 hw/input/tsc2005.c      | 13 +++++---
 hw/net/smc91c111.c      | 21 +++++++++----
 hw/net/stellaris_enet.c | 11 +++++--
 hw/sd/omap_mmc.c        | 13 +++++---
 hw/ssi/omap_spi.c       | 15 ++++++---
 11 files changed, 132 insertions(+), 91 deletions(-)

-- 
2.18.0
