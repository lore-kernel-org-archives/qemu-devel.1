Received: from eggs.gnu.org ([2001:4830:134:3::10]:49725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fYHH5-0004AB-Dz
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fYHH4-0006V1-AV
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:42:47 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fYHH4-0006UE-3e
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:42:46 -0400
Received: by mail-pg0-x244.google.com with SMTP id m5-v6so1430318pgd.3
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:42:45 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 28 Jun 2018 04:41:27 +0800
Message-Id: <20180627204136.4177-12-zhangckid@gmail.com>
In-Reply-To: <20180627204136.4177-1-zhangckid@gmail.com>
References: <20180627204136.4177-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V9 11/20] qapi/migration.json: Rename COLO
 unknown mode to none mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

Suggested by Markus Armbruster rename COLO unknown mode to none mode.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 migration/colo-failover.c |  2 +-
 migration/colo.c          |  2 +-
 qapi/migration.json       | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index 0ae0c41221..4854a96c92 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -77,7 +77,7 @@ FailoverStatus failover_get_state(void)
 
 void qmp_x_colo_lost_heartbeat(Error **errp)
 {
-    if (get_colo_mode() == COLO_MODE_UNKNOWN) {
+    if (get_colo_mode() == COLO_MODE_NONE) {
         error_setg(errp, QERR_FEATURE_DISABLED, "colo");
         return;
     }
diff --git a/migration/colo.c b/migration/colo.c
index ab484ad754..8fdb79ac73 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -160,7 +160,7 @@ COLOMode get_colo_mode(void)
     } else if (migration_incoming_in_colo_state()) {
         return COLO_MODE_SECONDARY;
     } else {
-        return COLO_MODE_UNKNOWN;
+        return COLO_MODE_NONE;
     }
 }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index d8c3b2e443..c24f114104 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -864,18 +864,18 @@
 ##
 # @COLOMode:
 #
-# The colo mode
+# The COLO current mode.
 #
-# @unknown: unknown mode
+# @none: None mode.
 #
-# @primary: master side
+# @primary: COLO node in primary side.
 #
-# @secondary: slave side
+# @secondary: COLO node in slave side.
 #
 # Since: 2.8
 ##
 { 'enum': 'COLOMode',
-  'data': [ 'unknown', 'primary', 'secondary'] }
+  'data': [ 'none', 'primary', 'secondary'] }
 
 ##
 # @FailoverStatus:
-- 
2.17.GIT
