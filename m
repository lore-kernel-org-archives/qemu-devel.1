Received: from eggs.gnu.org ([209.51.188.92]:46737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFm-0000ZH-5w
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFV-0002IX-Sk
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:53 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:33366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gzQFV-0002BE-Jz
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:37 -0500
Received: by mail-oi1-x230.google.com with SMTP id z14so17318413oid.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:17:23 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 28 Feb 2019 12:16:59 -0600
Message-Id: <20190228181710.2477-9-minyard@acm.org>
In-Reply-To: <20190228181710.2477-1-minyard@acm.org>
References: <20190228181710.2477-1-minyard@acm.org>
Subject: [Qemu-devel] [PULL 08/19] i2c:smbus_eeprom: Get rid of the quick
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, minyard@acm.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

It's not necessary, it won't be called if it's NULL.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 760594b3f1..2f90287b69 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -38,13 +38,6 @@ typedef struct SMBusEEPROMDevice {
     uint8_t offset;
 } SMBusEEPROMDevice;
 
-static void eeprom_quick_cmd(SMBusDevice *dev, uint8_t read)
-{
-#ifdef DEBUG
-    printf("eeprom_quick_cmd: addr=0x%02x read=%d\n", dev->i2c.address, read);
-#endif
-}
-
 static uint8_t eeprom_receive_byte(SMBusDevice *dev)
 {
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
@@ -97,7 +90,6 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(klass);
 
     dc->realize = smbus_eeprom_realize;
-    sc->quick_cmd = eeprom_quick_cmd;
     sc->receive_byte = eeprom_receive_byte;
     sc->write_data = eeprom_write_data;
     dc->props = smbus_eeprom_properties;
-- 
2.17.1
