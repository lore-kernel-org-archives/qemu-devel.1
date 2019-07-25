Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2BDC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5499421951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5499421951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfhT-00086J-G6
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48677)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfhG-0007Rd-3E
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfhE-0001OR-AE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:30:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hqfhA-0001Lg-4u; Thu, 25 Jul 2019 11:30:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 052194628B;
 Thu, 25 Jul 2019 15:30:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9204C60852;
 Thu, 25 Jul 2019 15:30:13 +0000 (UTC)
Message-ID: <c9e264a70dd524649bdba7769afbd86209a55c6e.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:30:12 +0300
In-Reply-To: <20190724171239.8764-9-mreitz@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-9-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 25 Jul 2019 15:30:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 08/11] vhdx: Fix .bdrv_has_zero_init()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-07-24 at 19:12 +0200, Max Reitz wrote:
> Fixed VHDX images cannot guarantee to be zero-initialized.  If the image
> has the "fixed" subformat, forward the call to the underlying storage
> node.
> 
> Reported-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/vhdx.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index a02d1c99a7..6a09d0a55c 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -2075,6 +2075,30 @@ static int coroutine_fn vhdx_co_check(BlockDriverState *bs,
>      return 0;
>  }
>  
> +static int vhdx_has_zero_init(BlockDriverState *bs)
> +{
> +    BDRVVHDXState *s = bs->opaque;
> +    int state;
> +
> +    /*
> +     * Check the subformat: Fixed images have all BAT entries present,
> +     * dynamic images have none (right after creation).  It is
> +     * therefore enough to check the first BAT entry.
> +     */
> +    if (!s->bat_entries) {
> +        return 1;
> +    }
> +
> +    state = s->bat[0] & VHDX_BAT_STATE_BIT_MASK;
> +    if (state == PAYLOAD_BLOCK_FULLY_PRESENT) {
> +        /* Fixed subformat */
> +        return bdrv_has_zero_init(bs->file->bs);
> +    }
> +
> +    /* Dynamic subformat */
> +    return 1;
> +}
> +
>  static QemuOptsList vhdx_create_opts = {
>      .name = "vhdx-create-opts",
>      .head = QTAILQ_HEAD_INITIALIZER(vhdx_create_opts.head),
> @@ -2128,7 +2152,7 @@ static BlockDriver bdrv_vhdx = {
>      .bdrv_co_create_opts    = vhdx_co_create_opts,
>      .bdrv_get_info          = vhdx_get_info,
>      .bdrv_co_check          = vhdx_co_check,
> -    .bdrv_has_zero_init     = bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init     = vhdx_has_zero_init,
>  
>      .create_opts            = &vhdx_create_opts,
>  };

I am not familiar with VHDX format to be honest too, but knowing that dynamic format allows for growing
and static are preallocated this makes sense.

Its a bit amusing and not surprising that the the spec for this format is in .docx. 
I took a quick look to get a rough impression of the file format.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky




