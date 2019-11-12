Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D5DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E7F21D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qD1dCNl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E7F21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUY2G-0006oy-VG
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iUY1P-0005xk-P8
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iUY1M-0004sH-Ow
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:23:59 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:42606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iUY1M-0004rz-GC
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:23:56 -0500
Received: by mail-il1-x141.google.com with SMTP id n18so15858721ilt.9
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W1Vb4ddRBhBV4us1jKgRQWY6035ih7yIFS3MH4hIKAA=;
 b=qD1dCNl6MLZvquthIpcGTlxSQoCRjdfeC4v8/F0+fiM9nDdkGFwbNxmYzfWAx/MPV2
 DJYFs+6hLYPaTH8AzQ/ZlIy+TXd5NuFz86AbaJUlcKuLKA91GW67OSz/GkUL0w339ChN
 42asLl7RnfTp1S4KgBxOVIOfBSpiFuRitcQWoVEw9H7hSgS9QH8ontkZdCP2qfWYy3NC
 y64reQ3oHSKhQy0u1VKNDIU/2Jltmc3rbxBVRcelM5YgVbWYrtA60D2MQNVQY5oOe9CM
 4pAAfVNP7t8vWFZHUPgJE0Q9p1lbOfm+j/jBuonGC+UVLF8jmqN3QYINyzPXMnGv7I27
 Fumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W1Vb4ddRBhBV4us1jKgRQWY6035ih7yIFS3MH4hIKAA=;
 b=rR9R5XqSmBw2wBLxu2Nj4FdCJB0PEoRqakP9PeC75z1320p3M74ujc2b8+9ipjvHp6
 hzz4FJh/vUZgbNogVmVOu0KQhcAcyyU3ViOnAvklBOeNZUyYj4VBOw9nim++DLBOGoOH
 qEatWo55QF057t7WB5pjmzZg3HhC97HhSC3YKrUANkennZ8wy/eUsGnVaJiaWQp+gVk0
 2vr1cbYP7gMZGujfR0RIKM+5je5Dc30bqQp6psB9n7jLy58WcSEw8DqZsf567d3hBd1S
 vrveSb6zlY4gYzDofrnMW7qi4BONX7Tb+Y1j7esGmvPbp4WqSiBcVEXX5gbh/xXpAcIn
 04SA==
X-Gm-Message-State: APjAAAW5bSt+tGD3KwTsXuBciDcF+npqgdDrQbxci82pd2J4/34TTJVr
 QJpM9yJi6H89YnM+fdwKF0O6gxfL40hULpdcVnT7ew==
X-Google-Smtp-Source: APXvYqxUFz7McBb/YkEkJGWwb1MCSTJzu9FGVIGwV8giPsyGMHVXlCshGPeidu6NfMfLkmyGYO1u+0bhBvyJL0jhQwk=
X-Received: by 2002:a92:60b:: with SMTP id x11mr35275176ilg.69.1573572234991; 
 Tue, 12 Nov 2019 07:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-14-its@irrelevant.dk>
In-Reply-To: <20191015103900.313928-14-its@irrelevant.dk>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 12 Nov 2019 15:23:43 +0000
Message-ID: <CADSWDzs6mECPKv2qAojEF75Vxi1i5_2fkvDtjWkQU22F9a4a7g@mail.gmail.com>
Subject: Re: [PATCH v2 13/20] nvme: refactor prp mapping
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Javier Gonzalez <javier@javigon.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On Tue, 15 Oct 2019 at 11:57, Klaus Jensen <its@irrelevant.dk> wrote:
>
> Instead of handling both QSGs and IOVs in multiple places, simply use
> QSGs everywhere by assuming that the request does not involve the
> controller memory buffer (CMB). If the request is found to involve the
> CMB, convert the QSG to an IOV and issue the I/O. The QSG is converted
> to an IOV by the dma helpers anyway, so the CMB path is not unfairly
> affected by this simplifying change.
>

Out of curiosity, in how many cases the SG list will have to
be converted to IOV ? Does that justify creating the SG list in vain ?

