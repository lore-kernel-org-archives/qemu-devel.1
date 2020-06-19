Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3975EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01725207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01725207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmL0w-00067w-AV
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jmL04-0005Wr-Mb; Fri, 19 Jun 2020 13:40:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:60059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jmL00-0001K7-Pd; Fri, 19 Jun 2020 13:40:24 -0400
IronPort-SDR: Wp33e/dFQbje625OBxzNrO+4EpYMx1xrSbtPfBHSSRdX+5yW2XYAlIGngMfth7vqPU4hYdU08B
 TamCW0RjTEng==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="122750883"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; d="scan'208";a="122750883"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 10:30:33 -0700
IronPort-SDR: dDX/PX0QAe03U/yKJqjCVvAfS7XA4nIcMdtBfVkZWen+dA+Z6nQuO7igP7ptrBTUeKAcBh31F+
 mytp2TDSt4VA==
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; d="scan'208";a="477707404"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.134.76.115])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 10:30:32 -0700
Subject: Re: [PATCH RESEND v2 2/2] nvme: allow cmb and pmr to be enabled on
 same device
To: Klaus Jensen <its@irrelevant.dk>
References: <20200617051857.20508-1-andrzej.jakowski@linux.intel.com>
 <20200617051857.20508-3-andrzej.jakowski@linux.intel.com>
 <20200618092524.posxi5mysb3jjtpn@apples.localdomain>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <f766ffd1-04d4-9e41-5393-80e61ab37ec2@linux.intel.com>
Date: Fri, 19 Jun 2020 10:30:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618092524.posxi5mysb3jjtpn@apples.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.55.52.136;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:30:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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

On 6/18/20 2:25 AM, Klaus Jensen wrote:
> On Jun 16 22:18, Andrzej Jakowski wrote:
>> So far it was not possible to have CMB and PMR emulated on the same
>> device, because BAR2 was used exclusively either of PMR or CMB. This
>> patch places CMB at BAR4 offset so it not conflicts with MSI-X vectors.
>>
>> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
>> ---
>>  hw/block/nvme.c      | 122 ++++++++++++++++++++++++++++---------------
>>  hw/block/nvme.h      |   5 +-
>>  include/block/nvme.h |   4 +-
>>  3 files changed, 86 insertions(+), 45 deletions(-)
>>
>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>> index 9f11f3e9da..62681966b9 100644
>> --- a/hw/block/nvme.c
>> +++ b/hw/block/nvme.c
>> @@ -22,12 +22,12 @@
>>   *              [pmrdev=<mem_backend_file_id>,] \
>>   *              max_ioqpairs=<N[optional]>
>>   *
>> - * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
>> - * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
>> + * Note cmb_size_mb denotes size of CMB in MB. CMB when configured is assumed
>> + * to be resident in BAR4 at certain offset - this is because BAR4 is also
>> + * used for storing MSI-X table that is available at offset 0 in BAR4.
> 
> I would still really like a R-b by a more PCI-competent reviewer to
> ensure that it is sane to have the MSI-X table here in prefetchable
> 64-bit address space.

Having Reviewed-by for that make sense to me. And let me offer some
evidences of real devices having MSI-X in prefetchable region and 
non-prefetchable region. Based on those examples I don't think it matters
where you place your MSI-X vector.

Why do you think it may not be sane to place MSI-x table in prefetchable
region?

Device with MSI-X in non-prefetchable region:
Region 0: Memory at fb42c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
                Vector table: BAR=0 offset=00002000
                PBA: BAR=0 offset=00003000

Device with MSI-X in prefetchable region
Region 0: Memory at fbc00000 (64-bit, prefetchable) [size=2M]
        Region 2: I/O ports at e020 [size=32]
        Region 4: Memory at fbe04000 (64-bit, prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
                Vector table: BAR=4 offset=00000000
                PBA: BAR=4 offset=00002000



> 
>>   *
>> - * cmb_size_mb= and pmrdev= options are mutually exclusive due to limitation
>> - * in available BAR's. cmb_size_mb= will take precedence over pmrdev= when
>> - * both provided.
>> + * pmrdev is assumed to be resident in BAR2/BAR3. When configured it consumes
>> + * whole BAR2/BAR3 exclusively.
>>   * Enabling pmr emulation can be achieved by pointing to memory-backend-file.
>>   * For example:
>>   * -object memory-backend-file,id=<mem_id>,share=on,mem-path=<file_path>, \
>> @@ -69,18 +69,19 @@
>>  
>>  static void nvme_process_sq(void *opaque);
>>  
>> -static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>> +static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr, int size)
>>  {
>> -    hwaddr low = n->ctrl_mem.addr;
>> -    hwaddr hi  = n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
>> +    hwaddr low = n->bar4.addr + n->cmb_offset;
>> +    hwaddr hi  = low + NVME_CMBSZ_GETSIZE(n->bar.cmbsz);
> 
> Isn't it better to use n->bar4.size?

My understanding is that cmb doesn't necessarily need to occupy whole BAR,
which is required to be power-of-two in size.

> 
>>  
>> -    return addr >= low && addr < hi;
>> +    return addr >= low && (addr + size) < hi;
>>  }
> 
> I think nvme_addr_is_cmb should do what it says on the tin - that is,
> check that addr is within the CMB. The size check belongs in
> nvme_addr_read.

