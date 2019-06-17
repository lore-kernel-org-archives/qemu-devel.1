Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E0C31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68CB2082C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68CB2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwym-0002Oj-Se
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40672)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hcwhH-00029B-Jp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hcwhF-000850-DH
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hcwhF-0007le-3Y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B5CA2E95BE
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 18:49:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99BF37FA2C;
 Mon, 17 Jun 2019 18:49:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73F5A1133010; Mon, 17 Jun 2019 20:49:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:48:57 +0200
Message-Id: <20190617184903.19436-11-armbru@redhat.com>
In-Reply-To: <20190617184903.19436-1-armbru@redhat.com>
References: <20190617184903.19436-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 17 Jun 2019 18:49:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/16] monitor: Create monitor-internal.h with
 common definitions
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

Before we can split monitor/misc.c, we need to create a header file that
contains the common definitions that will be used by multiple source
files.

For a start, add the type definitions for Monitor, MonitorHMP and
MonitorQMP and their dependencies. We'll add functions as needed when
splitting monitor/misc.c.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190613153405.24769-10-kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Header guard symbol tidied up, superfluous #include dropped, FIXME in
hmp_change() resolved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS                |   2 +
 monitor/hmp-cmds.c         |   5 +-
 monitor/misc.c             | 114 +----------------------------
 monitor/monitor-internal.h | 145 +++++++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 116 deletions(-)
 create mode 100644 monitor/monitor-internal.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c7d366727..15f21c35e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1918,6 +1918,7 @@ F: qapi/run-state.json
 Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 S: Maintained
+F: monitor/monitor-internal.h
 F: monitor/misc.c
 F: monitor/hmp*
 F: hmp.h
@@ -2040,6 +2041,7 @@ F: tests/check-qom-proplist.c
 QMP
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
+F: monitor/monitor-internal.h
 F: monitor/qmp*
 F: monitor/misc.c
 F: docs/devel/*qmp-*
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index c917e24d9c..c283dde0e9 100644
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
@@ -1943,8 +1943,7 @@ static void hmp_change_read_arg(void *opaque, const=
 char *password,
=20
 void hmp_change(Monitor *mon, const QDict *qdict)
 {
-    /* FIXME Make MonitorHMP public and use container_of */
-    MonitorHMP *hmp_mon =3D (MonitorHMP *)mon;
+    MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
     const char *device =3D qdict_get_str(qdict, "device");
     const char *target =3D qdict_get_str(qdict, "target");
     const char *arg =3D qdict_get_try_str(qdict, "arg");
diff --git a/monitor/misc.c b/monitor/misc.c
index c5f8483b7e..3cdbb681fb 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "monitor-internal.h"
 #include "qemu/units.h"
 #include <dirent.h>
 #include "cpu.h"
@@ -35,15 +36,12 @@
 #include "exec/gdbstub.h"
 #include "net/net.h"
 #include "net/slirp.h"
-#include "chardev/char-fe.h"
 #include "chardev/char-io.h"
 #include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
-#include "monitor/monitor.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
-#include "qemu/readline.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "sysemu/block-backend.h"
@@ -61,7 +59,6 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qlist.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
@@ -93,55 +90,6 @@
 #include "hw/s390x/storage-attributes.h"
 #endif
