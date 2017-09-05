Received: from eggs.gnu.org ([2001:4830:134:3::10]:42916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpDeL-0006eO-Gb
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpDeC-0007w8-6Y
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:12:17 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 21:11:43 +0800
Message-Id: <20170905131149.10669-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 0/6] arm: Make use of DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

v6: Rebase and resend v5: Add Philippe's rev-bys and fix one typo in bitb=
and
    patch.

This is the arm part that was left out from:

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04006.html

Make use of the new DEFINE_PROP_LINK, in favor of open coded the
object_property_add_link. The advantage of it is the property now get ref=
lected
in the info qtree output, for a bit more introspectability.

Fam Zheng (6):
  armv7m: Convert bitband.source-memory to DEFINE_PROP_LINK
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

--=20
2.13.5
