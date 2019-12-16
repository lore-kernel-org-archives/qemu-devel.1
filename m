Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B3AC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5665206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBoLN2Uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5665206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtVr-0001P0-Bz
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFH-0005Fk-3l
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFF-0007i7-Ec
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:19 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFF-0007g9-6o
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:17 -0500
Received: by mail-wr1-x432.google.com with SMTP id g17so8053667wro.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=I/fcWdzj1xHfk1SVVMZ05ZGlnMoxP5II4qfCSvXSpyc=;
 b=uBoLN2UwP2kh58Thr8gn7Tp7dYNtJIEmNsET7se6lBSUc5z+HGEqkpSksTwvdV25HW
 qTS+JwLsOKPEzBevBmfEtNR9T/6VzvrptpFi6POdyCw1c0srvwcl+XhzOhm1p95cRdyo
 4Ks3oZr6sMQfrnIQBuUgmNbIqul0cmtJGi7dGZQFkCTV6tOPpPymcGgMKohE0I220qCn
 WKPib7jjISXKHEzNd0ElUNYMxCqtEN1oVz9q1D5gCY4oXpDaZRlmjsCNV7MN7/Zivxy8
 ULnR5dOR/diTOcBS3CQG3PygQRVUTMikOShtKDHPyjhhYI81PIVGNuL0frWP+et5TgBE
 FPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=I/fcWdzj1xHfk1SVVMZ05ZGlnMoxP5II4qfCSvXSpyc=;
 b=Zh+0lNDxipP+LAKriVDuxuWOxUR5iazgcweE/UllSObIKl/fGhsfmtRtIGfUXFP6wP
 QBKg/lVxrbc5x4T44RmsMN70RmZ0rIXfcdh/+zTx8J/pirgPwnyiHK7oST9+oZKRxAVz
 nbYrEQJX80wbo17TUZ5CNMaB7igGWEj9bEqcSJsO32RIL4xTrjiFYcjriU2kWCmP2HoD
 6a44BLbcLKWn+LT51zEoyvAjhL//O5ukjvGXFpI6cA0hTjtVMjG2/3YliLZ7ahxoLsia
 7VZsfX3GbmzQug33BHsvOuQQfwGW8BTOvqbKWSZnwEmxdH6g5ljS6ysrsUoDzRexWXCc
 gAvw==
X-Gm-Message-State: APjAAAWhivctyNUmgFldDW2DfGoV7funoEw2iUkFHlFgHlDEH7EBL8IN
 d7jm6ubMTwjvaCmkLghsjAg13THz
X-Google-Smtp-Source: APXvYqyRNytPsD99f/8uj3pF2dekxA7HOl7wLIhuGd4Bm8R1dHTQsRGukfd6aHYgOPByghMTXzxkkw==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr31616508wrs.184.1576513755966; 
 Mon, 16 Dec 2019 08:29:15 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/62] kvm: introduce kvm_kernel_irqchip_* functions
Date: Mon, 16 Dec 2019 17:28:12 +0100
Message-Id: <1576513726-53700-29-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

The KVMState struct is opaque, so provide accessors for the fields
that will be moved from current_machine to the accelerator.  For now
they just forward to the machine object, but this will change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c  | 23 +++++++++++++++++++----
 hw/ppc/e500.c        |  5 ++---
 hw/ppc/spapr_irq.c   | 16 ++++------------
 include/sysemu/kvm.h |  7 +++++--
 target/arm/kvm.c     |  8 ++++----
 target/i386/kvm.c    |  4 ++--
 target/mips/kvm.c    |  2 +-
 target/ppc/kvm.c     |  2 +-
 target/s390x/kvm.c   |  2 +-
 9 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4770dd8..34e8f26 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1774,7 +1774,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
