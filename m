Received: from eggs.gnu.org ([2001:4830:134:3::10]:36617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZOIr-0004h6-2Z
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZOIl-00072b-E6
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:57:25 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 18 Dec 2018 16:57:12 -0600
Message-Id: <20181218225714.284495-2-eblake@redhat.com>
In-Reply-To: <20181218225714.284495-1-eblake@redhat.com>
References: <20181218225714.284495-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] nbd: publish _lookup functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

These functions are used for formatting pretty trace points. We are
going to add some in block/nbd-client, so, let's publish all these
functions at once. Note, that nbd_reply_type_lookup is already
published, and constants, "named" by these functions live in
include/block/nbd.h too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181102151152.288399-3-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h | 5 +++++
 nbd/nbd-internal.h  | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 6a5bfe5d559..65402d33964 100644
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
index eeff78d3c98..f38be9ebaaf 100644
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
2.17.2
