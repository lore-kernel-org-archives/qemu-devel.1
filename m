Received: from eggs.gnu.org ([2001:4830:134:3::10]:37412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1ciNoX-0000Jy-ID
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1ciNoT-0006Ys-Ka
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:06:17 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1ciNoT-0006Yf-Ek
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:06:13 -0500
Received: by mail-pg0-x241.google.com with SMTP id 25so1490462pgy.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 08:06:13 -0800 (PST)
From: Suramya Shah <shah.suramya@gmail.com>
Date: Mon, 27 Feb 2017 21:31:18 +0530
Message-Id: <20170227160118.3557-1-shah.suramya@gmail.com>
Subject: [Qemu-devel] [[PATCH-2]] Removed support for DEPTH!=32 in sm501.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shah.suramya@gmail.com, peter.maydell@linaro.org, kraxel@redhat.com

Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
---
 hw/display/sm501.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 040a0b9..faca906 100644
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
 
-- 
2.9.3
