Received: from eggs.gnu.org ([209.51.188.92]:56976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzP1C-0005Nm-K9
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzP1B-0007Ky-6a
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:63409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1gzP1A-0007Dq-Px
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:45 -0500
From: Zhang Chen <chen.zhang@intel.com >
Date: Fri,  1 Mar 2019 00:55:06 +0800
Message-Id: <20190228165508.21594-6-chen.zhang@intel.com>
In-Reply-To: <20190228165508.21594-1-chen.zhang@intel.com>
References: <20190228165508.21594-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH V2 5/7] qapi/migration.json: Remove a variable
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

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 qapi/migration.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 48e21880a3..f4c1762dfc 100644
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
