Received: from eggs.gnu.org ([2001:4830:134:3::10]:49044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxT-0000Se-0r
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxS-0000v8-5G
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:10 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:33 +0200
Message-Id: <20170704220346.29244-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/35] sheepdog: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Sheepdog" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/sheepdog.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 83bc43dde4..64ff275db9 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -481,7 +481,8 @@ static inline AIOReq *alloc_aio_req(BDRVSheepdogState=
 *s, SheepdogAIOCB *acb,
     return aio_req;
 }
=20
-static void wait_for_overlapping_aiocb(BDRVSheepdogState *s, SheepdogAIO=
CB *acb)
+static void coroutine_fn
+wait_for_overlapping_aiocb(BDRVSheepdogState *s, SheepdogAIOCB *acb)
 {
     SheepdogAIOCB *cb;
=20
@@ -494,7 +495,8 @@ retry:
     }
 }
=20
-static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
+static void coroutine_fn
+sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
                          QEMUIOVector *qiov, int64_t sector_num, int nb_=
sectors,
                          int type)
 {
@@ -1954,7 +1956,8 @@ static int parse_block_size_shift(BDRVSheepdogState=
 *s, QemuOpts *opt)
     return 0;
 }
=20
-static int sd_create(const char *filename, QemuOpts *opts,
+static int coroutine_fn
+sd_create(const char *filename, QemuOpts *opts,
                      Error **errp)
 {
     Error *err =3D NULL;
@@ -2431,7 +2434,8 @@ static void coroutine_fn sd_co_rw_vector(SheepdogAI=
OCB *acb)
     }
 }
=20
-static void sd_aio_complete(SheepdogAIOCB *acb)
+static void coroutine_fn
+sd_aio_complete(SheepdogAIOCB *acb)
 {
     if (acb->aiocb_type =3D=3D AIOCB_FLUSH_CACHE) {
         return;
@@ -2905,7 +2909,8 @@ cleanup:
     return ret;
 }
=20
-static int sd_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
+static int coroutine_fn
+sd_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
                            int64_t pos)
 {
     BDRVSheepdogState *s =3D bs->opaque;
@@ -2920,7 +2925,8 @@ static int sd_save_vmstate(BlockDriverState *bs, QE=
MUIOVector *qiov,
     return ret;
 }
=20
-static int sd_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
+static int coroutine_fn
+sd_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
                            int64_t pos)
 {
     BDRVSheepdogState *s =3D bs->opaque;
--=20
2.13.1.395.gf7b71de06
