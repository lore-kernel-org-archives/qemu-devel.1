Received: from eggs.gnu.org ([209.51.188.92]:52337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJwtK-0005Cg-SU
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJwtK-0003Oi-3i
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:13453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJwtJ-0003O8-Ql
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:34 -0400
From: Zhang Chen <chen.zhang@intel.com >
Date: Fri, 26 Apr 2019 17:07:28 +0800
Message-Id: <20190426090730.2691-2-chen.zhang@intel.com>
In-Reply-To: <20190426090730.2691-1-chen.zhang@intel.com>
References: <20190426090730.2691-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 1/3] migration/colo.c: Remove redundant input
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>, Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

The colo_do_failover no need the input parameter.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 include/migration/colo.h  | 2 +-
 migration/colo-failover.c | 2 +-
 migration/colo.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 99ce17aca7..ddebe0ad27 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -37,7 +37,7 @@ bool migration_incoming_in_colo_state(void);
 COLOMode get_colo_mode(void);
 
 /* failover */
-void colo_do_failover(MigrationState *s);
+void colo_do_failover(void);
 
 void colo_checkpoint_notify(void *opaque);
 #endif
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index 4854a96c92..e9ca0b4774 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -39,7 +39,7 @@ static void colo_failover_bh(void *opaque)
         return;
     }
 
-    colo_do_failover(NULL);
+    colo_do_failover();
 }
 
 void failover_request_active(Error **errp)
diff --git a/migration/colo.c b/migration/colo.c
index 238a6d62c7..8c1644091f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -193,7 +193,7 @@ COLOMode get_colo_mode(void)
     }
 }
 
-void colo_do_failover(MigrationState *s)
+void colo_do_failover(void)
 {
     /* Make sure VM stopped while failover happened. */
     if (!colo_runstate_is_stopped()) {
-- 
2.17.GIT
