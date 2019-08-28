Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F36BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7AA62189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X74RCDyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AA62189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i35W5-00048L-VO
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 17:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i35Uc-00034K-9W
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i35Ua-0003LD-Un
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:28:37 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i35Ua-0003Kw-NV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:28:36 -0400
Received: by mail-pl1-x641.google.com with SMTP id o3so529406plb.13
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wjg0xlXJIX8qztizzqID0rdk7WOO7Bus9Jg0yc3r8lI=;
 b=X74RCDyZtOAbZ5r6Y/s7S/7UJDSKNj/d7hnmR3is47FeCiGDA1mfiKaXcBAlrTI6XV
 wgkTd05pONw6I3GmZf3/LNpqv1TqhPlvyyfqQurunW58x83TQC1+t+4CAKD9i/nVKkxh
 F9gfJlDESdvo6O9p/78AM1Hm8yIkehzxEei/6cDSv6E8ebbWcJgx4vcjetKr9K3lM+j6
 jeFRSzvU9bFj1FTMV5osJapucK8YSmwFyzYufnI9rnx4AyFwrt7HP1cdsKJtbEmd5Esf
 jelwluoyEUDQP6zt2xEArtBKFykwFqP9U6KOwC7gsrEl1XeEwy+NVMymoar7SIIrli7b
 9uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wjg0xlXJIX8qztizzqID0rdk7WOO7Bus9Jg0yc3r8lI=;
 b=R98BG4Md6QLjSNIKrIf4C+5/2ydhPCHMBz1p9u7Ot5fZSNGDPKTKz0Dy+ddhs0ulqh
 f2uyMTJ7Epr6AGnJeMt5citbvovCPVtOmNsSbWdoOxlVsM3wGDajqSiwa32/AnkJhbI5
 lmX++xKwUfGe3qRUeLw2gvd8Np2W9GVAP6NZo2fiacoP5yCnug9KGZqr1YZ1fjp2WIh6
 l7b9I5QnMRgiekBRDGQpvZTxNwZqjNn/N12hhJAxAmoLXg7UqeNwCVmiUsI9Be3l2DF0
 g5T0J1IJaWvbI/4X6vd+jgEztvjvXl1obTOck6Bfv0oOr3uTaVlEiFoN+FimifeeAxAr
 E5xA==
X-Gm-Message-State: APjAAAU+iU3knxPLXx8meZ9d+TonAc5SCtxIvQiNQwhbg8k0DKZzpR46
 O0b7vgB/OKE9PS720ZsOJKiGuw==
X-Google-Smtp-Source: APXvYqzTl99Y7SV8N/fOIx5I6VNfK1Yh2Ay1UZz+s1c4atOXluiYzhwwMHEnmEO8Xt57bZOdbDHLWA==
X-Received: by 2002:a17:902:ff03:: with SMTP id
 f3mr1315132plj.134.1567027715578; 
 Wed, 28 Aug 2019 14:28:35 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j1sm294563pfh.174.2019.08.28.14.28.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Aug 2019 14:28:34 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190824213451.31118-1-richard.henderson@linaro.org>
 <20190824213451.31118-5-richard.henderson@linaro.org>
 <77c9af3e-4c18-a20f-137e-468d04583241@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a699d74e-c257-0abb-7680-1bd2038f1c88@linaro.org>
Date: Wed, 28 Aug 2019 14:28:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <77c9af3e-4c18-a20f-137e-468d04583241@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH 4/6] exec: Factor out
 cpu_watchpoint_address_matches
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/19 1:41 AM, David Hildenbrand wrote:
>> -    /* Make accesses to pages with watchpoints go via the
>> -       watchpoint trap routines.  */
>> -    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
>> -        if (cpu_watchpoint_address_matches(wp, vaddr, TARGET_PAGE_SIZE)) {
>> -            /* Avoid trapping reads of pages with a write breakpoint. */
>> -            if ((prot & PAGE_WRITE) || (wp->flags & BP_MEM_READ)) {
>> -                iotlb = PHYS_SECTION_WATCH + paddr;
>> -                *address |= TLB_MMIO;
>> -                break;
> In the old code, we were able to break once we found a hit ...
> 
>> -            }
>> -        }
>> +    /* Avoid trapping reads of pages with a write breakpoint. */
>> +    match = (prot & PAGE_READ ? BP_MEM_READ : 0)
>> +          | (prot & PAGE_WRITE ? BP_MEM_WRITE : 0);
>> +    flags = cpu_watchpoint_address_matches(cpu, vaddr, TARGET_PAGE_SIZE);
>> +    if (flags & match) {
> ... now you cannot break early anymore. Maybe pass in the match to
> cpu_watchpoint_address_matches() ?

Hmm, yes, perhaps.

OTOH, summing a bitmask is a very quick operation.  Depending on the total
number of watchpoints, of course...


r~

