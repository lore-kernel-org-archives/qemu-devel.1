Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C59C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B2F20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B2F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDPwL-0008Ss-LE
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 04:47:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlc-0008BF-CL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlb-0003fu-1q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDPla-0003eq-Hd
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D54B6F74AE
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 08:36:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 78BC46013D;
	Mon,  8 Apr 2019 08:36:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1D6931132783; Mon,  8 Apr 2019 10:36:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 10:36:27 +0200
Message-Id: <20190408083627.7479-16-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-1-armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 08 Apr 2019 08:36:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 15/15] monitor: Simplify how -device/device_add
 print help
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408083627.Wii-C8yiWQLDiTDEAuPyAk8S--QXDqJbPGw-sLNbcNw@z>

Commit a95db58f210 added monitor_vfprintf() as an error_printf()
generalized from stderr to arbitrary streams, then used it wrapped in
helper out_printf() to print -device/device_add help to stdout.  Use
qemu_printf() instead, and delete monitor_vfprintf() and out_printf().

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/monitor/monitor.h |  3 ---
 monitor.c                 | 16 ++++------------
 qdev-monitor.c            | 36 ++++++++++++++----------------------
 3 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index e4c3717454..316a168c41 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -48,7 +48,4 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 int monitor_fdset_dup_fd_find(int dup_fd);
 
-int monitor_vfprintf(FILE *stream,
-                     const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
-
 #endif /* MONITOR_H */
diff --git a/monitor.c b/monitor.c
index 7b4a78d798..10be8bdb86 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4541,23 +4541,15 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(opaque);
 }
 
-/*
- * Print to current monitor if we have one, else to stream.
- */
-int monitor_vfprintf(FILE *stream, const char *fmt, va_list ap)
-{
-    if (cur_mon && !monitor_cur_is_qmp()) {
-        return monitor_vprintf(cur_mon, fmt, ap);
-    }
-    return vfprintf(stream, fmt, ap);
-}
-
 /*
  * Print to current monitor if we have one, else to stderr.
  */
 int error_vprintf(const char *fmt, va_list ap)
 {
-    return monitor_vfprintf(stderr, fmt, ap);
+    if (cur_mon && !monitor_cur_is_qmp()) {
+        return monitor_vprintf(cur_mon, fmt, ap);
+    }
+    return vfprintf(stderr, fmt, ap);
 }
 
 int error_vprintf_unless_qmp(const char *fmt, va_list ap)
diff --git a/qdev-monitor.c b/qdev-monitor.c
index d4320986a2..373b9ad445 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "qemu/option.h"
+#include "qemu/qemu-print.h"
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
 
@@ -104,31 +105,22 @@ static bool qdev_class_has_alias(DeviceClass *dc)
     return (qdev_class_get_alias(dc) != NULL);
 }
 
-static void out_printf(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    monitor_vfprintf(stdout, fmt, ap);
-    va_end(ap);
-}
-
 static void qdev_print_devinfo(DeviceClass *dc)
 {
-    out_printf("name \"%s\"", object_class_get_name(OBJECT_CLASS(dc)));
+    qemu_printf("name \"%s\"", object_class_get_name(OBJECT_CLASS(dc)));
     if (dc->bus_type) {
-        out_printf(", bus %s", dc->bus_type);
+        qemu_printf(", bus %s", dc->bus_type);
     }
     if (qdev_class_has_alias(dc)) {
-        out_printf(", alias \"%s\"", qdev_class_get_alias(dc));
+        qemu_printf(", alias \"%s\"", qdev_class_get_alias(dc));
     }
     if (dc->desc) {
-        out_printf(", desc \"%s\"", dc->desc);
+        qemu_printf(", desc \"%s\"", dc->desc);
     }
     if (!dc->user_creatable) {
-        out_printf(", no-user");
+        qemu_printf(", no-user");
     }
-    out_printf("\n");
+    qemu_printf("\n");
 }
 
 static void qdev_print_devinfos(bool show_no_user)
@@ -164,7 +156,7 @@ static void qdev_print_devinfos(bool show_no_user)
                 continue;
             }
             if (!cat_printed) {
-                out_printf("%s%s devices:\n", i ? "\n" : "", cat_name[i]);
+                qemu_printf("%s%s devices:\n", i ? "\n" : "", cat_name[i]);
                 cat_printed = true;
             }
             qdev_print_devinfo(dc);
@@ -286,20 +278,20 @@ int qdev_device_help(QemuOpts *opts)
     }
 
     if (prop_list) {
-        out_printf("%s options:\n", driver);
+        qemu_printf("%s options:\n", driver);
     } else {
-        out_printf("There are no options for %s.\n", driver);
+        qemu_printf("There are no options for %s.\n", driver);
     }
     for (prop = prop_list; prop; prop = prop->next) {
         int len;
-        out_printf("  %s=<%s>%n", prop->value->name, prop->value->type, &len);
+        qemu_printf("  %s=<%s>%n", prop->value->name, prop->value->type, &len);
         if (prop->value->has_description) {
             if (len < 24) {
-                out_printf("%*s", 24 - len, "");
+                qemu_printf("%*s", 24 - len, "");
             }
-            out_printf(" - %s\n", prop->value->description);
+            qemu_printf(" - %s\n", prop->value->description);
         } else {
-            out_printf("\n");
+            qemu_printf("\n");
         }
     }
 
-- 
2.17.2


