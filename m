Received: from eggs.gnu.org ([209.51.188.92]:39483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGS-0004Sw-Qo
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGS-0005kb-0E
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxGR-0005k3-Qb
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:59 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:19:08 +0100
Message-Id: <20190213161913.22107-21-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 20/25] chardev/wctablet: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The correct name is Wacom.
Fix the typo which is present since 378af96155d.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190213123446.1768-1-philmd@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.21.0.rc0.1.g036caf7885
