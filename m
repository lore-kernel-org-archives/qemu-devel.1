Received: from eggs.gnu.org ([2001:4830:134:3::10]:41062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0By-0002cS-Dp
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0Bx-00019U-1a
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:05:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cj0Bw-00019J-T2
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:05:01 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15DA43B71F
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 09:05:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  1 Mar 2017 13:04:26 +0400
Message-Id: <20170301090453.11075-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170301090453.11075-1-marcandre.lureau@redhat.com>
References: <20170301090453.11075-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/28] qtest: fix a memory leak
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 qtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qtest.c b/qtest.c
index a6858272eb..5aa6636ca8 100644
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
2.12.0.rc2.3.gc93709801
