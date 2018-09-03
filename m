Received: from eggs.gnu.org ([2001:4830:134:3::10]:56313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwgfx-00007K-5t
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwgfw-00057I-Cq
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:41:21 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fwgfw-00056f-6n
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:41:20 -0400
Received: by mail-pg1-x541.google.com with SMTP id f4-v6so2727088pgq.5
	for <qemu-devel@nongnu.org>; Sun, 02 Sep 2018 21:41:20 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon,  3 Sep 2018 12:38:52 +0800
Message-Id: <20180903043900.28592-12-zhangckid@gmail.com>
In-Reply-To: <20180903043900.28592-1-zhangckid@gmail.com>
References: <20180903043900.28592-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V12 11/19] qapi/migration.json: Rename COLO
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

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
index 761fbb9f78..9107ac124a 100644
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
index 9b3b1c0c4e..c0bc77fd8d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -899,18 +899,18 @@
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
2.17.GIT
