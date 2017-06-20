Received: from eggs.gnu.org ([2001:4830:134:3::10]:45265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITH-0004Me-0M
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITB-0002GW-A6
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNITB-0002Eq-1b
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D44FB7CE04
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:41:08 +0200
Message-Id: <1497962468-22936-42-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 41/41] tests/qdict: check more get_try_int()
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170607163635.17635-42-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qdict.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 5eca1b5..3540577 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -108,10 +108,17 @@ static void qdict_get_try_int_test(void)
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
2.7.5
