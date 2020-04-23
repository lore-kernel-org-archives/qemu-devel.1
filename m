Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DD0C55192
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0681C20780
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNBSsiQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0681C20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRl1N-0004rV-2i
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 19:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRl05-0003fg-DT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRl04-0005DS-Da
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:11:21 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jRl03-0005BH-SI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:11:20 -0400
Received: by mail-pj1-x1044.google.com with SMTP id t40so3181909pjb.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bS5Ds58YVb6VQc7K4RAJmf5pnUFf2FMvRoBV2Y/BIrU=;
 b=oNBSsiQkqQTNqNf6j+T4n+mAW1OYMBtMXWATdSiN7lqlnA1Sd7cFQtaO9jcth5Kh6N
 iFlPgKsd8LHGYPXl2lbx/muO4Og65ukhTsO3HEV6TctW5+j3+5p2/RT90ILycsnCI9SJ
 ArccjhSvZLRuT42G+KeZjymljCS9OoIImx4G5BfZ/7xnBm39oTfC/s3zw9XSIGtY5fP4
 ahoff08hU+ychJEsr9vGxTEf8zALsxpPOGWJ7NgeTVTY98vfeE4grl4MGqaEvVged69X
 c92f5xzRG5+E/gm2QB7hsWmXn3cL+aoRZCppdtKxXNG/gq9SX9guJc3w0aZCbIiwceUO
 kAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bS5Ds58YVb6VQc7K4RAJmf5pnUFf2FMvRoBV2Y/BIrU=;
 b=F6nSUrruljg7qwNdyFOnNKJyLyD0vuetS/+d3vJ2kwVEOvzp6NKZM3VJyoAHD+rsjc
 f/EhRHsyqmuebuY9Ek1N83b8kFiuPvNcincvIswjUIc4r+uaOHigHSPGJ6qdbyK8z7k5
 9O3qt9KBpvMLPw/LvFzjau4LiDGnn69zXVlzK5yrlvCOq0YkuTrm7f4gELYGpBx1yvwb
 iVqUf96G8r2YZjE1UM22w4S7WfGxiBchaPMVyssaviMm0pF7xfJgDMVIKZ6QhG/wftPT
 jVrKvKxEX10b+PzxhPiPCyzbiLpxyJYFfFgPg838qiyr+yP62GQoAxRUU6Iqa4Gac428
 xS8A==
X-Gm-Message-State: AGi0Pua9WG/QzDugaBv4sCoB7nsqHHuOVddT73PNrQQlLCFbdKaK3c4m
 x/KewyZLF2Mlk1VJEDzrp/6qUjyd4iE=
X-Google-Smtp-Source: APiQypIemCKEOQHcswER+/lIJQKBEanqx/VB3hXX6oboCLc6H/OSfU0f7S9gPJQaVDPj4Vf5m3JJZg==
X-Received: by 2002:a17:90a:a484:: with SMTP id
 z4mr3154751pjp.40.1587683477467; 
 Thu, 23 Apr 2020 16:11:17 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id p64sm3361746pjp.7.2020.04.23.16.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 16:11:16 -0700 (PDT)
Subject: Re: [PATCH v2 09/36] tcg: Consolidate 3 bits into enum TCGTempKind
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-10-richard.henderson@linaro.org>
 <CAHiYmc7eFG5FSa8z1gEv0Cdi+eBvOx-Y4_2qFCM-EYNZBPqd6A@mail.gmail.com>
 <a3133ba4-9146-bd1a-98be-c41077a18eca@amsat.org>
 <574ccd10-74a3-49e9-5301-015c0a93df1e@linaro.org>
 <20200423172400.GK1077680@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dfc47f62-d92d-70c5-3bf0-01002fbe96ea@linaro.org>
Date: Thu, 23 Apr 2020 16:11:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423172400.GK1077680@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 10:24 AM, Daniel P. Berrangé wrote:
> On Thu, Apr 23, 2020 at 08:40:10AM -0700, Richard Henderson wrote:
>> On 4/23/20 2:00 AM, Philippe Mathieu-Daudé wrote:
>>>>> @@ -1885,12 +1896,17 @@ static char *tcg_get_arg_str_ptr(TCGContext *s, char *buf, int buf_size,
>>>>>  {
>>>>>      int idx = temp_idx(ts);
>>>>>
>>>>> -    if (ts->temp_global) {
>>>>> +    switch (ts->kind) {
>>>>> +    case TEMP_FIXED:
>>>>> +    case TEMP_GLOBAL:
>>>>>          pstrcpy(buf, buf_size, ts->name);
>>>>> -    } else if (ts->temp_local) {
>>>>> +        break;
>>>>> +    case TEMP_LOCAL:
>>>>>          snprintf(buf, buf_size, "loc%d", idx - s->nb_globals);
>>>>> -    } else {
>>>>> +        break;
>>>>> +    case TEMP_NORMAL:
>>>>>          snprintf(buf, buf_size, "tmp%d", idx - s->nb_globals);
>>>>> +        break;
>>>>>      }
>>>>
>>>> Hmm, why this switch doesn't have:
>>>>
>>>>         default:
>>>>             g_assert_not_reached();
>>>>
>>>> like the other ones?
>>>
>>> ... then all switch should have a default case, as noticed Aleksandar.
>>
>> There's a bit of a conflict between wanting to use -Werror -Wswitch, and making
>> sure every switch has a default.
>>
>> With the former, you get a compiler error of the form
>>
>> error: enumeration value ‘FOO’ not handled in switch
>>
>> which lets you easily find places that need adjustment enumerators are added.
> 
> FYI,  -Wswitch-enum can deal with this. This gives a warning about
> missing enum cases, even if there is a default statement:
> 
> [quote]
> '-Wswitch-enum'
>      Warn whenever a 'switch' statement has an index of enumerated type
>      and lacks a 'case' for one or more of the named codes of that
>      enumeration.  'case' labels outside the enumeration range also
>      provoke warnings when this option is used.  The only difference
>      between '-Wswitch' and this option is that this option gives a
>      warning about an omitted enumeration code even if there is a
>      'default' label.

This warning, IMO, is useless.

All you need is one enumeration with 100 elements -- e.g. TCGOp -- and you
certainly will not want to have to add all enumerators to every switch.


r~

