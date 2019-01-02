Received: from eggs.gnu.org ([208.118.235.92]:35860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgT-0004Oq-SC
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgS-0005SI-UG
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:05 -0500
Message-Id: <7cb0f9796d26f5d47d55710c32e0ecaf4f139aa9.1546394798.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1546394798.git.balaton@eik.bme.hu>
References: <cover.1546394798.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 02 Jan 2019 03:06:38 +0100
Subject: [Qemu-devel] [PATCH 3/8] ppc4xx: Disable debug logging by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

Debug logs were left enabled in ppc4xx_devs.c whereas in other files
these are normally not enabled. Disable it here as well.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc4xx_devs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 8c6f3c9577..9b6e4c60fa 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -32,8 +32,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 
-#define DEBUG_UIC
-
+/*#define DEBUG_UIC*/
 
 #ifdef DEBUG_UIC
 #  define LOG_UIC(...) qemu_log_mask(CPU_LOG_INT, ## __VA_ARGS__)
-- 
2.13.7
