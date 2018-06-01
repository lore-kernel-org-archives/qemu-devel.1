Received: from eggs.gnu.org ([2001:4830:134:3::10]:38919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtg-0002Xc-Vb
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtg-0007V2-3T
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtf-0007Um-Us
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:24 -0400
Date: Fri, 1 Jun 2018 19:27:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-25-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/31] colo: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhang Chen <zhangckid@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

When pulling in headers that are in the same directory as the C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 net/colo-compare.c    | 2 +-
 net/colo.c            | 2 +-
 net/filter-rewriter.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 23b2d2c4cc..c3a2be4c90 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -25,7 +25,7 @@
 #include "net/queue.h"
 #include "chardev/char-fe.h"
 #include "qemu/sockets.h"
-#include "net/colo.h"
+#include "colo.h"
 #include "sysemu/iothread.h"
=20
 #define TYPE_COLO_COMPARE "colo-compare"
diff --git a/net/colo.c b/net/colo.c
index 842626502e..6dda4ed66e 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -14,7 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include "trace.h"
-#include "net/colo.h"
+#include "colo.h"
=20
 uint32_t connection_key_hash(const void *opaque)
 {
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 62dad2d773..f584e4eba4 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -11,7 +11,7 @@
=20
 #include "qemu/osdep.h"
 #include "trace.h"
-#include "net/colo.h"
+#include "colo.h"
 #include "net/filter.h"
 #include "net/net.h"
 #include "qemu-common.h"
--=20
MST
