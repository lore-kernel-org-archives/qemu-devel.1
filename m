Received: from eggs.gnu.org ([2001:4830:134:3::10]:51221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ7o-00006H-D2
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ7k-0000W4-I7
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:03:08 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:55:10 +0300
Message-Id: <f96c18965ced5f5502c9547d12f07a255062e4f1.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/17] tests/hbitmap: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/test-hbitmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 9091c639b3..f29631f939 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -813,7 +813,7 @@ static void test_hbitmap_serialize_basic(TestHBitmapD=
ata *data,
     size_t buf_size;
     uint8_t *buf;
     uint64_t positions[] =3D { 0, 1, L1 - 1, L1, L2 - 1, L2, L2 + 1, L3 =
- 1 };
-    int num_positions =3D sizeof(positions) / sizeof(positions[0]);
+    int num_positions =3D ARRAY_SIZE(positions);
=20
     hbitmap_test_init(data, L3, 0);
     g_assert(hbitmap_is_serializable(data->hb));
@@ -838,7 +838,7 @@ static void test_hbitmap_serialize_part(TestHBitmapDa=
ta *data,
     size_t buf_size;
     uint8_t *buf;
     uint64_t positions[] =3D { 0, 1, L1 - 1, L1, L2 - 1, L2, L2 + 1, L3 =
- 1 };
-    int num_positions =3D sizeof(positions) / sizeof(positions[0]);
+    int num_positions =3D ARRAY_SIZE(positions);
=20
     hbitmap_test_init(data, L3, 0);
     buf_size =3D L2;
@@ -880,7 +880,7 @@ static void test_hbitmap_serialize_zeroes(TestHBitmap=
Data *data,
     int64_t next;
     uint64_t min_l1 =3D MAX(L1, 64);
     uint64_t positions[] =3D { 0, min_l1, L2, L3 - min_l1};
-    int num_positions =3D sizeof(positions) / sizeof(positions[0]);
+    int num_positions =3D ARRAY_SIZE(positions);
=20
     hbitmap_test_init(data, L3, 0);
=20
--=20
2.11.0
