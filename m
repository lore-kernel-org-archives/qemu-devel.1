Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CD720684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5cjbjQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CD720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfNc-0007iO-DS
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjJ-0008Tc-VB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjD-0007wD-8h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdjC-0007vK-Rr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id r1so16440008wrs.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2ljGpKGl/qkz79Gqkva+tRZiiwcaLrJvFEeqtn6BdMA=;
 b=F5cjbjQ1LRxmSUGRqMJ1TCG+liiOegUKzdnB8cDH2YFu4tsgRKSXPnE5q4l/ZaLiMv
 8wqkydtkDCreuiAp09ZnxTdOTYWlS6vH5ygj5ET3/BXFWGv7w8osTq4jTt5HRG9mPizc
 iIYytTFx3BdJx3oYVx3z9Ls/QgndQh4ADWxqk2qsn3wXHZiEIbT0pbziC3e+sRk6SO1C
 FfZn/7sqme16JhLWSCCxIt0wOw2ZJiZedsfgnqDYsaRxOoKLAsEgHg17V/Dg96Kp37pL
 GFeK+i7MQ8ArAlUexj9xJGMev1zryKnv7aA8taQr63Z1U4mNFQQDswrkiNz80OhNNLAg
 504Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=2ljGpKGl/qkz79Gqkva+tRZiiwcaLrJvFEeqtn6BdMA=;
 b=FlvaBTGyNXW4+eTA+9wnwowYTIZzlWwSlpqq0KYkgc4vU6vNliP1+wqM8RxqykO99d
 ewY+KoFS1w6MvYSsptSU6SjZ8h7e4lbXVz8sWkU9+aGqwKDbqlR5VcSJiQrLohIH8Dw7
 U5TncTZAuoQyJoP1iqIEiLUbT6RDYIzdhNxxSfJa3bhXz2dtz4cOMQJsk7tKAkQXglF0
 G0KUCTL7d63Qzr/nVYKnaQAV8b6kvfkFPhls+0v+SEpY3PFPtxRZJf0E2IiKr6iiL6aE
 XNs/aqOw+onLctcUJWaUUGU8j1J1yOrTh9fRo9dloqXk6WIeiwUJzi6B9nBozWqllk6q
 EvYQ==
X-Gm-Message-State: APjAAAXtO77SB8D97wb1Ji/nZ5c3FUE6m4rDWqXkgDCv48FRBBuC0t0a
 ONPSM5Gq1WXZMF21T30t9I9Ml8DH
X-Google-Smtp-Source: APXvYqxT+6ktJB1OVVyDUZG/geo5/MSM8uoDjGWrA+GdNFJpxPlwsKJbwW87EmxTDQN/8LVMFVEZ4A==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr4056875wrn.57.1571925877164;
 Thu, 24 Oct 2019 07:04:37 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/39] core: replace getpagesize() with qemu_real_host_page_size
Date: Thu, 24 Oct 2019 16:03:52 +0200
Message-Id: <1571925835-31930-37-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

There are three page size in qemu:

  real host page size
  host page size
  target page size

All of them have dedicate variable to represent. For the last two, we
use the same form in the whole qemu project, while for the first one we
use two forms: qemu_real_host_page_size and getpagesize().

qemu_real_host_page_size is defined to be a replacement of
getpagesize(), so let it serve the role.

