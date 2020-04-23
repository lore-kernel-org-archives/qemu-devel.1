Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26230C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E2520724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNyTq1hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E2520724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiQG-0006UC-SR
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiMF-0005Oi-Hj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiME-0003gI-Nk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:22:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29778
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiME-0003g9-8H
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wq10tdmagP4bZ/4I285kBZFNlh6YBL1XlJbyw1tLKw8=;
 b=UNyTq1hmKiPhlS3CMetjre/NIQ5MO29MOYNfVjbUqKPHykIkRMQWsDfj9jVxCNCaK98W8K
 5CP8yt8eqed2vdIBlku7QdW9dSAkBLH/0HK/6tVnpVR+PtQRjiQ0Iw9cW32T5xmwUXQODg
 e3UhkNr6M1qu0/D8kGXFP+WKnkBG1n4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-Q4yM1LQNNliAFdsg53b8pQ-1; Thu, 23 Apr 2020 16:21:59 -0400
X-MC-Unique: Q4yM1LQNNliAFdsg53b8pQ-1
Received: by mail-wr1-f71.google.com with SMTP id r11so3381938wrx.21
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ar7WwMHZ0+CpcbAoGEZSCSPIuYugOvcLGHNI+3InVx8=;
 b=WG8apG2vb9yTobcNlK5oIZn+S/6/AcV1VgKzxWf1qOPIL2MOmVeK/+hgiIY5MGGNsr
 hy1hldMcTZ/yM094UKK7s89ufrMwoHFKZQqVDf7II50Ece0NDFlnDJX4LZ2iB7iVMuQ3
 lnyhFsK6YocjjgzNPozK9V4vlSzw8xPZsTk+LtGljYibfO+4fHGF/7EqmpUlO2Pc3tFR
 zq55VcoftG2v/mTbQf9dr4TfVeaBX/CSAIcVanrk1wWFgrMdX/uEpsLuf5ScO2F0PDUU
 x9qLRJ5ZORSHfFY1vUZ823idZ/nugbWckUUFox/hXOpm8hQMJlUTvyIskIz7bar8CFSg
 ckfg==
X-Gm-Message-State: AGi0PuZGO5al6sbVaqkdmYGZbvgcRRL8oUT5i6BLtLejZNw0K4XAvIcj
 ILcyUSi4U/QkF7agesvnNYIYiMtMKdGTlaXBT7APwnmN+VMt2AEwQ9cUTsDNAXsc15eAiDuHbys
 AxOTX5SfPl66mwUg=
X-Received: by 2002:adf:8284:: with SMTP id 4mr6877019wrc.6.1587673318048;
 Thu, 23 Apr 2020 13:21:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypKH9YSaJ+JDgC9pahB+sDTq8Y4XOMtZ0jb+bccjXtPa7WsvKEEXtoqjOLwM/WnoOqI7V7U0Bg==
X-Received: by 2002:adf:8284:: with SMTP id 4mr6876984wrc.6.1587673317711;
 Thu, 23 Apr 2020 13:21:57 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id c1sm5402925wrc.4.2020.04.23.13.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 13:21:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] multi-process: Refactor machine_init and exit notifiers
Date: Thu, 23 Apr 2020 22:21:12 +0200
Message-Id: <20200423202112.644-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200423202112.644-1-philmd@redhat.com>
References: <20200423202112.644-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Relocate machine_int and exit notifiers into common code

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
[PMD: Removed NotifierList machine_init_done_notifiers stub]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile.objs           |  1 +
 include/sysemu/sysemu.h |  2 ++
 softmmu/vl.c            | 42 -------------------------
 stubs/machine-notify.c  |  4 +++
 util/machine-notify.c   | 69 +++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS             |  1 +
 6 files changed, 77 insertions(+), 42 deletions(-)
 create mode 100644 util/machine-notify.c

diff --git a/Makefile.objs b/Makefile.objs
index a7c967633a..bfb9271862 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -79,6 +79,7 @@ qemu-seccomp.o-libs :=3D $(SECCOMP_LIBS)
 common-obj-$(CONFIG_FDT) +=3D device_tree.o
=20
 common-obj-y +=3D qapi/
+common-obj-y +=3D util/machine-notify.o
=20
 endif # CONFIG_SOFTMMU
