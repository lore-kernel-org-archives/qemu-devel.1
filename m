Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F625C31E4B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679D421743
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679D421743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSs5-0001Lu-IV
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59894)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbRko-0000Ns-Lp
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbRkm-0003Nh-Ju
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbRkW-00037v-Uz; Thu, 13 Jun 2019 11:34:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB8A7308626C;
 Thu, 13 Jun 2019 15:34:43 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-246.ams2.redhat.com
 [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38F496108C;
 Thu, 13 Jun 2019 15:34:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:33:56 +0200
Message-Id: <20190613153405.24769-7-kwolf@redhat.com>
In-Reply-To: <20190613153405.24769-1-kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 15:34:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 06/15] monitor: Rename HMP command type and
 tables
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This renames the type for HMP monitor commands and the tables holding
the commands to make clear that they are related to HMP and to allow
making them public later:

* mon_cmd_t -> HMPCommand (fixing use of a reserved name, too)
* mon_cmds -> hmp_cmds
* info_cmds -> hmp_info_cmds

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor.c       | 68 ++++++++++++++++++++++++-------------------------
 hmp-commands.hx |  2 +-
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/monitor.c b/monitor.c
index 5eacaa48a6..006c650761 100644
--- a/monitor.c
+++ b/monitor.c
@@ -127,7 +127,7 @@
  *
  */
