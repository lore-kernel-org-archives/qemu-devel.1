Received: from eggs.gnu.org ([2001:4830:134:3::10]:59417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjvA-0006Ph-8J
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjv5-0002uB-FB
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:57:56 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 17:56:18 -0300
Message-Id: <20180111205626.23291-14-f4bug@amsat.org>
In-Reply-To: <20180111205626.23291-1-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 13/21] hw/arm/bcm2835_peripherals: change
 maximum block size to 1kB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org

following the datasheet.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 79d680cb1b..72d4dd73b5 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -272,6 +272,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     object_property_set_uint(OBJECT(&s->sdhci), 52, "max-frequency", &err);
     object_property_set_bool(OBJECT(&s->sdhci), false, "adma1", &err);
     object_property_set_bool(OBJECT(&s->sdhci), true, "1v8", &err);
+    object_property_set_uint(OBJECT(&s->sdhci), 1024, "max-block-length", &err);
     object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-quirk",
                              &err);
     if (err) {
-- 
2.15.1
