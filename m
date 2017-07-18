Received: from eggs.gnu.org ([2001:4830:134:3::10]:60309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsZ-0001lf-GW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsW-0000rM-EP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:48 -0300
Message-Id: <20170718061005.29518-13-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/29] sm501: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/sm501_template.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
index a60abad019..6b6386bc72 100644
--- a/hw/display/sm501_template.h
+++ b/hw/display/sm501_template.h
@@ -105,7 +105,7 @@ static void glue(draw_hwc_line_, PIXEL_NAME)(uint8_t *d, const uint8_t *s,
 
     for (i = 0; i < SM501_HWC_WIDTH && c_x + i < width; i++) {
         /* get pixel value */
-        if (i % 4 == 0) {
+        if (QEMU_IS_ALIGNED(i, 4)) {
             bitset = ldub_p(s);
             s++;
         }
-- 
2.13.2
