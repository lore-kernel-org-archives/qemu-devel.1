Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0841C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEAD206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naRdg8t1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEAD206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtSi-0006Jo-Bk
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF4-0004v3-UG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF3-0007HZ-BL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:51968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtF3-0007F3-3p
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id d73so7440962wmd.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Fn/zzlT03nOmdiYOhDzmLdgNJP3vAWSij9EwHSCsuo=;
 b=naRdg8t1jrPnMawR0oslRcVD9W4oxD+k+EzyckXp2+BPC9qQTFvKwLvS6fwh9RDQid
 sovQfgGdgd2BHSBZ7c9ElMnDEfQiovwSSSESBQftIvU06e/qBOb7fIHgDjxGmHnw0lme
 00YKwGpEXuPoV7IojlWMMa+GjtneynRVEQYEIwDvBS5TVqGoclmX08Bmp4MzQz7954Hd
 UGqHTha+dnt2r/EgCahEYZVyaiGXnq1PJMuUvedAJrSjajFVGeO1529a1rU+qpmju8J1
 zepbc8U/XN4ltukEM7tpUZrHxnGrMIscjNCJ+kHKp8kVCOThjI8WZddo8G683SY2RHBB
 +hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/Fn/zzlT03nOmdiYOhDzmLdgNJP3vAWSij9EwHSCsuo=;
 b=ISu5SSZELqKKJz4WgnI/oOupuwCUviN0z/LQQNQI0Zeeo2M28RU6ifhhHj1FicKAqn
 vpcXKMl7AV/ocJ4TKMzmgzbATpnPKo0ojYhZ2vdmksAw3mKxg9cnue1zNV9L+vkVhnfL
 UpsDK4T2528V6AjdPkit6zqrwJ9kkXKigcOIVMLBtQivnBMdTasoztHlipRvvto8+xre
 pd/Ag+rkRlPJnw2SYiFym3+yP1eit7rY+S2vbPaGhxBB7VnASj7sJcrq7H5EYQzd36TN
 Th45IFkLVn4DW1qGoJfH7rrRUX2BpvarjeggWJbmHLfQLr3/ThAhakattzwbAGXiNxdr
 6k+w==
X-Gm-Message-State: APjAAAXJNm1wNG2gkezHiiDchyDqK9ytqUX51OoAndsoLtFdlazCxNt+
 XF5bz0X3VoJB8t83m5I3MQ5qvmuh
X-Google-Smtp-Source: APXvYqxB84VqkxAMEGgHstnt9oZEITxxkRbWT1TUKAccQ6rxHxtMRoSmCe0q/nbRb7jADwgLkFZLMw==
X-Received: by 2002:a7b:c10f:: with SMTP id w15mr21464955wmi.69.1576513743262; 
 Mon, 16 Dec 2019 08:29:03 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/62] vl: merge -accel processing into configure_accelerators
Date: Mon, 16 Dec 2019 17:28:00 +0100
Message-Id: <1576513726-53700-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
index 6e454a0..14c78bc 100644
--- a/vl.c
+++ b/vl.c
@@ -2839,8 +2839,65 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
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
 
@@ -4167,9 +4224,7 @@ int main(int argc, char **argv, char **envp)
      * Note: uses machine properties such as kernel-irqchip, must run
      * after machine_set_property().
      */
-    qemu_opts_foreach(qemu_find_opts("icount"),
-                      do_configure_icount, NULL, &error_fatal);
-    configure_accelerator(current_machine, argv[0]);
+    configure_accelerators(argv[0]);
 
     /*
      * Beware, QOM objects created before this point miss global and
@@ -4254,7 +4309,6 @@ int main(int argc, char **argv, char **envp)
     qemu_spice_init();
 
     cpu_ticks_init();
-    configure_accelerators();
 
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
-- 
1.8.3.1



