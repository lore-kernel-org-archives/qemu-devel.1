Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276B1C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE753208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE753208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwxG-0001LB-3s
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40388)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hcwh0-0001XV-3G
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hcwgw-0007oz-DQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hcwgv-0007gk-RN
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5B95D1796
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 18:49:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE25B90AC;
 Mon, 17 Jun 2019 18:49:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C5B01136448; Mon, 17 Jun 2019 20:49:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:48:51 +0200
Message-Id: <20190617184903.19436-5-armbru@redhat.com>
In-Reply-To: <20190617184903.19436-1-armbru@redhat.com>
References: <20190617184903.19436-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 17 Jun 2019 18:49:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/16] monitor: Make MonitorQMP a child class of
 Monitor
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Currently, struct Monitor mixes state that is only relevant for HMP,
state that is only relevant for QMP, and some actually shared state.
In particular, a MonitorQMP field is present in the state of any
monitor, even if it's not a QMP monitor and therefore doesn't use the
state.

As a first step towards a clean separation between QMP and HMP, let
MonitorQMP extend Monitor and create a MonitorQMP object only when the
monitor is actually a QMP monitor.

Some places accessed Monitor.qmp unconditionally, even for HMP monitors.
They can't keep doing this now, so during the conversion, they are
either changed to become conditional on monitor_is_qmp() or to assert()
that they always get a QMP monitor.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190613153405.24769-4-kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Superfluous variable in monitor_data_destroy() eliminated]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 219 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 123 insertions(+), 96 deletions(-)

diff --git a/monitor.c b/monitor.c
index 261342a0f6..15f94fc41f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -168,26 +168,6 @@ struct MonFdset {
     QLIST_ENTRY(MonFdset) next;
 };
=20
-typedef struct {
-    JSONMessageParser parser;
-    /*
-     * When a client connects, we're in capabilities negotiation mode.
-     * @commands is &qmp_cap_negotiation_commands then.  When command
-     * qmp_capabilities succeeds, we go into command mode, and
-     * @command becomes &qmp_commands.
-     */
-    QmpCommandList *commands;
-    bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
-    bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
-    /*
-     * Protects qmp request/response queue.
-     * Take monitor_lock first when you need both.
-     */
-    QemuMutex qmp_queue_lock;
-    /* Input queue that holds all the parsed QMP requests */
-    GQueue *qmp_requests;
-} MonitorQMP;
-
 /*
  * To prevent flooding clients, events can be throttled. The
  * throttling is calculated globally, rather than per-Monitor
@@ -220,7 +200,6 @@ struct Monitor {
      */
     ReadLineState *rs;
=20
-    MonitorQMP qmp;
     gchar *mon_cpu_path;
     mon_cmd_t *cmd_table;
     QTAILQ_ENTRY(Monitor) entry;
@@ -241,6 +220,27 @@ struct Monitor {
     int mux_out;
 };
=20
+typedef struct {
+    Monitor common;
+    JSONMessageParser parser;
+    /*
+     * When a client connects, we're in capabilities negotiation mode.
+     * @commands is &qmp_cap_negotiation_commands then.  When command
+     * qmp_capabilities succeeds, we go into command mode, and
+     * @command becomes &qmp_commands.
+     */
+    QmpCommandList *commands;
+    bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
+    bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
+    /*
+     * Protects qmp request/response queue.
+     * Take monitor_lock first when you need both.
+     */
+    QemuMutex qmp_queue_lock;
+    /* Input queue that holds all the parsed QMP requests */
+    GQueue *qmp_requests;
+} MonitorQMP;
+
 /* Shared monitor I/O thread */
 IOThread *mon_iothread;
