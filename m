Received: from eggs.gnu.org ([2001:4830:134:3::10]:49116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxd-0000bU-QJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxc-00014Z-T9
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:21 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:35 +0200
Message-Id: <20170704220346.29244-25-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 24/35] null: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Null Block Driver" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/null.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/null.c b/block/null.c
index 876f90965b..4c8afe16d7 100644
--- a/block/null.c
+++ b/block/null.c
@@ -167,7 +167,8 @@ static inline BlockAIOCB *null_aio_common(BlockDriver=
State *bs,
     return &acb->common;
 }
=20
-static BlockAIOCB *null_aio_readv(BlockDriverState *bs,
+static BlockAIOCB * coroutine_fn
+null_aio_readv(BlockDriverState *bs,
                                   int64_t sector_num, QEMUIOVector *qiov=
,
                                   int nb_sectors,
                                   BlockCompletionFunc *cb,
@@ -182,7 +183,8 @@ static BlockAIOCB *null_aio_readv(BlockDriverState *b=
s,
     return null_aio_common(bs, cb, opaque);
 }
=20
-static BlockAIOCB *null_aio_writev(BlockDriverState *bs,
+static BlockAIOCB * coroutine_fn
+null_aio_writev(BlockDriverState *bs,
                                    int64_t sector_num, QEMUIOVector *qio=
v,
                                    int nb_sectors,
                                    BlockCompletionFunc *cb,
@@ -191,7 +193,8 @@ static BlockAIOCB *null_aio_writev(BlockDriverState *=
bs,
     return null_aio_common(bs, cb, opaque);
 }
=20
-static BlockAIOCB *null_aio_flush(BlockDriverState *bs,
+static BlockAIOCB * coroutine_fn
+null_aio_flush(BlockDriverState *bs,
                                   BlockCompletionFunc *cb,
                                   void *opaque)
 {
--=20
2.13.1.395.gf7b71de06
