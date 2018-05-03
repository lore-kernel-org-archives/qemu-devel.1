Received: from eggs.gnu.org ([2001:4830:134:3::10]:56559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFn-0002T9-8T
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFm-0002QW-BL
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFm-0002QA-6A
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:58 -0400
Date: Thu, 3 May 2018 22:50:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-18-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 17/67] colo: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory. Directory based path works more or less by accident.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/colo-compare.c    | 2 +-
 net/colo.c            | 2 +-
 net/filter-rewriter.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 23b2d2c..c3a2be4 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -25,7 +25,7 @@
 #include "net/queue.h"
 #include "chardev/char-fe.h"
 #include "qemu/sockets.h"
-#include "net/colo.h"
+#include "colo.h"
 #include "sysemu/iothread.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
diff --git a/net/colo.c b/net/colo.c
index 8426265..6dda4ed 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "trace.h"
-#include "net/colo.h"
+#include "colo.h"
 
 uint32_t connection_key_hash(const void *opaque)
 {
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 62dad2d..f584e4e 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "trace.h"
-#include "net/colo.h"
+#include "colo.h"
 #include "net/filter.h"
 #include "net/net.h"
 #include "qemu-common.h"
-- 
MST
