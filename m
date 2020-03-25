Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DCFC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96A9206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVck/HS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96A9206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3kC-0007uZ-Pr
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Xo-0000oE-0K
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Xm-0005CH-OE
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:45:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45686)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Xm-0005Bw-Jn
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKoEf7EdMWTgGzNkMuUzYgo/AMgyKhn6j7tpOT05QQo=;
 b=fVck/HS6brVms8nmDnpRGrVmFMsi0FhWm7TKaoftZfnYvAcNMlf3sfHI6y1QNj0v4ZQYnu
 v/PAqV6NEbE0svWyz3hDn7WAG2+O/WkJhV/kptYW74pTM1/vzZwQfFBwwO/A05AenSxKZV
 WIxCtfykOWarKxGoLFSAzD8mIRlD9Qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-fxyne2N8PWKxcTOAQ0XvRQ-1; Wed, 25 Mar 2020 06:45:52 -0400
X-MC-Unique: fxyne2N8PWKxcTOAQ0XvRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500871005512;
 Wed, 25 Mar 2020 10:45:51 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36A6ECDBC1;
 Wed, 25 Mar 2020 10:45:49 +0000 (UTC)
Message-ID: <8001a1b07bce413961ff6e3569988ab118542f5d.camel@redhat.com>
Subject: Re: [PATCH v6 24/42] nvme: remove redundant has_sg member
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:45:48 +0200
In-Reply-To: <20200316142928.153431-25-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-25-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Remove the has_sg member from NvmeRequest since it's redundant.

To be honest this patch also replaces the dma_acct_start with block_acct_start
which looks right to me, and IMHO its OK to have both in the same patch,
but that should be mentioned in the commit message

With this fixed,
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 18 ++++++++++++------
>  hw/block/nvme.h |  1 -
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 187c816eb6ad..e40c080c3b48 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -484,16 +484,20 @@ static void nvme_rw_cb(void *opaque, int ret)
>          block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
>          req->status = NVME_INTERNAL_DEV_ERROR;
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
> @@ -517,7 +521,6 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>  
> -    req->has_sg = false;
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>                       BLOCK_ACCT_WRITE);
>      req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
> @@ -554,16 +557,19 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>  
> -    dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
>      if (req->qsg.nsg > 0) {
> -        req->has_sg = true;
> +        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
> +                         acct);
> +
>          req->aiocb = is_write ?
>              dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
>                            nvme_rw_cb, req) :
>              dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
>                           nvme_rw_cb, req);
>      } else {
> -        req->has_sg = false;
> +        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->iov.size,
> +                         acct);
> +
>          req->aiocb = is_write ?
>              blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
>                              req) :
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index b4d1738a3d0a..442b17bf1701 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -29,7 +29,6 @@ typedef struct NvmeRequest {
>      struct NvmeSQueue       *sq;
>      BlockAIOCB              *aiocb;
>      uint16_t                status;
> -    bool                    has_sg;
>      NvmeCqe                 cqe;
>      BlockAcctCookie         acct;
>      QEMUSGList              qsg;





