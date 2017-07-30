Received: from eggs.gnu.org ([2001:4830:134:3::10]:35320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dbuqF-0004oH-4n
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dbuqA-0005lM-70
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:29:35 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:38448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dbuqA-0005kE-0k
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:29:30 -0400
Received: by mail-io0-x244.google.com with SMTP id l7so17931162iof.5
	for <qemu-devel@nongnu.org>; Sun, 30 Jul 2017 13:29:29 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <BCFCA0C8-8811-43C3-B65A-76B4470868FD@gmail.com>
Date: Sun, 30 Jul 2017 16:29:27 -0400
Subject: [Qemu-devel] [PATCH v2 1/2] Add more function keys to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

There are now keyboards that have 19 function keys. This patch extends =
QEMU so these function keys can be used.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 qapi-schema.json  | 12 +++++++++++-
 ui/input-keymap.c |  9 +++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index c96f0a2..f1c989b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4862,6 +4862,15 @@
 # @ac_refresh: since 2.10
 # @ac_bookmarks: since 2.10
 # altgr, altgr_r: dropped in 2.10
+# @f16: since 2.11
+# @f17: since 2.11
+# @f18: since 2.11
+# @f19: since 2.11
+# @f20: since 2.11
+# @f21: since 2.11
+# @f22: since 2.11
+# @f23: since 2.11
+# @f24: since 2.11
 #
 # Since: 1.3.0
 #
@@ -4888,7 +4897,8 @@
             'audionext', 'audioprev', 'audiostop', 'audioplay', =
'audiomute',
             'volumeup', 'volumedown', 'mediaselect',
             'mail', 'calculator', 'computer',
-            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', =
'ac_bookmarks' ] }
+            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', =
'ac_bookmarks',
+            'f16', 'f17', 'f18', 'f19', 'f20', 'f21', 'f22', 'f23', =
'f24'] }
=20
 ##
 # @KeyValue:
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index cf979c2..c0413e1 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -251,6 +251,15 @@ static const int qcode_to_number[] =3D {
=20
     [Q_KEY_CODE_F11] =3D 0x57,
     [Q_KEY_CODE_F12] =3D 0x58,
+    [Q_KEY_CODE_F16] =3D 0x59,
+    [Q_KEY_CODE_F17] =3D 0x5a,
+    [Q_KEY_CODE_F18] =3D 0x5b,
+    [Q_KEY_CODE_F19] =3D 0x5c,
+    [Q_KEY_CODE_F20] =3D 0x5d,
+    [Q_KEY_CODE_F21] =3D 0x5e,
+    [Q_KEY_CODE_F22] =3D 0x5f,
+    [Q_KEY_CODE_F23] =3D 0x60,
+    [Q_KEY_CODE_F24] =3D 0x61,
=20
     [Q_KEY_CODE_PRINT] =3D 0xb7,
=20
--=20
2.7.2
