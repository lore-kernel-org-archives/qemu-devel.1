Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB80C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4EBA2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEDuB581"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EBA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKmW-0002t2-Pe
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKY7-0003h2-3b
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKY4-0001ek-UJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:10 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKY4-0001bD-Mz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:08 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so16631910wru.4
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mFgHc+JDuXDRL4Rz8NUQw8m1MBq1/vn5MhUlSU0rwJU=;
 b=BEDuB581sdgUZ/R9eFjJUBAJMj9FuM59jwpaDq4JrJhPyBsjtJND3h8upPF5/GZGu9
 U1U4wh2q5UapanBkFy1BvzTDIwIX2ACnYl6S7ATxLDM++NtT9mdNlOD2A2Zt6RxXWXXp
 V43P5LcCHpeNeAPYTCcqnKC6aJxzv3pnfv8xcZIE0ep371vAf+f4hgBybblftrPfYbK9
 xKZUhNlVKnPPbEy4GcvqhAXw0beU5SAA3a8n8h+2yN56IhMYNaZc6iODqOwiSmJZPS/M
 BYKQC6RODr6t14jxyBVyYw4CVKRHu6qNhD9GGzLh+HTRcfeUZH76cCGbb72bhMiSwrWa
 ayUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=mFgHc+JDuXDRL4Rz8NUQw8m1MBq1/vn5MhUlSU0rwJU=;
 b=DnOSS9mZDg7SSfp5KfFf6FQI6L9wYcgYw0hT5iDB18FJwXMDFviTFhQjN1DG7MGRmU
 w5cGJAizJJyNcBaipZDKWf19QERLSHNiSmbX8dmFg7FydtFn5NRv0yCfmrKIiaZl7mD+
 SBIAFjtA0h4KiJS3INEalcI1fSpf04c69fSJ4Di4+iGgDR9D1MsXAfRlO5M01MHyvTBh
 KfejIKwRik2nq6qqE/CEE7CwapuAhormUj4sbQWkBVQ+tAYLyFmpJgI/0B6clk5YFY/g
 mMGAbMHTNcJ6R4o5C80Eo2Cz7EPOcOdhjAYsbZb1ktdly8Fp8zK50UvCNIxWX4t2TisU
 DK4A==
X-Gm-Message-State: APjAAAVJvYXUM7W8vCyVuAislFwqEF3Ez9ZSpRS1JP/JOpT5/1HbWxHX
 asbGZK/EFLRIfLz1aBSnI9/iVj8n
X-Google-Smtp-Source: APXvYqwKG93ATrpqtnnw8hL0X9SkTta9jInIjnq/mYqgupXruXlld92MudpS5QW0sIBnSsj9i+OFIQ==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr2679096wrh.371.1575903727022; 
 Mon, 09 Dec 2019 07:02:07 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.02.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:02:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/18] kvm: convert "-machine kernel_irqchip" to an
 accelerator property
Date: Mon,  9 Dec 2019 16:01:45 +0100
Message-Id: <1575903705-12925-19-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/core/machine.c   | 61 -----------------------------------------------------
 include/hw/boards.h |  3 ---
 qemu-options.hx     |  9 +++++---
 vl.c                |  3 ++-
 5 files changed, 62 insertions(+), 73 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c0a6351..b0adbb2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -42,6 +42,8 @@
 #include "sysemu/sev.h"
 #include "sysemu/balloon.h"
 #include "qapi/visitor.h"
+#include "qapi/qapi-types-common.h"
+#include "qapi/qapi-visit-common.h"
 
 #include "hw/boards.h"
 
@@ -94,6 +96,9 @@ struct KVMState
     int many_ioeventfds;
     int intx_set_mask;
     int kvm_shadow_mem;
