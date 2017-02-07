Received: from eggs.gnu.org ([2001:4830:134:3::10]:60389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6By-0007Qm-4Q
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6Bv-0007hQ-4Z
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6Bu-0007gm-VB
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:19 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 191193A769F
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:52:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:51:44 +0400
Message-Id: <20170207135211.15870-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/28] qtest: fix a memory leak
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

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qtest.c b/qtest.c
index 1446719e8d..6f4d26832a 100644
--- a/qtest.c
+++ b/qtest.c
@@ -240,6 +240,7 @@ static void GCC_FMT_ATTR(2, 3) qtest_sendf(CharBacken=
d *chr,
     va_start(ap, fmt);
     buffer =3D g_strdup_vprintf(fmt, ap);
     qtest_send(chr, buffer);
+    g_free(buffer);
     va_end(ap);
 }
=20
--=20
2.11.0.295.gd7dffce1c.dirty
