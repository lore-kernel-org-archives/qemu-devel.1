Received: from eggs.gnu.org ([2001:4830:134:3::10]:45539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1SS-00075J-Gf
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1SO-0006ka-JD
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1SO-0006kM-DP
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BB3F10C96
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:43:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:49 +0200
Message-Id: <20170622124204.19407-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/31] monitor: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index fcf4fad47b..c302ea7fba 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1335,7 +1335,7 @@ static void memory_dump(Monitor *mon, int count, in=
t format, int wsize,
=20
     switch(format) {
     case 'o':
-        max_digits =3D (wsize * 8 + 2) / 3;
+        max_digits =3D DIV_ROUND_UP(wsize * 8, 3);
         break;
     default:
     case 'x':
@@ -1343,7 +1343,7 @@ static void memory_dump(Monitor *mon, int count, in=
t format, int wsize,
         break;
     case 'u':
     case 'd':
-        max_digits =3D (wsize * 8 * 10 + 32) / 33;
+        max_digits =3D DIV_ROUND_UP(wsize * 8 * 10, 33);
         break;
     case 'c':
         wsize =3D 1;
--=20
2.13.1.395.gf7b71de06
