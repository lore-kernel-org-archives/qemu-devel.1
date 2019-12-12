Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506D9C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F15E214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVmTsolc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F15E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifStl-0008P6-TP
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHF-0005Me-St
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHE-00045k-61
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:25 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifSHD-000446-V1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:24 -0500
Received: by mail-wr1-x442.google.com with SMTP id c14so3620879wrn.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KD+mFGQOMXFzU8I/K2R4asx9z8KYJwXRgxxZ/YYLUss=;
 b=sVmTsolczJ9zN/z70nd9VzLDO179vQ64PMWjHIg4VBNSVm2StcQOYl8p+kV2flDGO4
 Bw71L+7biI0cOO/UEJiHPqfBQqcbj8qmYNFJFF7FcsRmGmkO+8tZwNVVdxLIiZz7v5+k
 xu+uoTdeX5BuBpGOZWZ1PvzqhGZIqnQD4cix9V+5bYRPNJqcegutYvlDNUdbyC/Li71G
 gGJ9WK/SgSW0Coczyea35W8q408cGrxacpxNSffiyAw3RhAS2Aa3JBO1O6gboKyxblSB
 o+I1ZZi0siwhFDpn/8f7RvGxKP3j2RY2gpYBXPXVKkJf/tvk5HWkhALyVKgl8XRFullV
 I+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=KD+mFGQOMXFzU8I/K2R4asx9z8KYJwXRgxxZ/YYLUss=;
 b=CytWH0BzN+Hgh9Os0NAWQaumRPLWujo+AfU21qWFYdHMtF5r5jT02XLq0hj37p8n7n
 LWIk9EhZLwuE2q9ZDu+L6jMavwleEsl83PkS2Mh8EHH9kxabzZ6vmA4NO3sviX4E4oJv
 xHOw7NXfM7Gc53xS33HZQWGtsdaBbpMzYNPGKzF7Reg0dbKB2M923d0QYLaIxsWjD/ii
 UZvqIg56/g5EeTDpViwOC/Er6npD2l1FiowDTznm6FuLzkPfeMgWhBigOi+TlYLFvE49
 UWej/L/gcCgmih9Gk3R4BPvrc+w+88zkaOPUdn91SrxJSnwvu8a1HOngRwPmUXxEV2w5
 Seog==
X-Gm-Message-State: APjAAAWCbe96Kw2bgLnwSEPrqXF0KzKqEeE5A3xXwjB3rN3hGDhcVL6G
 41kM8I011cue+gWr4XoKDwjCLk+h
X-Google-Smtp-Source: APXvYqzwQuZmUlYutbciprbepII72jEx3wIqH/YVUnSVvrvI8IIArsAcO92ed8LO95t9pg14f4WqIw==
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr7531290wrx.147.1576171762477; 
 Thu, 12 Dec 2019 09:29:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 2sm6810130wrq.31.2019.12.12.09.29.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 09:29:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] x86: move SMM property to X86MachineState
Date: Thu, 12 Dec 2019 18:29:11 +0100
Message-Id: <1576171754-45138-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: philmd@redhat.com, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add it to microvm as well, it is a generic property of the x86
architecture.

Suggested-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c          | 49 -------------------------------------------------
 hw/i386/pc_piix.c     |  6 +++---
 hw/i386/pc_q35.c      |  2 +-
 hw/i386/x86.c         | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/i386/pc.h  |  3 ---
 include/hw/i386/x86.h |  5 +++++
 target/i386/kvm.c     |  3 +--
 7 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fdbd2bf..6a3212e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2028,48 +2028,6 @@ static void pc_machine_set_vmport(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &pcms->vmport, errp);
 }
 
-bool pc_machine_is_smm_enabled(PCMachineState *pcms)
-{
-    bool smm_available = false;
-
-    if (pcms->smm == ON_OFF_AUTO_OFF) {
-        return false;
-    }
-
-    if (tcg_enabled() || qtest_enabled()) {
-        smm_available = true;
-    } else if (kvm_enabled()) {
-        smm_available = kvm_has_smm();
-    }
-
-    if (smm_available) {
-        return true;
-    }
-
-    if (pcms->smm == ON_OFF_AUTO_ON) {
-        error_report("System Management Mode not supported by this hypervisor.");
-        exit(1);
-    }
-    return false;
-}
-
-static void pc_machine_get_smm(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-    OnOffAuto smm = pcms->smm;
-
-    visit_type_OnOffAuto(v, name, &smm, errp);
-}
-
-static void pc_machine_set_smm(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &pcms->smm, errp);
-}
-
 static bool pc_machine_get_smbus(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -2116,7 +2074,6 @@ static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    pcms->smm = ON_OFF_AUTO_AUTO;
 #ifdef CONFIG_VMPORT
     pcms->vmport = ON_OFF_AUTO_AUTO;
 #else
@@ -2223,12 +2180,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
         pc_machine_get_device_memory_region_size, NULL,
         NULL, NULL, &error_abort);
 
