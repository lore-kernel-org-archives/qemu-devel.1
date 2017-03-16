Received: from eggs.gnu.org ([2001:4830:134:3::10]:46988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1coRbJ-00042c-Ua
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1coRbE-0000CN-Vp
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:41 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <iwona260909@gmail.com>)
	id 1coRbE-0000Bz-Oi
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:36 -0400
Received: by mail-lf0-x242.google.com with SMTP id y193so2927550lfd.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 02:21:36 -0700 (PDT)
From: iwona260909@gmail.com
Date: Thu, 16 Mar 2017 10:20:30 +0100
Message-Id: <20170316092030.1685-2-iwona260909@gmail.com>
In-Reply-To: <20170316092030.1685-1-iwona260909@gmail.com>
References: <20170316092030.1685-1-iwona260909@gmail.com>
Subject: [Qemu-devel] [PATCH] Dead Code Removal: removing support for DEPTH
 != 32.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Iwona Kotlarska <iwona260909@gmail.com>

From: Iwona Kotlarska <iwona260909@gmail.com>

Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>
---
 hw/display/sm501.c          | 37 -------------------------------------
 hw/display/sm501_template.h |  8 +-------
 2 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 040a0b93f2..8935ea758a 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1173,23 +1173,6 @@ typedef void draw_line_func(uint8_t *d, const uint8_t *s,
 typedef void draw_hwc_line_func(SM501State * s, int crt, uint8_t * palette,
                                 int c_y, uint8_t *d, int width);
 
-#define DEPTH 8
-#include "sm501_template.h"
-
-#define DEPTH 15
-#include "sm501_template.h"
-
-#define BGR_FORMAT
-#define DEPTH 15
-#include "sm501_template.h"
-
-#define DEPTH 16
-#include "sm501_template.h"
-
-#define BGR_FORMAT
-#define DEPTH 16
-#include "sm501_template.h"
-
 #define DEPTH 32
 #include "sm501_template.h"
 
@@ -1198,43 +1181,23 @@ typedef void draw_hwc_line_func(SM501State * s, int crt, uint8_t * palette,
 #include "sm501_template.h"
 
 static draw_line_func * draw_line8_funcs[] = {
-    draw_line8_8,
-    draw_line8_15,
-    draw_line8_16,
     draw_line8_32,
     draw_line8_32bgr,
-    draw_line8_15bgr,
-    draw_line8_16bgr,
 };
 
 static draw_line_func * draw_line16_funcs[] = {
-    draw_line16_8,
-    draw_line16_15,
-    draw_line16_16,
     draw_line16_32,
     draw_line16_32bgr,
-    draw_line16_15bgr,
-    draw_line16_16bgr,
 };
 
 static draw_line_func * draw_line32_funcs[] = {
-    draw_line32_8,
-    draw_line32_15,
-    draw_line32_16,
     draw_line32_32,
     draw_line32_32bgr,
-    draw_line32_15bgr,
-    draw_line32_16bgr,
 };
 
 static draw_hwc_line_func * draw_hwc_line_funcs[] = {
-    draw_hwc_line_8,
-    draw_hwc_line_15,
-    draw_hwc_line_16,
     draw_hwc_line_32,
     draw_hwc_line_32bgr,
-    draw_hwc_line_15bgr,
-    draw_hwc_line_16bgr,
 };
 
 static inline int get_depth_index(DisplaySurface *surface)
diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
index f33e499be4..4e5801ec3e 100644
--- a/hw/display/sm501_template.h
+++ b/hw/display/sm501_template.h
@@ -22,13 +22,7 @@
  * THE SOFTWARE.
  */
 
-#if DEPTH == 8
-#define BPP 1
-#define PIXEL_TYPE uint8_t
-#elif DEPTH == 15 || DEPTH == 16
-#define BPP 2
-#define PIXEL_TYPE uint16_t
-#elif DEPTH == 32
+#if DEPTH == 32
 #define BPP 4
 #define PIXEL_TYPE uint32_t
 #else
-- 
2.12.0
