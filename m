Received: from eggs.gnu.org ([2001:4830:134:3::10]:38483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosih-0004ur-UX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosid-0001iG-DM
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:39 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosid-0001hW-6e
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosic-00023i-8x
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:34 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:50 +0000
Message-Id: <20180222152307.7499-16-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/32] sdcard: use G_BYTE from cutils
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

code is now easier to read.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215220540.6556-11-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 90d1e27ee7..b3698e34ad 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -36,6 +36,7 @@
 #include "hw/sd/sd.h"
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
+#include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
@@ -343,7 +344,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
     uint32_t wpsize = (1 << (WPGROUP_SHIFT + 1)) - 1;
 
-    if (size <= 0x40000000) {	/* Standard Capacity SD */
+    if (size <= 1 * G_BYTE) { /* Standard Capacity SD */
         sd->csd[0] = 0x00;	/* CSD structure */
         sd->csd[1] = 0x26;	/* Data read access-time-1 */
         sd->csd[2] = 0x00;	/* Data read access-time-2 */
-- 
2.16.1
