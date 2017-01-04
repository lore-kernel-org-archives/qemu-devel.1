Received: from eggs.gnu.org ([2001:4830:134:3::10]:52370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001iI-VW
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdI-0001so-Ip
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOjdI-0001sM-C6
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:28 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  4 Jan 2017 12:21:15 +0100
Message-Id: <1483528883-1753-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
References: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/11] ps2: Fix lost scancodes by recent changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

With "ps2: use QEMU qcodes instead of scancodes", key handling was
changed to qcode base. But all scancodes are not converted to new one.

This adds some missing qcodes what I found in using.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Message-id: 87inqavlzj.fsf@mail.parknet.co.jp
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c    | 3 +++
 qapi-schema.json  | 3 ++-
 ui/input-keymap.c | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 0d14de0..3b47da4 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -394,6 +394,9 @@ static const uint16_t qcode_to_keycode_set2[Q_KEY_COD=
E__MAX] =3D {
     [Q_KEY_CODE_LESS] =3D 0x61,
     [Q_KEY_CODE_SYSRQ] =3D 0x7f,
     [Q_KEY_CODE_RO] =3D 0x51,
+    [Q_KEY_CODE_HIRAGANA] =3D 0x13,
+    [Q_KEY_CODE_HENKAN] =3D 0x64,
+    [Q_KEY_CODE_YEN] =3D 0x6a,
     [Q_KEY_CODE_KP_COMMA] =3D 0x6d,
 };
=20
diff --git a/qapi-schema.json b/qapi-schema.json
index a0d3b5d..fd5b9d7 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3642,7 +3642,8 @@
             'kp_9', 'less', 'f11', 'f12', 'print', 'home', 'pgup', 'pgdn=
', 'end',
             'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', '=
again',
             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', '=
cut',
-            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause', 'ro',
+            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
+            'ro', 'hiragana', 'henkan', 'yen',
             'kp_comma', 'kp_equals', 'power' ] }
=20
 ##
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index f1e700d..8a1476f 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -131,6 +131,9 @@ static const int qcode_to_number[] =3D {
     [Q_KEY_CODE_DELETE] =3D 0xd3,
=20
     [Q_KEY_CODE_RO] =3D 0x73,
+    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
+    [Q_KEY_CODE_HENKAN] =3D 0x79,
+    [Q_KEY_CODE_YEN] =3D 0x7d,
     [Q_KEY_CODE_KP_COMMA] =3D 0x7e,
=20
     [Q_KEY_CODE__MAX] =3D 0,
--=20
1.8.3.1
