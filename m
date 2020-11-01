Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35ECC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91E5221FC
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOe8HeEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91E5221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKSd-0004Kx-Pm
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKRZ-0003YE-IA
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 15:59:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKRW-00056g-Kw
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 15:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604264352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4OtyU0zlulOguQQVk9fVHYWINDN5iChWcN2Q0k0mpzo=;
 b=VOe8HeEjvtEVbKBS560IdB1uZKmSPAL2fgnssMu4YQ48bmAvis2h6ocA7KnQ1fB1S+OCDm
 C88d/Vkk9f9cI5RuJe9ljBBQ6f0wR2S389v9/pf6s6WfXf09fO1VjOMFhlVIqRaldlWk6X
 w2bcEsog/CZOmggdgC90Fet2OmkoDxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-Ygjf44UyMU6anOz-lq5-0g-1; Sun, 01 Nov 2020 15:59:10 -0500
X-MC-Unique: Ygjf44UyMU6anOz-lq5-0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD01356BF9;
 Sun,  1 Nov 2020 20:59:08 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D9AC5C26B;
 Sun,  1 Nov 2020 20:59:00 +0000 (UTC)
Subject: [PULL v3 00/32] VFIO updates 2020-11-01 (for QEMU 5.2 soft-freeze)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 01 Nov 2020 13:58:59 -0700
Message-ID: <160426371498.24886.12193840637250368669.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:46:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Artem Polyakov <artemp@nvidia.com>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amey Narkhede <ameynarkhede03@gmail.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aggregated interdiff versus v1 pull request below.  Thanks,

Alex

The following changes since commit 700d20b49e303549b32d3a7a3efbfcee8c7a4f6c:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-11-01 14:02:19 +0000)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20201101.0

for you to fetch changes up to c624b6b312680b76d2a19a4c65cfdb234e875e1b:

  vfio: fix incorrect print type (2020-11-01 12:30:52 -0700)

----------------------------------------------------------------
VFIO update 2020-11-01

 * Migration support (Kirti Wankhede)
 * s390 DMA limiting (Matthew Rosato)
 * zPCI hardware info (Matthew Rosato)
 * Lock guard (Amey Narkhede)
 * Print fixes (Zhengui li)
 * Warning/build fixes

----------------------------------------------------------------
Amey Narkhede (1):
      hw/vfio: Use lock guard macros

Kirti Wankhede (17):
      vfio: Add function to unmap VFIO region
      vfio: Add vfio_get_object callback to VFIODeviceOps
      vfio: Add save and load functions for VFIO PCI devices
      vfio: Add migration region initialization and finalize function
      vfio: Add VM state change handler to know state of VM
      vfio: Add migration state change notifier
      vfio: Register SaveVMHandlers for VFIO device
      vfio: Add save state functions to SaveVMHandlers
      vfio: Add load state functions to SaveVMHandlers
      memory: Set DIRTY_MEMORY_MIGRATION when IOMMU is enabled
      vfio: Get migration capability flags for container
      vfio: Add function to start and stop dirty pages tracking
      vfio: Add vfio_listener_log_sync to mark dirty pages
      vfio: Dirty page tracking when vIOMMU is enabled
      vfio: Add ioctl to get dirty pages bitmap during dma unmap
      vfio: Make vfio-pci device migration capable
      qapi: Add VFIO devices migration stats in Migration stats

Matthew Rosato (10):
      update-linux-headers: Add vfio_zdev.h
      linux-headers: update against 5.10-rc1
      s390x/pci: Move header files to include/hw/s390x
      vfio: Create shared routine for scanning info capabilities
      vfio: Find DMA available capability
      s390x/pci: Add routine to get the vfio dma available count
      s390x/pci: Honor DMA limits set by vfio
      s390x/pci: clean up s390 PCI groups
      vfio: Add routine for finding VFIO_DEVICE_GET_INFO capabilities
      s390x/pci: get zPCI function info from host

Pierre Morel (3):
      s390x/pci: create a header dedicated to PCI CLP
      s390x/pci: use a PCI Group structure
      s390x/pci: use a PCI Function structure

