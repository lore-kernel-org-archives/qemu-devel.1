Received: from eggs.gnu.org ([2001:4830:134:3::10]:54096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Ey-0001FF-4T
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Et-0006TG-J8
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4Et-0006TA-Da
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:04:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BD2C80C11
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:04:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:57:07 +0400
Message-Id: <20170531135709.345-44-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 43/45] tests/qdict: check more get_try_int()
 cases
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

Suggested by Markus Armbruster.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/check-qdict.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 5c70490e83..889b43b57d 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -117,10 +117,17 @@ static void qdict_get_try_int_test(void)
     QDict *tests_dict =3D qdict_new();
=20
     qdict_put_int(tests_dict, key, value);
+    qdict_put_str(tests_dict, "string", "test");
=20
     ret =3D qdict_get_try_int(tests_dict, key, 0);
     g_assert(ret =3D=3D value);
=20
+    ret =3D qdict_get_try_int(tests_dict, "missing", -42);
+    g_assert_cmpuint(ret, =3D=3D, -42);
+
+    ret =3D qdict_get_try_int(tests_dict, "string", -42);
+    g_assert_cmpuint(ret, =3D=3D, -42);
+
     QDECREF(tests_dict);
 }
=20
--=20
2.13.0.91.g00982b8dd
