Received: from eggs.gnu.org ([2001:4830:134:3::10]:49479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ7Cc-00005c-Ft
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ7Cb-0000Ux-NE
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQ7Cb-0000UU-8u
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:15:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DEB1C0587FA
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 07:15:52 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Jun 2017 15:15:44 +0800
Message-Id: <1498634144-26508-1-git-send-email-peterx@redhat.com>
In-Reply-To: <1498536619-14548-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 11/10] migration: add comment for
 TYPE_MIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, lvivier@redhat.com, eblake@redhat.com, armbru@redhat.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com

It'll be strange that the migration object inherits TYPE_DEVICE. Add
some explanations to it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index b1b0825..2398a9d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2046,6 +2046,14 @@ static void migration_instance_init(Object *obj)
 
 static const TypeInfo migration_type = {
     .name = TYPE_MIGRATION,
+    /*
+     * NOTE: "migration" itself is not really a device. We used
+     * TYPE_DEVICE here only to leverage some existing QDev features
+     * like "-global" properties, and HW_COMPAT_* fields (which are
+     * finally applied as global properties as well). If one day the
+     * global property feature can be migrated from QDev to QObject in
+     * general, then we can switch to QObject as well.
+     */
     .parent = TYPE_DEVICE,
     .class_init = migration_class_init,
     .class_size = sizeof(MigrationClass),
-- 
2.7.4
