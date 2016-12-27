Received: from eggs.gnu.org ([2001:4830:134:3::10]:35498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLta0-0002R7-On
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZz-0001Ji-Vh
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZz-0001Ja-P7
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:19 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZy-0003uq-Uo
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:18 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:06 +0000
Message-Id: <1482852077-19397-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/25] aspeed: attach the second SPI controller
 object to the SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1480434248-27138-6-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 3a6b91f..82e2712 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -124,7 +124,7 @@ static void aspeed_soc_init(Object *obj)
     for (i = 0; i < sc->info->spis_num; i++) {
         object_initialize(&s->spi[i], sizeof(s->spi[i]),
                           sc->info->spi_typename[i]);
-        object_property_add_child(obj, "spi", OBJECT(&s->spi[i]), NULL);
+        object_property_add_child(obj, "spi[*]", OBJECT(&s->spi[i]), NULL);
         qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
     }
 
-- 
2.7.4
