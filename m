Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284B6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E532220679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="kj/yhVvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E532220679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrYo-0007wo-VB
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jkrWJ-0006iw-Oq
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:59:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jkrWH-0000jF-Rp
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:59:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id c71so71485wmd.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9Gd2RYW2L+4BwjkBf0sPxKKfQgFuP/xOd6FSKpeq1RU=;
 b=kj/yhVvwXraYIac57Miab8FFOcYoa49v21i+hRsmB4cTAvlFtBXfYHJ3e0IxB4Cius
 eFz2xVe21/mpQ2SmoWhZYrQ8XU8cYeFk1h7Z9rVXUaCyHoP/M45mzpkgQ8v1TNNx2ksk
 cA4bpr6HtDYa7JFO1PfipGa4cNE1U8oaCDkCLpqxoN8mBwSyRrzd2R+6e3FQebPN7KV/
 pBrdcFC5u9Dn1pVW7wh2BBwp3iKwKz7M7gcXEYX50LMT/FKjnN66N/ZiPmilOyIhOUoz
 LDyuaQzdXjSpWDhQ04eZ94AWYFralX9x7sFlsewLO6yFJNhPW8jMbBBXbgAeNUEkNZPd
 a31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Gd2RYW2L+4BwjkBf0sPxKKfQgFuP/xOd6FSKpeq1RU=;
 b=H0Vjq2H65gba38shOXd1toegG97Y2JvMG/5Xm08JTDUVrxgPrQ3moKLbY5HsQdKx2O
 LSmupQdKZCsXWk5O7JYFAi5dDhIA4nYuOo3OmHUWXhYBUPLfvU3dNIryiLDFdLa2CbTa
 oIJxpzSU6gcS1eiLA00N7eAc8+Fjd9N1eZpxuvPthOglPPYwNdNxHq60qZyFoTzwnogB
 XarO3qXKvkovR8rjt4FypH6bbT1cVjBw3DE1pH4jeRWFYiq+SQ/GpTpn9X67MI981iqo
 cspU2NoLi8OvBgEtks+dLjfDbZAuE23TjSXk+OE07/X62JcvMhiibTugTsDFll8B/Zyn
 zNoA==
X-Gm-Message-State: AOAM531zUDd0RxbNSU14bZxw4Pv+Wl6NXBUZle1mCwPP/IoAeBuZyuOh
 B+bBdktMOWLjE1O9C3Zj/q4gKQ==
X-Google-Smtp-Source: ABdhPJy0ATMv+OVjCB3dZF4baFaiGa8h91Fg+1ko7nRe9xlK+cm44j+VVGPRL2LHY5JfZJRCgf3lNw==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr13445126wmt.105.1592236771615; 
 Mon, 15 Jun 2020 08:59:31 -0700 (PDT)
Received: from linux.home ([2a01:cb19:867e:2100:7eef:23e0:9210:3e8])
 by smtp.gmail.com with ESMTPSA id z9sm22317726wmi.41.2020.06.15.08.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 08:59:30 -0700 (PDT)
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
 <1f4d93eb-0b89-5189-0147-3a456197cc0d@vivier.eu>
From: Fred Konrad <konrad@adacore.com>
Message-ID: <0cfb0348-d6db-db68-3181-85a605bfa91b@adacore.com>
Date: Mon, 15 Jun 2020 17:59:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1f4d93eb-0b89-5189-0147-3a456197cc0d@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=konrad@adacore.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 Aurelien Jarno <aurelien@aurel32.net>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missed this one sorry.

Le 6/12/20 à 10:31 AM, Laurent Vivier a écrit :
> Le 28/04/2020 à 19:17, KONRAD Frederic a écrit :
>> The MC68881 say about infinities (3.2.4):
>>
>> "*For the extended precision format, the most significant bit of the
>> mantissa (the integer bit) is a don't care."
>>
>> https://www.nxp.com/docs/en/reference-manual/MC68881UM.pdf
>>
>> The m68k extended format is implemented with the floatx80 and
>> floatx80_invalid_encoding currently treats 0x7fff00000000000000000000 as
>> an invalid encoding.  This patch fixes floatx80_invalid_encoding so it
>> accepts that the most significant bit of the mantissa can be 0.
>>
>> This bug can be revealed with the following code which pushes extended
>> infinity on the stack as a double and then reloads it as a double.  It
>> should normally be converted and read back as infinity and is currently
>> read back as nan:
>>
>>          .global _start
>>          .text
>> _start:
>>          lea val, %a0
>>          lea fp, %fp
>>          fmovex (%a0), %fp0
>>          fmoved %fp0, %fp@(-8)
>>          fmoved %fp@(-8), %fp0
>> end:
>>          bra end
>>
>> .align 0x4
>> val:
>>          .fill 1, 4, 0x7fff0000
>>          .fill 1, 4, 0x00000000
>>          .fill 1, 4, 0x00000000
>> .align 0x4
>>          .fill 0x100, 1, 0
>> fp:
>>

[...]

> 
> According to "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL" the explicit
> integer bit is "Don't care" for signed infinite (a.high == 0x7FFF) (this
> is the case this patch manages).
> 
> But wit a zero exponent and a non zero mantissa, it's a denormal number,
> and a signed zero has also a zero explicit integer bit but a zero
> mantissa. (both cases are already managed in the existing code).
> 
> with a non zero exponent less than the maximum value it's an unnormal
> number.
> 
> The denormal and unnormal numbers must be managed during the load
> operation in the m68k TCG emulation to generate directly the FP_UNIMP
> exception.

Is this already handled in the TCG code?

Thanks,
Fred

> 
> So I think, in the end, we don't have invalid number at softfloat level
> and floatx80_invalid_encoding() should always return "false" for
> TARGET_M68K.
> 
> Thanks,
> Laurent
> 

