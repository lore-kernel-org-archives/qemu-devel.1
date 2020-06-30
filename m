Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22342C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 01:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAD620722
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 01:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7Y7jrMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAD620722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4js-0003M3-88
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 21:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jq4jD-0002o3-0o; Mon, 29 Jun 2020 21:06:27 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jq4jB-0004MG-Ax; Mon, 29 Jun 2020 21:06:26 -0400
Received: by mail-il1-x142.google.com with SMTP id a11so7952433ilk.0;
 Mon, 29 Jun 2020 18:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eIU80hlctrgIzFpuS/p6L91OX1lAyxmRaOAi6fIdWjk=;
 b=Y7Y7jrMr+o7eak4U5+JywYz1vHT5/byGg2fm1AlyvXy1qDdZxB027mrEBrk9Fg0a1U
 mnuy40OSGoKCBp5W+WJqCQd4jWGmC2tUTQw1HJxQHRlAeLM1g+Lx0HtnIiWUAt7bWhjo
 2galgNyzIzJ6aZvdPmXxGqenFQKu+IcisTFX+63p0rpZHAJ1VwChQ9VKziCLzNcgNdql
 LKrCSQ2BuXI/eSmH4s2vKFvW/36N7Rc/iG/NwaTpesD4aH638h9xI1QzDorwHZb6W4b6
 wpKxzQI85spn6lRUXroOh2AI2F4Nz3mzXCUUJ3jo678MjtLc1HozRQ7QQ2piWzDN3Bod
 1RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eIU80hlctrgIzFpuS/p6L91OX1lAyxmRaOAi6fIdWjk=;
 b=Xo5UB8mwVvhV6b6IKZYlihhTDk4sUBU1KJMkxAPvIBpWldoa8lzrn8Aw7CTUJzraau
 fmLytdD3iAzQR/y8Mz9pGYoo0GqUh8r6hpNgbL9WmYH2EhOUfunmfU5lwaIQRIlW55FX
 j4DFHwHE/xiuHF1cyCoxej3HGeKBvZrJbBzwY0nP9bYrLc4fI+hygIHYvV8nLj1vkNGv
 7RMOFy4J2ziB3zoQdGTKIgAyNp3/DoetPSD+vEkBbIwpt9C9PmWs+3xTY9a7nVgs90Zf
 XOp1UXGnV+BCsFLRnWGh/mQGYyFj1Z0KfL84EYObrqh/q9EAggPlm1LnUUImULAFQe93
 F7xA==
X-Gm-Message-State: AOAM530SozV+KKeUCrlnlbGPgC++rE/fLwf3MDUHgNF6Lk/ss5rgCp2V
 HTec/CxXGddFhcyDC3F9YUp5qLkdadNhHmF4Oas=
X-Google-Smtp-Source: ABdhPJy+n2p3ZIdtKB0nU3+YDkRaRIX4p1StDTXa8IoQ4DZWxwoj20/SbOcPHc3hSXaPM6OKRKTyl56tKvAiLhV7o2w=
X-Received: by 2002:a92:5f12:: with SMTP id t18mr226558ilb.267.1593479182906; 
 Mon, 29 Jun 2020 18:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-2-dmitry.fomichev@wdc.com>
In-Reply-To: <20200617213415.22417-2-dmitry.fomichev@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2020 17:56:40 -0700
Message-ID: <CAKmqyKMH+cPCSwb_3jPAmy5=bz7idTeYYkNatij8xRiJO9jTmA@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] hw/block/nvme: Move NvmeRequest has_sg field to
 a bit flag
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 Damien Le Moal <damien.lemoal@wdc.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 2:43 PM Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:
>
> In addition to the existing has_sg flag, a few more Boolean
> NvmeRequest flags are going to be introduced in subsequent patches.
> Convert "has_sg" variable to "flags" and define NvmeRequestFlags
> enum for individual flag values.
>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/nvme.c | 8 +++-----
>  hw/block/nvme.h | 6 +++++-
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 1aee042d4c..3ed9f3d321 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -350,7 +350,7 @@ static void nvme_rw_cb(void *opaque, int ret)
>          block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
>          req->status = NVME_INTERNAL_DEV_ERROR;
>      }
> -    if (req->has_sg) {
> +    if (req->flags & NVME_REQ_FLG_HAS_SG) {
>          qemu_sglist_destroy(&req->qsg);
>      }
>      nvme_enqueue_req_completion(cq, req);
> @@ -359,7 +359,6 @@ static void nvme_rw_cb(void *opaque, int ret)
>  static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
> -    req->has_sg = false;
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>           BLOCK_ACCT_FLUSH);
>      req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
> @@ -383,7 +382,6 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>
> -    req->has_sg = false;
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>                       BLOCK_ACCT_WRITE);
>      req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
> @@ -422,14 +420,13 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>
>      dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
>      if (req->qsg.nsg > 0) {
> -        req->has_sg = true;
> +        req->flags |= NVME_REQ_FLG_HAS_SG;
>          req->aiocb = is_write ?
>              dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
>                            nvme_rw_cb, req) :
>              dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
>                           nvme_rw_cb, req);
>      } else {
> -        req->has_sg = false;
>          req->aiocb = is_write ?
>              blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
>                              req) :
> @@ -917,6 +914,7 @@ static void nvme_process_sq(void *opaque)
>          QTAILQ_REMOVE(&sq->req_list, req, entry);
>          QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
>          memset(&req->cqe, 0, sizeof(req->cqe));
> +        req->flags = 0;
>          req->cqe.cid = cmd.cid;
>
>          status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 1d30c0bca2..0460cc0e62 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -16,11 +16,15 @@ typedef struct NvmeAsyncEvent {
>      NvmeAerResult result;
>  } NvmeAsyncEvent;
>
> +enum NvmeRequestFlags {
> +    NVME_REQ_FLG_HAS_SG   = 1 << 0,
> +};
> +
>  typedef struct NvmeRequest {
>      struct NvmeSQueue       *sq;
>      BlockAIOCB              *aiocb;
>      uint16_t                status;
> -    bool                    has_sg;
> +    uint16_t                flags;
>      NvmeCqe                 cqe;
>      BlockAcctCookie         acct;
>      QEMUSGList              qsg;
> --
> 2.21.0
>
>

