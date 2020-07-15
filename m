Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF78EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A3520578
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A3520578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvcSO-0002nL-FK
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 04:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jvcRZ-0001oq-Nw; Wed, 15 Jul 2020 04:07:09 -0400
Received: from charlie.dont.surf ([128.199.63.193]:44900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jvcRV-0000iP-SG; Wed, 15 Jul 2020 04:07:09 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id A5A18BF448;
 Wed, 15 Jul 2020 08:07:01 +0000 (UTC)
Date: Wed, 15 Jul 2020 10:06:58 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v4 2/2] nvme: allow cmb and pmr to be enabled on same
 device
Message-ID: <20200715080658.GA506302@apples.localdomain>
References: <20200701214858.28515-1-andrzej.jakowski@linux.intel.com>
 <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>
 <20200702101318.rmd65uzwfpcmb24n@apples.localdomain>
 <20200702103127.hoonqkas3bw2v7re@apples.localdomain>
 <8f871a0d-47f1-1c8a-fcc2-aab2638c70cf@linux.intel.com>
 <20200702175113.6qtnpxqimpavzx7h@apples.localdomain>
 <191b39ed-0588-b5db-d352-965efd19128a@linux.intel.com>
 <20200706071545.md4tivimefffgyi6@apples.localdomain>
 <16d74d40-bd55-997d-7fd6-e7ec59566a68@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16d74d40-bd55-997d-7fd6-e7ec59566a68@linux.intel.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 04:07:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kbusch@kernel.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul  7 21:44, Andrzej Jakowski wrote:
