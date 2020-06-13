Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBFDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A238F20792
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A238F20792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkE7C-0006HN-Tl
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDyC-0007A9-4b; Sat, 13 Jun 2020 17:45:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33284 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDy7-0003L7-PR; Sat, 13 Jun 2020 17:45:43 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2238FFF1004DFACDB16F;
 Sun, 14 Jun 2020 05:45:36 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:45:29 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 13/22] arm/cpuhp: Add ACPI _MAT entry for Processor object
Date: Sat, 13 Jun 2020 22:36:20 +0100
Message-ID: <20200613213629.21984-14-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20200613213629.21984-1-salil.mehta@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.30.60]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 17:44:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, sudeep.holla@arm.com,
 gshan@redhat.com, mst@redhat.com, jiakernel2@gmail.com, maz@kernel.org,
 zhukeqian1@huawei.com, david@redhat.com, richard.henderson@linaro.org,
 linuxarm@huawei.com, eric.auger@redhat.com, james.morse@arm.com,
 catalin.marinas@arm.com, imammedo@redhat.com,
 Salil Mehta <salil.mehta@huawei.com>, pbonzini@redhat.com,
 mehta.salil.lnk@gmail.com, maran.wilson@oracle.com, will@kernel.org,
 wangxiongfeng2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds a function which builds the ACPI _MAT entry for processor objects. This
shall be called from the cpus AML for all possible vcpus.

The entry is passed to the guest kernel with ACPI_MADT_GICC_ENABLED flag when
it evaluates _MAT object. OSPM evaluates _MAT object in context to the cpu
hotplug event.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/acpi/cpu.c            |  5 +++++
 hw/arm/virt-acpi-build.c | 20 ++++++++++++++++++++
 include/hw/arm/virt.h    |  1 +
 3 files changed, 26 insertions(+)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 867fdd6993..a79dc65120 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -565,6 +565,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                 apic->flags = cpu_to_le32(1);
                 break;
             }
+            case ACPI_APIC_GENERIC_CPU_INTERFACE: {
+                AcpiMadtGenericCpuInterface *gicc = (void *)madt_buf->data;
+                gicc->flags = cpu_to_le32(1);
+                break;
+            }
             default:
                 assert(0);
             }
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c654e2c9a3..354fd775f9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -593,6 +593,22 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 }
 
 /* MADT */
+static void
+build_mat_entry(AcpiDeviceIf *adev, int uid, const CPUArchIdList *arch_ids,
+                    GArray *entry)
+{
+    AcpiMadtGenericCpuInterface *gicc = acpi_data_push(entry,sizeof(*gicc));
+    MachineState *ms = MACHINE(qdev_get_machine());
+    CPUArchIdList *possible_cpus = ms->possible_cpus;
+
+    /* fill the relevant fields of _MAT entry for GICC */
+    gicc->type = ACPI_APIC_GENERIC_CPU_INTERFACE;
+    gicc->length = sizeof(*gicc);
+    gicc->cpu_interface_number = cpu_to_le32(uid);
+    gicc->arm_mpidr = possible_cpus->cpus[uid].arch_id;
+    gicc->uid = cpu_to_le32(uid);
+}
+
 static void
 build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
@@ -741,6 +757,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
              .acpi_1_compatible = false,
              .has_legacy_cphp = false
         };
+        AcpiDeviceIfClass *adevc;
+        /* _MAT entry shall be used within cpus aml */
+        adevc = ACPI_DEVICE_IF_CLASS(DEVICE_GET_CLASS(vms->acpi_dev));
+        adevc->madt_cpu = build_mat_entry;
 
         build_cpus_aml(scope, ms, opts, memmap[VIRT_CPUHP_ACPI].base,
                        "\\_SB", NULL, AML_SYSTEM_MEMORY);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index e0bd9df69d..e8468d8cf6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -37,6 +37,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/acpi/acpi_dev_interface.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
-- 
2.17.1



