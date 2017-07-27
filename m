Received: from eggs.gnu.org ([2001:4830:134:3::10]:48438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dak8Z-0002md-BE
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dak8V-0003kL-GY
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:51:39 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dak8V-0003jr-Bm
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:51:35 -0400
Received: by mail-it0-x242.google.com with SMTP id r9so12886124ita.3
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:51:35 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <1920BE03-56F6-4E44-B9D2-0638A86FACB2@gmail.com>
Date: Thu, 27 Jul 2017 10:51:33 -0400
Subject: [Qemu-devel] [PATCH 1/2] Add more function keys to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

There are now keyboards that have 19 function keys. This patch extends =
QEMU so these function keys can be used.=20

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 qapi-schema.json  | 6 +++++-
 ui/input-keymap.c | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 9c6c3e1..a051820 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4842,6 +4842,10 @@
 # @hiragana: since 2.9
 # @henkan: since 2.9
 # @yen: since 2.9
+# @f16: since 2.10
+# @f17: since 2.10
+# @f18: since 2.10
+# @f19: since 2.10
 #
 # Since: 1.3.0
 #
@@ -4864,7 +4868,7 @@
             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', =
'cut',
             'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
             'ro', 'hiragana', 'henkan', 'yen',
-            'kp_comma', 'kp_equals', 'power' ] }
+            'kp_comma', 'kp_equals', 'power', 'f16', 'f17', 'f18', =
'f19'] }
=20
 ##
 # @KeyValue:
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 8a1476f..d1169e3 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -114,6 +114,10 @@ static const int qcode_to_number[] =3D {
=20
     [Q_KEY_CODE_F11] =3D 0x57,
     [Q_KEY_CODE_F12] =3D 0x58,
+    [Q_KEY_CODE_F16] =3D 0x59,
+    [Q_KEY_CODE_F17] =3D 0x5a,
+    [Q_KEY_CODE_F18] =3D 0x5b,
+    [Q_KEY_CODE_F19] =3D 0x5c,
=20
     [Q_KEY_CODE_PRINT] =3D 0xb7,
=20
--=20
2.7.2
