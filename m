Received: from eggs.gnu.org ([2001:4830:134:3::10]:53435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQpo-0000rJ-EG
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQpn-0007QW-N9
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:41:54 -0300
Message-Id: <20180625124238.25339-3-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 02/46] vdi: Use definitions from
 "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:VDI" <qemu-block@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
---
 block/vdi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 1d8ed67dbf..6555cffb88 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -50,6 +50,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
@@ -83,9 +84,6 @@
 /* Command line option for static images. */
 #define BLOCK_OPT_STATIC "static"
 
-#define KiB     1024
-#define MiB     (KiB * KiB)
-
 #define SECTOR_SIZE 512
 #define DEFAULT_CLUSTER_SIZE (1 * MiB)
 
@@ -434,7 +432,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     } else if (header.block_size != DEFAULT_CLUSTER_SIZE) {
         error_setg(errp, "unsupported VDI image (block size %" PRIu32
-                   " is not %u)", header.block_size, DEFAULT_CLUSTER_SIZE);
+                         " is not %" PRIu64 ")",
+                   header.block_size, DEFAULT_CLUSTER_SIZE);
         ret = -ENOTSUP;
         goto fail;
     } else if (header.disk_size >
-- 
2.18.0
