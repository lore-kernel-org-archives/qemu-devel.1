Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17898C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DB02074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jfu0i5FO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DB02074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k162S-0004At-7E
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k161q-0003be-1p
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 06:43:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33953
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k161o-0007JH-As
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 06:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596105791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7l2Oqyva+d7QbyiCRJqQ50/rp6laKJeQU8GtCDUkoNo=;
 b=Jfu0i5FOAajFCKASERZG/gGfBnD/3jRYHmxP8YdY8oVkPB5yb++KZEH6steXv8bGX454O7
 v3jnbOELdT7tAXPdAzfXf2vCzcql21brVfPL/v6ppx3uM9HjG9kL+Y+b2bfJlCK482THAo
 Lc2JAfoz7RhnknXvBrDVEUkPFZPxR10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-bcIZ9dTxNMWFYZ2TtccETg-1; Thu, 30 Jul 2020 06:43:09 -0400
X-MC-Unique: bcIZ9dTxNMWFYZ2TtccETg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29B3A1DE1;
 Thu, 30 Jul 2020 10:43:08 +0000 (UTC)
Received: from starship (unknown [10.35.206.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB3CB709E4;
 Thu, 30 Jul 2020 10:43:02 +0000 (UTC)
Message-ID: <458222243222342259465ccff18937b63d2c66c2.camel@redhat.com>
Subject: Re: [PATCH v2 04/16] hw/block/nvme: remove redundant has_sg member
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Date: Thu, 30 Jul 2020 13:43:01 +0300
In-Reply-To: <20200729220638.344477-5-its@irrelevant.dk>
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-5-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-07-30 at 00:06 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Remove the has_sg member from NvmeRequest since it's redundant.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

> ---
>  hw/block/nvme.c | 7 ++-----
>  hw/block/nvme.h | 1 -
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index d60b19e1840f..a9d9a2912655 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -550,7 +550,8 @@ static void nvme_rw_cb(void *opaque, int ret)
>          block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
>          req->status = NVME_INTERNAL_DEV_ERROR;
>      }
> -    if (req->has_sg) {
> +
> +    if (req->qsg.nalloc) {
>          qemu_sglist_destroy(&req->qsg);
>      }
>      nvme_enqueue_req_completion(cq, req);
> @@ -559,7 +560,6 @@ static void nvme_rw_cb(void *opaque, int ret)
>  static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRequest *req)
>  {
> -    req->has_sg = false;
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>           BLOCK_ACCT_FLUSH);
>      req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
> @@ -585,7 +585,6 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>  
> -    req->has_sg = false;
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
>                       BLOCK_ACCT_WRITE);
>      req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
> @@ -623,7 +622,6 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      }
>  
>      if (req->qsg.nsg > 0) {
> -        req->has_sg = true;
>          block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
>                           acct);
>          req->aiocb = is_write ?
> @@ -632,7 +630,6 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>              dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
>                           nvme_rw_cb, req);
>      } else {
> -        req->has_sg = false;
>          block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->iov.size,
>                           acct);
>          req->aiocb = is_write ?
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 0b6a8ae66559..5519b5cc7686 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -22,7 +22,6 @@ typedef struct NvmeRequest {
>      struct NvmeSQueue       *sq;
>      BlockAIOCB              *aiocb;
>      uint16_t                status;
> -    bool                    has_sg;
>      NvmeCqe                 cqe;
>      BlockAcctCookie         acct;
>      QEMUSGList              qsg;



