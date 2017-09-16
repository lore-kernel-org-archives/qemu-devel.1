Received: from eggs.gnu.org ([2001:4830:134:3::10]:52528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEB-0008DI-UX
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEB-00078F-0B
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:00 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 17:46:12 +0100
Message-Id: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/6] convert some omap/palm devices from using
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset converts a handful of old devices from the old_mmio
fields in MemoryRegionOps. We don't have very many devices still
using old_mmio, so it would be nice to get rid of the remainder
and drop the field entirely at some point.

(You could argue that really we should mark some of these old
boards as obsolete and eventually delete them. I don't actually
have a test image for the palm stuff at all...)

thanks
-- PMM

Peter Maydell (6):
  hw/arm/palm.c: Don't use old_mmio for static_ops
  hw/gpio/omap_gpio.c: Don't use old_mmio
  hw/timer/omap_synctimer.c: Don't use old_mmio
  hw/timer/omap_gptimer: Don't use old_mmio
  hw/i2c/omap_i2c.c: Don't use old_mmio
  hw/arm/omap2.c: Don't use old_mmio

 hw/arm/omap2.c            | 49 +++++++++++++++++++++++++++++++++++------------
 hw/arm/palm.c             | 30 ++++++++++-------------------
 hw/gpio/omap_gpio.c       | 26 ++++++++++++-------------
 hw/i2c/omap_i2c.c         | 44 ++++++++++++++++++++++++++++++------------
 hw/timer/omap_gptimer.c   | 49 +++++++++++++++++++++++++++++++++++------------
 hw/timer/omap_synctimer.c | 35 +++++++++++++++++++--------------
 6 files changed, 149 insertions(+), 84 deletions(-)

-- 
2.7.4
