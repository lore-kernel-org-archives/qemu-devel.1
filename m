Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3572C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336A9207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336A9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5u1e-0006Qy-H2
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i5u0y-0005zi-Ip
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i5u0w-0000jG-VE
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1i5u0u-0000gN-Oe
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:49:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D5AB23007C30;
 Thu,  5 Sep 2019 15:49:33 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7FF360127;
 Thu,  5 Sep 2019 15:49:28 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 11:49:25 -0400
Message-Id: <20190905154925.30478-1-imammedo@redhat.com>
In-Reply-To: <add488d0-df13-830f-28c5-c7232ccb741f@redhat.com>
References: <add488d0-df13-830f-28c5-c7232ccb741f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 05 Sep 2019 15:49:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] q35: lpc: allow to lock down 128K RAM at
 default SMBASE address
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
Cc: yingwen.chen@intel.com, devel@edk2.groups.io, phillip.goerl@oracle.com,
 alex.williamson@redhat.com, jiewen.yao@intel.com, jun.nakajima@intel.com,
 michael.d.kinney@intel.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 rfc@edk2.groups.io, lersek@redhat.com, joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

lpc already has SMI negotiation feature, extend it by adding
optin ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT to supported features.

Writing this bit into "etc/smi/requested-features" fw_cfg file,
tells QEMU to alias 0x30000,128K RAM range into SMRAM address
space and mask this region from normal RAM address space
(reads return 0xff and writes are ignored, i.e. guest code
should be able to deal with not usable 0x30000,128K RAM range
once ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT is activated).

To make negotiated change effective, guest should read
"etc/smi/features-ok" fw_cfg file, which activates negotiated
features and locks down negotiating capabilities until hard reset.

Flow for initializing SMI handler on guest side:
 1. set SMI handler entry point at default SMBASE location
 2. check that host supports ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT
    in "etc/smi/supported-features" and set if supported set
    it in "etc/smi/requested-features"
 3. read "etc/smi/features-ok", if returned value is 1
    negotiated at step 2 features are activated successfully.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/i386/ich9.h | 11 ++++++--
 hw/i386/pc.c           |  4 ++-
 hw/i386/pc_q35.c       |  3 ++-
 hw/isa/lpc_ich9.c      | 58 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 72e803f6e2..c28685b753 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -12,11 +12,14 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ich9.h"
 #include "hw/pci/pci_bus.h"
+#include "qemu/units.h"
 
 void ich9_lpc_set_irq(void *opaque, int irq_num, int level);
 int ich9_lpc_map_irq(PCIDevice *pci_dev, int intx);
 PCIINTxRoute ich9_route_intx_pin_to_irq(void *opaque, int pirq_pin);
-void ich9_lpc_pm_init(PCIDevice *pci_lpc, bool smm_enabled);
+void ich9_lpc_pm_init(PCIDevice *pci_lpc, bool smm_enabled,
+                      MemoryRegion *system_memory, MemoryRegion *ram,
+                      MemoryRegion *smram);
 I2CBus *ich9_smb_init(PCIBus *bus, int devfn, uint32_t smb_io_base);
 
 void ich9_generate_smi(void);
@@ -71,6 +74,8 @@ typedef struct ICH9LPCState {
     uint8_t smi_features_ok;          /* guest-visible, read-only; selecting it
                                        * triggers feature lockdown */
     uint64_t smi_negotiated_features; /* guest-invisible, host endian */
+    MemoryRegion smbase_blackhole;
+    MemoryRegion smbase_window;
 
     /* isa bus */
     ISABus *isa_bus;
@@ -248,5 +253,7 @@ typedef struct ICH9LPCState {
 
 /* bit positions used in fw_cfg SMI feature negotiation */
 #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
-
+#define ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT        1
+#define ICH9_LPC_SMBASE_ADDR                    0x30000
+#define ICH9_LPC_SMBASE_RAM_SIZE                (128 * KiB)
 #endif /* HW_ICH9_H */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c14ed86439..99a98303eb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -119,7 +119,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
-GlobalProperty pc_compat_4_1[] = {};
+GlobalProperty pc_compat_4_1[] = {
+    { "ICH9-LPC", "x-smi-locked-smbase", "off" },
+};
 const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 
 GlobalProperty pc_compat_4_0[] = {};
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d4e8a1cb9f..50462686a0 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -292,7 +292,8 @@ static void pc_q35_init(MachineState *machine)
                          0xff0104);
 
     /* connect pm stuff to lpc */
-    ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms));
+    ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms), get_system_memory(),
+        ram_memory, MEMORY_REGION(object_resolve_path("/machine/smram", NULL)));
 
     if (pcms->sata_enabled) {
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 17c292e306..17a8cd1b51 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -359,6 +359,38 @@ static void ich9_set_sci(void *opaque, int irq_num, int level)
     }
 }
 
