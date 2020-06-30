Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA18DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EEF206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EEF206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqEVX-0006pK-Nl
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqEU1-0005ra-RM; Tue, 30 Jun 2020 07:31:25 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqETy-0002T9-G1; Tue, 30 Jun 2020 07:31:25 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 8DDEDBF676;
 Tue, 30 Jun 2020 11:31:16 +0000 (UTC)
Date: Tue, 30 Jun 2020 13:31:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 07/18] hw/block/nvme: Add support for Namespace Types
Message-ID: <20200630113108.2g6jpa2pwfxumjqh@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-8-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-8-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 04:46:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 18 06:34, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Namespace Types introduce a new command set, "I/O Command Sets",
> that allows the host to retrieve the command sets associated with
> a namespace. Introduce support for the command set, and enable
> detection for the NVM Command Set.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++--
>  hw/block/nvme.h |  11 +++
>  2 files changed, 216 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 03b8deee85..453f4747a5 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -686,6 +686,26 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
>          prp1, prp2);
>  }
>  
> +static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeIdentify *c)
> +{
> +    uint64_t prp1 = le64_to_cpu(c->prp1);
> +    uint64_t prp2 = le64_to_cpu(c->prp2);
> +    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
> +    uint32_t *list;
> +    uint16_t ret;
> +
> +    trace_pci_nvme_identify_ctrl_csi(c->csi);
> +
> +    if (c->csi == NVME_CSI_NVM) {
> +        list = g_malloc0(data_len);
> +        ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
> +        g_free(list);
> +        return ret;
> +    } else {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +}
> +
>  static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
>  {
>      NvmeNamespace *ns;
> @@ -701,11 +721,42 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
>      }
>  
>      ns = &n->namespaces[nsid - 1];
> +    assert(nsid == ns->nsid);
>  
>      return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
>          prp1, prp2);
>  }
>  
> +static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeIdentify *c)
> +{
> +    NvmeNamespace *ns;
> +    uint32_t nsid = le32_to_cpu(c->nsid);
> +    uint64_t prp1 = le64_to_cpu(c->prp1);
> +    uint64_t prp2 = le64_to_cpu(c->prp2);
> +    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
> +    uint32_t *list;
> +    uint16_t ret;
> +
> +    trace_pci_nvme_identify_ns_csi(nsid, c->csi);
> +
> +    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> +        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
> +    ns = &n->namespaces[nsid - 1];
> +    assert(nsid == ns->nsid);
> +
> +    if (c->csi == NVME_CSI_NVM) {
> +        list = g_malloc0(data_len);
> +        ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
> +        g_free(list);
> +        return ret;
> +    } else {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +}
> +
>  static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>  {
>      static const int data_len = NVME_IDENTIFY_DATA_SIZE;
> @@ -733,6 +784,99 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>      return ret;
>  }
>  
> +static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeIdentify *c)
> +{
> +    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
> +    uint32_t min_nsid = le32_to_cpu(c->nsid);
> +    uint64_t prp1 = le64_to_cpu(c->prp1);
> +    uint64_t prp2 = le64_to_cpu(c->prp2);
> +    uint32_t *list;
> +    uint16_t ret;
> +    int i, j = 0;
> +
> +    trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
> +
> +    if (c->csi != NVME_CSI_NVM) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    list = g_malloc0(data_len);
> +    for (i = 0; i < n->num_namespaces; i++) {
> +        if (i < min_nsid) {
> +            continue;
> +        }
> +        list[j++] = cpu_to_le32(i + 1);
> +        if (j == data_len / sizeof(uint32_t)) {
> +            break;
> +        }
> +    }
> +    ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
> +    g_free(list);
> +    return ret;
> +}
> +
> +static uint16_t nvme_list_ns_descriptors(NvmeCtrl *n, NvmeIdentify *c)
> +{
> +    NvmeNamespace *ns;
> +    uint32_t nsid = le32_to_cpu(c->nsid);
> +    uint64_t prp1 = le64_to_cpu(c->prp1);
> +    uint64_t prp2 = le64_to_cpu(c->prp2);
> +    void *buf_ptr;
> +    NvmeNsIdDesc *desc;
> +    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
> +    uint8_t *buf;
> +    uint16_t status;
> +
> +    trace_pci_nvme_list_ns_descriptors();
> +
> +    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> +        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
> +    ns = &n->namespaces[nsid - 1];
> +    assert(nsid == ns->nsid);
> +
> +    buf = g_malloc0(data_len);
> +    buf_ptr = buf;
> +
> +    desc = buf_ptr;
> +    desc->nidt = NVME_NIDT_UUID;
> +    desc->nidl = NVME_NIDL_UUID;
> +    buf_ptr += sizeof(*desc);
> +    memcpy(buf_ptr, ns->uuid.data, NVME_NIDL_UUID);
> +    buf_ptr += NVME_NIDL_UUID;
> +
> +    desc = buf_ptr;
> +    desc->nidt = NVME_NIDT_CSI;
> +    desc->nidl = NVME_NIDL_CSI;
> +    buf_ptr += sizeof(*desc);
> +    *(uint8_t *)buf_ptr = NVME_CSI_NVM;
> +
> +    status = nvme_dma_read_prp(n, buf, data_len, prp1, prp2);
> +    g_free(buf);
> +    return status;
> +}
> +
> +static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeIdentify *c)
> +{
> +    uint64_t prp1 = le64_to_cpu(c->prp1);
> +    uint64_t prp2 = le64_to_cpu(c->prp2);
> +    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
> +    uint32_t *list;
> +    uint8_t *ptr;
> +    uint16_t status;
> +
> +    trace_pci_nvme_identify_cmd_set();
> +
> +    list = g_malloc0(data_len);
> +    ptr = (uint8_t *)list;
> +    NVME_SET_CSI(*ptr, NVME_CSI_NVM);
> +    status = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
> +    g_free(list);
> +    return status;
> +}
> +
>  static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>  {
>      NvmeIdentify *c = (NvmeIdentify *)cmd;
> @@ -740,10 +884,20 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>      switch (le32_to_cpu(c->cns)) {
>      case NVME_ID_CNS_NS:
>          return nvme_identify_ns(n, c);
> +    case NVME_ID_CNS_CS_NS:
> +        return nvme_identify_ns_csi(n, c);
>      case NVME_ID_CNS_CTRL:
>          return nvme_identify_ctrl(n, c);
> +    case NVME_ID_CNS_CS_CTRL:
> +        return nvme_identify_ctrl_csi(n, c);
>      case NVME_ID_CNS_NS_ACTIVE_LIST:
>          return nvme_identify_nslist(n, c);
> +    case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
> +        return nvme_identify_nslist_csi(n, c);
> +    case NVME_ID_CNS_NS_DESC_LIST:
> +        return nvme_list_ns_descriptors(n, c);
> +    case NVME_ID_CNS_IO_COMMAND_SET:
> +        return nvme_identify_cmd_set(n, c);
>      default:
>          trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -818,6 +972,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_get_feature_timestamp(n, cmd);
> +    case NVME_COMMAND_SET_PROFILE:
> +        result = 0;
> +        break;
>      default:
>          trace_pci_nvme_err_invalid_getfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -864,6 +1021,15 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
> +        break;
> +
> +    case NVME_COMMAND_SET_PROFILE:
> +        if (dw11 & 0x1ff) {
> +            trace_pci_nvme_err_invalid_iocsci(dw11 & 0x1ff);
> +            return NVME_CMD_SET_CMB_REJECTED | NVME_DNR;
> +        }
> +        break;
> +
>      default:
>          trace_pci_nvme_err_invalid_setfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1149,6 +1315,29 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
>          break;
>      case 0x14:  /* CC */
>          trace_pci_nvme_mmio_cfg(data & 0xffffffff);
> +
> +        if (NVME_CC_CSS(data) != NVME_CC_CSS(n->bar.cc)) {
> +            if (NVME_CC_EN(n->bar.cc)) {
> +                NVME_GUEST_ERR(pci_nvme_err_change_css_when_enabled,
> +                               "changing selected command set when enabled");
> +                break;
> +            }
> +            switch (NVME_CC_CSS(data)) {
> +            case CSS_NVM_ONLY:
> +                trace_pci_nvme_css_nvm_cset_selected_by_host(data & 0xffffffff);
> +                break;
> +            case CSS_ALL_NSTYPES:
> +                NVME_SET_CC_CSS(n->bar.cc, CSS_ALL_NSTYPES);
> +                trace_pci_nvme_css_all_csets_sel_by_host(data & 0xffffffff);
> +                break;
> +            case CSS_ADMIN_ONLY:
> +                break;
> +            default:
> +                NVME_GUEST_ERR(pci_nvme_ub_unknown_css_value,
> +                               "unknown value in CC.CSS field");
> +            }
> +        }
> +
>          /* Windows first sends data, then sends enable bit */
>          if (!NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc) &&
>              !NVME_CC_SHN(data) && !NVME_CC_SHN(n->bar.cc))
> @@ -1496,6 +1685,7 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>  {
>      int64_t bs_size;
>      NvmeIdNs *id_ns = &ns->id_ns;
> +    int lba_index;
>  
>      bs_size = blk_getlength(n->conf.blk);
>      if (bs_size < 0) {
> @@ -1505,7 +1695,10 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>  
>      n->ns_size = bs_size;
>  
> -    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> +    ns->csi = NVME_CSI_NVM;
> +    qemu_uuid_generate(&ns->uuid); /* TODO make UUIDs persistent */
> +    lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);

There is only one LBA format at this point anyway, so I don't think this
is needed.

> +    id_ns->lbaf[lba_index].ds = nvme_ilog2(n->conf.logical_block_size);

Would be nice to have this in a separate patch.

>      id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
>  
>      /* no thin provisioning */
> @@ -1616,7 +1809,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>      id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
>      strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
> -    strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
> +    strpadcpy((char *)id->fr, sizeof(id->fr), "2.0", ' ');

Out of curiosity, any specific reason for bumping the firmware revision?

>      strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
>      id->rab = 6;
>      id->ieee[0] = 0x00;
> @@ -1640,7 +1833,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
>      NVME_CAP_SET_CQR(n->bar.cap, 1);
>      NVME_CAP_SET_TO(n->bar.cap, 0xf);
> -    NVME_CAP_SET_CSS(n->bar.cap, 1);
> +    /*
> +     * The driver now always supports NS Types, but all commands that

s/driver/device

> +     * support CSI field will only handle NVM Command Set.
> +     */
> +    NVME_CAP_SET_CSS(n->bar.cap, (CAP_CSS_NVM | CAP_CSS_CSI_SUPP));
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
>  
>      n->bar.vs = 0x00010200;
> @@ -1650,6 +1847,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>  static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      NvmeCtrl *n = NVME(pci_dev);
> +    NvmeNamespace *ns;
>      Error *local_err = NULL;
>  
>      int i;
> @@ -1675,8 +1873,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>  
>      nvme_init_ctrl(n, pci_dev);
>  
> -    for (i = 0; i < n->num_namespaces; i++) {
> -        nvme_init_namespace(n, &n->namespaces[i], &local_err);
> +    ns = n->namespaces;
> +    for (i = 0; i < n->num_namespaces; i++, ns++) {
> +        ns->nsid = i + 1;

n->num_namespaces is hardcoded to 1, so no real need for this change,
but cleanup is always nice I guess :)

> +        nvme_init_namespace(n, ns, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 4fd155c409..0d29f75475 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -121,4 +121,15 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
>      return n->ns_size >> nvme_ns_lbads(ns);
>  }
>  
> +static inline int nvme_ilog2(uint64_t i)
> +{
> +    int log = -1;
> +
> +    while (i) {
> +        i >>= 1;
> +        log++;
> +    }
> +    return log;
> +}
> +
>  #endif /* HW_NVME_H */
> -- 
> 2.21.0
> 
> 

