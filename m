Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F93C31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 20:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF5421852
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 20:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF5421852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcFRj-0006FI-Qv
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 16:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40366)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hcFQ4-0001KL-LQ
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 16:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hcFKZ-0006ia-Ce
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 16:31:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hcFKX-0006Yg-9i; Sat, 15 Jun 2019 16:31:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D605308427E;
 Sat, 15 Jun 2019 20:31:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-23.ams2.redhat.com
 [10.36.116.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17A577C68B;
 Sat, 15 Jun 2019 20:31:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8772811386A6; Sat, 15 Jun 2019 22:31:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
 <87muikedsg.fsf@dusky.pond.sub.org>
 <20190614093219.GC6042@dhcp-200-226.str.redhat.com>
Date: Sat, 15 Jun 2019 22:31:12 +0200
In-Reply-To: <20190614093219.GC6042@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Fri, 14 Jun 2019 11:32:19 +0200")
Message-ID: <8736kabnfz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Sat, 15 Jun 2019 20:31:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 00/15] monitor: Split monitor.c in
 core/HMP/QMP/misc
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

> Am 14.06.2019 um 11:06 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > monitor.c mixes a lot of different things in a single file: The core
>> > monitor infrastructure, HMP infrastrcture, QMP infrastructure, and the
>> > implementation of several HMP and QMP commands. Almost worse, struct
>> > Monitor mixes state for HMP, for QMP, and state actually shared between
>> > all monitors. monitor.c must be linked with a system emulator and even
>> > requires per-target compilation because some of the commands it
>> > implements access system emulator state.
>> >
>> > The reason why I care about this is that I'm working on a protoype for a
>> > storage daemon, which wants to use QMP (but probably not HMP) and
>> > obviously doesn't have any system emulator state. So I'm interested in
>> > some core monitor parts that can be linked to non-system-emulator tools.
>> >
>> > This series first creates separate structs MonitorQMP and MonitorHMP
>> > which inherit from Monitor, and then moves the associated infrastructure
>> > code into separate source files.
>> >
>> > While the split is probably not perfect, I think it's an improvement of
>> > the current state even for QEMU proper, and it's good enough so I can
>> > link my storage daemon against just monitor/core.o and monitor/qmp.o and
>> > get a useless QMP monitor that parses the JSON input and rejects
>> > everything as an unknown command.
>> >
>> > Next I'll try to teach it a subset of QMP commands that can actually be
>> > supported in a tool, but while there will be a few follow-up patches to
>> > achieve this, I don't expect that this work will bring up much that
>> > needs to be changed in the splitting process done in this series.
>> 
>> I think I can address the remaining rather minor issues without a
>> respin.  Please let me know if you disagree with any of my remarks.
>
> Feel free to make the changes you suggested, possibly with the exception
> of the #includes in monitor-internal.h where I think you're only
> partially right (see my reply there).
>
> Please also consider fixing the commit message typo I pointed out for
> patch 15.

Done.  Result in my public repository https://repo.or.cz/qemu/armbru.git
tag pull-monitor-2019-06-15, just in case you want to run your eyes over
it.  Incremental diff appended.

 monitor/hmp-cmds.c         |  5 ++---
 monitor/hmp.c              | 13 +++++++------
 monitor/misc.c             | 27 ++++++---------------------
 monitor/monitor-internal.h | 14 +++++---------
 monitor/monitor.c          | 10 +++-------
 monitor/qmp.c              |  5 +++--
 6 files changed, 26 insertions(+), 48 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 712737cd18..c283dde0e9 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -24,7 +24,7 @@
 #include "qemu/option.h"
 #include "qemu/timer.h"
 #include "qemu/sockets.h"
-#include "monitor/monitor.h"
+#include "monitor/monitor-internal.h"
 #include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
