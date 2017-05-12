Received: from eggs.gnu.org ([2001:4830:134:3::10]:48280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D0O-0002Zt-Iz
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D0L-00056w-Hl
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d9D0L-00055s-CQ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E9C5796EB
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:01:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 12 May 2017 18:00:48 +0200
Message-Id: <20170512160055.9081-6-quintela@redhat.com>
In-Reply-To: <20170512160055.9081-1-quintela@redhat.com>
References: <20170512160055.9081-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 05/12] migration: Move colo.h to migration/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

There are functions only used by migration code.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 MAINTAINERS                             | 2 +-
 migration/colo-comm.c                   | 2 +-
 migration/colo-failover.c               | 2 +-
 {include/migration => migration}/colo.h | 0
 migration/migration.c                   | 2 +-
 migration/ram.c                         | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename {include/migration => migration}/colo.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e8d731..e834876 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1537,7 +1537,7 @@ COLO Framework
 M: zhanghailiang <zhang.zhanghailiang@huawei.com>
 S: Maintained
 F: migration/colo*
-F: include/migration/colo.h
+F: migration/colo.h
 F: include/migration/failover.h
 F: docs/COLO-FT.txt
 
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index 3d91798..9b35027 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "migration/migration.h"
-#include "migration/colo.h"
+#include "colo.h"
 #include "trace.h"
 
 typedef struct {
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index cc229f5..29b8d63 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "migration/colo.h"
+#include "colo.h"
 #include "migration/failover.h"
 #include "qmp-commands.h"
 #include "qapi/qmp/qerror.h"
diff --git a/include/migration/colo.h b/migration/colo.h
similarity index 100%
rename from include/migration/colo.h
rename to migration/colo.h
diff --git a/migration/migration.c b/migration/migration.c
index ad5ed14..a5a17fe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -38,7 +38,7 @@
 #include "exec/address-spaces.h"
 #include "io/channel-buffer.h"
 #include "io/channel-tls.h"
-#include "migration/colo.h"
+#include "colo.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
 
diff --git a/migration/ram.c b/migration/ram.c
index 2564c00..7a5f5fa 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -44,7 +44,7 @@
 #include "trace.h"
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
-#include "migration/colo.h"
+#include "colo.h"
 
 /***********************************************************/
 /* ram save/restore */
-- 
2.9.3
