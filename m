Received: from eggs.gnu.org ([2001:4830:134:3::10]:34126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7i0P-0005sD-2b
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7i0O-00051c-1S
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:20:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7i0N-0004vS-Rr
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:19:59 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 18:18:30 +0400
Message-Id: <20181003141833.21493-10-marcandre.lureau@redhat.com>
In-Reply-To: <20181003141833.21493-1-marcandre.lureau@redhat.com>
References: <20181003141833.21493-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/12] tests/qom-proplist: check class
 properties iterator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This test failed before "fix iterating properties over a class".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/check-qom-proplist.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 8e1b9c27f3..7ed16b704b 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -565,6 +565,14 @@ static void test_dummy_iterator(void)
     object_unparent(OBJECT(dobj));
 }
=20
+static void test_dummy_class_iterator(void)
+{
+    ObjectPropertyIterator iter;
+    ObjectClass *klass =3D object_class_by_name(TYPE_DUMMY);
+
+    object_class_property_iter_init(&iter, klass);
+    test_dummy_prop_iterator(&iter);
+}
=20
 static void test_dummy_delchild(void)
 {
@@ -636,6 +644,7 @@ int main(int argc, char **argv)
     g_test_add_func("/qom/proplist/badenum", test_dummy_badenum);
     g_test_add_func("/qom/proplist/getenum", test_dummy_getenum);
     g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
+    g_test_add_func("/qom/proplist/class_iterator", test_dummy_class_ite=
rator);
     g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
     g_test_add_func("/qom/resolve/partial", test_qom_partial_path);
=20
--=20
2.19.0.271.gfe8321ec05
