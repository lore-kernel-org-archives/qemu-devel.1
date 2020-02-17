Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D663C35242
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0052E2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0052E2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b7c-0004Se-5G
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b30-0004Md-1q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2y-0000bn-MR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3231 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2u-0000Ro-8H; Mon, 17 Feb 2020 02:42:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0F484F9413AD7C18766C;
 Mon, 17 Feb 2020 15:42:20 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:12 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 14/16] hw/arm: move shared bootinfo member to ArmMachine
Date: Mon, 17 Feb 2020 02:51:26 -0500
Message-ID: <1581925888-103620-15-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: zhang.zhanghailiang@huawei.com, slp@redhat.com,
 Xu Yandong <xuyandong2@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move bootinfo member from VirtMachineState to ArmMachineState.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/arm.c          |  9 +++++++++
 hw/arm/virt.c         | 28 +++++++++-------------------
 include/hw/arm/arm.h  |  3 +++
 include/hw/arm/virt.h |  1 -
 4 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/hw/arm/arm.c b/hw/arm/arm.c
index 4bffee0f37..7d880dd8e7 100644
--- a/hw/arm/arm.c
+++ b/hw/arm/arm.c
@@ -508,6 +508,15 @@ void create_virtio_devices(const ArmMachineState *ams)
     }
 }
 
+void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
+{
+    const ArmMachineState *board = container_of(binfo, ArmMachineState,
+                                                 bootinfo);
+
+    *fdt_size = board->fdt_size;
+    return board->fdt;
+}
+
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     ArmMachineState *ams = ARM_MACHINE(obj);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 11e753906b..2f498ea687 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -971,16 +971,6 @@ static void create_secure_ram(VirtMachineState *vms,
     g_free(nodename);
 }
 
-static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
-{
-    const VirtMachineState *vms = container_of(binfo, VirtMachineState,
-                                                 bootinfo);
-
-    ArmMachineState *board = ARM_MACHINE(vms);
-    *fdt_size = board->fdt_size;
-    return board->fdt;
-}
-
 static void virt_build_smbios(VirtMachineState *vms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(vms);
@@ -1016,7 +1006,7 @@ void virt_machine_done(Notifier *notifier, void *data)
     MachineState *ms = MACHINE(vms);
     ArmMachineState *ams = ARM_MACHINE(vms);
     ARMCPU *cpu = ARM_CPU(first_cpu);
-    struct arm_boot_info *info = &vms->bootinfo;
+    struct arm_boot_info *info = &ams->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
 
     /*
@@ -1373,14 +1363,14 @@ static void machvirt_init(MachineState *machine)
 
     create_platform_bus(vms);
 
-    vms->bootinfo.ram_size = machine->ram_size;
-    vms->bootinfo.nb_cpus = smp_cpus;
-    vms->bootinfo.board_id = -1;
-    vms->bootinfo.loader_start = ams->memmap[VIRT_MEM].base;
-    vms->bootinfo.get_dtb = machvirt_dtb;
-    vms->bootinfo.skip_dtb_autoload = true;
-    vms->bootinfo.firmware_loaded = firmware_loaded;
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
+    ams->bootinfo.ram_size = machine->ram_size;
+    ams->bootinfo.nb_cpus = smp_cpus;
+    ams->bootinfo.board_id = -1;
+    ams->bootinfo.loader_start = ams->memmap[VIRT_MEM].base;
+    ams->bootinfo.get_dtb = machvirt_dtb;
+    ams->bootinfo.skip_dtb_autoload = true;
+    ams->bootinfo.firmware_loaded = firmware_loaded;
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &ams->bootinfo);
 
     vms->machine_done.notify = virt_machine_done;
     qemu_add_machine_init_done_notifier(&vms->machine_done);
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index 743a90ba36..372f4dea28 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -92,6 +92,7 @@ typedef struct {
 typedef struct {
     MachineState parent;
     int32_t gic_version;
+    struct arm_boot_info bootinfo;
     MemMapEntry *memmap;
     const int *irqmap;
     int smp_cpus;
@@ -130,6 +131,8 @@ void create_rtc(const ArmMachineState *ams);
 
 void create_virtio_devices(const ArmMachineState *ams);
 
+void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size);
+
 /* Return the number of used redistributor regions  */
 static inline int virt_gicv3_redist_region_count(ArmMachineState *ams)
 {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 086a27682f..8276e2c02c 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -68,7 +68,6 @@ typedef struct {
     bool its;
     bool virt;
     VirtIOMMUType iommu;
-    struct arm_boot_info bootinfo;
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
     hwaddr highest_gpa;
-- 
2.18.1


