Received: from eggs.gnu.org ([2001:4830:134:3::10]:50132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJht5-0006l8-Cw
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJht3-0002jj-Gr
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:03 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:10 +0100
Message-Id: <20181105163744.25139-3-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/36] block: replace "discard" literal with
 BDRV_OPT_DISCARD macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 95d8635aa1..9d2adf7962 100644
--- a/block.c
+++ b/block.c
@@ -1327,7 +1327,7 @@ QemuOptsList bdrv_runtime_opts =3D {
             .help =3D "try to optimize zero writes (off, on, unmap)",
         },
         {
-            .name =3D "discard",
+            .name =3D BDRV_OPT_DISCARD,
             .type =3D QEMU_OPT_STRING,
             .help =3D "discard operation (ignore/off, unmap/on)",
         },
@@ -1432,7 +1432,7 @@ static int bdrv_open_common(BlockDriverState *bs, B=
lockBackend *file,
         }
     }
=20
-    discard =3D qemu_opt_get(opts, "discard");
+    discard =3D qemu_opt_get(opts, BDRV_OPT_DISCARD);
     if (discard !=3D NULL) {
         if (bdrv_parse_discard_flags(discard, &bs->open_flags) !=3D 0) {
             error_setg(errp, "Invalid discard option");
@@ -3186,7 +3186,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_sta=
te, BlockReopenQueue *queue,
=20
     update_flags_from_options(&reopen_state->flags, opts);
=20
-    discard =3D qemu_opt_get_del(opts, "discard");
+    discard =3D qemu_opt_get_del(opts, BDRV_OPT_DISCARD);
     if (discard !=3D NULL) {
         if (bdrv_parse_discard_flags(discard, &reopen_state->flags) !=3D=
 0) {
             error_setg(errp, "Invalid discard option");
--=20
2.19.1
