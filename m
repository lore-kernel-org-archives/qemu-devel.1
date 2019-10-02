Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44877C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C3D21848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi1fS/dS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C3D21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFiHU-0000Gy-O0
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrV-0005f3-7g
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrT-0003aF-Aa
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrT-0003Xn-2x
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id r3so20517875wrj.6
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Mr658lAKnetL+4KX58LnRrlMr3PsH5dvajSAOIiuU0c=;
 b=Fi1fS/dSk+Ct64Pu1u/0uDED35uKMd7fQDSP0JcqYXiBEBXCkhMZJD03pUC2JEOu7Z
 brpyLqrtfu//xyALzO4olEClzi92feTtufBLyam65l4idIuIH1OtaN/TjDsCgBOkXycp
 mK/n7NJQ7StiVD7XHvXl0TMKULdJtRqe0hgO4EZxdR/XmxbjKfZ2v87A74+6cSj63SMo
 IY2SAvfQKoOaVytjbynM01+Vn6D4ytatJsZbx+7GmHNOhop1AGXh+uR/oLXeLPn2TBQq
 aWp3B1T+DF1dqd5MBu6SVfTfDV7iFWdR+pWK7BIK8aiXy7ZVfyB9LjXMwT0eQyYhot5s
 W4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Mr658lAKnetL+4KX58LnRrlMr3PsH5dvajSAOIiuU0c=;
 b=ovdjonip9oL1FTSWQcnl8hTKDYVfLG9Q/W6ta9FavJHb2sWEN4GRhdqaYhNYoDWURv
 lKBdMWFY88MMK2/MlfASE+mudDlwUdoappMUUu1DmCJbYbW1VD/LI0xNadvzVAtfPA9c
 P7ZOkX8ydvCUlsQDdcQuNO73nVcNCsGZgcRERSFdCThjidPvgiiDXrni50LqVR1KAgDp
 I2xxnyNwoV2xYHqEItsi0h26ps1vc/4I5iDU0lv9XcSogsrxaEFv53USI6JQX4Tr0vJn
 yrX5hpAeDYvhFQPZ2idka7A5Rou77w5oWxn+gpxmBH/PPhhBX8Hi9V+bGwurhSaB8X0K
 hy5Q==
X-Gm-Message-State: APjAAAX0wR8bEuDYA+SzSJ/p8eE51OKv56Fdv7MhKusGiHtTnS2/0koo
 nzpc7icse5Mz5i69/K1zHwG+9dp/
X-Google-Smtp-Source: APXvYqxhqEu45mg+p0BrIpUqZ2eIqark9vHanfj2pF132u1sIRe7YteCDnSlbwWOqUXpaKZpaztiqw==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr3421856wrv.240.1570035139956; 
 Wed, 02 Oct 2019 09:52:19 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/30] memory: allow memory_region_register_iommu_notifier() to
 fail
Date: Wed,  2 Oct 2019 18:51:47 +0200
Message-Id: <1570035113-56848-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
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
Cc: Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Currently, when a notifier is attempted to be registered and its
flags are not supported (especially the MAP one) by the IOMMU MR,
we generally abruptly exit in the IOMMU code. The failure could be
handled more nicely in the caller and especially in the VFIO code.

So let's allow memory_region_register_iommu_notifier() to fail as
well as notify_flag_changed() callback.

All sites implementing the callback are updated. This patch does
not yet remove the exit(1) in the amd_iommu code.

in SMMUv3 we turn the warning message into an error message saying
that the assigned device would not work properly.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                | 10 ++++++++--
 hw/arm/smmuv3.c       | 18 ++++++++++--------
 hw/i386/amd_iommu.c   | 17 ++++++++++-------
 hw/i386/intel_iommu.c |  8 +++++---
 hw/ppc/spapr_iommu.c  |  8 +++++---
 hw/vfio/common.c      |  9 +++++++--
 hw/virtio/vhost.c     |  9 +++++++--
 include/exec/memory.h | 21 ++++++++++++++++-----
 memory.c              | 31 ++++++++++++++++++++-----------
 9 files changed, 88 insertions(+), 43 deletions(-)

diff --git a/exec.c b/exec.c
index 1d6e4d8..bdcfcdf 100644
--- a/exec.c
+++ b/exec.c
@@ -660,7 +660,8 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
      */
     MemoryRegion *mr = MEMORY_REGION(iommu_mr);
     TCGIOMMUNotifier *notifier;
-    int i;
+    Error *err = NULL;
+    int i, ret;
 
     for (i = 0; i < cpu->iommu_notifiers->len; i++) {
         notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
@@ -689,7 +690,12 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
                             0,
                             HWADDR_MAX,
                             iommu_idx);
-        memory_region_register_iommu_notifier(notifier->mr, &notifier->n);
+        ret = memory_region_register_iommu_notifier(notifier->mr, &notifier->n,
+                                                    &err);
+        if (ret) {
+            error_report_err(err);
+            exit(1);
+        }
     }
 
     if (!notifier->active) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index db051dc..e2fbb83 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1469,20 +1469,21 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
     dc->realize = smmu_realize;
 }
 
