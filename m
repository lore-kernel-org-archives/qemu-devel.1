Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47264C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098EC2133D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098EC2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45645 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtMH-0003Xh-09
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:12:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtKS-0001wp-9C
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtKQ-0004Q1-ON
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtKQ-0004M2-C6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62160369CA;
	Tue,  9 Apr 2019 16:10:22 +0000 (UTC)
Received: from localhost (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 50DCF5D9C9;
	Tue,  9 Apr 2019 16:10:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:09:50 +0200
Message-Id: <20190409161009.6322-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 09 Apr 2019 16:10:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 01/20] qmp: constify QmpCommand and list
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409160950.czcItjDmVeuGPI_NSQ1ZOtEPlof3vROYxxmbxxNtH_s@z>

Since 0b69f6f72ce47a37a749b056b6d5ec64c61f11e8 "qapi: remove
qmp_unregister_command()", the command list can be declared const.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 9 +++++----
 monitor.c                   | 4 ++--
 qapi/qmp-dispatch.c         | 6 +++---
 qapi/qmp-registry.c         | 6 +++---
 qga/commands.c              | 2 +-
 qga/main.c                  | 6 +++---
 6 files changed, 17 insertions(+), 16 deletions(-)

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
diff --git a/monitor.c b/monitor.c
index 4807bbe811..abc5bdc4ba 100644
--- a/monitor.c
+++ b/monitor.c
@@ -174,7 +174,7 @@ typedef struct {
      * qmp_capabilities succeeds, we go into command mode, and
      * @command becomes &qmp_commands.
      */
-    QmpCommandList *commands;
+    const QmpCommandList *commands;
     bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
     bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
     /*
@@ -1071,7 +1071,7 @@ static void hmp_info_help(Monitor *mon, const QDict=
 *qdict)
     help_cmd(mon, "info");
 }
=20
-static void query_commands_cb(QmpCommand *cmd, void *opaque)
+static void query_commands_cb(const QmpCommand *cmd, void *opaque)
 {
     CommandInfoList *info, **list =3D opaque;
=20
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
index c0d77c79c4..5b144b9250 100644
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
2.21.0.196.g041f5ea1cf


