Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CD5C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C3820767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsH2GvZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C3820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbu3-0004q1-9L
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVi-0005sj-Je
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVg-0000GP-L7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6p9hUMEUii+QrtRAZHxiv7M9kayxspGCtythkhQRiA=;
 b=YsH2GvZLuaj+ZKmQ8/e20LIbYtTfZbVTeTWkH/o2peWCgu+Z9FS+s/KJuOfcgFR66vLbLM
 hAY9yiApdSJjAcz6KR13WRep9LuuPXbcpIb4Ex9NOJUplxRb9CNQgInzfpv25+U6xGZHPB
 n3+NXGzbGPCvK47KqHWsKjlNT++DYO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-rOtJufE2MD2dj8rG8sNKWQ-1; Wed, 02 Sep 2020 18:45:41 -0400
X-MC-Unique: rOtJufE2MD2dj8rG8sNKWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37731801AEA
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:45:40 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2579D7E313;
 Wed,  2 Sep 2020 22:45:37 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 55/63] vfio: Rename PCI_VFIO to VFIO_PCI
Date: Wed,  2 Sep 2020 18:43:03 -0400
Message-Id: <20200902224311.1321159-56-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Alex Williamson <alex.williamson@redhat.com>, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/vfio/pci.h |  2 +-
 hw/vfio/pci.c | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 846d60e56c..5e53d5b863 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,7 +116,7 @@ typedef struct VFIOMSIXInfo {
 
 #define TYPE_VFIO_PCI "vfio-pci"
 typedef struct VFIOPCIDevice VFIOPCIDevice;
-DECLARE_INSTANCE_CHECKER(VFIOPCIDevice, PCI_VFIO,
+DECLARE_INSTANCE_CHECKER(VFIOPCIDevice, VFIO_PCI,
                          TYPE_VFIO_PCI)
 
 struct VFIOPCIDevice {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3611dcd38b..0d83eb0e47 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -230,7 +230,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     PCIINTxRoute route;
 
     if (vdev->interrupt != VFIO_INT_INTx) {
@@ -456,7 +456,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
-    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIOMSIVector *vector;
     int ret;
 
@@ -541,7 +541,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
 
 static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
-    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
@@ -1048,7 +1048,7 @@ static const MemoryRegionOps vfio_vga_ops = {
  */
 static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
-    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIORegion *region = &vdev->bars[bar].region;
     MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
@@ -1094,7 +1094,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
  */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
-    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1127,7 +1127,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
-    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     uint32_t val_le = cpu_to_le32(val);
 
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
@@ -2701,7 +2701,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
 
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
-    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
     char *tmp, *subsys, group_path[PATH_MAX], *group_name;
@@ -3033,7 +3033,7 @@ error:
 
 static void vfio_instance_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = PCI_VFIO(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI(obj);
     VFIOGroup *group = vdev->vbasedev.group;
 
     vfio_display_finalize(vdev);
@@ -3057,7 +3057,7 @@ static void vfio_instance_finalize(Object *obj)
 
 static void vfio_exitfn(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
 
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
@@ -3075,7 +3075,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
 static void vfio_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = PCI_VFIO(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI(dev);
 
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
@@ -3115,7 +3115,7 @@ post_reset:
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = PCI_VFIO(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI(obj);
 
     device_add_bootindex_property(obj, &vdev->bootindex,
                                   "bootindex", NULL,
-- 
2.26.2


