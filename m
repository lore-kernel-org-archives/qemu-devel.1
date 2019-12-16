Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CDFC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1267206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfgQLdwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1267206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtQB-0002Yq-8H
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF2-0004rS-L0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF0-0007Bq-VL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:04 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtF0-0007AC-Nc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:02 -0500
Received: by mail-wr1-x429.google.com with SMTP id w15so8063669wru.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=u7/VzsObPJenJKrRI20Is7W11ftIW2OHO+f1XruWVNs=;
 b=pfgQLdwnFYrkzaiYGxfdRwIky1EAG7S3mqN3ciPQpL+fR/r/ILW/Dw1tG+D+7/VcuQ
 mvDaD3lBIR6EFTIvlbH4faSSFpbpYIn9UeJGLwxWbPFcGVSc+R0jCLk55q/nwYOr1cOG
 8jvbJ5/tl/d8nTH8tUzcNoa13xyELjVH4YSztEmXSDzXV0JuhTQBfjOouWfrS0n2mEvJ
 Hpp/1A7E/3Hi92RO9eNjsjJPQYufgl6B3z9PSsuYXT0pRLsoVEqkFGgFONLjI0hsd+WH
 m0SP1hhDcVJqbEHMYa2s0tY98cLdthRLuwTrLpd/63No/J/Wp6ZpQlR8pkBsJktPX+u0
 nwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=u7/VzsObPJenJKrRI20Is7W11ftIW2OHO+f1XruWVNs=;
 b=ZEQV5kJT8fWAsmfmg6qVz6SWX6AHge+oZ9h7XaotSc5MOuBu8Tl9zG+h4zTgeJ+Ako
 S3bneqmlFz97ANvdM6CDPovFLWwp8aHTCd8alYEQv/CN51a87hx/+mNoOJBnMBM42Itz
 b7v6MNFgBqcJZs5rbnn/pZHSmFz3BoVaPwPKPRKANSteZLvqVV/eA+WjLZO3gTmItrSr
 yj8VPY9Tk6D6TdIrU6tZfroiXrmtLWPI1jMd7duubzqfNIZ/4quvXi3IsIX48qzQ5O0z
 +vR2rizz3fiyV9m/3BqElZrs6iKVVYtghWpe4xHqA1w68zfJkfbGTcm7hmDqqccPQv2b
 xnDg==
X-Gm-Message-State: APjAAAWjTX75jsQb76Fw1PvX3Jd1IoX9CfqEirWFTnC/+hyrMsyVHUTP
 DMdr82yhdHaFJ4AFe6NXR28FMGjW
X-Google-Smtp-Source: APXvYqzzFVJd9gvjEZgK1WF8+IDkz7bVJypw5mk5AeFu/AAhw2KXh0D2O6/c5DgeqYzMFEn3rFVBQQ==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr30893270wrs.222.1576513741413; 
 Mon, 16 Dec 2019 08:29:01 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/62] tcg: move qemu_tcg_configure to accel/tcg/tcg-all.c
Date: Mon, 16 Dec 2019 17:27:58 +0100
Message-Id: <1576513726-53700-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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



