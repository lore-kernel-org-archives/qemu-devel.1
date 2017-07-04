Received: from eggs.gnu.org ([2001:4830:134:3::10]:48589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwN-0007qf-Cy
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwK-0000Bb-3I
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:03 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:21 +0200
Message-Id: <20170704220346.29244-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/35] vmdk: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:VMDK" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/vmdk.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 55581b03fe..f8422e8971 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1334,7 +1334,8 @@ static int64_t coroutine_fn vmdk_co_get_block_statu=
s(BlockDriverState *bs,
     return ret;
 }
=20
-static int vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
+static int coroutine_fn
+vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
                             int64_t offset_in_cluster, QEMUIOVector *qio=
v,
                             uint64_t qiov_offset, uint64_t n_bytes,
                             uint64_t offset)
@@ -1406,7 +1407,8 @@ static int vmdk_write_extent(VmdkExtent *extent, in=
t64_t cluster_offset,
     return ret;
 }
=20
-static int vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
+static int coroutine_fn
+vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
                             int64_t offset_in_cluster, QEMUIOVector *qio=
v,
                             int bytes)
 {
@@ -1551,7 +1553,8 @@ fail:
  *
  * Returns: error code with 0 for success.
  */
-static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
+static int coroutine_fn
+vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
                        uint64_t bytes, QEMUIOVector *qiov,
                        bool zeroed, bool zero_dry_run)
 {
@@ -1857,7 +1860,8 @@ static int filename_decompose(const char *filename,=
 char *path, char *prefix,
     return VMDK_OK;
 }
=20
-static int vmdk_create(const char *filename, QemuOpts *opts, Error **err=
p)
+static int coroutine_fn
+vmdk_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     int idx =3D 0;
     BlockBackend *new_blk =3D NULL;
--=20
2.13.1.395.gf7b71de06
