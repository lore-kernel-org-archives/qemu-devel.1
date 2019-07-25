Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE1CC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FFFA21951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFFA21951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfgb-00051b-Pf
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48437)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfgM-000472-Qj
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfgL-0000wt-Mb
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hqfgI-0000vd-5G; Thu, 25 Jul 2019 11:29:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 779D230C7128;
 Thu, 25 Jul 2019 15:29:21 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10F431001B14;
 Thu, 25 Jul 2019 15:29:19 +0000 (UTC)
Message-ID: <9a2ee10d7d7680ae237cabe475ec6e8e6fdba418.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:29:19 +0300
In-Reply-To: <20190724171239.8764-6-mreitz@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-6-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 25 Jul 2019 15:29:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 05/11] block: Use
 bdrv_has_zero_init_truncate()
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
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/parallels.c | 2 +-
>  block/vhdx.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index 00fae125d1..7cd2714b69 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -835,7 +835,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>          goto fail_options;
>      }
>  
> -    if (!bdrv_has_zero_init(bs->file->bs)) {
> +    if (!bdrv_has_zero_init_truncate(bs->file->bs)) {
>          s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
>      }
>  
> diff --git a/block/vhdx.c b/block/vhdx.c
> index d6070b6fa8..a02d1c99a7 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1282,7 +1282,7 @@ static coroutine_fn int vhdx_co_writev(BlockDriverState *bs, int64_t sector_num,
>                  /* Queue another write of zero buffers if the underlying file
>                   * does not zero-fill on file extension */
>  
> -                if (bdrv_has_zero_init(bs->file->bs) == 0) {
> +                if (bdrv_has_zero_init_truncate(bs->file->bs) == 0) {
>                      use_zero_buffers = true;
>  
>                      /* zero fill the front, if any */

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


