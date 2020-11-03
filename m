Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DF0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BEC22226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BEC22226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvMZ-0004pU-97
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIN-0008QM-PN
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvII-000856-OO
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:15 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQTPZ2Wn5zkcR3;
 Tue,  3 Nov 2020 20:20:02 +0800 (CST)
Received: from localhost (10.174.184.155) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 20:19:55 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v9 2/8] fw_cfg: Write the extra roots into the fw_cfg
Date: Tue, 3 Nov 2020 20:01:51 +0800
Message-ID: <20201103120157.2286-3-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103120157.2286-1-cenjiahui@huawei.com>
References: <20201103120157.2286-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=cenjiahui@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:56:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org,
 Jiahui Cen <cenjiahui@huawei.com>, berrange@redhat.com, mst@redhat.com,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, miaoyubo@huawei.com,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yubo Miao <miaoyubo@huawei.com>

Write the extra roots into the fw_cfg, therefore the uefi could
get the extra roots. Only if the uefi knows there are extra roots,
the config space of devices behind the root could be obtained.

Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
---
 hw/arm/virt.c              |  8 ++++++++
 hw/i386/pc.c               | 18 ++----------------
 hw/nvram/fw_cfg.c          | 20 ++++++++++++++++++++
 include/hw/nvram/fw_cfg.h  |  2 ++
 include/hw/pci/pcie_host.h |  4 ++++
 5 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 27dbeb549e..58c3695290 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -78,6 +78,8 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pcie_host.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1463,6 +1465,10 @@ void virt_machine_done(Notifier *notifier, void *data)
     ARMCPU *cpu = ARM_CPU(first_cpu);
     struct arm_boot_info *info = &vms->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
+    PCIHostState *s = PCI_GET_PCIE_HOST_STATE;
+
+    PCIBus *bus = s->bus;
+    FWCfgState *fw_cfg = vms->fw_cfg;
 
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
@@ -1481,6 +1487,8 @@ void virt_machine_done(Notifier *notifier, void *data)
         exit(1);
     }
 
+    fw_cfg_write_extra_pci_roots(bus, fw_cfg);
+
     virt_acpi_setup(vms);
     virt_build_smbios(vms);
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5e6c0023e0..bdd2301d19 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -778,26 +778,12 @@ void pc_machine_done(Notifier *notifier, void *data)
                                         PCMachineState, machine_done);
     X86MachineState *x86ms = X86_MACHINE(pcms);
     PCIBus *bus = pcms->bus;
+    FWCfgState *fw_cfg = x86ms->fw_cfg;
 
     /* set the number of CPUs */
     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
-    if (bus) {
-        int extra_hosts = 0;
-
-        QLIST_FOREACH(bus, &bus->child, sibling) {
-            /* look for expander root buses */
-            if (pci_bus_is_root(bus)) {
-                extra_hosts++;
-            }
-        }
-        if (extra_hosts && x86ms->fw_cfg) {
-            uint64_t *val = g_malloc(sizeof(*val));
-            *val = cpu_to_le64(extra_hosts);
-            fw_cfg_add_file(x86ms->fw_cfg,
-                    "etc/extra-pci-roots", val, sizeof(*val));
-        }
-    }
+    fw_cfg_write_extra_pci_roots(bus, fw_cfg);
 
     acpi_setup();
     if (x86ms->fw_cfg) {
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 08539a1aab..33dcbdd31d 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -40,6 +40,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/pci/pci_bus.h"
 
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
 
@@ -742,6 +743,25 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
     return ptr;
 }
 
+void fw_cfg_write_extra_pci_roots(PCIBus *bus, FWCfgState *s)
+{
+    if (bus) {
+        int extra_hosts = 0;
+        QLIST_FOREACH(bus, &bus->child, sibling) {
+            /* look for expander root buses */
+            if (pci_bus_is_root(bus)) {
+                extra_hosts++;
+            }
+        }
+        if (extra_hosts && s) {
+            uint64_t *val = g_malloc(sizeof(*val));
+            *val = cpu_to_le64(extra_hosts);
+            fw_cfg_add_file(s,
+                   "etc/extra-pci-roots", val, sizeof(*val));
+        }
+    }
+}
+
 void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len)
 {
     trace_fw_cfg_add_bytes(key, trace_key_name(key), len);
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 8a9f5738bf..0dc75ba6ca 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -104,6 +104,8 @@ struct FWCfgMemState {
     MemoryRegionOps wide_data_ops;
 };
 
+void fw_cfg_write_extra_pci_roots(PCIBus *bus, FWCfgState *s);
+
 /**
  * fw_cfg_add_bytes:
  * @s: fw_cfg device being modified
diff --git a/include/hw/pci/pcie_host.h b/include/hw/pci/pcie_host.h
index 076457b270..12f48ddd59 100644
--- a/include/hw/pci/pcie_host.h
+++ b/include/hw/pci/pcie_host.h
@@ -27,6 +27,10 @@
 
 #define TYPE_PCIE_HOST_BRIDGE "pcie-host-bridge"
 OBJECT_DECLARE_SIMPLE_TYPE(PCIExpressHost, PCIE_HOST_BRIDGE)
+#define PCI_GET_PCIE_HOST_STATE \
+    OBJECT_CHECK(PCIHostState, \
+                 object_resolve_path_type("", "pcie-host-bridge", NULL), \
+                 TYPE_PCIE_HOST_BRIDGE)
 
 #define PCIE_HOST_MCFG_BASE "MCFG"
 #define PCIE_HOST_MCFG_SIZE "mcfg_size"
-- 
2.19.1


