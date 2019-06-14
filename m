Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EDBC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B28420866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B28420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbi1f-0001O4-8t
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60140)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hbhz1-00081n-QN
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hbhz0-00011l-A7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:54:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hbhyq-0000uA-FP; Fri, 14 Jun 2019 04:54:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C84C281F13;
 Fri, 14 Jun 2019 08:54:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3FBF66D31;
 Fri, 14 Jun 2019 08:54:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B41311386A6; Fri, 14 Jun 2019 10:54:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
 <20190613153405.24769-4-kwolf@redhat.com>
Date: Fri, 14 Jun 2019 10:54:28 +0200
In-Reply-To: <20190613153405.24769-4-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 13 Jun 2019 17:33:53 +0200")
Message-ID: <87ef3wfsxn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 14 Jun 2019 08:54:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 03/15] monitor: Make MonitorQMP a child
 class of Monitor
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
Cc: dgilbert@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Currently, struct Monitor mixes state that is only relevant for HMP,
> state that is only relevant for QMP, and some actually shared state.
> In particular, a MonitorQMP field is present in the state of any
> monitor, even if it's not a QMP monitor and therefore doesn't use the
> state.
>
> As a first step towards a clean separation between QMP and HMP, let
> MonitorQMP extend Monitor and create a MonitorQMP object only when the
> monitor is actually a QMP monitor.
>
> Some places accessed Monitor.qmp unconditionally, even for HMP monitors.
> They can't keep doing this now, so during the conversion, they are
> either changed to become conditional on monitor_is_qmp() or to assert()
> that they always get a QMP monitor.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  monitor.c | 220 ++++++++++++++++++++++++++++++------------------------
>  1 file changed, 124 insertions(+), 96 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index a70c1283b1..855a147723 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -168,26 +168,6 @@ struct MonFdset {
[...]
> @@ -712,29 +717,33 @@ static void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
>      }
>      memset(mon, 0, sizeof(Monitor));
>      qemu_mutex_init(&mon->mon_lock);
> -    qemu_mutex_init(&mon->qmp.qmp_queue_lock);
>      mon->outbuf = qstring_new();
>      /* Use *mon_cmds by default. */
>      mon->cmd_table = mon_cmds;
>      mon->skip_flush = skip_flush;
>      mon->use_io_thread = use_io_thread;
> -    mon->qmp.qmp_requests = g_queue_new();
>      mon->flags = flags;
>  }
>  
> +static void monitor_data_destroy_qmp(MonitorQMP *mon)
> +{
> +    json_message_parser_destroy(&mon->parser);
> +    qemu_mutex_destroy(&mon->qmp_queue_lock);
> +    monitor_qmp_cleanup_req_queue_locked(mon);
> +    g_queue_free(mon->qmp_requests);
> +}
> +
>  static void monitor_data_destroy(Monitor *mon)
>  {
>      g_free(mon->mon_cpu_path);
>      qemu_chr_fe_deinit(&mon->chr, false);
>      if (monitor_is_qmp(mon)) {
> -        json_message_parser_destroy(&mon->qmp.parser);
> +        MonitorQMP *qmp_mon = container_of(mon, MonitorQMP, common);
> +        monitor_data_destroy_qmp(qmp_mon);

I dislike declarations hiding among statements, and variables used just
once.  If the variable was used more than once, or its use was in a
complicated expression, or a lengthy line, I'd ask for a blank line to
separate declaration from statement.  But here, I'd prefer

           monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));

Can touch up in my tree.

