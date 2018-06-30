Received: from eggs.gnu.org ([2001:4830:134:3::10]:37709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95t-0003yI-KF
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95r-0001ek-Q0
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:49 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95r-0001e7-J0
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:47 -0400
Received: by mail-wm0-x244.google.com with SMTP id z6-v6so3516657wma.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:09:57 +0200
Message-Id: <20180630061040.6018-5-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/47] vdi: Use definitions from "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Message-Id: <20180625124238.25339-3-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/vdi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 1d8ed67..6555cff 100644
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
1.8.3.1
