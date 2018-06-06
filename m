Received: from eggs.gnu.org ([2001:4830:134:3::10]:40216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQYwX-0008QY-Tc
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQYwU-0000Wd-3y
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:41 -0400
Message-Id: <79ec5d3a052aa8380f57a1f0778b0a0584192e49.1528291908.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1528291908.git.balaton@eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 06 Jun 2018 15:31:48 +0200
Subject: [Qemu-devel] [PATCH v2 6/8] sam460ex: Add RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

The Sam460ex has an M41T80 serial RTC chip on I2C bus 0 at address 0x68.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/sam460ex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index bdc53d2..dc730cc 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -457,6 +457,7 @@ static void sam460ex_init(MachineState *machine)
     object_property_set_bool(OBJECT(dev), true, "realized", NULL);
     smbus_eeprom_init(i2c[0]->bus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
+    i2c_create_slave(i2c[0]->bus, "m41t80", 0x68);
 
     dev = sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800, uic[0][3]);
     i2c[1] = PPC4xx_I2C(dev);
-- 
2.7.6
