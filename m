Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC9AC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE64206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEVzKzQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE64206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Y6-0000mL-Q7
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3V7-00051a-Oc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3V6-0003MT-F2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:43:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60587)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3V6-0003MG-AJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLXjIXcD6xWCR1Y7Yk1x5ls5003ezmKOOvsW8XHtFNU=;
 b=VEVzKzQO5chAUhKEZdghCdW8PPLUcB48gqhvNmFbhex21wYv3BSNIIKNJEwB8mIcUaKQYN
 bpIQWRLbD5smX3xpBZP1YI6vNLwUnWfTLNDpndISs8uZSDKlkOGGOm0lp9Yo2r3oczk66U
 oU0Da1QJFxw1y6Whaz//myDl5BHkAyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-74t6Z8ViOvOSLZXbQJ6oiA-1; Wed, 25 Mar 2020 06:43:05 -0400
X-MC-Unique: 74t6Z8ViOvOSLZXbQJ6oiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2548800D5B;
 Wed, 25 Mar 2020 10:43:03 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C3C35D9C5;
 Wed, 25 Mar 2020 10:43:01 +0000 (UTC)
Message-ID: <53339d66d895398cac49114689f5d77ab07f0aac.camel@redhat.com>
Subject: Re: [PATCH v6 17/42] nvme: add log specific field to trace events
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:43:00 +0200
In-Reply-To: <20200316142928.153431-18-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-18-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
> The LSP field is not used directly now, but include it in the trace.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 3 ++-
>  hw/block/trace-events | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index e56142c4ea99..16de3ca1c5d5 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -760,6 +760,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t dw12 = le32_to_cpu(cmd->cdw12);
>      uint32_t dw13 = le32_to_cpu(cmd->cdw13);
>      uint8_t  lid = dw10 & 0xff;
> +    uint8_t  lsp = (dw10 >> 8) & 0xf;
>      uint8_t  rae = (dw10 >> 15) & 0x1;
>      uint32_t numdl, numdu;
>      uint64_t off, lpol, lpou;
> @@ -777,7 +778,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>  
> -    trace_nvme_dev_get_log(nvme_cid(req), lid, rae, len, off);
> +    trace_nvme_dev_get_log(nvme_cid(req), lid, lsp, rae, len, off);
>  
>      switch (lid) {
>      case NVME_LOG_ERROR_INFO:
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index dde1d22bc39a..13e2c71664f6 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -48,7 +48,7 @@ nvme_dev_getfeat_numq(int result) "get feature number of queues, result=%d"
>  nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
>  nvme_dev_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
>  nvme_dev_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
> -nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
> +nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
>  nvme_dev_process_aers(int queued) "queued %d"
>  nvme_dev_aer(uint16_t cid) "cid %"PRIu16""
>  nvme_dev_aer_aerl_exceeded(void) "aerl exceeded"
Perfect!
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




