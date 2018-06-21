Received: from eggs.gnu.org ([2001:4830:134:3::10]:59320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW3v7-0000cu-Cn
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW3v4-0006YL-A7
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:02:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 15:02:19 -0300
Message-Id: <20180621180224.8312-7-f4bug@amsat.org>
In-Reply-To: <20180621180224.8312-1-f4bug@amsat.org>
References: <20180621180224.8312-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/11] hw/sd/omap_mmc: Use qemu_log_mask(UNIMP)
 instead of printf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/omap_mmc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 5b47cadf11..aa2a816f76 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -17,6 +17,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/arm/omap.h"
 #include "hw/sd/sd.h"
@@ -449,10 +450,14 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
         s->enable = (value >> 11) & 1;
         s->be = (value >> 10) & 1;
         s->clkdiv = (value >> 0) & (s->rev >= 2 ? 0x3ff : 0xff);
-        if (s->mode != 0)
-            printf("SD mode %i unimplemented!\n", s->mode);
-        if (s->be != 0)
-            printf("SD FIFO byte sex unimplemented!\n");
+        if (s->mode != 0) {
+            qemu_log_mask(LOG_UNIMP,
+                          "omap_mmc_wr: mode #%i unimplemented\n", s->mode);
+        }
+        if (s->be != 0) {
+            qemu_log_mask(LOG_UNIMP,
+                          "omap_mmc_wr: Big Endian not implemented\n");
+        }
         if (s->dw != 0 && s->lines < 4)
             printf("4-bit SD bus enabled\n");
         if (!s->enable)
-- 
2.18.0.rc2
