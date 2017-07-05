Received: from eggs.gnu.org ([2001:4830:134:3::10]:36350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSfZF-0005xB-Kh
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSfZE-0000VH-85
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dSfZE-0000V3-2F
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:48 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Jul 2017 16:21:23 +0800
Message-Id: <1499242883-2184-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1499242883-2184-1-git-send-email-peterx@redhat.com>
References: <1499242883-2184-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] doc: update TYPE_MIGRATION documents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, haoqf@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

[Peter collected Eduardo's patch comment and formatted into patch]

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dbdc121..31d46d1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2052,12 +2052,12 @@ static void migration_instance_init(Object *obj)
 static const TypeInfo migration_type = {
     .name = TYPE_MIGRATION,
     /*
-     * NOTE: "migration" itself is not really a device. We used
-     * TYPE_DEVICE here only to leverage some existing QDev features
-     * like "-global" properties, and HW_COMPAT_* fields (which are
-     * finally applied as global properties as well). If one day the
-     * global property feature can be migrated from QDev to QObject in
-     * general, then we can switch to QObject as well.
+     * NOTE: TYPE_MIGRATION is not really a device, as the object is
+     * not created using qdev_create(), it is not attached to the qdev
+     * device tree, and it is never realized.
+     *
+     * TODO: Make this TYPE_OBJECT once QOM provides something like
+     * TYPE_DEVICE's "-global" properties.
      */
     .parent = TYPE_DEVICE,
     .class_init = migration_class_init,
-- 
2.7.4
