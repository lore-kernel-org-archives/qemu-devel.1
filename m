Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8028C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C839320868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C839320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51132 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZK7O-00054F-Rm
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44521)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hZHqM-0003g4-Hy
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hZHqG-0000V3-9B
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:35:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hZHqC-0000Nv-DG; Fri, 07 Jun 2019 12:35:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B549730BC564;
 Fri,  7 Jun 2019 16:35:43 +0000 (UTC)
Received: from work-vm (ovpn-116-24.ams2.redhat.com [10.36.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FA42611AB;
 Fri,  7 Jun 2019 16:35:38 +0000 (UTC)
Date: Fri, 7 Jun 2019 17:35:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190607163535.GP2631@work-vm>
References: <20190607135430.22149-1-kwolf@redhat.com>
 <20190607135430.22149-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607135430.22149-6-kwolf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 07 Jun 2019 16:35:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 05/10] monitor: Move cmd_table to
 MonitorHMP
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Monitor.cmd_table contains the handlers for HMP commands, so there is no
> reason to keep it in the state shared with QMP. Move it to MonitorHMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 810f3dcf9c..d964dd1969 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -191,7 +191,6 @@ struct Monitor {
>      bool use_io_thread;
>  
>      gchar *mon_cpu_path;
> -    mon_cmd_t *cmd_table;
>      QTAILQ_ENTRY(Monitor) entry;
>  
>      /*
> @@ -219,6 +218,7 @@ struct MonitorHMP {
>       * These members can be safely accessed without locks.
>       */
>      ReadLineState *rs;
> +    mon_cmd_t *cmd_table;
>  };
>  
>  typedef struct {
> @@ -720,13 +720,19 @@ static void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
>      memset(mon, 0, sizeof(Monitor));
>      qemu_mutex_init(&mon->mon_lock);
>      mon->outbuf = qstring_new();
> -    /* Use *mon_cmds by default. */
> -    mon->cmd_table = mon_cmds;
>      mon->skip_flush = skip_flush;
>      mon->use_io_thread = use_io_thread;
>      mon->flags = flags;
>  }
>  
> +static void monitor_data_init_hmp(MonitorHMP *mon, int flags, bool skip_flush)
> +{
> +    monitor_data_init(&mon->common, flags, skip_flush, false);
> +
> +    /* Use *mon_cmds by default. */
> +    mon->cmd_table = mon_cmds;
> +}
> +
>  static void monitor_data_destroy_qmp(MonitorQMP *mon)
>  {
>      json_message_parser_destroy(&mon->parser);
> @@ -757,7 +763,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      Monitor *old_mon;
>      MonitorHMP hmp = {};
>  
> -    monitor_data_init(&hmp.common, 0, true, false);
> +    monitor_data_init_hmp(&hmp, 0, true);
>  
>      old_mon = cur_mon;
>      cur_mon = &hmp.common;
> @@ -1002,6 +1008,7 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
>  
>  static void help_cmd(Monitor *mon, const char *name)
>  {
> +    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
>      char *args[MAX_ARGS];
>      int nb_args = 0;
>  
> @@ -1024,7 +1031,7 @@ static void help_cmd(Monitor *mon, const char *name)
>      }
>  
>      /* 2. dump the contents according to parsed args */
> -    help_cmd_dump(mon, mon->cmd_table, args, nb_args, 0);
> +    help_cmd_dump(mon, hmp_mon->cmd_table, args, nb_args, 0);
>  
>      free_cmdline_args(args, nb_args);
>  }
> @@ -3477,7 +3484,7 @@ static void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
>  
>      trace_handle_hmp_command(mon, cmdline);
>  
> -    cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->common.cmd_table);
> +    cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
>      if (!cmd) {
>          return;
>      }
> @@ -4124,7 +4131,7 @@ static void monitor_find_completion(void *opaque,
>      }
>  
>      /* 2. auto complete according to args */
> -    monitor_find_completion_by_table(mon, mon->common.cmd_table, args, nb_args);
> +    monitor_find_completion_by_table(mon, mon->cmd_table, args, nb_args);
>  
>  cleanup:
>      free_cmdline_args(args, nb_args);
> @@ -4680,7 +4687,7 @@ static void monitor_init_hmp(Chardev *chr, int flags)
>      MonitorHMP *mon = g_malloc0(sizeof(*mon));
>      bool use_readline = flags & MONITOR_USE_READLINE;
>  
> -    monitor_data_init(&mon->common, flags, false, false);
> +    monitor_data_init_hmp(mon, flags, false);
>      qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
>  
>      if (use_readline) {
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

