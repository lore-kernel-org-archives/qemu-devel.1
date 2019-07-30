Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1C6C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AEB20693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AEB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQnp-0002P4-Tg
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 08:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58209)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hsQnJ-0001ir-04
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hsQnH-0007Eu-Oy
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hsQnB-0007D3-N1; Tue, 30 Jul 2019 07:59:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0DE330917AC;
 Tue, 30 Jul 2019 11:59:43 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 910A15D6A7;
 Tue, 30 Jul 2019 11:59:42 +0000 (UTC)
Message-ID: <9a6d1d0cb98bd7b25152c91095e7e8693da09751.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 14:59:41 +0300
In-Reply-To: <20190730114812.10493-1-mreitz@redhat.com>
References: <20190730114812.10493-1-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 30 Jul 2019 11:59:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1?] nvme: Limit blkshift to 12 (for 4
 kB blocks)
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-07-30 at 13:48 +0200, Max Reitz wrote:
> Linux does not support blocks greater than 4 kB anyway, so we might as
> well limit blkshift to 12 and thus save us from some potential trouble.

Well in theory its not 4K but PAGE_SIZE, thus on some IBM machines that I heard have
64K page size that might work, but again, I don't think any hardware vendor
dared yet to sell devices with sector size > 4K.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> I won't be around for too long today, so I thought I'd just write a
> patch myself now.
> ---
>  block/nvme.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index c28755cc31..2c85713519 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -105,7 +105,7 @@ typedef struct {
>  
>      uint64_t nsze; /* Namespace size reported by identify command */
>      int nsid;      /* The namespace id to read/write data. */
> -    size_t blkshift;
> +    int blkshift;
>  
>      uint64_t max_transfer;
>      bool plugged;
> @@ -420,7 +420,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>      NvmeIdNs *idns;
>      NvmeLBAF *lbaf;
>      uint8_t *resp;
> -    int r, hwsect_size;
> +    int r;
>      uint64_t iova;
>      NvmeCmd cmd = {
>          .opcode = NVME_ADM_CMD_IDENTIFY,
> @@ -474,11 +474,11 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>          goto out;
>      }
>  
> -    hwsect_size = 1 << lbaf->ds;
> -
> -    if (hwsect_size < BDRV_SECTOR_SIZE || hwsect_size > s->page_size) {
> -        error_setg(errp, "Namespace has unsupported block size (%d)",
> -                hwsect_size);
> +    if (lbaf->ds < BDRV_SECTOR_BITS || lbaf->ds > 12 ||
> +        (1 << lbaf->ds) > s->page_size)
> +    {
> +        error_setg(errp, "Namespace has unsupported block size (2^%d)",
> +                   lbaf->ds);
>          goto out;
>      }
>  
> @@ -804,16 +804,16 @@ static int64_t nvme_getlength(BlockDriverState *bs)
>      return s->nsze << s->blkshift;
>  }
>  
> -static int64_t nvme_get_blocksize(BlockDriverState *bs)
> +static uint32_t nvme_get_blocksize(BlockDriverState *bs)
>  {
>      BDRVNVMeState *s = bs->opaque;
> -    assert(s->blkshift >= BDRV_SECTOR_BITS);
> -    return 1 << s->blkshift;
> +    assert(s->blkshift >= BDRV_SECTOR_BITS && s->blkshift <= 12);
> +    return UINT32_C(1) << s->blkshift;
>  }
>  
>  static int nvme_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
>  {
> -    int64_t blocksize = nvme_get_blocksize(bs);
> +    uint32_t blocksize = nvme_get_blocksize(bs);
>      bsz->phys = blocksize;
>      bsz->log = blocksize;
>      return 0;



