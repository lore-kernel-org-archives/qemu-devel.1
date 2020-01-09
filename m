Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023BEC33CA1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E982072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FC1kvige"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E982072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipW76-000848-SM
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1ipW5u-0006sX-B4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1ipW5r-0003mu-Gt
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:35:18 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:42477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1ipW5r-0003jD-5y
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:35:15 -0500
Received: by mail-io1-xd41.google.com with SMTP id n11so6712352iom.9
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gbgQct5Ke5rkWL0/k8bfreG0awt6gv9kBh1cT1hSBTE=;
 b=FC1kvigeqyDg5iW/Y2dZzlUmJx6+Tox1UDmTpLj8wHPvjvWbkFRSUR117dhLGHn6uj
 SDGpN5PQ2aqFRvPIWNhIvJyyamozOz13sYJDC1gzsKElvNOUM3GnohL7FmMWA0qgP6br
 PBjCRQjLoCxrXxZK88kLbvBc6V+Ed613OFj9qvrRug+91WAJPmDuVH3IPGDnwOiugV7t
 CT2Dpvvlw3M33TCz0ZvhgBGSEkTLac4uSPtf2Z+hqg+kWgQd7v1X3y7OG0FPQCNRBC+v
 BAjXESGkn/7gwopiUX6i4b/2vhz+GRQA/DPwfBlpUxMrNgX/Fuw0AVq4J+qtg40CLZ+k
 +fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gbgQct5Ke5rkWL0/k8bfreG0awt6gv9kBh1cT1hSBTE=;
 b=eBl5b44YTeXKmK2G2wWVQKjceLWsHBqNg3moqciGOZ8VnqNAPqVgGrY9/MvgEHaDfv
 sD3b07fWBJEQs66vMsL7gqzc38JaW9mLaE9Y0VpoES1Vr4P/4FLTYfRtP3bBp2IMVscZ
 QgfyGwK4jGsuzf3DXd2McJF2eBJNGxCxQJ/d4xRNuwIsan437KXuOqiJIF4Ru7G/1T+8
 09K6BXqnKi9FjpvcW59wAMiExXHz30ixTcgiYXWTI21Ji981/RFt0EHxgBlQRKW/BF9+
 a+BePi32Z7Po6J/mDOZ+ftv5qFJetEFayf6yRHGaNoXWgGeu/ZA/Lx/PS+6QXfb4IS9x
 SsiQ==
X-Gm-Message-State: APjAAAWdZXhVNf93a4rAedey1K9yPKAZxf2DEeSG23ApYVkzjVVez6n0
 ZrZdJzhnqFlWK5mMh9rNIcIkoPNrHkIPwA2YCY2DJg==
X-Google-Smtp-Source: APXvYqy0c8J8SNY14QNkqsgBCjZrK7eNlD+viwV7/kH+qTto4AcGQ8LpMViaN1/T0MxrfNhBH8H+PfhdeY8AfqHsW+I=
X-Received: by 2002:a02:620c:: with SMTP id d12mr8602793jac.116.1578569714076; 
 Thu, 09 Jan 2020 03:35:14 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191219130947eucas1p21cf4cec3d0b63850ab0e35aa5fab62b8@eucas1p2.samsung.com>
 <20191219130921.309264-1-k.jensen@samsung.com>
 <20191219130921.309264-20-k.jensen@samsung.com>
