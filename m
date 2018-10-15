Received: from eggs.gnu.org ([2001:4830:134:3::10]:45432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByX3-0004Ei-Ht
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByWz-00047j-SO
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByWt-0003ui-JU
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:12 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:11 +0800
Message-Id: <1539593186-32183-12-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 11/26] qapi/migration.json: Rename COLO unknown
 mode to none mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <chen.zhang@intel.com>

Suggested by Markus Armbruster rename COLO unknown mode to none mode.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 migration/colo-failover.c |  2 +-
 migration/colo.c          |  2 +-
 qapi/migration.json       | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index 0ae0c41..4854a96 100644
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
index bd7390d..2cdd366 100644
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
index 4a18209..0776e0f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -923,18 +923,18 @@
 ##
 # @COLOMode:
 #
-# The colo mode
+# The COLO current mode.
 #
-# @unknown: unknown mode
+# @none: COLO is disabled.
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
2.5.0