+static uint64_t smbase_blackhole_read(void *ptr, hwaddr reg, unsigned size)
+{
+    return 0xffffffff;
+}
+
+static void smbase_blackhole_write(void *opaque, hwaddr addr, uint64_t val,
+                                   unsigned width)
+{
+    /* nothing */
+}
+
+static const MemoryRegionOps smbase_blackhole_ops = {
+    .read = smbase_blackhole_read,
+    .write = smbase_blackhole_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void ich9_lpc_smbase_locked_update(ICH9LPCState *lpc)
+{
+    bool en = lpc->smi_negotiated_features & ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT;
+
+    memory_region_transaction_begin();
+    memory_region_set_enabled(&lpc->smbase_blackhole, en);
+    memory_region_set_enabled(&lpc->smbase_window, en);
+    memory_region_transaction_commit();
+}
+
 static void smi_features_ok_callback(void *opaque)
 {
     ICH9LPCState *lpc = opaque;
@@ -379,9 +411,13 @@ static void smi_features_ok_callback(void *opaque)
     /* valid feature subset requested, lock it down, report success */
     lpc->smi_negotiated_features = guest_features;
     lpc->smi_features_ok = 1;
+
+    ich9_lpc_smbase_locked_update(lpc);
 }
 
-void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_enabled)
+void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_enabled,
+                      MemoryRegion *system_memory,  MemoryRegion *ram,
+                      MemoryRegion *smram)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(lpc_pci);
     qemu_irq sci_irq;
@@ -413,6 +449,20 @@ void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_enabled)
                                  &lpc->smi_features_ok,
                                  sizeof lpc->smi_features_ok,
                                  true);
+
+        memory_region_init_io(&lpc->smbase_blackhole, OBJECT(lpc),
+                              &smbase_blackhole_ops, NULL,
+                              "smbase-blackhole", ICH9_LPC_SMBASE_RAM_SIZE);
+        memory_region_set_enabled(&lpc->smbase_blackhole, false);
+        memory_region_add_subregion_overlap(system_memory, ICH9_LPC_SMBASE_ADDR,
+                                            &lpc->smbase_blackhole, 1);
+
+
+        memory_region_init_alias(&lpc->smbase_window, OBJECT(lpc),
+            "smbase-window", ram,
+             ICH9_LPC_SMBASE_ADDR, ICH9_LPC_SMBASE_RAM_SIZE);
+        memory_region_set_enabled(&lpc->smbase_window, false);
+        memory_region_add_subregion(smram, 0x30000, &lpc->smbase_window);
     }
 
     ich9_lpc_reset(DEVICE(lpc));
@@ -508,6 +558,7 @@ static int ich9_lpc_post_load(void *opaque, int version_id)
     ich9_lpc_pmbase_sci_update(lpc);
     ich9_lpc_rcba_update(lpc, 0 /* disabled ICH9_LPC_RCBA_EN */);
     ich9_lpc_pmcon_update(lpc);
+    ich9_lpc_smbase_locked_update(lpc);
     return 0;
 }
 
@@ -567,6 +618,8 @@ static void ich9_lpc_reset(DeviceState *qdev)
     memset(lpc->smi_guest_features_le, 0, sizeof lpc->smi_guest_features_le);
     lpc->smi_features_ok = 0;
     lpc->smi_negotiated_features = 0;
+
+    ich9_lpc_smbase_locked_update(lpc);
 }
 
 /* root complex register block is mapped into memory space */
@@ -697,6 +750,7 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
     qdev_init_gpio_out_named(dev, lpc->gsi, ICH9_GPIO_GSI, GSI_NUM_PINS);
 
     isa_bus_irqs(isa_bus, lpc->gsi);
+
 }
 
 static bool ich9_rst_cnt_needed(void *opaque)
@@ -764,6 +818,8 @@ static Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
     DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
                       ICH9_LPC_SMI_F_BROADCAST_BIT, true),
+    DEFINE_PROP_BIT64("x-smi-locked-smbase", ICH9LPCState, smi_host_features,
+                      ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.18.1


