Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 01:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE70A2237B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 01:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="flzHJPRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE70A2237B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVOzK-0003UG-BX
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 21:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kVOxJ-0002pK-DG; Wed, 21 Oct 2020 20:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kVOxG-0001yq-B3; Wed, 21 Oct 2020 20:59:48 -0400
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B714A2237B;
 Thu, 22 Oct 2020 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603328384;
 bh=cMAn9LpEIzE8/UlkUGW7LWo2dCvfL6r//NAYffT0j8Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=flzHJPRclutPgQ2MVdRJcwEjfEaY0iV8NvAVu/V0Cwz+QIr0B8nc6VRpIWUcCNzDi
 N8eOyKDaLwalLYJwAB1ZfvYVwO/jeQiaHuqba1s3P9V30/rl+hUIq47kjB2dYLyNxg
 uXoaIIqnDE5SrgWxR59E501I1pqNdN/+0ijS5zYk=
Date: Wed, 21 Oct 2020 17:59:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v3 2/2] hw/block/nvme: add the dataset management command
Message-ID: <20201022005941.GB1663557@dhcp-10-100-145-180.wdc.com>
References: <20201021221736.100779-1-its@irrelevant.dk>
 <20201021221736.100779-3-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021221736.100779-3-its@irrelevant.dk>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 20:55:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 12:17:36AM +0200, Klaus Jensen wrote:
> +static void nvme_aio_discard_cb(void *opaque, int ret)
> +{
> +    NvmeRequest *req = opaque;
> +    int *discards = req->opaque;
> +
> +    trace_pci_nvme_aio_discard_cb(nvme_cid(req));
> +
> +    if (ret) {
> +        req->status = NVME_INTERNAL_DEV_ERROR;
> +        trace_pci_nvme_err_aio(nvme_cid(req), strerror(ret),
> +                               req->status);
> +    }
> +
> +    if (discards && --(*discards) > 0) {
> +        return;
> +    }
> +
> +    g_free(req->opaque);
> +    req->opaque = NULL;
> +
> +    nvme_enqueue_req_completion(nvme_cq(req), req);
> +}
> +
> +static uint16_t nvme_dsm(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeNamespace *ns = req->ns;
> +    NvmeDsmCmd *dsm = (NvmeDsmCmd *) &req->cmd;
> +    NvmeDsmRange *range = NULL;
> +    int *discards = NULL;
> +
> +    uint32_t attr = le32_to_cpu(dsm->attributes);
> +    uint32_t nr = (le32_to_cpu(dsm->nr) & 0xff) + 1;
> +
> +    uint16_t status = NVME_SUCCESS;
> +
> +    trace_pci_nvme_dsm(nvme_cid(req), nvme_nsid(ns), nr, attr);
> +
> +    if (attr & NVME_DSMGMT_AD) {
> +        int64_t offset;
> +        size_t len;
> +
> +        range = g_new(NvmeDsmRange, nr);
> +
> +        status = nvme_dma(n, (uint8_t *)range, nr * sizeof(NvmeDsmRange),
> +                          DMA_DIRECTION_TO_DEVICE, req);
> +        if (status) {
> +            goto out;
> +        }
> +
> +        discards = g_new0(int, 1);
> +        req->opaque = discards;

I think you need to initialize discards to 1 so that this function is
holding a reference on it while the asynchronous part is running.
Otherwise, the callback may see 'discards' at 0 and free it while we're
trying to discard the next range.

> +
> +        for (int i = 0; i < nr; i++) {
> +            uint64_t slba = le64_to_cpu(range[i].slba);
> +            uint32_t nlb = le32_to_cpu(range[i].nlb);
> +
> +            if (nvme_check_bounds(n, ns, slba, nlb)) {
> +                trace_pci_nvme_err_invalid_lba_range(slba, nlb,
> +                                                     ns->id_ns.nsze);
> +                continue;
> +            }
> +
> +            trace_pci_nvme_dsm_deallocate(nvme_cid(req), nvme_nsid(ns), slba,
> +                                          nlb);
> +
> +            offset = nvme_l2b(ns, slba);
> +            len = nvme_l2b(ns, nlb);
> +
> +            while (len) {
> +                size_t bytes = MIN(BDRV_REQUEST_MAX_BYTES, len);
> +
> +                blk_aio_pdiscard(ns->blkconf.blk, offset, bytes,
> +                                 nvme_aio_discard_cb, req);
> +
> +                (*discards)++;

The increment ought to be before the aio call so that the _cb can't see
the value before it's accounted for. 

> +
> +                offset += bytes;
> +                len -= bytes;
> +            }
> +        }
> +
> +        if (*discards) {
> +            status = NVME_NO_COMPLETE;
> +        } else {
> +            g_free(discards);
> +            req->opaque = NULL;
> +        }
> +    }
> +
> +out:
> +    g_free(range);
> +
> +    return status;
> +}
> +
>  static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
>  {
>      block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,
> @@ -1088,6 +1183,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
>      case NVME_CMD_WRITE:
>      case NVME_CMD_READ:
>          return nvme_rw(n, req);
> +    case NVME_CMD_DSM:
> +        return nvme_dsm(n, req);
>      default:
>          trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
> @@ -2810,7 +2907,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
>      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
> -                           NVME_ONCS_FEATURES);
> +                           NVME_ONCS_FEATURES | NVME_ONCS_DSM);

I think we should set ID_NS.NDPG and NDPA since there really is a
preferred granularity and alignment.

>  
>      id->vwc = 0x1;
>      id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
> -- 
> 2.28.0
> 

