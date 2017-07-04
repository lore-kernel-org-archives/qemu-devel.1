Received: from eggs.gnu.org ([2001:4830:134:3::10]:49064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxV-0000Uh-6X
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxU-0000wA-DB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:13 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:34 +0200
Message-Id: <20170704220346.29244-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 23/35] ssh: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:SSH" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/ssh.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 52964416da..03a8ebe6f7 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -813,7 +813,8 @@ static QemuOptsList ssh_create_opts =3D {
     }
 };
=20
-static int ssh_create(const char *filename, QemuOpts *opts, Error **errp=
)
+static int coroutine_fn
+ssh_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     int r, ret;
     int64_t total_size =3D 0;
@@ -1029,7 +1030,8 @@ static coroutine_fn int ssh_co_readv(BlockDriverSta=
te *bs,
     return ret;
 }
=20
-static int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
+static int coroutine_fn
+ssh_write(BDRVSSHState *s, BlockDriverState *bs,
                      int64_t offset, size_t size,
                      QEMUIOVector *qiov)
 {
--=20
2.13.1.395.gf7b71de06
