Received: from eggs.gnu.org ([2001:4830:134:3::10]:51224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ7o-00006I-DS
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ7l-0000Wj-Cq
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:03:08 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:55:12 +0300
Message-Id: <d40d74a645feea0ad01482da2358804f6574dce0.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/17] tests/qapi: use ARRAY_SIZE macro
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
---
 tests/test-string-output-visitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-string-output-visitor.c b/tests/test-string-outpu=
t-visitor.c
index fa4b4ca288..02766c0f65 100644
--- a/tests/test-string-output-visitor.c
+++ b/tests/test-string-output-visitor.c
@@ -95,7 +95,7 @@ static void test_visitor_out_intList(TestOutputVisitorD=
ata *data,
     Error *err =3D NULL;
     char *str;
=20
-    for (i =3D 0; i < sizeof(value) / sizeof(value[0]); i++) {
+    for (i =3D 0; i < ARRAY_SIZE(value); i++) {
         *tmp =3D g_malloc0(sizeof(**tmp));
         (*tmp)->value =3D value[i];
         tmp =3D &(*tmp)->next;
--=20
2.11.0
