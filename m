Received: from eggs.gnu.org ([2001:4830:134:3::10]:49193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcI-0007OE-2V
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcC-0004vw-KX
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcC-0004vq-GK
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 199ED7B4AD
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 14:30:20 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:01 -0500
Message-Id: <20180327143014.1767669-2-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/14] qmp-test: fix response leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Apparently introduced in commit a4f90923b520f1dc0a768634877eb412e5052c26.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180326172041.21009-1-marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qmp-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 558e83540cc..8de99a4727e 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -90,6 +90,7 @@ static void test_qmp_protocol(void)
     test_version(qdict_get(q, "version"));
     capabilities =3D qdict_get_qlist(q, "capabilities");
     g_assert(capabilities && qlist_empty(capabilities));
+    QDECREF(resp);

     /* Test valid command before handshake */
     resp =3D qtest_qmp(qts, "{ 'execute': 'query-version' }");
--=20
2.14.3
