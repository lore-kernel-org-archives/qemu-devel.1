Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A039C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54E321835
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvmpMEBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54E321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGBW-0004mo-Us
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihGAb-000484-5t
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihGAZ-0000a4-R0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:58:00 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihGAZ-0000Ze-JC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:57:59 -0500
Received: by mail-pg1-x544.google.com with SMTP id q127so5993003pga.4
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 08:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=35wX1HYRxAyJpHe8LnX7Y8fHENDYiRGdXDfL0VomOJk=;
 b=UvmpMEBeJL+ECJ45w+tDMOp5Z20XmhytSXycmInXunj53NsW2u3OqhdJQOKvxxy8tD
 a4dOnPftC4f8DbKjUWErjeK+7sRp7WNtOl6Hu1mUSYvEYGO9HhjxynKc9FNCHAGFOZ+i
 /Y/CvKeUHmM7cv5bYYV95KpSfKOz+5rXEoiJ1TtY1+uHF3TgLorXJsjSnanX/99qAoXr
 jl9wbLKKY+5SnBxlSaeLa9lEEHaBwHzDaH/1ws42G3cl5gyG785ydEiAi0DHLQd5DTW3
 UL2vbNMEAcCp/mkZ2eA488V+OFd+SLCsOZ7AOVnQdH4j32M91oAFovAZWIqBp5M1dety
 N+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=35wX1HYRxAyJpHe8LnX7Y8fHENDYiRGdXDfL0VomOJk=;
 b=SMTrpoTPMoIdtkyEC1dWOGt0F+DXYG86FtYk7n/LycoSSSsrRo8ZJNUzxUrpbhLX5K
 FcMrNewYDS9FQYS+qNNnS6jMl8plWoc5TRgX2MhvaImKun+gHzFHlK46EgYnLobQt56d
 NzyH0hq2oXNgHnGQmACngXt2kGXzV8X7G7NCYxNrgRXI1fLmzc+5ht3uhG8Xu9b8ILnY
 Ng/4VV2D7mBgZwOLBEfpfTTxixIRU8Wov8bu/OWj/cnJS5+hG7PUXRa9jl3IY/sYhaby
 TEWKM3mg5RtFQjbdtkvvUsynxMRXPbpy0mXL+DAvJr4g61MGLKwAfBeIe12V5SpNOc6V
 X82A==
X-Gm-Message-State: APjAAAU0nFpJOGry7GkZ2tGcfT2308JrtOzU0k7ApIn9Ctl6V1SMyjY5
 JT8kRJQ8Xs8MQwgkxr/plBPxwQ==
X-Google-Smtp-Source: APXvYqzjIHAl4TyhYYjoygIu3rxBy0b9BmBu3q1ol9CDjY/iPCaMQ0zQkYrXp9MC0tSuX2AUyGRXLg==
X-Received: by 2002:a63:cc02:: with SMTP id x2mr26541622pgf.114.1576601878297; 
 Tue, 17 Dec 2019 08:57:58 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id a15sm28528346pfh.169.2019.12.17.08.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 08:57:57 -0800 (PST)
Subject: Re: [PATCH] memory: Do not allow subregion out of the parent region
 range
To: Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20191214160223.20012-1-philmd@redhat.com>
 <da81a3e7-62a8-f46e-c12f-4dead2a9091f@redhat.com>
 <92bb8e12-3ece-9811-438b-8fa64d2bde66@redhat.com>
 <4a07cc6f-8762-145e-2b54-c61b0e287f19@redhat.com>
 <127AF076-D309-4952-B572-52587A93F46A@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c5c27111-efc5-0a05-bdbd-415533e5bc30@linaro.org>
Date: Tue, 17 Dec 2019 06:57:53 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <127AF076-D309-4952-B572-52587A93F46A@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
 "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 1:58 AM, Christophe de Dinechin wrote:
> 
> 
>> On 17 Dec 2019, at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 16/12/19 18:46, Philippe Mathieu-Daudé wrote:
>>>>>
>>>>
>>>> I think in some cases this could be intentional, for example if you have
>>>> different models with different BAR sizes and you organize this with the
>>>> same tree of MemoryRegion and different sizes for the parent.
>>>
>>> But if a child is outside of the parent range, it can't be reached,
>>> right? I'm confused, maybe AddressSpace can do that, but MemoryRegion
>>> shouldn't?
>>
>> Yes, the idea is that you could have for one version of the device
>>
>>   parent 0x000-0x7ff
>>     stuff 0x000-0x3ff
>>     morestuff 0x400-0x7ff
>>
>> and for another
>>
>>   parent 0x000-0x3ff
>>     stuff 0x000-0x3ff
>>     morestuff 0x400-0x7ff
>>
>> where parent is the BAR, and you can share the code to generate the tree
>> underneath parent.
> 
> I can see why you would have code reuse reasons to do that,
> but frankly it looks buggy and confusing. In the rare cases
> where this is indented, maybe add a flag making it explicit?

The guest OS is programming the BAR, producing a configuration that, while it
doesn't make sense, is also legal per PCI.  QEMU cannot abort for this
configuration.


r~

