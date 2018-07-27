Received: from eggs.gnu.org ([2001:4830:134:3::10]:51614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fj15P-0006I4-3y
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fj15O-000502-GK
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:39:07 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jul 2018 12:38:54 +0100
Message-Id: <20180727113854.20283-3-peter.maydell@linaro.org>
In-Reply-To: <20180727113854.20283-1-peter.maydell@linaro.org>
References: <20180727113854.20283-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 2/2] hw/arm/iotkit: Fix IRQ number for
 timer1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

A cut-and-paste error meant we were incorrectly wiring up the timer1
IRQ to IRQ3. IRQ3 is the interrupt for timer0 -- move timer0 to
IRQ4 where it belongs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/iotkit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index c76d3ed7435..8cadc8b1608 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -382,7 +382,7 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer1), 0,
-                       qdev_get_gpio_in(DEVICE(&s->armv7m), 3));
+                       qdev_get_gpio_in(DEVICE(&s->armv7m), 4));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer1), 0);
     object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[1]", &err);
     if (err) {
-- 
2.17.1
