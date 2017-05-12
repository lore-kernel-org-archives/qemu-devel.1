Received: from eggs.gnu.org ([2001:4830:134:3::10]:48442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D0h-0002rx-Ee
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D0e-0005Lu-8w
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d9D0e-0005LI-3w
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E86F635E2
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:01:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 12 May 2017 18:00:54 +0200
Message-Id: <20170512160055.9081-12-quintela@redhat.com>
In-Reply-To: <20170512160055.9081-1-quintela@redhat.com>
References: <20170512160055.9081-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 11/12] migration: Remove vmstate.h from
 migration.h
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

Minor rearrangements due to rebase
---
 include/migration/migration.h | 1 -
 migration/block.c             | 1 +
 migration/colo-comm.c         | 1 +
 migration/migration.c         | 1 +
 migration/ram.c               | 1 +
 5 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5ae21e6..a564ecd 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -18,7 +18,6 @@
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/notify.h"
-#include "migration/vmstate.h"
 #include "io/channel.h"
 #include "qapi-types.h"
 #include "exec/cpu-common.h"
diff --git a/migration/block.c b/migration/block.c
index d2923b3..c919787 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -27,6 +27,7 @@
 #include "migration/migration.h"
 #include "sysemu/blockdev.h"
 #include "migration/qemu-file.h"
+#include "migration/vmstate.h"
 #include "sysemu/block-backend.h"
 
 #define BLOCK_SIZE                       (1 << 20)
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index 9b35027..b4288b8 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "migration/migration.h"
+#include "migration/vmstate.h"
 #include "colo.h"
 #include "trace.h"
 
diff --git a/migration/migration.c b/migration/migration.c
index a5a17fe..7ac09f0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -21,6 +21,7 @@
 #include "migration/migration.h"
 #include "qemu-file-channel.h"
 #include "migration/qemu-file.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "block/block.h"
 #include "qapi/qmp/qerror.h"
diff --git a/migration/ram.c b/migration/ram.c
index ce5019b..abd97d9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -38,6 +38,7 @@
 #include "xbzrle.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
+#include "migration/vmstate.h"
 #include "postcopy-ram.h"
 #include "exec/address-spaces.h"
 #include "migration/page_cache.h"
-- 
2.9.3
