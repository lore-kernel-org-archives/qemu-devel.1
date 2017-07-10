Received: from eggs.gnu.org ([2001:4830:134:3::10]:35613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCy-0004py-AP
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCx-0008Kn-Fv
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dUcCx-0008KV-9s
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 621D37F3EB
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 17:10:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Jul 2017 18:10:35 +0100
Message-Id: <20170710171040.21021-5-dgilbert@redhat.com>
In-Reply-To: <20170710171040.21021-1-dgilbert@redhat.com>
References: <20170710171040.21021-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] doc: update TYPE_MIGRATION documents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

[Peter collected Eduardo's patch comment and formatted into patch]

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1499242883-2184-5-git-send-email-peterx@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dbdc121838..31d46d1343 100644
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
2.13.0
