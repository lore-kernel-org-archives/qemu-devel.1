Received: from eggs.gnu.org ([2001:4830:134:3::10]:50424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlm-00031l-5L
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGll-0004EO-CR
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGll-00046X-5N
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlg-0003dy-DI
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:44:54 +0100
Message-Id: <20180608124517.29475-9-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/31] aspeed: add the pc9552 chips to the
 witherspoon machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

The pca9552 LED blinkers on the Witherspoon machine are used for leds
but also as GPIOs to control fans and GPUs.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180530064049.27976-8-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 5d0ed3391e0..bb9d33848d3 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -384,6 +384,8 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
     AspeedSoCState *soc = &bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
 
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca9552", 0x60);
+
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
 
@@ -396,6 +398,8 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
                           eeprom_buf);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "pca9552",
+                     0x60);
 }
 
 static void witherspoon_bmc_init(MachineState *machine)
-- 
2.17.1