=20
-/*
- * Supported types:
- *
- * 'F'          filename
- * 'B'          block device name
- * 's'          string (accept optional quote)
- * 'S'          it just appends the rest of the string (accept optional =
quote)
- * 'O'          option string of the form NAME=3DVALUE,...
- *              parsed according to QemuOptsList given by its name
- *              Example: 'device:O' uses qemu_device_opts.
- *              Restriction: only lists with empty desc are supported
- *              TODO lift the restriction
- * 'i'          32 bit integer
- * 'l'          target long (32 or 64 bit)
- * 'M'          Non-negative target long (32 or 64 bit), in user mode th=
e
- *              value is multiplied by 2^20 (think Mebibyte)
- * 'o'          octets (aka bytes)
- *              user mode accepts an optional E, e, P, p, T, t, G, g, M,=
 m,
- *              K, k suffix, which multiplies the value by 2^60 for suff=
ixes E
- *              and e, 2^50 for suffixes P and p, 2^40 for suffixes T an=
d t,
- *              2^30 for suffixes G and g, 2^20 for M and m, 2^10 for K =
and k
- * 'T'          double
- *              user mode accepts an optional ms, us, ns suffix,
- *              which divides the value by 1e3, 1e6, 1e9, respectively
- * '/'          optional gdb-like print format (like "/10x")
- *
- * '?'          optional type (for all types, except '/')
- * '.'          other form of optional type (for 'i' and 'l')
- * 'b'          boolean
- *              user mode accepts "on" or "off"
- * '-'          optional parameter (eg. '-f')
- *
- */
-
-typedef struct HMPCommand {
-    const char *name;
-    const char *args_type;
-    const char *params;
-    const char *help;
-    const char *flags; /* p=3Dpreconfig */
-    void (*cmd)(Monitor *mon, const QDict *qdict);
-    /* @sub_table is a list of 2nd level of commands. If it does not exi=
st,
-     * cmd should be used. If it exists, sub_table[?].cmd should be
-     * used, and cmd of 1st level plays the role of help function.
-     */
-    struct HMPCommand *sub_table;
-    void (*command_completion)(ReadLineState *rs, int nb_args, const cha=
r *str);
-} HMPCommand;
-
 /* file descriptors passed via SCM_RIGHTS */
 typedef struct mon_fd_t mon_fd_t;
 struct mon_fd_t {
@@ -184,66 +132,6 @@ typedef struct {
     int64_t rate;       /* Minimum time (in ns) between two events */
 } MonitorQAPIEventConf;
=20
-struct Monitor {
-    CharBackend chr;
-    int reset_seen;
-    int flags;
-    int suspend_cnt;            /* Needs to be accessed atomically */
-    bool skip_flush;
-    bool use_io_thread;
-
-    gchar *mon_cpu_path;
-    QTAILQ_ENTRY(Monitor) entry;
-
-    /*
-     * The per-monitor lock. We can't access guest memory when holding
-     * the lock.
-     */
-    QemuMutex mon_lock;
-
-    /*
-     * Members that are protected by the per-monitor lock
-     */
-    QLIST_HEAD(, mon_fd_t) fds;
-    QString *outbuf;
-    guint out_watch;
-    /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
-    int mux_out;
-};
-
-struct MonitorHMP {
-    Monitor common;
-    /*
-     * State used only in the thread "owning" the monitor.
-     * If @use_io_thread, this is @mon_iothread. (This does not actually=
 happen
-     * in the current state of the code.)
-     * Else, it's the main thread.
-     * These members can be safely accessed without locks.
-     */
-    ReadLineState *rs;
-};
-
-typedef struct {
-    Monitor common;
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
 /* Shared monitor I/O thread */
 IOThread *mon_iothread;
=20
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
new file mode 100644
index 0000000000..ebaf0201c8
--- /dev/null
+++ b/monitor/monitor-internal.h
@@ -0,0 +1,145 @@
+/*
+ * QEMU monitor
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#ifndef MONITOR_INTERNAL_H
+#define MONITOR_INTERNAL_H
+
+#include "chardev/char-fe.h"
+#include "monitor/monitor.h"
+#include "qapi/qapi-types-misc.h"
+#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp/json-parser.h"
+#include "qemu/readline.h"
+
+/*
+ * Supported types:
+ *
+ * 'F'          filename
+ * 'B'          block device name
+ * 's'          string (accept optional quote)
+ * 'S'          it just appends the rest of the string (accept optional =
quote)
+ * 'O'          option string of the form NAME=3DVALUE,...
+ *              parsed according to QemuOptsList given by its name
+ *              Example: 'device:O' uses qemu_device_opts.
+ *              Restriction: only lists with empty desc are supported
+ *              TODO lift the restriction
+ * 'i'          32 bit integer
+ * 'l'          target long (32 or 64 bit)
+ * 'M'          Non-negative target long (32 or 64 bit), in user mode th=
e
+ *              value is multiplied by 2^20 (think Mebibyte)
+ * 'o'          octets (aka bytes)
+ *              user mode accepts an optional E, e, P, p, T, t, G, g, M,=
 m,
+ *              K, k suffix, which multiplies the value by 2^60 for suff=
ixes E
+ *              and e, 2^50 for suffixes P and p, 2^40 for suffixes T an=
d t,
+ *              2^30 for suffixes G and g, 2^20 for M and m, 2^10 for K =
and k
+ * 'T'          double
+ *              user mode accepts an optional ms, us, ns suffix,
+ *              which divides the value by 1e3, 1e6, 1e9, respectively
+ * '/'          optional gdb-like print format (like "/10x")
+ *
+ * '?'          optional type (for all types, except '/')
+ * '.'          other form of optional type (for 'i' and 'l')
+ * 'b'          boolean
+ *              user mode accepts "on" or "off"
+ * '-'          optional parameter (eg. '-f')
+ *
+ */
+
+typedef struct HMPCommand {
+    const char *name;
+    const char *args_type;
+    const char *params;
+    const char *help;
+    const char *flags; /* p=3Dpreconfig */
+    void (*cmd)(Monitor *mon, const QDict *qdict);
+    /*
+     * @sub_table is a list of 2nd level of commands. If it does not exi=
st,
+     * cmd should be used. If it exists, sub_table[?].cmd should be
+     * used, and cmd of 1st level plays the role of help function.
+     */
+    struct HMPCommand *sub_table;
+    void (*command_completion)(ReadLineState *rs, int nb_args, const cha=
r *str);
+} HMPCommand;
+
+struct Monitor {
+    CharBackend chr;
+    int reset_seen;
+    int flags;
+    int suspend_cnt;            /* Needs to be accessed atomically */
+    bool skip_flush;
+    bool use_io_thread;
+
+    gchar *mon_cpu_path;
+    QTAILQ_ENTRY(Monitor) entry;
+
+    /*
+     * The per-monitor lock. We can't access guest memory when holding
+     * the lock.
+     */
+    QemuMutex mon_lock;
+
+    /*
+     * Members that are protected by the per-monitor lock
+     */
+    QLIST_HEAD(, mon_fd_t) fds;
+    QString *outbuf;
+    guint out_watch;
+    /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
+    int mux_out;
+};
+
+struct MonitorHMP {
+    Monitor common;
+    /*
+     * State used only in the thread "owning" the monitor.
+     * If @use_io_thread, this is @mon_iothread. (This does not actually=
 happen
+     * in the current state of the code.)
+     * Else, it's the main thread.
+     * These members can be safely accessed without locks.
+     */
+    ReadLineState *rs;
+};
+
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
+#endif
--=20
2.21.0


