Received: from eggs.gnu.org ([2001:4830:134:3::10]:41864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Vnr-0006LV-2w
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Vnn-0006u9-V3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:21:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Vnn-0006tT-Qh
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:20:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BD9E4072CC5
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 17:20:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 19:20:41 +0200
Message-Id: <20180326172041.21009-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qmp-test: fix response leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Apparently introduced in commit a4f90923b520f1dc0a768634877eb412e5052c26.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 558e83540c..8de99a4727 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -90,6 +90,7 @@ static void test_qmp_protocol(void)
     test_version(qdict_get(q, "version"));
     capabilities =3D qdict_get_qlist(q, "capabilities");
     g_assert(capabilities && qlist_empty(capabilities));
+    QDECREF(resp);
=20
     /* Test valid command before handshake */
     resp =3D qtest_qmp(qts, "{ 'execute': 'query-version' }");
--=20
2.17.0.rc1.1.g4c4f2b46a3
