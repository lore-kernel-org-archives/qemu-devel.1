Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9C3C17447
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6A5222CD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upyJIbbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6A5222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtsA-00031J-99
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnf-0005mB-SD
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtne-0006K4-8D
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:15 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtne-0006Jf-0w
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:14 -0500
Received: by mail-wr1-x42f.google.com with SMTP id s5so2661129wrw.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Na0X6tD4ZljnoxlrSDpoo7TALwUaYoZx+hQdqFyPXBw=;
 b=upyJIbbJgtqHoBCNVXlzbW5HD2N2Q0jIgByquHlV1B+k1WiZdz3Z3xn66KsFcgzMd4
 gn4XYDNL9pu0LDNsSmLepJSuYq/HGwMYLKjf1LOAJqTKkb8uJTCI+vxL9dVl7N/8701N
 +vZDMhPsCo/jWj2SeHtGvAXE4eRwfqpp/+yntQeuFNWF7QubKWLSWDtWpjFODFBLmm5I
 9fUxhpuGbN7JHCm1g80xOasIAyCNJRO9YKkIMvtoBnaTGsFfBDyM9xaE0CPZV0u5wmgr
 KMU7EIcOohCl8Bio3f9TzStefbytdM0AdmD9dT1sCXiwGqB76k0XXhHonnytEJTWlK0K
 9tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Na0X6tD4ZljnoxlrSDpoo7TALwUaYoZx+hQdqFyPXBw=;
 b=COzqY8RLhGfch63KNl8KfP34hIqrbs1oscJr2E+34vOhannePUiHMxmFeWZ7WUlQVC
 k2EJa2xu7KQS81bS2IZGpQziCkSbUmAH6LiE6c4QbjsROdniAeaAu56FyD+g2HwCPyAt
 JiJSCtdjrDyTQAaO8lJQxkxE1HqVEldj46vJrY+hppCfTPb+0LYRFDn6o7OunyLpIleo
 tv+EG5JCHtpmNCzyMeuClQPA0LcLNEb3RZ9u8idqfeTT9p5nCCDZYDZW/Pj86JVOdZok
 8YMfT9a3a+/UFs2JJETeMWB8rm4c4GoSK9roWPfUPJX61kiPBQXsjwUcaEKjTDGwxQx1
 zD9w==
X-Gm-Message-State: APjAAAVJy2Ed8BW5FGkm65BBslSdcWr62RPyMgIx8fIICTZKYL2G6ghL
 Zsj4gR71ETAvo9ZQ3RwjfrZ+1Zik
X-Google-Smtp-Source: APXvYqya0qtv7PNmHngS7cmFYAVcWFcrNzyk9qJREnNmNVVHyEqpmYYIOGBZyLmplb9y4hxosqF1XA==
X-Received: by 2002:adf:f18e:: with SMTP id h14mr3300376wro.348.1573655952596; 
 Wed, 13 Nov 2019 06:39:12 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/16] vl: configure accelerators from -accel options
Date: Wed, 13 Nov 2019 15:38:55 +0100
Message-Id: <1573655945-14912-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

Drop the "accel" property from MachineState, and instead desugar
"-machine accel=" to a list of "-accel" options.

This has a semantic change due to removing merge_lists from -accel.
For example:

- "-accel kvm -accel tcg" all but ignored "-accel kvm".  This is a bugfix.

- "-accel kvm -accel thread=single" ignored "thread=single", since it
  applied the option to KVM.  Now it fails due to not specifying the
  accelerator on "-accel thread=single".

- "-accel tcg -accel thread=single" chose single-threaded TCG, while now
  it will fail due to not specifying the accelerator on "-accel
  thread=single".

Also, "-machine accel" and "-accel" become incompatible.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c   | 21 ------------
 include/hw/boards.h |  1 -
 vl.c                | 93 +++++++++++++++++++++++++++++++----------------------
 3 files changed, 54 insertions(+), 61 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3..45ddfb6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -173,21 +173,6 @@ GlobalProperty hw_compat_2_1[] = {
 };
 const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
 
-static char *machine_get_accel(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->accel);
-}
-
-static void machine_set_accel(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->accel);
-    ms->accel = g_strdup(value);
-}
-
 static void machine_set_kernel_irqchip(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
@@ -808,11 +793,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_align_shift = 23;
     mc->numa_auto_assign_ram = numa_default_auto_assign_ram;
 
-    object_class_property_add_str(oc, "accel",
-        machine_get_accel, machine_set_accel, &error_abort);
-    object_class_property_set_description(oc, "accel",
-        "Accelerator list", &error_abort);
-
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, machine_set_kernel_irqchip,
         NULL, NULL, &error_abort);
