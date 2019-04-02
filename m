Received: from eggs.gnu.org ([209.51.188.92]:34485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJ2S-0005RN-Av
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJ2R-0001Gk-8Q
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBJ2R-0001EJ-0O
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:15 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 15:01:06 +0200
Message-Id: <20190402130112.15142-3-armbru@redhat.com>
In-Reply-To: <20190402130112.15142-1-armbru@redhat.com>
References: <20190402130112.15142-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] qapi/migration.json: Fix ColoStatus member
 last_mode's version
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
Message-Id: <20190326174510.13303-1-chen.zhang@intel.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[Commit message tweaked as per Eric's review]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index cfde29acf8..798c6ac2df 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1382,7 +1382,7 @@
 #
 # @last_mode: COLO last running mode. If COLO is running, this field
 #             will return same like mode field, after failover we can
-#             use this field to get last colo mode. (since 4.1)
+#             use this field to get last colo mode. (since 4.0)
 #
 # @reason: describes the reason for the COLO exit.
 #
-- 
2.17.2