=20
@@ -249,7 +249,7 @@ QEMUBH *qmp_dispatcher_bh;
=20
 struct QMPRequest {
     /* Owner of the request */
-    Monitor *mon;
+    MonitorQMP *mon;
     /*
      * Request object to be handled or Error to be reported
      * (exactly one of them is non-null)
@@ -357,18 +357,18 @@ static void qmp_request_free(QMPRequest *req)
 }
=20
 /* Caller must hold mon->qmp.qmp_queue_lock */
-static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
+static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
 {
-    while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
-        qmp_request_free(g_queue_pop_head(mon->qmp.qmp_requests));
+    while (!g_queue_is_empty(mon->qmp_requests)) {
+        qmp_request_free(g_queue_pop_head(mon->qmp_requests));
     }
 }
=20
-static void monitor_qmp_cleanup_queues(Monitor *mon)
+static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
 {
-    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_lock(&mon->qmp_queue_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
-    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_unlock(&mon->qmp_queue_lock);
 }
=20
=20
@@ -480,17 +480,17 @@ int monitor_printf(Monitor *mon, const char *fmt, .=
..)
     return ret;
 }
=20
-static void qmp_send_response(Monitor *mon, const QDict *rsp)
+static void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
 {
     const QObject *data =3D QOBJECT(rsp);
     QString *json;
=20
-    json =3D mon->flags & MONITOR_USE_PRETTY ? qobject_to_json_pretty(da=
ta) :
-                                             qobject_to_json(data);
+    json =3D mon->common.flags & MONITOR_USE_PRETTY ?
+           qobject_to_json_pretty(data) : qobject_to_json(data);
     assert(json !=3D NULL);
=20
     qstring_append_chr(json, '\n');
-    monitor_puts(mon, qstring_get_str(json));
+    monitor_puts(&mon->common, qstring_get_str(json));
=20
     qobject_unref(json);
 }
@@ -513,12 +513,17 @@ static MonitorQAPIEventConf monitor_qapi_event_conf=
[QAPI_EVENT__MAX] =3D {
 static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
     Monitor *mon;
+    MonitorQMP *qmp_mon;
=20
     trace_monitor_protocol_event_emit(event, qdict);
     QTAILQ_FOREACH(mon, &mon_list, entry) {
-        if (monitor_is_qmp(mon)
-            && mon->qmp.commands !=3D &qmp_cap_negotiation_commands) {
-            qmp_send_response(mon, qdict);
+        if (!monitor_is_qmp(mon)) {
+            continue;
+        }
+
+        qmp_mon =3D container_of(mon, MonitorQMP, common);
+        if (qmp_mon->commands !=3D &qmp_cap_negotiation_commands) {
+            qmp_send_response(qmp_mon, qdict);
         }
     }
 }
@@ -711,29 +716,32 @@ static void monitor_data_init(Monitor *mon, int fla=
gs, bool skip_flush,
         monitor_iothread_init();
     }
     qemu_mutex_init(&mon->mon_lock);
-    qemu_mutex_init(&mon->qmp.qmp_queue_lock);
     mon->outbuf =3D qstring_new();
     /* Use *mon_cmds by default. */
     mon->cmd_table =3D mon_cmds;
     mon->skip_flush =3D skip_flush;
     mon->use_io_thread =3D use_io_thread;
-    mon->qmp.qmp_requests =3D g_queue_new();
     mon->flags =3D flags;
 }
=20
+static void monitor_data_destroy_qmp(MonitorQMP *mon)
+{
+    json_message_parser_destroy(&mon->parser);
+    qemu_mutex_destroy(&mon->qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(mon);
+    g_queue_free(mon->qmp_requests);
+}
+
 static void monitor_data_destroy(Monitor *mon)
 {
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
-        json_message_parser_destroy(&mon->qmp.parser);
+        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
     }
     readline_free(mon->rs);
     qobject_unref(mon->outbuf);
     qemu_mutex_destroy(&mon->mon_lock);
-    qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
-    monitor_qmp_cleanup_req_queue_locked(mon);
-    g_queue_free(mon->qmp.qmp_requests);
 }
=20
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_i=
ndex,
@@ -1087,8 +1095,12 @@ static void query_commands_cb(QmpCommand *cmd, voi=
d *opaque)
 CommandInfoList *qmp_query_commands(Error **errp)
 {
     CommandInfoList *list =3D NULL;
+    MonitorQMP *mon;
=20
-    qmp_for_each_command(cur_mon->qmp.commands, query_commands_cb, &list=
);
+    assert(monitor_is_qmp(cur_mon));
+    mon =3D container_of(cur_mon, MonitorQMP, common);
+
+    qmp_for_each_command(mon->commands, query_commands_cb, &list);
=20
     return list;
 }
@@ -1155,16 +1167,16 @@ static void monitor_init_qmp_commands(void)
                          qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONF=
IG);
 }
