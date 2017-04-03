Received: from eggs.gnu.org ([2001:4830:134:3::10]:56930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1b9-0004I9-TH
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1b5-0007i3-LL
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:00:43 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1b5-0007hR-CV
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:00:39 -0400
Received: by mail-qk0-x244.google.com with SMTP id r140so7902240qke.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 06:00:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491034725-23968-1-git-send-email-peterx@redhat.com>
	<1491034725-23968-5-git-send-email-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <82d20c7b-26bf-c4da-e104-33a7f9103216@amsat.org>
Date: Mon, 3 Apr 2017 10:00:33 -0300
MIME-Version: 1.0
In-Reply-To: <1491034725-23968-5-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hmp: info migrate_parameters format
 tunes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 04/01/2017 05:18 AM, Peter Xu wrote:
> Do the same (one per line) to the parameter list.
>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hmp.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/hmp.c b/hmp.c
> index 95eef8c..b33e39e 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -282,46 +282,44 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>      params = qmp_query_migrate_parameters(NULL);
>
>      if (params) {
> -        monitor_printf(mon, "parameters:");
>          assert(params->has_compress_level);
> -        monitor_printf(mon, " %s: %" PRId64,
> +        monitor_printf(mon, "%s: %" PRId64 "\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_LEVEL],
>              params->compress_level);
>          assert(params->has_compress_threads);
> -        monitor_printf(mon, " %s: %" PRId64,
> +        monitor_printf(mon, "%s: %" PRId64 "\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_THREADS],
>              params->compress_threads);
>          assert(params->has_decompress_threads);
> -        monitor_printf(mon, " %s: %" PRId64,
> +        monitor_printf(mon, "%s: %" PRId64 "\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_DECOMPRESS_THREADS],
>              params->decompress_threads);
>          assert(params->has_cpu_throttle_initial);
> -        monitor_printf(mon, " %s: %" PRId64,
> +        monitor_printf(mon, "%s: %" PRId64 "\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL],
>              params->cpu_throttle_initial);
>          assert(params->has_cpu_throttle_increment);
> -        monitor_printf(mon, " %s: %" PRId64,
> +        monitor_printf(mon, "%s: %" PRId64 "\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT],
>              params->cpu_throttle_increment);
> -        monitor_printf(mon, " %s: '%s'",
> +        monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_CREDS],
>              params->has_tls_creds ? params->tls_creds : "");
> -        monitor_printf(mon, " %s: '%s'",
> +        monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_HOSTNAME],
>              params->has_tls_hostname ? params->tls_hostname : "");
>          assert(params->has_max_bandwidth);
> -        monitor_printf(mon, " %s: %" PRId64 " bytes/second",
> +        monitor_printf(mon, "%s: %" PRId64 " bytes/second\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_MAX_BANDWIDTH],
>              params->max_bandwidth);
>          assert(params->has_downtime_limit);
> -        monitor_printf(mon, " %s: %" PRId64 " milliseconds",
> +        monitor_printf(mon, "%s: %" PRId64 " milliseconds\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_DOWNTIME_LIMIT],
>              params->downtime_limit);
>          assert(params->has_x_checkpoint_delay);
> -        monitor_printf(mon, " %s: %" PRId64,
> +        monitor_printf(mon, "%s: %" PRId64 "\n",
>              MigrationParameter_lookup[MIGRATION_PARAMETER_X_CHECKPOINT_DELAY],
>              params->x_checkpoint_delay);
> -        monitor_printf(mon, "\n");
>      }
>
>      qapi_free_MigrationParameters(params);
>
