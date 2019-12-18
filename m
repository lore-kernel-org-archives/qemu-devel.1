Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E479C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485622072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSb4RNaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485622072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYHf-0001b3-M4
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY35-0006FL-M3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2z-0000RV-Vf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:27 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2z-0000Nc-E6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:21 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so1561170wmc.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oafxCydgQY02VpdhM1ynHEUTP4YLeatsAL+0uqEzaBs=;
 b=tSb4RNaNFxFKj+9Ya45PDfb52UGb3HQCMvo6nSPQ4aFqE6bmsHFYHcMt9YufIAhlw5
 m1uraC4LnNEm/oGvK4UMnd+SblUqA79za7dDMu2s4N477gHsT/JIQaCiaCJhnoEw1MLY
 DZGqjSKNzNMU+N8icZ2NpqU7p9Co2ElFvcBqlx5Oyiv3EJJb3MGSPoSrmLU5zALSyGzp
 bxNxbTsj76OiitolyBS/VknuBYJuhU31Ra5KTZc5KCmVVFGFlSL9YdzZL8AiNmE44RJA
 LxAuO1W3GA/ipPnLkfYduB/qDHVTdR62TcGRKpb85nks/nt0Zn6RDkUPhK+ylBmJNOB7
 JEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oafxCydgQY02VpdhM1ynHEUTP4YLeatsAL+0uqEzaBs=;
 b=c+4/XcE2ozMlQzx+Ga4y0psLgjBGRR2AfD+XDNnVCQDn91etWkWe2n6BVaBeiw8pGS
 50tu+jvWjD2LGU12dJkwocaVtiMkuLiqatUs7R4YwshpHppvcQycQr7H7Tt58YGk1SYi
 OVXMgCKa69Egcu1WFei9fUHfFY6ZBbCBUOrPkvOCLDEm5bzpJZy2OhIjBss193/18vNx
 Th01L6jGB+cwZWCoH9gWMR16g5BNt+YcvHDdA7VNtJDt5RvdjutRKKZXEk6WAoNJIopk
 vuiztSkhXQLGAfowljsoCrB3+Zuwm8eToCeNcepCk1vuoSiq/feM8r7Ak6MM0Lo5hFE2
 GtGw==
X-Gm-Message-State: APjAAAWecYiqg95zfAc+XuZ4WzgoX+XNyza+7ts6KExY3XEBd5qT/9SA
 UlByg8fIZ7eu7igLP3wYMRAjpcXx
X-Google-Smtp-Source: APXvYqwbVfpAAexCDztdV/e2eu2ACZGkEjDI/AD8B6cOclL4gE2hRgK0/0CW0nILOOvkEYtJLaxpHg==
X-Received: by 2002:a1c:5a0a:: with SMTP id o10mr2788652wmb.114.1576670599170; 
 Wed, 18 Dec 2019 04:03:19 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/87] tcg: convert "-accel threads" to a QOM property
Date: Wed, 18 Dec 2019 13:01:50 +0100
Message-Id: <1576670573-48048-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the ad-hoc qemu_tcg_configure with generic code invoking QOM
property getters and setters.  More properties (and thus more valid
-accel suboptions) will be added in the next patches, which will move
accelerator-related "-machine" options to accelerators.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-all.c   | 52 +++++++++++++++++++++++++++++++++++++--------------
 include/sysemu/cpus.h |  2 --
 vl.c                  | 32 ++++++++++++++++---------------
 3 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 6b000f0..7829f02 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -34,7 +34,17 @@
 #include "include/qapi/error.h"
 #include "include/qemu/error-report.h"
 #include "include/hw/boards.h"
-#include "qemu/option.h"
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
 
@@ -107,23 +117,33 @@ static bool default_mttcg_enabled(void)
 
 static void tcg_accel_instance_init(Object *obj)
 {
-    mttcg_enabled = default_mttcg_enabled();
+    TCGState *s = TCG_STATE(obj);
+
+    s->mttcg_enabled = default_mttcg_enabled();
 }
 
 static int tcg_init(MachineState *ms)
 {
+    TCGState *s = TCG_STATE(current_machine->accelerator);
+
     tcg_exec_init(tcg_tb_size * 1024 * 1024);
     cpu_interrupt_handler = tcg_handle_interrupt;
+    mttcg_enabled = s->mttcg_enabled;
     return 0;
 }
 
-void qemu_tcg_configure(QemuOpts *opts, Error **errp)
+static char *tcg_get_thread(Object *obj, Error **errp)
 {
-    const char *t = qemu_opt_get(opts, "thread");
-    if (!t) {
-        return;
-    }
-    if (strcmp(t, "multi") == 0) {
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
         if (TCG_OVERSIZED_GUEST) {
             error_setg(errp, "No MTTCG when guest word size > hosts");
         } else if (use_icount) {
@@ -138,12 +158,12 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
                             "than the host provides");
                 error_printf("This may cause strange/hard to debug errors\n");
             }
-            mttcg_enabled = true;
+            s->mttcg_enabled = true;
         }
-    } else if (strcmp(t, "single") == 0) {
-        mttcg_enabled = false;
+    } else if (strcmp(value, "single") == 0) {
+        s->mttcg_enabled = false;
     } else {
-        error_setg(errp, "Invalid 'thread' setting %s", t);
+        error_setg(errp, "Invalid 'thread' setting %s", value);
     }
 }
 
@@ -153,15 +173,19 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
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
     .instance_init = tcg_accel_instance_init,
     .class_init = tcg_accel_class_init,
+    .instance_size = sizeof(TCGState),
 };
 
 static void register_accel_types(void)
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
index b2f00cc..7f2f3fb 100644
--- a/vl.c
+++ b/vl.c
@@ -293,17 +293,12 @@ static QemuOptsList qemu_accel_opts = {
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
 
@@ -2711,6 +2706,13 @@ static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
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
@@ -2725,6 +2727,10 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
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
@@ -2732,10 +2738,6 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
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



