Received: from eggs.gnu.org ([2001:4830:134:3::10]:34026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvh-0000Pb-GW
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvg-0001X0-Io
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 10:38:18 +0800
Message-Id: <20170717023824.18796-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/6] arm: Make use of DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

This is the arm part that was left out from:

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04006.html

Make use of the new DEFINE_PROP_LINK, in favor of open coded the
object_property_add_link. The advantage of it is the property now get reflected
in the info qtree output, for a bit more introspectability.

Fam Zheng (6):
  armv7m: Convert bitband.source-mamory to DEFINE_PROP_LINK
  armv7m: Convert armv7m.memory to DEFINE_PROP_LINK
  gicv3: Convert to DEFINE_PROP_LINK
  xlnx_zynqmp: Convert to DEFINE_PROP_LINK
  xilinx_axienet: Convert to DEFINE_PROP_LINK
  xilinx_axidma: Convert to DEFINE_PROP_LINK

 hw/arm/armv7m.c             | 16 ++++------------
 hw/arm/xlnx-zynqmp.c        |  7 ++-----
 hw/dma/xilinx_axidma.c      | 16 ++++------------
 hw/intc/arm_gicv3_its_kvm.c | 19 +++++++------------
 hw/net/xilinx_axienet.c     | 16 ++++------------
 5 files changed, 21 insertions(+), 53 deletions(-)

-- 
2.9.4
