Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB90C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB5D20658
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lelKUBo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB5D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywUc-00075t-6D
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQF-0008K3-EG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQC-0000Dz-TC
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQC-0000Bb-LJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:12 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204113111euoutp022389a1179aece5b4857039857e2538f8~wL6jvMK7B3023230232euoutp02B
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 11:31:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204113111euoutp022389a1179aece5b4857039857e2538f8~wL6jvMK7B3023230232euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580815871;
 bh=2EdIg2dqS4is2/71/wtKDkcAjFpedYTyvl4ZZh7iwes=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lelKUBo1RtXvLfmQ6kOLzJBttZIre5/mi/rwSGMMwhPlSlP39ze1tSzQdC9XjlXvU
 AHnsoDulk1xejdjVSgg4W3jjXgO/dHq8N+R6fZilcTLXs1/+/+WaqBxDbdxJdQfcLh
 eQOofZdBF8CuvKynbVQnkg6DFBc6QG9fkHnwqBLE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204113111eucas1p15eb69341c493393bdc1002f38ddbd3e7~wL6jg6pD80252702527eucas1p13;
 Tue,  4 Feb 2020 11:31:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id E1.0F.61286.FF5593E5; Tue,  4
 Feb 2020 11:31:11 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113111eucas1p2a96ec20fbaf679215b50d9f03245b33e~wL6jS9Qkq0683206832eucas1p2H;
 Tue,  4 Feb 2020 11:31:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200204113111eusmtrp1d95ab5ee4061de5f02ceb608f4104884~wL6jSdGA82102721027eusmtrp1D;
 Tue,  4 Feb 2020 11:31:11 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-9d-5e3955fff99e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id FA.AC.08375.FF5593E5; Tue,  4
 Feb 2020 11:31:11 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113110eusmtip279e2ff1405fc17f52f2b634b58c41bec~wL6i7LHvI1904519045eusmtip2T;
 Tue,  4 Feb 2020 11:31:10 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC 9/9] hw/arm/virt: Hack in support for memexpose device
Date: Tue,  4 Feb 2020 12:30:51 +0100
Message-Id: <1580815851-28887-10-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djPc7r/Qy3jDFoPK1nsufCYzWL/tn+s
 FnPOPGCxON67g8WBxePOtT1sHk+ubWbyOPhuD5PH+31X2QJYorhsUlJzMstSi/TtErgyWvfM
 Yy9Ya1ex4DJXA+NO3S5GTg4JAROJT3v+MHUxcnEICaxglNiw4igLhPOFUWLapQlQmc+MEhO2
 bAXKcIC19J1Ih4gvZ5T4d+0RE1zH7o5LzCBz2QTUJHYe+cwIYosISEr87joNFmcWyJB4Pqsb
 zBYWcJFo2rwYzGYRUJU42f+RFcTmFQiU2Pj/AhvEfXISN891gtVwAsXf75kEtkxC4DKbxN01
 G5khilwkTj47zA5hC0u8Or4FypaROD25hwXCrpdoubMDqrmDUaJv5XSoDdYSXzYsBXuNWUBT
 Yv0ufYiwo8TGs2/YID7mk7jxVhDifj6JSdumM0OEeSU62oQgqvUkup/cZILZuqzxEdRWD4l1
 62YwQ8JnCaPEg1/f2SYwys9CWLaAkXEVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYPSf
 /nf80w7Gr5eSDjEKcDAq8fBesLOIE2JNLCuuzD3EKMHBrCTCe17fMk6INyWxsiq1KD++qDQn
 tfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkGRobXq9k2/VWZWPl46uof09dOuvSE
 J2Or1R554dAP1XE+es/Tr22U/Sa+z1x+CuulHZf+XNs88dCZ388m3Pac8P7y6tIoYf+TWXPt
 W+Muy58vzv2keC77pOmSY1pC+3YJLPFLzX+4e9G9OXm8ExteCLZoxuQGbTVv2PZ+V27p/Q17
 0hSnhl5YdNJfiaU4I9FQi7moOBEAor+X3voCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsVy+t/xe7r/Qy3jDBoX81nsufCYzWL/tn+s
 FnPOPGCxON67g8WBxePOtT1sHk+ubWbyOPhuD5PH+31X2QJYovRsivJLS1IVMvKLS2yVog0t
 jPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyWvfMYy9Ya1ex4DJXA+NO3S5GDg4J
 AROJvhPpXYycHEICSxklHizPAbElBGQkfpxewwZhC0v8udYFZHMB1XxilDiy8RI7SIJNQE1i
 55HPjCC2iICkxO+u08wgNrNAlsTO2feZQGxhAReJps2LweIsAqoSJ/s/soLYvAKBEhv/X4Ba
 ICdx81wnWA0nUPz9nklMEAcFSFzYNYt9AiPfAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmb
 GIGBuO3Yz807GC9tDD7EKMDBqMTDe8HOIk6INbGsuDL3EKMEB7OSCO95fcs4Id6UxMqq1KL8
 +KLSnNTiQ4ymQEdNZJYSTc4HRkleSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILU
 Ipg+Jg5OqQbGxpuGM6cLMbAkJVbGHFL+sO337JO+jkvjz968d+mtzNoNHxj13DSY9Lzv8z+f
 EcWys/3Un2K7WWZuKcXtjGw+X3xP31jf9sXWPOqmptlv/+irJXHXi6z8L3PeXKPX+EB3ZzNr
 xaEF01YKs3GvZJh412Z5YnXf0h28a1fpV7zW2uMrcNC27HaQEktxRqKhFnNRcSIAVFhBKVoC
 AAA=