> As a side-effect, this patch also allows PRPs to be located in the CMB.
> The logic ensures that if some of the PRP is in the CMB, all of it must
> be located there, as per the specification.
>
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c       | 255 ++++++++++++++++++++++++++++--------------
>  hw/block/nvme.h       |   4 +-
>  hw/block/trace-events |   1 +
>  include/block/nvme.h  |   1 +
>  4 files changed, 174 insertions(+), 87 deletions(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 1e2320b38b14..cbc0b6a660b6 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -179,138 +179,200 @@ static void nvme_set_error_page(NvmeCtrl *n, uint16_t sqid, uint16_t cid,
>      n->elp_index = (n->elp_index + 1) % n->params.elpe;
>  }
>
> -static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
> -                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
> +static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, uint64_t prp1,
> +    uint64_t prp2, uint32_t len, NvmeRequest *req)
>  {
>      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
>      trans_len = MIN(len, trans_len);
>      int num_prps = (len >> n->page_bits) + 1;
> +    uint16_t status = NVME_SUCCESS;
> +    bool prp_list_in_cmb = false;
> +
> +    trace_nvme_map_prp(req->cid, req->cmd.opcode, trans_len, len, prp1, prp2,
> +        num_prps);
>
>      if (unlikely(!prp1)) {
>          trace_nvme_err_invalid_prp();
>          return NVME_INVALID_FIELD | NVME_DNR;
> -    } else if (n->cmbsz && prp1 >= n->ctrl_mem.addr &&
> -               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
> -        qsg->nsg = 0;
> -        qemu_iovec_init(iov, num_prps);
> -        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
> -    } else {
> -        pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
> -        qemu_sglist_add(qsg, prp1, trans_len);
>      }
> +
> +    if (nvme_addr_is_cmb(n, prp1)) {
> +        req->is_cmb = true;
> +    }
> +
This seems to be used here and within read/write functions which are calling
this one. Maybe there is a nicer way to track that instead of passing
the request
from multiple places ?

> +    pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
> +    qemu_sglist_add(qsg, prp1, trans_len);
> +
>      len -= trans_len;
>      if (len) {
>          if (unlikely(!prp2)) {
>              trace_nvme_err_invalid_prp2_missing();
> +            status = NVME_INVALID_FIELD | NVME_DNR;
>              goto unmap;
>          }
> +
>          if (len > n->page_size) {
>              uint64_t prp_list[n->max_prp_ents];
>              uint32_t nents, prp_trans;
>              int i = 0;
>
> +            if (nvme_addr_is_cmb(n, prp2)) {
> +                prp_list_in_cmb = true;
> +            }
> +
>              nents = (len + n->page_size - 1) >> n->page_bits;
>              prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> -            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
> +            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
>              while (len != 0) {
> +                bool addr_is_cmb;
>                  uint64_t prp_ent = le64_to_cpu(prp_list[i]);
>
>                  if (i == n->max_prp_ents - 1 && len > n->page_size) {
>                      if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
>                          trace_nvme_err_invalid_prplist_ent(prp_ent);
> +                        status = NVME_INVALID_FIELD | NVME_DNR;
> +                        goto unmap;
> +                    }
> +
> +                    addr_is_cmb = nvme_addr_is_cmb(n, prp_ent);
> +                    if ((prp_list_in_cmb && !addr_is_cmb) ||
> +                        (!prp_list_in_cmb && addr_is_cmb)) {

Minor: Same condition (based on different vars) is being used in
multiple places. Might be worth to move it outside and just pass in
the needed values.

> +                        status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
>                          goto unmap;
>                      }
>
>                      i = 0;
>                      nents = (len + n->page_size - 1) >> n->page_bits;
>                      prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> -                    nvme_addr_read(n, prp_ent, (void *)prp_list,
> -                        prp_trans);
> +                    nvme_addr_read(n, prp_ent, (void *) prp_list, prp_trans);
>                      prp_ent = le64_to_cpu(prp_list[i]);
>                  }
>
>                  if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
>                      trace_nvme_err_invalid_prplist_ent(prp_ent);
> +                    status = NVME_INVALID_FIELD | NVME_DNR;
>                      goto unmap;
>                  }
>
> -                trans_len = MIN(len, n->page_size);
> -                if (qsg->nsg){
> -                    qemu_sglist_add(qsg, prp_ent, trans_len);
> -                } else {
> -                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
> +                addr_is_cmb = nvme_addr_is_cmb(n, prp_ent);
> +                if ((req->is_cmb && !addr_is_cmb) ||
> +                    (!req->is_cmb && addr_is_cmb)) {
> +                    status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +                    goto unmap;
>                  }
> +
> +                trans_len = MIN(len, n->page_size);
> +                qemu_sglist_add(qsg, prp_ent, trans_len);
> +
>                  len -= trans_len;
>                  i++;
>              }
>          } else {
> +            bool addr_is_cmb = nvme_addr_is_cmb(n, prp2);
> +            if ((req->is_cmb && !addr_is_cmb) ||
> +                (!req->is_cmb && addr_is_cmb)) {
> +                status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +                goto unmap;
> +            }
> +
>              if (unlikely(prp2 & (n->page_size - 1))) {
>                  trace_nvme_err_invalid_prp2_align(prp2);
> +                status = NVME_INVALID_FIELD | NVME_DNR;
>                  goto unmap;
>              }
> -            if (qsg->nsg) {
> -                qemu_sglist_add(qsg, prp2, len);
> -            } else {
> -                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
> -            }
> +
> +            qemu_sglist_add(qsg, prp2, len);
>          }
>      }
> +
>      return NVME_SUCCESS;
>
> - unmap:
> +unmap:
>      qemu_sglist_destroy(qsg);
> -    return NVME_INVALID_FIELD | NVME_DNR;
> +
> +    return status;
> +}
> +
> +static void dma_to_cmb(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov)
> +{
> +    for (int i = 0; i < qsg->nsg; i++) {
> +        void *addr = &n->cmbuf[qsg->sg[i].base - n->ctrl_mem.addr];
> +        qemu_iovec_add(iov, addr, qsg->sg[i].len);
> +    }
>  }
>
>  static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> -                                   uint64_t prp1, uint64_t prp2)
> +    uint64_t prp1, uint64_t prp2, NvmeRequest *req)
>  {
>      QEMUSGList qsg;
> -    QEMUIOVector iov;
>      uint16_t status = NVME_SUCCESS;
>
> -    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +    status = nvme_map_prp(n, &qsg, prp1, prp2, len, req);
> +    if (status) {
> +        return status;
>      }
> -    if (qsg.nsg > 0) {
> -        if (dma_buf_write(ptr, len, &qsg)) {
> -            status = NVME_INVALID_FIELD | NVME_DNR;
> -        }
> -        qemu_sglist_destroy(&qsg);
> -    } else {
> -        if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
> +
> +    if (req->is_cmb) {
> +        QEMUIOVector iov;
> +
> +        qemu_iovec_init(&iov, qsg.nsg);
> +        dma_to_cmb(n, &qsg, &iov);
> +
> +        if (unlikely(qemu_iovec_to_buf(&iov, 0, ptr, len) != len)) {
> +            trace_nvme_err_invalid_dma();
>              status = NVME_INVALID_FIELD | NVME_DNR;
>          }
> +
>          qemu_iovec_destroy(&iov);
> +
Aren't we missing the sglist cleanup here ?
(goto as in nvme_dma_read_prp)

> +        return status;
> +    }
> +
> +    if (unlikely(dma_buf_write(ptr, len, &qsg))) {
> +        trace_nvme_err_invalid_dma();
> +        status = NVME_INVALID_FIELD | NVME_DNR;
>      }
> +
> +    qemu_sglist_destroy(&qsg);
> +
>      return status;
>  }
>
>  static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> -    uint64_t prp1, uint64_t prp2)
> +    uint64_t prp1, uint64_t prp2, NvmeRequest *req)
>  {
>      QEMUSGList qsg;
> -    QEMUIOVector iov;
>      uint16_t status = NVME_SUCCESS;
>
> -    trace_nvme_dma_read(prp1, prp2);
> -
> -    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +    status = nvme_map_prp(n, &qsg, prp1, prp2, len, req);
> +    if (status) {
> +        return status;
>      }
> -    if (qsg.nsg > 0) {
> -        if (unlikely(dma_buf_read(ptr, len, &qsg))) {
> -            trace_nvme_err_invalid_dma();
> -            status = NVME_INVALID_FIELD | NVME_DNR;
> -        }
> -        qemu_sglist_destroy(&qsg);
> -    } else {
> +
> +    if (req->is_cmb) {
> +        QEMUIOVector iov;
> +
> +        qemu_iovec_init(&iov, qsg.nsg);
> +        dma_to_cmb(n, &qsg, &iov);
> +
>          if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) != len)) {
>              trace_nvme_err_invalid_dma();
>              status = NVME_INVALID_FIELD | NVME_DNR;
>          }
> +
>          qemu_iovec_destroy(&iov);
> +
> +        goto out;
>      }
> +
> +    if (unlikely(dma_buf_read(ptr, len, &qsg))) {
> +        trace_nvme_err_invalid_dma();
> +        status = NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +out:
> +    qemu_sglist_destroy(&qsg);
> +
>      return status;
>  }
>
Aside: both nvme_write_prp and nvme_read_prp seem to differ only
with the final call to either dma or qemu_ioves calls.
Might be worth to unify it and move it to a single function with additional
parameter that will determine the type of the transaction.

