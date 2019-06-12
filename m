Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAA2C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D4321734
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D4321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5ZM-0006Kb-8C
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 11:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hb5Xd-0005o8-J9
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hb5Xa-0006vh-CC
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hb5XT-0006lm-3i; Wed, 12 Jun 2019 11:51:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DAE03087944;
 Wed, 12 Jun 2019 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-60.ams2.redhat.com
 [10.36.117.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D90653DE4;
 Wed, 12 Jun 2019 15:51:40 +0000 (UTC)
Date: Wed, 12 Jun 2019 17:51:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190612155139.GG9699@localhost.localdomain>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-12-kwolf@redhat.com>
 <87pnniykvm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnniykvm.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 12 Jun 2019 15:51:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 11/11] monitor: Split out
 monitor/monitor.c
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

Am 12.06.2019 um 15:49 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Move the monitor core infrastructure from monitor/misc.c to
> > monitor/monitor.c. This is code that can be shared for all targets, so
> > compile it only once.
> >
> > What remains in monitor/misc.c after this patch is mostly monitor
> > command implementations and code that requires a system emulator or is
> > even target-dependent.
> 
> I think target-independent command handlers should move to qmp-cmds.c
> and hmp-cmds.c.  Okay to leave for later.  Mentioning it the commit
> message wouldn't hurt, though.
> 
> Also left in misc.c, and bulky enough for mention: completion callbacks.
> They should perhaps move next to their command handlers.  Okay to leave
> for later.

Ok.

