Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ACDC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9B82072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bckHgj1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9B82072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihY9V-0007Dn-W1
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2s-0006AG-Uu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2r-00007m-6F
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:14 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2q-0008Us-Ih
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:12 -0500
Received: by mail-wr1-x431.google.com with SMTP id c14so1999803wrn.7
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3BGv9sEI70WyhhrGO9t9As7mziy/qWreFJRvngEh1iI=;
 b=bckHgj1qzyZg7X1bfUpWLTYkKim2Ldq3YZQ7hM8Bb0Ae7pYqD2BFA4Pf9LyyZvb3Z2
 cucFORzqJL/hEy1NlcrWxbVXScMV6qWfreFQuFiCZqUyLvfWg9a4ugSiQHZ7DFM5/+2j
 KAWyPi4BNA01IfdzqHzCSxINukVvrdzAc8SUzdJEjwj7o7gQYs6jSSXmpMQyVMCqxp5T
 FBmqm6cuLlJCW8XpIuaxtzAIUvAvKYRr34Drsc9HixBTFoDgwvZxGFy+5c9DJEABH3wY
 j0084x2b85neIBWLff4TVXIXXqdRvPCxHOsQt5zF8RueDKPtscNO9+rPA5J88f+7Vlbp
 Cfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3BGv9sEI70WyhhrGO9t9As7mziy/qWreFJRvngEh1iI=;
 b=SihKq2tASRrulp9ZiyMmBfaJEJVPPnVA/3d5jgpzs6VqlJPldSd4N6yAKAgXHA9rwk
 HgA+6v0bnUO7SgpqFM/eXoy0Ta2biLaJz5iH2iA2vOvWmKjJ00WaYwSFRMjnYe9K5JmA
 w+oznZk469exiJw9ITz5qRY7GUiH0UFIZbU3Re/qudVGs6kpv8jxtNfYFku5e2Gm86OE
 tiNAmOBl1H2js9rYHFQmOq8PnLeGu4UwLkobL7db3VlQQLHUK+2Nh942QjKC+GAu9//o
 tMuQXY/4WdWST+IlY9XyImzOk9eX4rJLzFyQtFBObGjvlKlyYyahelzQ2BHg2u0fUJBT
 hwVw==
X-Gm-Message-State: APjAAAXxA643giw3411j/gpbVxiitd80gEjIvPhlABzxSEzSVkfmW4Sg
 94uj4/BY6MitDAOZFsecOu6IGZyH
X-Google-Smtp-Source: APXvYqwDLfC/ZaLJLwJ2XR2wouZlpl3NuDbeM+/kIlb2w0JJ5F1fuNTHxksdXixEJ0DN+Mqkbo5ptA==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr2487465wrv.302.1576670591223; 
 Wed, 18 Dec 2019 04:03:11 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/87] vl: merge -accel processing into configure_accelerators
Date: Wed, 18 Dec 2019 13:01:42 +0100
Message-Id: <1576670573-48048-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

The next step is to move the parsing of "-machine accel=..." into vl.c,
unifying it with the configure_accelerators() function that has just
been introduced.  This way, we will be able to desugar it into multiple
"-accel" options, without polluting accel/accel.c.

The CONFIG_TCG and CONFIG_KVM symbols are not available in vl.c, but
we can use accel_find instead to find their value at runtime.  Once we
know that the binary has one of TCG or KVM, the default accelerator
can be expressed simply as "tcg:kvm", because TCG never fails to initialize.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c          | 69 ++------------------------------------------------
 include/sysemu/accel.h |  4 ++-
 vl.c                   | 64 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 64 insertions(+), 73 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 5fa3171..60c3827 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -28,13 +28,7 @@
 #include "hw/boards.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
-#include "sysemu/qtest.h"
-#include "hw/xen/xen.h"
 #include "qom/object.h"
