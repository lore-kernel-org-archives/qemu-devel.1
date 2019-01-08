Received: from eggs.gnu.org ([209.51.188.92]:41317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggoXk-0003oN-40
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggoXg-0004oj-EN
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:23:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggoXg-0004Hk-1A
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:23:28 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  8 Jan 2019 11:23:01 +0100
Message-Id: <20190108102301.1957-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] i2c-ddc: fix oob read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: public@hansmi.ch, Gerd Hoffmann <kraxel@redhat.com>

Suggested-by: Michael Hanselmann <public@hansmi.ch>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i2c/i2c-ddc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
index be34fe072c..0a0367ff38 100644
--- a/hw/i2c/i2c-ddc.c
+++ b/hw/i2c/i2c-ddc.c
@@ -56,7 +56,7 @@ static int i2c_ddc_rx(I2CSlave *i2c)
     I2CDDCState *s = I2CDDC(i2c);
 
     int value;
-    value = s->edid_blob[s->reg];
+    value = s->edid_blob[s->reg % sizeof(s->edid_blob)];
     s->reg++;
     return value;
 }
-- 
2.9.3
