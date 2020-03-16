Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7E8C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816D5206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvSXoLGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816D5206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxO7-0002zz-J5
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH2-0002T7-Er
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxGz-0000MW-Sn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxGz-0000Fl-Ls
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dm/EuTkxE9RqTe8WAQAMKzeZ4YbmePbXoehbDlbCm2s=;
 b=VvSXoLGmY+KUnwYfpL5S3VRb6RZEVl8r5rMg7YyIXKeEnieqLP7NeRgFDdgfxGYAkLrIFe
 TEWVGd82Pro0+QJSEuzEnKlRKqe5s4oV7NIo+KCDpG/kBEwJTsuBXdF5P4fgR/AK8HKdYp
 wW2a1aNNBO8GEiBq27ZPc4s4vgMBHvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-BZV9f3uZO_SCSHHcizkwYw-1; Mon, 16 Mar 2020 17:27:39 -0400
X-MC-Unique: BZV9f3uZO_SCSHHcizkwYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BC41107ACC7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:27:38 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B33E19756;
 Mon, 16 Mar 2020 21:27:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/61] misc: Replace zero-length arrays with flexible array
 member (automatic)
Date: Mon, 16 Mar 2020 22:26:30 +0100
Message-Id: <1584394048-44994-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Description copied from Linux kernel commit from Gustavo A. R. Silva
(see [3]):

--v-- description start --v--

  The current codebase makes use of the zero-length array language
  extension to the C90 standard, but the preferred mechanism to
  declare variable-length types such as these ones is a flexible
  array member [1], introduced in C99:

  struct foo {
      int stuff;
      struct boo array[];
  };

  By making use of the mechanism above, we will get a compiler
  warning in case the flexible array does not occur last in the
  structure, which will help us prevent some kind of undefined
  behavior bugs from being unadvertenly introduced [2] to the
  Linux codebase from now on.

--^-- description end --^--

Do the similar housekeeping in the QEMU codebase (which uses
C99 since commit 7be41675f7cb).

All these instances of code were found with the help of the
following Coccinelle script:

  @@
  identifier s, m, a;
  type t, T;
  @@
   struct s {
      ...
      t m;
  -   T a[0];
  +   T a[];
  };
  @@
  identifier s, m, a;
  type t, T;
  @@
   struct s {
      ...
      t m;
  -   T a[0];
  +   T a[];
   } QEMU_PACKED;

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D76497732932f
[3] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/co=
mmit/?id=3D17642a2fbd2c1

Inspired-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/linux-aio.c                     |  2 +-
 bsd-user/qemu.h                       |  2 +-
 contrib/libvhost-user/libvhost-user.h |  2 +-
 hw/acpi/nvdimm.c                      |  6 +++---
 hw/dma/soc_dma.c                      |  2 +-
 hw/i386/x86.c                         |  2 +-
 hw/m68k/bootinfo.h                    |  2 +-
 hw/misc/omap_l4.c                     |  2 +-
 hw/nvram/eeprom93xx.c                 |  2 +-
 hw/rdma/vmw/pvrdma_qp_ops.c           |  4 ++--
 hw/usb/dev-network.c                  |  2 +-
 hw/usb/dev-smartcard-reader.c         |  4 ++--
 hw/virtio/virtio.c                    |  4 ++--
 hw/xen/xen_pt.h                       |  2 +-
 include/hw/acpi/acpi-defs.h           | 12 ++++++------
 include/hw/arm/smmu-common.h          |  2 +-
 include/hw/i386/intel_iommu.h         |  3 ++-
 include/hw/virtio/virtio-iommu.h      |  2 +-
 include/sysemu/cryptodev.h            |  2 +-
 include/tcg/tcg.h                     |  2 +-
 net/queue.c                           |  2 +-
 pc-bios/s390-ccw/bootmap.h            |  2 +-
 pc-bios/s390-ccw/sclp.h               |  2 +-
 tests/qtest/libqos/ahci.h             |  2 +-
 24 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index 91204a2..3c0527c 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -121,7 +121,7 @@ struct aio_ring {
     unsigned    incompat_features;
     unsigned    header_length;  /* size of aio_ring */
=20
-    struct io_event io_events[0];
+    struct io_event io_events[];
 };
=20
 /**
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 09e8aed..f8bb1e5 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -95,7 +95,7 @@ typedef struct TaskState {
     struct sigqueue *first_free; /* first free siginfo queue entry */
     int signal_pending; /* non zero if a signal may be pending */
=20
-    uint8_t stack[0];
+    uint8_t stack[];
 } __attribute__((aligned(16))) TaskState;
