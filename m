Received: from eggs.gnu.org ([209.51.188.92]:39824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gttke-0004pq-0X
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gttkd-00045U-47
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:34:55 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 13 Feb 2019 13:34:45 +0100
Message-Id: <20190213123446.1768-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] chardev/wctablet: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Anatoli Huseu1 <avg.tolik@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The correct name is Wacom.
Fix the typo which is present since 378af96155d.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Use correct English in description
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
