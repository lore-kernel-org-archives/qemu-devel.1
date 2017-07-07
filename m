Received: from eggs.gnu.org ([2001:4830:134:3::10]:41290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkv-0004gx-GD
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkq-0007cI-Oz
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:22 +0200
Message-Id: <1499447335-6125-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 007/100] vvfat: fix typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index e83b8ba..07a111f 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -403,9 +403,9 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int=
 heads, int secs)
     /* FAT12/FAT16/FAT32 */
     /* DOS uses different types when partition is LBA,
        probably to prevent older versions from using CHS on them */
-    partition->fs_type=3D s->fat_type=3D=3D12 ? 0x1:
-                        s->fat_type=3D=3D16 ? (lba?0xe:0x06):
-                         /*fat_tyoe=3D=3D32*/ (lba?0xc:0x0b);
+    partition->fs_type =3D s->fat_type =3D=3D 12 ? 0x1 :
+                         s->fat_type =3D=3D 16 ? (lba ? 0xe : 0x06) :
+                       /*s->fat_type =3D=3D 32*/ (lba ? 0xc : 0x0b);
=20
     real_mbr->magic[0]=3D0x55; real_mbr->magic[1]=3D0xaa;
 }
@@ -805,7 +805,7 @@ static int read_directory(BDRVVVFATState* s, int mapp=
ing_index)
                 (ROOT_ENTRIES - cur) * sizeof(direntry_t));
     }
=20
-     /* reget the mapping, since s->mapping was possibly realloc()ed */
+    /* re-get the mapping, since s->mapping was possibly realloc()ed */
     mapping =3D array_get(&(s->mapping), mapping_index);
     first_cluster +=3D (s->directory.next - mapping->info.dir.first_dir_=
index)
         * 0x20 / s->cluster_size;
--=20
1.8.3.1
