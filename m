Received: from eggs.gnu.org ([2001:4830:134:3::10]:49410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVyH-0001Cn-Ts
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVyH-0001Vx-5t
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:07:01 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:42 +0200
Message-Id: <20170704220346.29244-32-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 31/35] parallels: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:parallels" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/parallels.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 8be46a7d48..213e42b9d2 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -472,7 +472,8 @@ static int parallels_check(BlockDriverState *bs, Bdrv=
CheckResult *res,
 }
=20
=20
-static int parallels_create(const char *filename, QemuOpts *opts, Error =
**errp)
+static int coroutine_fn
+parallels_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     int64_t total_size, cl_size;
     uint8_t tmp[BDRV_SECTOR_SIZE];
--=20
2.13.1.395.gf7b71de06
