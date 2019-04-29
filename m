Received: from eggs.gnu.org ([209.51.188.92]:34363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004r5-3R
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9en-0006jr-Ps
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9em-0006bE-CE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id b10so156608wmj.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.12
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:20 +0100
Message-Id: <20190429170030.11323-33-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/42] hw/arm/nseries: Use TYPE_TMP105 instead
 of hardcoded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-3-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/nseries.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 906b7ca22d4..2b710c3d49f 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -31,6 +31,7 @@
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/devices.h"
+#include "hw/misc/tmp105.h"
 #include "hw/block/flash.h"
 #include "hw/hw.h"
 #include "hw/bt.h"
@@ -218,7 +219,7 @@ static void n8x0_i2c_setup(struct n800_s *s)
     qemu_register_powerdown_notifier(&n8x0_system_powerdown_notifier);
 
     /* Attach a TMP105 PM chip (A0 wired to ground) */
-    dev = i2c_create_slave(i2c, "tmp105", N8X0_TMP105_ADDR);
+    dev = i2c_create_slave(i2c, TYPE_TMP105, N8X0_TMP105_ADDR);
     qdev_connect_gpio_out(dev, 0, tmp_irq);
 }
 
-- 
2.20.1