=20
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index ef81302e1a..2438dd7bea 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -17,11 +17,13 @@ extern bool qemu_uuid_set;
=20
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
+void qemu_run_exit_notifiers(void);
=20
 extern bool machine_init_done;
=20
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
+void qemu_run_machine_init_done_notifiers(void);
=20
 extern int autostart;
=20
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 32c0047889..39cbb6b50d 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -172,12 +172,6 @@ int icount_align_option;
 QemuUUID qemu_uuid;
 bool qemu_uuid_set;
=20
-static NotifierList exit_notifiers =3D
-    NOTIFIER_LIST_INITIALIZER(exit_notifiers);
-
-static NotifierList machine_init_done_notifiers =3D
-    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
-
 bool xen_allowed;
 uint32_t xen_domid;
 enum xen_mode xen_mode =3D XEN_EMULATE;
@@ -2325,21 +2319,6 @@ static MachineClass *machine_parse(const char *name,=
 GSList *machines)
     return mc;
 }
=20
-void qemu_add_exit_notifier(Notifier *notify)
-{
-    notifier_list_add(&exit_notifiers, notify);
-}
-
-void qemu_remove_exit_notifier(Notifier *notify)
-{
-    notifier_remove(notify);
-}
-
-static void qemu_run_exit_notifiers(void)
-{
-    notifier_list_notify(&exit_notifiers, NULL);
-}
-
 static const char *pid_file;
 static Notifier qemu_unlink_pidfile_notifier;
=20
@@ -2350,27 +2329,6 @@ static void qemu_unlink_pidfile(Notifier *n, void *d=
ata)
     }
 }
=20
-bool machine_init_done;
-
-void qemu_add_machine_init_done_notifier(Notifier *notify)
-{
-    notifier_list_add(&machine_init_done_notifiers, notify);
-    if (machine_init_done) {
-        notify->notify(notify, NULL);
-    }
-}
-
-void qemu_remove_machine_init_done_notifier(Notifier *notify)
-{
-    notifier_remove(notify);
-}
-
-static void qemu_run_machine_init_done_notifiers(void)
-{
-    machine_init_done =3D true;
-    notifier_list_notify(&machine_init_done_notifiers, NULL);
-}
-
 static const QEMUOption *lookup_opt(int argc, char **argv,
                                     const char **poptarg, int *poptind)
 {
diff --git a/stubs/machine-notify.c b/stubs/machine-notify.c
index d164ecccb9..71eba45b0f 100644
--- a/stubs/machine-notify.c
+++ b/stubs/machine-notify.c
@@ -4,3 +4,7 @@
 void qemu_add_machine_init_done_notifier(Notifier *notify)
 {
 }
+
+void qemu_remove_machine_init_done_notifier(Notifier *notify)
+{
+}
diff --git a/util/machine-notify.c b/util/machine-notify.c
new file mode 100644
index 0000000000..718af79335
--- /dev/null
+++ b/util/machine-notify.c
@@ -0,0 +1,69 @@
+/*
+ * Machine notifiers.
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/notify.h"
+#include "sysemu/sysemu.h"
+
+static NotifierList machine_init_done_notifiers =3D
+    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
+
+static NotifierList exit_notifiers =3D
+    NOTIFIER_LIST_INITIALIZER(exit_notifiers);
+
+bool machine_init_done;
+
+void qemu_add_machine_init_done_notifier(Notifier *notify)
+{
+    notifier_list_add(&machine_init_done_notifiers, notify);
+    if (machine_init_done) {
+        notify->notify(notify, NULL);
+    }
+}
+
+void qemu_remove_machine_init_done_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
+void qemu_run_machine_init_done_notifiers(void)
+{
+    machine_init_done =3D true;
+    notifier_list_notify(&machine_init_done_notifiers, NULL);
+}
+
+void qemu_add_exit_notifier(Notifier *notify)
+{
+    notifier_list_add(&exit_notifiers, notify);
+}
+
+void qemu_remove_exit_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
+void qemu_run_exit_notifiers(void)
+{
+    notifier_list_notify(&exit_notifiers, NULL);
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2b..04b19ac56c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2133,6 +2133,7 @@ F: util/qemu-timer.c
 F: softmmu/vl.c
 F: softmmu/main.c
 F: qapi/run-state.json
+F: util/machine-notify.c
=20
 Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
--=20
2.21.1


