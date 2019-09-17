Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F21C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4D620678
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IO9ApJlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4D620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAIxE-0005TW-1K
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAIuL-0003Qo-Us
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAIuK-0007N1-Nn
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:13:01 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAIuK-0007MC-Bo
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:13:00 -0400
Received: by mail-pl1-x644.google.com with SMTP id t11so1948277plo.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qYG/X0ICQ8dIQ8H8r8RkLV1BT/pCCS126mBrzAl8iMo=;
 b=IO9ApJlI1t+CqhoJAvDpJaOdWndvSweiNswKa5ktwlcctl4AM2HqdVZEV4ALRSJVFR
 118a0nY6+x5MvA3J3K2eqhjsNKypXoDtU4bYl4mUBmQuWfHV6zspJj1voIDfM3vW8bHk
 ++/Zkh/udE1SUquf/se9NVWuUc0EdVLdZOGJZkZPtm1Wipoh4jdsdBIizhqSmpRDeynz
 Se9oQEcLRZJfiFY6rmlyg29sP/oY1OX9TU2K2VWWRKD7QLEB36gcdQyFAOahy4hnz80l
 mo6jaIJUlxB6noNqbD+sUwXNfOL7UVEbfpFZlY2mNz5XU225vy/lpZMPUfSQ2DVeuVWS
 joVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qYG/X0ICQ8dIQ8H8r8RkLV1BT/pCCS126mBrzAl8iMo=;
 b=h8WbRctPZB1dRau+6G6YeGraY2SMmynXJ40Feb6Jr/+ygOIfCrM8qAquizwEBol63J
 De/srhkRlGZ8Ai4fhESw+hMpLklyCebKNgg0QknijODasEZglV8ZhVsbBe3+ycUYe+nY
 hRueOxf1M4NEwrvbkC6uhqOBUS+SE/BRzjUkvGVKytD3n/6bL8tmWxyphb5FfcHwDXJ4
 fuuL8ve7azaXsxON8NmGtHpfX8lxRqAJBjIAGWaN1V+aX2A2QdPygnETjr2E+flgHBir
 EuOyiBR6RB5BIkxLfRt269JS5wVMqIFXuAnXOD6Ko/hrDDxWT3P9dxu62L7MCxwtJHBk
 LKUQ==
X-Gm-Message-State: APjAAAU/NGhP7mG2rocUwkFuELK+FsZsQnzehtQHWdcnwpzJO/TTmHyT
 G5gZSBqr66RsAWTbueIWi49h1Q==
X-Google-Smtp-Source: APXvYqy15yLLCYzZ/P/cYCdFB4g50mxz7py4rO8QpxUBZxHJP+zIIoUFZwN8AWPuI0D1a315wu2CsA==
X-Received: by 2002:a17:902:b58f:: with SMTP id
 a15mr192996pls.81.1568747578560; 
 Tue, 17 Sep 2019 12:12:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j128sm4736523pfg.51.2019.09.17.12.12.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 12:12:57 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <83f649c6482bf363c38e7f3778d866f4@linuxsystems.it>
 <9d1ea4ff-a0df-f7c6-54ca-c03b010c5ff1@redhat.com>
 <CAFEAcA94_kJ=5ABvB6B11U5NKpxka7e11tkB46m7qSMBFQQW9A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <88e64ee8-0fe4-ccb7-03c6-40f391e39d1d@linaro.org>
Date: Tue, 17 Sep 2019 12:12:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA94_kJ=5ABvB6B11U5NKpxka7e11tkB46m7qSMBFQQW9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] ELF load command alignment not page-aligned
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Niccol=c3=b2_Belli?= <darkbasic@linuxsystems.it>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 7:40 AM, Peter Maydell wrote:
> On Tue, 17 Sep 2019 at 11:49, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Cc'ing PPC folks and Laurent.
>>
>> On 9/16/19 11:06 PM, Niccolò Belli wrote:
>>> Hi,
>>> I'm trying to use qemu-user-static to chroot into a foreign amd64
>>> environment from my ppc64le host.
>>> The host has a 64k page size, while x86_64 uses 4k.
>>> I get those errors while loading shared libraries: "ELF load command
>>> alignment not page-aligned"
>>> Is there any way to fix this? I cannot simply switch to 4k page size
>>> because my btrfs filesystem won't mount anymore (it requires the
>>> sectorsize to be equal to the page size).
> 
> I vaguely recall that the answer is that we don't really
> support running a linux-user guest which has a smaller page
> size than the host. There are some sort-of-hacks in the code,
> so some simple cases might more-or-less work, but I'm not
> very surprised that you've run into something that doesn't
> work.
> 
> Cc:ing Richard who probably has a more accurate answer.

You are correct that this combination will not work.

This combination is exactly why I've proposed enabling softmmu for linux-user.
 With that, arbitrary mappings can be made between host and guest.  But it's a
fair amount of effort, which no one has yet found time for.


r~

