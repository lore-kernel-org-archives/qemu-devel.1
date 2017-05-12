Received: from eggs.gnu.org ([2001:4830:134:3::10]:48279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D0O-0002Zs-J1
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D0N-00058S-Cr
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d9D0N-00057l-6U
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15FC183F44
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:01:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 12 May 2017 18:00:49 +0200
Message-Id: <20170512160055.9081-7-quintela@redhat.com>
In-Reply-To: <20170512160055.9081-1-quintela@redhat.com>
References: <20170512160055.9081-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 06/12] migration: Move failover.h to
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
index e834876..65cfb05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1538,7 +1538,7 @@ M: zhanghailiang <zhang.zhanghailiang@huawei.com>
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
index a3834e6..4b9a23c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -21,7 +21,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "migration/failover.h"
+#include "colo-failover.h"
 #include "replication.h"
 #include "qmp-commands.h"
 
-- 
2.9.3
