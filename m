Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9EC55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BDC2098B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zUBDuxif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BDC2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdyf-00049O-Jb
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRdxZ-0003No-Lt
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRdxY-0008Un-DJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:40:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jRdxX-0008MP-VH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:40:16 -0400
Received: by mail-pf1-x444.google.com with SMTP id x77so3145329pfc.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ga+RaqdsdYTpSWo9IsrGnPuPsN6RyBMc11hGLkS1Xcc=;
 b=zUBDuxifGtZ+1lxLrxxYIbVqDiU2GHZqhjyK5Ek+9b7c/V7KhdmwioFQIQ79ViOx98
 vG6HvJSGSWzDpiRy76q5ikjpvjghNnaDiV0SHLL3PY8sbrdoqr8yuos81N5xS295Qdu+
 eqLjVETS7fjsjprVCltlzVafL1bmE3QtCOeIq6qcHwnZ8mJYUHPhHHLebOSoe5lFoBRB
 SjugPy93lMiMqnneO5CabdOY5HjVV4z32RIBJ0J93+c/tFcSaoSuM+U0Ond9ix/++Atq
 52oABT5L7jO5lpt27yv6KtZ9DPiqhITQhOVO9T1deXSUXDroqJH8nVCFQIXY6WfaHkeJ
 7uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ga+RaqdsdYTpSWo9IsrGnPuPsN6RyBMc11hGLkS1Xcc=;
 b=fGYfHYDx/Dxb9gxedL/wN4xdEyOMcm15tUvEG/mHk11JSSTWY6KdIbJF+IMdUfdDxp
 MM4Qf0f6aX8nsrNzc8TKn3CJ8KTdJenBlD1iudF6SjnLjxS07YduxPtggCeGOPR7lNKs
 pGaA7GhHB1r04YsIuZdvQtHgjpa8MnPRj1xt4DmCX5CHPOOy8+ta1meLH8WU8UkEY7QX
 7FUGpkWYytwBDBU7UOz+RZ0CpJ2+AjhcZN0GTvI/2VCHd4gqnwHfTw2Q1UYom6HA83Hd
 s4g5LShppQQhuhNJtOZ/dhiMOiIlcZquAIZO7GP36eFawZr0C0lse6hBk1VjXbWJnBrU
 gOMA==
X-Gm-Message-State: AGi0PuYwsPChcYnCwi86uUJeQ7NMmuwAj/ScTUQH53xB3Lb2uwWNsY2Z
 UuH/4M5tMJVrOzM7btRmhxiW6+ZJTM0=
X-Google-Smtp-Source: APiQypJvyoOtpvcEl9iaDOK9F6rfVkbIdKyBXoFTZ2nngRkhSui+lAoBpxaIu2xyqXfHsIMMzvm32A==
X-Received: by 2002:a63:8ac4:: with SMTP id y187mr4535481pgd.294.1587656413417; 
 Thu, 23 Apr 2020 08:40:13 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2851617pfq.100.2020.04.23.08.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 08:40:12 -0700 (PDT)
Subject: Re: [PATCH v2 09/36] tcg: Consolidate 3 bits into enum TCGTempKind
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-10-richard.henderson@linaro.org>
 <CAHiYmc7eFG5FSa8z1gEv0Cdi+eBvOx-Y4_2qFCM-EYNZBPqd6A@mail.gmail.com>
 <a3133ba4-9146-bd1a-98be-c41077a18eca@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <574ccd10-74a3-49e9-5301-015c0a93df1e@linaro.org>
Date: Thu, 23 Apr 2020 08:40:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a3133ba4-9146-bd1a-98be-c41077a18eca@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 2:00 AM, Philippe Mathieu-Daudé wrote:
>>> @@ -1885,12 +1896,17 @@ static char *tcg_get_arg_str_ptr(TCGContext *s, char *buf, int buf_size,
>>>  {
>>>      int idx = temp_idx(ts);
>>>
>>> -    if (ts->temp_global) {
>>> +    switch (ts->kind) {
>>> +    case TEMP_FIXED:
>>> +    case TEMP_GLOBAL:
>>>          pstrcpy(buf, buf_size, ts->name);
>>> -    } else if (ts->temp_local) {
>>> +        break;
>>> +    case TEMP_LOCAL:
>>>          snprintf(buf, buf_size, "loc%d", idx - s->nb_globals);
>>> -    } else {
>>> +        break;
>>> +    case TEMP_NORMAL:
>>>          snprintf(buf, buf_size, "tmp%d", idx - s->nb_globals);
>>> +        break;
>>>      }
>>
>> Hmm, why this switch doesn't have:
>>
>>         default:
>>             g_assert_not_reached();
>>
>> like the other ones?
> 
> ... then all switch should have a default case, as noticed Aleksandar.

There's a bit of a conflict between wanting to use -Werror -Wswitch, and making
sure every switch has a default.

With the former, you get a compiler error of the form

error: enumeration value ‘FOO’ not handled in switch

which lets you easily find places that need adjustment enumerators are added.

With the latter, you only get a runtime failure, which can be more difficult to
find if you've missed one.

We do not always have the option of relying on -Wswitch, if there are other
compounding warnings such as uninitialized variables.

In this instance, we can rely on -Wswitch, and I see no reason to add a default
case.


r~

