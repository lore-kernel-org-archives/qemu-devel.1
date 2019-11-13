Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC7C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C7A222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODHF6XW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C7A222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUu01-00044p-Lu
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnl-0005vj-6w
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnj-0006Lx-Gn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:21 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtnj-0006LZ-A0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:19 -0500
Received: by mail-wr1-x429.google.com with SMTP id i12so2648466wro.5
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WMkY/N7ZGoVwQ6hEN+rLJ67VQGFFDvx1r2Y94rAjGB8=;
 b=ODHF6XW2I0qGDs8TYRVugRrz6B7UMTYs7DGFqHj9PNNJlLvXC/aEGMXwhwWmL827zn
 RbENAty7l1dMKMdUdQsv3pY7ZHXZfoYhqx1EqNRUzGE+XH28dLXCTU5Lz+/Z10fGPWxp
 Bc8rTUWBxRsNfvJwOnZEdYFnk9hEckRSSfnwEbeYWBH5eEQRA9YNWxKrTBXMdWDhXKLk
 EqkQoklveb0CDArtuJRJy0WF9x2XbEjAevZEiaGs11dPS8WmgPZMwstlNrx2mzWNMKAf
 aMkQJLrKbi6X18LHr9s4Z9S9fX4Sqwp6KMWA4swm2MW697Lb2DBYSlebZkVMsdyqlMus
 2RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=WMkY/N7ZGoVwQ6hEN+rLJ67VQGFFDvx1r2Y94rAjGB8=;
 b=O9OX+q8b0tQtW0hwJ9MOFre73raMGBeB2Wm5TK4REX8pSQhvqU2O+pOHgLvKo4m/CQ
 xaa45mT3Rgb4F0QxrrardHb8ik6gv+LQFRrNtlzTSdT6MRpLfsyjNIJqrdCiUGfaoxIf
 w0bWYZUL1siSorI0RVLHmeVbNvI0oMCv+qC2nAHWVF+EpiZYGkzisIfSrzvviMZ2uRQ1
 pf/vIDN0PE7YjS/YdbRSiyNJ+y8oOVuWLJGoVcqLU5+4HZOCJ4ROOgcuaIOCHCCtsIYQ
 WL0zbmf2Oxe/KUL5LT0mt/P2uEwtc0dwoKBmL0Z9bInnlq0u7IOFwBCbNtNQM1/2yDKp
 AqaA==
X-Gm-Message-State: APjAAAWUu3tLgoQ3A0FczZh2QtZg6YufAx5hIJZN6m1gdU+3gKMQOxyI
 DO0tTC9J002+//vnK5I463T0gDxd
X-Google-Smtp-Source: APXvYqwS9/CRyYh5LlOtdae5q503rYEbhjBK0ZZT5LIt6fvfkbdV3fN3V5fynyRz5clxtLK20WMQPQ==
X-Received: by 2002:a05:6000:1612:: with SMTP id
 u18mr1257782wrb.306.1573655957925; 
 Wed, 13 Nov 2019 06:39:17 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/16] tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"
Date: Wed, 13 Nov 2019 15:39:01 +0100
Message-Id: <1573655945-14912-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

-tb-size fits nicely in the new framework for accelerator-specific options.  It
is a very niche option, so insta-deprecate the old version.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-all.c    | 40 +++++++++++++++++++++++++++++++++++++---
 include/sysemu/accel.h |  2 --
 qemu-deprecated.texi   |  6 ++++++
 qemu-options.hx        |  6 +++++-
 vl.c                   |  8 ++++----
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7829f02..1dc384c 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -34,11 +34,13 @@
 #include "include/qapi/error.h"
 #include "include/qemu/error-report.h"
 #include "include/hw/boards.h"
+#include "qapi/qapi-builtin-visit.h"
 
 typedef struct TCGState {
     AccelState parent_obj;
 
     bool mttcg_enabled;
+    unsigned long tb_size;
 } TCGState;
 
 #define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