[Note] Not fully tested for some arch or device.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20191013021145.16011-3-richardw.yang@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c            |  6 +++---
 backends/hostmem.c             |  2 +-
 block.c                        |  4 ++--
 block/file-posix.c             |  9 +++++----
 block/io.c                     |  2 +-
 block/parallels.c              |  2 +-
 block/qcow2-cache.c            |  2 +-
 contrib/vhost-user-gpu/vugbm.c |  2 +-
 exec.c                         |  6 +++---
 hw/intc/s390_flic_kvm.c        |  2 +-
 hw/ppc/mac_newworld.c          |  2 +-
 hw/ppc/spapr_pci.c             |  2 +-
 hw/rdma/vmw/pvrdma_main.c      |  2 +-
 hw/vfio/spapr.c                |  7 ++++---
 include/exec/ram_addr.h        |  2 +-
 include/qemu/osdep.h           |  4 ++--
 migration/migration.c          |  2 +-
 migration/postcopy-ram.c       |  4 ++--
 monitor/misc.c                 |  2 +-
 target/ppc/kvm.c               |  2 +-
 tests/vhost-user-bridge.c      |  8 ++++----
 util/mmap-alloc.c              | 10 +++++-----
 util/oslib-posix.c             |  4 ++--
 util/oslib-win32.c             |  2 +-
 util/vfio-helpers.c            | 12 ++++++------
 25 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d2d96d7..140b0bd 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -52,7 +52,7 @@
 /* KVM uses PAGE_SIZE in its definition of KVM_COALESCED_MMIO_MAX. We
  * need to use the real host PAGE_SIZE, as that's what KVM will use.
  */
-#define PAGE_SIZE getpagesize()
+#define PAGE_SIZE qemu_real_host_page_size
 
 //#define DEBUG_KVM
 