> On 7/6/20 12:15 AM, Klaus Jensen wrote:
> > On Jul  2 16:33, Andrzej Jakowski wrote:
> >> On 7/2/20 10:51 AM, Klaus Jensen wrote:
> >>> On Jul  2 08:07, Andrzej Jakowski wrote:
> >>>> On 7/2/20 3:31 AM, Klaus Jensen wrote:
> >>>>> Aight, an update here. This only happens when QEMU is run with a virtual
> >>>>> IOMMU. Otherwise, the kernel is happy.
> >>>>>
> >>>>> With the vIOMMU, qemu also craps out a bit:
> >>>>>
> >>>>> qemu-system-x86_64: vtd_iova_to_slpte: detected slpte permission error (iova=0xfd200000, level=0x2, slpte=0x0, write=0)
> >>>>> qemu-system-x86_64: vtd_iommu_translate: detected translation failure (dev=03:00:00, iova=0xfd200000)
> >>>>>
> >>>>> So I think we are back in QEMU land for the bug.
> >>>>
> >>>> Can you share command line for that?
> >>>>
> >>>>
> >>>
> >>> qemu-system-x86_64 \
> >>>   -nodefaults \
> >>>   -display none \
> >>>   -device intel-iommu,pt,intremap=on,device-iotlb=on \
> >>>   -machine type=q35,accel=kvm,kernel_irqchip=split \
> >>>   -cpu host \
> >>>   -smp 4 \
> >>>   -m 8G \
> >>>   -nic user,model=virtio-net-pci,hostfwd=tcp::2222-:22 \
> >>>   -device virtio-rng-pci \
> >>>   -drive id=boot,file=/home/kbj/work/src/vmctl/state/pmr/boot.qcow2,format=qcow2,if=virtio,discard=on,detect-zeroes=unmap \
> >>>   -device pcie-root-port,id=pcie_root_port1,chassis=1,slot=0 \
> >>>   -device x3130-upstream,id=pcie_upstream1,bus=pcie_root_port1 \
> >>>   -device xio3130-downstream,id=pcie_downstream1,bus=pcie_upstream1,chassis=1,slot=1 \
> >>>   -drive id=nvme0n1,file=/home/kbj/work/src/vmctl/state/pmr/nvme0n1.img,format=raw,if=none,discard=on,detect-zeroes=unmap \
> >>>   -object memory-backend-file,id=pmr,share=on,mem-path=pmr.bin,size=1M \
> >>>   -device nvme,id=nvme0,serial=deadbeef,bus=pcie_downstream1,drive=nvme0n1,msix_qsize=1,pmrdev=pmr,cmb_size_mb=2 \
> >>>   -pidfile /home/kbj/work/src/vmctl/run/pmr/pidfile \
> >>>   -kernel /home/kbj/work/src/kernel/linux/arch/x86_64/boot/bzImage \
> >>>   -append root=/dev/vda1 console=ttyS0,115200 audit=0 nokaslr \
> >>>   -virtfs local,path=/home/kbj/work/src/kernel/linux,security_model=none,readonly,mount_tag=modules \
> >>>   -serial mon:stdio \
> >>>   -trace pci_nvme*
> >>>
> >>>
> >>
> >> I focused on reproduction and it looks to me that my patch doesn't 
> >> necessarily introduce regression. I run it w/ and w/o patch in both cases
> >> getting error while registering. Here is kernel guest log:
> >>
> >> [   87.606482] nvme nvme0: pci function 0000:00:04.0
> >> [   87.635577] dev=0000000095b0a83b bar=2 size=134217728 offset=0
> >> [   87.636593] nvme nvme0: failed to register the CMB ret=-95
> >> [   87.643262] nvme nvme0: 12/0/0 default/read/poll queues
> >>
> >> Any thoughts?
> >>
> > 
> > Hmm, that's not what I am seeing.
> > 
> > With kernel v5.8-rc4, I'm not seeing any issues with CMB with and
> > without IOMMU on QEMU master. With your patches, my kernel (v5.8-rc4)
> > pukes both with and without iommu.
> > 
> > BUT! This doesn't mean that your patch is bad, it looks more like an
> > issue in the kernel. I still think the BAR configuration looks sane, but
> > I am not expert on this.
> > 
> > To satisify my curiosity I tried mending your patch to put the CMB on
> > offset 0 and move the MSI-X vector table and PBA to BAR 0 (like I
> > suggested back in the day). That works. With and without IOMMU. So, I
> > think it is an issue with the Linux kernel not being too happy about the
> > CMB being at an offset. It doesn't directly look like an issue in the
> > nvme driver since the issue shows up far lower in the memory subsystem,
> > but it would be nice to have the linux nvme gang at least acknowledge
> > the issue.
> > 
> 
> I have managed to reproduce that problem and played with patch to see
> when the problem occurs vs not. 
> When I put MSIX back to BAR2 (no PMR at all) and CMB left at BAR4 but 
> starting at offset 0 I was still able to reproduce issue.
> So then I've played with memory region API and interesting observed that
> problem occurs when region overlaying is used via:
> 
> memory_region_init(&n->bar4, OBJECT(n), "nvme-bar4",  bar_size);$
> $  
> if (n->params.cmb_size_mb) {$
>     memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,$
>                           "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));$
> $  
>     memory_region_add_subregion_overlap(&n->bar4, cmb_offset, &n->ctrl_mem, 1);$
> }$
> 
> on the other hand when cmb memory region is initialized w/o region
> overlaying that is:
> 
> memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,$
>                       "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> 
> I get no reproduction.
> 
> Also observed qemu complaing about failed translation:
> qemu-system-x86_64: vtd_iova_to_slpte: detected slpte permission error (iova=0xfe400000, level=0x2, slpte=0x0, write=0)
> qemu-system-x86_64: vtd_iommu_translate: detected translation failure (dev=03:00:00, iova=0xfe400000)
> 
> Not sure how we want to proceed. Any suggestions?
> 

Hi Andrzej,

I've not been ignoring this, but sorry for not following up earlier.

I'm hesitent to merge anything that very obviously breaks an OS that we
know is used a lot to this using this device. Also because the issue has
not been analyzed well enough to actually know if this is a QEMU or
kernel issue.

Now, as far as I can test, having the MSI-X vector table and PBA in BAR
0, PMR in BAR 2 and CMB in BAR 4 seems to make everyone happy
(irregardless of IOMMU on/off).

Later, when the issue is better understood, we can add options to set
offsets, BIRs etc.

The patch below replaces your "[PATCH v4 2/2] nvme: allow cmb and pmr to
be enabled" (but still requires "[PATCH v4 1/2] ...") and applies to
git://git.infradead.org/qemu-nvme.git nvme-next branch.