> > The amount of function and particularly extern variables in
> > monitor_int.h is probably a bit larger than it needs to be, but this way
> > no non-trivial code modifications are needed. The interfaces between all
> > monitor parts can be cleaned up later.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  include/monitor/monitor.h |   1 +
> >  monitor/monitor_int.h     |   1 +
> >  monitor/misc.c            | 568 +----------------------------------
> >  monitor/monitor.c         | 605 ++++++++++++++++++++++++++++++++++++++
> >  MAINTAINERS               |   2 +
> >  monitor/Makefile.objs     |   2 +-
> >  monitor/trace-events      |   2 +-
> >  7 files changed, 612 insertions(+), 569 deletions(-)
> >  create mode 100644 monitor/monitor.c
> >
> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> > index 8547529e49..b9f8d175ed 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -20,6 +20,7 @@ typedef struct MonitorHMP MonitorHMP;
> >  bool monitor_cur_is_qmp(void);
> >  
> >  void monitor_init_globals(void);
> > +void monitor_init_globals_core(void);
> >  void monitor_init(Chardev *chr, int flags);
> >  void monitor_init_qmp(Chardev *chr, int flags);
> >  void monitor_init_hmp(Chardev *chr, int flags);
> > diff --git a/monitor/monitor_int.h b/monitor/monitor_int.h
> > index 88eaed9c5c..d5fb5162f3 100644
> > --- a/monitor/monitor_int.h
> > +++ b/monitor/monitor_int.h
> > @@ -191,6 +191,7 @@ extern mon_cmd_t mon_cmds[];
> >  int monitor_puts(Monitor *mon, const char *str);
> >  void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
> >                         bool use_io_thread);
> > +void monitor_data_destroy(Monitor *mon);
> >  int monitor_can_read(void *opaque);
> >  void monitor_list_append(Monitor *mon);
> >  void monitor_fdsets_cleanup(void);
> > diff --git a/monitor/misc.c b/monitor/misc.c
> > index 4f1168b7c3..a4ec850493 100644
> > --- a/monitor/misc.c
> > +++ b/monitor/misc.c
> > @@ -62,7 +62,6 @@
> >  #include "qapi/qmp/json-parser.h"
> >  #include "qapi/qmp/qlist.h"
> >  #include "qom/object_interfaces.h"
> > -#include "trace.h"
> >  #include "trace/control.h"
> >  #include "monitor/hmp-target.h"
> >  #ifdef CONFIG_TRACE_SIMPLE
> > @@ -117,43 +116,13 @@ struct MonFdset {
> >      QLIST_ENTRY(MonFdset) next;
> >  };
> >  
> > -/*
> > - * To prevent flooding clients, events can be throttled. The
> > - * throttling is calculated globally, rather than per-Monitor
> > - * instance.
> > - */
> > -typedef struct MonitorQAPIEventState {
> > -    QAPIEvent event;    /* Throttling state for this event type and... */
> > -    QDict *data;        /* ... data, see qapi_event_throttle_equal() */
> > -    QEMUTimer *timer;   /* Timer for handling delayed events */
> > -    QDict *qdict;       /* Delayed event (if any) */
> > -} MonitorQAPIEventState;
> > -
> > -typedef struct {
> > -    int64_t rate;       /* Minimum time (in ns) between two events */
> > -} MonitorQAPIEventConf;
> > -
> > -/* Shared monitor I/O thread */
> > -IOThread *mon_iothread;
> > -
> > -/* Bottom half to dispatch the requests received from I/O thread */
> > -QEMUBH *qmp_dispatcher_bh;
> > -
> >  /* QMP checker flags */
> >  #define QMP_ACCEPT_UNKNOWNS 1
> >  
> > -/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
> > -QemuMutex monitor_lock;
> > -static GHashTable *monitor_qapi_event_state;
> > -MonitorList mon_list;
> > -static bool monitor_destroyed;
> > -
> >  /* Protects mon_fdsets */
> >  static QemuMutex mon_fdsets_lock;
> >  static QLIST_HEAD(, MonFdset) mon_fdsets;
> >  
> > -int mon_refcount;
> > -
> >  static mon_cmd_t info_cmds[];
> >  
> >  __thread Monitor *cur_mon;
> > @@ -161,32 +130,6 @@ __thread Monitor *cur_mon;
> >  static void monitor_command_cb(void *opaque, const char *cmdline,
> >                                 void *readline_opaque);
> >  
> > -/**
> > - * Is @mon is using readline?
> > - * Note: not all HMP monitors use readline, e.g., gdbserver has a
> > - * non-interactive HMP monitor, so readline is not used there.
> > - */
> > -static inline bool monitor_uses_readline(const Monitor *mon)
> > -{
> > -    return mon->flags & MONITOR_USE_READLINE;
> > -}
> > -
> > -static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
> > -{
> > -    return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
> > -}
> > -
> > -/*
> > - * Return the clock to use for recording an event's time.
> > - * It's QEMU_CLOCK_REALTIME, except for qtests it's
> > - * QEMU_CLOCK_VIRTUAL, to support testing rate limits.
> > - * Beware: result is invalid before configure_accelerator().
> > - */
> > -static inline QEMUClockType monitor_get_event_clock(void)
> > -{
> > -    return qtest_enabled() ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME;
> > -}
> > -
> >  /**
> >   * Is the current monitor, if any, a QMP monitor?
> >   */
>    bool monitor_cur_is_qmp(void)
>    {
>        return cur_mon && monitor_is_qmp(cur_mon);
>    }
> 
> I can see why monitor_cur_is_qmp() stays here.  But why do the next two
> stay?
> 
>    void monitor_read_command(MonitorHMP *mon, int show_prompt)
>    {
>        if (!mon->rs)
>            return;
> 
>        readline_start(mon->rs, "(qemu) ", 0, monitor_command_cb, NULL);
>        if (show_prompt)
>            readline_show_prompt(mon->rs);
>    }
> 
>    int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
>                              void *opaque)
>    {
>        if (mon->rs) {
>            readline_start(mon->rs, "Password: ", 1, readline_func, opaque);
>            /* prompt is printed on return from the command handler */
>            return 0;
>        } else {
>            monitor_printf(&mon->common,
>                           "terminal does not support password prompting\n");
>            return -ENOTTY;
>        }
>    }

No real reason. These can move to hmp.c together with
monitor_command_cb().

