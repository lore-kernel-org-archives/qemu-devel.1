Received: from eggs.gnu.org ([2001:4830:134:3::10]:49472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVyP-0001Jz-94
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVyO-0001YW-G1
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:07:09 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:44 +0200
Message-Id: <20170704220346.29244-34-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 33/35] vdi: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:VDI" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/vdi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/vdi.c b/block/vdi.c
index 79af47763b..53cd7f64d8 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -716,7 +716,8 @@ vdi_co_pwritev(BlockDriverState *bs, uint64_t offset,=
 uint64_t bytes,
     return ret;
 }
=20
-static int vdi_create(const char *filename, QemuOpts *opts, Error **errp=
)
+static int coroutine_fn
+vdi_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     int ret =3D 0;
     uint64_t bytes =3D 0;
--=20
2.13.1.395.gf7b71de06
