Received: from eggs.gnu.org ([2001:4830:134:3::10]:53299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIpE-0005en-6g
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIpB-0003Jx-5z
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:00:40 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 23:00:17 -0300
Message-Id: <20171214020025.4004-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/8] SDHCI: add a qtest and fix few issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

This series adds a qtest for the SD Host Controller Interface.

To keep it simple, for each device using a SDHCI IP we ask the the capabilities
it supports, and verify with the public datashits availables.

So far the QEMU devices only implement the v2 and v3 Specs.

This exposes few inconsistencies, we fix them.

Regards,

Phil.

Based-on: 20171213232025.24503-27-f4bug@amsat.org
          (SDCard housekeeping)

Philippe Mathieu-Daudé (8):
  sdhci: add a "sd-spec-version" property
  sdhci: some ARM boards do support SD_HOST_SPECv3_VERS
  sdhci: add qtest to check the SD Spec version
  sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only
  sdhci: add check_capab_readonly() qtest
  sdhci: add a check_capab_baseclock() qtest
  sdhci: add a check_capab_sdma() qtest
  sdhci: add a check_capab_v3() qtest

 include/hw/sd/sdhci.h        |  14 +++-
 hw/sd/sdhci-internal.h       |   4 +-
 hw/arm/bcm2835_peripherals.c |   7 ++
 hw/arm/fsl-imx6.c            |   6 ++
 hw/arm/xilinx_zynq.c         |   2 +
 hw/sd/sdhci.c                |  30 +++++++--
 tests/sdhci-test.c           | 152 +++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include       |   1 +
 8 files changed, 206 insertions(+), 10 deletions(-)
 create mode 100644 tests/sdhci-test.c

-- 
2.15.1