X-CMS-MailID: 20200204113111eucas1p2a96ec20fbaf679215b50d9f03245b33e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204113111eucas1p2a96ec20fbaf679215b50d9f03245b33e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113111eucas1p2a96ec20fbaf679215b50d9f03245b33e
References: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200204113111eucas1p2a96ec20fbaf679215b50d9f03245b33e@eucas1p2.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 hw/arm/virt.c         | 110 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/virt.h |   5 +++
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f788fe2..ba35b21 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -71,6 +71,8 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/misc/memexpose/memexpose-core.h"
+#include "hw/misc/memexpose/memexpose-memregion.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -168,6 +170,8 @@ static MemMapEntry extended_memmap[] = {
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
     [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
+    [VIRT_HIGH_MEMEXPOSE_MMIO] =     { 0x0, 256 * MiB },
+    [VIRT_HIGH_MEMEXPOSE] =     { 0x0, 32 * GiB },
     /* Second PCIe window */
     [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
 };
@@ -179,6 +183,7 @@ static const int a15irqmap[] = {
     [VIRT_GPIO] = 7,
     [VIRT_SECURE_UART] = 8,
     [VIRT_ACPI_GED] = 9,
+    [VIRT_MEMEXPOSE] = 10,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
@@ -763,6 +768,67 @@ static void create_uart(const VirtMachineState *vms, int uart,
     g_free(nodename);
 }
 
+static void create_memexpose(const VirtMachineState *vms, MemoryRegion *mem,
+                             Error **errp)
+{
+    if (!vms->memexpose_size) {
+        error_setg(errp, "For memexpose support, memexpose_size "
+                         "needs to be greater than zero");
+        return;
+    }
+    if (!strcmp("", vms->memexpose_ep)) {
+        error_setg(errp, "For memexpose support, memexpose_ep "
+                         "needs to be non-empty");
+        return;
+    }
+
+    DeviceState *dev = qdev_create(NULL, "memexpose-memdev");
+
+    hwaddr base = vms->memmap[VIRT_HIGH_MEMEXPOSE].base;
+    hwaddr size = vms->memexpose_size;
+    hwaddr mmio_base = vms->memmap[VIRT_HIGH_MEMEXPOSE_MMIO].base;
+    hwaddr mmio_size = MEMEXPOSE_INTR_MEM_SIZE;
+    int irq = vms->irqmap[VIRT_MEMEXPOSE];
+
+    qdev_prop_set_uint64(dev, "shm_size", size);
+
+    char *intr_ep = g_strdup_printf("%s-intr", vms->memexpose_ep);
+    char *mem_ep = g_strdup_printf("%s-mem", vms->memexpose_ep);
+    Chardev *c = qemu_chr_find(mem_ep);
+    if (!c) {
+        error_setg(errp, "Failed to find memexpose memory endpoint");
+        return;
+    }
+    qdev_prop_set_chr(dev, "mem_chardev", c);
+    c = qemu_chr_find(intr_ep);
+    if (!c) {
+        error_setg(errp, "Failed to find memexpose interrupt endpoint");
+        return;
+    }
+    qdev_prop_set_chr(dev, "intr_chardev", c);
+    g_free(intr_ep);
+    g_free(mem_ep);
+
+    qdev_init_nofail(dev);
+    MemexposeMemdev *mdev = MEMEXPOSE_MEMDEV(dev);
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+    memory_region_add_subregion(mem, mmio_base, &mdev->intr.shmem);
+    memory_region_add_subregion(mem, base, &mdev->mem.shmem);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
+
+    char *nodename = g_strdup_printf("/memexpose@%" PRIx64, mmio_base);
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+                            "memexpose-memregion");
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+                                 2, mmio_base, 2, mmio_size,
+                                 2, base, 2, size);
+    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    g_free(nodename);
+}
+
 static void create_rtc(const VirtMachineState *vms)
 {
     char *nodename;
@@ -1572,7 +1638,6 @@ static void machvirt_init(MachineState *machine)
                            UINT64_MAX);
         memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
     }
