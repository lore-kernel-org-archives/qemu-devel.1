Received: from eggs.gnu.org ([209.51.188.92]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxdt-0005cP-Ds
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxXW-0006sm-JM
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:12:03 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:55 +0100
Message-Id: <20190111140857.4211-14-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/15] ui/console: Remove QemuDmaBuf from
 "qemu/typedefs.h"
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

Files requiring QemuDmaBuf already include "ui/console.h".

To clean "qemu/typedefs.h", move the declaration to "ui/console.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/qemu/typedefs.h | 1 -
 include/ui/console.h    | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index e44f1473a5..55f4de7259 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -77,7 +77,6 @@ typedef struct QBool QBool;
 typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
-typedef struct QemuDmaBuf QemuDmaBuf;
 typedef struct QEMUFile QEMUFile;
 typedef struct QemuLockable QemuLockable;
 typedef struct QemuMutex QemuMutex;
diff --git a/include/ui/console.h b/include/ui/console.h
index b74246f0f5..8396387c47 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -179,7 +179,7 @@ struct QEMUGLParams {
     int minor_ver;
 };
=20
-struct QemuDmaBuf {
+typedef struct QemuDmaBuf {
     int       fd;
     uint32_t  width;
     uint32_t  height;
@@ -187,7 +187,7 @@ struct QemuDmaBuf {
     uint32_t  fourcc;
     uint32_t  texture;
     bool      y0_top;
-};
+} QemuDmaBuf;
=20
 typedef struct DisplayChangeListenerOps {
     const char *dpy_name;
--=20
2.17.2
