Received: from eggs.gnu.org ([2001:4830:134:3::10]:41892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZar-0001gq-Ae
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZal-0007Mr-Qx
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:09 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 12:42:40 -0300
Message-Id: <20180108154303.6522-9-f4bug@amsat.org>
In-Reply-To: <20180108154303.6522-1-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 08/31] hw/sd: clean/reorder the Makefile
 adding few comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/Makefile.objs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index c2b7664264..0fe2501017 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -1,9 +1,14 @@
+# SD/MMC subsystem core
+common-obj-$(CONFIG_SD) += core.o
+
+# SD/MMC host adapters
 common-obj-$(CONFIG_PL181) += pl181.o
 common-obj-$(CONFIG_SSI_SD) += ssi-sd.o
-common-obj-$(CONFIG_SD) += sd.o core.o
 common-obj-$(CONFIG_SDHCI) += sdhci.o
-
 obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
 obj-$(CONFIG_OMAP) += omap_mmc.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
 obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
+
+# emulated SD/MMC devices
+common-obj-$(CONFIG_SD) += sd.o
-- 
2.15.1
