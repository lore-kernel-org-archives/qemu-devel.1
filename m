Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461DFC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DBE2342D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Pf4vLNQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DBE2342D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2KhP-0007Yi-7I
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 15:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1i2Kaz-0007z1-Jx
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1i2Kay-0000P4-6W
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:24:05 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18341)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1i2Kax-0000Or-7e
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:24:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d6431d30001>; Mon, 26 Aug 2019 12:24:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 26 Aug 2019 12:24:02 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 26 Aug 2019 12:24:02 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 19:24:01 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 19:24:01 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Aug 2019 19:23:54 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Tue, 27 Aug 2019 00:25:44 +0530
Message-ID: <1566845753-18993-5-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
References: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1566847444; bh=F/gSqJlPYGHDCoClM8Z1x0XD6giuMs0/6cGvJHDBlCk=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=Pf4vLNQq5lbYQV/LTcUJEXCC5Qw/zJfeLNT1zwlpcE5/qzPtegsfZoiPYpdNXt3nm
 t2p7kVlyC+JiFkkFL1k+N7qW5Zicg+hQuNK85UeUFZJ1H+SBYY4J8tVC4zoEBikDQa
 hE2ZfrOqTL4oNKuV+uU5VtN/8jS6tRObsU7gHdn/EcIyXf5b2PCI1bhgxZ5TLsIDJN
 4oAM+qmk8h6TtlYaOz8O0Aw6Q89BrSnarmtIMbAoNJNm/F/FbmiKVBKRH5dxjPGbRH
 05ns6oj6TprBFkNggDOWmBZY9HjLjcQRyHEkobOUJNhwU2iIq2cgLdRJdL1lSdDnqP
 I4H5MU4Nh/XMg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.64
Subject: [Qemu-devel] [PATCH v8 04/13] vfio: Add save and load functions for
 VFIO PCI devices
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions save and restore PCI device specific data - config
space of PCI device.
Tested save and restore with MSI and MSIX type.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/pci.c                 | 168 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |   2 +
 2 files changed, 170 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 56166cae824f..161068286592 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -40,6 +40,7 @@
 #include "pci.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/qemu-file.h"
 
 #define TYPE_VFIO_PCI "vfio-pci"
 #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
@@ -1618,6 +1619,55 @@ static void vfio_bars_prepare(VFIOPCIDevice *vdev)
     }
 }
 
+static int vfio_bar_validate(VFIOPCIDevice *vdev, int nr)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOBAR *bar = &vdev->bars[nr];
+    uint64_t addr;
+    uint32_t addr_lo, addr_hi = 0;
+
+    /* Skip unimplemented BARs and the upper half of 64bit BARS. */
+    if (!bar->size) {
+        return 0;
+    }
+
+    /* skip IO BAR */
+    if (bar->ioport) {
+        return 0;
+    }
+
+    addr_lo = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + nr * 4, 4);
+
+    addr_lo = addr_lo & (bar->ioport ? PCI_BASE_ADDRESS_IO_MASK :
+                                       PCI_BASE_ADDRESS_MEM_MASK);
+    if (bar->type == PCI_BASE_ADDRESS_MEM_TYPE_64) {
+        addr_hi = pci_default_read_config(pdev,
+                                         PCI_BASE_ADDRESS_0 + (nr + 1) * 4, 4);
+    }
+
+    addr = ((uint64_t)addr_hi << 32) | addr_lo;
+
+    if (!QEMU_IS_ALIGNED(addr, bar->size)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int vfio_bars_validate(VFIOPCIDevice *vdev)
+{
+    int i, ret;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        ret = vfio_bar_validate(vdev, i);
+        if (ret) {
+            error_report("vfio: BAR address %d validation failed", i);
+            return ret;
+        }
+    }
+    return 0;
+}
+
 static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
 {
     VFIOBAR *bar = &vdev->bars[nr];
@@ -2400,11 +2450,129 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
     return OBJECT(vdev);
 }
 
+static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+    uint16_t pci_cmd;
+    int i;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        uint32_t bar;
+
+        bar = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
+        qemu_put_be32(f, bar);
+    }
+
+    qemu_put_be32(f, vdev->interrupt);
+    if (vdev->interrupt == VFIO_INT_MSI) {
+        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
+        bool msi_64bit;
+
+        msi_flags = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                                            2);
+        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
+
+        msi_addr_lo = pci_default_read_config(pdev,
+                                         pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
+        qemu_put_be32(f, msi_addr_lo);
+
+        if (msi_64bit) {
+            msi_addr_hi = pci_default_read_config(pdev,
+                                             pdev->msi_cap + PCI_MSI_ADDRESS_HI,
+                                             4);
+        }
+        qemu_put_be32(f, msi_addr_hi);
+
+        msi_data = pci_default_read_config(pdev,
+                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
+                2);
+        qemu_put_be32(f, msi_data);
+    } else if (vdev->interrupt == VFIO_INT_MSIX) {
+        uint16_t offset;
+
+        /* save enable bit and maskall bit */
+        offset = pci_default_read_config(pdev,
+                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
+        qemu_put_be16(f, offset);
+        msix_save(pdev, f);
+    }
+    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
+    qemu_put_be16(f, pci_cmd);
+}
+
+static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+    uint32_t interrupt_type;
+    uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
+    uint16_t pci_cmd;
+    bool msi_64bit;
+    int i, ret;
+
+    /* retore pci bar configuration */
+    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
+    vfio_pci_write_config(pdev, PCI_COMMAND,
+                        pci_cmd & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        uint32_t bar = qemu_get_be32(f);
+
+        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
+    }
+
+    ret = vfio_bars_validate(vdev);
+    if (ret) {
+        return ret;
+    }
+
+    interrupt_type = qemu_get_be32(f);
+
+    if (interrupt_type == VFIO_INT_MSI) {
+        /* restore msi configuration */
+        msi_flags = pci_default_read_config(pdev,
+                                            pdev->msi_cap + PCI_MSI_FLAGS, 2);
+        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
+
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                              msi_flags & (!PCI_MSI_FLAGS_ENABLE), 2);
+
+        msi_addr_lo = qemu_get_be32(f);
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
+                              msi_addr_lo, 4);
+
+        msi_addr_hi = qemu_get_be32(f);
+        if (msi_64bit) {
+            vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
+                                  msi_addr_hi, 4);
+        }
+        msi_data = qemu_get_be32(f);
+        vfio_pci_write_config(pdev,
+                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
+                msi_data, 2);
+
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                              msi_flags | PCI_MSI_FLAGS_ENABLE, 2);
+    } else if (interrupt_type == VFIO_INT_MSIX) {
+        uint16_t offset = qemu_get_be16(f);
+
+        /* load enable bit and maskall bit */
+        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
+                              offset, 2);
+        msix_load(pdev, f);
+    }
+    pci_cmd = qemu_get_be16(f);
+    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
+    return 0;
+}
+
 static VFIODeviceOps vfio_pci_ops = {
     .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
     .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
     .vfio_eoi = vfio_intx_eoi,
     .vfio_get_object = vfio_pci_get_object,
+    .vfio_save_config = vfio_pci_save_config,
+    .vfio_load_config = vfio_pci_load_config,
 };
 
 int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 771b6d59a3db..6ea4898c4d7e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -120,6 +120,8 @@ struct VFIODeviceOps {
     int (*vfio_hot_reset_multi)(VFIODevice *vdev);
     void (*vfio_eoi)(VFIODevice *vdev);
     Object *(*vfio_get_object)(VFIODevice *vdev);
+    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
+    int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
 };
 
 typedef struct VFIOGroup {
-- 
2.7.0