@@ -46,8 +48,6 @@ typedef struct TCGState {
 #define TCG_STATE(obj) \
         OBJECT_CHECK(TCGState, (obj), TYPE_TCG_ACCEL)
 
-unsigned long tcg_tb_size;
-
 /* mask must never be zero, except for A20 change call */
 static void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
@@ -126,7 +126,7 @@ static int tcg_init(MachineState *ms)
 {
     TCGState *s = TCG_STATE(current_machine->accelerator);
 
-    tcg_exec_init(tcg_tb_size * 1024 * 1024);
+    tcg_exec_init(s->tb_size * 1024 * 1024);
     cpu_interrupt_handler = tcg_handle_interrupt;
     mttcg_enabled = s->mttcg_enabled;
     return 0;
@@ -167,6 +167,33 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
     }
 }
 
+static void tcg_get_tb_size(Object *obj, Visitor *v,
+                            const char *name, void *opaque,
+                            Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+    uint32_t value = s->tb_size;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void tcg_set_tb_size(Object *obj, Visitor *v,
+                            const char *name, void *opaque,
+                            Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+    Error *error = NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+
+    s->tb_size = value;
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -178,6 +205,13 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
                                   tcg_get_thread,
                                   tcg_set_thread,
                                   NULL);
+
+    object_class_property_add(oc, "tb-size", "int",
+        tcg_get_tb_size, tcg_set_tb_size,
+        NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, "tb-size",
+        "TCG translation block cache size", &error_abort);
+
 }
 
 static const TypeInfo tcg_accel_type = {
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 22cac0f..d4c1429 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -64,8 +64,6 @@ typedef struct AccelClass {
 #define ACCEL_GET_CLASS(obj) \
     OBJECT_GET_CLASS(AccelClass, (obj), TYPE_ACCEL)
 
-extern unsigned long tcg_tb_size;
-
 AccelClass *accel_find(const char *opt_name);
 int accel_init_machine(AccelState *accel, MachineState *ms);
 
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 7239e09..6ca5f80 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -147,6 +147,12 @@ QEMU 4.1 has three options, please migrate to one of these three:
       to do is specify the kernel they want to boot with the -kernel option
  3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.
 
+@subsection -tb-size option (since 5.0)
+
+QEMU 5.0 introduced an alternative syntax to specify the size of the translation
+block cache, @option{-accel tcg,tb-size=}.  The new syntax deprecates the
+previously available @option{-tb-size} option.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection query-block result field dirty-bitmaps[i].status (since 4.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index b95bf9f..3931f90 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -120,6 +120,7 @@ ETEXI
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,thread=single|multi]\n"
     "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
+    "                tb-size=n (TCG translation block cache size)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
 STEXI
 @item -accel @var{name}[,prop=@var{value}[,...]]
@@ -129,6 +130,8 @@ kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If th
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @table @option
+@item tb-size=@var{n}
+Controls the size (in MiB) of the TCG translation block cache.
 @item thread=single|multi
 Controls number of TCG threads. When the TCG is multi-threaded there will be one
 thread per vCPU therefor taking advantage of additional host cores. The default
@@ -3995,7 +3998,8 @@ DEF("tb-size", HAS_ARG, QEMU_OPTION_tb_size, \
 STEXI
 @item -tb-size @var{n}
 @findex -tb-size
-Set TB size.
+Set TCG translation block cache size.  Deprecated, use @samp{-accel tcg,tb-size=@var{n}}
+instead.
 ETEXI
 
 DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
diff --git a/vl.c b/vl.c
index 2ea94c7..06c6ad9 100644
--- a/vl.c
+++ b/vl.c
@@ -2857,6 +2857,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
         return 0;
     }
     accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
+    object_apply_compat_props(OBJECT(accel));
     qemu_opt_foreach(opts, accelerator_set_property,
                      accel,
                      &error_fatal);
@@ -2868,6 +2869,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
                      acc, strerror(-ret));
         return 0;
     }
+
     return 1;
 }
 
@@ -3747,10 +3749,8 @@ int main(int argc, char **argv, char **envp)
                 error_report("TCG is disabled");
                 exit(1);
 #endif
-                if (qemu_strtoul(optarg, NULL, 0, &tcg_tb_size) < 0) {
-                    error_report("Invalid argument to -tb-size");
-                    exit(1);
-                }
+                warn_report("The -tb-size option is deprecated, use -accel tcg,tb-size instead");
+                object_register_sugar_prop(ACCEL_CLASS_NAME("tcg"), "tb-size", optarg);
                 break;
             case QEMU_OPTION_icount:
                 icount_opts = qemu_opts_parse_noisily(qemu_find_opts("icount"),
-- 
1.8.3.1



