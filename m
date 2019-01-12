Received: from eggs.gnu.org ([209.51.188.92]:45087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gi8JO-0006dM-TQ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 20:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gi8JO-00088N-Br
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 20:42:10 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 12 Jan 2019 02:32:44 +0100
Message-Id: <20190112014156.6AA447456B3@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] smbus: Remove unneeded include
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

The file no longer uses error_report after review so the header is not
needed either.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Forgot to delete this when rewriting after review. This
can be squashed into 7713f5bed in dgibson/qemu/ppc-for-4.0

 hw/i2c/smbus_eeprom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index bef24a1ca4..01b9439014 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-- 
2.13.7
