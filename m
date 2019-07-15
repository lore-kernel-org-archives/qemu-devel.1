Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386EAC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B3B2064B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B3B2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn6Mx-00030k-70
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 15:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hn6Ml-0002LX-Di
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hn6Mk-0002kx-1K
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:10:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hn6Mj-0002kA-Ox
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:10:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A10781F0E;
 Mon, 15 Jul 2019 19:10:25 +0000 (UTC)
Received: from localhost (ovpn-112-18.ams2.redhat.com [10.36.112.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E044C5DA34;
 Mon, 15 Jul 2019 19:10:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 23:09:42 +0400
Message-Id: <20190715191001.1188-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190715191001.1188-1-marcandre.lureau@redhat.com>
References: <20190715191001.1188-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 15 Jul 2019 19:10:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 01/20] qmp: constify QmpCommand and list
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 0b69f6f72ce47a37a749b056b6d5ec64c61f11e8 "qapi: remove
qmp_unregister_command()", the command list can be declared const.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 9 +++++----
 monitor/misc.c              | 2 +-
 monitor/monitor-internal.h  | 2 +-
 qapi/qmp-dispatch.c         | 6 +++---
 qapi/qmp-registry.c         | 6 +++---
 qga/commands.c              | 2 +-
 qga/main.c                  | 6 +++---
 7 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 9aa426a398..5a9cf82472 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -39,7 +39,8 @@ typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpComm=
andList;
=20
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
-QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
+const QmpCommand *qmp_find_command(const QmpCommandList *cmds,
+                                   const char *name);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
=20
@@ -47,13 +48,13 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QDict *qmp_error_response(Error *err);
-QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
+QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
                     bool allow_oob);
 bool qmp_is_oob(const QDict *dict);
=20
-typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
+typedef void (*qmp_cmd_callback_fn)(const QmpCommand *cmd, void *opaque)=
;
=20
-void qmp_for_each_command(QmpCommandList *cmds, qmp_cmd_callback_fn fn,
+void qmp_for_each_command(const QmpCommandList *cmds, qmp_cmd_callback_f=
n fn,
                           void *opaque);
=20
 #endif
diff --git a/monitor/misc.c b/monitor/misc.c
index 00338c002a..a0fc5111c5 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -230,7 +230,7 @@ static void hmp_info_help(Monitor *mon, const QDict *=
qdict)
     help_cmd(mon, "info");
 }
=20
-static void query_commands_cb(QmpCommand *cmd, void *opaque)
+static void query_commands_cb(const QmpCommand *cmd, void *opaque)
 {
     CommandInfoList *info, **list =3D opaque;
=20
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 7760b22ba3..b0a028dbf8 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -133,7 +133,7 @@ typedef struct {
      * qmp_capabilities succeeds, we go into command mode, and
      * @command becomes &qmp_commands.
      */
-    QmpCommandList *commands;
+    const QmpCommandList *commands;
     bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
     bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
     /*
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index e2c366e09e..f9d43046aa 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -75,14 +75,14 @@ static QDict *qmp_dispatch_check_obj(const QObject *r=
equest, bool allow_oob,
     return dict;
 }
=20
-static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
+static QObject *do_qmp_dispatch(const QmpCommandList *cmds, QObject *req=
uest,
                                 bool allow_oob, Error **errp)
 {
     Error *local_err =3D NULL;
     bool oob;
     const char *command;
     QDict *args, *dict;
-    QmpCommand *cmd;
+    const QmpCommand *cmd;
     QObject *ret =3D NULL;
=20
     dict =3D qmp_dispatch_check_obj(request, allow_oob, errp);
@@ -163,7 +163,7 @@ bool qmp_is_oob(const QDict *dict)
         && !qdict_haskey(dict, "execute");
 }
=20
-QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
+QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
                     bool allow_oob)
 {
     Error *err =3D NULL;
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index ca00f74795..d0f9a1d3e3 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -27,7 +27,7 @@ void qmp_register_command(QmpCommandList *cmds, const c=
har *name,
     QTAILQ_INSERT_TAIL(cmds, cmd, node);
 }
=20
-QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name)
+const QmpCommand *qmp_find_command(const QmpCommandList *cmds, const cha=
r *name)
 {
     QmpCommand *cmd;
=20
@@ -77,10 +77,10 @@ bool qmp_has_success_response(const QmpCommand *cmd)
     return !(cmd->options & QCO_NO_SUCCESS_RESP);
 }
=20
-void qmp_for_each_command(QmpCommandList *cmds, qmp_cmd_callback_fn fn,
+void qmp_for_each_command(const QmpCommandList *cmds, qmp_cmd_callback_f=
n fn,
                           void *opaque)
 {
-    QmpCommand *cmd;
+    const QmpCommand *cmd;
=20
     QTAILQ_FOREACH(cmd, cmds, node) {
         fn(cmd, opaque);
diff --git a/qga/commands.c b/qga/commands.c
index 0c7d1385c2..05e9ab6c3d 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -54,7 +54,7 @@ void qmp_guest_ping(Error **errp)
     slog("guest-ping called");
 }
=20
-static void qmp_command_info(QmpCommand *cmd, void *opaque)
+static void qmp_command_info(const QmpCommand *cmd, void *opaque)
 {
     GuestAgentInfo *info =3D opaque;
     GuestAgentCommandInfo *cmd_info;
diff --git a/qga/main.c b/qga/main.c
index c35c2a2120..f23614528e 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -359,7 +359,7 @@ static gint ga_strcmp(gconstpointer str1, gconstpoint=
er str2)
 }
=20
 /* disable commands that aren't safe for fsfreeze */
-static void ga_disable_non_whitelisted(QmpCommand *cmd, void *opaque)
+static void ga_disable_non_whitelisted(const QmpCommand *cmd, void *opaq=
ue)
 {
     bool whitelisted =3D false;
     int i =3D 0;
@@ -378,7 +378,7 @@ static void ga_disable_non_whitelisted(QmpCommand *cm=
d, void *opaque)
 }
=20
 /* [re-]enable all commands, except those explicitly blacklisted by user=
 */
-static void ga_enable_non_blacklisted(QmpCommand *cmd, void *opaque)
+static void ga_enable_non_blacklisted(const QmpCommand *cmd, void *opaqu=
e)
 {
     GList *blacklist =3D opaque;
     const char *name =3D qmp_command_name(cmd);
@@ -918,7 +918,7 @@ int64_t ga_get_fd_handle(GAState *s, Error **errp)
     return handle;
 }
=20
-static void ga_print_cmd(QmpCommand *cmd, void *opaque)
+static void ga_print_cmd(const QmpCommand *cmd, void *opaque)
 {
     printf("%s\n", qmp_command_name(cmd));
 }
--=20
2.22.0.428.g6d5b264208


