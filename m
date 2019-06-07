Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA475C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52335208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52335208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50270 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJXV-0007Q1-ME
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hZHnb-00018k-Ix
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hZHnZ-00024J-Bc
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:33:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hZHnD-0000Py-Nm; Fri, 07 Jun 2019 12:32:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6631430C5843;
 Fri,  7 Jun 2019 16:32:25 +0000 (UTC)
Received: from work-vm (ovpn-116-24.ams2.redhat.com [10.36.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEA5C10ABD75;
 Fri,  7 Jun 2019 16:32:22 +0000 (UTC)
Date: Fri, 7 Jun 2019 17:32:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190607163219.GO2631@work-vm>
References: <20190607135430.22149-1-kwolf@redhat.com>
 <20190607135430.22149-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607135430.22149-5-kwolf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 07 Jun 2019 16:32:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 04/10] monitor: Create MonitorHMP with
 readline state
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
> The ReadLineState in Monitor is only used for HMP monitors. Create
> MonitorHMP and move it there.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/monitor/monitor.h |   5 +-
>  hmp.c                     |   4 +-
>  monitor.c                 | 123 +++++++++++++++++++++-----------------
>  3 files changed, 75 insertions(+), 57 deletions(-)
> 
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 86656297f1..1ba354f811 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -7,6 +7,7 @@
>  #include "qemu/readline.h"
>  
>  extern __thread Monitor *cur_mon;
> +typedef struct MonitorHMP MonitorHMP;
>  
>  /* flags for monitor_init */
>  /* 0x01 unused */
> @@ -35,8 +36,8 @@ void monitor_flush(Monitor *mon);
>  int monitor_set_cpu(int cpu_index);
>  int monitor_get_cpu_index(void);
>  
> -void monitor_read_command(Monitor *mon, int show_prompt);
> -int monitor_read_password(Monitor *mon, ReadLineFunc *readline_func,
> +void monitor_read_command(MonitorHMP *mon, int show_prompt);
> +int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
>                            void *opaque);
>  
>  AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
> diff --git a/hmp.c b/hmp.c
> index be5e345c6f..99414cd39c 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1943,6 +1943,8 @@ static void hmp_change_read_arg(void *opaque, const char *password,
>  
>  void hmp_change(Monitor *mon, const QDict *qdict)
>  {
> +    /* FIXME Make MonitorHMP public and use container_of */
> +    MonitorHMP *hmp_mon = (MonitorHMP *) mon;
>      const char *device = qdict_get_str(qdict, "device");
>      const char *target = qdict_get_str(qdict, "target");
>      const char *arg = qdict_get_try_str(qdict, "arg");
> @@ -1960,7 +1962,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>          if (strcmp(target, "passwd") == 0 ||
>              strcmp(target, "password") == 0) {
>              if (!arg) {
> -                monitor_read_password(mon, hmp_change_read_arg, NULL);
> +                monitor_read_password(hmp_mon, hmp_change_read_arg, NULL);
>                  return;
>              }
>          }
> diff --git a/monitor.c b/monitor.c
> index d18cf18393..810f3dcf9c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -190,14 +190,6 @@ struct Monitor {
>      bool skip_flush;
>      bool use_io_thread;
>  
> -    /*
> -     * State used only in the thread "owning" the monitor.
> -     * If @use_io_thread, this is @mon_iothread.
> -     * Else, it's the main thread.
> -     * These members can be safely accessed without locks.
> -     */
> -    ReadLineState *rs;
> -
>      gchar *mon_cpu_path;
>      mon_cmd_t *cmd_table;
>      QTAILQ_ENTRY(Monitor) entry;
> @@ -218,6 +210,17 @@ struct Monitor {
>      int mux_out;
>  };
>  
> +struct MonitorHMP {
> +    Monitor common;
> +    /*
> +     * State used only in the thread "owning" the monitor.
> +     * If @use_io_thread, this is @mon_iothread.
> +     * Else, it's the main thread.
> +     * These members can be safely accessed without locks.
> +     */
> +    ReadLineState *rs;
> +};
> +
>  typedef struct {
>      Monitor common;
>      JSONMessageParser parser;
> @@ -324,7 +327,7 @@ bool monitor_cur_is_qmp(void)
>      return cur_mon && monitor_is_qmp(cur_mon);
>  }
>  
> -void monitor_read_command(Monitor *mon, int show_prompt)
> +void monitor_read_command(MonitorHMP *mon, int show_prompt)
>  {
>      if (!mon->rs)
>          return;
> @@ -334,7 +337,7 @@ void monitor_read_command(Monitor *mon, int show_prompt)
>          readline_show_prompt(mon->rs);
>  }
>  
> -int monitor_read_password(Monitor *mon, ReadLineFunc *readline_func,
> +int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
>                            void *opaque)
>  {
>      if (mon->rs) {
> @@ -342,7 +345,8 @@ int monitor_read_password(Monitor *mon, ReadLineFunc *readline_func,
>          /* prompt is printed on return from the command handler */
>          return 0;
>      } else {
> -        monitor_printf(mon, "terminal does not support password prompting\n");
> +        monitor_printf(&mon->common,
> +                       "terminal does not support password prompting\n");
>          return -ENOTTY;
>      }
>  }
> @@ -703,7 +707,7 @@ static void monitor_qapi_event_init(void)
>                                                  qapi_event_throttle_equal);
>  }
>  
> -static void handle_hmp_command(Monitor *mon, const char *cmdline);
> +static void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
>  
>  static void monitor_iothread_init(void);
>  
> @@ -738,8 +742,10 @@ static void monitor_data_destroy(Monitor *mon)
>      if (monitor_is_qmp(mon)) {
>          MonitorQMP *qmp_mon = container_of(mon, MonitorQMP, common);
>          monitor_data_destroy_qmp(qmp_mon);
> +    } else {
> +        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> +        readline_free(hmp_mon->rs);
>      }
> -    readline_free(mon->rs);
>      qobject_unref(mon->outbuf);
>      qemu_mutex_destroy(&mon->mon_lock);
>  }
> @@ -748,12 +754,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>                                  int64_t cpu_index, Error **errp)
>  {
>      char *output = NULL;
> -    Monitor *old_mon, hmp;
> +    Monitor *old_mon;
> +    MonitorHMP hmp = {};
>  
> -    monitor_data_init(&hmp, 0, true, false);
> +    monitor_data_init(&hmp.common, 0, true, false);
>  
>      old_mon = cur_mon;
> -    cur_mon = &hmp;
> +    cur_mon = &hmp.common;
>  
>      if (has_cpu_index) {
>          int ret = monitor_set_cpu(cpu_index);
> @@ -768,16 +775,16 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      handle_hmp_command(&hmp, command_line);
>      cur_mon = old_mon;
>  
> -    qemu_mutex_lock(&hmp.mon_lock);
> -    if (qstring_get_length(hmp.outbuf) > 0) {
> -        output = g_strdup(qstring_get_str(hmp.outbuf));
> +    qemu_mutex_lock(&hmp.common.mon_lock);
> +    if (qstring_get_length(hmp.common.outbuf) > 0) {
> +        output = g_strdup(qstring_get_str(hmp.common.outbuf));
>      } else {
>          output = g_strdup("");
>      }
> -    qemu_mutex_unlock(&hmp.mon_lock);
> +    qemu_mutex_unlock(&hmp.common.mon_lock);
>  
>  out:
> -    monitor_data_destroy(&hmp);
> +    monitor_data_destroy(&hmp.common);
>      return output;
>  }
>  
> @@ -1341,14 +1348,15 @@ static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
>  
>  static void hmp_info_history(Monitor *mon, const QDict *qdict)
>  {
> +    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
>      int i;
>      const char *str;
>  
> -    if (!mon->rs)
> +    if (!hmp_mon->rs)
>          return;
>      i = 0;
>      for(;;) {
> -        str = readline_get_history(mon->rs, i);
> +        str = readline_get_history(hmp_mon->rs, i);
>          if (!str)
>              break;
>          monitor_printf(mon, "%d: '%s'\n", i, str);
> @@ -3048,11 +3056,12 @@ static const mon_cmd_t *search_dispatch_table(const mon_cmd_t *disp_table,
>   * Do not assume the return value points into @table!  It doesn't when
>   * the command is found in a sub-command table.
>   */
> -static const mon_cmd_t *monitor_parse_command(Monitor *mon,
> +static const mon_cmd_t *monitor_parse_command(MonitorHMP *hmp_mon,
>                                                const char *cmdp_start,
>                                                const char **cmdp,
>                                                mon_cmd_t *table)
>  {
> +    Monitor *mon = &hmp_mon->common;
>      const char *p;
>      const mon_cmd_t *cmd;
>      char cmdname[256];
> @@ -3083,7 +3092,7 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
>      *cmdp = p;
>      /* search sub command */
>      if (cmd->sub_table != NULL && *p != '\0') {
> -        return monitor_parse_command(mon, cmdp_start, cmdp, cmd->sub_table);
> +        return monitor_parse_command(hmp_mon, cmdp_start, cmdp, cmd->sub_table);
>      }
>  
>      return cmd;
> @@ -3460,7 +3469,7 @@ fail:
>      return NULL;
>  }
>  
> -static void handle_hmp_command(Monitor *mon, const char *cmdline)
> +static void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
>  {
>      QDict *qdict;
>      const mon_cmd_t *cmd;
> @@ -3468,26 +3477,26 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
>  
>      trace_handle_hmp_command(mon, cmdline);
>  
> -    cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
> +    cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->common.cmd_table);
>      if (!cmd) {
>          return;
>      }
>  
> -    qdict = monitor_parse_arguments(mon, &cmdline, cmd);
> +    qdict = monitor_parse_arguments(&mon->common, &cmdline, cmd);
>      if (!qdict) {
>          while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
>              cmdline--;
>          }
> -        monitor_printf(mon, "Try \"help %.*s\" for more information\n",
> +        monitor_printf(&mon->common, "Try \"help %.*s\" for more information\n",
>                         (int)(cmdline - cmd_start), cmd_start);
>          return;
>      }
>  
> -    cmd->cmd(mon, qdict);
> +    cmd->cmd(&mon->common, qdict);
>      qobject_unref(qdict);
>  }
>  
> -static void cmd_completion(Monitor *mon, const char *name, const char *list)
> +static void cmd_completion(MonitorHMP *mon, const char *name, const char *list)
>  {
>      const char *p, *pstart;
>      char cmd[128];
> @@ -3511,7 +3520,7 @@ static void cmd_completion(Monitor *mon, const char *name, const char *list)
>      }
>  }
>  
> -static void file_completion(Monitor *mon, const char *input)
> +static void file_completion(MonitorHMP *mon, const char *input)
>  {
>      DIR *ffs;
>      struct dirent *d;
> @@ -4000,7 +4009,7 @@ void loadvm_completion(ReadLineState *rs, int nb_args, const char *str)
>      }
>  }
>  
> -static void monitor_find_completion_by_table(Monitor *mon,
> +static void monitor_find_completion_by_table(MonitorHMP *mon,
>                                               const mon_cmd_t *cmd_table,
>                                               char **args,
>                                               int nb_args)
> @@ -4095,7 +4104,7 @@ static void monitor_find_completion_by_table(Monitor *mon,
>  static void monitor_find_completion(void *opaque,
>                                      const char *cmdline)
>  {
> -    Monitor *mon = opaque;
> +    MonitorHMP *mon = opaque;
>      char *args[MAX_ARGS];
>      int nb_args, len;
>  
> @@ -4115,7 +4124,7 @@ static void monitor_find_completion(void *opaque,
>      }
>  
>      /* 2. auto complete according to args */
> -    monitor_find_completion_by_table(mon, mon->cmd_table, args, nb_args);
> +    monitor_find_completion_by_table(mon, mon->common.cmd_table, args, nb_args);
>  
>  cleanup:
>      free_cmdline_args(args, nb_args);
> @@ -4326,19 +4335,21 @@ static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
>  
>  static void monitor_read(void *opaque, const uint8_t *buf, int size)
>  {
> +    MonitorHMP *mon;
>      Monitor *old_mon = cur_mon;
>      int i;
>  
>      cur_mon = opaque;
> +    mon = container_of(cur_mon, MonitorHMP, common);
>  
> -    if (cur_mon->rs) {
> +    if (mon->rs) {
>          for (i = 0; i < size; i++)
> -            readline_handle_byte(cur_mon->rs, buf[i]);
> +            readline_handle_byte(mon->rs, buf[i]);
>      } else {
>          if (size == 0 || buf[size - 1] != 0)
>              monitor_printf(cur_mon, "corrupted command\n");
>          else
> -            handle_hmp_command(cur_mon, (char *)buf);
> +            handle_hmp_command(mon, (char *)buf);
>      }
>  
>      cur_mon = old_mon;
> @@ -4347,11 +4358,11 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
>  static void monitor_command_cb(void *opaque, const char *cmdline,
>                                 void *readline_opaque)
>  {
> -    Monitor *mon = opaque;
> +    MonitorHMP *mon = opaque;
>  
> -    monitor_suspend(mon);
> +    monitor_suspend(&mon->common);
>      handle_hmp_command(mon, cmdline);
> -    monitor_resume(mon);
> +    monitor_resume(&mon->common);
>  }
>  
>  int monitor_suspend(Monitor *mon)
> @@ -4397,8 +4408,9 @@ void monitor_resume(Monitor *mon)
>          }
>  
>          if (!monitor_is_qmp(mon)) {
> -            assert(mon->rs);
> -            readline_show_prompt(mon->rs);
> +            MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> +            assert(hmp_mon->rs);
> +            readline_show_prompt(hmp_mon->rs);
>          }
>  
>          aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
> @@ -4460,6 +4472,7 @@ static void monitor_qmp_event(void *opaque, int event)
>  static void monitor_event(void *opaque, int event)
>  {
>      Monitor *mon = opaque;
> +    MonitorHMP *hmp_mon = container_of(cur_mon, MonitorHMP, common);
>  
>      switch (event) {
>      case CHR_EVENT_MUX_IN:
> @@ -4467,7 +4480,7 @@ static void monitor_event(void *opaque, int event)
>          mon->mux_out = 0;
>          qemu_mutex_unlock(&mon->mon_lock);
>          if (mon->reset_seen) {
> -            readline_restart(mon->rs);
> +            readline_restart(hmp_mon->rs);
>              monitor_resume(mon);
>              monitor_flush(mon);
>          } else {
> @@ -4494,8 +4507,8 @@ static void monitor_event(void *opaque, int event)
>          monitor_printf(mon, "QEMU %s monitor - type 'help' for more "
>                         "information\n", QEMU_VERSION);
>          if (!mon->mux_out) {
> -            readline_restart(mon->rs);
> -            readline_show_prompt(mon->rs);
> +            readline_restart(hmp_mon->rs);
> +            readline_show_prompt(hmp_mon->rs);
>          }
>          mon->reset_seen = 1;
>          mon_refcount++;
> @@ -4556,15 +4569,17 @@ void monitor_init_globals(void)
>  static void GCC_FMT_ATTR(2, 3) monitor_readline_printf(void *opaque,
>                                                         const char *fmt, ...)
>  {
> +    MonitorHMP *mon = opaque;
>      va_list ap;
>      va_start(ap, fmt);
> -    monitor_vprintf(opaque, fmt, ap);
> +    monitor_vprintf(&mon->common, fmt, ap);
>      va_end(ap);
>  }
>  
>  static void monitor_readline_flush(void *opaque)
>  {
> -    monitor_flush(opaque);
> +    MonitorHMP *mon = opaque;
> +    monitor_flush(&mon->common);
>  }
>  
>  /*
> @@ -4662,11 +4677,11 @@ static void monitor_init_qmp(Chardev *chr, int flags)
>  
>  static void monitor_init_hmp(Chardev *chr, int flags)
>  {
> -    Monitor *mon = g_malloc(sizeof(*mon));
> +    MonitorHMP *mon = g_malloc0(sizeof(*mon));
>      bool use_readline = flags & MONITOR_USE_READLINE;
>  
> -    monitor_data_init(mon, flags, false, false);
> -    qemu_chr_fe_init(&mon->chr, chr, &error_abort);
> +    monitor_data_init(&mon->common, flags, false, false);
> +    qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
>  
>      if (use_readline) {
>          mon->rs = readline_init(monitor_readline_printf,
> @@ -4676,9 +4691,9 @@ static void monitor_init_hmp(Chardev *chr, int flags)
>          monitor_read_command(mon, 0);
>      }
>  
> -    qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
> -                             monitor_event, NULL, mon, NULL, true);
> -    monitor_list_append(mon);
> +    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read, monitor_read,
> +                             monitor_event, NULL, &mon->common, NULL, true);
> +    monitor_list_append(&mon->common);
>  }
>  
>  void monitor_init(Chardev *chr, int flags)
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

