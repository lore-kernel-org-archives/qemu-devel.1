Received: from eggs.gnu.org ([2001:4830:134:3::10]:58142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ7W-00056y-B8
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ7U-000189-PV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXZ7U-00017e-JT
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8479E3683C
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:29:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-60.ams2.redhat.com
	[10.36.116.60])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4452761F52
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:29:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Jul 2017 22:29:18 +0200
Message-Id: <1500409760-20730-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1500409760-20730-1-git-send-email-armbru@redhat.com>
References: <1500409760-20730-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] migration: Add TODO comments on
 duplication of QAPI_CLONE()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qmp_query_migrate_parameters() and qmp_migrate_set_parameters()
effectively duplicate QAPI_CLONE() inline.  Add suitable TODO
comments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index bae9808..d0a1d13 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -427,6 +427,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     MigrationParameters *params;
     MigrationState *s = migrate_get_current();
 
+    /* TODO use QAPI_CLONE() instead of duplicating it inline */
     params = g_malloc0(sizeof(*params));
     params->has_compress_level = true;
     params->compress_level = s->parameters.compress_level;
@@ -703,6 +704,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
                     "is invalid, it should be positive");
     }
 
+    /* TODO use QAPI_CLONE() instead of duplicating it inline */
     if (params->has_compress_level) {
         s->parameters.compress_level = params->compress_level;
     }
-- 
2.7.5
