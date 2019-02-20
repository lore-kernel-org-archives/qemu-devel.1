Received: from eggs.gnu.org ([209.51.188.92]:42366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTk2-0008N9-Db
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTjj-0007cZ-4o
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:53 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gwTjf-0006mH-T3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:37 -0500
Received: by mail-ot1-x343.google.com with SMTP id v20so8764131otk.7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:22:17 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Wed, 20 Feb 2019 07:59:56 -0600
Message-Id: <20190220135956.22589-20-minyard@acm.org>
In-Reply-To: <20190220135956.22589-1-minyard@acm.org>
References: <20190220135956.22589-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 19/19] i2c: Verify that the count passed in to
 smbus_eeprom_init() is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Keep someone from passing in a bogus number

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 44887b4a27..ee392f7cb1 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -178,6 +178,8 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
 {
     int i;
      /* XXX: make this persistent */
+
+    assert(nb_eeprom <= 8);
     uint8_t *eeprom_buf = g_malloc0(8 * SMBUS_EEPROM_SIZE);
     if (eeprom_spd_size > 0) {
         memcpy(eeprom_buf, eeprom_spd, eeprom_spd_size);
-- 
2.17.1
