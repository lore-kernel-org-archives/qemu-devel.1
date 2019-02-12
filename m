Received: from eggs.gnu.org ([209.51.188.92]:41370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtZeM-0003E2-9h
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 10:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtZVe-0000SN-8K
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:58:07 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 12 Feb 2019 15:57:22 +0100
Message-Id: <20190212145722.31891-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] chardev/wctablet: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatoli Huseu1 <avg.tolik@gmail.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The correct name is Wacom.
Fix the typo present this the origin of this file (378af96155d).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/wctablet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 969d014574..35dbd29a33 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -177,7 +177,7 @@ static void wctablet_input_sync(DeviceState *dev)
 }
=20
 static QemuInputHandler wctablet_handler =3D {
-    .name  =3D "QEMU Wacome Pen Tablet",
+    .name  =3D "QEMU Wacom Pen Tablet",
     .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
     .event =3D wctablet_input_event,
     .sync  =3D wctablet_input_sync,
--=20
2.20.1
