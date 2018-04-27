Received: from eggs.gnu.org ([2001:4830:134:3::10]:59196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fC7I9-0004Ua-2B
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fC7I8-0007t5-9m
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:36:17 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 18:36:09 +0100
Message-Id: <20180427173611.10281-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] arm: convert a couple of devices away from
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

We've had an API transition running for years for MemoryRegionOps
away from the old_mmio function-per-width to the new-style single
function each for read and write. This patchset converts a couple
of devices used in Arm machines to the new style.

This leaves us with:
 * hw/char/parallel
 * hw/block/pflash_cfi02
 * hw/display/vga-isa-mm
 * hw/input/pckbd
 * hw/intc/apic
 * hw/m68k/mcf5206
 * hw/net/pcinet-pci
 * hw/pci-host/bonito
 * hw/ppc/ppc405_boards
 * hw/ppc/ppc405_uc
 * hw/ppc/prep
 * hw/sh4/sh7750
 * hw/timer/m48t59
 * hw/watchdog/wdt_i6300esb

for 17 uses in total.

The conversions are fairly simple, so it would be nice to get
this transition done for the next release -- then we can delete
the code in memory.c that has to consider old_mmio.

thanks
-- PMM

Peter Maydell (2):
  hw/usb/tusb6010: Convert away from old_mmio
  hw/net/smc91c111: Convert away from old_mmio

 hw/net/smc91c111.c | 54 +++++++++++++++++++++-------------------------
 hw/usb/tusb6010.c  | 40 ++++++++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 33 deletions(-)

-- 
2.17.0
