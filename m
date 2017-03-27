Received: from eggs.gnu.org ([2001:4830:134:3::10]:50695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csOzP-0006dM-Ru
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csOzL-00030R-CB
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1csOzL-00030C-3L
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 315BFA203B
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 07:22:50 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 27 Mar 2017 15:21:27 +0800
Message-Id: <1490599288-11751-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1490599288-11751-1-git-send-email-peterx@redhat.com>
References: <1490599288-11751-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] hmp: info migrate_parameters format tunes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "\\  Dr . David Alan Gilbert \\ " <dgilbert@redhat.com>, peterx@redhat.com

Do the same (one per line) to the parameter list.

CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hmp.c b/hmp.c
index 95eef8c..b33e39e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -282,46 +282,44 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
     params = qmp_query_migrate_parameters(NULL);
 
     if (params) {
-        monitor_printf(mon, "parameters:");
         assert(params->has_compress_level);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_LEVEL],
             params->compress_level);
         assert(params->has_compress_threads);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_THREADS],
             params->compress_threads);
         assert(params->has_decompress_threads);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_DECOMPRESS_THREADS],
             params->decompress_threads);
         assert(params->has_cpu_throttle_initial);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL],
             params->cpu_throttle_initial);
         assert(params->has_cpu_throttle_increment);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT],
             params->cpu_throttle_increment);
-        monitor_printf(mon, " %s: '%s'",
+        monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_CREDS],
             params->has_tls_creds ? params->tls_creds : "");
-        monitor_printf(mon, " %s: '%s'",
+        monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_HOSTNAME],
             params->has_tls_hostname ? params->tls_hostname : "");
         assert(params->has_max_bandwidth);
-        monitor_printf(mon, " %s: %" PRId64 " bytes/second",
+        monitor_printf(mon, "%s: %" PRId64 " bytes/second\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_MAX_BANDWIDTH],
             params->max_bandwidth);
         assert(params->has_downtime_limit);
-        monitor_printf(mon, " %s: %" PRId64 " milliseconds",
+        monitor_printf(mon, "%s: %" PRId64 " milliseconds\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_DOWNTIME_LIMIT],
             params->downtime_limit);
         assert(params->has_x_checkpoint_delay);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_X_CHECKPOINT_DELAY],
             params->x_checkpoint_delay);
-        monitor_printf(mon, "\n");
     }
 
     qapi_free_MigrationParameters(params);
-- 
2.7.4