Zhengui Li (1):
      vfio: fix incorrect print type

 MAINTAINERS                                        |   1 +
 hw/s390x/meson.build                               |   1 +
 hw/s390x/s390-pci-bus.c                            |  91 +-
 hw/s390x/s390-pci-inst.c                           |  78 +-
 hw/s390x/s390-pci-vfio.c                           | 276 ++++++
 hw/s390x/s390-virtio-ccw.c                         |   2 +-
 hw/s390x/trace-events                              |   5 +
 hw/vfio/common.c                                   | 508 ++++++++++-
 hw/vfio/meson.build                                |   1 +
 hw/vfio/migration.c                                | 933 +++++++++++++++++++++
 hw/vfio/pci.c                                      |  87 +-
 hw/vfio/pci.h                                      |   1 -
 hw/vfio/platform.c                                 |   7 +-
 hw/vfio/trace-events                               |  21 +
 {hw => include/hw}/s390x/s390-pci-bus.h            |  22 +
 .../hw/s390x/s390-pci-clp.h                        | 123 +--
 include/hw/s390x/s390-pci-inst.h                   | 119 +++
 include/hw/s390x/s390-pci-vfio.h                   |  38 +
 include/hw/vfio/vfio-common.h                      |  30 +
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h        |   2 +-
 include/standard-headers/linux/ethtool.h           |   2 +
 include/standard-headers/linux/fuse.h              |  50 +-
 include/standard-headers/linux/input-event-codes.h |   4 +
 include/standard-headers/linux/pci_regs.h          |   6 +-
 include/standard-headers/linux/virtio_fs.h         |   3 +
 include/standard-headers/linux/virtio_gpu.h        |  19 +
 include/standard-headers/linux/virtio_mmio.h       |  11 +
 include/standard-headers/linux/virtio_pci.h        |  11 +-
 linux-headers/asm-arm64/kvm.h                      |  25 +
 linux-headers/asm-arm64/mman.h                     |   1 +
 linux-headers/asm-generic/hugetlb_encode.h         |   1 +
 linux-headers/asm-generic/unistd.h                 |  18 +-
 linux-headers/asm-mips/unistd_n32.h                |   1 +
 linux-headers/asm-mips/unistd_n64.h                |   1 +
 linux-headers/asm-mips/unistd_o32.h                |   1 +
 linux-headers/asm-powerpc/unistd_32.h              |   1 +
 linux-headers/asm-powerpc/unistd_64.h              |   1 +
 linux-headers/asm-s390/unistd_32.h                 |   1 +
 linux-headers/asm-s390/unistd_64.h                 |   1 +
 linux-headers/asm-x86/kvm.h                        |  20 +
 linux-headers/asm-x86/unistd_32.h                  |   1 +
 linux-headers/asm-x86/unistd_64.h                  |   1 +
 linux-headers/asm-x86/unistd_x32.h                 |   1 +
 linux-headers/linux/kvm.h                          |  19 +
 linux-headers/linux/mman.h                         |   1 +
 linux-headers/linux/vfio.h                         |  29 +-
 linux-headers/linux/vfio_zdev.h                    |  78 ++
 migration/migration.c                              |  17 +
 monitor/hmp-cmds.c                                 |   6 +
 qapi/migration.json                                |  17 +
 scripts/update-linux-headers.sh                    |   2 +-
 softmmu/memory.c                                   |   2 +-
 52 files changed, 2481 insertions(+), 217 deletions(-)
 create mode 100644 hw/s390x/s390-pci-vfio.c
 create mode 100644 hw/vfio/migration.c
 rename {hw => include/hw}/s390x/s390-pci-bus.h (94%)
 rename hw/s390x/s390-pci-inst.h => include/hw/s390x/s390-pci-clp.h (59%)
 create mode 100644 include/hw/s390x/s390-pci-inst.h
 create mode 100644 include/hw/s390x/s390-pci-vfio.h
 create mode 100644 linux-headers/linux/vfio_zdev.h

Changes vs v1:

diff -u b/hw/s390x/meson.build b/hw/s390x/meson.build
--- b/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -10,7 +10,6 @@
   's390-ccw.c',
   's390-pci-bus.c',
   's390-pci-inst.c',
-  's390-pci-vfio.c',
   's390-skeys.c',
   's390-stattrib.c',
   's390-virtio-hcall.c',
@@ -28,6 +27,7 @@
 ))
 s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-ccw.c'))
 s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
+s390x_ss.add(when: 'CONFIG_LINUX', if_true: files('s390-pci-vfio.c'))
 
 virtio_ss = ss.source_set()
 virtio_ss.add(files('virtio-ccw.c'))
diff -u b/hw/vfio/common.c b/hw/vfio/common.c
--- b/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -397,7 +397,8 @@
                    BITS_PER_BYTE;
 
     if (bitmap->size > container->max_dirty_bitmap_size) {
-        error_report("UNMAP: Size of bitmap too big 0x%llx", bitmap->size);
+        error_report("UNMAP: Size of bitmap too big 0x%"PRIx64,
+                     (uint64_t)bitmap->size);
         ret = -E2BIG;
         goto unmap_exit;
     }
@@ -410,7 +411,7 @@
 
     ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
     if (!ret) {
-        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)bitmap->data,
+        cpu_physical_memory_set_dirty_lebitmap((unsigned long *)bitmap->data,
                 iotlb->translated_addr, pages);
     } else {
         error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %m");
@@ -998,13 +999,13 @@
 
     ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
     if (ret) {
-        error_report("Failed to get dirty bitmap for iova: 0x%llx "
-                "size: 0x%llx err: %d",
-                range->iova, range->size, errno);
+        error_report("Failed to get dirty bitmap for iova: 0x%"PRIx64
+                " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
+                (uint64_t)range->size, errno);
         goto err_out;
     }
 
-    cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range->bitmap.data,
+    cpu_physical_memory_set_dirty_lebitmap((unsigned long *)range->bitmap.data,
                                             ram_addr, pages);
 
     trace_vfio_get_dirty_bitmap(container->fd, range->iova, range->size,
diff -u b/hw/vfio/migration.c b/hw/vfio/migration.c
--- b/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -55,8 +55,8 @@
     ret = iswrite ? pwrite(vbasedev->fd, val, count, off) :
                     pread(vbasedev->fd, val, count, off);
     if (ret < count) {
-        error_report("vfio_mig_%s %d byte %s: failed at offset 0x%lx, err: %s",
-                     iswrite ? "write" : "read", count,
+        error_report("vfio_mig_%s %d byte %s: failed at offset 0x%"
+                     HWADDR_PRIx", err: %s", iswrite ? "write" : "read", count,
                      vbasedev->name, off, strerror(errno));
         return (ret < 0) ? ret : -EINVAL;
     }
@@ -734,7 +734,7 @@
     uint32_t value, mask;
     int ret;
 
-    if ((vbasedev->migration->vm_running == running)) {
+    if (vbasedev->migration->vm_running == running) {
         return;
     }
 
diff -u b/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
--- b/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -15,9 +15,24 @@
 #include "hw/s390x/s390-pci-bus.h"
 
+#ifdef CONFIG_LINUX
 bool s390_pci_update_dma_avail(int fd, unsigned int *avail);
 S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
                                           S390PCIBusDevice *pbdev);
 void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
+#else
+static inline bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
+{
+    return false;
+}
+static inline S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
+                                                        S390PCIBusDevice *pbdev)
+{
+    return NULL;
+}
+static inline void s390_pci_end_dma_count(S390pciState *s,
+                                          S390PCIDMACount *cnt) { }
+static inline void s390_pci_get_clp_info(S390PCIBusDevice *pbdev) { }
+#endif
 
 #endif
diff -u b/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
--- b/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -198,8 +198,6 @@
 void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
-bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
-                             unsigned int *avail);
 
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
@@ -216,6 +214,8 @@
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
 struct vfio_info_cap_header *
 vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id);
+bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
+                             unsigned int *avail);
 struct vfio_info_cap_header *
 vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
 #endif