-static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                       IOMMUNotifierFlag old,
-                                       IOMMUNotifierFlag new)
+static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
+                                      IOMMUNotifierFlag old,
+                                      IOMMUNotifierFlag new,
+                                      Error **errp)
 {
     SMMUDevice *sdev = container_of(iommu, SMMUDevice, iommu);
     SMMUv3State *s3 = sdev->smmu;
     SMMUState *s = &(s3->smmu_state);
 
     if (new & IOMMU_NOTIFIER_MAP) {
-        int bus_num = pci_bus_num(sdev->bus);
-        PCIDevice *pcidev = pci_find_device(sdev->bus, bus_num, sdev->devfn);
-
-        warn_report("SMMUv3 does not support notification on MAP: "
-                     "device %s will not function properly", pcidev->name);
+        error_setg(errp,
+                   "device %02x.%02x.%x requires iommu MAP notifier which is "
+                   "not currently supported", pci_bus_num(sdev->bus),
+                   PCI_SLOT(sdev->devfn), PCI_FUNC(sdev->devfn));
+        return -EINVAL;
     }
 
     if (old == IOMMU_NOTIFIER_NONE) {
@@ -1492,6 +1493,7 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
         trace_smmuv3_notify_flag_del(iommu->parent_obj.name);
         QLIST_REMOVE(sdev, next);
     }
+    return 0;
 }
 
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0888452..d372636 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1466,18 +1466,21 @@ static const MemoryRegionOps mmio_mem_ops = {
     }
 };
 
-static void amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                            IOMMUNotifierFlag old,
-                                            IOMMUNotifierFlag new)
+static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
+                                           IOMMUNotifierFlag old,
+                                           IOMMUNotifierFlag new,
+                                           Error **errp)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
 
     if (new & IOMMU_NOTIFIER_MAP) {
-        error_report("device %02x.%02x.%x requires iommu notifier which is not "
-                     "currently supported", as->bus_num, PCI_SLOT(as->devfn),
-                     PCI_FUNC(as->devfn));
-        exit(1);
+        error_setg(errp,
+                   "device %02x.%02x.%x requires iommu notifier which is not "
+                   "currently supported", as->bus_num, PCI_SLOT(as->devfn),
+                   PCI_FUNC(as->devfn));
+        return -EINVAL;
     }
+    return 0;
 }
 
 static void amdvi_init(AMDVIState *s)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f1de8fd..771bed2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2929,9 +2929,10 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     return iotlb;
 }
 
-static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                          IOMMUNotifierFlag old,
-                                          IOMMUNotifierFlag new)
+static int vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
+                                         IOMMUNotifierFlag old,
+                                         IOMMUNotifierFlag new,
+                                         Error **errp)
 {
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
@@ -2944,6 +2945,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     } else if (new == IOMMU_NOTIFIER_NONE) {
         QLIST_REMOVE(vtd_as, next);
     }
+    return 0;
 }
 
 static int vtd_post_load(void *opaque, int version_id)
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index e87b3d5..3d3bcc8 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -205,9 +205,10 @@ static int spapr_tce_get_attr(IOMMUMemoryRegion *iommu,
     return -EINVAL;
 }
 
-static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                          IOMMUNotifierFlag old,
-                                          IOMMUNotifierFlag new)
+static int spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
+                                         IOMMUNotifierFlag old,
+                                         IOMMUNotifierFlag new,
+                                         Error **errp)
 {
     struct SpaprTceTable *tbl = container_of(iommu, SpaprTceTable, iommu);
 
@@ -216,6 +217,7 @@ static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
     } else if (old != IOMMU_NOTIFIER_NONE && new == IOMMU_NOTIFIER_NONE) {
         spapr_tce_set_need_vfio(tbl, false);
     }
+    return 0;
 }
 
 static int spapr_tce_table_post_load(void *opaque, int version_id)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index cebbb1c..5ca1148 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -636,9 +636,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
                             section->offset_within_region,
                             int128_get64(llend),
                             iommu_idx);
-        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
-        memory_region_register_iommu_notifier(section->mr, &giommu->n);
+        ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
+                                                    &err);
+        if (ret) {
+            g_free(giommu);
+            goto fail;
+        }
+        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
         memory_region_iommu_replay(giommu->iommu, &giommu->n);
 
         return;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2386b51..99de5f1 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -677,8 +677,9 @@ static void vhost_iommu_region_add(MemoryListener *listener,
                                          iommu_listener);
     struct vhost_iommu *iommu;
     Int128 end;
-    int iommu_idx;
+    int iommu_idx, ret;
     IOMMUMemoryRegion *iommu_mr;
