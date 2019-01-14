Received: from eggs.gnu.org ([209.51.188.92]:44876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz54-0005gq-JS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz53-0007bO-PL
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz53-0007al-JU
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:53 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:14 +0100
Message-Id: <1547460140-1473-20-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/25] ui/console: Remove QemuDmaBuf from
 "qemu/typedefs.h"
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

Files requiring QemuDmaBuf already include "ui/console.h".

To clean "qemu/typedefs.h", move the declaration to "ui/console.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/typedefs.h | 1 -
 include/ui/console.h    | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index c6d1c1b..67dd04f 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -82,7 +82,6 @@ typedef struct QBool QBool;
 typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
-typedef struct QemuDmaBuf QemuDmaBuf;
 typedef struct QEMUFile QEMUFile;
 typedef struct QemuLockable QemuLockable;
 typedef struct QemuMutex QemuMutex;
diff --git a/include/ui/console.h b/include/ui/console.h
index 853fcf4..c4f497c 100644
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
1.8.3.1
