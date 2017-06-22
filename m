Received: from eggs.gnu.org ([2001:4830:134:3::10]:46005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1TU-00081S-3j
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1TT-000703-C0
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1TT-0006zx-5u
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B4D442BD1
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:44:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:42:03 +0200
Message-Id: <20170622124204.19407-31-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 30/31] test-iov: replace g_malloc()+memcpy()
 with g_memdup()
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

I found these pattern via grepping the source tree. I don't have a
coccinelle script for it!

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-iov.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/test-iov.c b/tests/test-iov.c
index a22d71fd2c..fa3d75aee1 100644
--- a/tests/test-iov.c
+++ b/tests/test-iov.c
@@ -167,8 +167,7 @@ static void test_io(void)
     }
     iov_from_buf(iov, niov, 0, buf, sz);
=20
-    siov =3D g_malloc(sizeof(*iov) * niov);
-    memcpy(siov, iov, sizeof(*iov) * niov);
+    siov =3D g_memdup(iov, sizeof(*iov) * niov);
=20
     if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) < 0) {
        perror("socketpair");
--=20
2.13.1.395.gf7b71de06
