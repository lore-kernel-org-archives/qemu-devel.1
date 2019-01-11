Received: from eggs.gnu.org ([209.51.188.92]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxdr-0005cP-MA
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxXe-00078w-Ow
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:12:12 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:56 +0100
Message-Id: <20190111140857.4211-15-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/15] ui/console: Remove
 DisplayState/DisplaySurface from "qemu/typedefs.h"
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

Files requiring DisplayState/DisplaySurface already include "ui/console.h=
".

To clean "qemu/typedefs.h", move the declarations to "ui/console.h"
(removing DisplaySurface forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/qemu/typedefs.h | 2 --
 include/ui/console.h    | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 55f4de7259..af0dc6e065 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -24,8 +24,6 @@ typedef struct DeviceListener DeviceListener;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
 typedef struct DisplayChangeListener DisplayChangeListener;
-typedef struct DisplayState DisplayState;
-typedef struct DisplaySurface DisplaySurface;
 typedef struct DriveInfo DriveInfo;
 typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
diff --git a/include/ui/console.h b/include/ui/console.h
index 8396387c47..aa9f975544 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -131,7 +131,7 @@ struct PixelFormat {
     uint8_t rbits, gbits, bbits, abits;
 };
=20
-struct DisplaySurface {
+typedef struct DisplaySurface {
     pixman_format_code_t format;
     pixman_image_t *image;
     uint8_t flags;
@@ -140,7 +140,7 @@ struct DisplaySurface {
     GLenum gltype;
     GLuint texture;
 #endif
-};
+} DisplaySurface;
=20
 typedef struct QemuUIInfo {
     /* geometry */
@@ -189,6 +189,8 @@ typedef struct QemuDmaBuf {
     bool      y0_top;
 } QemuDmaBuf;
=20
+typedef struct DisplayState DisplayState;
+
 typedef struct DisplayChangeListenerOps {
     const char *dpy_name;
=20
--=20
2.17.2
