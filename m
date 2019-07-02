Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA3C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB3A20836
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB3A20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGge-0002RF-RL
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51062)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGKB-0005qp-EZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJw-0007yB-KB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJs-0007lx-TO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A33173082E4C
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 10:47:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48FED37D6;
 Tue,  2 Jul 2019 10:47:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0E052111BD60; Tue,  2 Jul 2019 12:47:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:16 +0200
Message-Id: <20190702104716.9140-19-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 10:47:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 18/18] dump: Move HMP command handlers to dump/
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the HMP handlers related to qapi/dump.json to
dump/dump-hmp-cmds.c, where they are covered by MAINTAINERS section
"Dump", just like qapi/dump.json.

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190619201050.19040-18-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
[Commit message typo fixed]
---
 Makefile.objs        |  1 +
 dump/Makefile.objs   |  1 +
 dump/dump-hmp-cmds.c | 88 ++++++++++++++++++++++++++++++++++++++++++++
 monitor/hmp-cmds.c   | 76 --------------------------------------
 4 files changed, 90 insertions(+), 76 deletions(-)
 create mode 100644 dump/dump-hmp-cmds.c

diff --git a/Makefile.objs b/Makefile.objs
index fe4f339b7c..6a143dcd57 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -45,6 +45,7 @@ io-obj-y =3D io/
 ifeq ($(CONFIG_SOFTMMU),y)
 common-obj-y =3D blockdev.o blockdev-nbd.o block/
 common-obj-y +=3D bootdevice.o iothread.o
+common-obj-y +=3D dump/
 common-obj-y +=3D job-qmp.o
 common-obj-y +=3D monitor/
 common-obj-y +=3D net/
diff --git a/dump/Makefile.objs b/dump/Makefile.objs
index ea6b074967..d2a5db3b81 100644
--- a/dump/Makefile.objs
+++ b/dump/Makefile.objs
@@ -1,2 +1,3 @@
 obj-y +=3D dump.o
+common-obj-y +=3D dump-hmp-cmds.o
 obj-$(TARGET_X86_64) +=3D win_dump.o
diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
new file mode 100644
index 0000000000..3dbf44372c
--- /dev/null
+++ b/dump/dump-hmp-cmds.c
@@ -0,0 +1,88 @@
+/*
+ * Human Monitor Interface commands
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-dump.h"
+#include "qapi/qmp/qdict.h"
+
+void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+    bool win_dmp =3D qdict_get_try_bool(qdict, "windmp", false);
+    bool paging =3D qdict_get_try_bool(qdict, "paging", false);
+    bool zlib =3D qdict_get_try_bool(qdict, "zlib", false);
+    bool lzo =3D qdict_get_try_bool(qdict, "lzo", false);
+    bool snappy =3D qdict_get_try_bool(qdict, "snappy", false);
+    const char *file =3D qdict_get_str(qdict, "filename");
+    bool has_begin =3D qdict_haskey(qdict, "begin");
+    bool has_length =3D qdict_haskey(qdict, "length");
+    bool has_detach =3D qdict_haskey(qdict, "detach");
+    int64_t begin =3D 0;
+    int64_t length =3D 0;
+    bool detach =3D false;
+    enum DumpGuestMemoryFormat dump_format =3D DUMP_GUEST_MEMORY_FORMAT_=
ELF;
+    char *prot;
+
+    if (zlib + lzo + snappy + win_dmp > 1) {
+        error_setg(&err, "only one of '-z|-l|-s|-w' can be set");
+        hmp_handle_error(mon, &err);
+        return;
+    }
+
+    if (win_dmp) {
+        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
+    }
+
+    if (zlib) {
+        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
+    }
+
+    if (lzo) {
+        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
+    }
+
+    if (snappy) {
+        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
+    }
+
+    if (has_begin) {
+        begin =3D qdict_get_int(qdict, "begin");
+    }
+    if (has_length) {
+        length =3D qdict_get_int(qdict, "length");
+    }
+    if (has_detach) {
+        detach =3D qdict_get_bool(qdict, "detach");
+    }
+
+    prot =3D g_strconcat("file:", file, NULL);
+
+    qmp_dump_guest_memory(paging, prot, true, detach, has_begin, begin,
+                          has_length, length, true, dump_format, &err);
+    hmp_handle_error(mon, &err);
+    g_free(prot);
+}
+
+void hmp_info_dump(Monitor *mon, const QDict *qdict)
+{
+    DumpQueryResult *result =3D qmp_query_dump(NULL);
+
+    assert(result && result->status < DUMP_STATUS__MAX);
+    monitor_printf(mon, "Status: %s\n", DumpStatus_str(result->status));
+
+    if (result->status =3D=3D DUMP_STATUS_ACTIVE) {
+        float percent =3D 0;
+        assert(result->total !=3D 0);
+        percent =3D 100.0 * result->completed / result->total;
+        monitor_printf(mon, "Finished: %.2f %%\n", percent);
+    }
+
+    qapi_free_DumpQueryResult(result);
+}
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 18ffeb7017..dc12ae6129 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -31,7 +31,6 @@
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-char.h"
-#include "qapi/qapi-commands-dump.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-net.h"
@@ -2160,64 +2159,6 @@ void hmp_device_del(Monitor *mon, const QDict *qdi=
ct)
     hmp_handle_error(mon, &err);
 }
=20
-void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
-{
-    Error *err =3D NULL;
-    bool win_dmp =3D qdict_get_try_bool(qdict, "windmp", false);
-    bool paging =3D qdict_get_try_bool(qdict, "paging", false);
-    bool zlib =3D qdict_get_try_bool(qdict, "zlib", false);
-    bool lzo =3D qdict_get_try_bool(qdict, "lzo", false);
-    bool snappy =3D qdict_get_try_bool(qdict, "snappy", false);
-    const char *file =3D qdict_get_str(qdict, "filename");
-    bool has_begin =3D qdict_haskey(qdict, "begin");
-    bool has_length =3D qdict_haskey(qdict, "length");
-    bool has_detach =3D qdict_haskey(qdict, "detach");
-    int64_t begin =3D 0;
-    int64_t length =3D 0;
-    bool detach =3D false;
-    enum DumpGuestMemoryFormat dump_format =3D DUMP_GUEST_MEMORY_FORMAT_=
ELF;
-    char *prot;
-
-    if (zlib + lzo + snappy + win_dmp > 1) {
-        error_setg(&err, "only one of '-z|-l|-s|-w' can be set");
-        hmp_handle_error(mon, &err);
-        return;
-    }
-
-    if (win_dmp) {
-        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
-    }
-
-    if (zlib) {
-        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
-    }
-
-    if (lzo) {
-        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
-    }
-
-    if (snappy) {
-        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
-    }
-
-    if (has_begin) {
-        begin =3D qdict_get_int(qdict, "begin");
-    }
-    if (has_length) {
-        length =3D qdict_get_int(qdict, "length");
-    }
-    if (has_detach) {
-        detach =3D qdict_get_bool(qdict, "detach");
-    }
-
-    prot =3D g_strconcat("file:", file, NULL);
-
-    qmp_dump_guest_memory(paging, prot, true, detach, has_begin, begin,
-                          has_length, length, true, dump_format, &err);
-    hmp_handle_error(mon, &err);
-    g_free(prot);
-}
-
 void hmp_netdev_add(Monitor *mon, const QDict *qdict)
 {
     Error *err =3D NULL;
@@ -2949,23 +2890,6 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const =
QDict *qdict)
     qapi_free_RockerOfDpaGroupList(list);
 }
=20
-void hmp_info_dump(Monitor *mon, const QDict *qdict)
-{
-    DumpQueryResult *result =3D qmp_query_dump(NULL);
-
-    assert(result && result->status < DUMP_STATUS__MAX);
-    monitor_printf(mon, "Status: %s\n", DumpStatus_str(result->status));
-
-    if (result->status =3D=3D DUMP_STATUS_ACTIVE) {
-        float percent =3D 0;
-        assert(result->total !=3D 0);
-        percent =3D 100.0 * result->completed / result->total;
-        monitor_printf(mon, "Finished: %.2f %%\n", percent);
-    }
-
-    qapi_free_DumpQueryResult(result);
-}
-
 void hmp_info_ramblock(Monitor *mon, const QDict *qdict)
 {
     ram_block_dump(mon);
--=20
2.21.0


