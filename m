Received: from eggs.gnu.org ([209.51.188.92]:34605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJ2c-0005dr-Da
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJ2W-0001PE-QA
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBJ2V-0001NJ-TP
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 15:01:07 +0200
Message-Id: <20190402130112.15142-4-armbru@redhat.com>
In-Reply-To: <20190402130112.15142-1-armbru@redhat.com>
References: <20190402130112.15142-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] qapi/migration.json: Rename COLOStatus
 last_mode to last-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Message-Id: <20190402085521.17973-1-chen.zhang@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message rephrased]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 798c6ac2df..9cfbaf8c6c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1380,7 +1380,7 @@
 # @mode: COLO running mode. If COLO is running, this field will return
 #        'primary' or 'secondary'.
 #
-# @last_mode: COLO last running mode. If COLO is running, this field
+# @last-mode: COLO last running mode. If COLO is running, this field
 #             will return same like mode field, after failover we can
 #             use this field to get last colo mode. (since 4.0)
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
2.17.2
