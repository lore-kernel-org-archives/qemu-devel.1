Received: from eggs.gnu.org ([2001:4830:134:3::10]:35006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeO-0001ON-0y
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeN-0003XW-4R
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:27 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 15 May 2017 22:31:03 +0200
Message-Id: <20170515203114.9477-4-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-1-hpoussin@reactos.org>
References: <20170515203114.9477-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/13] vvfat: fix typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 002bd86e42..57f2489689 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -404,9 +404,9 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int=
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
@@ -806,7 +806,7 @@ static int read_directory(BDRVVVFATState* s, int mapp=
ing_index)
                 (ROOT_ENTRIES - cur) * sizeof(direntry_t));
     }
=20
-     /* reget the mapping, since s->mapping was possibly realloc()ed */
+    /* reset the mapping, since s->mapping was possibly realloc()ed */
     mapping =3D array_get(&(s->mapping), mapping_index);
     first_cluster +=3D (s->directory.next - mapping->info.dir.first_dir_=
index)
         * 0x20 / s->cluster_size;
--=20
2.11.0