-
     firmware_loaded = virt_firmware_init(vms, sysmem,
                                          secure_sysmem ?: sysmem);
 
@@ -1721,6 +1786,8 @@ static void machvirt_init(MachineState *machine)
     fdt_add_pmu_nodes(vms);
 
     create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
+    if (vms->memexpose_size > 0)
+        create_memexpose(vms, sysmem, &error_abort);
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
@@ -1849,6 +1916,32 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
     }
 }
 
+static char *virt_get_memexpose_ep(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    return g_strdup(vms->memexpose_ep);
+}
+
+static void virt_set_memexpose_ep(Object *obj, const char *value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    g_free(vms->memexpose_ep);
+    vms->memexpose_ep = g_strdup(value);
+}
+
+static char *virt_get_memexpose_size(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    return g_strdup_printf("%" PRIx64, vms->memexpose_size);
+}
+
+static void virt_set_memexpose_size(Object *obj, const char *value,
+                                    Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    parse_option_size("memexpose-size", value, &vms->memexpose_size, errp);
+}
+
 static char *virt_get_iommu(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -2103,6 +2196,21 @@ static void virt_instance_init(Object *obj)
                                     "Set GIC version. "
                                     "Valid values are 2, 3 and host", NULL);
 
+    /* Memexpose disabled by default */
+    vms->memexpose_ep = g_strdup("");
+    object_property_add_str(obj, "memexpose-ep", virt_get_memexpose_ep,
+                            virt_set_memexpose_ep, NULL);
+    object_property_set_description(obj, "memexpose-ep",
+                                    "Set path to memexpose server socket. "
+                                    "Sockets used for communication will be "
+                                    "<name>-intr and <name>-mem. Set to empty "
+                                    "to disable memexpose.", NULL);
+    vms->memexpose_size = 0;
+    object_property_add_str(obj, "memexpose-size", virt_get_memexpose_size,
+                            virt_set_memexpose_size, NULL);
+    object_property_set_description(obj, "memexpose-size",
+                                    "Size of the memexpose region to access.",
+                                    NULL);
     vms->highmem_ecam = !vmc->no_highmem_ecam;
 
     if (vmc->no_its) {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 71508bf..d0aeb67 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -76,6 +76,7 @@ enum {
     VIRT_PLATFORM_BUS,
     VIRT_GPIO,
     VIRT_SECURE_UART,
+    VIRT_MEMEXPOSE,
     VIRT_SECURE_MEM,
     VIRT_PCDIMM_ACPI,
     VIRT_ACPI_GED,
@@ -86,6 +87,8 @@ enum {
 enum {
     VIRT_HIGH_GIC_REDIST2 =  VIRT_LOWMEMMAP_LAST,
     VIRT_HIGH_PCIE_ECAM,
+    VIRT_HIGH_MEMEXPOSE_MMIO,
+    VIRT_HIGH_MEMEXPOSE,
     VIRT_HIGH_PCIE_MMIO,
 };
 
@@ -124,6 +127,8 @@ typedef struct {
     bool its;
     bool virt;
     int32_t gic_version;
+    char *memexpose_ep;
+    uint64_t memexpose_size;
     VirtIOMMUType iommu;
     struct arm_boot_info bootinfo;
     MemMapEntry *memmap;
-- 
2.7.4