> @@ -400,6 +462,7 @@ static void nvme_rw_cb(void *opaque, int ret)
>      NvmeSQueue *sq = req->sq;
>      NvmeCtrl *n = sq->ctrl;
>      NvmeCQueue *cq = n->cq[sq->cqid];
> +    NvmeRwCmd *rw = (NvmeRwCmd *) &req->cmd;
>
>      if (!ret) {
>          block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
> @@ -407,19 +470,23 @@ static void nvme_rw_cb(void *opaque, int ret)
>      } else {
>          block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
>          nvme_set_error_page(n, sq->sqid, cpu_to_le16(req->cid),
> -            NVME_INTERNAL_DEV_ERROR, 0, 0, 1);
> +            NVME_INTERNAL_DEV_ERROR, offsetof(NvmeRwCmd, slba), rw->slba, 1);
>          req->status = NVME_INTERNAL_DEV_ERROR | NVME_MORE;
>      }
> -    if (req->has_sg) {
> +
> +    if (req->qsg.nalloc) {
>          qemu_sglist_destroy(&req->qsg);
>      }
> +    if (req->iov.nalloc) {
> +        qemu_iovec_destroy(&req->iov);
> +    }
> +
>      nvme_enqueue_req_completion(cq, req);
>  }
>
>  static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
> -    req->has_sg = false;
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>           BLOCK_ACCT_FLUSH);
>      req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
> @@ -443,7 +510,6 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>
> -    req->has_sg = false;
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>                       BLOCK_ACCT_WRITE);
>      req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
> @@ -475,21 +541,21 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>
> -    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
> +    if (nvme_map_prp(n, &req->qsg, prp1, prp2, data_size, req)) {
>          block_acct_invalid(blk_get_stats(n->conf.blk), acct);
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>
>      dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
> -    if (req->qsg.nsg > 0) {
> -        req->has_sg = true;
> +    if (!req->is_cmb) {
>          req->aiocb = is_write ?
>              dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
>                            nvme_rw_cb, req) :
>              dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
>                           nvme_rw_cb, req);
>      } else {
> -        req->has_sg = false;
> +        qemu_iovec_init(&req->iov, req->qsg.nsg);
> +        dma_to_cmb(n, &req->qsg, &req->iov);
>          req->aiocb = is_write ?
>              blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
>                              req) :
> @@ -587,7 +653,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
>      sq->size = size;
>      sq->cqid = cqid;
>      sq->head = sq->tail = 0;
> -    sq->io_req = g_new(NvmeRequest, sq->size);
> +    sq->io_req = g_new0(NvmeRequest, sq->size);
>
>      QTAILQ_INIT(&sq->req_list);
>      QTAILQ_INIT(&sq->out_req_list);
> @@ -660,7 +726,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>      }
>
>      return nvme_dma_read_prp(n, (uint8_t *) n->elpes + off, trans_len, prp1,
> -        prp2);
> +        prp2, req);
>  }
>
>  static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> @@ -719,7 +785,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>      }
>
>      return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
> -        prp2);
> +        prp2, req);
>  }
>
>  static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> @@ -739,7 +805,7 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
>      trans_len = MIN(sizeof(fw_log) - off, buf_len);
>
>      return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
> -        prp2);
> +        prp2, req);
>  }
>
>  static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -875,7 +941,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
>      return NVME_SUCCESS;
>  }
>
> -static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
> +static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
> +    NvmeRequest *req)
>  {
>      uint64_t prp1 = le64_to_cpu(c->prp1);
>      uint64_t prp2 = le64_to_cpu(c->prp2);
> @@ -883,10 +950,11 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
>      trace_nvme_identify_ctrl();
>
>      return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
> -        prp1, prp2);
> +        prp1, prp2, req);
>  }
>
> -static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
> +static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
> +    NvmeRequest *req)
>  {
>      NvmeNamespace *ns;
>      uint32_t nsid = le32_to_cpu(c->nsid);
> @@ -903,10 +971,11 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
>      ns = &n->namespaces[nsid - 1];
>
>      return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
> -        prp1, prp2);
> +        prp1, prp2, req);
>  }
>
> -static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
> +static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
> +    NvmeRequest *req)
>  {
>      static const int data_len = 4 * KiB;
>      uint32_t min_nsid = le32_to_cpu(c->nsid);
> @@ -928,12 +997,13 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
>              break;
>          }
>      }
> -    ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
> +    ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2, req);
>      g_free(list);
>      return ret;
>  }
>
> -static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
> +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
> +    NvmeRequest *req)
>  {
>      static const int len = 4096;
>
> @@ -963,24 +1033,24 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
>      list->nidl = 0x10;
>      *(uint32_t *) &list->nid[12] = cpu_to_be32(nsid);
>
> -    ret = nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2);
> +    ret = nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2, req);
>      g_free(list);
>      return ret;
>  }
>
> -static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> +static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      NvmeIdentify *c = (NvmeIdentify *)cmd;
>
>      switch (le32_to_cpu(c->cns)) {
>      case 0x00:
> -        return nvme_identify_ns(n, c);
> +        return nvme_identify_ns(n, c, req);
>      case 0x01:
> -        return nvme_identify_ctrl(n, c);
> +        return nvme_identify_ctrl(n, c, req);
>      case 0x02:
> -        return nvme_identify_ns_list(n, c);
> +        return nvme_identify_ns_list(n, c, req);
>      case 0x03:
> -        return nvme_identify_ns_descr_list(n, cmd);
> +        return nvme_identify_ns_descr_list(n, c, req);
>      default:
>          trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1039,15 +1109,16 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
>      return cpu_to_le64(ts.all);
>  }
>
> -static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> +static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> +    NvmeRequest *req)
>  {
>      uint64_t prp1 = le64_to_cpu(cmd->prp1);
>      uint64_t prp2 = le64_to_cpu(cmd->prp2);
>
>      uint64_t timestamp = nvme_get_timestamp(n);
>
> -    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
> -                                 sizeof(timestamp), prp1, prp2);
> +    return nvme_dma_read_prp(n, (uint8_t *)&timestamp, sizeof(timestamp),
> +        prp1, prp2, req);
>  }
>
>  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> @@ -1081,7 +1152,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          trace_nvme_getfeat_numq(result);
>          break;
>      case NVME_TIMESTAMP:
> -        return nvme_get_feature_timestamp(n, cmd);
> +        return nvme_get_feature_timestamp(n, cmd, req);
>      case NVME_INTERRUPT_COALESCING:
>          result = cpu_to_le32(n->features.int_coalescing);
>          break;
> @@ -1107,7 +1178,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>
> -static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> +static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> +    NvmeRequest *req)
>  {
>      uint16_t ret;
>      uint64_t timestamp;
> @@ -1115,7 +1187,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
>      uint64_t prp2 = le64_to_cpu(cmd->prp2);
>
>      ret = nvme_dma_write_prp(n, (uint8_t *)&timestamp,
> -                                sizeof(timestamp), prp1, prp2);
> +                                sizeof(timestamp), prp1, prp2, req);
>      if (ret != NVME_SUCCESS) {
>          return ret;
>      }
> @@ -1163,7 +1235,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>              ((n->params.num_queues - 2) << 16));
>          break;
>      case NVME_TIMESTAMP:
> -        return nvme_set_feature_timestamp(n, cmd);
> +        return nvme_set_feature_timestamp(n, cmd, req);
>      case NVME_ASYNCHRONOUS_EVENT_CONF:
>          n->features.async_config = dw11;
>          break;
> @@ -1212,7 +1284,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      case NVME_ADM_CMD_CREATE_CQ:
>          return nvme_create_cq(n, cmd);
>      case NVME_ADM_CMD_IDENTIFY:
> -        return nvme_identify(n, cmd);
> +        return nvme_identify(n, cmd, req);
>      case NVME_ADM_CMD_ABORT:
>          return nvme_abort(n, cmd, req);
>      case NVME_ADM_CMD_SET_FEATURES:
> @@ -1273,6 +1345,18 @@ static void nvme_process_aers(void *opaque)
>      }
>  }
>
> +static void nvme_init_req(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    memset(&req->cqe, 0, sizeof(req->cqe));
> +    req->cqe.cid = cmd->cid;
> +    req->cid = le16_to_cpu(cmd->cid);
> +
> +    memcpy(&req->cmd, cmd, sizeof(NvmeCmd));
> +    req->status = NVME_SUCCESS;
> +    req->is_cmb = false;
> +    req->is_write = false;

What is the use case for this one ?
It does not seem to be referenced in this patch.

BR

Beata


> +}
> +
>  static void nvme_process_sq(void *opaque)
>  {
>      NvmeSQueue *sq = opaque;
> @@ -1292,9 +1376,8 @@ static void nvme_process_sq(void *opaque)
>          req = QTAILQ_FIRST(&sq->req_list);
>          QTAILQ_REMOVE(&sq->req_list, req, entry);
>          QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
> -        memset(&req->cqe, 0, sizeof(req->cqe));
> -        req->cqe.cid = cmd.cid;
> -        req->cid = le16_to_cpu(cmd.cid);
> +
> +        nvme_init_req(n, &cmd, req);
>
>          status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :
>              nvme_admin_cmd(n, &cmd, req);
> @@ -1815,7 +1898,7 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
>
>      NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
>      NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 1);
> -    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> +    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 1);
>      NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
>      NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
>      NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 3f7bd627e824..add9ff335aa5 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -28,11 +28,13 @@ typedef struct NvmeRequest {
>      BlockAIOCB              *aiocb;
>      uint16_t                status;
>      uint16_t                cid;
> -    bool                    has_sg;
> +    bool                    is_cmb;
> +    bool                    is_write;
>      NvmeCqe                 cqe;
>      BlockAcctCookie         acct;
>      QEMUSGList              qsg;
>      QEMUIOVector            iov;
> +    NvmeCmd                 cmd;
>      QTAILQ_ENTRY(NvmeRequest)entry;
>  } NvmeRequest;
>
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index f62fa99dc2cd..e81bb3a64ed7 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -33,6 +33,7 @@ nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
>  nvme_irq_pin(void) "pulsing IRQ pin"
>  nvme_irq_masked(void) "IRQ is masked"
>  nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
> +nvme_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
>  nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
>  nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
>  nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index f0f5728b5ec4..d4990db4fdf8 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -427,6 +427,7 @@ enum NvmeStatusCodes {
>      NVME_CMD_ABORT_MISSING_FUSE = 0x000a,
>      NVME_INVALID_NSID           = 0x000b,
>      NVME_CMD_SEQ_ERROR          = 0x000c,
> +    NVME_INVALID_USE_OF_CMB     = 0x0012,
>      NVME_LBA_RANGE              = 0x0080,
>      NVME_CAP_EXCEEDED           = 0x0081,
>      NVME_NS_NOT_READY           = 0x0082,
> --
> 2.23.0
>
>

