Received: from eggs.gnu.org ([209.51.188.92]:44898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz56-0005hi-PQ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz54-0007cG-TX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz54-0007bd-Nl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:54 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:15 +0100
Message-Id: <1547460140-1473-21-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/25] ui/console: Remove
 DisplayState/DisplaySurface from "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Files requiring DisplayState/DisplaySurface already include "ui/console.h=
".

To clean "qemu/typedefs.h", move the declarations to "ui/console.h"
(removing DisplaySurface forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/typedefs.h | 2 --
 include/ui/console.h    | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 67dd04f..30ad8b2 100644
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
index c4f497c..0a19037 100644
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
1.8.3.1
