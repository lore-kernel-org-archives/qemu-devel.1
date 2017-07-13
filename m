Received: from eggs.gnu.org ([2001:4830:134:3::10]:42408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh3M-00031E-8K
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh3L-0004Pj-CJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:33:24 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:31:57 +0200
Message-Id: <20170713163219.9024-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/29] dmg: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:dmg" <qemu-block@nongnu.org>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/dmg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/dmg.c b/block/dmg.c
index 900ae5a678..6c0711f563 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -111,7 +111,7 @@ static void update_max_chunk_size(BDRVDMGState *s, ui=
nt32_t chunk,
         uncompressed_sectors =3D s->sectorcounts[chunk];
         break;
     case 1: /* copy */
-        uncompressed_sectors =3D (s->lengths[chunk] + 511) / 512;
+        uncompressed_sectors =3D DIV_ROUND_UP(s->lengths[chunk], 512);
         break;
     case 2: /* zero */
         /* as the all-zeroes block may be large, it is treated specially=
: the
--=20
2.13.1.395.gf7b71de06