+    Error *err = NULL;
 
     if (!memory_region_is_iommu(section->mr)) {
         return;
@@ -701,7 +702,11 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     iommu->iommu_offset = section->offset_within_address_space -
                           section->offset_within_region;
     iommu->hdev = dev;
-    memory_region_register_iommu_notifier(section->mr, &iommu->n);
+    ret = memory_region_register_iommu_notifier(section->mr, &iommu->n, &err);
+    if (ret) {
+        error_report_err(err);
+        exit(1);
+    }
     QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
     /* TODO: can replay help performance here? */
 }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6e67043..e499dc2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -288,10 +288,16 @@ typedef struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      * @old_flags: events which previously needed to be notified
      * @new_flags: events which now need to be notified
+     *
+     * Returns 0 on success, or a negative errno; in particular
+     * returns -EINVAL if the new flag bitmap is not supported by the
+     * IOMMU memory region. In case of failure, the error object
+     * must be created
      */
-    void (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
-                                IOMMUNotifierFlag old_flags,
-                                IOMMUNotifierFlag new_flags);
+    int (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
+                               IOMMUNotifierFlag old_flags,
+                               IOMMUNotifierFlag new_flags,
+                               Error **errp);
     /* Called to handle memory_region_iommu_replay().
      *
      * The default implementation of memory_region_iommu_replay() is to
@@ -1079,13 +1085,18 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
  * memory_region_register_iommu_notifier: register a notifier for changes to
  * IOMMU translation entries.
  *
+ * Returns 0 on success, or a negative errno otherwise. In particular,
+ * -EINVAL indicates that at least one of the attributes of the notifier
+ * is not supported (flag/range) by the IOMMU memory region. In case of error
+ * the error object must be created.
+ *
  * @mr: the memory region to observe
  * @n: the IOMMUNotifier to be added; the notify callback receives a
  *     pointer to an #IOMMUTLBEntry as the opaque value; the pointer
  *     ceases to be valid on exit from the notifier.
  */
-void memory_region_register_iommu_notifier(MemoryRegion *mr,
-                                           IOMMUNotifier *n);
+int memory_region_register_iommu_notifier(MemoryRegion *mr,
+                                          IOMMUNotifier *n, Error **errp);
 
 /**
  * memory_region_iommu_replay: replay existing IOMMU translations to
diff --git a/memory.c b/memory.c
index a99b8c0..978da3d 100644
--- a/memory.c
+++ b/memory.c
@@ -1817,33 +1817,38 @@ bool memory_region_is_logging(MemoryRegion *mr, uint8_t client)
     return memory_region_get_dirty_log_mask(mr) & (1 << client);
 }
 
-static void memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr)
+static int memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr,
+                                                   Error **errp)
 {
     IOMMUNotifierFlag flags = IOMMU_NOTIFIER_NONE;
     IOMMUNotifier *iommu_notifier;
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+    int ret = 0;
 
     IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
         flags |= iommu_notifier->notifier_flags;
     }
 
     if (flags != iommu_mr->iommu_notify_flags && imrc->notify_flag_changed) {
-        imrc->notify_flag_changed(iommu_mr,
-                                  iommu_mr->iommu_notify_flags,
-                                  flags);
+        ret = imrc->notify_flag_changed(iommu_mr,
+                                        iommu_mr->iommu_notify_flags,
+                                        flags, errp);
     }
 
-    iommu_mr->iommu_notify_flags = flags;
+    if (!ret) {
+        iommu_mr->iommu_notify_flags = flags;
+    }
+    return ret;
 }
 
-void memory_region_register_iommu_notifier(MemoryRegion *mr,
-                                           IOMMUNotifier *n)
+int memory_region_register_iommu_notifier(MemoryRegion *mr,
+                                          IOMMUNotifier *n, Error **errp)
 {
     IOMMUMemoryRegion *iommu_mr;
+    int ret;
 
     if (mr->alias) {
-        memory_region_register_iommu_notifier(mr->alias, n);
-        return;
+        return memory_region_register_iommu_notifier(mr->alias, n, errp);
     }
 
     /* We need to register for at least one bitfield */
@@ -1854,7 +1859,11 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
            n->iommu_idx < memory_region_iommu_num_indexes(iommu_mr));
 
     QLIST_INSERT_HEAD(&iommu_mr->iommu_notify, n, node);
-    memory_region_update_iommu_notify_flags(iommu_mr);
+    ret = memory_region_update_iommu_notify_flags(iommu_mr, errp);
+    if (ret) {
+        QLIST_REMOVE(n, node);
+    }
+    return ret;
 }
 
 uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_mr)
@@ -1907,7 +1916,7 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
     }
     QLIST_REMOVE(n, node);
     iommu_mr = IOMMU_MEMORY_REGION(mr);
-    memory_region_update_iommu_notify_flags(iommu_mr);
+    memory_region_update_iommu_notify_flags(iommu_mr, NULL);
 }
 
 void memory_region_notify_one(IOMMUNotifier *notifier,
-- 
1.8.3.1



