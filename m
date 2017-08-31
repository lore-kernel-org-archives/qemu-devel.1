Received: from eggs.gnu.org ([2001:4830:134:3::10]:41388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMpA-0002OB-8E
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMp8-00060T-Vk
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:35:48 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 Aug 2017 12:34:18 +0200
Message-Id: <20170831103432.6007-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170831103432.6007-1-marcandre.lureau@redhat.com>
References: <20170831103432.6007-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/29] monitor: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index e0f880107f..135ec2de8f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1349,7 +1349,7 @@ static void memory_dump(Monitor *mon, int count, in=
t format, int wsize,
=20
     switch(format) {
     case 'o':
-        max_digits =3D (wsize * 8 + 2) / 3;
+        max_digits =3D DIV_ROUND_UP(wsize * 8, 3);
         break;
     default:
     case 'x':
@@ -1357,7 +1357,7 @@ static void memory_dump(Monitor *mon, int count, in=
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
2.14.1.146.gd35faa819
