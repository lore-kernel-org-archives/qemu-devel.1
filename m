Received: from eggs.gnu.org ([209.51.188.92]:56527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfrH-00059H-B6
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfrG-0008WE-MK
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:15 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Jan 2019 13:18:57 -0600
Message-Id: <20190110191901.5082-4-eblake@redhat.com>
In-Reply-To: <20190110191901.5082-1-eblake@redhat.com>
References: <20190110191901.5082-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/6] Revert "vdi: Use a literal number of
 bytes for DEFAULT_CLUSTER_SIZE"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lbloch@janustech.com, armbru@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>

This reverts commit 3dd5b8f4718c6ca1eadb16dd67a8cad76455ddb0.

Now that we can express QemuOpts values as an integer, we don't have
to be careful about how we spell our macro.
---
 block/vdi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 65659c9b179..180a45b70f6 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -85,7 +85,7 @@
 #define BLOCK_OPT_STATIC "static"

 #define SECTOR_SIZE 512
-#define DEFAULT_CLUSTER_SIZE S_1MiB
+#define DEFAULT_CLUSTER_SIZE (1 * MiB)

 #if defined(CONFIG_VDI_DEBUG)
 #define VDI_DEBUG 1
@@ -432,7 +432,7 @@ static int vdi_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
         goto fail;
     } else if (header.block_size !=3D DEFAULT_CLUSTER_SIZE) {
         error_setg(errp, "unsupported VDI image (block size %" PRIu32
-                         " is not %" PRIu32 ")",
+                         " is not %" PRIu64 ")",
                    header.block_size, DEFAULT_CLUSTER_SIZE);
         ret =3D -ENOTSUP;
         goto fail;
--=20
2.20.1
