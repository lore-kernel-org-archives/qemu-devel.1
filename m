Received: from eggs.gnu.org ([2001:4830:134:3::10]:55085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38a7-0006v3-0m
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38a2-0004sq-Uf
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38a2-0004rA-PK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC8243D97B
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:15 +0200
Message-Id: <20170425220451.6028-6-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 05/41] migration: Remove migration.h from colo.h
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

migration.h is not included in any includes now.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/colo.h | 1 -
 migration/colo-comm.c    | 3 ++-
 migration/colo.c         | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 2bbff9e..ba0bb6e 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -14,7 +14,6 @@
 #define QEMU_COLO_H
 
 #include "qemu-common.h"
-#include "migration/migration.h"
 #include "qemu/coroutine_int.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index 20b60ec..3d91798 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -12,7 +12,8 @@
  */
 
 #include "qemu/osdep.h"
-#include <migration/colo.h>
+#include "migration/migration.h"
+#include "migration/colo.h"
 #include "trace.h"
 
 typedef struct {
diff --git a/migration/colo.c b/migration/colo.c
index cd9e767..fb00310 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -14,6 +14,7 @@
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qemu-file-channel.h"
+#include "migration/migration.h"
 #include "migration/colo.h"
 #include "io/channel-buffer.h"
 #include "trace.h"
-- 
2.9.3
