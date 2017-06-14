Received: from eggs.gnu.org ([2001:4830:134:3::10]:46576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Am-0005SX-6r
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Ai-0002I2-7i
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL3Ai-0002Gc-1N
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F27B980470
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:56:58 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 09:56:50 +0200
Message-Id: <20170614075653.26420-3-kraxel@redhat.com>
In-Reply-To: <20170614075653.26420-1-kraxel@redhat.com>
References: <20170614075653.26420-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] spice: Use proper enum type for kbd led
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jonathon Jongsma <jjongsma@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Jonathon Jongsma <jjongsma@redhat.com>

Although the Qemu and spice flags currently have the same value, it
seems more correct to pass the spice flag values to
spice_server_kbd_leds(), especially considering that this function
already makes an effort to convert between the QEMU_*_LED and
SPICE_KEYBOARD_MODIFIER_* values.

Signed-off-by: Jonathon Jongsma <jjongsma@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20170510202006.31737-1-jjongsma@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index 86293dd2ce..918580239d 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -87,7 +87,7 @@ static void kbd_leds(void *opaque, int ledstate)
     if (ledstate & QEMU_CAPS_LOCK_LED) {
         kbd->ledstate |=3D SPICE_KEYBOARD_MODIFIER_FLAGS_CAPS_LOCK;
     }
-    spice_server_kbd_leds(&kbd->sin, ledstate);
+    spice_server_kbd_leds(&kbd->sin, kbd->ledstate);
 }
=20
 /* mouse bits */
--=20
2.9.3
