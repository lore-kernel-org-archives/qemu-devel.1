Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C7C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B10B2072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YswgD7vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B10B2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYEM-0005ez-U0
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2q-00067C-In
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2o-0008QO-V5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:12 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2o-0008NP-Gk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:10 -0500
Received: by mail-wm1-x32d.google.com with SMTP id d139so4490111wmd.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=u7/VzsObPJenJKrRI20Is7W11ftIW2OHO+f1XruWVNs=;
 b=YswgD7vSTwH9TOZkhS7aoliHMjEXmHuoodyIrKzCo2Q/zbbVM/Pk+OKVsSfuvEaHs7
 mAaI1Hvsm4M7UwDMQDDVCeAVfzXm/nw/iH6ybr6AJ1aVPihUBnZDROeX3wWvK8umOwip
 8tvjJLQTYcarKrn73tgBpgL6mQZTwRyujvsxcVYkP7Co61Cyj4DYDKKTFLsJsKaJN0/b
 f1XaZzOAsDUCfajW7Wubdcl91CT/mISB2+iVQ7s8LasauqOrL1xrTCr/0rCqhlb3xy5l
 WqAr3wyekWTtWxsmCCT5aWq69MpmK6ZQAkJPFTHxFZRoZxvSjsGZl5UZmLkQ3n8DFj7+
 NL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=u7/VzsObPJenJKrRI20Is7W11ftIW2OHO+f1XruWVNs=;
 b=DaHr8/HjLxv0S78VxPcRiImAf5IUAEAYbWlXi3skLV6D6vLcpq2g/ltOylTIfU84u0
 xoySsMFBDD4uR5FqXDjYs6+5aXlRwSgJ+drLh9JausNn6/YJTVY46nEKyqz22WyHdOMK
 tEr/MwkYwL2vsJcRrsMY0HjmnZsgT4SOipxl2w9s3TgStfDWcLCICy3M0kHkkI1Hseq2
 E64kUcb0euqnmZeDL4uY2OZ7cJBToCWm9N25ja5Qj9sz99ub8fG6vK1NNELQeOJHbii3
 xQ7bMxgRnfizKC9xnD8V6m754uu6KB79SlKlga0mQdkKuEbP1tR9j6tunC1nBrcv6Cxy
 L6+Q==
X-Gm-Message-State: APjAAAW4oKgASiLmjqnwoZP0gwxWMMIPZbg9gZMuC7g69oFtihjRikQl
 0/rbpUuli7arLSwQ88am4ZC+SEMI
X-Google-Smtp-Source: APXvYqxSntZ0XUDATuCAtKRph+gouhEvzPC/LquMsFpEgEMX9/EIozE51ooLpZVPecwVHqa3VZFxBw==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr2722213wml.115.1576670589310; 
 Wed, 18 Dec 2019 04:03:09 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/87] tcg: move qemu_tcg_configure to accel/tcg/tcg-all.c
Date: Wed, 18 Dec 2019 13:01:40 +0100
Message-Id: <1576670573-48048-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move everything related to mttcg_enabled in accel/tcg/tcg-all.c,
which will make even more sense when "thread" becomes a QOM property.

For now, initializing mttcg_enabled in the instance_init function
prepares for the next patch, which will only invoke qemu_tcg_configure
when the command line includes a -accel option.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-all.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 cpus.c              | 72 ----------------------------------------------
 2 files changed, 83 insertions(+), 72 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c59d5b0..6b000f0 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -30,6 +30,11 @@
 #include "cpu.h"
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"
+#include "tcg/tcg.h"
+#include "include/qapi/error.h"
+#include "include/qemu/error-report.h"
+#include "include/hw/boards.h"
+#include "qemu/option.h"
 
 unsigned long tcg_tb_size;
 
@@ -58,6 +63,53 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
     }
 }
 
+/*
+ * We default to false if we know other options have been enabled
+ * which are currently incompatible with MTTCG. Otherwise when each
+ * guest (target) has been updated to support:
+ *   - atomic instructions
+ *   - memory ordering primitives (barriers)
+ * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
+ *
+ * Once a guest architecture has been converted to the new primitives
+ * there are two remaining limitations to check.
+ *
+ * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
+ * - The host must have a stronger memory order than the guest
+ *
+ * It may be possible in future to support strong guests on weak hosts
+ * but that will require tagging all load/stores in a guest with their
+ * implicit memory order requirements which would likely slow things
+ * down a lot.
+ */
+
+static bool check_tcg_memory_orders_compatible(void)
+{
+#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
+    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) == 0;
+#else
+    return false;
+#endif
+}
+
+static bool default_mttcg_enabled(void)
+{
+    if (use_icount || TCG_OVERSIZED_GUEST) {
+        return false;
+    } else {
+#ifdef TARGET_SUPPORTS_MTTCG
+        return check_tcg_memory_orders_compatible();
+#else
+        return false;
+#endif
+    }
+}
+
+static void tcg_accel_instance_init(Object *obj)
+{
+    mttcg_enabled = default_mttcg_enabled();
+}
+
 static int tcg_init(MachineState *ms)
 {
     tcg_exec_init(tcg_tb_size * 1024 * 1024);
@@ -65,6 +117,36 @@ static int tcg_init(MachineState *ms)
     return 0;
 }
 
