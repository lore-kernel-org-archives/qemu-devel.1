Received: from eggs.gnu.org ([2001:4830:134:3::10]:37137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dfKUb-0006AU-Vx
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dfKUb-0007C2-1E
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:29:22 -0400
From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed,  9 Aug 2017 15:58:28 +0930
Message-Id: <20170809062828.3673-4-andrew@aj.id.au>
In-Reply-To: <20170809062828.3673-1-andrew@aj.id.au>
References: <20170809062828.3673-1-andrew@aj.id.au>
Subject: [Qemu-devel] [PATCH for 2.11 v2 2/2] aspeed_soc: Propagate
 silicon-rev to watchdog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org, joel@jms.id.au, f4bug@amsat.org, ryan_chen@aspeedtech.com, openbmc@lists.ozlabs.org

This is required to configure differences in behaviour between the
AST2400 and AST2500 watchdog IPs.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/arm/aspeed_soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 3034849c80bf..79804e1ee652 100644
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
2.11.0