@@ -507,7 +507,7 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
 {
     ram_addr_t start = section->offset_within_region +
                        memory_region_get_ram_addr(section->mr);
-    ram_addr_t pages = int128_get64(section->size) / getpagesize();
+    ram_addr_t pages = int128_get64(section->size) / qemu_real_host_page_size;
 
     cpu_physical_memory_set_dirty_lebitmap(bitmap, start, pages);
     return 0;
@@ -1841,7 +1841,7 @@ static int kvm_init(MachineState *ms)
      * even with KVM.  TARGET_PAGE_SIZE is assumed to be the minimum
      * page size for the system though.
      */
-    assert(TARGET_PAGE_SIZE <= getpagesize());
+    assert(TARGET_PAGE_SIZE <= qemu_real_host_page_size);
 
     s->sigmask_len = 8;
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 6d333dc..e773bdf 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -304,7 +304,7 @@ size_t host_memory_backend_pagesize(HostMemoryBackend *memdev)
 #else
 size_t host_memory_backend_pagesize(HostMemoryBackend *memdev)
 {
-    return getpagesize();
+    return qemu_real_host_page_size;
 }
 #endif
 
diff --git a/block.c b/block.c
index dad5a3d..4cffc2b 100644
--- a/block.c
+++ b/block.c
@@ -106,7 +106,7 @@ size_t bdrv_opt_mem_align(BlockDriverState *bs)
 {
     if (!bs || !bs->drv) {
         /* page size or 4k (hdd sector size) should be on the safe side */
-        return MAX(4096, getpagesize());
+        return MAX(4096, qemu_real_host_page_size);
     }
 
     return bs->bl.opt_mem_alignment;
@@ -116,7 +116,7 @@ size_t bdrv_min_mem_align(BlockDriverState *bs)
 {
     if (!bs || !bs->drv) {
         /* page size or 4k (hdd sector size) should be on the safe side */
-        return MAX(4096, getpagesize());
+        return MAX(4096, qemu_real_host_page_size);
     }
 
     return bs->bl.min_mem_alignment;
diff --git a/block/file-posix.c b/block/file-posix.c
index 695fcf7..5d1995a 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -327,7 +327,7 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     char *buf;
-    size_t max_align = MAX(MAX_BLOCKSIZE, getpagesize());
+    size_t max_align = MAX(MAX_BLOCKSIZE, qemu_real_host_page_size);
     size_t alignments[] = {1, 512, 1024, 2048, 4096};
 
     /* For SCSI generic devices the alignment is not really used.
@@ -1136,13 +1136,14 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 
         ret = sg_get_max_segments(s->fd);
         if (ret > 0) {
-            bs->bl.max_transfer = MIN(bs->bl.max_transfer, ret * getpagesize());
+            bs->bl.max_transfer = MIN(bs->bl.max_transfer,
+                                      ret * qemu_real_host_page_size);
         }
     }
 
     raw_probe_alignment(bs, s->fd, errp);
     bs->bl.min_mem_alignment = s->buf_align;
-    bs->bl.opt_mem_alignment = MAX(s->buf_align, getpagesize());
+    bs->bl.opt_mem_alignment = MAX(s->buf_align, qemu_real_host_page_size);
 }
 
 static int check_for_dasd(int fd)
@@ -1705,7 +1706,7 @@ static int allocate_first_block(int fd, size_t max_size)
     size_t write_size = (max_size < MAX_BLOCKSIZE)
         ? BDRV_SECTOR_SIZE
         : MAX_BLOCKSIZE;
-    size_t max_align = MAX(MAX_BLOCKSIZE, getpagesize());
+    size_t max_align = MAX(MAX_BLOCKSIZE, qemu_real_host_page_size);
     void *buf;
     ssize_t n;
     int ret;
diff --git a/block/io.c b/block/io.c
index f0b86c1..e46d9e8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -160,7 +160,7 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
         bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
     } else {
         bs->bl.min_mem_alignment = 512;
-        bs->bl.opt_mem_alignment = getpagesize();
+        bs->bl.opt_mem_alignment = qemu_real_host_page_size;
 
         /* Safe default since most protocols use readv()/writev()/etc */
         bs->bl.max_iov = IOV_MAX;
diff --git a/block/parallels.c b/block/parallels.c
index 7cd2714..f1dfb03 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -847,7 +847,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    s->bat_dirty_block = 4 * getpagesize();
+    s->bat_dirty_block = 4 * qemu_real_host_page_size;
     s->bat_dirty_bmap =
         bitmap_new(DIV_ROUND_UP(s->header_size, s->bat_dirty_block));
 
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index d29b038..7444b9c 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -74,7 +74,7 @@ static void qcow2_cache_table_release(Qcow2Cache *c, int i, int num_tables)
 /* Using MADV_DONTNEED to discard memory is a Linux-specific feature */
 #ifdef CONFIG_LINUX
     void *t = qcow2_cache_get_table_addr(c, i);
-    int align = getpagesize();
+    int align = qemu_real_host_page_size;
     size_t mem_size = (size_t) c->table_size * num_tables;
     size_t offset = QEMU_ALIGN_UP((uintptr_t) t, align) - (uintptr_t) t;
     size_t length = QEMU_ALIGN_DOWN(mem_size - offset, align);
diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vugbm.c
index d3bb82f..9c357b6 100644
--- a/contrib/vhost-user-gpu/vugbm.c
+++ b/contrib/vhost-user-gpu/vugbm.c
@@ -52,7 +52,7 @@ struct udmabuf_create {
 static size_t
 udmabuf_get_size(struct vugbm_buffer *buf)
 {
-    return ROUND_UP(buf->width * buf->height * 4, getpagesize());
+    return ROUND_UP(buf->width * buf->height * 4, qemu_real_host_page_size);
 }
 
 static bool
diff --git a/exec.c b/exec.c
index fb0943c..9fc0d01 100644
--- a/exec.c
+++ b/exec.c
@@ -1756,11 +1756,11 @@ long qemu_maxrampagesize(void)
 #else
 long qemu_minrampagesize(void)
 {
-    return getpagesize();
+    return qemu_real_host_page_size;
 }
 long qemu_maxrampagesize(void)
 {
-    return getpagesize();
+    return qemu_real_host_page_size;
 }
 #endif
 
@@ -2417,7 +2417,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     assert(max_size >= size);
     new_block->fd = -1;
-    new_block->page_size = getpagesize();
+    new_block->page_size = qemu_real_host_page_size;
     new_block->host = host;
     if (host) {
         new_block->flags |= RAM_PREALLOC;
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index cedccba..c9ee80e 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -25,7 +25,7 @@
 #include "migration/qemu-file-types.h"
 #include "trace.h"
 
-#define FLIC_SAVE_INITIAL_SIZE getpagesize()
+#define FLIC_SAVE_INITIAL_SIZE qemu_real_host_page_size
 #define FLIC_FAILED (-1UL)
 #define FLIC_SAVEVM_VERSION 1
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index c5bbcc7..3594517 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -439,7 +439,7 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     /* The NewWorld NVRAM is not located in the MacIO device */
-    if (kvm_enabled() && getpagesize() > 4096) {
+    if (kvm_enabled() && qemu_real_host_page_size > 4096) {
         /* We can't combine read-write and read-only in a single page, so
            move the NVRAM out of ROM again for KVM */
         nvram_addr = 0xFFE00000;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 01ff41d..191b295 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1942,7 +1942,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
      * our memory slot is of page size granularity.
      */
     if (kvm_enabled()) {
-        msi_window_size = getpagesize();
+        msi_window_size = qemu_real_host_page_size;
     }
 
     memory_region_init_io(&sphb->msiwindow, OBJECT(sphb), &spapr_msi_ops, spapr,
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 3e36e13..3722d9e 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -601,7 +601,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     rdma_info_report("Initializing device %s %x.%x", pdev->name,
                      PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
 
-    if (TARGET_PAGE_SIZE != getpagesize()) {
+    if (TARGET_PAGE_SIZE != qemu_real_host_page_size) {
         error_setg(errp, "Target page size must be the same as host page size");
         return;
     }
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index e853eeb..33692fc 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -196,14 +196,15 @@ int vfio_spapr_create_window(VFIOContainer *container,
      * bits_per_level is a safe guess of how much we can allocate per level:
      * 8 is the current minimum for CONFIG_FORCE_MAX_ZONEORDER and MAX_ORDER
      * is usually bigger than that.
-     * Below we look at getpagesize() as TCEs are allocated from system pages.
+     * Below we look at qemu_real_host_page_size as TCEs are allocated from
+     * system pages.
      */
-    bits_per_level = ctz64(getpagesize()) + 8;
+    bits_per_level = ctz64(qemu_real_host_page_size) + 8;
     create.levels = bits_total / bits_per_level;
     if (bits_total % bits_per_level) {
         ++create.levels;
     }
-    max_levels = (64 - create.page_shift) / ctz64(getpagesize());
+    max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size);
     for ( ; create.levels <= max_levels; ++create.levels) {
         ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
         if (!ret) {
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index ad158bb..bed0554 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -373,7 +373,7 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
     hwaddr addr;
     ram_addr_t ram_addr;
     unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
-    unsigned long hpratio = getpagesize() / TARGET_PAGE_SIZE;
+    unsigned long hpratio = qemu_real_host_page_size / TARGET_PAGE_SIZE;
     unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
 
     /* start address is aligned at the start of a word? */
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index c7d242f..0f97d68 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -423,9 +423,9 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #  define QEMU_VMALLOC_ALIGN (256 * 4096)
 #elif defined(__linux__) && defined(__sparc__)
 #include <sys/shm.h>
-#  define QEMU_VMALLOC_ALIGN MAX(getpagesize(), SHMLBA)
+#  define QEMU_VMALLOC_ALIGN MAX(qemu_real_host_page_size, SHMLBA)
 #else
-#  define QEMU_VMALLOC_ALIGN getpagesize()
+#  define QEMU_VMALLOC_ALIGN qemu_real_host_page_size
 #endif
 
 #ifdef CONFIG_POSIX
diff --git a/migration/migration.c b/migration/migration.c
index 3febd0f..4133ed2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2284,7 +2284,7 @@ static struct rp_cmd_args {
 static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
                                        ram_addr_t start, size_t len)
 {
-    long our_host_ps = getpagesize();
+    long our_host_ps = qemu_real_host_page_size;
 
     trace_migrate_handle_rp_req_pages(rbname, start, len);
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index abccafc..a364027 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -308,7 +308,7 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
         return false;
     }
 
-    if (getpagesize() != ram_pagesize_summary()) {
+    if (qemu_real_host_page_size != ram_pagesize_summary()) {
         bool have_hp = false;
         /* We've got a huge page */
 #ifdef UFFD_FEATURE_MISSING_HUGETLBFS
@@ -346,7 +346,7 @@ static int test_ramblock_postcopiable(RAMBlock *rb, void *opaque)
  */
 bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
 {
-    long pagesize = getpagesize();
+    long pagesize = qemu_real_host_page_size;
     int ufd = -1;
     bool ret = false; /* Error unless we change it */
     void *testarea = NULL;
diff --git a/monitor/misc.c b/monitor/misc.c
index aef16f6..3baa15f 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -862,7 +862,7 @@ static uint64_t vtop(void *ptr, Error **errp)
     uint64_t pinfo;
     uint64_t ret = -1;
     uintptr_t addr = (uintptr_t) ptr;
-    uintptr_t pagesize = getpagesize();
+    uintptr_t pagesize = qemu_real_host_page_size;
     off_t offset = addr / pagesize * sizeof(pinfo);
     int fd;
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 820724c..7d2e896 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -411,7 +411,7 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
          * will be a normal mapping, not a special hugepage one used
          * for RAM.
          */
-        if (getpagesize() < 0x10000) {
+        if (qemu_real_host_page_size < 0x10000) {
             error_setg(errp,
                        "KVM can't supply 64kiB CI pages, which guest expects");
         }
diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index c4e350e..6c3d490 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -468,8 +468,8 @@ vubr_queue_set_started(VuDev *dev, int qidx, bool started)
 
     if (started && vubr->notifier.fd >= 0) {
         vu_set_queue_host_notifier(dev, vq, vubr->notifier.fd,
-                                   getpagesize(),
-                                   qidx * getpagesize());
+                                   qemu_real_host_page_size,
+                                   qidx * qemu_real_host_page_size);
     }
 
     if (qidx % 2 == 1) {
@@ -594,7 +594,7 @@ static void *notifier_thread(void *arg)
 {
     VuDev *dev = (VuDev *)arg;
     VubrDev *vubr = container_of(dev, VubrDev, vudev);
-    int pagesize = getpagesize();
+    int pagesize = qemu_real_host_page_size;
     int qidx;
 
     while (true) {
@@ -630,7 +630,7 @@ vubr_host_notifier_setup(VubrDev *dev)
     void *addr;
     int fd;
 
-    length = getpagesize() * VHOST_USER_BRIDGE_MAX_QUEUES;
+    length = qemu_real_host_page_size * VHOST_USER_BRIDGE_MAX_QUEUES;
 
     fd = mkstemp(template);
     if (fd < 0) {
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index f7f177d..27dcccd 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -48,7 +48,7 @@ size_t qemu_fd_getpagesize(int fd)
 #endif
 #endif
 
-    return getpagesize();
+    return qemu_real_host_page_size;
 }
 
 size_t qemu_mempath_getpagesize(const char *mem_path)
@@ -79,7 +79,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
 #endif
 #endif
 
-    return getpagesize();
+    return qemu_real_host_page_size;
 }
 
 void *qemu_ram_mmap(int fd,
@@ -114,7 +114,7 @@ void *qemu_ram_mmap(int fd,
      */
     flags = MAP_PRIVATE;
     pagesize = qemu_fd_getpagesize(fd);
-    if (fd == -1 || pagesize == getpagesize()) {
+    if (fd == -1 || pagesize == qemu_real_host_page_size) {
         guardfd = -1;
         flags |= MAP_ANONYMOUS;
     } else {
@@ -123,7 +123,7 @@ void *qemu_ram_mmap(int fd,
     }
 #else
     guardfd = -1;
-    pagesize = getpagesize();
+    pagesize = qemu_real_host_page_size;
     flags = MAP_PRIVATE | MAP_ANONYMOUS;
 #endif
 
@@ -205,7 +205,7 @@ void qemu_ram_munmap(int fd, void *ptr, size_t size)
 #if defined(__powerpc64__) && defined(__linux__)
         pagesize = qemu_fd_getpagesize(fd);
 #else
-        pagesize = getpagesize();
+        pagesize = qemu_real_host_page_size;
 #endif
         munmap(ptr, size + pagesize);
     }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f869338..5a291cc 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -617,7 +617,7 @@ void *qemu_alloc_stack(size_t *sz)
 #ifdef CONFIG_DEBUG_STACK_USAGE
     void *ptr2;
 #endif
-    size_t pagesz = getpagesize();
+    size_t pagesz = qemu_real_host_page_size;
 #ifdef _SC_THREAD_STACK_MIN
     /* avoid stacks smaller than _SC_THREAD_STACK_MIN */
     long min_stack_sz = sysconf(_SC_THREAD_STACK_MIN);
@@ -679,7 +679,7 @@ void qemu_free_stack(void *stack, size_t sz)
     unsigned int usage;
     void *ptr;
 
-    for (ptr = stack + getpagesize(); ptr < stack + sz;
+    for (ptr = stack + qemu_real_host_page_size; ptr < stack + sz;
          ptr += sizeof(uint32_t)) {
         if (*(uint32_t *)ptr != 0xdeadbeaf) {
             break;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 886e400..e9b14ab 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -554,7 +554,7 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
                      Error **errp)
 {
     int i;
-    size_t pagesize = getpagesize();
+    size_t pagesize = qemu_real_host_page_size;
 
     memory = (memory + pagesize - 1) & -pagesize;
     for (i = 0; i < memory / pagesize; i++) {
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 26ffd0d..813f7ec 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -514,9 +514,9 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
     IOVAMapping m = {.host = host, .size = size, .iova = iova};
     IOVAMapping *insert;
 
-    assert(QEMU_IS_ALIGNED(size, getpagesize()));
-    assert(QEMU_IS_ALIGNED(s->low_water_mark, getpagesize()));
-    assert(QEMU_IS_ALIGNED(s->high_water_mark, getpagesize()));
+    assert(QEMU_IS_ALIGNED(size, qemu_real_host_page_size));
+    assert(QEMU_IS_ALIGNED(s->low_water_mark, qemu_real_host_page_size));
+    assert(QEMU_IS_ALIGNED(s->high_water_mark, qemu_real_host_page_size));
     trace_qemu_vfio_new_mapping(s, host, size, index, iova);
 
     assert(index >= 0);
@@ -567,7 +567,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping,
 
     index = mapping - s->mappings;
     assert(mapping->size > 0);
-    assert(QEMU_IS_ALIGNED(mapping->size, getpagesize()));
+    assert(QEMU_IS_ALIGNED(mapping->size, qemu_real_host_page_size));
     assert(index >= 0 && index < s->nr_mappings);
     if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
         error_setg(errp, "VFIO_UNMAP_DMA failed: %d", -errno);
@@ -613,8 +613,8 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
     IOVAMapping *mapping;
     uint64_t iova0;
 
-    assert(QEMU_PTR_IS_ALIGNED(host, getpagesize()));
-    assert(QEMU_IS_ALIGNED(size, getpagesize()));
+    assert(QEMU_PTR_IS_ALIGNED(host, qemu_real_host_page_size));
+    assert(QEMU_IS_ALIGNED(size, qemu_real_host_page_size));
     trace_qemu_vfio_dma_map(s, host, size, temporary, iova);
     qemu_mutex_lock(&s->lock);
     mapping = qemu_vfio_find_mapping(s, host, &index);
-- 
1.8.3.1



