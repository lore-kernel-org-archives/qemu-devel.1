Received: from eggs.gnu.org ([2001:4830:134:3::10]:42747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cEJow-00038R-HQ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cEJov-00072Q-Mp
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:46:26 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Dec 2016 17:46:16 +0000
Message-Id: <1481046379-32632-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] GICv3 bugfixes (preliminary for virt)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

This patchset has a couple of fixes for bugs in the GICv3
emulation. I only noticed these in the course of adding the
virtualizations support, but they're bugs in the existing
non-virtualized code.

Patch 1 is strictly speaking not a GIC patch, but it's
an improvement to the debug logging that I found helpful
while trying to track down the bugs fixed in patches
2 and 3...

(I do now have the virtualization support to a point
where it will boot a nested Linux guest. Still a bunch
of loose ends to clean up but I hope to get that patchset
out to the list before the holidays...)

Peter Maydell (3):
  target-arm: Log AArch64 exception returns
  hw/intc/arm_gicv3: Remove incorrect usage of fieldoffset
  hw/intc/arm_gicv3: Don't signal Pending+Active interrupts to CPU

 hw/intc/arm_gicv3.c       |  5 +++++
 hw/intc/arm_gicv3_cpuif.c | 13 ++++++-------
 target-arm/op_helper.c    |  9 +++++++++
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.7.4
