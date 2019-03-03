Received: from eggs.gnu.org ([209.51.188.92]:49684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h0SiM-0005uk-PV
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 10:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h0SUz-0006Pz-Tu
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:53:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:42887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1h0SUz-00068j-L5
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:53:53 -0500
From: Zhang Chen <chen.zhang@intel.com >
Date: Sun,  3 Mar 2019 22:50:19 +0800
Message-Id: <20190303145021.2962-6-chen.zhang@intel.com>
In-Reply-To: <20190303145021.2962-1-chen.zhang@intel.com>
References: <20190303145021.2962-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH V3 5/7] qapi/migration.json: Remove a variable
 that doesn't exist in example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

Remove the "active" variable in example for query-colo-status.
It is a doc bug from commit f56c0065

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/migration.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 089ed67807..18929f1154 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1342,7 +1342,7 @@
 # Example:
 #
 # -> { "execute": "query-colo-status" }
-# <- { "return": { "mode": "primary", "active": true, "reason": "request" } }
+# <- { "return": { "mode": "primary", "reason": "request" } }
 #
 # Since: 3.1
 ##
-- 
2.17.GIT
