Received: from eggs.gnu.org ([2001:4830:134:3::10]:55090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38a7-0006v4-Bv
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38a6-00050R-AP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38a6-0004zo-40
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BB544E336
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:17 +0200
Message-Id: <20170425220451.6028-8-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 07/41] migration: Move failover.h to
 migration/colo-failover.h
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

This file is internal for migration/colo code.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 MAINTAINERS                                               | 2 +-
 migration/colo-failover.c                                 | 2 +-
 include/migration/failover.h => migration/colo-failover.h | 0
 migration/colo.c                                          | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/migration/failover.h => migration/colo-failover.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3560ba2..7435c9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1536,7 +1536,7 @@ M: zhanghailiang <zhang.zhanghailiang@huawei.com>
 S: Maintained
 F: migration/colo*
 F: migration/colo.h
-F: include/migration/failover.h
+F: migration/colo-failover.h
 F: docs/COLO-FT.txt
 
 COLO Proxy
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index 29b8d63..85c4526 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "colo.h"
-#include "migration/failover.h"
+#include "colo-failover.h"
 #include "qmp-commands.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
diff --git a/include/migration/failover.h b/migration/colo-failover.h
similarity index 100%
rename from include/migration/failover.h
rename to migration/colo-failover.h
diff --git a/migration/colo.c b/migration/colo.c
index fb00310..31ab23f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -20,7 +20,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "migration/failover.h"
+#include "colo-failover.h"
 #include "replication.h"
 #include "qmp-commands.h"
 
-- 
2.9.3
