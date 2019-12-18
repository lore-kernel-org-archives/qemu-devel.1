Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C024C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473EA2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFjP8YNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473EA2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYMr-0000cP-QA
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY38-0006J9-HQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY36-0000Ux-3v
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:30 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY35-0000Sh-Lf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:27 -0500
Received: by mail-wr1-x42c.google.com with SMTP id c9so1999185wrw.8
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=fy+B/TRcCsC3WIuPseL3Gdys+E0bj/B1JxAW2ZkWrwk=;
 b=cFjP8YNsCdrUqiRwtXHzwGI9hQ6m85yMviwW5hhjOTlIEr0oyuY85KEF8I41MBTlcn
 LFKorWB5Q5gcpGOBMCsyIIYsrZCoxoZt/KWyrcHD2U2+qYfpbYeZtucVlkcew9BqXI9J
 0M46bsPoupyF4I9i6ueWjtrRULGQsHuk+3Ya2BxmN0NfGYjqueeFEfurvhh6IbuWnN5F
 3/YDuklE2V4yqQqaPbRrYZHlceHnSQ33d5Gekf6XG//6jsfKrKXiPWdC4/sXB1k7puc8
 0Ps3OkUfInjHQBDpyl7XGZMNjFU3nCtHYhQ1BHw4HHNkwONhWgIwWk2vF4sQskzlCYLh
 MSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=fy+B/TRcCsC3WIuPseL3Gdys+E0bj/B1JxAW2ZkWrwk=;
 b=gFY+cRkvDsMBV9SmBf33cKIllnGTXcbMkipRbrKfJqPm7APx7aZw3ZCrjmjJPKIbSR
 R3FqDl5QJbmzvxZgWRk7OB5HhgkgQnto07dV3fvP+kl6fxjY0KPnIswxXNnASr2R7wvR
 hxUAScI09/9ZQPVt4Z4bZU9gPL5N2tEA9piYsg1xJndNA+nINukpRZCbCeocWOLKaL48
 etjm47WJ/TqGa0l1xwNsqqMjEMhL3XmDXt2rjYtoi5X5H2KyH2Vrzu12xMUF4bhwGnZw
 gee9jyHPM1Xl7M64o9BqEgJ3pfw9Bj+w43UShfSYkpat07o7gH84WZ11Q5+s6wMiAZYa
 CT/g==
X-Gm-Message-State: APjAAAXa3QGjEbHvTYpm5gSjhoA3Avw/dbeABP3xR3y2dFLkrvHAsb7i
 uhQksvIJS/Vh1DBUY8yupgVlPDNZ
X-Google-Smtp-Source: APXvYqxoObiN3zvHG7DH0ELngLpcm28bcGvl3F873+9alGcXlQgNGgifRE+NkcBgB5gx86ly7/Marg==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr2488643wrv.302.1576670602629; 
 Wed, 18 Dec 2019 04:03:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/87] kvm: convert "-machine kvm_shadow_mem" to an accelerator
 property
Date: Wed, 18 Dec 2019 13:01:53 +0100
Message-Id: <1576670573-48048-28-git-send-email-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 hw/core/machine.c   | 39 ---------------------------------------
 include/hw/boards.h |  2 --
 qemu-options.hx     |  6 +++---
 target/i386/kvm.c   |  2 +-
 vl.c                |  4 ++++
 6 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7b9f92d..4770dd8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -41,6 +41,7 @@
 #include "hw/irq.h"
 #include "sysemu/sev.h"
 #include "sysemu/balloon.h"
+#include "qapi/visitor.h"
 
 #include "hw/boards.h"
 
@@ -92,6 +93,7 @@ struct KVMState
     int max_nested_state_len;
     int many_ioeventfds;
     int intx_set_mask;
