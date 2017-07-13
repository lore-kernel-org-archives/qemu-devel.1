Received: from eggs.gnu.org ([2001:4830:134:3::10]:42151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh2i-0002QZ-Qo
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh2h-00041k-ST
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:32:44 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:31:53 +0200
Message-Id: <20170713163219.9024-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/29] vhdx: use QEMU_ALIGN_DOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:VHDX" <qemu-block@nongnu.org>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/vhdx-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 01278f3fc9..ad70706b99 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -884,7 +884,7 @@ static int vhdx_log_write(BlockDriverState *bs, BDRVV=
HDXState *s,
     }
=20
     sector_offset =3D offset % VHDX_LOG_SECTOR_SIZE;
-    file_offset =3D (offset / VHDX_LOG_SECTOR_SIZE) * VHDX_LOG_SECTOR_SI=
ZE;
+    file_offset =3D QEMU_ALIGN_DOWN(offset, VHDX_LOG_SECTOR_SIZE);
=20
     aligned_length =3D length;
=20
--=20
2.13.1.395.gf7b71de06