-static void kvm_irqchip_create(MachineState *machine, KVMState *s)
+static void kvm_irqchip_create(KVMState *s)
 {
     int ret;
 
@@ -1792,9 +1792,9 @@ static void kvm_irqchip_create(MachineState *machine, KVMState *s)
 
     /* First probe and see if there's a arch-specific hook to create the
      * in-kernel irqchip for us */
-    ret = kvm_arch_irqchip_create(machine, s);
+    ret = kvm_arch_irqchip_create(s);
     if (ret == 0) {
-        if (machine_kernel_irqchip_split(machine)) {
+        if (kvm_kernel_irqchip_split()) {
             perror("Split IRQ chip mode not supported.");
             exit(1);
         } else {
@@ -2066,7 +2066,7 @@ static int kvm_init(MachineState *ms)
     }
 
     if (machine_kernel_irqchip_allowed(ms)) {
-        kvm_irqchip_create(ms, s);
+        kvm_irqchip_create(s);
     }
 
     if (kvm_eventfds_allowed) {
@@ -2983,6 +2983,21 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
     s->kvm_shadow_mem = value;
 }
 
+bool kvm_kernel_irqchip_allowed(void)
+{
+    return machine_kernel_irqchip_allowed(current_machine);
+}
+
+bool kvm_kernel_irqchip_required(void)
+{
+    return machine_kernel_irqchip_required(current_machine);
+}
+
+bool kvm_kernel_irqchip_split(void)
+{
+    return machine_kernel_irqchip_split(current_machine);
+}
+
 static void kvm_accel_instance_init(Object *obj)
 {
     KVMState *s = KVM_STATE(obj);
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 91cd4c2..12b6a5b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -793,7 +793,6 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
                                       MemoryRegion *ccsr,
                                       IrqLines *irqs)
 {
-    MachineState *machine = MACHINE(pms);
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
     DeviceState *dev = NULL;
     SysBusDevice *s;
@@ -801,10 +800,10 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
     if (kvm_enabled()) {
         Error *err = NULL;
 
-        if (machine_kernel_irqchip_allowed(machine)) {
+        if (kvm_kernel_irqchip_allowed()) {
             dev = ppce500_init_mpic_kvm(pmc, irqs, &err);
         }
-        if (machine_kernel_irqchip_required(machine) && !dev) {
+        if (kvm_kernel_irqchip_required() && !dev) {
             error_reportf_err(err,
                               "kernel_irqchip requested but unavailable: ");
             exit(1);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d6bb7fd..15c3dd4 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -74,12 +74,11 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
                        SpaprInterruptController *intc,
                        Error **errp)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
     Error *local_err = NULL;
 
-    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+    if (kvm_enabled() && kvm_kernel_irqchip_allowed()) {
         if (fn(intc, &local_err) < 0) {
-            if (machine_kernel_irqchip_required(machine)) {
+            if (kvm_kernel_irqchip_required()) {
                 error_prepend(&local_err,
                               "kernel_irqchip requested but unavailable: ");
                 error_propagate(errp, local_err);
@@ -184,7 +183,7 @@ static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
      */
     if (kvm_enabled() &&
         spapr->irq == &spapr_irq_dual &&
-        machine_kernel_irqchip_required(machine) &&
+        kvm_kernel_irqchip_required() &&
         xics_kvm_has_broken_disconnect(spapr)) {
         error_setg(errp, "KVM is too old to support ic-mode=dual,kernel-irqchip=on");
         return -1;
@@ -287,20 +286,13 @@ uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
 
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
-    MachineState *machine = MACHINE(spapr);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
 
-    if (machine_kernel_irqchip_split(machine)) {
+    if (kvm_enabled() && kvm_kernel_irqchip_split()) {
         error_setg(errp, "kernel_irqchip split mode not supported on pseries");
         return;
     }
 
-    if (!kvm_enabled() && machine_kernel_irqchip_required(machine)) {
-        error_setg(errp,
-                   "kernel_irqchip requested but only available with KVM");
-        return;
-    }
-
     if (spapr_irq_check(spapr, errp) < 0) {
         return;
     }
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 9fe233b..aaf2a50 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -519,10 +519,13 @@ void kvm_pc_gsi_handler(void *opaque, int n, int level);
 void kvm_pc_setup_irq_routing(bool pci_enabled);
 void kvm_init_irq_routing(KVMState *s);
 
+bool kvm_kernel_irqchip_allowed(void);
+bool kvm_kernel_irqchip_required(void);
+bool kvm_kernel_irqchip_split(void);
+
 /**
  * kvm_arch_irqchip_create:
  * @KVMState: The KVMState pointer
- * @MachineState: The MachineState pointer
  *
  * Allow architectures to create an in-kernel irq chip themselves.
  *
@@ -530,7 +533,7 @@ void kvm_init_irq_routing(KVMState *s);
  *            0: irq chip was not created
  *          > 0: irq chip was created
  */
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s);
+int kvm_arch_irqchip_create(KVMState *s);
 
 /**
  * kvm_set_one_reg - set a register value in KVM via KVM_SET_ONE_REG ioctl
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5b82cef..b87b59a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -741,11 +741,11 @@ void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
 
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+int kvm_arch_irqchip_create(KVMState *s)
 {
-     if (machine_kernel_irqchip_split(ms)) {
-         perror("-machine kernel_irqchip=split is not supported on ARM.");
-         exit(1);
+    if (kvm_kernel_irqchip_split()) {
+        perror("-machine kernel_irqchip=split is not supported on ARM.");
+        exit(1);
     }
 
     /* If we can create the VGIC using the newer device control API, we
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 62ce681..ef63f3a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4494,10 +4494,10 @@ void kvm_arch_init_irq_routing(KVMState *s)
     }
 }
 
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+int kvm_arch_irqchip_create(KVMState *s)
 {
     int ret;
-    if (machine_kernel_irqchip_split(ms)) {
+    if (kvm_kernel_irqchip_split()) {
         ret = kvm_vm_enable_cap(s, KVM_CAP_SPLIT_IRQCHIP, 0, 24);
         if (ret) {
             error_report("Could not enable split irqchip mode: %s",
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 578bc14..de3e26e 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -57,7 +57,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+int kvm_arch_irqchip_create(KVMState *s)
 {
     return 0;
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index c77f984..461dc6d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -152,7 +152,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+int kvm_arch_irqchip_create(KVMState *s)
 {
     return 0;
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 0c9d14b..f3a742b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -374,7 +374,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+int kvm_arch_irqchip_create(KVMState *s)
 {
     return 0;
 }
-- 
1.8.3.1



