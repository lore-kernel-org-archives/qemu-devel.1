Received: from eggs.gnu.org ([2001:4830:134:3::10]:48397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D0d-0002og-M5
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D0c-0005Kf-N4
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d9D0c-0005Ju-Dy
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53F0C448D67
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:01:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 12 May 2017 18:00:53 +0200
Message-Id: <20170512160055.9081-11-quintela@redhat.com>
In-Reply-To: <20170512160055.9081-1-quintela@redhat.com>
References: <20170512160055.9081-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 10/12] migration: Remove qemu-file.h from
 vmstate.h
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

minor rearangements due to the rebase
---
 include/hw/hw.h             | 1 +
 include/migration/vmstate.h | 3 ---
 migration/block.c           | 1 +
 migration/colo.c            | 1 +
 migration/postcopy-ram.c    | 1 +
 migration/ram.c             | 1 +
 tests/test-vmstate.c        | 1 +
 7 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/hw/hw.h b/include/hw/hw.h
index e22d4ce..af9eae1 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -11,6 +11,7 @@
 #include "exec/memory.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "migration/qemu-file.h"
 #include "qemu/module.h"
 #include "sysemu/reset.h"
 
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index dacb052..f97411d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -27,9 +27,6 @@
 #ifndef QEMU_VMSTATE_H
 #define QEMU_VMSTATE_H
 
-#ifndef CONFIG_USER_ONLY
-#include "migration/qemu-file.h"
-#endif
 #include "migration/qjson.h"
 
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
diff --git a/migration/block.c b/migration/block.c
index fcfa823..d2923b3 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -26,6 +26,7 @@
 #include "migration/block.h"
 #include "migration/migration.h"
 #include "sysemu/blockdev.h"
+#include "migration/qemu-file.h"
 #include "sysemu/block-backend.h"
 
 #define BLOCK_SIZE                       (1 << 20)
diff --git a/migration/colo.c b/migration/colo.c
index 4b9a23c..95f5b6e2 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -15,6 +15,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu-file-channel.h"
 #include "migration/migration.h"
+#include "migration/qemu-file.h"
 #include "migration/colo.h"
 #include "migration/block.h"
 #include "io/channel-buffer.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index cdadaf6..019e031 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -20,6 +20,7 @@
 
 #include "qemu-common.h"
 #include "migration/migration.h"
+#include "migration/qemu-file.h"
 #include "postcopy-ram.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
diff --git a/migration/ram.c b/migration/ram.c
index 7a5f5fa..ce5019b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -37,6 +37,7 @@
 #include "qemu/main-loop.h"
 #include "xbzrle.h"
 #include "migration/migration.h"
+#include "migration/qemu-file.h"
 #include "postcopy-ram.h"
 #include "exec/address-spaces.h"
 #include "migration/page_cache.h"
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 1c13570..25389bc 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -27,6 +27,7 @@
 #include "qemu-common.h"
 #include "migration/migration.h"
 #include "migration/vmstate.h"
+#include "migration/qemu-file.h"
 #include "../migration/qemu-file-channel.h"
 #include "qemu/coroutine.h"
 #include "io/channel-file.h"
-- 
2.9.3
