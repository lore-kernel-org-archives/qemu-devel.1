Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585C8C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFDD20714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK9zT6FF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFDD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3lh-0001ba-8V
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3jA-0006pX-Rq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3j9-0004Kz-8M
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:57:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3j9-0004IO-1v
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HouoXWE3udsY+eIzgpQwRfPhqznEO+Bf/D1PBXu4EaA=;
 b=VK9zT6FFjEvTvnRBxTwYeun0A8sFYSp8fLK7SUeECx0yPxCC+nbDys1E5A0e9FJ1wvTRyu
 v6lilMtywTgjyyv4QmoF53yrSNUW1WZk9Qdp+VheAdJuFFkCpqG27TEJAfTGL6EC+h/hsW
 rCpAjnLc8Ru0I4HjKYrsbjFuxrZT7lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-VFhVYJgyPQmEPYlsMb3R5w-1; Wed, 25 Mar 2020 06:57:37 -0400
X-MC-Unique: VFhVYJgyPQmEPYlsMb3R5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 880DA8017DF;
 Wed, 25 Mar 2020 10:57:35 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D5D88D576;
 Wed, 25 Mar 2020 10:57:33 +0000 (UTC)
Message-ID: <9d3bad95342559566c391635d9d96e4b56dd08c7.camel@redhat.com>
Subject: Re: [PATCH v6 31/42] nvme: add check for prinfo
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:57:32 +0200
In-Reply-To: <20200316142928.153431-32-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-32-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
> Check the validity of the PRINFO field.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 50 ++++++++++++++++++++++++++++++++++++-------
>  hw/block/trace-events |  1 +
>  include/block/nvme.h  |  1 +
>  3 files changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 7d5340c272c6..0d2b5b45b0c5 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -505,6 +505,17 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len,
>      return NVME_SUCCESS;
>  }
>  
> +static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeNamespace *ns,
> +                                         uint16_t ctrl, NvmeRequest *req)
> +{
> +    if ((ctrl & NVME_RW_PRINFO_PRACT) && !(ns->id_ns.dps & DPS_TYPE_MASK)) {
> +        trace_nvme_dev_err_prinfo(nvme_cid(req), ctrl);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }

I refreshed my (still very limited) knowelege on the metadata
and the protection info, and this is what I found:

I think that this is very far from complete, because we also have:

1. PRCHECK. According to the spec it is independent of PRACT
   And when some of it is set, 
   together with enabled protection (the DPS field in namespace),
   Then the 8 bytes of the protection info is checked (optionally using the
   the EILBRT and ELBAT/ELBATM fields in the command and CRC of the data for the guard field)

   So this field should also be checked to be zero when protection is disabled
   (I don't see an explicit requirement for that in the spec, but neither I see
   such requirement for PRACT)

2. The protection values to be written / checked ((E)ILBRT/(E)LBATM/(E)LBAT)
   Same here, but also these should not be set when PRCHECK is not set for reads,
   plus some are protection type specific.


The spec does mention the 'Invalid Protection Information' error code which
refers to invalid values in the PRINFO field.
So this error code I think should be returned instead of the 'Invalid field'

Another thing to optionaly check is that the metadata pointer for separate metadata.
 Is zero as long as we don't support metadata
(again I don't see an explicit requirement for this in the spec, but it mentions:

"This field is valid only if the command has metadata that is not interleaved with
the logical block data, as specified in the Format NVM command"

)


> +
> +    return NVME_SUCCESS;
> +}
> +
>  static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
>                                           uint64_t slba, uint32_t nlb,
>                                           NvmeRequest *req)
> @@ -564,11 +575,22 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
>      uint64_t offset = slba << data_shift;
>      uint32_t count = nlb << data_shift;
> +    uint16_t ctrl = le16_to_cpu(rw->control);
>      uint16_t status;
>  
> +    status = nvme_check_prinfo(n, ns, ctrl, req);
> +    if (status) {
> +        goto invalid;
> +    }
> +
> +    if (ctrl & NVME_RW_PRINFO_PRCHK_MASK) {
> +        status = NVME_INVALID_PROT_INFO | NVME_DNR;
> +        goto invalid;
> +    }
> +
>      status = nvme_check_bounds(n, ns, slba, nlb, req);
>      if (status) {
> -        return status;
> +        goto invalid;
>      }
>  
>      block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> @@ -576,6 +598,10 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
>                                          BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
>      return NVME_NO_COMPLETE;
> +
> +invalid:
> +    block_acct_invalid(blk_get_stats(n->conf.blk), BLOCK_ACCT_WRITE);
> +    return status;
>  }
>  
>  static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> @@ -584,6 +610,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
>      uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
>      uint64_t slba = le64_to_cpu(rw->slba);
> +    uint16_t ctrl = le16_to_cpu(rw->control);
>  
>      uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
>      uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
> @@ -597,19 +624,22 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>  
>      status = nvme_check_mdts(n, data_size, req);
>      if (status) {
> -        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> -        return status;
> +        goto invalid;
> +    }
> +
> +    status = nvme_check_prinfo(n, ns, ctrl, req);
> +    if (status) {
> +        goto invalid;
>      }
>  
>      status = nvme_check_bounds(n, ns, slba, nlb, req);
>      if (status) {
> -        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> -        return status;
> +        goto invalid;
>      }
>  
> -    if (nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req)) {
> -        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +    status = nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req);
> +    if (status) {
> +        goto invalid;
>      }
>  
>      if (req->qsg.nsg > 0) {
> @@ -633,6 +663,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      }
>  
>      return NVME_NO_COMPLETE;
> +
> +invalid:
> +    block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> +    return status;
>  }
>  
>  static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 2df6aa38df1b..2aceb0537e05 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -80,6 +80,7 @@ nvme_dev_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_
>  
>  # nvme traces for error conditions
>  nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts %"PRIu64" len %"PRIu64""
> +nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu16""
>  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
>  nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
>  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index ecc02fbe8bb8..293d68553538 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -394,6 +394,7 @@ enum {
>      NVME_RW_PRINFO_PRCHK_GUARD  = 1 << 12,
>      NVME_RW_PRINFO_PRCHK_APP    = 1 << 11,
>      NVME_RW_PRINFO_PRCHK_REF    = 1 << 10,
> +    NVME_RW_PRINFO_PRCHK_MASK   = 7 << 10,
>  };
>  
>  typedef struct NvmeDsmCmd {


Best regards,
	Maxim Levitsky