> > @@ -220,355 +163,6 @@ int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
> >  }
> >  
> >  
> > -static void monitor_flush_locked(Monitor *mon);
> > -
> > -static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
> > -                                  void *opaque)
> > -{
> > -    Monitor *mon = opaque;
> > -
> > -    qemu_mutex_lock(&mon->mon_lock);
> > -    mon->out_watch = 0;
> > -    monitor_flush_locked(mon);
> > -    qemu_mutex_unlock(&mon->mon_lock);
> > -    return FALSE;
> > -}
> > -
> > -/* Caller must hold mon->mon_lock */
> > -static void monitor_flush_locked(Monitor *mon)
> > -{
> > -    int rc;
> > -    size_t len;
> > -    const char *buf;
> > -
> > -    if (mon->skip_flush) {
> > -        return;
> > -    }
> > -
> > -    buf = qstring_get_str(mon->outbuf);
> > -    len = qstring_get_length(mon->outbuf);
> > -
> > -    if (len && !mon->mux_out) {
> > -        rc = qemu_chr_fe_write(&mon->chr, (const uint8_t *) buf, len);
> > -        if ((rc < 0 && errno != EAGAIN) || (rc == len)) {
> > -            /* all flushed or error */
> > -            qobject_unref(mon->outbuf);
> > -            mon->outbuf = qstring_new();
> > -            return;
> > -        }
> > -        if (rc > 0) {
> > -            /* partial write */
> > -            QString *tmp = qstring_from_str(buf + rc);
> > -            qobject_unref(mon->outbuf);
> > -            mon->outbuf = tmp;
> > -        }
> > -        if (mon->out_watch == 0) {
> > -            mon->out_watch =
> > -                qemu_chr_fe_add_watch(&mon->chr, G_IO_OUT | G_IO_HUP,
> > -                                      monitor_unblocked, mon);
> > -        }
> > -    }
> > -}
> > -
> > -void monitor_flush(Monitor *mon)
> > -{
> > -    qemu_mutex_lock(&mon->mon_lock);
> > -    monitor_flush_locked(mon);
> > -    qemu_mutex_unlock(&mon->mon_lock);
> > -}
> > -
> > -/* flush at every end of line */
> > -int monitor_puts(Monitor *mon, const char *str)
> > -{
> > -    int i;
> > -    char c;
> > -
> > -    qemu_mutex_lock(&mon->mon_lock);
> > -    for (i = 0; str[i]; i++) {
> > -        c = str[i];
> > -        if (c == '\n') {
> > -            qstring_append_chr(mon->outbuf, '\r');
> > -        }
> > -        qstring_append_chr(mon->outbuf, c);
> > -        if (c == '\n') {
> > -            monitor_flush_locked(mon);
> > -        }
> > -    }
> > -    qemu_mutex_unlock(&mon->mon_lock);
> > -
> > -    return i;
> > -}
> > -
> > -int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> > -{
> > -    char *buf;
> > -    int n;
> > -
> > -    if (!mon)
> > -        return -1;
> > -
> > -    if (monitor_is_qmp(mon)) {
> > -        return -1;
> > -    }
> > -
> > -    buf = g_strdup_vprintf(fmt, ap);
> > -    n = monitor_puts(mon, buf);
> > -    g_free(buf);
> > -    return n;
> > -}
> > -
> > -int monitor_printf(Monitor *mon, const char *fmt, ...)
> > -{
> > -    int ret;
> > -
> > -    va_list ap;
> > -    va_start(ap, fmt);
> > -    ret = monitor_vprintf(mon, fmt, ap);
> > -    va_end(ap);
> > -    return ret;
> > -}
> > -
> > -static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
> > -    /* Limit guest-triggerable events to 1 per second */
> > -    [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
> > -    [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
> > -    [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
> > -    [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
> > -    [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
> > -    [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
> > -};
> > -
> > -/*
> > - * Broadcast an event to all monitors.
> > - * @qdict is the event object.  Its member "event" must match @event.
> > - * Caller must hold monitor_lock.
> > - */
> > -static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
> > -{
> > -    Monitor *mon;
> > -    MonitorQMP *qmp_mon;
> > -
> > -    trace_monitor_protocol_event_emit(event, qdict);
> > -    QTAILQ_FOREACH(mon, &mon_list, entry) {
> > -        if (!monitor_is_qmp(mon)) {
> > -            continue;
> > -        }
> > -
> > -        qmp_mon = container_of(mon, MonitorQMP, common);
> > -        if (qmp_mon->commands != &qmp_cap_negotiation_commands) {
> > -            qmp_send_response(qmp_mon, qdict);
> > -        }
> > -    }
> > -}
> > -
> > -static void monitor_qapi_event_handler(void *opaque);
> > -
> > -/*
> > - * Queue a new event for emission to Monitor instances,
> > - * applying any rate limiting if required.
> > - */
> > -static void
> > -monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
> > -{
> > -    MonitorQAPIEventConf *evconf;
> > -    MonitorQAPIEventState *evstate;
> > -
> > -    assert(event < QAPI_EVENT__MAX);
> > -    evconf = &monitor_qapi_event_conf[event];
> > -    trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
> > -
> > -    qemu_mutex_lock(&monitor_lock);
> > -
> > -    if (!evconf->rate) {
> > -        /* Unthrottled event */
> > -        monitor_qapi_event_emit(event, qdict);
> > -    } else {
> > -        QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
> > -        MonitorQAPIEventState key = { .event = event, .data = data };
> > -
> > -        evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
> > -        assert(!evstate || timer_pending(evstate->timer));
> > -
> > -        if (evstate) {
> > -            /*
> > -             * Timer is pending for (at least) evconf->rate ns after
> > -             * last send.  Store event for sending when timer fires,
> > -             * replacing a prior stored event if any.
> > -             */
> > -            qobject_unref(evstate->qdict);
> > -            evstate->qdict = qobject_ref(qdict);
> > -        } else {
> > -            /*
> > -             * Last send was (at least) evconf->rate ns ago.
> > -             * Send immediately, and arm the timer to call
> > -             * monitor_qapi_event_handler() in evconf->rate ns.  Any
> > -             * events arriving before then will be delayed until then.
> > -             */
> > -            int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
> > -
> > -            monitor_qapi_event_emit(event, qdict);
> > -
> > -            evstate = g_new(MonitorQAPIEventState, 1);
> > -            evstate->event = event;
> > -            evstate->data = qobject_ref(data);
> > -            evstate->qdict = NULL;
> > -            evstate->timer = timer_new_ns(monitor_get_event_clock(),
> > -                                          monitor_qapi_event_handler,
> > -                                          evstate);
> > -            g_hash_table_add(monitor_qapi_event_state, evstate);
> > -            timer_mod_ns(evstate->timer, now + evconf->rate);
> > -        }
> > -    }
> > -
> > -    qemu_mutex_unlock(&monitor_lock);
> > -}
> > -
> > -void qapi_event_emit(QAPIEvent event, QDict *qdict)
> > -{
> > -    /*
> > -     * monitor_qapi_event_queue_no_reenter() is not reentrant: it
> > -     * would deadlock on monitor_lock.  Work around by queueing
> > -     * events in thread-local storage.
> > -     * TODO: remove this, make it re-enter safe.
> > -     */
> > -    typedef struct MonitorQapiEvent {
> > -        QAPIEvent event;
> > -        QDict *qdict;
> > -        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
> > -    } MonitorQapiEvent;
> > -    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
> > -    static __thread bool reentered;
> > -    MonitorQapiEvent *ev;
> > -
> > -    if (!reentered) {
> > -        QSIMPLEQ_INIT(&event_queue);
> > -    }
> > -
> > -    ev = g_new(MonitorQapiEvent, 1);
> > -    ev->qdict = qobject_ref(qdict);
> > -    ev->event = event;
> > -    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
> > -    if (reentered) {
> > -        return;
> > -    }
> > -
> > -    reentered = true;
> > -
> > -    while ((ev = QSIMPLEQ_FIRST(&event_queue)) != NULL) {
> > -        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);
> > -        monitor_qapi_event_queue_no_reenter(ev->event, ev->qdict);
> > -        qobject_unref(ev->qdict);
> > -        g_free(ev);
> > -    }
> > -
> > -    reentered = false;
> > -}
> > -
> > -/*
> > - * This function runs evconf->rate ns after sending a throttled
> > - * event.
> > - * If another event has since been stored, send it.
> > - */
> > -static void monitor_qapi_event_handler(void *opaque)
> > -{
> > -    MonitorQAPIEventState *evstate = opaque;
> > -    MonitorQAPIEventConf *evconf = &monitor_qapi_event_conf[evstate->event];
> > -
> > -    trace_monitor_protocol_event_handler(evstate->event, evstate->qdict);
> > -    qemu_mutex_lock(&monitor_lock);
> > -
> > -    if (evstate->qdict) {
> > -        int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
> > -
> > -        monitor_qapi_event_emit(evstate->event, evstate->qdict);
> > -        qobject_unref(evstate->qdict);
> > -        evstate->qdict = NULL;
> > -        timer_mod_ns(evstate->timer, now + evconf->rate);
> > -    } else {
> > -        g_hash_table_remove(monitor_qapi_event_state, evstate);
> > -        qobject_unref(evstate->data);
> > -        timer_free(evstate->timer);
> > -        g_free(evstate);
> > -    }
> > -
> > -    qemu_mutex_unlock(&monitor_lock);
> > -}
> > -
> > -static unsigned int qapi_event_throttle_hash(const void *key)
> > -{
> > -    const MonitorQAPIEventState *evstate = key;
> > -    unsigned int hash = evstate->event * 255;
> > -
> > -    if (evstate->event == QAPI_EVENT_VSERPORT_CHANGE) {
> > -        hash += g_str_hash(qdict_get_str(evstate->data, "id"));
> > -    }
> > -
> > -    if (evstate->event == QAPI_EVENT_QUORUM_REPORT_BAD) {
> > -        hash += g_str_hash(qdict_get_str(evstate->data, "node-name"));
> > -    }
> > -
> > -    return hash;
> > -}
> > -
> > -static gboolean qapi_event_throttle_equal(const void *a, const void *b)
> > -{
> > -    const MonitorQAPIEventState *eva = a;
> > -    const MonitorQAPIEventState *evb = b;
> > -
> > -    if (eva->event != evb->event) {
> > -        return FALSE;
> > -    }
> > -
> > -    if (eva->event == QAPI_EVENT_VSERPORT_CHANGE) {
> > -        return !strcmp(qdict_get_str(eva->data, "id"),
> > -                       qdict_get_str(evb->data, "id"));
> > -    }
> > -
> > -    if (eva->event == QAPI_EVENT_QUORUM_REPORT_BAD) {
> > -        return !strcmp(qdict_get_str(eva->data, "node-name"),
> > -                       qdict_get_str(evb->data, "node-name"));
> > -    }
> > -
> > -    return TRUE;
> > -}
> > -
> > -static void monitor_qapi_event_init(void)
> > -{
> > -    monitor_qapi_event_state = g_hash_table_new(qapi_event_throttle_hash,
> > -                                                qapi_event_throttle_equal);
> > -}
> > -
> > -static void monitor_iothread_init(void);
> > -
> > -void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
> > -                       bool use_io_thread)
> > -{
> > -    if (use_io_thread && !mon_iothread) {
> > -        monitor_iothread_init();
> > -    }
> > -    memset(mon, 0, sizeof(Monitor));
> > -    qemu_mutex_init(&mon->mon_lock);
> > -    mon->outbuf = qstring_new();
> > -    mon->skip_flush = skip_flush;
> > -    mon->use_io_thread = use_io_thread;
> > -    mon->flags = flags;
> > -}
> > -
> > -static void monitor_data_destroy(Monitor *mon)
> > -{
> > -    g_free(mon->mon_cpu_path);
> > -    qemu_chr_fe_deinit(&mon->chr, false);
> > -    if (monitor_is_qmp(mon)) {
> > -        MonitorQMP *qmp_mon = container_of(mon, MonitorQMP, common);
> > -        monitor_data_destroy_qmp(qmp_mon);
> > -    } else {
> > -        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> > -        readline_free(hmp_mon->rs);
> > -    }
> > -    qobject_unref(mon->outbuf);
> > -    qemu_mutex_destroy(&mon->mon_lock);
> > -}
> > -
> >  char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
> >                                  int64_t cpu_index, Error **errp)
> >  {
> [...]
> 
>    static void monitor_init_qmp_commands(void)
>    {
>        /*
>         * Two command lists:
>         * - qmp_commands contains all QMP commands
>         * - qmp_cap_negotiation_commands contains just
>         *   "qmp_capabilities", to enforce capability negotiation
>         */
> 
>        qmp_init_marshal(&qmp_commands);
> 
>        qmp_register_command(&qmp_commands, "query-qmp-schema",
>                             qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
>        qmp_register_command(&qmp_commands, "device_add", qmp_device_add,
>                             QCO_NO_OPTIONS);
>        qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
>                             QCO_NO_OPTIONS);
> 
>        QTAILQ_INIT(&qmp_cap_negotiation_commands);
>        qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
>                             qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONFIG);
>    }
> 
> Should have been moved to qmp.c in PATCH 09.

No, like the mon_cmds definitions for HMP, this is system emulator code
that must not be moved to the monitor core.

> > @@ -2875,90 +2393,6 @@ int error_vprintf_unless_qmp(const char *fmt, va_list ap)
> 
> Why do these two stay?
> 
>    /*
>     * Print to current monitor if we have one, else to stderr.
>     */
>    int error_vprintf(const char *fmt, va_list ap)
>    {
>        if (cur_mon && !monitor_cur_is_qmp()) {
>            return monitor_vprintf(cur_mon, fmt, ap);
>        }
>        return vfprintf(stderr, fmt, ap);
>    }
> 
>    int error_vprintf_unless_qmp(const char *fmt, va_list ap)
>    {
>        if (!cur_mon) {
>            return vfprintf(stderr, fmt, ap);
>        }
>        if (!monitor_cur_is_qmp()) {
>            return monitor_vprintf(cur_mon, fmt, ap);
>        }
> >      return -1;
> >  }

I think these can move to monitor.c.

Kevin