Yep, that was my intention. New check confirms that start and end of requested
addresses are within CMB range. While previous code only checked start address.
You may end up with situation where end adress could be outside of CMB range while
start in CMB range.

> 
>>  
>>  static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>>  {
>> -    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
>> -        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
>> +    hwaddr cmb_addr = n->bar4.addr + n->cmb_offset;
>> +    if (n->cmbsz && nvme_addr_is_cmb(n, addr, size)) {
>> +        memcpy(buf, (void *)&n->cmbuf[addr - cmb_addr], size);
>>          return;
>>      }
>>  
>> @@ -167,17 +168,18 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>>                               uint64_t prp2, uint32_t len, NvmeCtrl *n)
>>  {
>>      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
>> +    hwaddr cmb_addr = n->bar4.addr + n->cmb_offset;
>>      trans_len = MIN(len, trans_len);
>>      int num_prps = (len >> n->page_bits) + 1;
>>  
>>      if (unlikely(!prp1)) {
>>          trace_pci_nvme_err_invalid_prp();
>>          return NVME_INVALID_FIELD | NVME_DNR;
>> -    } else if (n->bar.cmbsz && prp1 >= n->ctrl_mem.addr &&
>> -               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
>> +    } else if (n->cmbsz && prp1 >= cmb_addr &&
>> +               prp1 < cmb_addr + int128_get64(n->bar4.size)) {
>>          qsg->nsg = 0;
>>          qemu_iovec_init(iov, num_prps);
>> -        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
>> +        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - cmb_addr], trans_len);
>>      } else {
>>          pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
>>          qemu_sglist_add(qsg, prp1, trans_len);
>> @@ -222,7 +224,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>>                  if (qsg->nsg){
>>                      qemu_sglist_add(qsg, prp_ent, trans_len);
>>                  } else {
>> -                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
>> +                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - cmb_addr],
>> +                                   trans_len);
>>                  }
>>                  len -= trans_len;
>>                  i++;
>> @@ -235,7 +238,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>>              if (qsg->nsg) {
>>                  qemu_sglist_add(qsg, prp2, len);
>>              } else {
>> -                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
>> +                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - cmb_addr],
>> +                               trans_len);
>>              }
>>          }
>>      }
>> @@ -1360,6 +1364,7 @@ static const MemoryRegionOps nvme_cmb_ops = {
>>      },
>>  };
>>  
>> +
> 
> Spurious line break.

Yep. Will remove that change

> 
>>  static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
>>  {
>>      NvmeParams *params = &n->params;
>> @@ -1395,7 +1400,7 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
>>          return;
>>      }
>>  
>> -    if (!n->params.cmb_size_mb && n->pmrdev) {
>> +    if (n->pmrdev) {
>>          if (host_memory_backend_is_mapped(n->pmrdev)) {
>>              char *path = object_get_canonical_path_component(OBJECT(n->pmrdev));
>>              error_setg(errp, "can't use already busy memdev: %s", path);
>> @@ -1453,33 +1458,66 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>>      id_ns->nuse = id_ns->ncap;
>>  }
>>  
>> -static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
>> +#define NVME_MSIX_BIR (4)
> 
> I think this should be at the top with the other constants.

Makes sense.

> 
>> +static void nvme_bar4_init(PCIDevice *pci_dev, Error **errp)
>>  {
>> -    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_CMB_BIR);
>> -    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
>> -
>> -    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
>> -    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
>> -    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
>> -    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
>> -    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
>> -    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
>> -    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
>> -
>> -    n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
>> -    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
>> -                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
>> -    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
>> +    NvmeCtrl *n = NVME(pci_dev);
>> +    int status;
>> +    uint64_t bar_size;
>> +    uint32_t msix_vectors;
>> +    uint32_t nvme_pba_offset;
>> +    uint32_t cmb_size_units;
>> +
>> +    msix_vectors = n->params.max_ioqpairs + 1;
>> +    nvme_pba_offset = PCI_MSIX_ENTRY_SIZE * msix_vectors;
>> +    bar_size = nvme_pba_offset + QEMU_ALIGN_UP(msix_vectors, 64) / 8;
>> +
>> +    if (n->params.cmb_size_mb) {
>> +        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
>> +        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
>> +        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
>> +        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
>> +        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
>> +        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
>> +        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
>> +
>> +        cmb_size_units = NVME_CMBSZ_GETSIZEUNITS(n->bar.cmbsz);
>> +        n->cmb_offset = QEMU_ALIGN_UP(bar_size, cmb_size_units);
>> +
>> +        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_MSIX_BIR);
>> +        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, n->cmb_offset / cmb_size_units);
>> +
>> +        n->cmbloc = n->bar.cmbloc;
>> +        n->cmbsz = n->bar.cmbsz;
>> +
>> +        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
>> +
>> +        bar_size += n->cmb_offset;
>> +        bar_size += NVME_CMBSZ_GETSIZE(n->bar.cmbsz);
>> +    }
>> +
>> +    bar_size = pow2ceil(bar_size);
>> +
>> +    memory_region_init_io(&n->bar4, OBJECT(n), &nvme_cmb_ops, n,
>> +                          "nvme-bar4", bar_size);
>> +
>> +    status = msix_init(pci_dev, n->params.max_ioqpairs + 1,
>> +              &n->bar4, NVME_MSIX_BIR, 0,
>> +              &n->bar4, NVME_MSIX_BIR, nvme_pba_offset,
>> +              0, errp);
> 
> Align with opening brace.
Yep, makes sense