-    object_class_property_add(oc, PC_MACHINE_SMM, "OnOffAuto",
-        pc_machine_get_smm, pc_machine_set_smm,
-        NULL, NULL, &error_abort);
-    object_class_property_set_description(oc, PC_MACHINE_SMM,
-        "Enable SMM (pc & q35)", &error_abort);
-
     object_class_property_add(oc, PC_MACHINE_VMPORT, "OnOffAuto",
         pc_machine_get_vmport, pc_machine_set_vmport,
         NULL, NULL, &error_abort);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1bd70d1..dd0f00e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -281,7 +281,7 @@ else {
         /* TODO: Populate SPD eeprom data.  */
         pcms->smbus = piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
                                     x86ms->gsi[9], smi_irq,
-                                    pc_machine_is_smm_enabled(pcms),
+                                    x86_machine_is_smm_enabled(x86ms),
                                     &piix4_pm);
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
 
@@ -309,9 +309,9 @@ else {
 
 static void pc_compat_2_3_fn(MachineState *machine)
 {
-    PCMachineState *pcms = PC_MACHINE(machine);
+    X86MachineState *x86ms = X86_MACHINE(machine);
     if (kvm_enabled()) {
-        pcms->smm = ON_OFF_AUTO_OFF;
+        x86ms->smm = ON_OFF_AUTO_OFF;
     }
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 385e5cf..bccaaee 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -276,7 +276,7 @@ static void pc_q35_init(MachineState *machine)
                          0xff0104);
 
     /* connect pm stuff to lpc */
-    ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms));
+    ich9_lpc_pm_init(lpc, x86_machine_is_smm_enabled(x86ms));
 
     if (pcms->sata_enabled) {
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3e4aee5..6fb01e4 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -746,10 +746,53 @@ static void x86_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
     x86ms->max_ram_below_4g = value;
 }
 
+bool x86_machine_is_smm_enabled(X86MachineState *x86ms)
+{
+    bool smm_available = false;
+
+    if (x86ms->smm == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+
+    if (tcg_enabled() || qtest_enabled()) {
+        smm_available = true;
+    } else if (kvm_enabled()) {
+        smm_available = kvm_has_smm();
+    }
+
+    if (smm_available) {
+        return true;
+    }
+
+    if (x86ms->smm == ON_OFF_AUTO_ON) {
+        error_report("System Management Mode not supported by this hypervisor.");
+        exit(1);
+    }
+    return false;
+}
+
+static void x86_machine_get_smm(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    X86MachineState *x86ms = X86_MACHINE(obj);
+    OnOffAuto smm = x86ms->smm;
+
+    visit_type_OnOffAuto(v, name, &smm, errp);
+}
+
+static void x86_machine_set_smm(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    X86MachineState *x86ms = X86_MACHINE(obj);
+
+    visit_type_OnOffAuto(v, name, &x86ms->smm, errp);
+}
+
 static void x86_machine_initfn(Object *obj)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
 
+    x86ms->smm = ON_OFF_AUTO_AUTO;
     x86ms->max_ram_below_4g = 0; /* use default */
     x86ms->smp_dies = 1;
 }
@@ -770,9 +813,14 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
         x86_machine_get_max_ram_below_4g, x86_machine_set_max_ram_below_4g,
         NULL, NULL, &error_abort);
-
     object_class_property_set_description(oc, X86_MACHINE_MAX_RAM_BELOW_4G,
         "Maximum ram below the 4G boundary (32bit boundary)", &error_abort);
+
+    object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
+        x86_machine_get_smm, x86_machine_set_smm,
+        NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, X86_MACHINE_SMM,
+        "Enable SMM", &error_abort);
 }
 
 static const TypeInfo x86_machine_info = {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 82447f8..ca641e8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -43,7 +43,6 @@ struct PCMachineState {
 
     /* Configuration options: */
     OnOffAuto vmport;
-    OnOffAuto smm;
 
     bool acpi_build_enabled;
     bool smbus_enabled;
@@ -61,7 +60,6 @@ struct PCMachineState {
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
 #define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
 #define PC_MACHINE_VMPORT           "vmport"
-#define PC_MACHINE_SMM              "smm"
 #define PC_MACHINE_SMBUS            "smbus"
 #define PC_MACHINE_SATA             "sata"
 #define PC_MACHINE_PIT              "pit"
@@ -165,7 +163,6 @@ void vmmouse_set_data(const uint32_t *data);
 /* pc.c */
 extern int fd_bootchk;
 
-bool pc_machine_is_smm_enabled(PCMachineState *pcms);
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 4b84917..97d1575 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -60,6 +60,8 @@ typedef struct {
     uint16_t boot_cpus;
     unsigned smp_dies;
 
+    OnOffAuto smm;
+
     /*
      * Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space.
@@ -68,6 +70,7 @@ typedef struct {
 } X86MachineState;
 
 #define X86_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
+#define X86_MACHINE_SMM              "smm"
 
 #define TYPE_X86_MACHINE   MACHINE_TYPE_NAME("x86")
 #define X86_MACHINE(obj) \
@@ -95,4 +98,6 @@ void x86_load_linux(X86MachineState *x86ms,
                     bool pvh_enabled,
                     bool linuxboot_dma_enabled);
 
+bool x86_machine_is_smm_enabled(X86MachineState *x86ms);
+
 #endif
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ef63f3a..c7ff67a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2173,8 +2173,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
-        object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE) &&
-        pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
+        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
-- 
1.8.3.1



