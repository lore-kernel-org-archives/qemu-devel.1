Received: from eggs.gnu.org ([2001:4830:134:3::10]:41466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMpE-0002TC-Vu
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMpD-000693-Rj
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:35:52 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 Aug 2017 12:34:19 +0200
Message-Id: <20170831103432.6007-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170831103432.6007-1-marcandre.lureau@redhat.com>
References: <20170831103432.6007-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/29] console: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
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
2.14.1.146.gd35faa819