+void qemu_tcg_configure(QemuOpts *opts, Error **errp)
+{
+    const char *t = qemu_opt_get(opts, "thread");
+    if (!t) {
+        return;
+    }
+    if (strcmp(t, "multi") == 0) {
+        if (TCG_OVERSIZED_GUEST) {
+            error_setg(errp, "No MTTCG when guest word size > hosts");
+        } else if (use_icount) {
+            error_setg(errp, "No MTTCG when icount is enabled");
+        } else {
+#ifndef TARGET_SUPPORTS_MTTCG
+            warn_report("Guest not yet converted to MTTCG - "
+                        "you may get unexpected results");
+#endif
+            if (!check_tcg_memory_orders_compatible()) {
+                warn_report("Guest expects a stronger memory ordering "
+                            "than the host provides");
+                error_printf("This may cause strange/hard to debug errors\n");
+            }
+            mttcg_enabled = true;
+        }
+    } else if (strcmp(t, "single") == 0) {
+        mttcg_enabled = false;
+    } else {
+        error_setg(errp, "Invalid 'thread' setting %s", t);
+    }
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -78,6 +160,7 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
 static const TypeInfo tcg_accel_type = {
     .name = TYPE_TCG_ACCEL,
     .parent = TYPE_ACCEL,
+    .instance_init = tcg_accel_instance_init,
     .class_init = tcg_accel_class_init,
 };
 
diff --git a/cpus.c b/cpus.c
index 63bda15..b472378 100644
--- a/cpus.c
+++ b/cpus.c
@@ -166,78 +166,6 @@ typedef struct TimersState {
 static TimersState timers_state;
 bool mttcg_enabled;
 
-/*
- * We default to false if we know other options have been enabled
- * which are currently incompatible with MTTCG. Otherwise when each
- * guest (target) has been updated to support:
- *   - atomic instructions
- *   - memory ordering primitives (barriers)
- * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
- *
- * Once a guest architecture has been converted to the new primitives
- * there are two remaining limitations to check.
- *
- * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
- * - The host must have a stronger memory order than the guest
- *
- * It may be possible in future to support strong guests on weak hosts
- * but that will require tagging all load/stores in a guest with their
- * implicit memory order requirements which would likely slow things
- * down a lot.
- */
-
-static bool check_tcg_memory_orders_compatible(void)
-{
-#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
-    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) == 0;
-#else
-    return false;
-#endif
-}
-
-static bool default_mttcg_enabled(void)
-{
-    if (use_icount || TCG_OVERSIZED_GUEST) {
-        return false;
-    } else {
-#ifdef TARGET_SUPPORTS_MTTCG
-        return check_tcg_memory_orders_compatible();
-#else
-        return false;
-#endif
-    }
-}
-
-void qemu_tcg_configure(QemuOpts *opts, Error **errp)
-{
-    const char *t = qemu_opt_get(opts, "thread");
-    if (t) {
-        if (strcmp(t, "multi") == 0) {
-            if (TCG_OVERSIZED_GUEST) {
-                error_setg(errp, "No MTTCG when guest word size > hosts");
-            } else if (use_icount) {
-                error_setg(errp, "No MTTCG when icount is enabled");
-            } else {
-#ifndef TARGET_SUPPORTS_MTTCG
-                warn_report("Guest not yet converted to MTTCG - "
-                            "you may get unexpected results");
-#endif
-                if (!check_tcg_memory_orders_compatible()) {
-                    warn_report("Guest expects a stronger memory ordering "
-                                "than the host provides");
-                    error_printf("This may cause strange/hard to debug errors\n");
-                }
-                mttcg_enabled = true;
-            }
-        } else if (strcmp(t, "single") == 0) {
-            mttcg_enabled = false;
-        } else {
-            error_setg(errp, "Invalid 'thread' setting %s", t);
-        }
-    } else {
-        mttcg_enabled = default_mttcg_enabled();
-    }
-}
 
 /* The current number of executed instructions is based on what we
  * originally budgeted minus the current state of the decrementing
-- 
1.8.3.1



