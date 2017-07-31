Received: from eggs.gnu.org ([2001:4830:134:3::10]:60671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc8Nx-0004tI-JO
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc8Ns-0004hM-Q4
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:57:17 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:20 +0300
Message-Id: <80792eb9257588d9a554605f3411cbc7ed51e9bc.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/25] tests: check-qom-proplist: fix leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

user_creatable_add_opts() returns a reference (the other reference is
for the root parent/child link).

Leak introduced in commit a1af255f065cc.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/check-qom-proplist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 432b66585f..c51e6e734d 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -428,6 +428,8 @@ static void test_dummy_createcmdl(void)
     g_assert(err =3D=3D NULL);
     error_free(err);
=20
+    object_unref(OBJECT(dobj));
+
     /*
      * cmdline-parsing via qemu_opts_parse() results in a QemuOpts entry
      * corresponding to the Object's ID to be added to the QemuOptsList
--=20
2.11.0
