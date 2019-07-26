Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F6AC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F5D22CED
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F5D22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwl4-0002Gf-1J
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqwkt-0001oS-Bv
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqwkr-0007hq-12
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:43:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqwkq-0007YD-P0
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:43:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so28646346wrr.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pejRmaXQT5QUmRslU30uo6WM/z8jJfWeLMmUB4fC/Ag=;
 b=hua46SCx66qe6R0ViSIvM0mCtXYBz0opY5KbOE9PA8tPr70gQ1R3AYsNl/TI4tgYmq
 HsoF+9QGS0EX3hqnP0ixTbVJcY8CWHbVvz1978D1T3kisWy+jeAd1DYQ6TAvoeFcUf9Q
 z66jiKpmDMc+fwnGIh3gsiS7krT9eZT8pddntKvOrQvOyjaDw5bVEJOWY6R6oHPKdJPX
 udvt7yXSGjMCbDeuzNM/G1kQIZ4NjoUYwYTww/nytFNdHMODp+dKOwi7upzgnqzZMNWg
 hzw8JvUbOXEYG6nv2T+dyJIlCmnXvff+Tvax8+TXVsd33Il17qJ41osEKPW4fLXpnBKh
 GrTQ==
X-Gm-Message-State: APjAAAUu2ZSKlbNy2O3H0AZMtNv0pQQTj1hEJHw1GD0xqaZop3Gczr3r
 JpkshXR5SOy4eo/NfPBVY9WWzu7Qw6U=
X-Google-Smtp-Source: APXvYqwWTjEv4juSehf9C06WLs8SERqXulkf85bRfRDHrWBx1TxL8xQtJIIF6My3MwRxBhMIq9G6AA==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr105549161wrv.228.1564134190762; 
 Fri, 26 Jul 2019 02:43:10 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id t15sm45336986wrx.84.2019.07.26.02.43.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 02:43:10 -0700 (PDT)
Date: Fri, 26 Jul 2019 11:43:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190726094307.x3rm5tvpsh3s4vp4@steredhat>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-6-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724171239.8764-6-mreitz@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 07:12:33PM +0200, Max Reitz wrote:
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
> -- 
> 2.21.0
> 

What about describing in the commit message why we are using
bdrv_has_zero_init_truncate() like in the cover letter?

With or without:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

