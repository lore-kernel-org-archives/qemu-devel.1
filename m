Received: from eggs.gnu.org ([2001:4830:134:3::10]:57138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZm-0001E0-QU
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZk-0002kg-Ek
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 11 Aug 2017 16:05:32 +0200
Message-Id: <20170811140536.2792-4-kwolf@redhat.com>
In-Reply-To: <20170811140536.2792-1-kwolf@redhat.com>
References: <20170811140536.2792-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/7] qcow2: Drop debugging dump_refcounts()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

It's been #if 0'd since its introduction in 2006, commit 585f8587.
We can revive dead code if we need it, but in the meantime, it has
bit-rotted (for example, not checking for failure in bdrv_getlength()).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
=20
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
