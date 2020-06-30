Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B052C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD782067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD782067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq8BG-00066h-Iu
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 00:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq8Ac-0005Ze-2C; Tue, 30 Jun 2020 00:46:58 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq8Aa-0006gb-2t; Tue, 30 Jun 2020 00:46:57 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id A0109BF670;
 Tue, 30 Jun 2020 04:46:53 +0000 (UTC)
Date: Tue, 30 Jun 2020 06:46:50 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 04/18] hw/block/nvme: Add Commands Supported and
 Effects log
Message-ID: <20200630044650.rnfrijqgwxt537ky@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-5-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-5-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:09:10
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
> This log page becomes necessary to implement to allow checking for
> Zone Append command support in Zoned Namespace Command Set.
> 
> This commit adds the code to report this log page for NVM Command
> Set only. The parts that are specific to zoned operation will be
> added later in the series.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c       | 62 +++++++++++++++++++++++++++++++++++++++++++
>  hw/block/trace-events |  4 +++
>  include/block/nvme.h  | 18 +++++++++++++
>  3 files changed, 84 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index a1bbc9acde..03b8deee85 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -871,6 +871,66 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> +static uint16_t nvme_handle_cmd_effects(NvmeCtrl *n, NvmeCmd *cmd,
> +    uint64_t prp1, uint64_t prp2, uint64_t ofs, uint32_t len)
> +{
> +   NvmeEffectsLog cmd_eff_log = {};
> +   uint32_t *iocs = cmd_eff_log.iocs;
> +
> +    trace_pci_nvme_cmd_supp_and_effects_log_read();
> +
> +    if (ofs != 0) {
> +        trace_pci_nvme_err_invalid_effects_log_offset(ofs);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +    if (len != sizeof(cmd_eff_log)) {
> +        trace_pci_nvme_err_invalid_effects_log_len(len);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }

I don't see why you cannot request a subset of the page like any log
page?

> +
> +    iocs[NVME_ADM_CMD_DELETE_SQ] = NVME_CMD_EFFECTS_CSUPP;
> +    iocs[NVME_ADM_CMD_CREATE_SQ] = NVME_CMD_EFFECTS_CSUPP;
> +    iocs[NVME_ADM_CMD_DELETE_CQ] = NVME_CMD_EFFECTS_CSUPP;
> +    iocs[NVME_ADM_CMD_CREATE_CQ] = NVME_CMD_EFFECTS_CSUPP;
> +    iocs[NVME_ADM_CMD_IDENTIFY] = NVME_CMD_EFFECTS_CSUPP;
> +    iocs[NVME_ADM_CMD_SET_FEATURES] = NVME_CMD_EFFECTS_CSUPP;
> +    iocs[NVME_ADM_CMD_GET_FEATURES] = NVME_CMD_EFFECTS_CSUPP;
> +    iocs[NVME_ADM_CMD_GET_LOG_PAGE] = NVME_CMD_EFFECTS_CSUPP;

These are admin commands and should go to acs.

> +
> +    iocs[NVME_CMD_FLUSH] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
> +    iocs[NVME_CMD_WRITE_ZEROS] = NVME_CMD_EFFECTS_CSUPP |
> +                                 NVME_CMD_EFFECTS_LBCC;
> +    iocs[NVME_CMD_WRITE] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
> +    iocs[NVME_CMD_READ] = NVME_CMD_EFFECTS_CSUPP;
> +
> +    return nvme_dma_read_prp(n, (uint8_t *)&cmd_eff_log, len, prp1, prp2);
> +}
> +
> +static uint16_t nvme_get_log_page(NvmeCtrl *n, NvmeCmd *cmd)
> +{
> +    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> +    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> +    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> +    uint64_t dw12 = le32_to_cpu(cmd->cdw12);
> +    uint64_t dw13 = le32_to_cpu(cmd->cdw13);
> +    uint64_t ofs = (dw13 << 32) | dw12;
> +    uint32_t numdl, numdu, len;
> +    uint16_t lid = dw10 & 0xff;
> +
> +    numdl = dw10 >> 16;
> +    numdu = dw11 & 0xffff;
> +    len = (((numdu << 16) | numdl) + 1) << 2;
> +
> +    switch (lid) {
> +    case NVME_LOG_CMD_EFFECTS:
> +        return nvme_handle_cmd_effects(n, cmd, prp1, prp2, ofs, len);
> +    }
> +
> +    trace_pci_nvme_unsupported_log_page(lid);
> +    return NVME_INVALID_FIELD | NVME_DNR;
> +}

The controller should set bit 2 of the LPA field to indicate support for
extended data.

> +
>  static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      switch (cmd->opcode) {
> @@ -888,6 +948,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_set_feature(n, cmd, req);
>      case NVME_ADM_CMD_GET_FEATURES:
>          return nvme_get_feature(n, cmd, req);
> +    case NVME_ADM_CMD_GET_LOG_PAGE:
> +        return nvme_get_log_page(n, cmd);
>      default:
>          trace_pci_nvme_err_invalid_admin_opc(cmd->opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 958fcc5508..423d491e27 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -58,6 +58,7 @@ pci_nvme_mmio_start_success(void) "setting controller enable bit succeeded"
>  pci_nvme_mmio_stopped(void) "cleared controller enable bit"
>  pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
>  pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
> +pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and effects log read"
>  
>  # nvme traces for error conditions
>  pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
> @@ -69,6 +70,8 @@ pci_nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u not w
>  pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
>  pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
>  pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
> +pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
> +pci_nvme_err_invalid_effects_log_len(uint32_t len) "commands supported and effects log size is 4096, got %"PRIu32""
>  pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
>  pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
>  pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
> @@ -123,6 +126,7 @@ pci_nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write for
>  pci_nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion queue doorbell write value beyond queue size, cqid=%"PRIu32", new_head=%"PRIu16", ignoring"
>  pci_nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
>  pci_nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
> +pci_nvme_unsupported_log_page(uint16_t lid) "unsupported log page 0x%"PRIx16""
>  
>  # xen-block.c
>  xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 3099df99eb..6a58bac0c2 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -691,10 +691,27 @@ enum NvmeSmartWarn {
>      NVME_SMART_FAILED_VOLATILE_MEDIA  = 1 << 4,
>  };
>  
> +typedef struct NvmeEffectsLog {
> +  uint32_t      acs[256];
> +  uint32_t      iocs[256];
> +  uint8_t       resv[2048];
> +} NvmeEffectsLog;
> +
> +enum {
> +   NVME_CMD_EFFECTS_CSUPP             = 1 << 0,
> +   NVME_CMD_EFFECTS_LBCC              = 1 << 1,
> +   NVME_CMD_EFFECTS_NCC               = 1 << 2,
> +   NVME_CMD_EFFECTS_NIC               = 1 << 3,
> +   NVME_CMD_EFFECTS_CCC               = 1 << 4,
> +   NVME_CMD_EFFECTS_CSE_MASK          = 3 << 16,
> +   NVME_CMD_EFFECTS_UUID_SEL          = 1 << 19,
> +};
> +
>  enum LogIdentifier {
>      NVME_LOG_ERROR_INFO     = 0x01,
>      NVME_LOG_SMART_INFO     = 0x02,
>      NVME_LOG_FW_SLOT_INFO   = 0x03,
> +    NVME_LOG_CMD_EFFECTS    = 0x05,
>  };
>  
>  typedef struct NvmePSD {
> @@ -898,5 +915,6 @@ static inline void _nvme_check_size(void)
>      QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
>  }
>  #endif
> -- 
> 2.21.0
> 
> 

