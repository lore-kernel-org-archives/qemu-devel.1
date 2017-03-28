Received: from eggs.gnu.org ([2001:4830:134:3::10]:40259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst2o-0007Uu-76
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst2n-00070T-91
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cst2n-000706-3u
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19EE8C093568
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 15:28:24 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Mar 2017 16:27:41 +0100
Message-Id: <20170328152745.28186-3-dgilbert@redhat.com>
In-Reply-To: <20170328152745.28186-1-dgilbert@redhat.com>
References: <20170328152745.28186-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] migration/announce: Accessor functions for
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: kashyap@redhat.com, germano@redhat.com, armbru@redhat.com, jasowang@redhat.com, jdenemar@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Standard accessor functions for each of the parameters

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h |  5 +++++
 migration/migration.c         | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5720c88..a75800c 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -340,6 +340,11 @@ int migrate_compress_threads(void);
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
 
+int migrate_announce_initial(void);
+int migrate_announce_max(void);
+int migrate_announce_rounds(void);
+int migrate_announce_step(void);
+
 /* Sending on the return path - generic and then for each message type */
 void migrate_send_rp_message(MigrationIncomingState *mis,
                              enum mig_rp_message_type message_type,
diff --git a/migration/migration.c b/migration/migration.c
index 96c4ad6..6ae43a6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1483,6 +1483,26 @@ int64_t migrate_xbzrle_cache_size(void)
     return s->xbzrle_cache_size;
 }
 
+int migrate_announce_initial(void)
+{
+    return migrate_get_current()->parameters.announce_initial;
+}
+
+int migrate_announce_max(void)
+{
+    return migrate_get_current()->parameters.announce_max;
+}
+
+int migrate_announce_rounds(void)
+{
+    return migrate_get_current()->parameters.announce_rounds;
+}
+
+int migrate_announce_step(void)
+{
+    return migrate_get_current()->parameters.announce_step;
+}
+
 /* migration thread support */
 /*
  * Something bad happened to the RP stream, mark an error
-- 
2.9.3
