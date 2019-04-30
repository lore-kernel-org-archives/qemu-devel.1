Received: from eggs.gnu.org ([209.51.188.92]:48664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-0007yu-Re
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUum-00023L-Va
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:22 +0200
Message-Id: <20190430154244.30083-6-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/27] block/vhdx: Remove redundant IEC binary
 prefixes definition
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

From: Stefano Garzarella <sgarzare@redhat.com>

IEC binary prefixes are already defined in "qemu/units.h",
so we can remove redundant definitions in "block/vhdx.h".

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.h | 6 +-----
 block/vhdx.c | 3 ++-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/vhdx.h b/block/vhdx.h
index 1bfb4e4f73..bf72090c8f 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -17,11 +17,7 @@
=20
 #ifndef BLOCK_VHDX_H
 #define BLOCK_VHDX_H
-
-#define KiB              (1 * 1024)
-#define MiB            (KiB * 1024)
-#define GiB            (MiB * 1024)
-#define TiB ((uint64_t) GiB * 1024)
+#include "qemu/units.h"
=20
 #define DEFAULT_LOG_SIZE 1048576 /* 1MiB */
 /* Structures and fields present in the VHDX file */
diff --git a/block/vhdx.c b/block/vhdx.c
index b785aef4b7..7cd1fc3731 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1889,7 +1889,8 @@ static int coroutine_fn vhdx_co_create(BlockdevCrea=
teOptions *opts,
         return -EINVAL;
     }
     if (block_size > VHDX_BLOCK_SIZE_MAX) {
-        error_setg(errp, "Block size must not exceed %d", VHDX_BLOCK_SIZ=
E_MAX);
+        error_setg(errp, "Block size must not exceed %" PRId64,
+                   VHDX_BLOCK_SIZE_MAX);
         return -EINVAL;
     }
=20
--=20
2.20.1
