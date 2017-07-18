Received: from eggs.gnu.org ([2001:4830:134:3::10]:33813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXSku-0000Af-IT
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXSkt-0007Tx-FG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Jul 2017 15:41:24 +0200
Message-Id: <1500385286-21142-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-1-git-send-email-armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 08/10] migration: Add TODO comments on
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
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

qmp_query_migrate_parameters() and qmp_migrate_set_parameters()
effectively duplicate QAPI_CLONE() inline.  Add suitable TODO
comments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
