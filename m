Received: from eggs.gnu.org ([2001:4830:134:3::10]:51813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfXkC-0006o9-4H
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfXkB-0008Ll-2c
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:38:20 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  9 Aug 2017 15:38:07 -0500
Message-Id: <20170809203808.31725-5-eblake@redhat.com>
In-Reply-To: <20170809203808.31725-1-eblake@redhat.com>
References: <20170809203808.31725-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/5] qcow2: Drop debugging dump_refcounts()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com, Max Reitz <mreitz@redhat.com>

It's been #if 0'd since its introduction in 2006, commit 585f8587.
We can revive dead code if we need it, but in the meantime, it has
bit-rotted (for example, not checking for failure in bdrv_getlength()).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d7c600b5a2..99407403ea 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3798,27 +3798,6 @@ static ImageInfoSpecific *qcow2_get_specific_info(=
BlockDriverState *bs)
     return spec_info;
 }

-#if 0
-static void dump_refcounts(BlockDriverState *bs)
-{
-    BDRVQcow2State *s =3D bs->opaque;
-    int64_t nb_clusters, k, k1, size;
-    int refcount;
-
-    size =3D bdrv_getlength(bs->file->bs);
-    nb_clusters =3D size_to_clusters(s, size);
-    for(k =3D 0; k < nb_clusters;) {
-        k1 =3D k;
-        refcount =3D get_refcount(bs, k);
-        k++;
-        while (k < nb_clusters && get_refcount(bs, k) =3D=3D refcount)
-            k++;
-        printf("%" PRId64 ": refcount=3D%d nb=3D%" PRId64 "\n", k, refco=
unt,
-               k - k1);
-    }
-}
-#endif
-
 static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
                               int64_t pos)
 {
--=20
2.13.4
