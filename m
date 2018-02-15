Received: from eggs.gnu.org ([2001:4830:134:3::10]:51068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxR-0001oK-U8
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxN-0000ws-V0
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:17 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 15 Feb 2018 16:51:40 +0300
Message-Id: <1518702707-7077-3-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/9] nbd: change indenting in nbd.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Prepared indenting for the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index fc50003003..ef1698914b 100644
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
2.11.1
