Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876A2C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DF320665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DF320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAgxk-0007XZ-AF
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 16:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgve-0005qJ-Ke
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgvd-0008Fq-C6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:51:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iAgva-0008En-I7; Wed, 18 Sep 2019 16:51:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D691C3B714;
 Wed, 18 Sep 2019 20:51:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 845DA60C18;
 Wed, 18 Sep 2019 20:51:49 +0000 (UTC)
Message-ID: <bbf0dfd2dbb5eb9ae759e35d7cc46c369c783ea9.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 23:51:48 +0300
In-Reply-To: <20190918095144.955-7-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
 <20190918095144.955-7-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 18 Sep 2019 20:51:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/8] block: Let format drivers pass @exact
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
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-09-18 at 11:51 +0200, Max Reitz wrote:
> When truncating a format node, the @exact parameter is generally handled
> simply by virtue of the format storing the new size in the image
> metadata.  Such formats do not need to pass on the parameter to their
> file nodes.
> 
> There are exceptions, though:
> - raw and crypto cannot store the image size, and thus must pass on
>   @exact.
> 
> - When using qcow2 with an external data file, it just makes sense to
>   keep its size in sync with the qcow2 virtual disk (because the
>   external data file is the virtual disk).  Therefore, we should pass
>   @exact when truncating it.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/crypto.c     |  2 +-
>  block/qcow2.c      | 15 ++++++++++++++-
>  block/raw-format.c |  2 +-
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index e5a1a2cdf3..24823835c1 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -311,7 +311,7 @@ block_crypto_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
>  
>      offset += payload_offset;
>  
> -    return bdrv_co_truncate(bs->file, offset, false, prealloc, errp);
> +    return bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
>  }
>  
>  static void block_crypto_close(BlockDriverState *bs)
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 157b9b75d9..4ef19dd29a 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3822,6 +3822,13 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>          if ((last_cluster + 1) * s->cluster_size < old_file_size) {
>              Error *local_err = NULL;
>  
> +            /*
> +             * Do not pass @exact here: It will not help the user if
> +             * we get an error here just because they wanted to shrink
> +             * their qcow2 image (on a block device) with qemu-img.
> +             * (And on the qcow2 layer, the @exact requirement is
> +             * always fulfilled, so there is no need to pass it on.)
> +             */
>              bdrv_co_truncate(bs->file, (last_cluster + 1) * s->cluster_size,
>                               false, PREALLOC_MODE_OFF, &local_err);
>              if (local_err) {
> @@ -3840,7 +3847,12 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>      switch (prealloc) {
>      case PREALLOC_MODE_OFF:
>          if (has_data_file(bs)) {
> -            ret = bdrv_co_truncate(s->data_file, offset, false, prealloc, errp);
> +            /*
> +             * If the caller wants an exact resize, the external data
> +             * file should be resized to the exact target size, too,
> +             * so we pass @exact here.
> +             */
> +            ret = bdrv_co_truncate(s->data_file, offset, exact, prealloc, errp);
>              if (ret < 0) {
>                  goto fail;
>              }
> @@ -3925,6 +3937,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>          /* Allocate the data area */
>          new_file_size = allocation_start +
>                          nb_new_data_clusters * s->cluster_size;
> +        /* Image file grows, so @exact does not matter */
>          ret = bdrv_co_truncate(bs->file, new_file_size, false, prealloc, errp);
> 
>          if (ret < 0) {
>              error_prepend(errp, "Failed to resize underlying file: ");
> diff --git a/block/raw-format.c b/block/raw-format.c
> index 57d84d0bae..3a76ec7dd2 100644
> --- a/block/raw-format.c
> +++ b/block/raw-format.c
> @@ -387,7 +387,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>  
>      s->size = offset;
>      offset += s->offset;
> -    return bdrv_co_truncate(bs->file, offset, false, prealloc, errp);
> +    return bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
>  }
>  
>  static void raw_eject(BlockDriverState *bs, bool eject_flag)


Looks all right.
Reviewed-by: Maxim Levitsky <maximlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



