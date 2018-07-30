Received: from eggs.gnu.org ([2001:4830:134:3::10]:38630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fkFKo-0005Ux-21
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fkFKk-0000YR-Vc
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:04:06 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1fkFKk-0000Xc-PH
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:04:02 -0400
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Mon, 30 Jul 2018 23:03:43 +0200
Message-Id: <cover.1532984236.git.jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH v3 0/3] i.MX: Add the i.MX6UL SOC and a
 reference board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au, andrew.smirnov@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

This series adds the i.MX6UL SOC from NXP/Freescale and the reference
evaluation board.

This series was tested by booting linux 4.18 (built using imx_v6_v7_defconfig)
on the emulated board (with the appropriate device tree).

Jean-Christophe Dubois (3):
  i.MX6UL: Add i.MX6UL specific CCM device
  i.MX6UL: Add i.MX6UL SOC
  i.MX6UL: Add Freescale i.MX6 UltraLite 14x14 EVK Board

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Makefile.objs            |   1 +
 hw/arm/fsl-imx6ul.c             | 617 ++++++++++++++++++++++
 hw/arm/mcimx6ul-evk.c           |  85 +++
 hw/misc/Makefile.objs           |   1 +
 hw/misc/imx6ul_ccm.c            | 890 ++++++++++++++++++++++++++++++++
 hw/misc/trace-events            |   7 +
 include/hw/arm/fsl-imx6ul.h     | 339 ++++++++++++
 include/hw/misc/imx6ul_ccm.h    | 226 ++++++++
 9 files changed, 2167 insertions(+)
 create mode 100644 hw/arm/fsl-imx6ul.c
 create mode 100644 hw/arm/mcimx6ul-evk.c
 create mode 100644 hw/misc/imx6ul_ccm.c
 create mode 100644 include/hw/arm/fsl-imx6ul.h
 create mode 100644 include/hw/misc/imx6ul_ccm.h

-- 
2.17.1
