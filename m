Received: from eggs.gnu.org ([209.51.188.92]:57472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54O-0003jE-NQ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54K-0005H9-3V
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:32 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:47 -0600
Message-Id: <20190114162605.5330-3-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/20] block/dirty-bitmap: remove assertion from
 restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Dirty Bitmaps" <qemu-block@nongnu.org>

From: John Snow <jsnow@redhat.com>

When making a backup of a dirty bitmap (for transactions), we want to
restore that backup whether or not the bitmap is enabled.

It is perfectly valid to write into bitmaps that are disabled. It is
only illegitimate for the guest to have done so.

Remove this assertion.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20181221093529.23855-3-jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/dirty-bitmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 89fd1d7f8ba..6b688394e4e 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -625,7 +625,6 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap,=
 HBitmap **out)
 void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup)
 {
     HBitmap *tmp =3D bitmap->bitmap;
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
     bitmap->bitmap =3D backup;
     hbitmap_free(tmp);
--=20
2.20.1
