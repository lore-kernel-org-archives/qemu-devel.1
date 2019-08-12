Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508FCC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2161820684
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2161820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxD2d-000787-5p
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52771)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hxD20-0006gK-2n
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hxD1z-0006HJ-1E
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:18:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hxD1y-0006Gz-RE
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:18:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so346513wme.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 09:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nq2+bZc4PzGB35nfmUmfA1fYqmnn7Dv4dLkavZWHkiA=;
 b=o14PYCDVi/nJPvSfgj2loyVXY/o6Z6oJsurzXyuKm/F+i+PmpKbY0JPAoSLHSZZG+k
 t5dDPrrJcXZZZE1wrxDDib6jBZjHjCz5rtKcB8mUGSsard0VupTzZearXhzlaXSWwifS
 GUQheBfgoE0NFaWurPoIgdFcvlvrIy77g2wacIzHKwScB7QW0pNLn9KF+5h5wb+NsRNT
 5iwz0Uj6zznNHzA50vBO75FjyYCtAVF62d6GaJJ21tlzIO5H38H/Hz0OX0z/dvFPJeA9
 Z/h32rpairPf4sZN7020oiAL1R5leDzNfkfkPkekFcfZo45Sap2hx43Grb50VOf0OKso
 lPhg==
X-Gm-Message-State: APjAAAXiCxFBFR0afNMl29f9/A4o13zbfTivkh7iwiVUN//YhdK5z6gw
 ITmlGq9Y7DGw+QOjRHtfWf9EjA==
X-Google-Smtp-Source: APXvYqyO+90m/YL8L/Um6r80hHXgZ7FB4Q/4Dne5ZvCwGHQfJQIjPTlWTIQL9uV2ufkh8Mx9lxReCw==
X-Received: by 2002:a7b:c347:: with SMTP id l7mr44691wmj.163.1565626725545;
 Mon, 12 Aug 2019 09:18:45 -0700 (PDT)
Received: from [10.201.49.73] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id l3sm25964724wrb.41.2019.08.12.09.18.44
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 09:18:44 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190718010456.4234-1-richardw.yang@linux.intel.com>
 <20190718010456.4234-2-richardw.yang@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d456eac-5d7f-570a-b73e-a55f2068579f@redhat.com>
Date: Mon, 12 Aug 2019 18:18:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718010456.4234-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 1/2] bitmap: get last word mask from nr
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
Cc: corentincj@iksaif.net, pl@kamp.de, kraxel@redhat.com, peterx@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/07/19 03:04, Wei Yang wrote:
> The value left in nr is the number of bits for the last word, which
> could be calculate the last word mask directly.
> 
> Remove the unnecessary size.

Hi,

the value left in nr is _not_ the number of bits for the last word if
the start and the end are in the same word.  For example, if start %
BITS_PER_LONG was 3 and nr == 1, you'd have:

- before the patch BITMAP_LAST_WORD_MASK(4)

- after the patch BITMAP_LAST_WORD_MASK(1)

Paolo

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 
> ---
> v2: refine bitmap_set_atomic too, suggested from Peter
> ---
>  util/bitmap.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/util/bitmap.c b/util/bitmap.c
> index 1753ff7f5b..5b15249796 100644
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
> @@ -182,7 +181,6 @@ void bitmap_set(unsigned long *map, long start, long nr)
>  void bitmap_set_atomic(unsigned long *map, long start, long nr)
>  {
>      unsigned long *p = map + BIT_WORD(start);
> -    const long size = start + nr;
>      int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>      unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>  
> @@ -208,7 +206,7 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>  
>      /* Last word */
>      if (nr) {
> -        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
> +        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>          atomic_or(p, mask_to_set);
>      } else {
>          /* If we avoided the full barrier in atomic_or(), issue a
> @@ -221,7 +219,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>  void bitmap_clear(unsigned long *map, long start, long nr)
>  {
>      unsigned long *p = map + BIT_WORD(start);
> -    const long size = start + nr;
>      int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>      unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
>  
> @@ -235,7 +232,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
>          p++;
>      }
>      if (nr) {
> -        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
> +        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
>          *p &= ~mask_to_clear;
>      }
>  }
> 


