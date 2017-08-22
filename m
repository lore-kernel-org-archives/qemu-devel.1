Received: from eggs.gnu.org ([2001:4830:134:3::10]:55348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JX-0008Bo-Eq
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JW-00079T-Gu
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:51 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:14 +0200
Message-Id: <20170822132255.23945-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/54] qapi: drop the sentinel in enum array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:parallels" <qemu-block@nongnu.org>

Now that all usages have been converted to user lookup helpers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py   | 1 -
 block/parallels.c | 1 -
 ui/input-legacy.c | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 314d7e0365..73adb90379 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1863,7 +1863,6 @@ static const char *const %(c_name)s_array[] =3D {
=20
     max_index =3D c_enum_const(name, '_MAX', prefix)
     ret +=3D mcgen('''
-    [%(max_index)s] =3D NULL,
 };
=20
 const QEnumLookup %(c_name)s_lookup =3D {
diff --git a/block/parallels.c b/block/parallels.c
index f870bbac3e..d5de692c9c 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -72,7 +72,6 @@ typedef enum ParallelsPreallocMode {
 static const char *prealloc_mode_array[] =3D {
     "falloc",
     "truncate",
-    NULL,
 };
=20
 static QEnumLookup prealloc_mode_lookup =3D {
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index c597bdc711..d50a18a505 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -61,7 +61,7 @@ int index_from_key(const char *key, size_t key_length)
 {
     int i;
=20
-    for (i =3D 0; QKeyCode_lookup.array[i] !=3D NULL; i++) {
+    for (i =3D 0; i < QKeyCode_lookup.size; i++) {
         if (!strncmp(key, QKeyCode_lookup.array[i], key_length) &&
             !QKeyCode_lookup.array[i][key_length]) {
             break;
--=20
2.14.1.146.gd35faa819