@@ -1943,8 +1943,7 @@ static void hmp_change_read_arg(void *opaque, const char *password,
 
 void hmp_change(Monitor *mon, const QDict *qdict)
 {
-    /* FIXME Make MonitorHMP public and use container_of */
-    MonitorHMP *hmp_mon = (MonitorHMP *) mon;
+    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
     const char *device = qdict_get_str(qdict, "device");
     const char *target = qdict_get_str(qdict, "target");
     const char *arg = qdict_get_try_str(qdict, "arg");
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 43185a7445..5349a81307 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -24,18 +24,17 @@
 
 #include "qemu/osdep.h"
 #include "monitor-internal.h"
-
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
-
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
+#include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
-
 #include "trace.h"
 
 static void monitor_command_cb(void *opaque, const char *cmdline,
@@ -1279,8 +1278,10 @@ static void monitor_find_completion(void *opaque,
         return;
     }
 
-    /* if the line ends with a space, it means we want to complete the
-     * next arg */
+    /*
+     * if the line ends with a space, it means we want to complete the
+     * next arg
+     */
     len = strlen(cmdline);
     if (len > 0 && qemu_isspace(cmdline[len - 1])) {
         if (nb_args >= MAX_ARGS) {
@@ -1395,7 +1396,7 @@ static void monitor_readline_flush(void *opaque)
 
 void monitor_init_hmp(Chardev *chr, bool use_readline)
 {
-    MonitorHMP *mon = g_malloc0(sizeof(*mon));
+    MonitorHMP *mon = g_new0(MonitorHMP, 1);
 
     monitor_data_init(&mon->common, false, false, false);
     qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
diff --git a/monitor/misc.c b/monitor/misc.c
index 49d8c445c4..10f24673f8 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -35,18 +35,12 @@
 #include "exec/gdbstub.h"
 #include "net/net.h"
 #include "net/slirp.h"
-#include "chardev/char-fe.h"
-#include "chardev/char-io.h"
 #include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
-#include "monitor/monitor.h"
-#include "qemu/config-file.h"
 #include "qemu/ctype.h"
-#include "qemu/readline.h"
 #include "ui/console.h"
 #include "ui/input.h"
-#include "sysemu/block-backend.h"
 #include "audio/audio.h"
 #include "disas/disas.h"
 #include "sysemu/balloon.h"
@@ -58,11 +52,7 @@
 #include "sysemu/tpm.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/qlist.h"
 #include "qom/object_interfaces.h"
 #include "trace/control.h"
 #include "monitor/hmp-target.h"
@@ -71,7 +61,6 @@
 #endif
 #include "exec/memory.h"
 #include "exec/exec-all.h"
-#include "qemu/log.h"
 #include "qemu/option.h"
 #include "hmp.h"
 #include "qemu/thread.h"
@@ -81,9 +70,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
 #include "qapi/qapi-introspect.h"
-#include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
-#include "sysemu/iothread.h"
 #include "qemu/cutils.h"
 #include "tcg/tcg.h"
 
@@ -2336,14 +2323,12 @@ compare_mon_cmd(const void *a, const void *b)
 
 static void sortcmdlist(void)
 {
-    int array_num;
-    int elem_size = sizeof(HMPCommand);
-
-    array_num = sizeof(hmp_cmds)/elem_size-1;
-    qsort((void *)hmp_cmds, array_num, elem_size, compare_mon_cmd);
-
-    array_num = sizeof(hmp_info_cmds)/elem_size-1;
-    qsort((void *)hmp_info_cmds, array_num, elem_size, compare_mon_cmd);
+    qsort(hmp_cmds, ARRAY_SIZE(hmp_cmds) - 1,
+          sizeof(*hmp_cmds),
+          compare_mon_cmd);
+    qsort(hmp_info_cmds, ARRAY_SIZE(hmp_info_cmds) - 1,
+          sizeof(*hmp_info_cmds),
+          compare_mon_cmd);
 }
 
 void monitor_init_globals(void)
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 333ebf89e4..7760b22ba3 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -22,19 +22,15 @@
  * THE SOFTWARE.
  */
 
-#ifndef MONITOR_INT_H
-#define MONITOR_INT_H
+#ifndef MONITOR_INTERNAL_H
+#define MONITOR_INTERNAL_H
 
+#include "chardev/char-fe.h"
 #include "monitor/monitor.h"
-#include "qemu/cutils.h"
-
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/dispatch.h"
 #include "qapi/qapi-types-misc.h"
-
+#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp/json-parser.h"
 #include "qemu/readline.h"
-#include "chardev/char-fe.h"
 #include "sysemu/iothread.h"
 
 /*
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 01d8fb5d30..3ef28171c0 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -24,15 +24,13 @@
 
 #include "qemu/osdep.h"
 #include "monitor-internal.h"
-
 #include "qapi/error.h"
 #include "qapi/qapi-emit-events.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "sysemu/qtest.h"
-
 #include "trace.h"
 
 /*
@@ -545,11 +543,9 @@ void monitor_data_destroy(Monitor *mon)
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
-        MonitorQMP *qmp_mon = container_of(mon, MonitorQMP, common);
-        monitor_data_destroy_qmp(qmp_mon);
+        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
     } else {
-        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
-        readline_free(hmp_mon->rs);
+        readline_free(container_of(mon, MonitorHMP, common)->rs);
     }
     qobject_unref(mon->outbuf);
     qemu_mutex_destroy(&mon->mon_lock);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 7258f2b088..e1b196217d 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -28,9 +28,10 @@
 #include "monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qstring.h"
 #include "trace.h"
 
 struct QMPRequest {
@@ -365,7 +366,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
 
 void monitor_init_qmp(Chardev *chr, bool pretty)
 {
-    MonitorQMP *mon = g_malloc0(sizeof(*mon));
+    MonitorQMP *mon = g_new0(MonitorQMP, 1);
 
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
     monitor_data_init(&mon->common, true, false,

