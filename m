Received: from eggs.gnu.org ([2001:4830:134:3::10]:49184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxm-0000ix-3k
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxl-00018F-At
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:37 +0200
Message-Id: <20170704220346.29244-27-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 26/35] iscsi: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/iscsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 54067e2620..e16311cb4a 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1005,7 +1005,8 @@ static void iscsi_ioctl_handle_emulated(IscsiAIOCB =
*acb, int req, void *buf)
     qemu_bh_schedule(acb->bh);
 }
=20
-static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
+static BlockAIOCB * coroutine_fn
+iscsi_aio_ioctl(BlockDriverState *bs,
         unsigned long int req, void *buf,
         BlockCompletionFunc *cb, void *opaque)
 {
@@ -2107,7 +2108,8 @@ static int iscsi_truncate(BlockDriverState *bs, int=
64_t offset, Error **errp)
     return 0;
 }
=20
-static int iscsi_create(const char *filename, QemuOpts *opts, Error **er=
rp)
+static int coroutine_fn
+iscsi_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     int ret =3D 0;
     int64_t total_size =3D 0;
--=20
2.13.1.395.gf7b71de06