+    bool kernel_irqchip_allowed;
+    bool kernel_irqchip_required;
+    bool kernel_irqchip_split;
     bool sync_mmu;
     bool manual_dirty_log_protect;
     /* The man page (and posix) say ioctl numbers are signed int, but
@@ -1780,7 +1785,7 @@ static void kvm_irqchip_create(KVMState *s)
      * in-kernel irqchip for us */
     ret = kvm_arch_irqchip_create(s);
     if (ret == 0) {
-        if (kvm_kernel_irqchip_split()) {
+        if (s->kernel_irqchip_split) {
             perror("Split IRQ chip mode not supported.");
             exit(1);
         } else {
@@ -2051,7 +2056,7 @@ static int kvm_init(MachineState *ms)
         goto err;
     }
 
-    if (machine_kernel_irqchip_allowed(ms)) {
+    if (s->kernel_irqchip_allowed) {
         kvm_irqchip_create(s);
     }
 
@@ -2969,19 +2974,57 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
     s->kvm_shadow_mem = value;
 }
 
+static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    Error *err = NULL;
+    KVMState *s = KVM_STATE(obj);
+    OnOffSplit mode;
+
+    visit_type_OnOffSplit(v, name, &mode, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    } else {
+        switch (mode) {
+        case ON_OFF_SPLIT_ON:
+            s->kernel_irqchip_allowed = true;
+            s->kernel_irqchip_required = true;
+            s->kernel_irqchip_split = false;
+            break;
+        case ON_OFF_SPLIT_OFF:
+            s->kernel_irqchip_allowed = false;
+            s->kernel_irqchip_required = false;
+            s->kernel_irqchip_split = false;
+            break;
+        case ON_OFF_SPLIT_SPLIT:
+            s->kernel_irqchip_allowed = true;
+            s->kernel_irqchip_required = true;
+            s->kernel_irqchip_split = true;
+            break;
+        default:
+            /* The value was checked in visit_type_OnOffSplit() above. If
+             * we get here, then something is wrong in QEMU.
+             */
+            abort();
+        }
+    }
+}
+
 bool kvm_kernel_irqchip_allowed(void)
 {
-    return machine_kernel_irqchip_allowed(current_machine);
+    return kvm_state->kernel_irqchip_allowed;
 }
 
 bool kvm_kernel_irqchip_required(void)
 {
-    return machine_kernel_irqchip_required(current_machine);
+    return kvm_state->kernel_irqchip_required;
 }
 
 bool kvm_kernel_irqchip_split(void)
 {
-    return machine_kernel_irqchip_split(current_machine);
+    return kvm_state->kernel_irqchip_split;
 }
 
 static void kvm_accel_instance_init(Object *obj)
@@ -2999,6 +3042,12 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
 
+    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
+        NULL, kvm_set_kernel_irqchip,
+        NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, "kernel-irqchip",
+        "Configure KVM in-kernel irqchip", &error_abort);
+
     object_class_property_add(oc, "kvm-shadow-mem", "int",
         kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
         NULL, NULL, &error_abort);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bfb5f6f..c1cad2c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -173,44 +173,6 @@ GlobalProperty hw_compat_2_1[] = {
 };
 const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
 
-static void machine_set_kernel_irqchip(Object *obj, Visitor *v,
-                                       const char *name, void *opaque,
-                                       Error **errp)
-{
-    Error *err = NULL;
-    MachineState *ms = MACHINE(obj);
-    OnOffSplit mode;
-
-    visit_type_OnOffSplit(v, name, &mode, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    } else {
-        switch (mode) {
-        case ON_OFF_SPLIT_ON:
-            ms->kernel_irqchip_allowed = true;
-            ms->kernel_irqchip_required = true;
-            ms->kernel_irqchip_split = false;
-            break;
-        case ON_OFF_SPLIT_OFF:
-            ms->kernel_irqchip_allowed = false;
-            ms->kernel_irqchip_required = false;
-            ms->kernel_irqchip_split = false;
-            break;
-        case ON_OFF_SPLIT_SPLIT:
-            ms->kernel_irqchip_allowed = true;
-            ms->kernel_irqchip_required = true;
-            ms->kernel_irqchip_split = true;
-            break;
-        default:
-            /* The value was checked in visit_type_OnOffSplit() above. If
-             * we get here, then something is wrong in QEMU.
-             */
-            abort();
-        }
-    }
-}
-
 static char *machine_get_kernel(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -752,12 +714,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_align_shift = 23;
     mc->numa_auto_assign_ram = numa_default_auto_assign_ram;
 
-    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-        NULL, machine_set_kernel_irqchip,
-        NULL, NULL, &error_abort);
-    object_class_property_set_description(oc, "kernel-irqchip",
-        "Configure KVM in-kernel irqchip", &error_abort);
-
     object_class_property_add_str(oc, "kernel",
         machine_get_kernel, machine_set_kernel, &error_abort);
     object_class_property_set_description(oc, "kernel",
@@ -857,8 +813,6 @@ static void machine_initfn(Object *obj)
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
 
-    ms->kernel_irqchip_allowed = true;
-    ms->kernel_irqchip_split = mc->default_kernel_irqchip_split;
     ms->dump_guest_core = true;
     ms->mem_merge = true;
     ms->enable_graphics = true;
@@ -914,21 +868,6 @@ bool machine_usb(MachineState *machine)
     return machine->usb;
 }
 
