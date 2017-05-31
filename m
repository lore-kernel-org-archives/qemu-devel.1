Received: from eggs.gnu.org ([2001:4830:134:3::10]:52139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG498-0003s5-HO
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG495-00044z-Th
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG495-00044p-N7
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2280804EE
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:58:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:35 +0400
Message-Id: <20170531135709.345-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/45] tests: remove /qnum/destroy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The test isn't really useful.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/check-qnum.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/tests/check-qnum.c b/tests/check-qnum.c
index 4b3fec050e..7cc4262ee7 100644
--- a/tests/check-qnum.c
+++ b/tests/check-qnum.c
@@ -32,8 +32,7 @@ static void qnum_from_int_test(void)
     g_assert_cmpint(qi->base.refcnt, =3D=3D, 1);
     g_assert_cmpint(qobject_type(QOBJECT(qi)), =3D=3D, QTYPE_QNUM);
=20
-    // destroy doesn't exit yet
-    g_free(qi);
+    QDECREF(qi);
 }
=20
 static void qnum_from_double_test(void)
@@ -47,8 +46,7 @@ static void qnum_from_double_test(void)
     g_assert_cmpint(qf->base.refcnt, =3D=3D, 1);
     g_assert_cmpint(qobject_type(QOBJECT(qf)), =3D=3D, QTYPE_QNUM);
=20
-    // destroy doesn't exit yet
-    g_free(qf);
+    QDECREF(qf);
 }
=20
 static void qnum_from_int64_test(void)
@@ -106,24 +104,12 @@ static void qnum_to_string_test(void)
     QDECREF(qn);
 }
=20
-static void qnum_destroy_test(void)
-{
-    QNum *qn;
-
-    qn =3D qnum_from_int(0);
-    QDECREF(qn);
-
-    qn =3D qnum_from_double(0.42);
-    QDECREF(qn);
-}
-
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
=20
     g_test_add_func("/qnum/from_int", qnum_from_int_test);
     g_test_add_func("/qnum/from_double", qnum_from_double_test);
-    g_test_add_func("/qnum/destroy", qnum_destroy_test);
     g_test_add_func("/qnum/from_int64", qnum_from_int64_test);
     g_test_add_func("/qnum/get_int", qnum_get_int_test);
     g_test_add_func("/qnum/to_qnum", qobject_to_qnum_test);
--=20
2.13.0.91.g00982b8dd
