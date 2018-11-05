Received: from eggs.gnu.org ([2001:4830:134:3::10]:51796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhwg-0002tr-U2
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhwX-00049F-3a
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:41:43 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:43 +0100
Message-Id: <20181105163744.25139-36-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/36] vdi: Use a literal number of bytes for
 DEFAULT_CLUSTER_SIZE
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

From: Leonid Bloch <lbloch@janustech.com>

If an expression is used to define DEFAULT_CLUSTER_SIZE, when compiled,
it will be embedded as a literal expression in the binary (as the
default value) because it is stringified to mark the size of the default
value. Now this is fixed by using a defined number to define this value.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vdi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 0ff1ead736..2380daa583 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -85,7 +85,7 @@
 #define BLOCK_OPT_STATIC "static"
=20
 #define SECTOR_SIZE 512
-#define DEFAULT_CLUSTER_SIZE (1 * MiB)
+#define DEFAULT_CLUSTER_SIZE S_1MiB
=20
 #if defined(CONFIG_VDI_DEBUG)
 #define VDI_DEBUG 1
@@ -432,7 +432,7 @@ static int vdi_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
         goto fail;
     } else if (header.block_size !=3D DEFAULT_CLUSTER_SIZE) {
         error_setg(errp, "unsupported VDI image (block size %" PRIu32
-                         " is not %" PRIu64 ")",
+                         " is not %" PRIu32 ")",
                    header.block_size, DEFAULT_CLUSTER_SIZE);
         ret =3D -ENOTSUP;
         goto fail;
--=20
2.19.1
