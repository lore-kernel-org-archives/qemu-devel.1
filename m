Received: from eggs.gnu.org ([2001:4830:134:3::10]:39654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTtz-0006YW-Ja
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTtv-0007DJ-MB
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:27 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:43985 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwTtv-0007Bp-Al
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:23 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Sep 2017 16:57:58 +0300
Message-Id: <20170925135801.144261-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170925135801.144261-1-vsementsov@virtuozzo.com>
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/8] nbd: header constants indenting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Hmreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Prepare indenting for the following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h | 15 ++++++++-------
 nbd/nbd-internal.h  | 34 +++++++++++++++++-----------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 49008980f4..a6df5ce8b5 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -71,13 +71,14 @@ typedef struct NBDSimpleReply {
 
 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
-#define NBD_FLAG_HAS_FLAGS      (1 << 0)        /* Flags are there */
-#define NBD_FLAG_READ_ONLY      (1 << 1)        /* Device is read-only */
-#define NBD_FLAG_SEND_FLUSH     (1 << 2)        /* Send FLUSH */
-#define NBD_FLAG_SEND_FUA       (1 << 3)        /* Send FUA (Force Unit Access) */
-#define NBD_FLAG_ROTATIONAL     (1 << 4)        /* Use elevator algorithm - rotational media */
-#define NBD_FLAG_SEND_TRIM      (1 << 5)        /* Send TRIM (discard) */
-#define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6)     /* Send WRITE_ZEROES */
+#define NBD_FLAG_HAS_FLAGS         (1 << 0) /* Flags are there */
+#define NBD_FLAG_READ_ONLY         (1 << 1) /* Device is read-only */
+#define NBD_FLAG_SEND_FLUSH        (1 << 2) /* Send FLUSH */
+#define NBD_FLAG_SEND_FUA          (1 << 3) /* Send FUA (Force Unit Access) */
+#define NBD_FLAG_ROTATIONAL        (1 << 4) /* Use elevator algorithm -
+                                               rotational media */
+#define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
+#define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
 
 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 320abef296..d96c9cc7fd 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -46,23 +46,23 @@
 /* Size of oldstyle negotiation */
 #define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)
 
-#define NBD_REQUEST_MAGIC       0x25609513
-#define NBD_SIMPLE_REPLY_MAGIC  0x67446698
-#define NBD_OPTS_MAGIC          0x49484156454F5054LL
-#define NBD_CLIENT_MAGIC        0x0000420281861253LL
-#define NBD_REP_MAGIC           0x0003e889045565a9LL
-
-#define NBD_SET_SOCK            _IO(0xab, 0)
-#define NBD_SET_BLKSIZE         _IO(0xab, 1)
-#define NBD_SET_SIZE            _IO(0xab, 2)
-#define NBD_DO_IT               _IO(0xab, 3)
-#define NBD_CLEAR_SOCK          _IO(0xab, 4)
-#define NBD_CLEAR_QUE           _IO(0xab, 5)
-#define NBD_PRINT_DEBUG         _IO(0xab, 6)
-#define NBD_SET_SIZE_BLOCKS     _IO(0xab, 7)
-#define NBD_DISCONNECT          _IO(0xab, 8)
-#define NBD_SET_TIMEOUT         _IO(0xab, 9)
-#define NBD_SET_FLAGS           _IO(0xab, 10)
+#define NBD_REQUEST_MAGIC           0x25609513
+#define NBD_SIMPLE_REPLY_MAGIC      0x67446698
+#define NBD_OPTS_MAGIC              0x49484156454F5054LL
+#define NBD_CLIENT_MAGIC            0x0000420281861253LL
+#define NBD_REP_MAGIC               0x0003e889045565a9LL
+
+#define NBD_SET_SOCK                _IO(0xab, 0)
+#define NBD_SET_BLKSIZE             _IO(0xab, 1)
+#define NBD_SET_SIZE                _IO(0xab, 2)
+#define NBD_DO_IT                   _IO(0xab, 3)
+#define NBD_CLEAR_SOCK              _IO(0xab, 4)
+#define NBD_CLEAR_QUE               _IO(0xab, 5)
+#define NBD_PRINT_DEBUG             _IO(0xab, 6)
+#define NBD_SET_SIZE_BLOCKS         _IO(0xab, 7)
+#define NBD_DISCONNECT              _IO(0xab, 8)
+#define NBD_SET_TIMEOUT             _IO(0xab, 9)
+#define NBD_SET_FLAGS               _IO(0xab, 10)
 
 /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
  * but only a limited set of errno values is specified in the protocol.
-- 
2.11.1
