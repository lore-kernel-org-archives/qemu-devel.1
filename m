Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CA6C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5293B21881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5293B21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijDM-0008Vj-5U
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hijBP-0006fJ-9y
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hijBO-0006yp-6f
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:36:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hijBO-0006y3-0Y
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:36:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so3764380wro.5
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 10:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aI0yeQc6v5UMU4Kp3fLSRgG8ukXdGmTXoUoMZxVeetE=;
 b=uFF1imYbgUx9tdANyUdF+nR21MxhY6a7BV3gE8dxUdGXhW6oTUL6wJegDta041tA3C
 cD2QrowI+S55VuyxIyvvVL2DzqrI0a3X9d8OeNEUb1ZXDgrOf2ecbLTPIsL3oRwiiCH7
 A6kcpQPd0VEJq7NWeCzTdD51Gc4+0HOVARegDC5SC1ahpkhrzqzLjKhRP1e5irxRQall
 88WVyxMzW78iwJ/Rl9+tKC0zAIFmqmAskFjJ4vmK3D8OAyF6lN+C9hIwQ8dpoG5GPb/d
 V+6HoW/51PYbZZGAG5DTH5MIqqbWEIft3JHRPVRGO+whs08V1zanAIen+bLBprgIspHX
 Yy9g==
X-Gm-Message-State: APjAAAXdAhZim0yVjKoLFyyH0+iA0Mbx7FXdZxUrSP/w7UHzmoQlHzhy
 h6/U7N3VA3I7aaRpM4PscbjWWg==
X-Google-Smtp-Source: APXvYqyJk9Dw8RIGpm8nsP7B76dDpbQeeJvQUiHK7vGFlj9fFBHUKJ9qyddjIyXKsTdfW7t8+vyfLQ==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr31798943wru.310.1562175396917; 
 Wed, 03 Jul 2019 10:36:36 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id 72sm4132317wrk.22.2019.07.03.10.36.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 10:36:36 -0700 (PDT)
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190628181536.13729-1-huth@tuxfamily.org>
 <20190628181536.13729-4-huth@tuxfamily.org>
 <074eb5c6-8a7f-1018-47f9-9801e0aba704@redhat.com>
 <9b4187dd-9079-b511-aea7-2b8c992a3067@posteo.de>
 <6242593f-9472-8bc5-c65e-bea3aa0149c8@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <586ab7ad-9acb-e6f8-36c1-170942d8a888@redhat.com>
Date: Wed, 3 Jul 2019 19:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6242593f-9472-8bc5-c65e-bea3aa0149c8@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 3/4] m68k: Add NeXTcube machine
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 7:00 PM, Thomas Huth wrote:
> On 02/07/2019 19.43, Thomas Huth wrote:
>> On 29/06/2019 14.26, Philippe Mathieu-Daudé wrote:
>>> On 6/28/19 8:15 PM, Thomas Huth wrote:
> [...]
>>>> +static uint32_t mmio_readb(NeXTState *s, hwaddr addr)
>>>> +{
>>>> +    switch (addr) {
>>>> +    case 0xc000:
>>>> +        return (s->scr1 >> 24) & 0xFF;
>>>> +    case 0xc001:
>>>> +        return (s->scr1 >> 16) & 0xFF;
>>>> +    case 0xc002:
>>>> +        return (s->scr1 >> 8)  & 0xFF;
>>>> +    case 0xc003:
>>>> +        return (s->scr1 >> 0)  & 0xFF;
>>>
>>> So you have a 32-bit implementation (DMA accessed device?).
>>>
>>> memory::access_with_adjusted_size() already does this work
>>> for you if you use:
>>>
>>>    .impl.min_access_size = 4,
>>>    .valid.min_access_size = 1,
>>>    .valid.max_access_size = 4,
>>
>> Yeah, it's old code from 2011 ... I'll try to rework it as you suggested.
> 
> That does not really seem to work. I'm then still seeing accesses to
> 0xc002 in my "readl" handler. Looks like access_with_adjusted_size() is
> not really ready for that yet (see the FIXME in that function - it does
> not take care of unaligned accesses yet).

I was convinced the unaligned series [*] was already merged. Anyway you
give me a good news, we have new a test for it :)

[*] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06957.html

