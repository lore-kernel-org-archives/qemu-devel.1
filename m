Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2AFC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6B6229F9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6B6229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqweu-0006qn-SZ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49058)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqwef-0006F5-R1
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqwea-0008Be-SI
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:36:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqwea-0007sC-Km
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:36:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so53669138wru.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KIcaoz8fRZh2eK5EjfDl5HCqLyQdsOWYcGjNeYxRgrI=;
 b=gIIb+9OFLzGRb67szUUDoqk8CglH0GhDX5KT3lXUQTn7VDKFb0PfBMms0eVIKce3Ev
 q7SoJhYMS/PxAS3/AoXnxaEN9vQgFw50yxL+Up1Mtb1fj6E0lHipPeMP7U3xZK2VeA1T
 F+UPyQZCta5un7iO4riswkAuLTLjVECNY5NoYQ419selsInWZXIuK+UC/uuwFGOVepEC
 U1NB/wqwnAl8eonZ+jWagF6aSM2dxPTASguY9snI9zpB9V0Zm2YOm2X8rF7IoD9c9HIL
 ytk0rg3muD/6SCbBUb+YanVEQRQNke/G76kwGXKbrMrLdPfMXYmPOhU7x7mWsrrNnajz
 iDCg==
X-Gm-Message-State: APjAAAV+3h3TLvSRWFqKx10tdS8CbDj11OpdUnHfF97majby+bX1LS8k
 AHE06TfYHSXR3lzunTu+iixpLg==
X-Google-Smtp-Source: APXvYqxXsX2gga74IicmqqCfSsMUieJhrIx+ez/3RJOmWoMr9yPkkilIfV7qz9XvZ7UdIDGuAXiMbw==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr34841822wrp.116.1564133800483; 
 Fri, 26 Jul 2019 02:36:40 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id v23sm45680831wmj.32.2019.07.26.02.36.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 02:36:39 -0700 (PDT)
Date: Fri, 26 Jul 2019 11:36:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190726093637.yv3w4ynkoyvzahq6@steredhat>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724171239.8764-2-mreitz@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 01/11] qemu-img: Fix
 bdrv_has_zero_init() use in convert
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

On Wed, Jul 24, 2019 at 07:12:29PM +0200, Max Reitz wrote:
> bdrv_has_zero_init() only has meaning for newly created images or image
> areas.  If qemu-img convert did not create the image itself, it cannot
> rely on bdrv_has_zero_init()'s result to carry any meaning.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 79983772de..0f4be80c10 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1578,6 +1578,7 @@ typedef struct ImgConvertState {
>      bool has_zero_init;
>      bool compressed;
>      bool unallocated_blocks_are_zero;
> +    bool target_is_new;
>      bool target_has_backing;
>      int64_t target_backing_sectors; /* negative if unknown */
>      bool wr_in_order;
> @@ -1975,9 +1976,11 @@ static int convert_do_copy(ImgConvertState *s)
>      int64_t sector_num = 0;
>  
>      /* Check whether we have zero initialisation or can get it efficiently */
> -    s->has_zero_init = s->min_sparse && !s->target_has_backing
> -                     ? bdrv_has_zero_init(blk_bs(s->target))
> -                     : false;
> +    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
> +        s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
> +    } else {
> +        s->has_zero_init = false;
> +    }
>  
>      if (!s->has_zero_init && !s->target_has_backing &&
>          bdrv_can_write_zeroes_with_unmap(blk_bs(s->target)))
> @@ -2423,6 +2426,8 @@ static int img_convert(int argc, char **argv)
>          }
>      }
>  
> +    s.target_is_new = !skip_create;
> +
>      flags = s.min_sparse ? (BDRV_O_RDWR | BDRV_O_UNMAP) : BDRV_O_RDWR;
>      ret = bdrv_parse_cache_mode(cache, &flags, &writethrough);
>      if (ret < 0) {

Make sense!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