-#include "qemu/error-report.h"
-#include "qemu/option.h"
-#include "qapi/error.h"
 
 static const TypeInfo accel_type = {
     .name = TYPE_ACCEL,
@@ -44,7 +38,7 @@ static const TypeInfo accel_type = {
 };
 
 /* Lookup AccelClass from opt_name. Returns NULL if not found */
-static AccelClass *accel_find(const char *opt_name)
+AccelClass *accel_find(const char *opt_name)
 {
     char *class_name = g_strdup_printf(ACCEL_CLASS_NAME("%s"), opt_name);
     AccelClass *ac = ACCEL_CLASS(object_class_by_name(class_name));
@@ -52,7 +46,7 @@ static AccelClass *accel_find(const char *opt_name)
     return ac;
 }
 
-static int accel_init_machine(AccelClass *acc, MachineState *ms)
+int accel_init_machine(AccelClass *acc, MachineState *ms)
 {
     ObjectClass *oc = OBJECT_CLASS(acc);
     const char *cname = object_class_get_name(oc);
@@ -71,65 +65,6 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
     return ret;
 }
 
-void configure_accelerator(MachineState *ms, const char *progname)
-{
-    const char *accel;
-    char **accel_list, **tmp;
-    int ret;
-    bool accel_initialised = false;
-    bool init_failed = false;
-    AccelClass *acc = NULL;
-
-    accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
-    if (accel == NULL) {
-        /* Select the default accelerator */
-        int pnlen = strlen(progname);
-        if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
-            /* If the program name ends with "kvm", we prefer KVM */
-            accel = "kvm:tcg";
-        } else {
-#if defined(CONFIG_TCG)
-            accel = "tcg";
-#elif defined(CONFIG_KVM)
-            accel = "kvm";
-#else
-            error_report("No accelerator selected and"
-                         " no default accelerator available");
-            exit(1);
-#endif
-        }
-    }
-
-    accel_list = g_strsplit(accel, ":", 0);
-
-    for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
-        acc = accel_find(*tmp);
-        if (!acc) {
-            continue;
-        }
-        ret = accel_init_machine(acc, ms);
-        if (ret < 0) {
-            init_failed = true;
-            error_report("failed to initialize %s: %s",
-                         acc->name, strerror(-ret));
-        } else {
-            accel_initialised = true;
-        }
-    }
-    g_strfreev(accel_list);
-
-    if (!accel_initialised) {
-        if (!init_failed) {
-            error_report("-machine accel=%s: No accelerator found", accel);
-        }
-        exit(1);
-    }
-
-    if (init_failed) {
-        error_report("Back to %s accelerator", acc->name);
-    }
-}
-
 void accel_setup_post(MachineState *ms)
 {
     AccelState *accel = ms->accelerator;
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 8eb60b8..90b6213 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -66,7 +66,9 @@ typedef struct AccelClass {
 
 extern unsigned long tcg_tb_size;
 
-void configure_accelerator(MachineState *ms, const char *progname);
+AccelClass *accel_find(const char *opt_name);
+int accel_init_machine(AccelClass *acc, MachineState *ms);
+
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
 
diff --git a/vl.c b/vl.c
index 7ed9026..28adf38 100644
--- a/vl.c
+++ b/vl.c
@@ -2714,8 +2714,65 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
-static void configure_accelerators(void)
+static void configure_accelerators(const char *progname)
 {
+    const char *accel;
+    char **accel_list, **tmp;
+    int ret;
+    bool accel_initialised = false;
+    bool init_failed = false;
+    AccelClass *acc = NULL;
+
+    qemu_opts_foreach(qemu_find_opts("icount"),
+                      do_configure_icount, NULL, &error_fatal);
+
+    accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
+    if (accel == NULL) {
+        /* Select the default accelerator */
+        if (!accel_find("tcg") && !accel_find("kvm")) {
+            error_report("No accelerator selected and"
+                         " no default accelerator available");
+            exit(1);
+        } else {
+            int pnlen = strlen(progname);
+            if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
+                /* If the program name ends with "kvm", we prefer KVM */
+                accel = "kvm:tcg";
+            } else {
+                accel = "tcg:kvm";
+            }
+        }
+    }
+
+    accel_list = g_strsplit(accel, ":", 0);
+
+    for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
+        acc = accel_find(*tmp);
+        if (!acc) {
+            continue;
+        }
+        ret = accel_init_machine(acc, current_machine);
+        if (ret < 0) {
+            init_failed = true;
+            error_report("failed to initialize %s: %s",
+                         acc->name, strerror(-ret));
+        } else {
+            accel_initialised = true;
+        }
+    }
+    g_strfreev(accel_list);
+
+    if (!accel_initialised) {
+        if (!init_failed) {
+            error_report("-machine accel=%s: No accelerator found", accel);
+        }
+        exit(1);
+    }
+
+    if (init_failed) {
+        error_report("Back to %s accelerator", acc->name);
+    }
+
     qemu_opts_foreach(qemu_find_opts("accel"),
                       do_configure_accelerator, NULL, &error_fatal);
 
@@ -4035,9 +4092,7 @@ int main(int argc, char **argv, char **envp)
      * Note: uses machine properties such as kernel-irqchip, must run
      * after machine_set_property().
      */
-    qemu_opts_foreach(qemu_find_opts("icount"),
-                      do_configure_icount, NULL, &error_fatal);
-    configure_accelerator(current_machine, argv[0]);
+    configure_accelerators(argv[0]);
 
     /*
      * Beware, QOM objects created before this point miss global and
@@ -4122,7 +4177,6 @@ int main(int argc, char **argv, char **envp)
     qemu_spice_init();
 
     cpu_ticks_init();
-    configure_accelerators();
 
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
-- 
1.8.3.1



