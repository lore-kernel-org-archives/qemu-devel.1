Received: from eggs.gnu.org ([2001:4830:134:3::10]:60686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLt1-0002CB-NP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLt0-0001YL-St
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:58 -0300
Message-Id: <20170718061005.29518-23-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 22/29] vmsvga: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

No entry in MAINTAINERS, should it go under Graphics or Vmware?

 hw/display/vmware_vga.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 4a64b41259..ff8130ff70 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -679,10 +679,9 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             if (cursor.width > 256
                 || cursor.height > 256
                 || cursor.bpp > 32
-                || SVGA_BITMAP_SIZE(x, y)
-                    > sizeof(cursor.mask) / sizeof(cursor.mask[0])
+                || SVGA_BITMAP_SIZE(x, y) > ARRAY_SIZE(cursor.mask)
                 || SVGA_PIXMAP_SIZE(x, y, cursor.bpp)
-                    > sizeof(cursor.image) / sizeof(cursor.image[0])) {
+                    > ARRAY_SIZE(cursor.image)) {
                     goto badcmd;
             }
 
-- 
2.13.2
