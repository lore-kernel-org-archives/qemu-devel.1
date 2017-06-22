Received: from eggs.gnu.org ([2001:4830:134:3::10]:45391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1SA-0006pJ-Ty
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1SA-0006cd-6R
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1S9-0006bG-Vs
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5FD54ACD0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:43:16 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:46 +0200
Message-Id: <20170622124204.19407-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/31] ui: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/cursor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/cursor.c b/ui/cursor.c
index 5155b392e8..2e2fe13fa6 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -118,7 +118,7 @@ void cursor_put(QEMUCursor *c)
=20
 int cursor_get_mono_bpl(QEMUCursor *c)
 {
-    return (c->width + 7) / 8;
+    return DIV_ROUND_UP(c->width, 8);
 }
=20
 void cursor_set_mono(QEMUCursor *c,
--=20
2.13.1.395.gf7b71de06
