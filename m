Received: from eggs.gnu.org ([2001:4830:134:3::10]:41192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1g83aZ-00035Y-8L
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1g83VA-0001Xs-UT
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:17:18 -0400
Received: from relay.sw.ru ([185.231.240.75]:45784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1g83VA-0001XT-MJ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:17:12 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Thu,  4 Oct 2018 16:17:39 +0300
Message-Id: <20181004131739.11053-1-den@openvz.org>
In-Reply-To: <558261af-914a-1ea4-ef21-c7654a50284e@virtuozzo.com>
References: <558261af-914a-1ea4-ef21-c7654a50284e@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] nbd: add all possible transmission flags
 supported by NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is done to avoid silly mistakes like one with wrong value of
NBD_FLAG_SEND_CACHE flag.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Eric Blake <eblake@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/nbd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4377fa502c..ea8e792de0 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -135,6 +135,9 @@ typedef struct NBDExtent {
 #define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
 #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
 #define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment) */
+#define NBD_FLAG_CAN_MULTI_CONN    (1 << 8) /* Shared cache over multiple
+                                               connections per export */
+#define NBD_FLAG_SEND_RESIZE       (1 << 9)  /* Support RESIZE extension */
 #define NBD_FLAG_SEND_CACHE        (1 << 10) /* Send CACHE (prefetch) */
 
 /* New-style handshake (global) flags, sent from server to client, and
-- 
2.17.1
