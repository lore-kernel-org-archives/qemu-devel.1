Received: from eggs.gnu.org ([2001:4830:134:3::10]:41228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fddjI-0004aA-EN
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fddjH-0008PR-PU
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:42:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 16:41:50 +0100
Message-Id: <20180712154152.32183-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 0/2] a couple of GICv2 bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Jan Kiszka <jan.kiszka@web.de>, Luc Michel <luc.michel@greensocs.com>

These patches fix bugs in our GICv2 implementation that we noticed
in the course of reviewing Luc's patchset to add virtualization
support to it.

Patch 1 is a missing bounds check, effectively. Luckily there
was a mask operation in place that means it's not actually
possible to do anything nasty as a result.

Patch 2 fixes GICD_ITARGETSR for non-11MPCore GICs, which is
necessary to run Jailhouse as a guest.

thanks
-- PMM

Peter Maydell (2):
  hw/intc/arm_gic: Check interrupt number in gic_deactivate_irq()
  hw/intc/arm_gic: Fix handling of GICD_ITARGETSR

 hw/intc/arm_gic.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

-- 
2.17.1
