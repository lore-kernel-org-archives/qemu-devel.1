Received: from eggs.gnu.org ([2001:4830:134:3::10]:46125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XDI-0003gQ-Sh
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XDH-0007x9-Ke
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:59:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XDH-0007wh-B8
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4389AC04BD42
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:58:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:46 +0200
Message-Id: <20170421115646.15544-66-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 65/65] hmp: info migrate_parameters format tunes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Do the same (one per line) to the parameter list.

CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hmp.c b/hmp.c
index 70db84f..ab407d6 100644
--- a/hmp.c
+++ b/hmp.c
@@ -285,46 +285,44 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
     params =3D qmp_query_migrate_parameters(NULL);
=20
     if (params) {
-        monitor_printf(mon, "parameters:");
         assert(params->has_compress_level);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_LEVEL=
],
             params->compress_level);
         assert(params->has_compress_threads);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_THREA=
DS],
             params->compress_threads);
         assert(params->has_decompress_threads);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_DECOMPRESS_THR=
EADS],
             params->decompress_threads);
         assert(params->has_cpu_throttle_initial);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_I=
NITIAL],
             params->cpu_throttle_initial);
         assert(params->has_cpu_throttle_increment);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_I=
NCREMENT],
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
             MigrationParameter_lookup[MIGRATION_PARAMETER_MAX_BANDWIDTH]=
,
             params->max_bandwidth);
         assert(params->has_downtime_limit);
-        monitor_printf(mon, " %s: %" PRId64 " milliseconds",
+        monitor_printf(mon, "%s: %" PRId64 " milliseconds\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_DOWNTIME_LIMIT=
],
             params->downtime_limit);
         assert(params->has_x_checkpoint_delay);
-        monitor_printf(mon, " %s: %" PRId64,
+        monitor_printf(mon, "%s: %" PRId64 "\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_X_CHECKPOINT_D=
ELAY],
             params->x_checkpoint_delay);
-        monitor_printf(mon, "\n");
     }
=20
     qapi_free_MigrationParameters(params);
--=20
2.9.3