+    int kvm_shadow_mem;
     bool sync_mmu;
     bool manual_dirty_log_protect;
     /* The man page (and posix) say ioctl numbers are signed int, but
@@ -2954,6 +2956,40 @@ static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
     return false;
 }
 
+static void kvm_get_kvm_shadow_mem(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    int64_t value = s->kvm_shadow_mem;
+
+    visit_type_int(v, name, &value, errp);
+}
+
+static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    Error *error = NULL;
+    int64_t value;
+
+    visit_type_int(v, name, &value, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+
+    s->kvm_shadow_mem = value;
+}
+
+static void kvm_accel_instance_init(Object *obj)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    s->kvm_shadow_mem = -1;
+}
+
 static void kvm_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -2961,11 +2997,18 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
     ac->init_machine = kvm_init;
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
+
+    object_class_property_add(oc, "kvm-shadow-mem", "int",
+        kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
+        NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, "kvm-shadow-mem",
+        "KVM shadow MMU size", &error_abort);
 }
 
 static const TypeInfo kvm_accel_type = {
     .name = TYPE_KVM_ACCEL,
     .parent = TYPE_ACCEL,
+    .instance_init = kvm_accel_instance_init,
     .class_init = kvm_accel_class_init,
     .instance_size = sizeof(KVMState),
 };
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 05cea3a..9c93353 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -216,33 +216,6 @@ static void machine_set_kernel_irqchip(Object *obj, Visitor *v,
     }
 }
 
-static void machine_get_kvm_shadow_mem(Object *obj, Visitor *v,
-                                       const char *name, void *opaque,
-                                       Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-    int64_t value = ms->kvm_shadow_mem;
-
-    visit_type_int(v, name, &value, errp);
-}
-
-static void machine_set_kvm_shadow_mem(Object *obj, Visitor *v,
-                                       const char *name, void *opaque,
-                                       Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-    Error *error = NULL;
-    int64_t value;
-
-    visit_type_int(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-
-    ms->kvm_shadow_mem = value;
-}
-
 static char *machine_get_kernel(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -790,12 +763,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure KVM in-kernel irqchip", &error_abort);
 
-    object_class_property_add(oc, "kvm-shadow-mem", "int",
-        machine_get_kvm_shadow_mem, machine_set_kvm_shadow_mem,
-        NULL, NULL, &error_abort);
-    object_class_property_set_description(oc, "kvm-shadow-mem",
-        "KVM shadow MMU size", &error_abort);
-
     object_class_property_add_str(oc, "kernel",
         machine_get_kernel, machine_set_kernel, &error_abort);
     object_class_property_set_description(oc, "kernel",
@@ -897,7 +864,6 @@ static void machine_initfn(Object *obj)
 
     ms->kernel_irqchip_allowed = true;
     ms->kernel_irqchip_split = mc->default_kernel_irqchip_split;
-    ms->kvm_shadow_mem = -1;
     ms->dump_guest_core = true;
     ms->mem_merge = true;
     ms->enable_graphics = true;
@@ -968,11 +934,6 @@ bool machine_kernel_irqchip_split(MachineState *machine)
     return machine->kernel_irqchip_split;
 }
 
-int machine_kvm_shadow_mem(MachineState *machine)
-{
-    return machine->kvm_shadow_mem;
-}
-
 int machine_phandle_start(MachineState *machine)
 {
     return machine->phandle_start;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5025c1a..6084e61 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -66,7 +66,6 @@ bool machine_usb(MachineState *machine);
 bool machine_kernel_irqchip_allowed(MachineState *machine);
 bool machine_kernel_irqchip_required(MachineState *machine);
 bool machine_kernel_irqchip_split(MachineState *machine);
-int machine_kvm_shadow_mem(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
@@ -278,7 +277,6 @@ struct MachineState {
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
     bool kernel_irqchip_split;
-    int kvm_shadow_mem;
     char *dtb;
     char *dumpdtb;
     int phandle_start;
diff --git a/qemu-options.hx b/qemu-options.hx
index 1535390..004370c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -34,7 +34,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                supported accelerators are kvm, xen, hax, hvf, whpx or tcg (default: tcg)\n"
     "                kernel_irqchip=on|off|split controls accelerated irqchip support (default=off)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
-    "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
     "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
@@ -74,8 +73,6 @@ Controls in-kernel irqchip support for the chosen accelerator when available.
 Enables emulation of VMWare IO port, for vmmouse etc. auto says to select the
 value based on accel. For accel=xen the default is off otherwise the default
 is on.
-@item kvm_shadow_mem=size
-Defines the size of the KVM shadow MMU.
 @item dump-guest-core=on|off
 Include guest memory in a core dump. The default is on.
 @item mem-merge=on|off
@@ -118,6 +115,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,prop[=value][,...]]\n"
     "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
     "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
+    "                kvm-shadow-mem=size of KVM shadow MMU in bytes\n"
     "                tb-size=n (TCG translation block cache size)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
 STEXI
@@ -131,6 +129,8 @@ fails to initialize.
 @item igd-passthru=on|off
 When Xen is in use, this option controls whether Intel integrated graphics
 devices can be passed through to the guest (default=off)
+@item kvm-shadow-mem=size
+Defines the size of the KVM shadow MMU.
 @item tb-size=@var{n}
 Controls the size (in MiB) of the TCG translation block cache.
 @item thread=single|multi
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 1d10046..62ce681 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2163,7 +2163,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
     qemu_register_reset(kvm_unpoison_all, NULL);
 
-    shadow_mem = machine_kvm_shadow_mem(ms);
+    shadow_mem = object_property_get_int(OBJECT(s), "kvm-shadow-mem", &error_abort);
     if (shadow_mem != -1) {
         shadow_mem /= 4096;
         ret = kvm_vm_ioctl(s, KVM_SET_NR_MMU_PAGES, shadow_mem);
diff --git a/vl.c b/vl.c
index 774305c..8c6fcda 100644
--- a/vl.c
+++ b/vl.c
@@ -2514,6 +2514,10 @@ static int machine_set_property(void *opaque,
         object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, value);
         return 0;
     }
+    if (g_str_equal(qom_name, "kvm-shadow-mem")) {
+        object_register_sugar_prop(ACCEL_CLASS_NAME("kvm"), qom_name, value);
+        return 0;
+    }
 
     return object_parse_property_opt(opaque, name, value, "type", errp);
 }
-- 
1.8.3.1



