Received: from eggs.gnu.org ([2001:4830:134:3::10]:42111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuE-0003dk-N6
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuE-0007Ob-1N
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:11:11 +0100
Message-Id: <20180820141116.9118-18-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 17/22] hw/ssi/pl022: Don't directly call
 vmstate_register()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Use the DeviceState vmsd pointer rather than calling vmstate_register()
directly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/pl022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index 0b5f90b857f..c9989537062 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -279,7 +279,6 @@ static int pl022_init(SysBusDevice *sbd)
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
     s->ssi = ssi_create_bus(dev, "ssi");
-    vmstate_register(dev, -1, &vmstate_pl022, s);
     return 0;
 }
 
@@ -290,6 +289,7 @@ static void pl022_class_init(ObjectClass *klass, void *data)
 
     sdc->init = pl022_init;
     dc->reset = pl022_reset;
+    dc->vmsd = &vmstate_pl022;
 }
 
 static const TypeInfo pl022_info = {
-- 
2.18.0
