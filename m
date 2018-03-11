Received: from eggs.gnu.org ([2001:4830:134:3::10]:57363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aishwaryakadlag@gmail.com>) id 1ev41N-0002Ht-OZ
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 12:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aishwaryakadlag@gmail.com>) id 1ev41M-0000xi-H0
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 12:40:29 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aishwaryakadlag@gmail.com>)
	id 1ev41M-0000xP-9n
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 12:40:28 -0400
Received: by mail-pg0-x241.google.com with SMTP id a15so1178726pgn.5
	for <qemu-devel@nongnu.org>; Sun, 11 Mar 2018 09:40:27 -0700 (PDT)
From: Aishwarya Kadlag <aishwaryakadlag@gmail.com>
Date: Sun, 11 Mar 2018 22:10:14 +0530
Message-Id: <1520786414-8806-1-git-send-email-aishwaryakadlag@gmail.com>
Subject: [Qemu-devel] [PATCH V1]sm501: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aishwarya Kadlag <aishwaryakadlag@gmail.com>

From: Aishwarya Kadlag <aishwaryakadlag@gmail.com>

Remove support for DEPTH != 32 values from hw/display/*_template.h 
files and other files that include them. Only DEPTH == 32 case is 
supported.

Signed-off-by: Aishwarya Kadlag <aishwaryakadlag@gmail.com>
---
hw/display/sw501_1.c              |   36 ------------------------------------ 
hw/display/sw501_template_1.h     |    4 +++- 
2 files changed, 3 insertions(+), 37 deletions(-)


diff -u sm501.c sm501_1.c > sm501.patch -s
--- sm501.c	2018-03-11 17:46:33.621452968 +0530
+++ sm501_1.c	2018-03-11 17:53:26.933445566 +0530
@@ -1358,22 +1358,6 @@
                                 int width, const uint8_t *palette,
                                 int c_x, int c_y);
 
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
 
 #define DEPTH 32
 #include "sm501_template.h"
@@ -1383,43 +1367,23 @@
 #include "sm501_template.h"
 
 static draw_line_func *draw_line8_funcs[] = {
-    draw_line8_8,
-    draw_line8_15,
-    draw_line8_16,
     draw_line8_32,
     draw_line8_32bgr,
-    draw_line8_15bgr,
-    draw_line8_16bgr,
 };
 
 static draw_line_func *draw_line16_funcs[] = {
-    draw_line16_8,
-    draw_line16_15,
-    draw_line16_16,
     draw_line16_32,
     draw_line16_32bgr,
-    draw_line16_15bgr,
-    draw_line16_16bgr,
 };
 
 static draw_line_func *draw_line32_funcs[] = {
-    draw_line32_8,
-    draw_line32_15,
-    draw_line32_16,
     draw_line32_32,
     draw_line32_32bgr,
-    draw_line32_15bgr,
-    draw_line32_16bgr,
 };
 
 static draw_hwc_line_func *draw_hwc_line_funcs[] = {
-    draw_hwc_line_8,
-    draw_hwc_line_15,
-    draw_hwc_line_16,
     draw_hwc_line_32,
     draw_hwc_line_32bgr,
-    draw_hwc_line_15bgr,
-    draw_hwc_line_16bgr,
 };
 
 static inline int get_depth_index(DisplaySurface *surface)



diff -u sm501_template.h sm501_template_1.h > sm501_template.patch -s
--- sm501_template.h    2018-03-11 17:25:36.816653718 +0530
+++ sm501_template_1.h  2018-03-11 17:25:16.828654076 +0530
@@ -22,13 +22,15 @@
  * THE SOFTWARE.
  */
 
+/*
 #if DEPTH == 8
 #define BPP 1
 #define PIXEL_TYPE uint8_t
 #elif DEPTH == 15 || DEPTH == 16
 #define BPP 2
 #define PIXEL_TYPE uint16_t
-#elif DEPTH == 32
+*/
+#if DEPTH == 32
 #define BPP 4
 #define PIXEL_TYPE uint32_t
 #else
