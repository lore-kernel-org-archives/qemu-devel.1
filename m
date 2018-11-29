Received: from eggs.gnu.org ([2001:4830:134:3::10]:37046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gSPJI-0006pv-Oq
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gSPJD-0007Ez-N9
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:04 -0500
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 29 Nov 2018 17:36:51 +0100
Message-Id: <20181129163655.20370-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/4] hw/arm: versal: Correct number of IRQs
 in GIC setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, muhammad_bilal@mentor.com, frederic.konrad@adacore.com, alistair@alistair23.me, luc.michel@greensocs.com, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The Versal GIC has 192 IRQs not 256 as we previously had setup.
This series fixes the setup and moves the virtio-mmio nodes
to use other reserved interrupts.

Since we don't have 32 reserved lines, we also reduce the number of
virtio-mmio regions to 8 (we do have some more lines free but let's
leave some for future use).

Cheers,
Edgar

Edgar E. Iglesias (4):
  hw/arm: versal: Remove bogus virtio-mmio creation
  hw/arm: versal: Reduce number of virtio-mmio instances
  hw/arm: versal: Use IRQs 111 - 118 for virtio-mmio
  hw/arm: versal: Correct the nr of IRQs to 192

 hw/arm/xlnx-versal-virt.c    | 7 +++----
 include/hw/arm/xlnx-versal.h | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.17.1
