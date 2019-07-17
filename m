Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C8AC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 01:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC2D217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 01:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC2D217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZED-0000Ov-Bs
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 21:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hnZE2-0008S5-PV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 21:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hnZE1-0006ZU-Pv
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 21:59:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hnZE1-0006Z3-Ja
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 21:59:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so10331670pgj.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 18:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ME6RWmLiEpaQuVUC4H1pG1wHoLbyFOxeqXZXn5FhvOE=;
 b=hcN3aBdIwd+ulV7Ex10fRzPtiJNByzkneUgMViwELQpMpHrVD3at9svp5viuGlYa5T
 AZAcOo7CFurtj7GEnXUOwCjpJFPkIJ356J7OevSy7K+7FOEWBO6NX43ypKNXTQlO4c/J
 JvziweqlEGBQsLDGXUmYo1T/POX819hs58zbxVci4rUZwHMu6WIKivaPka/V2o8Wl5Sl
 55LKb45RPpZZj4O1itJ087pQeXNdXBI1H9o8MlSMLoFHVFu1Cx4CLVmokQOTJ8y24gJI
 jbVUWOX6MtiM/CNukmdq4qH9Ti36ObOmshMLwQc+x8OGRrvq42v1lSg9BXooHx9TNNUG
 g0pA==
X-Gm-Message-State: APjAAAWSraDD5ydQ6yV7H+jzdfjigm2CqDsoRW665bywxJaekTkXOLo7
 nwAXzIDUUYQKsTzCQj7Mle6xfw==
X-Google-Smtp-Source: APXvYqwQKTRI85+vVecATM5ygiaS3F9rZ3znI+af9jsP0s3VAhiOwDeKrUEaWqth5eUuvCiSH584HQ==
X-Received: by 2002:a63:9a51:: with SMTP id e17mr38162818pgo.212.1563328760539; 
 Tue, 16 Jul 2019 18:59:20 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m4sm31702397pgs.71.2019.07.16.18.59.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 18:59:19 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Wed, 17 Jul 2019 09:59:10 +0800
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190717015910.GD30980@xz-x1>
References: <20190717012902.23958-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190717012902.23958-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
Subject: Re: [Qemu-devel] [RESEND][PATCH] bitmap: get last word mask from nr
 directly
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
Cc: quintela@redhat.com, corentincj@iksaif.net, pl@kamp.de,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 09:29:02AM +0800, Wei Yang wrote:
> The value left in nr is the number of bits for the last word, which
> could be calculate the last word mask directly.

Is it true even if start does not align to BITS_PER_LONG?

> 
> Remove the unnecessary size.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
> resend with wider audience
> ---
>  util/bitmap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/util/bitmap.c b/util/bitmap.c
> index cb618c65a5..5aa60b8717 100644
> --- a/util/bitmap.c
> +++ b/util/bitmap.c
> @@ -160,7 +160,6 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
>  void bitmap_set(unsigned long *map, long start, long nr)
>  {
>      unsigned long *p = map + BIT_WORD(start);
> -    const long size = start + nr;
>      int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>      unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>  
> @@ -174,7 +173,7 @@ void bitmap_set(unsigned long *map, long start, long nr)
>          p++;
>      }
>      if (nr) {
> -        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
> +        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>          *p |= mask_to_set;
>      }
>  }
> @@ -221,7 +220,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>  void bitmap_clear(unsigned long *map, long start, long nr)
>  {
>      unsigned long *p = map + BIT_WORD(start);
> -    const long size = start + nr;
>      int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>      unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
>  
> @@ -235,7 +233,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
>          p++;
>      }
>      if (nr) {
> -        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
> +        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
>          *p &= ~mask_to_clear;
>      }
>  }
> -- 
> 2.17.1
> 

Regards,

-- 
Peter Xu

