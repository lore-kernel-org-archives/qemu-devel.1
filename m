Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A89C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F12C208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F12C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJls-0003Cb-5f
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hZHZD-0007oO-IJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hZHYu-0004Nu-Fy
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:18:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37700)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hZHYl-0002ZN-LK; Fri, 07 Jun 2019 12:17:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B0733A3EA2;
 Fri,  7 Jun 2019 16:17:15 +0000 (UTC)
Received: from work-vm (ovpn-116-24.ams2.redhat.com [10.36.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 327C610B1149;
 Fri,  7 Jun 2019 16:17:14 +0000 (UTC)
Date: Fri, 7 Jun 2019 17:17:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190607161710.GM2631@work-vm>
References: <20190607135430.22149-1-kwolf@redhat.com>
 <20190607135430.22149-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607135430.22149-4-kwolf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 07 Jun 2019 16:17:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 03/10] monitor: Make MonitorQMP a child
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
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
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor.c | 214 ++++++++++++++++++++++++++++++------------------------
>  1 file changed, 118 insertions(+), 96 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index bb23cc0450..d18cf18393 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -166,26 +166,6 @@ struct MonFdset {
>      QLIST_ENTRY(MonFdset) next;
>  };
>  
> -typedef struct {
> -    JSONMessageParser parser;
> -    /*
> -     * When a client connects, we're in capabilities negotiation mode.
> -     * @commands is &qmp_cap_negotiation_commands then.  When command
> -     * qmp_capabilities succeeds, we go into command mode, and
> -     * @command becomes &qmp_commands.
> -     */
> -    QmpCommandList *commands;
> -    bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
> -    bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
> -    /*
> -     * Protects qmp request/response queue.
> -     * Take monitor_lock first when you need both.
> -     */
> -    QemuMutex qmp_queue_lock;
> -    /* Input queue that holds all the parsed QMP requests */
> -    GQueue *qmp_requests;
> -} MonitorQMP;
> -
>  /*
>   * To prevent flooding clients, events can be throttled. The
>   * throttling is calculated globally, rather than per-Monitor
> @@ -218,7 +198,6 @@ struct Monitor {
>       */
>      ReadLineState *rs;
>  
> -    MonitorQMP qmp;
>      gchar *mon_cpu_path;
>      mon_cmd_t *cmd_table;
>      QTAILQ_ENTRY(Monitor) entry;
> @@ -239,6 +218,27 @@ struct Monitor {
>      int mux_out;
>  };
>  
> +typedef struct {
> +    Monitor common;
> +    JSONMessageParser parser;
> +    /*
> +     * When a client connects, we're in capabilities negotiation mode.
> +     * @commands is &qmp_cap_negotiation_commands then.  When command
> +     * qmp_capabilities succeeds, we go into command mode, and
> +     * @command becomes &qmp_commands.
> +     */
> +    QmpCommandList *commands;
> +    bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
> +    bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
> +    /*
> +     * Protects qmp request/response queue.
> +     * Take monitor_lock first when you need both.
> +     */
> +    QemuMutex qmp_queue_lock;
> +    /* Input queue that holds all the parsed QMP requests */
> +    GQueue *qmp_requests;
> +} MonitorQMP;
> +
>  /* Shared monitor I/O thread */
>  IOThread *mon_iothread;
>  
> @@ -247,7 +247,7 @@ QEMUBH *qmp_dispatcher_bh;
>  
>  struct QMPRequest {
>      /* Owner of the request */
> -    Monitor *mon;
> +    MonitorQMP *mon;
>      /*
>       * Request object to be handled or Error to be reported
>       * (exactly one of them is non-null)
> @@ -355,18 +355,18 @@ static void qmp_request_free(QMPRequest *req)
>  }
>  
>  /* Caller must hold mon->qmp.qmp_queue_lock */
> -static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
> +static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
>  {
> -    while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
> -        qmp_request_free(g_queue_pop_head(mon->qmp.qmp_requests));
> +    while (!g_queue_is_empty(mon->qmp_requests)) {
> +        qmp_request_free(g_queue_pop_head(mon->qmp_requests));
>      }
>  }
>  
> -static void monitor_qmp_cleanup_queues(Monitor *mon)
> +static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
>  {
> -    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> +    qemu_mutex_lock(&mon->qmp_queue_lock);
>      monitor_qmp_cleanup_req_queue_locked(mon);
> -    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +    qemu_mutex_unlock(&mon->qmp_queue_lock);
>  }
>  
>  
> @@ -478,17 +478,17 @@ int monitor_printf(Monitor *mon, const char *fmt, ...)
>      return ret;
>  }
>  
> -static void qmp_send_response(Monitor *mon, const QDict *rsp)
> +static void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
>  {
>      const QObject *data = QOBJECT(rsp);
>      QString *json;
>  
> -    json = mon->flags & MONITOR_USE_PRETTY ? qobject_to_json_pretty(data) :
> -                                             qobject_to_json(data);
> +    json = mon->common.flags & MONITOR_USE_PRETTY ?
> +           qobject_to_json_pretty(data) : qobject_to_json(data);
>      assert(json != NULL);
>  
>      qstring_append_chr(json, '\n');
> -    monitor_puts(mon, qstring_get_str(json));
> +    monitor_puts(&mon->common, qstring_get_str(json));
>  
>      qobject_unref(json);
>  }
> @@ -511,12 +511,17 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>  static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
>  {
>      Monitor *mon;
> +    MonitorQMP *qmp_mon;
>  
>      trace_monitor_protocol_event_emit(event, qdict);
>      QTAILQ_FOREACH(mon, &mon_list, entry) {
> -        if (monitor_is_qmp(mon)
> -            && mon->qmp.commands != &qmp_cap_negotiation_commands) {
> -            qmp_send_response(mon, qdict);
> +        if (!monitor_is_qmp(mon)) {
> +            continue;
> +        }
> +
> +        qmp_mon = container_of(mon, MonitorQMP, common);
> +        if (qmp_mon->commands != &qmp_cap_negotiation_commands) {
> +            qmp_send_response(qmp_mon, qdict);
>          }
>      }
>  }
> @@ -710,29 +715,33 @@ static void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
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
> @@ -1085,8 +1094,9 @@ static void query_commands_cb(QmpCommand *cmd, void *opaque)
>  CommandInfoList *qmp_query_commands(Error **errp)
>  {
>      CommandInfoList *list = NULL;
> +    MonitorQMP *mon = container_of(cur_mon, MonitorQMP, common);
>  
> -    qmp_for_each_command(cur_mon->qmp.commands, query_commands_cb, &list);
> +    qmp_for_each_command(mon->commands, query_commands_cb, &list);
>  
>      return list;
>  }
> @@ -1153,16 +1163,16 @@ static void monitor_init_qmp_commands(void)
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
> @@ -1170,7 +1180,7 @@ static void monitor_qmp_caps_reset(Monitor *mon)
>   * On success, set mon->qmp.capab[], and return true.
>   * On error, set @errp, and return false.
>   */
> -static bool qmp_caps_accept(Monitor *mon, QMPCapabilityList *list,
> +static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
>                              Error **errp)
>  {
>      GString *unavailable = NULL;
> @@ -1179,7 +1189,7 @@ static bool qmp_caps_accept(Monitor *mon, QMPCapabilityList *list,
>      memset(capab, 0, sizeof(capab));
>  
>      for (; list; list = list->next) {
> -        if (!mon->qmp.capab_offered[list->value]) {
> +        if (!mon->capab_offered[list->value]) {
>              if (!unavailable) {
>                  unavailable = g_string_new(QMPCapability_str(list->value));
>              } else {
> @@ -1196,25 +1206,27 @@ static bool qmp_caps_accept(Monitor *mon, QMPCapabilityList *list,
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
> +    MonitorQMP *mon = container_of(cur_mon, MonitorQMP, common);
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
> @@ -4121,27 +4133,27 @@ static int monitor_can_read(void *opaque)
>   * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
>   * Nothing is emitted then.
>   */
> -static void monitor_qmp_respond(Monitor *mon, QDict *rsp)
> +static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
>  {
>      if (rsp) {
>          qmp_send_response(mon, rsp);
>      }
>  }
>  
> -static void monitor_qmp_dispatch(Monitor *mon, QObject *req)
> +static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>  {
>      Monitor *old_mon;
>      QDict *rsp;
>      QDict *error;
>  
>      old_mon = cur_mon;
> -    cur_mon = mon;
> +    cur_mon = &mon->common;
>  
> -    rsp = qmp_dispatch(mon->qmp.commands, req, qmp_oob_enabled(mon));
> +    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
>  
>      cur_mon = old_mon;
>  
> -    if (mon->qmp.commands == &qmp_cap_negotiation_commands) {
> +    if (mon->commands == &qmp_cap_negotiation_commands) {
>          error = qdict_get_qdict(rsp, "error");
>          if (error
>              && !g_strcmp0(qdict_get_try_str(error, "class"),
> @@ -4166,24 +4178,30 @@ static void monitor_qmp_dispatch(Monitor *mon, QObject *req)
>   * monitor to the end of mon_list queue.
>   *
>   * Note: if the function returned with non-NULL, then the caller will
> - * be with mon->qmp.qmp_queue_lock held, and the caller is responsible
> + * be with qmp_mon->qmp_queue_lock held, and the caller is responsible
>   * to release it.
>   */
>  static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
>  {
>      QMPRequest *req_obj = NULL;
>      Monitor *mon;
> +    MonitorQMP *qmp_mon;
>  
>      qemu_mutex_lock(&monitor_lock);
>  
>      QTAILQ_FOREACH(mon, &mon_list, entry) {
> -        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> -        req_obj = g_queue_pop_head(mon->qmp.qmp_requests);
> +        if (!monitor_is_qmp(mon)) {
> +            continue;
> +        }
> +
> +        qmp_mon = container_of(mon, MonitorQMP, common);
> +        qemu_mutex_lock(&qmp_mon->qmp_queue_lock);
> +        req_obj = g_queue_pop_head(qmp_mon->qmp_requests);
>          if (req_obj) {
>              /* With the lock of corresponding queue held */
>              break;
>          }
> -        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +        qemu_mutex_unlock(&qmp_mon->qmp_queue_lock);
>      }
>  
>      if (req_obj) {
> @@ -4205,7 +4223,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
>      QMPRequest *req_obj = monitor_qmp_requests_pop_any_with_lock();
>      QDict *rsp;
>      bool need_resume;
> -    Monitor *mon;
> +    MonitorQMP *mon;
>  
>      if (!req_obj) {
>          return;
> @@ -4214,8 +4232,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
>      mon = req_obj->mon;
>      /*  qmp_oob_enabled() might change after "qmp_capabilities" */
>      need_resume = !qmp_oob_enabled(mon) ||
> -        mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
> -    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +        mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
> +    qemu_mutex_unlock(&mon->qmp_queue_lock);
>      if (req_obj->req) {
>          QDict *qdict = qobject_to(QDict, req_obj->req);
>          QObject *id = qdict ? qdict_get(qdict, "id") : NULL;
> @@ -4231,7 +4249,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
>  
>      if (need_resume) {
>          /* Pairs with the monitor_suspend() in handle_qmp_command() */
> -        monitor_resume(mon);
> +        monitor_resume(&mon->common);
>      }
>      qmp_request_free(req_obj);
>  
> @@ -4241,7 +4259,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
>  
>  static void handle_qmp_command(void *opaque, QObject *req, Error *err)
>  {
> -    Monitor *mon = opaque;
> +    MonitorQMP *mon = opaque;
>      QObject *id = NULL;
>      QDict *qdict;
>      QMPRequest *req_obj;
> @@ -4273,7 +4291,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
>      req_obj->err = err;
>  
>      /* Protect qmp_requests and fetching its length. */
> -    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> +    qemu_mutex_lock(&mon->qmp_queue_lock);
>  
>      /*
>       * Suspend the monitor when we can't queue more requests after
> @@ -4282,8 +4300,8 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
>       * command, for backward compatibility.
>       */
>      if (!qmp_oob_enabled(mon) ||
> -        mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
> -        monitor_suspend(mon);
> +        mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
> +        monitor_suspend(&mon->common);
>      }
>  
>      /*
> @@ -4291,9 +4309,9 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
>       * handled in time order.  Ownership for req_obj, req,
>       * etc. will be delivered to the handler side.
>       */
> -    assert(mon->qmp.qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
> -    g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
> -    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +    assert(mon->qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
> +    g_queue_push_tail(mon->qmp_requests, req_obj);
> +    qemu_mutex_unlock(&mon->qmp_queue_lock);
>  
>      /* Kick the dispatcher routine */
>      qemu_bh_schedule(qmp_dispatcher_bh);
> @@ -4301,9 +4319,9 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
>  
>  static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
>  {
> -    Monitor *mon = opaque;
> +    MonitorQMP *mon = opaque;
>  
> -    json_message_parser_feed(&mon->qmp.parser, (const char *) buf, size);
> +    json_message_parser_feed(&mon->parser, (const char *) buf, size);
>  }
>  
>  static void monitor_read(void *opaque, const uint8_t *buf, int size)
> @@ -4389,7 +4407,7 @@ void monitor_resume(Monitor *mon)
>      trace_monitor_suspend(mon, -1);
>  }
>  
> -static QDict *qmp_greeting(Monitor *mon)
> +static QDict *qmp_greeting(MonitorQMP *mon)
>  {
>      QList *cap_list = qlist_new();
>      QObject *ver = NULL;
> @@ -4398,7 +4416,7 @@ static QDict *qmp_greeting(Monitor *mon)
>      qmp_marshal_query_version(NULL, &ver, NULL);
>  
>      for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
> -        if (mon->qmp.capab_offered[cap]) {
> +        if (mon->capab_offered[cap]) {
>              qlist_append_str(cap_list, QMPCapability_str(cap));
>          }
>      }
> @@ -4411,11 +4429,11 @@ static QDict *qmp_greeting(Monitor *mon)
>  static void monitor_qmp_event(void *opaque, int event)
>  {
>      QDict *data;
> -    Monitor *mon = opaque;
> +    MonitorQMP *mon = opaque;
>  
>      switch (event) {
>      case CHR_EVENT_OPENED:
> -        mon->qmp.commands = &qmp_cap_negotiation_commands;
> +        mon->commands = &qmp_cap_negotiation_commands;
>          monitor_qmp_caps_reset(mon);
>          data = qmp_greeting(mon);
>          qmp_send_response(mon, data);
> @@ -4430,8 +4448,8 @@ static void monitor_qmp_event(void *opaque, int event)
>           * is closed.
>           */
>          monitor_qmp_cleanup_queues(mon);
> -        json_message_parser_destroy(&mon->qmp.parser);
> -        json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
> +        json_message_parser_destroy(&mon->parser);
> +        json_message_parser_init(&mon->parser, handle_qmp_command,
>                                   mon, NULL);
>          mon_refcount--;
>          monitor_fdsets_cleanup();
> @@ -4593,30 +4611,34 @@ static void monitor_list_append(Monitor *mon)
>  
>  static void monitor_qmp_setup_handlers_bh(void *opaque)
>  {
> -    Monitor *mon = opaque;
> +    MonitorQMP *mon = opaque;
>      GMainContext *context;
>  
> -    assert(mon->use_io_thread);
> +    assert(mon->common.use_io_thread);
>      context = iothread_get_g_main_context(mon_iothread);
>      assert(context);
> -    qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
> -                             monitor_qmp_event, NULL, mon, context, true);
> -    monitor_list_append(mon);
> +    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
> +                             monitor_qmp_read, monitor_qmp_event,
> +                             NULL, &mon->common, context, true);
> +    monitor_list_append(&mon->common);
>  }
>  
>  static void monitor_init_qmp(Chardev *chr, int flags)
>  {
> -    Monitor *mon = g_malloc(sizeof(*mon));
> +    MonitorQMP *mon = g_malloc0(sizeof(*mon));
>  
>      /* Note: we run QMP monitor in I/O thread when @chr supports that */
> -    monitor_data_init(mon, flags, false,
> +    monitor_data_init(&mon->common, flags, false,
>                        qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
>  
> -    qemu_chr_fe_init(&mon->chr, chr, &error_abort);
> -    qemu_chr_fe_set_echo(&mon->chr, true);
> +    qemu_mutex_init(&mon->qmp_queue_lock);
> +    mon->qmp_requests = g_queue_new();
>  
> -    json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon, NULL);
> -    if (mon->use_io_thread) {
> +    qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
> +    qemu_chr_fe_set_echo(&mon->common.chr, true);
> +
> +    json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
> +    if (mon->common.use_io_thread) {
>          /*
>           * Make sure the old iowatch is gone.  It's possible when
>           * e.g. the chardev is in client mode, with wait=on.
> @@ -4631,10 +4653,10 @@ static void monitor_init_qmp(Chardev *chr, int flags)
>                                  monitor_qmp_setup_handlers_bh, mon);
>          /* The bottom half will add @mon to @mon_list */
>      } else {
> -        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
> +        qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
>                                   monitor_qmp_read, monitor_qmp_event,
> -                                 NULL, mon, NULL, true);
> -        monitor_list_append(mon);
> +                                 NULL, &mon->common, NULL, true);
> +        monitor_list_append(&mon->common);
>      }
>  }
>  
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