=20
-static bool qmp_oob_enabled(Monitor *mon)
+static bool qmp_oob_enabled(MonitorQMP *mon)
 {
-    return mon->qmp.capab[QMP_CAPABILITY_OOB];
+    return mon->capab[QMP_CAPABILITY_OOB];
 }
=20
-static void monitor_qmp_caps_reset(Monitor *mon)
+static void monitor_qmp_caps_reset(MonitorQMP *mon)
 {
-    memset(mon->qmp.capab_offered, 0, sizeof(mon->qmp.capab_offered));
-    memset(mon->qmp.capab, 0, sizeof(mon->qmp.capab));
-    mon->qmp.capab_offered[QMP_CAPABILITY_OOB] =3D mon->use_io_thread;
+    memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
+    memset(mon->capab, 0, sizeof(mon->capab));
+    mon->capab_offered[QMP_CAPABILITY_OOB] =3D mon->common.use_io_thread=
;
 }
=20
 /*
@@ -1172,7 +1184,7 @@ static void monitor_qmp_caps_reset(Monitor *mon)
  * On success, set mon->qmp.capab[], and return true.
  * On error, set @errp, and return false.
  */
-static bool qmp_caps_accept(Monitor *mon, QMPCapabilityList *list,
+static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
                             Error **errp)
 {
     GString *unavailable =3D NULL;
@@ -1181,7 +1193,7 @@ static bool qmp_caps_accept(Monitor *mon, QMPCapabi=
lityList *list,
     memset(capab, 0, sizeof(capab));
=20
     for (; list; list =3D list->next) {
-        if (!mon->qmp.capab_offered[list->value]) {
+        if (!mon->capab_offered[list->value]) {
             if (!unavailable) {
                 unavailable =3D g_string_new(QMPCapability_str(list->val=
ue));
             } else {
@@ -1198,25 +1210,30 @@ static bool qmp_caps_accept(Monitor *mon, QMPCapa=
bilityList *list,
         return false;
     }
=20
-    memcpy(mon->qmp.capab, capab, sizeof(capab));
+    memcpy(mon->capab, capab, sizeof(capab));
     return true;
 }
=20
 void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
                           Error **errp)
 {
-    if (cur_mon->qmp.commands =3D=3D &qmp_commands) {
+    MonitorQMP *mon;
+
+    assert(monitor_is_qmp(cur_mon));
+    mon =3D container_of(cur_mon, MonitorQMP, common);
+
+    if (mon->commands =3D=3D &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "Capabilities negotiation is already complete, command=
 "
                   "ignored");
         return;
     }
=20
-    if (!qmp_caps_accept(cur_mon, enable, errp)) {
+    if (!qmp_caps_accept(mon, enable, errp)) {
         return;
     }
=20
-    cur_mon->qmp.commands =3D &qmp_commands;
+    mon->commands =3D &qmp_commands;
 }
=20
 /* Set the current CPU defined by the user. Callers must hold BQL. */
@@ -4123,27 +4140,27 @@ static int monitor_can_read(void *opaque)
  * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
  * Nothing is emitted then.
  */
-static void monitor_qmp_respond(Monitor *mon, QDict *rsp)
+static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
 {
     if (rsp) {
         qmp_send_response(mon, rsp);
     }
 }
=20
-static void monitor_qmp_dispatch(Monitor *mon, QObject *req)
+static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
 {
     Monitor *old_mon;
     QDict *rsp;
     QDict *error;
=20
     old_mon =3D cur_mon;
-    cur_mon =3D mon;
+    cur_mon =3D &mon->common;
=20
-    rsp =3D qmp_dispatch(mon->qmp.commands, req, qmp_oob_enabled(mon));
+    rsp =3D qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
=20
     cur_mon =3D old_mon;
=20
-    if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
+    if (mon->commands =3D=3D &qmp_cap_negotiation_commands) {
         error =3D qdict_get_qdict(rsp, "error");
         if (error
             && !g_strcmp0(qdict_get_try_str(error, "class"),
@@ -4168,24 +4185,30 @@ static void monitor_qmp_dispatch(Monitor *mon, QO=
bject *req)
  * monitor to the end of mon_list queue.
  *
  * Note: if the function returned with non-NULL, then the caller will
- * be with mon->qmp.qmp_queue_lock held, and the caller is responsible
+ * be with qmp_mon->qmp_queue_lock held, and the caller is responsible
  * to release it.
  */
 static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
 {
     QMPRequest *req_obj =3D NULL;
     Monitor *mon;
+    MonitorQMP *qmp_mon;
=20
     qemu_mutex_lock(&monitor_lock);
=20
     QTAILQ_FOREACH(mon, &mon_list, entry) {
-        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
-        req_obj =3D g_queue_pop_head(mon->qmp.qmp_requests);
+        if (!monitor_is_qmp(mon)) {
+            continue;
+        }
+
+        qmp_mon =3D container_of(mon, MonitorQMP, common);
+        qemu_mutex_lock(&qmp_mon->qmp_queue_lock);
+        req_obj =3D g_queue_pop_head(qmp_mon->qmp_requests);
         if (req_obj) {
             /* With the lock of corresponding queue held */
             break;
         }
-        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+        qemu_mutex_unlock(&qmp_mon->qmp_queue_lock);
     }
=20
     if (req_obj) {
@@ -4207,7 +4230,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
     QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock();
     QDict *rsp;
     bool need_resume;
-    Monitor *mon;
+    MonitorQMP *mon;
=20
     if (!req_obj) {
         return;
@@ -4216,8 +4239,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
     mon =3D req_obj->mon;
     /*  qmp_oob_enabled() might change after "qmp_capabilities" */
     need_resume =3D !qmp_oob_enabled(mon) ||
-        mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
-    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
+    qemu_mutex_unlock(&mon->qmp_queue_lock);
     if (req_obj->req) {
         QDict *qdict =3D qobject_to(QDict, req_obj->req);
         QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
@@ -4233,7 +4256,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
=20
     if (need_resume) {
         /* Pairs with the monitor_suspend() in handle_qmp_command() */
-        monitor_resume(mon);
+        monitor_resume(&mon->common);
     }
     qmp_request_free(req_obj);
=20
@@ -4243,7 +4266,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
=20
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
-    Monitor *mon =3D opaque;
+    MonitorQMP *mon =3D opaque;
     QObject *id =3D NULL;
     QDict *qdict;
     QMPRequest *req_obj;
@@ -4275,7 +4298,7 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
     req_obj->err =3D err;
=20
     /* Protect qmp_requests and fetching its length. */
-    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_lock(&mon->qmp_queue_lock);
=20
     /*
      * Suspend the monitor when we can't queue more requests after
@@ -4284,8 +4307,8 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
      * command, for backward compatibility.
      */
     if (!qmp_oob_enabled(mon) ||
-        mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1) =
{
-        monitor_suspend(mon);
+        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1) {
+        monitor_suspend(&mon->common);
     }
=20
     /*
@@ -4293,9 +4316,9 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
      * handled in time order.  Ownership for req_obj, req,
      * etc. will be delivered to the handler side.
      */
-    assert(mon->qmp.qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
-    g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
-    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+    assert(mon->qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
+    g_queue_push_tail(mon->qmp_requests, req_obj);
+    qemu_mutex_unlock(&mon->qmp_queue_lock);
=20
     /* Kick the dispatcher routine */
     qemu_bh_schedule(qmp_dispatcher_bh);
@@ -4303,9 +4326,9 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
=20
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
 {
-    Monitor *mon =3D opaque;
+    MonitorQMP *mon =3D opaque;
=20
-    json_message_parser_feed(&mon->qmp.parser, (const char *) buf, size)=
;
+    json_message_parser_feed(&mon->parser, (const char *) buf, size);
 }
=20
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
@@ -4391,7 +4414,7 @@ void monitor_resume(Monitor *mon)
     trace_monitor_suspend(mon, -1);
 }
=20
-static QDict *qmp_greeting(Monitor *mon)
+static QDict *qmp_greeting(MonitorQMP *mon)
 {
     QList *cap_list =3D qlist_new();
     QObject *ver =3D NULL;
@@ -4400,7 +4423,7 @@ static QDict *qmp_greeting(Monitor *mon)
     qmp_marshal_query_version(NULL, &ver, NULL);
=20
     for (cap =3D 0; cap < QMP_CAPABILITY__MAX; cap++) {
-        if (mon->qmp.capab_offered[cap]) {
+        if (mon->capab_offered[cap]) {
             qlist_append_str(cap_list, QMPCapability_str(cap));
         }
     }
@@ -4413,11 +4436,11 @@ static QDict *qmp_greeting(Monitor *mon)
 static void monitor_qmp_event(void *opaque, int event)
 {
     QDict *data;
-    Monitor *mon =3D opaque;
+    MonitorQMP *mon =3D opaque;
=20
     switch (event) {
     case CHR_EVENT_OPENED:
-        mon->qmp.commands =3D &qmp_cap_negotiation_commands;
+        mon->commands =3D &qmp_cap_negotiation_commands;
         monitor_qmp_caps_reset(mon);
         data =3D qmp_greeting(mon);
         qmp_send_response(mon, data);
@@ -4432,8 +4455,8 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
          * is closed.
          */
         monitor_qmp_cleanup_queues(mon);
-        json_message_parser_destroy(&mon->qmp.parser);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
+        json_message_parser_destroy(&mon->parser);
+        json_message_parser_init(&mon->parser, handle_qmp_command,
                                  mon, NULL);
         mon_refcount--;
         monitor_fdsets_cleanup();
@@ -4595,33 +4618,37 @@ static void monitor_list_append(Monitor *mon)
=20
 static void monitor_qmp_setup_handlers_bh(void *opaque)
 {
-    Monitor *mon =3D opaque;
+    MonitorQMP *mon =3D opaque;
     GMainContext *context;
=20
-    assert(mon->use_io_thread);
+    assert(mon->common.use_io_thread);
     context =3D iothread_get_g_main_context(mon_iothread);
     assert(context);
-    qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_re=
ad,
-                             monitor_qmp_event, NULL, mon, context, true=
);
-    monitor_list_append(mon);
+    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
+                             monitor_qmp_read, monitor_qmp_event,
+                             NULL, &mon->common, context, true);
+    monitor_list_append(&mon->common);
 }
=20
 static void monitor_init_qmp(Chardev *chr, int flags)
 {
-    Monitor *mon =3D g_new0(Monitor, 1);
+    MonitorQMP *mon =3D g_new0(MonitorQMP, 1);
=20
     /* Only HMP supports readline */
     assert(!(flags & MONITOR_USE_READLINE));
=20
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    monitor_data_init(mon, flags, false,
+    monitor_data_init(&mon->common, flags, false,
                       qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTE=
XT));
=20
-    qemu_chr_fe_init(&mon->chr, chr, &error_abort);
-    qemu_chr_fe_set_echo(&mon->chr, true);
+    qemu_mutex_init(&mon->qmp_queue_lock);
+    mon->qmp_requests =3D g_queue_new();
=20
-    json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon, =
NULL);
-    if (mon->use_io_thread) {
+    qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
+    qemu_chr_fe_set_echo(&mon->common.chr, true);
+
+    json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL=
);
+    if (mon->common.use_io_thread) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=3Don.
@@ -4636,10 +4663,10 @@ static void monitor_init_qmp(Chardev *chr, int fl=
ags)
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
-        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
+        qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
                                  monitor_qmp_read, monitor_qmp_event,
-                                 NULL, mon, NULL, true);
-        monitor_list_append(mon);
+                                 NULL, &mon->common, NULL, true);
+        monitor_list_append(&mon->common);
     }
 }
=20
--=20
2.21.0


