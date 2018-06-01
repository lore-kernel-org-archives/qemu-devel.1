Received: from eggs.gnu.org ([2001:4830:134:3::10]:38683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtN-0002Dk-OS
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtI-0007Df-Lh
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:05 -0400
Date: Fri, 1 Jun 2018 19:26:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-10-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/31] block: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org

When pulling in headers that are in the same directory as the C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 block/crypto.c         | 2 +-
 block/nbd.c            | 2 +-
 block/qcow.c           | 2 +-
 block/qcow2-bitmap.c   | 2 +-
 block/qcow2-cluster.c  | 2 +-
 block/qcow2-refcount.c | 2 +-
 block/qcow2-snapshot.c | 2 +-
 block/qcow2.c          | 4 ++--
 block/vhdx-endian.c    | 2 +-
 block/vhdx-log.c       | 2 +-
 block/vhdx.c           | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 7e7ad2d2a6..bc322b50f5 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -29,7 +29,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
 #include "qemu/option.h"
-#include "block/crypto.h"
+#include "crypto.h"
=20
 typedef struct BlockCrypto BlockCrypto;
=20
diff --git a/block/nbd.c b/block/nbd.c
index 3e1693cc55..ff8333e3c1 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -27,7 +27,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "block/nbd-client.h"
+#include "nbd-client.h"
 #include "qapi/error.h"
 #include "qemu/uri.h"
 #include "block/block_int.h"
diff --git a/block/qcow.c b/block/qcow.c
index 3ba2ca25ea..1f866af0d3 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -37,7 +37,7 @@
 #include "qapi/qapi-visit-block-core.h"
 #include "crypto/block.h"
 #include "migration/blocker.h"
-#include "block/crypto.h"
+#include "crypto.h"
=20
 /**************************************************************/
 /* QEMU COW block driver with compression and encryption support */
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 6e93ec43e1..60d5290f10 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -30,7 +30,7 @@
 #include "qemu/cutils.h"
=20
 #include "block/block_int.h"
-#include "block/qcow2.h"
+#include "qcow2.h"
=20
 /* NOTICE: BME here means Bitmaps Extension and used as a namespace for
  * _internal_ constants. Please do not use this _internal_ abbreviation =
for
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1aee726c6a..0d74584c9b 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "block/block_int.h"
-#include "block/qcow2.h"
+#include "qcow2.h"
 #include "qemu/bswap.h"
 #include "trace.h"
=20
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 2dc23005b7..403236256b 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "block/block_int.h"
-#include "block/qcow2.h"
+#include "qcow2.h"
 #include "qemu/range.h"
 #include "qemu/bswap.h"
 #include "qemu/cutils.h"
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 74293be470..bb6a5b7516 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
-#include "block/qcow2.h"
+#include "qcow2.h"
 #include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index 6d532470a8..db13109744 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -27,7 +27,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include <zlib.h>
-#include "block/qcow2.h"
+#include "qcow2.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block-core.h"
@@ -39,7 +39,7 @@
 #include "qemu/bswap.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "block/crypto.h"
+#include "crypto.h"
=20
 /*
   Differences with QCOW:
diff --git a/block/vhdx-endian.c b/block/vhdx-endian.c
index 429d7556bd..41fbdd2b8f 100644
--- a/block/vhdx-endian.c
+++ b/block/vhdx-endian.c
@@ -19,7 +19,7 @@
 #include "qemu-common.h"
 #include "block/block_int.h"
 #include "qemu/bswap.h"
-#include "block/vhdx.h"
+#include "vhdx.h"
=20
 /*
  * All the VHDX formats on disk are little endian - the following
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 0ac4863b25..d2f1b98199 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -24,7 +24,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/bswap.h"
-#include "block/vhdx.h"
+#include "vhdx.h"
=20
=20
 typedef struct VHDXLogSequence {
diff --git a/block/vhdx.c b/block/vhdx.c
index 0b1e21c750..79c68a2061 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -23,7 +23,7 @@
 #include "qemu/option.h"
 #include "qemu/crc32c.h"
 #include "qemu/bswap.h"
-#include "block/vhdx.h"
+#include "vhdx.h"
 #include "migration/blocker.h"
 #include "qemu/uuid.h"
 #include "qapi/qmp/qdict.h"
--=20
MST
