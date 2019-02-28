Received: from eggs.gnu.org ([209.51.188.92]:46765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFo-0000aD-1a
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFc-0002MR-TB
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:56 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:43698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gzQFY-0002Bg-Bx
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:42 -0500
Received: by mail-ot1-x32b.google.com with SMTP id n71so18528058ota.10
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:17:24 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 28 Feb 2019 12:17:00 -0600
Message-Id: <20190228181710.2477-10-minyard@acm.org>
In-Reply-To: <20190228181710.2477-1-minyard@acm.org>
References: <20190228181710.2477-1-minyard@acm.org>
Subject: [Qemu-devel] [PULL 09/19] i2c:smbus: Make white space in switch
 statements consistent
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

It had spaces between cases in some places and not others.  Add a space
for every one.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c | 1 +
 hw/i2c/smbus_slave.c  | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 2f90287b69..2816e35bcc 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -43,6 +43,7 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
     uint8_t *data = eeprom->data;
     uint8_t val = data[eeprom->offset++];
+
 #ifdef DEBUG
     printf("eeprom_receive_byte: addr=0x%02x val=0x%02x\n",
            dev->i2c.address, val);
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 52a57423ee..5b3046f6a3 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -70,6 +70,7 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
             DPRINTF("Incoming data\n");
             dev->mode = SMBUS_WRITE_DATA;
             break;
+
         default:
             BADF("Unexpected send start condition in state %d\n", dev->mode);
             dev->mode = SMBUS_CONFUSED;
@@ -83,6 +84,7 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
             DPRINTF("Read mode\n");
             dev->mode = SMBUS_READ_DATA;
             break;
+
         case SMBUS_WRITE_DATA:
             if (dev->data_len == 0) {
                 BADF("Read after write with no data\n");
@@ -93,6 +95,7 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
                 dev->mode = SMBUS_READ_DATA;
             }
             break;
+
         default:
             BADF("Unexpected recv start condition in state %d\n", dev->mode);
             dev->mode = SMBUS_CONFUSED;
@@ -129,9 +132,11 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
         case SMBUS_DONE:
             /* Nothing to do.  */
             break;
+
         case SMBUS_READ_DATA:
             dev->mode = SMBUS_DONE;
             break;
+
         default:
             BADF("Unexpected NACK in state %d\n", dev->mode);
             dev->mode = SMBUS_CONFUSED;
@@ -155,11 +160,13 @@ static uint8_t smbus_i2c_recv(I2CSlave *s)
         }
         DPRINTF("Read data %02x\n", ret);
         break;
+
     default:
         BADF("Unexpected read in state %d\n", dev->mode);
         dev->mode = SMBUS_CONFUSED;
         break;
     }
+
     return ret;
 }
 
@@ -176,10 +183,12 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
             dev->data_buf[dev->data_len++] = data;
         }
         break;
+
     default:
         BADF("Unexpected write in state %d\n", dev->mode);
         break;
     }
+
     return 0;
 }
 
-- 
2.17.1
