Received: from eggs.gnu.org ([209.51.188.92]:48167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxdp-0005cg-JC
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxXm-0007NE-Kk
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:12:20 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:57 +0100
Message-Id: <20190111140857.4211-16-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 15/15] ui/console: Add "ui/pixelformat.h"
 to declare PixelFormat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

PixelFormat is used by "ui/console.h" and by "ui/qemu-pixman.h".

Create the new header "ui/pixelformat.h" to declare this structure,
and remove the forward declaration from "qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC because "ui/console.h" has on license, so I added a default one.
---
 include/qemu/typedefs.h  |  1 -
 include/ui/console.h     | 11 +----------
 include/ui/pixelformat.h | 31 +++++++++++++++++++++++++++++++
 include/ui/qemu-pixman.h |  2 ++
 4 files changed, 34 insertions(+), 11 deletions(-)
 create mode 100644 include/ui/pixelformat.h

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index af0dc6e065..b0f33aa065 100644
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
index aa9f975544..4fa2fa5c47 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -2,6 +2,7 @@
 #define CONSOLE_H
=20
 #include "ui/qemu-pixman.h"
+#include "ui/pixelformat.h"
 #include "qom/object.h"
 #include "qemu/notify.h"
 #include "qemu/error-report.h"
@@ -121,16 +122,6 @@ struct QemuConsoleClass {
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
diff --git a/include/ui/pixelformat.h b/include/ui/pixelformat.h
new file mode 100644
index 0000000000..585097531f
--- /dev/null
+++ b/include/ui/pixelformat.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_PIXELFORMAT_H
+#define QEMU_PIXELFORMAT_H
+
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
+#endif
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index b7c82d17fc..999a4aa770 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -16,6 +16,8 @@
 #pragma GCC diagnostic pop
 #endif
=20
+#include "ui/pixelformat.h"
+
 /*
  * pixman image formats are defined to be native endian,
  * that means host byte order on qemu.  So we go define
--=20
2.17.2
