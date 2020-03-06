Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEAAC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B7A2051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTVrgv8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B7A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGmd-0000g6-S1
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZZ-00054m-8w
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZV-00087A-7M
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28211
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZU-00083H-RG
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K8jVIwNKgc74b+swgvdH5lh6YjNauzZp09UL06irv9Q=;
 b=MTVrgv8rNsZlcCr5YQ6SVq+IHCtVqPK+L5UBVYq9V0g8InPg9RVIYwJ+5kEMJ7NQYKA+jI
 N9f9vkjV7wsjDaVM1DS1STKdKIlwp9yMRHfvTzvgl7+2x2Y3NruyTkFTjxOhfE8olXOy90
 wou6gxedRS8R4lEs46FH8WzHBHQ5J0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-cpozvw4xMNqiiQRq1Om0dg-1; Fri, 06 Mar 2020 12:15:32 -0500
X-MC-Unique: cpozvw4xMNqiiQRq1Om0dg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4B7C13F5;
 Fri,  6 Mar 2020 17:15:31 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADAED73873;
 Fri,  6 Mar 2020 17:15:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 20/29] stubs: Update monitor stubs for qemu-storage-daemon
Date: Fri,  6 Mar 2020 18:14:49 +0100
Message-Id: <20200306171458.1848-21-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before we can add the monitor to qemu-storage-daemon, we need to add a
stubs for monitor_fdsets_cleanup().

We also need to make sure that stubs that are actually implemented in
the monitor core aren't linked to qemu-storage-daemon so that we don't
get linker errors because of duplicate symbols. This is achieved by
moving the stubs in question to a new file stubs/monitor-core.c.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-15-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 stubs/monitor-core.c | 21 +++++++++++++++++++++
 stubs/monitor.c      | 15 ++-------------
 stubs/Makefile.objs  |  1 +
 3 files changed, 24 insertions(+), 13 deletions(-)
 create mode 100644 stubs/monitor-core.c

diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
new file mode 100644
index 0000000000..403c00a6d0
--- /dev/null
+++ b/stubs/monitor-core.c
@@ -0,0 +1,21 @@
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+#include "qemu-common.h"
+#include "qapi/qapi-emit-events.h"
+
+__thread Monitor *cur_mon;
+
+void monitor_init_qmp(Chardev *chr, bool pretty)
+{
+}
+
+void qapi_event_emit(QAPIEvent event, QDict *qdict)
+{
+}
+
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
+{
+    abort();
+}
+
+
diff --git a/stubs/monitor.c b/stubs/monitor.c
index c3e9a2e4dc..9403f8e72c 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -1,14 +1,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-emit-events.h"
 #include "monitor/monitor.h"
-
-__thread Monitor *cur_mon;
-
-int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
-{
-    abort();
-}
+#include "../monitor/monitor-internal.h"
=20
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
@@ -16,14 +9,10 @@ int monitor_get_fd(Monitor *mon, const char *name, Error=
 **errp)
     return -1;
 }
=20
-void monitor_init_qmp(Chardev *chr, bool pretty)
-{
-}
-
 void monitor_init_hmp(Chardev *chr, bool use_readline)
 {
 }
=20
-void qapi_event_emit(QAPIEvent event, QDict *qdict)
+void monitor_fdsets_cleanup(void)
 {
 }
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 24062ce7d9..45be5dc0ed 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -19,6 +19,7 @@ stub-obj-y +=3D machine-init-done.o
 stub-obj-y +=3D migr-blocker.o
 stub-obj-y +=3D change-state-handler.o
 stub-obj-y +=3D monitor.o
+stub-obj-y +=3D monitor-core.o
 stub-obj-y +=3D notify-event.o
 stub-obj-y +=3D qtest.o
 stub-obj-y +=3D replay.o
--=20
2.20.1


