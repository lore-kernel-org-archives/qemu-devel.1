Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52529C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD2720714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQFrb36t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD2720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3ky-0000az-7c
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3ij-00061f-4B
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3ih-0001yR-KJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:57:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3ih-0001vW-EY
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRbdNGVpeUeZU8xPW2J68+C6Q8QI8wHXklbkTUbGfj0=;
 b=HQFrb36tUmtgpatkjQ1gEl18Sba+lbcau9tHKowf4Wol/yDXMrcU1aFh9Hl456HbbEDnVZ
 tWCBcfolxnnZiUAu0yC7m2hm1KHKnUc9+TgcJi4trGo7/vpbs46/018bs3bUtoOLNAfRQP
 qsYAswGLrIEkZst1wrLgTRxndK7HTRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-g5Abs0DkOHqILNO7r1DkxA-1; Wed, 25 Mar 2020 06:57:09 -0400
X-MC-Unique: g5Abs0DkOHqILNO7r1DkxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2057D1005510;
 Wed, 25 Mar 2020 10:57:08 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E47A65C241;
 Wed, 25 Mar 2020 10:57:05 +0000 (UTC)
Message-ID: <7b81ac47dddb6a97a67706c4dc06ca8f4db75954.camel@redhat.com>
Subject: Re: [PATCH v6 30/42] nvme: add check for mdts
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:57:04 +0200
In-Reply-To: <20200316142928.153431-31-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-31-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> Add 'mdts' device parameter to control the Maximum Data Transfer Size of
> the controller and check that it is respected.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 29 ++++++++++++++++++++++++++++-
>  hw/block/nvme.h       |  4 +++-
>  hw/block/trace-events |  1 +
>  3 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index ba520c76bae5..7d5340c272c6 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -19,7 +19,8 @@
>   *      -drive file=<file>,if=none,id=<drive_id>
>   *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
>   *              cmb_size_mb=<cmb_size_mb[optional]>, \
> - *              max_ioqpairs=<N[optional]>
> + *              max_ioqpairs=<N[optional]>, \
> + *              mdts=<mdts[optional]>
>   *
>   * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
>   * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> @@ -491,6 +492,19 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
>      }
>  }
>  
> +static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len,
> +                                       NvmeRequest *req)
> +{
> +    uint8_t mdts = n->params.mdts;
> +
> +    if (mdts && len > n->page_size << mdts) {
> +        trace_nvme_dev_err_mdts(nvme_cid(req), n->page_size << mdts, len);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
> +
>  static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
>                                           uint64_t slba, uint32_t nlb,
>                                           NvmeRequest *req)
> @@ -581,6 +595,12 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>  
>      trace_nvme_dev_rw(is_write ? "write" : "read", nlb, data_size, slba);
>  
> +    status = nvme_check_mdts(n, data_size, req);
> +    if (status) {
> +        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> +        return status;
> +    }
> +
>      status = nvme_check_bounds(n, ns, slba, nlb, req);
>      if (status) {
>          block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> @@ -871,6 +891,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t numdl, numdu;
>      uint64_t off, lpol, lpou;
>      size_t   len;
> +    uint16_t status;
>  
>      numdl = (dw10 >> 16);
>      numdu = (dw11 & 0xffff);
> @@ -886,6 +907,11 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  
>      trace_nvme_dev_get_log(nvme_cid(req), lid, lsp, rae, len, off);
>  
> +    status = nvme_check_mdts(n, len, req);
> +    if (status) {
> +        return status;
> +    }
> +
>      switch (lid) {
>      case NVME_LOG_ERROR_INFO:
>          return nvme_error_info(n, cmd, rae, len, off, req);
> @@ -2011,6 +2037,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>      id->ieee[0] = 0x00;
>      id->ieee[1] = 0x02;
>      id->ieee[2] = 0xb3;
> +    id->mdts = params->mdts;
>      id->ver = cpu_to_le32(NVME_SPEC_VER);
>      id->oacs = cpu_to_le16(0);
>  
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 442b17bf1701..b05c2153aebf 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -9,7 +9,8 @@
>      DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 0), \
>      DEFINE_PROP_UINT32("max_ioqpairs", _state, _props.max_ioqpairs, 64), \
>      DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
> -    DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, 64)
> +    DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, 64), \
> +    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7)
>  
>  typedef struct NvmeParams {
>      char     *serial;
> @@ -18,6 +19,7 @@ typedef struct NvmeParams {
>      uint32_t cmb_size_mb;
>      uint8_t  aerl;
>      uint32_t aer_max_queued;
> +    uint8_t  mdts;
>  } NvmeParams;
>  
>  typedef struct NvmeAsyncEvent {
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index e31e652fa04e..2df6aa38df1b 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -79,6 +79,7 @@ nvme_dev_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_
>  nvme_dev_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_tail %"PRIu16""
>  
>  # nvme traces for error conditions
> +nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts %"PRIu64" len %"PRIu64""
>  nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
>  nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
>  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