In-Reply-To: <20191219130921.309264-20-k.jensen@samsung.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Thu, 9 Jan 2020 11:35:02 +0000
Message-ID: <CADSWDzvedgUVQQx0Pc6gw1hZVtDpOFayXRMUny-7PHf+oFga3g@mail.gmail.com>
Subject: Re: [PATCH v4 19/24] nvme: handle dma errors
To: Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On Thu, 19 Dec 2019 at 13:09, Klaus Jensen <k.jensen@samsung.com> wrote:
>
> Handling DMA errors gracefully is required for the device to pass the
> block/011 test ("disable PCI device while doing I/O") in the blktests
> suite.
>
> With this patch the device passes the test by retrying "critical"
> transfers (posting of completion entries and processing of submission
> queue entries).
>
> If DMA errors occur at any other point in the execution of the command
> (say, while mapping the PRPs), the command is aborted with a Data
> Transfer Error status code.
>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 37 +++++++++++++++++++++++++++++--------
>  hw/block/trace-events |  2 ++
>  include/block/nvme.h  |  2 +-
>  3 files changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 56659bbe263a..f6591285b504 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -71,14 +71,14 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>      return addr >= low && addr < hi;
>  }
>
> -static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> +static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  {
>      if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
>          memcpy(buf, (void *) &n->cmbuf[addr - n->ctrl_mem.addr], size);
> -        return;
> +        return 0;
>      }
>
> -    pci_dma_read(&n->parent_obj, addr, buf, size);
> +    return pci_dma_read(&n->parent_obj, addr, buf, size);
>  }
>
>  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
> @@ -216,7 +216,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>
>              nents = (len + n->page_size - 1) >> n->page_bits;
>              prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> -            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
> +            if (nvme_addr_read(n, prp2, (void *) prp_list, prp_trans)) {
> +                trace_nvme_dev_err_addr_read(prp2);
> +                status = NVME_DATA_TRANSFER_ERROR;
> +                goto unmap;
> +            }
>              while (len != 0) {
>                  uint64_t prp_ent = le64_to_cpu(prp_list[i]);
>
> @@ -235,7 +239,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>                      i = 0;
>                      nents = (len + n->page_size - 1) >> n->page_bits;
>                      prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> -                    nvme_addr_read(n, prp_ent, (void *) prp_list, prp_trans);
> +                    if (nvme_addr_read(n, prp_ent, (void *) prp_list, prp_trans)) {
> +                        trace_nvme_dev_err_addr_read(prp_ent);
> +                        status = NVME_DATA_TRANSFER_ERROR;
> +                        goto unmap;
> +                    }
>                      prp_ent = le64_to_cpu(prp_list[i]);
>                  }
>
> @@ -456,6 +464,7 @@ static void nvme_post_cqes(void *opaque)
>      NvmeCQueue *cq = opaque;
>      NvmeCtrl *n = cq->ctrl;
>      NvmeRequest *req, *next;
> +    int ret;
>
>      QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
>          NvmeSQueue *sq;
> @@ -471,9 +480,16 @@ static void nvme_post_cqes(void *opaque)
>          req->cqe.sq_id = cpu_to_le16(sq->sqid);
>          req->cqe.sq_head = cpu_to_le16(sq->head);
>          addr = cq->dma_addr + cq->tail * n->cqe_size;
> -        nvme_inc_cq_tail(cq);
> -        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> +        ret = pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
>              sizeof(req->cqe));
> +        if (ret) {
> +            trace_nvme_dev_err_addr_write(addr);
> +            QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
> +            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                100 * SCALE_MS);
> +            break;
> +        }
> +        nvme_inc_cq_tail(cq);
>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>      }
>      if (cq->tail != cq->head) {
> @@ -1595,7 +1611,12 @@ static void nvme_process_sq(void *opaque)
>
>      while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
>          addr = sq->dma_addr + sq->head * n->sqe_size;
> -        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
> +        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
> +            trace_nvme_dev_err_addr_read(addr);
> +            timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                100 * SCALE_MS);
> +            break;
> +        }

Is there a chance we will end up repeatedly triggering the read error here
as this will come back to the same memory location each time (the sq->head
is not moving here) ?


BR
Beata

>          nvme_inc_sq_head(sq);
>
>          req = QTAILQ_FIRST(&sq->req_list);
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 90a57fb6099a..09bfb3782dd0 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -83,6 +83,8 @@ nvme_dev_mmio_shutdown_cleared(void) "shutdown bit cleared"
>  nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts %"PRIu64" len %"PRIu64""
>  nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu16""
>  nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
> +nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
> +nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
>  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
>  nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
>  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index c1de92179596..a873776d98b8 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -418,7 +418,7 @@ enum NvmeStatusCodes {
>      NVME_INVALID_OPCODE         = 0x0001,
>      NVME_INVALID_FIELD          = 0x0002,
>      NVME_CID_CONFLICT           = 0x0003,
> -    NVME_DATA_TRAS_ERROR        = 0x0004,
> +    NVME_DATA_TRANSFER_ERROR    = 0x0004,
>      NVME_POWER_LOSS_ABORT       = 0x0005,
>      NVME_INTERNAL_DEV_ERROR     = 0x0006,
>      NVME_CMD_ABORT_REQ          = 0x0007,
> --
> 2.24.1
>