>      }
>      readline_free(mon->rs);
>      qobject_unref(mon->outbuf);
>      qemu_mutex_destroy(&mon->mon_lock);
> -    qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
> -    monitor_qmp_cleanup_req_queue_locked(mon);
> -    g_queue_free(mon->qmp.qmp_requests);
>  }
>  
>  char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
> @@ -1087,8 +1096,12 @@ static void query_commands_cb(QmpCommand *cmd, void *opaque)
>  CommandInfoList *qmp_query_commands(Error **errp)
>  {
>      CommandInfoList *list = NULL;
> +    MonitorQMP *mon;
> +
> +    assert(monitor_is_qmp(cur_mon));

Could use monitor_cur_is_qmp().  If I mess with it in my tree anyway,
I'll consider changing to it.

> +    mon = container_of(cur_mon, MonitorQMP, common);
>  
> -    qmp_for_each_command(cur_mon->qmp.commands, query_commands_cb, &list);
> +    qmp_for_each_command(mon->commands, query_commands_cb, &list);
>  
>      return list;
>  }
> @@ -1155,16 +1168,16 @@ static void monitor_init_qmp_commands(void)
>                           qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONFIG);
>  }
>  
> -static bool qmp_oob_enabled(Monitor *mon)
> +static bool qmp_oob_enabled(MonitorQMP *mon)
>  {
> -    return mon->qmp.capab[QMP_CAPABILITY_OOB];
> +    return mon->capab[QMP_CAPABILITY_OOB];
>  }
>  
> -static void monitor_qmp_caps_reset(Monitor *mon)
> +static void monitor_qmp_caps_reset(MonitorQMP *mon)
>  {
> -    memset(mon->qmp.capab_offered, 0, sizeof(mon->qmp.capab_offered));
> -    memset(mon->qmp.capab, 0, sizeof(mon->qmp.capab));
> -    mon->qmp.capab_offered[QMP_CAPABILITY_OOB] = mon->use_io_thread;
> +    memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
> +    memset(mon->capab, 0, sizeof(mon->capab));
> +    mon->capab_offered[QMP_CAPABILITY_OOB] = mon->common.use_io_thread;
>  }
>  
>  /*
> @@ -1172,7 +1185,7 @@ static void monitor_qmp_caps_reset(Monitor *mon)
>   * On success, set mon->qmp.capab[], and return true.
>   * On error, set @errp, and return false.
>   */
> -static bool qmp_caps_accept(Monitor *mon, QMPCapabilityList *list,
> +static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
>                              Error **errp)
>  {
>      GString *unavailable = NULL;
> @@ -1181,7 +1194,7 @@ static bool qmp_caps_accept(Monitor *mon, QMPCapabilityList *list,
>      memset(capab, 0, sizeof(capab));
>  
>      for (; list; list = list->next) {
> -        if (!mon->qmp.capab_offered[list->value]) {
> +        if (!mon->capab_offered[list->value]) {
>              if (!unavailable) {
>                  unavailable = g_string_new(QMPCapability_str(list->value));
>              } else {
> @@ -1198,25 +1211,30 @@ static bool qmp_caps_accept(Monitor *mon, QMPCapabilityList *list,
>          return false;
>      }
>  
> -    memcpy(mon->qmp.capab, capab, sizeof(capab));
> +    memcpy(mon->capab, capab, sizeof(capab));
>      return true;
>  }
>  
>  void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
>                            Error **errp)
>  {
> -    if (cur_mon->qmp.commands == &qmp_commands) {
> +    MonitorQMP *mon;
> +
> +    assert(monitor_is_qmp(cur_mon));

Likewise.

> +    mon = container_of(cur_mon, MonitorQMP, common);
> +
> +    if (mon->commands == &qmp_commands) {
>          error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
>                    "Capabilities negotiation is already complete, command "
>                    "ignored");
>          return;
>      }
>  
> -    if (!qmp_caps_accept(cur_mon, enable, errp)) {
> +    if (!qmp_caps_accept(mon, enable, errp)) {
>          return;
>      }
>  
> -    cur_mon->qmp.commands = &qmp_commands;
> +    mon->commands = &qmp_commands;
>  }
>  
>  /* Set the current CPU defined by the user. Callers must hold BQL. */
[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>

