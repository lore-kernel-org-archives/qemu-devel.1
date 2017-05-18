Received: from eggs.gnu.org ([2001:4830:134:3::10]:35376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBO7v-00049q-QC
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBO7u-0007D8-HT
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:18:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBO7u-0007Co-A3
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:18:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 061E7303150
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:18:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 18:16:54 +0200
Message-Id: <20170518161655.30311-9-quintela@redhat.com>
In-Reply-To: <20170518161655.30311-1-quintela@redhat.com>
References: <20170518161655.30311-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 8/9] migration: Remove vmstate.h from
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---

Minor rearrangements due to rebase
---
 include/migration/migration.h | 1 -
 migration/block.c             | 1 +
 migration/colo-comm.c         | 1 +
 migration/migration.c         | 1 +
 migration/ram.c               | 1 +
 5 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/migration/migration.h b/include/migration/migration.=
h
index 8280df1..0e807b6 100644
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
index 5baf46d..13f90d3 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -27,6 +27,7 @@
 #include "migration/migration.h"
 #include "sysemu/blockdev.h"
 #include "migration/qemu-file.h"
+#include "migration/vmstate.h"
 #include "sysemu/block-backend.h"
=20
 #define BLOCK_SIZE                       (1 << 20)
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index 3d91798..8bfdf68 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "migration/migration.h"
 #include "migration/colo.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 typedef struct {
diff --git a/migration/migration.c b/migration/migration.c
index 2d9379c..9fe474b 100644
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
index 8ce8c07..c07a9c0 100644
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
--=20
2.9.3
