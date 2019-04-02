Received: from eggs.gnu.org ([209.51.188.92]:32771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hBFdq-00029i-GY
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hBFU5-0003zN-9Q
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:13:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:7515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hBFG8-0004cC-Ik
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:59:08 -0400
From: Zhang Chen <chen.zhang@intel.com >
Date: Tue,  2 Apr 2019 16:55:21 +0800
Message-Id: <20190402085521.17973-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH] qapi/migration.json: Clean up for COLOStatus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

Address Markus's comments change the 'last_mode' to 'last-mode'.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 qapi/migration.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index cfde29acf8..9217886c80 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1380,7 +1380,7 @@
 # @mode: COLO running mode. If COLO is running, this field will return
 #        'primary' or 'secondary'.
 #
-# @last_mode: COLO last running mode. If COLO is running, this field
+# @last-mode: COLO last running mode. If COLO is running, this field
 #             will return same like mode field, after failover we can
 #             use this field to get last colo mode. (since 4.1)
 #
@@ -1389,7 +1389,7 @@
 # Since: 3.1
 ##
 { 'struct': 'COLOStatus',
-  'data': { 'mode': 'COLOMode', 'last_mode': 'COLOMode',
+  'data': { 'mode': 'COLOMode', 'last-mode': 'COLOMode',
             'reason': 'COLOExitReason' } }
 
 ##
-- 
2.17.GIT
