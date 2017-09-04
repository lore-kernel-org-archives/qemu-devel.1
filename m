Received: from eggs.gnu.org ([2001:4830:134:3::10]:52747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSa-00058k-UB
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSM-0004sw-PW
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSM-0004ru-8V
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSL-0005Za-9r
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:21 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:55 +0100
Message-Id: <1504527967-29248-25-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/36] aspeed_soc: Propagate silicon-rev to
 watchdog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jeffery <andrew@aj.id.au>

This is required to configure differences in behaviour between the
AST2400 and AST2500 watchdog IPs.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5529024..22dcac9 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -183,6 +183,8 @@ static void aspeed_soc_init(Object *obj)
         object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
         object_property_add_child(obj, "wdt[*]", OBJECT(&s->wdt[i]), NULL);
         qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default());
+        qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
+                                    sc->info->silicon_rev);
     }
 
     object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC100);
-- 
2.7.4
