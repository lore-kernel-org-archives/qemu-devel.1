Received: from eggs.gnu.org ([209.51.188.92]:46769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFo-0000aF-B5
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFc-0002Lu-Ns
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:56 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:41540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gzQFY-0002DG-BD
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:40 -0500
Received: by mail-oi1-x231.google.com with SMTP id e7so17274032oia.8
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:17:28 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 28 Feb 2019 12:17:10 -0600
Message-Id: <20190228181710.2477-20-minyard@acm.org>
In-Reply-To: <20190228181710.2477-1-minyard@acm.org>
References: <20190228181710.2477-1-minyard@acm.org>
Subject: [Qemu-devel] [PULL 19/19] i2c: Verify that the count passed in to
 smbus_eeprom_init() is valid
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

Keep someone from passing in a bogus number

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 0ba5763fc2..37167e7244 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -180,6 +180,8 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
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
