Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF06C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C798420665
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C798420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbT2x-0003j0-3m
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbRkt-0000WE-8G
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbRkr-0003Tx-Eo
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbRkk-0003F8-Df; Thu, 13 Jun 2019 11:35:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DEFE6EB81;
 Thu, 13 Jun 2019 15:34:47 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-246.ams2.redhat.com
 [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 137B260C44;
 Thu, 13 Jun 2019 15:34:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:33:57 +0200
Message-Id: <20190613153405.24769-8-kwolf@redhat.com>
In-Reply-To: <20190613153405.24769-1-kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 13 Jun 2019 15:34:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 07/15] Move monitor.c to monitor/misc.c
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

Create a new monitor/ subdirectory and move monitor.c there. As the plan
is to move the monitor core into separate files, use the chance to
rename it to misc.c.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/writing-qmp-commands.txt |  2 +-
 monitor.c =3D> monitor/misc.c         |  2 +-
 MAINTAINERS                         |  4 ++--
 Makefile.objs                       |  1 +
 Makefile.target                     |  3 ++-
 monitor/Makefile.objs               |  1 +
 monitor/trace-events                | 11 +++++++++++
 trace-events                        | 10 ----------
 8 files changed, 19 insertions(+), 15 deletions(-)
 rename monitor.c =3D> monitor/misc.c (99%)
 create mode 100644 monitor/Makefile.objs
 create mode 100644 monitor/trace-events

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
index 9dfc62bf5a..cc6ecd6d5d 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -470,7 +470,7 @@ it's good practice to always check for errors.
=20
 Another important detail is that HMP's "info" commands don't go into the
 hmp-commands.hx. Instead, they go into the info_cmds[] table, which is d=
efined
-in the monitor.c file. The entry for the "info alarmclock" follows:
+in the monitor/misc.c file. The entry for the "info alarmclock" follows:
=20
     {
         .name       =3D "alarmclock",
diff --git a/monitor.c b/monitor/misc.c
similarity index 99%
rename from monitor.c
rename to monitor/misc.c
index 006c650761..e5db04265d 100644
--- a/monitor.c
+++ b/monitor/misc.c
@@ -64,7 +64,7 @@
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qlist.h"
 #include "qom/object_interfaces.h"
-#include "trace-root.h"
+#include "trace.h"
 #include "trace/control.h"
 #include "monitor/hmp-target.h"
 #ifdef CONFIG_TRACE_SIMPLE
diff --git a/MAINTAINERS b/MAINTAINERS
index 588c8d947a..231964c1da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1916,7 +1916,7 @@ F: qapi/run-state.json
 Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 S: Maintained
-F: monitor.c
+F: monitor/misc.c
 F: hmp.[ch]
 F: hmp-commands*.hx
 F: include/monitor/hmp-target.h
@@ -2038,7 +2038,7 @@ QMP
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: qmp.c
-F: monitor.c
+F: monitor/misc.c
 F: docs/devel/*qmp-*
 F: docs/interop/*qmp-*
 F: scripts/qmp/
diff --git a/Makefile.objs b/Makefile.objs
index c8337fa34b..dd39a70b48 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -130,6 +130,7 @@ trace-events-subdirs =3D
 trace-events-subdirs +=3D accel/kvm
 trace-events-subdirs +=3D accel/tcg
 trace-events-subdirs +=3D crypto
+trace-events-subdirs +=3D monitor
 ifeq ($(CONFIG_USER_ONLY),y)
 trace-events-subdirs +=3D linux-user
 endif
diff --git a/Makefile.target b/Makefile.target
index ecd856e3a3..72c267f7dc 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -148,9 +148,10 @@ endif #CONFIG_BSD_USER
 #########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
-obj-y +=3D arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o num=
a.o
+obj-y +=3D arch_init.o cpus.o gdbstub.o balloon.o ioport.o numa.o
 obj-y +=3D qtest.o
 obj-y +=3D hw/
+obj-y +=3D monitor/
 obj-y +=3D qapi/
 obj-y +=3D memory.o
 obj-y +=3D memory_mapping.o
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
new file mode 100644
index 0000000000..e783b0616b
--- /dev/null
+++ b/monitor/Makefile.objs
@@ -0,0 +1 @@
+obj-y +=3D misc.o
diff --git a/monitor/trace-events b/monitor/trace-events
new file mode 100644
index 0000000000..abfdf20b14
--- /dev/null
+++ b/monitor/trace-events
@@ -0,0 +1,11 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# misc.c
+monitor_protocol_event_handler(uint32_t event, void *qdict) "event=3D%d =
data=3D%p"
+monitor_protocol_event_emit(uint32_t event, void *data) "event=3D%d data=
=3D%p"
+monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate)=
 "event=3D%d data=3D%p rate=3D%" PRId64
+handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
+handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
+monitor_suspend(void *ptr, int cnt) "mon %p: %d"
+monitor_qmp_cmd_in_band(const char *id) "%s"
+monitor_qmp_cmd_out_of_band(const char *id) "%s"
diff --git a/trace-events b/trace-events
index 844ee58dd9..aeea3c2bdb 100644
--- a/trace-events
+++ b/trace-events
@@ -41,16 +41,6 @@ system_wakeup_request(int reason) "reason=3D%d"
 qemu_system_shutdown_request(int reason) "reason=3D%d"
 qemu_system_powerdown_request(void) ""
=20
-# monitor.c
-monitor_protocol_event_handler(uint32_t event, void *qdict) "event=3D%d =
data=3D%p"
-monitor_protocol_event_emit(uint32_t event, void *data) "event=3D%d data=
=3D%p"
-monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate)=
 "event=3D%d data=3D%p rate=3D%" PRId64
-handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
-handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
-monitor_suspend(void *ptr, int cnt) "mon %p: %d"
-monitor_qmp_cmd_in_band(const char *id) "%s"
-monitor_qmp_cmd_out_of_band(const char *id) "%s"
-
 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=3D%p b=
s=3D%p offset=3D%" PRId64 " to_dev=3D%d"
 dma_aio_cancel(void *dbs) "dbs=3D%p"
--=20
2.20.1


