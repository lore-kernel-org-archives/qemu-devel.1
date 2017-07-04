Received: from eggs.gnu.org ([2001:4830:134:3::10]:49253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxu-0000qR-5e
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxt-0001EW-9t
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:38 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:38 +0200
Message-Id: <20170704220346.29244-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 27/35] file-posix: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:raw" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/file-posix.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3927fabf06..adafbbb6a0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1483,7 +1483,8 @@ static int aio_worker(void *arg)
     return ret;
 }
=20
-static int paio_submit_co(BlockDriverState *bs, int fd,
+static int coroutine_fn
+paio_submit_co(BlockDriverState *bs, int fd,
                           int64_t offset, QEMUIOVector *qiov,
                           int bytes, int type)
 {
@@ -1599,7 +1600,8 @@ static void raw_aio_unplug(BlockDriverState *bs)
 #endif
 }
=20
-static BlockAIOCB *raw_aio_flush(BlockDriverState *bs,
+static BlockAIOCB * coroutine_fn
+raw_aio_flush(BlockDriverState *bs,
         BlockCompletionFunc *cb, void *opaque)
 {
     BDRVRawState *s =3D bs->opaque;
@@ -1835,7 +1837,8 @@ static int64_t raw_get_allocated_file_size(BlockDri=
verState *bs)
     return (int64_t)st.st_blocks * 512;
 }
=20
-static int raw_create(const char *filename, QemuOpts *opts, Error **errp=
)
+static int coroutine_fn
+raw_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     int fd;
     int result =3D 0;
@@ -2526,7 +2529,8 @@ hdev_open_Mac_error:
=20
 #if defined(__linux__)
=20
-static BlockAIOCB *hdev_aio_ioctl(BlockDriverState *bs,
+static BlockAIOCB * coroutine_fn
+hdev_aio_ioctl(BlockDriverState *bs,
         unsigned long int req, void *buf,
         BlockCompletionFunc *cb, void *opaque)
 {
@@ -2592,7 +2596,8 @@ static coroutine_fn int hdev_co_pwrite_zeroes(Block=
DriverState *bs,
     return -ENOTSUP;
 }
=20
-static int hdev_create(const char *filename, QemuOpts *opts,
+static int coroutine_fn
+hdev_create(const char *filename, QemuOpts *opts,
                        Error **errp)
 {
     int fd;
--=20
2.13.1.395.gf7b71de06
