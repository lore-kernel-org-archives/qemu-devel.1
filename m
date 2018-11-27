Received: from eggs.gnu.org ([2001:4830:134:3::10]:38458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBl-0001n5-SV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBi-0001L4-LB
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRXBi-0001G3-C9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:38 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Nov 2018 07:49:28 +0100
Message-Id: <20181127064932.7299-3-kraxel@redhat.com>
In-Reply-To: <20181127064932.7299-1-kraxel@redhat.com>
References: <20181127064932.7299-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] ps2kbd: default to scan enabled after reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

A check for scan_enabled has been added to ps2_keyboard_event in commit
143c04c7e0639e53086519592ead15d2556bfbf2 to prevent stream corruption.
This works well as long as operating system is resetting keyboard, or ena=
bling it.

This fixes IBM 40p firmware, which doesn't bother sending KBD_CMD_RESET,
KBD_CMD_ENABLE or KBD_CMD_RESET_ENABLE before trying to use the keyboard.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20181021190721.2148-1-hpoussin@reactos.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 6c43fc2912..eb33ee9b6f 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -942,7 +942,7 @@ static void ps2_kbd_reset(void *opaque)
=20
     trace_ps2_kbd_reset(opaque);
     ps2_common_reset(&s->common);
-    s->scan_enabled =3D 0;
+    s->scan_enabled =3D 1;
     s->translate =3D 0;
     s->scancode_set =3D 2;
     s->modifiers =3D 0;
--=20
2.9.3
