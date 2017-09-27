Received: from eggs.gnu.org ([2001:4830:134:3::10]:56530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70N-0001Rc-AH
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70L-00044K-Pc
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:42:58 +1000
Message-Id: <20170927074316.4454-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/26] ppc/mac: Advertise a high clock frequency
 for NewWorld Macs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

We use 900Mhz, otherwise MacOS X 10.5 refuses to install.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_newworld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index d013c412d6..6a2bce181a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -77,7 +77,7 @@
 #define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
 #define TBFREQ (100UL * 1000UL * 1000UL)
-#define CLOCKFREQ (266UL * 1000UL * 1000UL)
+#define CLOCKFREQ (900UL * 1000UL * 1000UL)
 #define BUSFREQ (100UL * 1000UL * 1000UL)
 
 #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
-- 
2.13.5
