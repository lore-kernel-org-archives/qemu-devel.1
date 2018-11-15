Received: from eggs.gnu.org ([2001:4830:134:3::10]:57674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNF5R-0003wH-Ln
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNF5J-0000uq-Rt
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:14567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gNF5J-0000oM-DW
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:17 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 15 Nov 2018 18:08:03 +0800
Message-Id: <1542276484-25508-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v9 7/8] migration: move migrate_postcopy() to
 include/migration/misc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com

The ram save state notifier callback, for example the free page
optimization offerred by virtio-balloon, may need to check if
postcopy is in use, so move migrate_postcopy() to the outside header.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/misc.h | 1 +
 migration/migration.h    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 67cb275..06b816f 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -70,6 +70,7 @@ bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
 bool migration_in_postcopy_after_devices(MigrationState *);
 void migration_global_dump(Monitor *mon);
+bool migrate_postcopy(void);
 
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
diff --git a/migration/migration.h b/migration/migration.h
index e413d4d..e1e92ff 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -249,8 +249,6 @@ bool migration_is_blocked(Error **errp);
 bool migration_in_postcopy(void);
 MigrationState *migrate_get_current(void);
 
-bool migrate_postcopy(void);
-
 bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
-- 
1.8.3.1
