Received: from eggs.gnu.org ([209.51.188.92]:35088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj1zI-0005YA-S9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj1zI-0007Aq-3E
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:09:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj1zH-0007Af-Tv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:09:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30D50D7923
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 13:09:07 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 14 Jan 2019 14:08:29 +0100
Message-Id: <20190114130829.21790-4-philmd@redhat.com>
In-Reply-To: <20190114130829.21790-1-philmd@redhat.com>
References: <20190114130829.21790-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/3] ui/console: Remove PixelFormat from
 qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Header files requiring PixelFormat already include "ui/qemu-pixman.h".

To clean "qemu/typedefs.h", move the declaration to "ui/qemu-pixman.h"
(removing the forward declaration).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/qemu/typedefs.h  |  1 -
 include/ui/console.h     | 10 ----------
 include/ui/qemu-pixman.h | 10 ++++++++++
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 4cda7343bf..64b8386697 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -67,7 +67,6 @@ typedef struct PCIExpressHost PCIExpressHost;
 typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
 typedef struct PCIHostState PCIHostState;
 typedef struct PCMachineState PCMachineState;
-typedef struct PixelFormat PixelFormat;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
diff --git a/include/ui/console.h b/include/ui/console.h
index aa9f975544..fef900db76 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -121,16 +121,6 @@ struct QemuConsoleClass {
=20
 #define QEMU_ALLOCATED_FLAG     0x01
=20
-struct PixelFormat {
-    uint8_t bits_per_pixel;
-    uint8_t bytes_per_pixel;
-    uint8_t depth; /* color depth in bits */
-    uint32_t rmask, gmask, bmask, amask;
-    uint8_t rshift, gshift, bshift, ashift;
-    uint8_t rmax, gmax, bmax, amax;
-    uint8_t rbits, gbits, bbits, abits;
-};
-
 typedef struct DisplaySurface {
     pixman_format_code_t format;
     pixman_image_t *image;
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index b7c82d17fc..0668109305 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -53,6 +53,16 @@
=20
 /* -------------------------------------------------------------------- =
*/
=20
+typedef struct PixelFormat {
+    uint8_t bits_per_pixel;
+    uint8_t bytes_per_pixel;
+    uint8_t depth; /* color depth in bits */
+    uint32_t rmask, gmask, bmask, amask;
+    uint8_t rshift, gshift, bshift, ashift;
+    uint8_t rmax, gmax, bmax, amax;
+    uint8_t rbits, gbits, bbits, abits;
+} PixelFormat;
+
 PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format);
 pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_end=
ian);
 pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format);
--=20
2.17.2