=20
-typedef struct mon_cmd_t {
+typedef struct HMPCommand {
     const char *name;
     const char *args_type;
     const char *params;
@@ -138,9 +138,9 @@ typedef struct mon_cmd_t {
      * cmd should be used. If it exists, sub_table[?].cmd should be
      * used, and cmd of 1st level plays the role of help function.
      */
-    struct mon_cmd_t *sub_table;
+    struct HMPCommand *sub_table;
     void (*command_completion)(ReadLineState *rs, int nb_args, const cha=
r *str);
-} mon_cmd_t;
+} HMPCommand;
=20
 /* file descriptors passed via SCM_RIGHTS */
 typedef struct mon_fd_t mon_fd_t;
@@ -277,8 +277,8 @@ static QLIST_HEAD(, MonFdset) mon_fdsets;
=20
 static int mon_refcount;
=20
-static mon_cmd_t mon_cmds[];
-static mon_cmd_t info_cmds[];
+static HMPCommand hmp_cmds[];
+static HMPCommand hmp_info_cmds[];
=20
 QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
=20
@@ -935,7 +935,7 @@ static int parse_cmdline(const char *cmdline,
 /*
  * Can command @cmd be executed in preconfig state?
  */
-static bool cmd_can_preconfig(const mon_cmd_t *cmd)
+static bool cmd_can_preconfig(const HMPCommand *cmd)
 {
     if (!cmd->flags) {
         return false;
@@ -945,7 +945,7 @@ static bool cmd_can_preconfig(const mon_cmd_t *cmd)
 }
=20
 static void help_cmd_dump_one(Monitor *mon,
-                              const mon_cmd_t *cmd,
+                              const HMPCommand *cmd,
                               char **prefix_args,
                               int prefix_args_nb)
 {
@@ -962,10 +962,10 @@ static void help_cmd_dump_one(Monitor *mon,
 }
=20
 /* @args[@arg_index] is the valid command need to find in @cmds */
-static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
+static void help_cmd_dump(Monitor *mon, const HMPCommand *cmds,
                           char **args, int nb_args, int arg_index)
 {
-    const mon_cmd_t *cmd;
+    const HMPCommand *cmd;
     size_t i;
=20
     /* No valid arg need to compare with, dump all in *cmds */
@@ -1023,7 +1023,7 @@ static void help_cmd(Monitor *mon, const char *name=
)
     }
=20
     /* 2. dump the contents according to parsed args */
-    help_cmd_dump(mon, mon_cmds, args, nb_args, 0);
+    help_cmd_dump(mon, hmp_cmds, args, nb_args, 0);
=20
     free_cmdline_args(args, nb_args);
 }
@@ -2691,13 +2691,13 @@ int monitor_fd_param(Monitor *mon, const char *fd=
name, Error **errp)
 }
=20
 /* Please update hmp-commands.hx when adding or changing commands */
-static mon_cmd_t info_cmds[] =3D {
+static HMPCommand hmp_info_cmds[] =3D {
 #include "hmp-commands-info.h"
     { NULL, NULL, },
 };
=20
-/* mon_cmds and info_cmds would be sorted at runtime */
-static mon_cmd_t mon_cmds[] =3D {
+/* hmp_cmds and hmp_info_cmds would be sorted at runtime */
+static HMPCommand hmp_cmds[] =3D {
 #include "hmp-commands.h"
     { NULL, NULL, },
 };
@@ -3039,10 +3039,10 @@ static int is_valid_option(const char *c, const c=
har *typestr)
     return (typestr !=3D NULL);
 }
=20
-static const mon_cmd_t *search_dispatch_table(const mon_cmd_t *disp_tabl=
e,
-                                              const char *cmdname)
+static const HMPCommand *search_dispatch_table(const HMPCommand *disp_ta=
ble,
+                                               const char *cmdname)
 {
-    const mon_cmd_t *cmd;
+    const HMPCommand *cmd;
=20
     for (cmd =3D disp_table; cmd->name !=3D NULL; cmd++) {
         if (compare_cmd(cmdname, cmd->name)) {
@@ -3063,14 +3063,14 @@ static const mon_cmd_t *search_dispatch_table(con=
st mon_cmd_t *disp_table,
  * Do not assume the return value points into @table!  It doesn't when
  * the command is found in a sub-command table.
  */
-static const mon_cmd_t *monitor_parse_command(MonitorHMP *hmp_mon,
-                                              const char *cmdp_start,
-                                              const char **cmdp,
-                                              mon_cmd_t *table)
+static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
+                                               const char *cmdp_start,
+                                               const char **cmdp,
+                                               HMPCommand *table)
 {
     Monitor *mon =3D &hmp_mon->common;
     const char *p;
-    const mon_cmd_t *cmd;
+    const HMPCommand *cmd;
     char cmdname[256];
=20
     /* extract the command name */
@@ -3114,7 +3114,7 @@ static const mon_cmd_t *monitor_parse_command(Monit=
orHMP *hmp_mon,
=20
 static QDict *monitor_parse_arguments(Monitor *mon,
                                       const char **endp,
-                                      const mon_cmd_t *cmd)
+                                      const HMPCommand *cmd)
 {
     const char *typestr;
     char *key;
@@ -3479,12 +3479,12 @@ fail:
 static void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
 {
     QDict *qdict;
-    const mon_cmd_t *cmd;
+    const HMPCommand *cmd;
     const char *cmd_start =3D cmdline;
=20
     trace_handle_hmp_command(mon, cmdline);
=20
-    cmd =3D monitor_parse_command(mon, cmdline, &cmdline, mon_cmds);
+    cmd =3D monitor_parse_command(mon, cmdline, &cmdline, hmp_cmds);
     if (!cmd) {
         return;
     }
@@ -4017,14 +4017,14 @@ void loadvm_completion(ReadLineState *rs, int nb_=
args, const char *str)
 }
=20
 static void monitor_find_completion_by_table(MonitorHMP *mon,
-                                             const mon_cmd_t *cmd_table,
+                                             const HMPCommand *cmd_table=
,
                                              char **args,
                                              int nb_args)
 {
     const char *cmdname;
     int i;
     const char *ptype, *old_ptype, *str, *name;
-    const mon_cmd_t *cmd;
+    const HMPCommand *cmd;
     BlockBackend *blk =3D NULL;
=20
     if (nb_args <=3D 1) {
@@ -4131,7 +4131,7 @@ static void monitor_find_completion(void *opaque,
     }
=20
     /* 2. auto complete according to args */
-    monitor_find_completion_by_table(mon, mon_cmds, args, nb_args);
+    monitor_find_completion_by_table(mon, hmp_cmds, args, nb_args);
=20
 cleanup:
     free_cmdline_args(args, nb_args);
@@ -4531,20 +4531,20 @@ static void monitor_event(void *opaque, int event=
)
 static int
 compare_mon_cmd(const void *a, const void *b)
 {
-    return strcmp(((const mon_cmd_t *)a)->name,
-            ((const mon_cmd_t *)b)->name);
+    return strcmp(((const HMPCommand *)a)->name,
+            ((const HMPCommand *)b)->name);
 }
=20
 static void sortcmdlist(void)
 {
     int array_num;
-    int elem_size =3D sizeof(mon_cmd_t);
+    int elem_size =3D sizeof(HMPCommand);
=20
-    array_num =3D sizeof(mon_cmds)/elem_size-1;
-    qsort((void *)mon_cmds, array_num, elem_size, compare_mon_cmd);
+    array_num =3D sizeof(hmp_cmds)/elem_size-1;
+    qsort((void *)hmp_cmds, array_num, elem_size, compare_mon_cmd);
=20
-    array_num =3D sizeof(info_cmds)/elem_size-1;
-    qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
+    array_num =3D sizeof(hmp_info_cmds)/elem_size-1;
+    qsort((void *)hmp_info_cmds, array_num, elem_size, compare_mon_cmd);
 }
=20
 static void monitor_iothread_init(void)
diff --git a/hmp-commands.hx b/hmp-commands.hx
index a2c3ffc218..8b7aec3e8d 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1934,7 +1934,7 @@ ETEXI
         .params     =3D "[subcommand]",
         .help       =3D "show various information about the system state=
",
         .cmd        =3D hmp_info_help,
-        .sub_table  =3D info_cmds,
+        .sub_table  =3D hmp_info_cmds,
         .flags      =3D "p",
     },
=20
--=20
2.20.1


