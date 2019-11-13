Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C54C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E180D222CA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYixFIYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E180D222CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtyg-00023C-LN
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnl-0005wJ-FW
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnj-0006M3-Lb
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:21 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtnj-0006Li-EU
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:19 -0500
Received: by mail-wm1-x342.google.com with SMTP id z26so2251302wmi.4
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Y+16lVLuNcBNpTOJq/xCtuQdbLbwB1u4ci4+zWS4pdw=;
 b=MYixFIYjArAN4hDypeka4NMayAR15LwczewDBWt0t+x98jWLFupXWBQv6VCgVm8aRF
 kAxX5WysQXyNYtHJgqq4CsQdNTLEphjwGyuCgLwv2dVE3SAFWL9vonUUALv+bOr3ATwi
 U9dWYpmFlKhYkJCU4lYZOm2lLIojFZDbD/SyKmpNwGzn+sdxVAApwSHvNLb+PsnroOyO
 ZFImwUFUfQAIHOsHKlleUqN1ENAnKpM+OMo7k8CY/TZ1DaEc1pOyDnl7IjpgQ7LKp71e
 wFlLdhzYGBEjoyfdhg7eToWdG6O41op05PS+HYIoiy3T75MD08kliw8++nFr6cUi0uxk
 NPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Y+16lVLuNcBNpTOJq/xCtuQdbLbwB1u4ci4+zWS4pdw=;
 b=UyJpWQmU7rSUIFeuYvw/BJsAozLz4hxcYq/A9XFW7CyDdoBkO8x8oBAp8xM9tdZ9pL
 ygZvR+7EcX04V1rHFcHrztlL+eatm8UJLRc+nQ90braLWqAe3GCGplUkDptGgn1tAmwy
 HvNYbqhch9L0rYiPZrAKKSrP83k0eSpaHdAUIsqtSa1z7KT5f94gtEHnE7yUM+KII7ic
 /cwF5bBFC6Xd8V2tpz4uRI4z0l0/sRsVtiT38om4Q3BpraPsQxRdFR2S0I+KbWywQnvE
 HjMIDJ4v8z5GbyoqqaNx+cfgXOYjpiDcPda6GavALYNqw/VgRiAcom4gVd35fovpI2Re
 tCBQ==
X-Gm-Message-State: APjAAAU+qW4H+TTpfMJF0vmlLazn/66bQ99OAKgw0wL/ihAjtbCno448
 p5JfzlhHuqkfreQGKhkVBQzymC81
X-Google-Smtp-Source: APXvYqwv2S71mFbxxTNOzi3H25bI8Y1JX/i3hMuVEEDndOqFqc26A4P7EXU4zwMPNt4nrlEGGrnDUg==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr2735545wmc.9.1573655957158;
 Wed, 13 Nov 2019 06:39:17 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/16] tcg: convert "-accel threads" to a QOM property
Date: Wed, 13 Nov 2019 15:39:00 +0100
Message-Id: <1573655945-14912-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the ad-hoc qemu_tcg_configure with generic code invoking
QOM property getters and setters.  This will be extended in the
next patches, which will turn accelerator-related "-machine"
options into QOM properties as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-all.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++++++-
 cpus.c                |  72 --------------------------------
 include/sysemu/cpus.h |   2 -
 vl.c                  |  32 ++++++++-------
 4 files changed, 126 insertions(+), 91 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c59d5b0..7829f02 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -30,6 +30,21 @@
 #include "cpu.h"
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"
+#include "tcg/tcg.h"
+#include "include/qapi/error.h"
+#include "include/qemu/error-report.h"
+#include "include/hw/boards.h"
+
+typedef struct TCGState {
+    AccelState parent_obj;
+
+    bool mttcg_enabled;
+} TCGState;
+
+#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
+
+#define TCG_STATE(obj) \
+        OBJECT_CHECK(TCGState, (obj), TYPE_TCG_ACCEL)
 
 unsigned long tcg_tb_size;
 
@@ -58,27 +73,119 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
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
+    TCGState *s = TCG_STATE(obj);
+
+    s->mttcg_enabled = default_mttcg_enabled();
+}
+
 static int tcg_init(MachineState *ms)
 {
+    TCGState *s = TCG_STATE(current_machine->accelerator);
+
     tcg_exec_init(tcg_tb_size * 1024 * 1024);
     cpu_interrupt_handler = tcg_handle_interrupt;
+    mttcg_enabled = s->mttcg_enabled;
     return 0;
 }
 
+static char *tcg_get_thread(Object *obj, Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+
+    return g_strdup(s->mttcg_enabled ? "multi" : "single");
+}
+
+static void tcg_set_thread(Object *obj, const char *value, Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+
+    if (strcmp(value, "multi") == 0) {
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
+            s->mttcg_enabled = true;
+        }
+    } else if (strcmp(value, "single") == 0) {
+        s->mttcg_enabled = false;
+    } else {
+        error_setg(errp, "Invalid 'thread' setting %s", value);
+    }
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init;
     ac->allowed = &tcg_allowed;
-}
 
-#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
+    object_class_property_add_str(oc, "thread",
+                                  tcg_get_thread,
+                                  tcg_set_thread,
+                                  NULL);
+}
 
 static const TypeInfo tcg_accel_type = {
     .name = TYPE_TCG_ACCEL,
     .parent = TYPE_ACCEL,
+    .instance_init = tcg_accel_instance_init,
     .class_init = tcg_accel_class_init,
+    .instance_size = sizeof(TCGState),
 };
 
 static void register_accel_types(void)
diff --git a/cpus.c b/cpus.c
index fabbeca..69d4f6a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -165,78 +165,6 @@ typedef struct TimersState {
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
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 32c05f2..3c1da6a 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -40,6 +40,4 @@ extern int smp_threads;
 
 void list_cpus(const char *optarg);
 
-void qemu_tcg_configure(QemuOpts *opts, Error **errp);
-
 #endif
diff --git a/vl.c b/vl.c
index c8ec906..2ea94c7 100644
--- a/vl.c
+++ b/vl.c
@@ -294,17 +294,12 @@ static QemuOptsList qemu_accel_opts = {
     .implied_opt_name = "accel",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_accel_opts.head),
     .desc = {
-        {
-            .name = "accel",
-            .type = QEMU_OPT_STRING,
-            .help = "Select the type of accelerator",
-        },
-        {
-            .name = "thread",
-            .type = QEMU_OPT_STRING,
-            .help = "Enable/disable multi-threaded TCG",
-        },
-        { /* end of list */ }
+        /*
+         * no elements => accept any
+         * sanity checking will happen later
+         * when setting accelerator properties
+         */
+        { }
     },
 };
 
@@ -2841,6 +2836,13 @@ static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static int accelerator_set_property(void *opaque,
+                                const char *name, const char *value,
+                                Error **errp)
+{
+    return object_parse_property_opt(opaque, name, value, "accel", errp);
+}
+
 static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
 {
     bool *p_init_failed = opaque;
@@ -2855,6 +2857,10 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
         return 0;
     }
     accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
+    qemu_opt_foreach(opts, accelerator_set_property,
+                     accel,
+                     &error_fatal);
+
     ret = accel_init_machine(accel, current_machine);
     if (ret < 0) {
         *p_init_failed = true;
@@ -2862,10 +2868,6 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
                      acc, strerror(-ret));
         return 0;
     }
-
-    if (tcg_enabled()) {
-        qemu_tcg_configure(opts, &error_fatal);
-    }
     return 1;
 }
 
-- 
1.8.3.1