Can you reproduce the issues with that patch? I can't on a stock Arch
Linux 5.7.5-arch1-1 kernel.


---
 hw/block/nvme.c | 41 +++++++++++++++++++++++++++++------------
 hw/block/nvme.h |  1 +
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ce96a14f9f1a..903362d0bdb8 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -25,9 +25,8 @@
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
  *
- * cmb_size_mb= and pmrdev= options are mutually exclusive due to limitation
- * in available BAR's. cmb_size_mb= will take precedence over pmrdev= when
- * both provided.
+ * pmrdev is assumed to be resident in BAR4. When configured it consumes
+ * whole BAR4/BAR5 exclusively.
  * Enabling pmr emulation can be achieved by pointing to memory-backend-file.
  * For example:
  * -object memory-backend-file,id=<mem_id>,share=on,mem-path=<file_path>, \
@@ -57,7 +56,7 @@
 #define NVME_MAX_IOQPAIRS 0xffff
 #define NVME_DB_SIZE  4
 #define NVME_CMB_BIR 2
-#define NVME_PMR_BIR 2
+#define NVME_PMR_BIR 4
 
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -1394,7 +1393,7 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
         return;
     }
 
-    if (!n->params.cmb_size_mb && n->pmrdev) {
+    if (n->pmrdev) {
         if (host_memory_backend_is_mapped(n->pmrdev)) {
             char *path = object_get_canonical_path_component(OBJECT(n->pmrdev));
             error_setg(errp, "can't use already busy memdev: %s", path);
@@ -1476,9 +1475,6 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
 
 static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
 {
-    /* Controller Capabilities register */
-    NVME_CAP_SET_PMRS(n->bar.cap, 1);
-
     /* PMR Capabities register */
     n->bar.pmrcap = 0;
     NVME_PMRCAP_SET_RDS(n->bar.pmrcap, 0);
@@ -1526,23 +1522,43 @@ static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
 static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 {
     uint8_t *pci_conf = pci_dev->config;
+    uint32_t msix_vectors;
+    uint32_t pba_offset;
+    uint64_t bar_size, msix_offset = 0;
 
     pci_conf[PCI_INTERRUPT_PIN] = 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
     pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(pci_dev, 0x80);
 
+    msix_offset = n->reg_size;
+    bar_size = n->reg_size;
+
+    msix_vectors = n->params.max_ioqpairs + 1;
+    pba_offset = msix_offset + PCI_MSIX_ENTRY_SIZE * msix_vectors;
+    bar_size += pba_offset + QEMU_ALIGN_UP(msix_vectors, 64) / 8;
+    bar_size = pow2ceil(bar_size);
+
+    memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
                           n->reg_size);
-    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
-                     PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
-    if (msix_init_exclusive_bar(pci_dev, n->params.msix_qsize, 4, errp)) {
+    memory_region_add_subregion(&n->bar0, 0, &n->iomem);
+
+    if (msix_init(pci_dev, n->params.msix_qsize,
+                  &n->bar0, 0, msix_offset,
+                  &n->bar0, 0, pba_offset,
+                  0, errp)) {
         return;
     }
 
+    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
+
     if (n->params.cmb_size_mb) {
         nvme_init_cmb(n, pci_dev);
-    } else if (n->pmrdev) {
+    }
+
+    if (n->pmrdev) {
         nvme_init_pmr(n, pci_dev);
     }
 }
@@ -1582,6 +1598,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_CSS(n->bar.cap, 1);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
     NVME_CAP_SET_CMBS(n->bar.cap, n->params.cmb_size_mb ? 1 : 0);
+    NVME_CAP_SET_PMRS(n->bar.cap, n->pmrdev ? 1 : 0);
 
     n->bar.vs = 0x00010200;
     n->bar.intmc = n->bar.intms = 0;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1d30c0bca283..f312d18b315b 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -79,6 +79,7 @@ static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
 
 typedef struct NvmeCtrl {
     PCIDevice    parent_obj;
+    MemoryRegion bar0;
     MemoryRegion iomem;
     MemoryRegion ctrl_mem;
     NvmeBar      bar;
-- 
2.27.0


