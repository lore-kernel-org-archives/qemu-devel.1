Received: from eggs.gnu.org ([2001:4830:134:3::10]:33125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZbyz-00015Y-CU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZbyx-0006sZ-TU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZbyx-0006s8-NB
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4C0D7D0CB
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:57:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-94.ams2.redhat.com
	[10.36.116.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7029261B95
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:57:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Jul 2017 13:56:57 +0200
Message-Id: <1500897419-15539-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1500897419-15539-1-git-send-email-armbru@redhat.com>
References: <1500897419-15539-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 08/10] migration: Add TODO comments on
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
 migration/migration.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 88b9277..6b4d17f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -433,6 +433,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     MigrationParameters *params;
     MigrationState *s = migrate_get_current();
 
+    /* TODO use QAPI_CLONE() instead of duplicating it inline */
     params = g_malloc0(sizeof(*params));
     params->has_compress_level = true;
     params->compress_level = s->parameters.compress_level;
@@ -745,6 +746,8 @@ static void migrate_params_apply(MigrationParameters *params)
 {
     MigrationState *s = migrate_get_current();
 
+    /* TODO use QAPI_CLONE() instead of duplicating it inline */
+
     if (params->has_compress_level) {
         s->parameters.compress_level = params->compress_level;
     }
-- 
2.7.5