=20
 void init_task_state(TaskState *ts);
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/=
libvhost-user.h
index 6fc8000..f30394f 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -286,7 +286,7 @@ typedef struct VuVirtqInflight {
     uint16_t used_idx;
=20
     /* Used to track the state of each descriptor in descriptor table */
-    VuDescStateSplit desc[0];
+    VuDescStateSplit desc[];
 } VuVirtqInflight;
=20
 typedef struct VuVirtqInflightDesc {
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 5219dd0..eb6a37b 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -485,7 +485,7 @@ struct NvdimmFuncGetLabelDataOut {
     /* the size of buffer filled by QEMU. */
     uint32_t len;
     uint32_t func_ret_status; /* return status code. */
-    uint8_t out_buf[0]; /* the data got via Get Namesapce Label function. =
*/
+    uint8_t out_buf[]; /* the data got via Get Namesapce Label function. *=
/
 } QEMU_PACKED;
 typedef struct NvdimmFuncGetLabelDataOut NvdimmFuncGetLabelDataOut;
 QEMU_BUILD_BUG_ON(sizeof(NvdimmFuncGetLabelDataOut) > NVDIMM_DSM_MEMORY_SI=
ZE);
@@ -493,7 +493,7 @@ QEMU_BUILD_BUG_ON(sizeof(NvdimmFuncGetLabelDataOut) > N=
VDIMM_DSM_MEMORY_SIZE);
 struct NvdimmFuncSetLabelDataIn {
     uint32_t offset; /* the offset in the namespace label data area. */
     uint32_t length; /* the size of data is to be written via the function=
. */
-    uint8_t in_buf[0]; /* the data written to label data area. */
+    uint8_t in_buf[]; /* the data written to label data area. */
 } QEMU_PACKED;
 typedef struct NvdimmFuncSetLabelDataIn NvdimmFuncSetLabelDataIn;
 QEMU_BUILD_BUG_ON(sizeof(NvdimmFuncSetLabelDataIn) +
@@ -510,7 +510,7 @@ struct NvdimmFuncReadFITOut {
     /* the size of buffer filled by QEMU. */
     uint32_t len;
     uint32_t func_ret_status; /* return status code. */
-    uint8_t fit[0]; /* the FIT data. */
+    uint8_t fit[]; /* the FIT data. */
 } QEMU_PACKED;
 typedef struct NvdimmFuncReadFITOut NvdimmFuncReadFITOut;
 QEMU_BUILD_BUG_ON(sizeof(NvdimmFuncReadFITOut) > NVDIMM_DSM_MEMORY_SIZE);
diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index c3e4158..3a43005 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -80,7 +80,7 @@ struct dma_s {
     } *memmap;
     int memmap_size;
=20
-    struct soc_dma_ch_s ch[0];
+    struct soc_dma_ch_s ch[];
 };
=20
 static void soc_dma_ch_schedule(struct soc_dma_ch_s *ch, int delay_bytes)
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 7f38e6b..0824652 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -328,7 +328,7 @@ struct setup_data {
     uint64_t next;
     uint32_t type;
     uint32_t len;
-    uint8_t data[0];
+    uint8_t data[];
 } __attribute__((packed));
=20
=20
diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
index 5f8ded2..c954270 100644
--- a/hw/m68k/bootinfo.h
+++ b/hw/m68k/bootinfo.h
@@ -14,7 +14,7 @@
 struct bi_record {
     uint16_t tag;        /* tag ID */
     uint16_t size;       /* size of record */
-    uint32_t data[0];    /* data */
+    uint32_t data[];     /* data */
 };
=20
 /* machine independent tags */
diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
index 61b6df5..54aeaec 100644
--- a/hw/misc/omap_l4.c
+++ b/hw/misc/omap_l4.c
@@ -24,7 +24,7 @@ struct omap_l4_s {
     MemoryRegion *address_space;
     hwaddr base;
     int ta_num;
-    struct omap_target_agent_s ta[0];
+    struct omap_target_agent_s ta[];
 };
=20
 struct omap_l4_s *omap_l4_init(MemoryRegion *address_space,
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 07f0954..ca6f591 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -86,7 +86,7 @@ struct _eeprom_t {
     uint8_t  addrbits;
     uint16_t size;
     uint16_t data;
-    uint16_t contents[0];
+    uint16_t contents[];
 };
=20
 /* Code for saving and restoring of EEPROM state. */
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index bd6db85..8050287 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -34,13 +34,13 @@ typedef struct CompHandlerCtx {
 /* Send Queue WQE */
 typedef struct PvrdmaSqWqe {
     struct pvrdma_sq_wqe_hdr hdr;
-    struct pvrdma_sge sge[0];
+    struct pvrdma_sge sge[];
 } PvrdmaSqWqe;
=20
 /* Recv Queue WQE */
 typedef struct PvrdmaRqWqe {
     struct pvrdma_rq_wqe_hdr hdr;
-    struct pvrdma_sge sge[0];
+    struct pvrdma_sge sge[];
 } PvrdmaRqWqe;
=20
 /*
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 9a78ad9..6210427 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -626,7 +626,7 @@ static const uint32_t oid_supported_list[] =3D
 struct rndis_response {
     QTAILQ_ENTRY(rndis_response) entries;
     uint32_t length;
-    uint8_t buf[0];
+    uint8_t buf[];
 };
=20
 typedef struct USBNetState {
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 02693a2..ef72738 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -227,7 +227,7 @@ typedef struct QEMU_PACKED CCID_Parameter {
 typedef struct QEMU_PACKED CCID_DataBlock {
     CCID_BULK_IN b;
     uint8_t      bChainParameter;
-    uint8_t      abData[0];
+    uint8_t      abData[];
 } CCID_DataBlock;
=20
 /* 6.1.4 PC_to_RDR_XfrBlock */
@@ -235,7 +235,7 @@ typedef struct QEMU_PACKED CCID_XferBlock {
     CCID_Header  hdr;
     uint8_t      bBWI; /* Block Waiting Timeout */
     uint16_t     wLevelParameter; /* XXX currently unused */
-    uint8_t      abData[0];
+    uint8_t      abData[];
 } CCID_XferBlock;
=20
 typedef struct QEMU_PACKED CCID_IccPowerOn {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b2d415e..b6c8ef5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -54,7 +54,7 @@ typedef struct VRingAvail
 {
     uint16_t flags;
     uint16_t idx;
-    uint16_t ring[0];
+    uint16_t ring[];
 } VRingAvail;
=20
 typedef struct VRingUsedElem
@@ -67,7 +67,7 @@ typedef struct VRingUsed
 {
     uint16_t flags;
     uint16_t idx;
-    VRingUsedElem ring[0];
+    VRingUsedElem ring[];
 } VRingUsed;
=20
 typedef struct VRingMemoryRegionCaches {
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 9167bba..179775d 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -203,7 +203,7 @@ typedef struct XenPTMSIX {
     uint64_t mmio_base_addr;
     MemoryRegion mmio;
     void *phys_iomem_base;
-    XenPTMSIXEntry msix_entry[0];
+    XenPTMSIXEntry msix_entry[];
 } XenPTMSIX;
=20
 struct XenPCIPassthroughState {
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 57a3f58..19f7ba7 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -518,7 +518,7 @@ struct AcpiDmarDeviceScope {
     struct {
         uint8_t device;
         uint8_t function;
-    } path[0];
+    } path[];
 } QEMU_PACKED;
 typedef struct AcpiDmarDeviceScope AcpiDmarDeviceScope;
=20
@@ -530,7 +530,7 @@ struct AcpiDmarHardwareUnit {
     uint8_t reserved;
     uint16_t pci_segment;   /* The PCI Segment associated with this unit *=
/
     uint64_t address;   /* Base address of remapping hardware register-set=
 */
-    AcpiDmarDeviceScope scope[0];
+    AcpiDmarDeviceScope scope[];
 } QEMU_PACKED;
 typedef struct AcpiDmarHardwareUnit AcpiDmarHardwareUnit;
=20
@@ -541,7 +541,7 @@ struct AcpiDmarRootPortATS {
     uint8_t flags;
     uint8_t reserved;
     uint16_t pci_segment;
-    AcpiDmarDeviceScope scope[0];
+    AcpiDmarDeviceScope scope[];
 } QEMU_PACKED;
 typedef struct AcpiDmarRootPortATS AcpiDmarRootPortATS;
=20
@@ -604,7 +604,7 @@ typedef struct AcpiIortMemoryAccess AcpiIortMemoryAcces=
s;
 struct AcpiIortItsGroup {
     ACPI_IORT_NODE_HEADER_DEF
     uint32_t its_count;
-    uint32_t identifiers[0];
+    uint32_t identifiers[];
 } QEMU_PACKED;
 typedef struct AcpiIortItsGroup AcpiIortItsGroup;
=20
@@ -621,7 +621,7 @@ struct AcpiIortSmmu3 {
     uint32_t pri_gsiv;
     uint32_t gerr_gsiv;
     uint32_t sync_gsiv;
-    AcpiIortIdMapping id_mapping_array[0];
+    AcpiIortIdMapping id_mapping_array[];
 } QEMU_PACKED;
 typedef struct AcpiIortSmmu3 AcpiIortSmmu3;
=20
@@ -630,7 +630,7 @@ struct AcpiIortRC {
     AcpiIortMemoryAccess memory_properties;
     uint32_t ats_attribute;
     uint32_t pci_segment_number;
-    AcpiIortIdMapping id_mapping_array[0];
+    AcpiIortIdMapping id_mapping_array[];
 } QEMU_PACKED;
 typedef struct AcpiIortRC AcpiIortRC;
=20
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 1f37844..ca4a4b1 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -85,7 +85,7 @@ typedef struct SMMUDevice {
=20
 typedef struct SMMUPciBus {
     PCIBus       *bus;
-    SMMUDevice   *pbdev[0]; /* Parent array is sparse, so dynamically allo=
c */
+    SMMUDevice   *pbdev[]; /* Parent array is sparse, so dynamically alloc=
 */
 } SMMUPciBus;
=20
 typedef struct SMMUIOTLBKey {
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index a1c4afc..3870052 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -114,7 +114,8 @@ struct VTDAddressSpace {
=20
 struct VTDBus {
     PCIBus* bus;=09=09/* A reference to the bus to provide translation for=
 */
-    VTDAddressSpace *dev_as[0];=09/* A table of VTDAddressSpace objects in=
dexed by devfn */
+    /* A table of VTDAddressSpace objects indexed by devfn */
+    VTDAddressSpace *dev_as[];
 };
=20
 struct VTDIOTLBEntry {
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-io=
mmu.h
index 6f67f10..e653004 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -41,7 +41,7 @@ typedef struct IOMMUDevice {
=20
 typedef struct IOMMUPciBus {
     PCIBus       *bus;
-    IOMMUDevice  *pbdev[0]; /* Parent array is sparse, so dynamically allo=
c */
+    IOMMUDevice  *pbdev[]; /* Parent array is sparse, so dynamically alloc=
 */
 } IOMMUPciBus;
=20
 typedef struct VirtIOIOMMU {
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index a9afb7e..35eab06 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -143,7 +143,7 @@ typedef struct CryptoDevBackendSymOpInfo {
     uint8_t *dst;
     uint8_t *aad_data;
     uint8_t *digest_result;
-    uint8_t data[0];
+    uint8_t data[];
 } CryptoDevBackendSymOpInfo;
=20
 typedef struct CryptoDevBackendClass {
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 54e5446..c48bd76 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -267,7 +267,7 @@ struct TCGLabel {
 typedef struct TCGPool {
     struct TCGPool *next;
     int size;
-    uint8_t data[0] __attribute__ ((aligned));
+    uint8_t data[] __attribute__ ((aligned));
 } TCGPool;
=20
 #define TCG_POOL_CHUNK_SIZE 32768
diff --git a/net/queue.c b/net/queue.c
index 61276ca..0164727 100644
--- a/net/queue.c
+++ b/net/queue.c
@@ -46,7 +46,7 @@ struct NetPacket {
     unsigned flags;
     int size;
     NetPacketSent *sent_cb;
-    uint8_t data[0];
+    uint8_t data[];
 };
=20
 struct NetQueue {
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 94f53a5..12a0166 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -136,7 +136,7 @@ typedef struct BootMapScriptHeader {
=20
 typedef struct BootMapScript {
     BootMapScriptHeader header;
-    BootMapScriptEntry  entry[0];
+    BootMapScriptEntry  entry[];
 } __attribute__ ((packed)) BootMapScript;
=20
 /*
diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
index 8450161..64b53ca 100644
--- a/pc-bios/s390-ccw/sclp.h
+++ b/pc-bios/s390-ccw/sclp.h
@@ -95,7 +95,7 @@ typedef struct EventBufferHeader {
 typedef struct WriteEventData {
     SCCBHeader h;
     EventBufferHeader ebh;
-    char data[0];
+    char data[];
 } __attribute__((packed)) WriteEventData;
=20
 typedef struct ReadEventData {
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index f05b3e5..44ab110 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -351,7 +351,7 @@ typedef struct AHCIQState {
 typedef struct FIS {
     uint8_t fis_type;
     uint8_t flags;
-    char data[0];
+    char data[];
 } __attribute__((__packed__)) FIS;
=20
 /**
--=20
1.8.3.1



