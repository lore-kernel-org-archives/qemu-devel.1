Received: from eggs.gnu.org ([209.51.188.92]:37833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3Pt-0004m0-5x
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3P6-0005vu-4Q
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:53:21 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Feb 2019 23:53:00 +0100
Message-Id: <20190213225311.17876-2-mreitz@redhat.com>
In-Reply-To: <20190213225311.17876-1-mreitz@redhat.com>
References: <20190213225311.17876-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/12] block: Mark commit and mirror as
 filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

The commit and mirror block nodes are filters, so they should be marked
as such.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/commit.c | 2 ++
 block/mirror.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index 2b876bf6e9..87d0b208ea 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -254,6 +254,8 @@ static BlockDriver bdrv_commit_top =3D {
     .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_commit_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_commit_top_child_perm,
+
+    .is_filter                  =3D true,
 };
=20
 void commit_start(const char *job_id, BlockDriverState *bs,
diff --git a/block/mirror.c b/block/mirror.c
index 726d3c27fb..c7ca8078d1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1469,6 +1469,8 @@ static BlockDriver bdrv_mirror_top =3D {
     .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_mirror_top_child_perm,
+
+    .is_filter                  =3D true,
 };
=20
 static void mirror_start_job(const char *job_id, BlockDriverState *bs,
--=20
2.20.1
