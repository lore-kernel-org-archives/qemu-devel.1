Received: from eggs.gnu.org ([209.51.188.92]:49740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hB7Kw-0008VZ-3n
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 20:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hB7Ku-0000Mx-2P
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 20:31:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:43069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hB7Kr-0000Fy-DP
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 20:31:31 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue,  2 Apr 2019 08:31:06 +0800
Message-Id: <20190402003106.17614-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] migration: remove unused field bytes_xfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

MigrationState->bytes_xfer is only set to 0 in migrate_init().

Remove this unnecessary field.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/migration.c | 1 -
 migration/migration.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dea7078bf4..c929cf8d0f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1681,7 +1681,6 @@ void migrate_init(MigrationState *s)
      * parameters/capabilities that the user set, and
      * locks.
      */
-    s->bytes_xfer = 0;
     s->cleanup_bh = 0;
     s->to_dst_file = NULL;
     s->rp_state.from_dst_file = NULL;
diff --git a/migration/migration.h b/migration/migration.h
index 852eb3c4e9..b9efbe9168 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -116,7 +116,6 @@ struct MigrationState
     DeviceState parent_obj;
 
     /*< public >*/
-    size_t bytes_xfer;
     QemuThread thread;
     QEMUBH *cleanup_bh;
     QEMUFile *to_dst_file;
-- 
2.19.1
