Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93C1C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A553E206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTT2LzDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A553E206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isF8n-0004OZ-P9
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 19:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isF81-0003wR-7M
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isF7z-0005Al-Rv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:04:44 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isF7z-0005AJ-IV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:04:43 -0500
Received: by mail-pf1-x441.google.com with SMTP id i6so11046176pfc.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 16:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XESKgfMcYAa+GdbklKWIHyvwA3i0DmjGdPKhcbteKZg=;
 b=zTT2LzDAedcFU0UktRpMv8Cv9IQGLrpRAdqb1EjSXkgPpZx3HfK3YlpWTz55/OubBd
 vqHDnw005wwqbMCQw1jUITqstQiejgm3dHejqPF4D2H4jHa3xYGF1x0TGSm69XYp2frX
 02AdqO1iHtbKDImmaeE7DOeGU57pOPdaw1uy7JHsA94ATJOlqv0QSsGZcBs2yjszkMdi
 oZzqEQHCcoX/a7yr/n28Ds6yiQ578FMdIzvEQfiCNIAdHSY4UWvM/r+RgsbRF+4naZWo
 xRIuhlymDD4UNsmLEaL+asXldDGP0M0CiEPUicxcknGJwAPh5HXAihUSv/uPH5isvnjF
 ibgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XESKgfMcYAa+GdbklKWIHyvwA3i0DmjGdPKhcbteKZg=;
 b=bICTRsExPhHQHV7H3uHqf0pXij5z5nyeXspXdn5YYbIn5sugnjR9aBOftgXgYYGegA
 YfkEaqLO6e3Zxiu+od5nUC0JP2mQrrsRFOpwboDOpvi+88uDpxOCyCAwdr42U0hrZ3Bx
 XaC0aVAVzYRbMia+m8XZHiqWHKqnzAtFzMdlfRhHzrkSRPaKcx9Vy1nk9iMMgGHZawkb
 M8FSnhUlbB4UMQAKNIhOjiRLDI9oyT9TZmrVKs4+/mTR89C+oddG3gN18NYRAL+rkuio
 sOr7ecwoYyqh1y6m8dda6zrWaTlAWADGRDTxmyCRkB+i0j7LFTUQTABlRA+SnudIO5KD
 PVXQ==
X-Gm-Message-State: APjAAAVjnjWgO1LtbP7iaixfwgkigCmps/FRachGvD6U2mTTXsUL+eq6
 GWgJxPXOkerffy5CgIGWHWmISEPnU1g=
X-Google-Smtp-Source: APXvYqywexLYTJ7Nop0IUZcqcsWaCSw/T1mZ4O1m/xL7aBlDOjT6AU1uyyCqfyxWcRkm49+G866Svg==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr134164pfd.70.1579219482030;
 Thu, 16 Jan 2020 16:04:42 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id y5sm16701966pfn.185.2020.01.16.16.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 16:04:41 -0800 (PST)
Subject: Re: [PATCH] util/cacheinfo: fix crash when compiling with uClibc
To: Carlos Santos <casantos@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191017123713.30192-1-casantos@redhat.com>
 <CAFEAcA9dMRBtDs6QSXGVv_bNhtu5wnGKLvMxr2YuoWM=yomGDg@mail.gmail.com>
 <CAC1VKkNr8jN_0qVLtX5-YVH1dgN0fGAvnVZJXUpa+UfG_34ooQ@mail.gmail.com>
 <CAC1VKkPfacdLkXfHVNm-josjtds3Xsj=9NhRfNaQTyRv4XxEfQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <48f341e2-5844-2929-1c38-4ecd26ed8546@linaro.org>
Date: Thu, 16 Jan 2020 14:04:35 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAC1VKkPfacdLkXfHVNm-josjtds3Xsj=9NhRfNaQTyRv4XxEfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 1:18 AM, Carlos Santos wrote:
> On Thu, Oct 17, 2019 at 8:06 PM Carlos Santos <casantos@redhat.com> wrote:
>>
>> On Thu, Oct 17, 2019 at 9:47 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>> On Thu, 17 Oct 2019 at 13:39, <casantos@redhat.com> wrote:
>>>>
>>>> From: Carlos Santos <casantos@redhat.com>
>>>>
>>>> uClibc defines _SC_LEVEL1_ICACHE_LINESIZE and _SC_LEVEL1_DCACHE_LINESIZE
>>>> but the corresponding sysconf calls returns -1, which is a valid result,
>>>> meaning that the limit is indeterminate.
>>>>
>>>> Handle this situation using the fallback values instead of crashing due
>>>> to an assertion failure.
>>>>
>>>> Signed-off-by: Carlos Santos <casantos@redhat.com>
>>>> ---
>>>>  util/cacheinfo.c | 10 ++++++++--
>>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
>>>> index ea6f3e99bf..d94dc6adc8 100644
>>>> --- a/util/cacheinfo.c
>>>> +++ b/util/cacheinfo.c
>>>> @@ -93,10 +93,16 @@ static void sys_cache_info(int *isize, int *dsize)
>>>>  static void sys_cache_info(int *isize, int *dsize)
>>>>  {
>>>>  # ifdef _SC_LEVEL1_ICACHE_LINESIZE
>>>> -    *isize = sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
>>>> +    int tmp_isize = (int) sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
>>>
>>> Do we need the cast here ?
>>
>> It's there to remind the reader that a type coercion may occur, since
>> sysconf() returns a long and isize is an int.
>>
>>>> +    if (tmp_isize > 0) {
>>>> +        *isize = tmp_isize;
>>>> +    }
>>>>  # endif
>>>>  # ifdef _SC_LEVEL1_DCACHE_LINESIZE
>>>> -    *dsize = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
>>>> +    int tmp_dsize = (int) sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
>>>> +    if (tmp_dsize > 0) {
>>>> +        *dsize = tmp_dsize;
>>>> +    }
>>>>  # endif
>>>>  }
>>>>  #endif /* sys_cache_info */
>>>> --
>>>
>>> thanks
>>> -- PMM
>>
>> --
>> Carlos Santos
>> Senior Software Maintenance Engineer
>> Red Hat
>> casantos@redhat.com    T: +55-11-3534-6186
> 
> Hi,
> 
> Any chance to have this merged for Christmas? :-)

No, but it's queued now.  ;-)


r~