@@ -971,7 +951,6 @@ static void machine_finalize(Object *obj)
 {
     MachineState *ms = MACHINE(obj);
 
-    g_free(ms->accel);
     g_free(ms->kernel_filename);
     g_free(ms->initrd_filename);
     g_free(ms->kernel_cmdline);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index de45087..36fcbda 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -275,7 +275,6 @@ struct MachineState {
 
     /*< public >*/
 
-    char *accel;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
     bool kernel_irqchip_split;
diff --git a/vl.c b/vl.c
index b93217d..dd895db 100644
--- a/vl.c
+++ b/vl.c
@@ -293,7 +293,6 @@ static QemuOptsList qemu_accel_opts = {
     .name = "accel",
     .implied_opt_name = "accel",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_accel_opts.head),
-    .merge_lists = true,
     .desc = {
         {
             .name = "accel",
@@ -2651,6 +2650,11 @@ static int machine_set_property(void *opaque,
         }
     }
 
+    /* Legacy options do not correspond to MachineState properties.  */
+    if (g_str_equal(qom_name, "accel")) {
+        return 0;
+    }
+
     r = object_parse_property_opt(opaque, name, value, "type", errp);
     g_free(qom_name);
     return r;
@@ -2843,74 +2847,88 @@ static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
 
 static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
 {
+    bool *p_init_failed = opaque;
+    const char *acc = qemu_opt_get(opts, "accel");
+    AccelClass *ac = accel_find(acc);
+    int ret;
+
+    if (!ac) {
+        return 0;
+    }
+    ret = accel_init_machine(ac, current_machine);
+    if (ret < 0) {
+        *p_init_failed = true;
+        error_report("failed to initialize %s: %s",
+                     acc, strerror(-ret));
+        return 0;
+    }
+
     if (tcg_enabled()) {
         qemu_tcg_configure(opts, &error_fatal);
     }
-    return 0;
+    return 1;
 }
 
 static void configure_accelerators(const char *progname)
 {
     const char *accel;
     char **accel_list, **tmp;
-    int ret;
     bool accel_initialised = false;
     bool init_failed = false;
-    AccelClass *acc = NULL;
 
     qemu_opts_foreach(qemu_find_opts("icount"),
                       do_configure_icount, NULL, &error_fatal);
 
     accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
-    if (accel == NULL) {
-        /* Select the default accelerator */
-        if (!accel_find("tcg") && !accel_find("kvm")) {
-            error_report("No accelerator selected and"
-                         " no default accelerator available");
-            exit(1);
-        } else {
-            int pnlen = strlen(progname);
-            if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
-                /* If the program name ends with "kvm", we prefer KVM */
-                accel = "kvm:tcg";
+    if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
+        if (accel == NULL) {
+            /* Select the default accelerator */
+            if (!accel_find("tcg") && !accel_find("kvm")) {
+                error_report("No accelerator selected and"
+                             " no default accelerator available");
+                exit(1);
             } else {
-                accel = "tcg:kvm";
+                int pnlen = strlen(progname);
+                if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
+                    /* If the program name ends with "kvm", we prefer KVM */
+                    accel = "kvm:tcg";
+                } else {
+                    accel = "tcg:kvm";
+                }
             }
         }
-    }
 
-    accel_list = g_strsplit(accel, ":", 0);
+        accel_list = g_strsplit(accel, ":", 0);
 
-    for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
-        acc = accel_find(*tmp);
-        if (!acc) {
-            continue;
+        for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
+            /*
+             * Filter invalid accelerators here, to prevent obscenities
+             * such as "-machine accel=tcg,,thread=single".
+             */
+            if (accel_find(*tmp)) {
+                qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, true);
+            }
         }
-        ret = accel_init_machine(acc, current_machine);
-        if (ret < 0) {
-            init_failed = true;
-            error_report("failed to initialize %s: %s",
-                         acc->name, strerror(-ret));
-        } else {
-            accel_initialised = true;
+    } else {
+        if (accel != NULL) {
+            error_report("The -accel and \"-machine accel=\" options are incompatible");
+            exit(1);
         }
     }
-    g_strfreev(accel_list);
 
-    if (!accel_initialised) {
+    if (!qemu_opts_foreach(qemu_find_opts("accel"),
+                           do_configure_accelerator, &init_failed, &error_fatal)) {
         if (!init_failed) {
-            error_report("-machine accel=%s: No accelerator found", accel);
+            error_report("no accelerator found");
         }
         exit(1);
     }
 
     if (init_failed) {
-        error_report("Back to %s accelerator", acc->name);
+        AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
+        error_report("Back to %s accelerator", ac->name);
     }
 
-    qemu_opts_foreach(qemu_find_opts("accel"),
-                      do_configure_accelerator, NULL, &error_fatal);
-
     if (!tcg_enabled() && use_icount) {
         error_report("-icount is not allowed with hardware virtualization");
         exit(1);
@@ -3618,9 +3636,6 @@ int main(int argc, char **argv, char **envp)
                                  "use -M accel=... for now instead");
                     exit(1);
                 }
-                opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
-                                        false, &error_abort);
-                qemu_opt_set(opts, "accel", optarg, &error_abort);
                 break;
             case QEMU_OPTION_usb:
                 olist = qemu_find_opts("machine");
-- 
1.8.3.1



