Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4AAC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B986420673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="osgsy+Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B986420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyWa-0006qY-N8
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyJm-0005ps-8G
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyJk-0005K6-My
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:38 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6435)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hdyJk-0005IY-Do
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0b9ad20000>; Thu, 20 Jun 2019 07:40:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Jun 2019 07:40:17 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 07:40:17 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:40:16 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 14:40:10 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Thu, 20 Jun 2019 20:07:31 +0530
Message-ID: <1561041461-22326-4-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561041618; bh=820//1adwBrsybd0iJJD10rOM2cUvJ+T90dz3F2qvpc=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=osgsy+Tm16I7Tq/PIriD2F7zqY4SQUtbCutHyactcaKGyXR9CvxmzWeLla5Q3BHiW
 RQ7ocfkGCMqfj6vYo2LJ4XmVoIXBLgfBQwOipiFavdwL9ErBIdy+3vHuHRpWO9/9qy
 MD+/B3Knw8IF7sLDSLVkhxRY42Z+NZj9QKqU44Yw4YgkDvO7abtIglcHbJhQMdZYIl
 DGgqq42eG4sv9N4MuPMEy/311zQHvYZ6PShY6eJgdOh5agtuledZDTIuziAx4j3A8j
 50TqyUvLI/kHjHpAlv1W8B6mh/NttGn9endBr+5lm7VjwoN0XYpkFhScL88DE7ecT3
 ctqYKRbVp9Heg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.64
Subject: [Qemu-devel] [PATCH v4 03/13] vfio: Add save and load functions for
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Zhengxiao.zx@Alibaba-inc.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yan.y.zhao@intel.com,
 eskultet@redhat.com, ziye.yang@intel.com, qemu-devel@nongnu.org,
 cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com,
 zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 yulei.zhang@intel.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions save and restore PCI device specific data - config
space of PCI device.
Tested save and restore with MSI and MSIX type.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/pci.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h |  29 +++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ce3fe96efe2c..09a0821a5b1c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1187,6 +1187,118 @@ void vfio_pci_write_config(PCIDevice *pdev,
     }
 }
 
+void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
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
+void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+    uint32_t interrupt_type;
+    uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
+    uint16_t pci_cmd;
+    bool msi_64bit;
+    int i;
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
+    vfio_pci_write_config(pdev, PCI_COMMAND,
+                          pci_cmd | PCI_COMMAND_IO | PCI_COMMAND_MEMORY, 2);
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
+}
+
 /*
  * Interrupt setup
  */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 834a90d64686..847be5f56478 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -19,6 +19,7 @@
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 
+#ifdef CONFIG_LINUX
 #define PCI_ANY_ID (~0)
 
 struct VFIOPCIDevice;
@@ -202,4 +203,32 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
 
+void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f);
+void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
+
+static inline Object *vfio_pci_get_object(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+
+    return OBJECT(vdev);
+}
+
+#else
+static inline void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    g_assert(false);
+}
+
+static inline void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    g_assert(false);
+}
+
+static inline Object *vfio_pci_get_object(VFIODevice *vbasedev)
+{
+    return NULL;
+}
+
+#endif
+
 #endif /* HW_VFIO_VFIO_PCI_H */
-- 
2.7.0


