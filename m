Received: from eggs.gnu.org ([209.51.188.92]:37045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEG-0003Db-Hw
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB7z-0005dh-Qz
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:36 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:38418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB7x-0005YU-Ih
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:22 -0500
Received: by mail-it1-x144.google.com with SMTP id z20so20674377itc.3
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:19 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:48 -0600
Message-Id: <20190128175458.27255-10-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v4 09/19] i2c:smbus: Make white space in switch
 statements consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

It had spaces between cases in some places and not others.  Add a space
for every one.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c | 1 +
 hw/i2c/smbus_slave.c  | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 4bc579e69e..62e634c745 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -41,6 +41,7 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
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
