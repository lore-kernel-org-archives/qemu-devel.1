Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBC1C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A3A21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG+0VwIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A3A21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYKd-0005Xg-Hw
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY37-0006Hd-Bh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY35-0000TB-3r
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:29 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:36635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2z-0000QB-UR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:22 -0500
Received: by mail-wr1-x42c.google.com with SMTP id z3so2023018wru.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=4RMbJ1vgiB2ahPcjjY43T5z1jQHk/pVa3Mh71/KfOko=;
 b=lG+0VwIScgbnXTvwj3g0j5NFtiBRuFf0EXntw6vJu9oh1f+iASjDj53KUQOBIbI3lg
 OUGJSvktegxjnq3CfRrd9fhc65l9zJE/aWu6BhK0Ei+Zv4KvGp3rZSMXgVH6FOCxsjRs
 R5NLWLu0PYCsNQSF1VOUgBpNtmr/4WZq5PRZI+DCV1TqSJLG8DE4SsM9gP49XEA5+p5G
 PEampx1j65U+zb+RvTxVv5/SzWRtOttg9FG1iagoQkDZ1/tbWnhyB8r4/hZE6OGK4hzx
 p6pVTfbXD63VKuVCkIODqAAxq9WZaUZJCELUzDvulkijOphfwsYG1A8dPyTUlsHrG05Y
 lajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=4RMbJ1vgiB2ahPcjjY43T5z1jQHk/pVa3Mh71/KfOko=;
 b=njzcQ/ClX4AWK4chbZnWR7n2jdxIB2QlVcHGdJV20Oe6wVGx9RrXHaZ4dh9BSv5czu
 q0PE7q5fyNqbUgwTGYU9vGDtMKyERDprKMUj2G5XuHhXjD2yC2FttRFXy0PU/OYCZqKm
 b1SNzliCCn2ZsVfaUG2U/wBTJXwXfv0Gv9KiGiOxUPEcY+2zoUQmQRGrBrWT7iPWJ3sE
 jdLMLAGaa67vypJhNJfYOuI3elgEsQ0zaEn0EMITFxhvQaG731Z84mM7p0bsOP8apQ1W
 E5lmxgHaMk+X/tPsoorJI7uyRRgbtImFq35GsSJCwlbAJeKzrEVvdLNjhJoTtBSqcx7s
 HLNw==
X-Gm-Message-State: APjAAAWKqFuu6JtY8QAKAmtbFMVhbOxlf9D9NdmCTyvYg8dX6AwtrN9e
 URyZnD/AmO15Vup61Q7Zhdt9qgnj
X-Google-Smtp-Source: APXvYqx13J5jyZLllEhTNuvQMjlZTRJUNwyReVcUJ4aW3NINinwW60S5IEOUUpauU9vvK2T5rcNJLg==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr2378181wrv.250.1576670600392; 
 Wed, 18 Dec 2019 04:03:20 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/87] tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"
Date: Wed, 18 Dec 2019 13:01:51 +0100
Message-Id: <1576670573-48048-26-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

-tb-size fits nicely in the new framework for accelerator-specific options.  It
is a very niche option, so insta-deprecate it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-all.c    | 40 +++++++++++++++++++++++++++++++++++++---
 include/sysemu/accel.h |  2 --
 qemu-deprecated.texi   |  6 ++++++
 qemu-options.hx        |  8 ++++++--
 vl.c                   |  8 ++++----
 5 files changed, 53 insertions(+), 11 deletions(-)

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
index 62680f7..e88f6d1 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -142,6 +142,12 @@ QEMU 4.1 has three options, please migrate to one of these three:
       to do is specify the kernel they want to boot with the -kernel option
  3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.
 
+@subsection -tb-size option (since 5.0)
+
+QEMU 5.0 introduced an alternative syntax to specify the size of the translation
+block cache, @option{-accel tcg,tb-size=}.  The new syntax deprecates the
+previously available @option{-tb-size} option.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection change (since 2.5.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index c63e794..ee1f676 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -118,8 +118,9 @@ Select CPU model (@code{-cpu help} for list and additional feature selection)
 ETEXI
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
-    "-accel [accel=]accelerator[,thread=single|multi]\n"
+    "-accel [accel=]accelerator[,prop[=value][,...]]\n"
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
@@ -3923,7 +3926,8 @@ DEF("tb-size", HAS_ARG, QEMU_OPTION_tb_size, \
 STEXI
 @item -tb-size @var{n}
 @findex -tb-size
-Set TB size.
+Set TCG translation block cache size.  Deprecated, use @samp{-accel tcg,tb-size=@var{n}}
+instead.
 ETEXI
 
 DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
diff --git a/vl.c b/vl.c
index 7f2f3fb..900f97a 100644
--- a/vl.c
+++ b/vl.c
@@ -2727,6 +2727,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
         return 0;
     }
     accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
+    object_apply_compat_props(OBJECT(accel));
     qemu_opt_foreach(opts, accelerator_set_property,
                      accel,
                      &error_fatal);
@@ -2738,6 +2739,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
                      acc, strerror(-ret));
         return 0;
     }
+
     return 1;
 }
 
@@ -3590,10 +3592,8 @@ int main(int argc, char **argv, char **envp)
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



