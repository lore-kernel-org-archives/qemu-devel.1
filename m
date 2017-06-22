Received: from eggs.gnu.org ([2001:4830:134:3::10]:45551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1SU-00076w-EP
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1ST-0006lG-Ie
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1ST-0006l9-D5
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51986C056793
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:43:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:50 +0200
Message-Id: <20170622124204.19407-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/31] console: use DIV_ROUND_UP
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
 include/ui/console.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 7262bef6d3..8024878bae 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -328,7 +328,7 @@ static inline int surface_bits_per_pixel(DisplaySurfa=
ce *s)
 static inline int surface_bytes_per_pixel(DisplaySurface *s)
 {
     int bits =3D PIXMAN_FORMAT_BPP(s->format);
-    return (bits + 7) / 8;
+    return DIV_ROUND_UP(bits, 8);
 }
=20
 static inline pixman_format_code_t surface_format(DisplaySurface *s)
--=20
2.13.1.395.gf7b71de06
