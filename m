Received: from eggs.gnu.org ([2001:4830:134:3::10]:45174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fkdH5-0005DS-7e
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 18:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fkdH1-0000pA-9j
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 18:37:51 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1fkdH1-0000oy-1y
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 18:37:47 -0400
Received: by mail-pf1-x441.google.com with SMTP id e13-v6so6785024pff.7
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 15:37:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 31 Jul 2018 15:37:41 -0700
Message-Id: <1533076661-8030-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH] hw/sd: Mark sd-card as storage device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>

sd-card is currently listed as uncategorized device.
Mark it as storage device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/sd/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d4356e9..aaab15f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2121,6 +2121,7 @@ static void sd_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &sd_vmstate;
     dc->reset = sd_reset;
     dc->bus_type = TYPE_SD_BUS;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 
     sc->set_voltage = sd_set_voltage;
     sc->get_dat_lines = sd_get_dat_lines;
-- 
2.7.4
