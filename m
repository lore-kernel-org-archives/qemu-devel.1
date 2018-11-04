Received: from eggs.gnu.org ([2001:4830:134:3::10]:40992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gJMqL-0007C9-3r
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 13:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gJMqE-0004gA-3m
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 13:09:44 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Sun, 4 Nov 2018 18:09:28 +0000
Message-ID: <20181104180900.7527-2-lbloch@janustech.com>
References: <20181104180900.7527-1-lbloch@janustech.com>
In-Reply-To: <20181104180900.7527-1-lbloch@janustech.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 1/1] vdi: Use a literal number of bytes for
 DEFAULT_CLUSTER_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Leonid Bloch <lbloch@janustech.com>

If an expression is used to define DEFAULT_CLUSTER_SIZE, when compiled,
it will be embedded as a literal expression in the binary (as the
default value) because it is stringified to mark the size of the default
value. Now this is fixed by using a defined number to define this value.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/vdi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 6555cffb88..d996793f1c 100644
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
@@ -432,7 +432,7 @@ static int vdi_open(BlockDriverState *bs, QDict *option=
s, int flags,
         goto fail;
     } else if (header.block_size !=3D DEFAULT_CLUSTER_SIZE) {
         error_setg(errp, "unsupported VDI image (block size %" PRIu32
-                         " is not %" PRIu64 ")",
+                         " is not %" PRIu32 ")",
                    header.block_size, DEFAULT_CLUSTER_SIZE);
         ret =3D -ENOTSUP;
         goto fail;
--=20
2.17.1
