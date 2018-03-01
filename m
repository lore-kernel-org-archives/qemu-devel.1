Received: from eggs.gnu.org ([2001:4830:134:3::10]:52053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erVM7-0005hm-HH
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 16:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erVM6-00041Z-Du
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 16:03:11 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 15:02:47 -0600
Message-Id: <20180301210249.14872-3-eblake@redhat.com>
In-Reply-To: <20180301210249.14872-1-eblake@redhat.com>
References: <20180301210249.14872-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] nbd: change indenting in nbd.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Prepared indenting for the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1518702707-7077-3-git-send-email-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index fc500030038..ef1698914ba 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -128,21 +128,21 @@ typedef struct NBDStructuredError {
 #define NBD_FLAG_C_NO_ZEROES      (1 << 1) /* End handshake without zeroes. */

 /* Option requests. */
-#define NBD_OPT_EXPORT_NAME      (1)
-#define NBD_OPT_ABORT            (2)
-#define NBD_OPT_LIST             (3)
-/* #define NBD_OPT_PEEK_EXPORT   (4) not in use */
-#define NBD_OPT_STARTTLS         (5)
-#define NBD_OPT_INFO             (6)
-#define NBD_OPT_GO               (7)
-#define NBD_OPT_STRUCTURED_REPLY (8)
+#define NBD_OPT_EXPORT_NAME       (1)
+#define NBD_OPT_ABORT             (2)
+#define NBD_OPT_LIST              (3)
+/* #define NBD_OPT_PEEK_EXPORT    (4) not in use */
+#define NBD_OPT_STARTTLS          (5)
+#define NBD_OPT_INFO              (6)
+#define NBD_OPT_GO                (7)
+#define NBD_OPT_STRUCTURED_REPLY  (8)

 /* Option reply types. */
 #define NBD_REP_ERR(value) ((UINT32_C(1) << 31) | (value))

-#define NBD_REP_ACK             (1)             /* Data sending finished. */
-#define NBD_REP_SERVER          (2)             /* Export description. */
-#define NBD_REP_INFO            (3)             /* NBD_OPT_INFO/GO. */
+#define NBD_REP_ACK             (1)    /* Data sending finished. */
+#define NBD_REP_SERVER          (2)    /* Export description. */
+#define NBD_REP_INFO            (3)    /* NBD_OPT_INFO/GO. */

 #define NBD_REP_ERR_UNSUP           NBD_REP_ERR(1)  /* Unknown option */
 #define NBD_REP_ERR_POLICY          NBD_REP_ERR(2)  /* Server denied */
-- 
2.14.3