-bool machine_kernel_irqchip_allowed(MachineState *machine)
-{
-    return machine->kernel_irqchip_allowed;
-}
-
-bool machine_kernel_irqchip_required(MachineState *machine)
-{
-    return machine->kernel_irqchip_required;
-}
-
-bool machine_kernel_irqchip_split(MachineState *machine)
-{
-    return machine->kernel_irqchip_split;
-}
-
 int machine_phandle_start(MachineState *machine)
 {
     return machine->phandle_start;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 46119eb..b42fedd 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -63,9 +63,6 @@ extern MachineState *current_machine;
 
 void machine_run_board_init(MachineState *machine);
 bool machine_usb(MachineState *machine);
-bool machine_kernel_irqchip_allowed(MachineState *machine);
-bool machine_kernel_irqchip_required(MachineState *machine);
-bool machine_kernel_irqchip_split(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
diff --git a/qemu-options.hx b/qemu-options.hx
index 779c8af..945fc4a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -32,7 +32,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
     "                supported accelerators are kvm, xen, hax, hvf, whpx or tcg (default: tcg)\n"
-    "                kernel_irqchip=on|off|split controls accelerated irqchip support (default=off)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
@@ -67,8 +66,6 @@ This is used to enable an accelerator. Depending on the target architecture,
 kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If there is
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
-@item kernel_irqchip=on|off
-Controls in-kernel irqchip support for the chosen accelerator when available.
 @item vmport=on|off|auto
 Enables emulation of VMWare IO port, for vmmouse etc. auto says to select the
 value based on accel. For accel=xen the default is off otherwise the default
@@ -115,6 +112,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,prop[=value][,...]]\n"
     "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
     "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
+    "                kernel-irqchip=on|off|split controls accelerated irqchip support (default=on)\n"
     "                kvm-shadow-mem=size of KVM shadow MMU in bytes\n"
     "                tb-size=n (TCG translation block cache size)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
@@ -129,6 +127,11 @@ fails to initialize.
 @item igd-passthru=on|off
 When Xen is in use, this option controls whether Intel integrated graphics
 devices can be passed through to the guest (default=off)
+@item kernel-irqchip=on|off|split
+Controls KVM in-kernel irqchip support.  The default is full acceleration of the
+interrupt controllers.  On x86, split irqchip reduces the kernel attack
+surface, at a performance cost for non-MSI interrupts.  Disabling the in-kernel
+irqchip completely is not recommended except for debugging purposes.
 @item kvm-shadow-mem=size
 Defines the size of the KVM shadow MMU.
 @item tb-size=@var{n}
diff --git a/vl.c b/vl.c
index 3678522..53e4ff6 100644
--- a/vl.c
+++ b/vl.c
@@ -2639,7 +2639,8 @@ static int machine_set_property(void *opaque,
         object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, value);
         return 0;
     }
-    if (g_str_equal(qom_name, "kvm-shadow-mem")) {
+    if (g_str_equal(qom_name, "kvm-shadow-mem") ||
+        g_str_equal(qom_name, "kernel-irqchip")) {
         object_register_sugar_prop(ACCEL_CLASS_NAME("kvm"), qom_name, value);
         return 0;
     }
-- 
1.8.3.1