> 
>> +
>> +    if (status) {
>> +        return;
>> +    }
>> +
>> +    pci_register_bar(pci_dev, NVME_MSIX_BIR,
>>                       PCI_BASE_ADDRESS_SPACE_MEMORY |
>>                       PCI_BASE_ADDRESS_MEM_TYPE_64 |
>> -                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
>> +                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->bar4);
>>  }
>>  
>>  static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
>>  {
>> -    /* Controller Capabilities register */
>> -    NVME_CAP_SET_PMRS(n->bar.cap, 1);
>> -
>>      /* PMR Capabities register */
>>      n->bar.pmrcap = 0;
>>      NVME_PMRCAP_SET_RDS(n->bar.pmrcap, 0);
>> @@ -1537,13 +1575,10 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>>                            n->reg_size);
>>      pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>>                       PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
>> -    if (msix_init_exclusive_bar(pci_dev, n->params.msix_qsize, 4, errp)) {
>> -        return;
>> -    }
>>  
>> -    if (n->params.cmb_size_mb) {
>> -        nvme_init_cmb(n, pci_dev);
>> -    } else if (n->pmrdev) {
>> +    nvme_bar4_init(pci_dev, errp);
>> +
>> +    if (n->pmrdev) {
>>          nvme_init_pmr(n, pci_dev);
>>      }
>>  }
>> @@ -1583,6 +1618,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>>      NVME_CAP_SET_CSS(n->bar.cap, 1);
>>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
>>      NVME_CAP_SET_CMBS(n->bar.cap, n->params.cmb_size_mb ? 1 : 0);
>> +    NVME_CAP_SET_PMRS(n->bar.cap, n->pmrdev ? 1 : 0);
>>  
>>      n->bar.vs = 0x00010200;
>>      n->bar.intmc = n->bar.intms = 0;
>> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
>> index 1d30c0bca2..bc233e6a68 100644
>> --- a/hw/block/nvme.h
>> +++ b/hw/block/nvme.h
>> @@ -80,7 +80,7 @@ static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
>>  typedef struct NvmeCtrl {
>>      PCIDevice    parent_obj;
>>      MemoryRegion iomem;
>> -    MemoryRegion ctrl_mem;
>> +    MemoryRegion bar4;
>>      NvmeBar      bar;
>>      BlockConf    conf;
>>      NvmeParams   params;
>> @@ -94,6 +94,9 @@ typedef struct NvmeCtrl {
>>      uint32_t    num_namespaces;
>>      uint32_t    max_q_ents;
>>      uint64_t    ns_size;
>> +    uint32_t    cmbsz;
>> +    uint32_t    cmbloc;
>> +    uint32_t    cmb_offset;
> 
> So, in commit c923aac9e00d ("hw/block/nvme: remove redundant
> cmbloc/cmbsz members") I actually specifically got rid of cmbloc and
> cmbsz members and they are now being reintroduced :P
> 
> Since we are not really using the value, just testing if they are
> non-zero, can we use n->bar.cmbsz instead? n->cmbloc is not used at all
> actually.

Let me take a look on that.

> 
>>      uint8_t     *cmbuf;
>>      uint32_t    irq_status;
>>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
>> diff --git a/include/block/nvme.h b/include/block/nvme.h
>> index 14cf398dfa..76d15bdf9f 100644
>> --- a/include/block/nvme.h
>> +++ b/include/block/nvme.h
>> @@ -216,9 +216,11 @@ enum NvmeCmbszMask {
>>      (cmbsz |= (uint64_t)(val & CMBSZ_SZU_MASK) << CMBSZ_SZU_SHIFT)
>>  #define NVME_CMBSZ_SET_SZ(cmbsz, val)    \
>>      (cmbsz |= (uint64_t)(val & CMBSZ_SZ_MASK) << CMBSZ_SZ_SHIFT)
>> +#define NVME_CMBSZ_GETSIZEUNITS(cmbsz) \
>> +    (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz)))
>>  
>>  #define NVME_CMBSZ_GETSIZE(cmbsz) \
>> -    (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
>> +    (NVME_CMBSZ_SZ(cmbsz) * NVME_CMBSZ_GETSIZEUNITS(cmbsz))
>>  
>>  enum NvmePmrcapShift {
>>      PMRCAP_RDS_SHIFT      = 3,
>> -- 
>> 2.21.1
>>
>>


