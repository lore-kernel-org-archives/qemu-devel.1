Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2181C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86AC2133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86AC2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbhvy-0005fO-Ji
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58581)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hbhsj-0002pr-UU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hbhsi-0005co-Ak
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:48:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hbhsd-0005OQ-97; Fri, 14 Jun 2019 04:48:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E51003688B;
 Fri, 14 Jun 2019 08:48:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ABCD39C3;
 Fri, 14 Jun 2019 08:48:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 22B1511386A6; Fri, 14 Jun 2019 10:48:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
 <20190613153405.24769-14-kwolf@redhat.com>
Date: Fri, 14 Jun 2019 10:48:06 +0200
In-Reply-To: <20190613153405.24769-14-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 13 Jun 2019 17:34:03 +0200")
Message-ID: <87o930ft89.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 14 Jun 2019 08:48:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 13/15] monitor: Split Monitor.flags into
 separate bools
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Monitor.flags contains three different flags: One to distinguish HMP
> from QMP; one specific to HMP (MONITOR_USE_READLINE) that is ignored
> with QMP; and another one specific to QMP (MONITOR_USE_PRETTY) that is
> ignored with HMP.
>
> Split the flags field into three bools and move them to the right
> subclass. Flags are still in use for the monitor_init() interface.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  monitor/monitor-internal.h |  8 +++++---
>  monitor/hmp.c              |  6 +++---
>  monitor/misc.c             |  2 +-
>  monitor/monitor.c          | 14 +++++++++-----
>  monitor/qmp.c              |  7 ++++---
>  5 files changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 30679d522e..260725e51b 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -90,8 +90,8 @@ typedef struct HMPCommand {
>  struct Monitor {
>      CharBackend chr;
>      int reset_seen;
> -    int flags;
>      int suspend_cnt;            /* Needs to be accessed atomically */
> +    bool is_qmp;
>      bool skip_flush;
>      bool use_io_thread;
>  
> @@ -116,6 +116,7 @@ struct Monitor {
>  
>  struct MonitorHMP {
>      Monitor common;
> +    bool use_readline;
>      /*
>       * State used only in the thread "owning" the monitor.
>       * If @use_io_thread, this is @mon_iothread. (This does not actually happen
> @@ -129,6 +130,7 @@ struct MonitorHMP {
>  typedef struct {
>      Monitor common;
>      JSONMessageParser parser;
> +    bool pretty;
>      /*
>       * When a client connects, we're in capabilities negotiation mode.
>       * @commands is &qmp_cap_negotiation_commands then.  When command
> @@ -152,7 +154,7 @@ typedef struct {
>   */
>  static inline bool monitor_is_qmp(const Monitor *mon)
>  {
> -    return (mon->flags & MONITOR_USE_CONTROL);
> +    return mon->is_qmp;
>  }

The function was marginal before, and it's pointless now.  Let's kill it
in a follow-up patch.  No need to do it in this series.

>  
>  typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
> @@ -169,7 +171,7 @@ void monitor_init_qmp(Chardev *chr, int flags);
>  void monitor_init_hmp(Chardev *chr, int flags);
>  
>  int monitor_puts(Monitor *mon, const char *str);
> -void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
> +void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
>                         bool use_io_thread);
>  void monitor_data_destroy(Monitor *mon);
>  int monitor_can_read(void *opaque);
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 3621b195ed..5ba8b6e8d5 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1396,12 +1396,12 @@ static void monitor_readline_flush(void *opaque)
>  void monitor_init_hmp(Chardev *chr, int flags)
>  {
>      MonitorHMP *mon = g_malloc0(sizeof(*mon));
> -    bool use_readline = flags & MONITOR_USE_READLINE;
>  
> -    monitor_data_init(&mon->common, flags, false, false);
> +    monitor_data_init(&mon->common, false, false, false);
>      qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
>  
> -    if (use_readline) {
> +    mon->use_readline = flags & MONITOR_USE_READLINE;
> +    if (mon->use_readline) {
>          mon->rs = readline_init(monitor_readline_printf,
>                                  monitor_readline_flush,
>                                  mon,
> diff --git a/monitor/misc.c b/monitor/misc.c
> index dddbddb21f..10c056394e 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -134,7 +134,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      Monitor *old_mon;
>      MonitorHMP hmp = {};
>  
> -    monitor_data_init(&hmp.common, 0, true, false);
> +    monitor_data_init(&hmp.common, false, true, false);
>  
>      old_mon = cur_mon;
>      cur_mon = &hmp.common;
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 6802b8e491..7325e4362b 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -80,14 +80,18 @@ bool monitor_cur_is_qmp(void)
>   * Note: not all HMP monitors use readline, e.g., gdbserver has a
>   * non-interactive HMP monitor, so readline is not used there.
>   */
> -static inline bool monitor_uses_readline(const Monitor *mon)
> +static inline bool monitor_uses_readline(const MonitorHMP *mon)
>  {
> -    return mon->flags & MONITOR_USE_READLINE;
> +    return mon->use_readline;
>  }

Another one to kill.

>  
>  static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
>  {
> -    return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
> +    if (monitor_is_qmp(mon)) {
> +        return false;
> +    }
> +
> +    return !monitor_uses_readline(container_of(mon, MonitorHMP, common));
>  }
>  

Not sure about this one.  We'll see.

>  static void monitor_flush_locked(Monitor *mon);
> @@ -523,17 +527,17 @@ static void monitor_iothread_init(void)
>      mon_iothread = iothread_create("mon_iothread", &error_abort);
>  }
>  
> -void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
> +void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
>                         bool use_io_thread)
>  {
>      if (use_io_thread && !mon_iothread) {
>          monitor_iothread_init();
>      }
>      qemu_mutex_init(&mon->mon_lock);
> +    mon->is_qmp = is_qmp;
>      mon->outbuf = qstring_new();
>      mon->skip_flush = skip_flush;
>      mon->use_io_thread = use_io_thread;
> -    mon->flags = flags;
>  }
>  
>  void monitor_data_destroy(Monitor *mon)
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 31fbcd59f7..3abc718ca3 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -86,8 +86,7 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
>      const QObject *data = QOBJECT(rsp);
>      QString *json;
>  
> -    json = mon->common.flags & MONITOR_USE_PRETTY ?
> -           qobject_to_json_pretty(data) : qobject_to_json(data);
> +    json = mon->pretty ? qobject_to_json_pretty(data) : qobject_to_json(data);
>      assert(json != NULL);
>  
>      qstring_append_chr(json, '\n');
> @@ -372,9 +371,11 @@ void monitor_init_qmp(Chardev *chr, int flags)
>      assert(!(flags & MONITOR_USE_READLINE));
>  
>      /* Note: we run QMP monitor in I/O thread when @chr supports that */
> -    monitor_data_init(&mon->common, flags, false,
> +    monitor_data_init(&mon->common, true, false,
>                        qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
>  
> +    mon->pretty = flags & MONITOR_USE_PRETTY;
> +
>      qemu_mutex_init(&mon->qmp_queue_lock);
>      mon->qmp_requests = g_queue_new();

Reviewed-by: Markus Armbruster <armbru@redhat.com>

