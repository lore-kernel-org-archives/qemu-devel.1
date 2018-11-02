Received: from eggs.gnu.org ([2001:4830:134:3::10]:32859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIb7C-0004b5-Tf
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIb78-0003JS-6z
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:12:02 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  2 Nov 2018 18:11:51 +0300
Message-Id: <20181102151152.288399-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181102151152.288399-1-vsementsov@virtuozzo.com>
References: <20181102151152.288399-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/3] nbd: publish _lookup functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

These functions are used for formatting pretty trace points. We are
going to add some in block/nbd-client, so, let's publish all these
functions at once. Note, that nbd_reply_type_lookup is already
published, and constants, "named" by these functions live in
include/block/nbd.h too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h | 5 +++++
 nbd/nbd-internal.h  | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 6a5bfe5d55..65402d3396 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -343,5 +343,10 @@ static inline bool nbd_reply_is_structured(NBDReply *reply)
 }
 
 const char *nbd_reply_type_lookup(uint16_t type);
+const char *nbd_opt_lookup(uint32_t opt);
+const char *nbd_rep_lookup(uint32_t rep);
+const char *nbd_info_lookup(uint16_t info);
+const char *nbd_cmd_lookup(uint16_t info);
+const char *nbd_err_lookup(int err);
 
 #endif
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index eeff78d3c9..f38be9ebaa 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -100,11 +100,6 @@ struct NBDTLSHandshakeData {
 
 void nbd_tls_handshake(QIOTask *task,
                        void *opaque);
-const char *nbd_opt_lookup(uint32_t opt);
-const char *nbd_rep_lookup(uint32_t rep);
-const char *nbd_info_lookup(uint16_t info);
-const char *nbd_cmd_lookup(uint16_t info);
-const char *nbd_err_lookup(int err);
 
 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
 
-- 
2.18.0
