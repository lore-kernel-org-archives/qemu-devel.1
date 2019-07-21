Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21029C76186
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 00:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D033320838
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 00:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEy45TjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D033320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hozLB-0000E9-Lq
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 20:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39138)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hozL2-0008HN-2P
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 20:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hozL0-0002ku-UH
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 20:04:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hozL0-0002jQ-Hb
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 20:04:26 -0400
Received: by mail-pl1-x642.google.com with SMTP id t14so17351767plr.11
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 17:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bbg94PZuJNokk3vTvZW8ztRKzGv0yjmdnNpy106J4dQ=;
 b=NEy45TjPj1jWKiQnL3xiJvUkv7XWGwAueIcmbtdn1WcsedQXuy2Xl2VEXwzGsSbD/j
 ea2/tz/cCkG042VpQibf1DlYSOYMmVk0p6EflkxZmP1VU5VXWoc2/6Ml7leY0QrjAaJd
 eHVx+L3xlgqHs8kJyM5kbbWcdXhR22fKm3omGOQ+plcT1mH0vB1GV2mSHuvvWzFF78VP
 cS5hZLYD8kZ/Ox+yn980uNA99c8AhiS4QH1Vq1b+lVt1qXZtj2hXDgw0un2cO7/giRBY
 rSptlESY3H1U5qvV2tflLkzLWYxZ2lhuUy4zNJINDAvAAiQ0chx3Utgd5O2ypmezcfVG
 anKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bbg94PZuJNokk3vTvZW8ztRKzGv0yjmdnNpy106J4dQ=;
 b=KI1nc3Ja7cZR51oHPFY2ZrpLObq/ah2G0+Ing+xuAp96P/qz0C+OE254eo+l/0kFex
 iY6Wgd+4dqqtdmgQSdFFKyXAILHH/fnCcvNqg3NT+YiIMU5CUpdy3buBxnX4lENKm2km
 gJQXPdBW2oMQ/43Re+QADpd/D+1DuzrhB3mV85DsYXI3Br6k+mvuEnp6GmSdj8RLpjFj
 1jxfjWoUlRFzxKv7Pt4D9Gsh1P2EfmX7izi8oc71Ec+KcpXt9ta5/ekjLVmb7F0nPAXP
 /M/AXzfnize6TAAzsnDjmd/wxtF6RKK7eg+s5/TRxCxhR5Tz2JIr8zJGKhybng5h2G9U
 yV/w==
X-Gm-Message-State: APjAAAXOqrPD/bKvLgtPcC5ZiNZUsQBbGDAC6Sv+w/gx3XHRnx9xEWJ/
 he++2dWTPUuS3Q7m6GpQi29k2Q==
X-Google-Smtp-Source: APXvYqy7RXIz28R2GkM0Gv2x99R3q3CYSk0sP23h13K2uzpwb+Xj1bAZtOW4GoY6OMwV5anDVa2Rnw==
X-Received: by 2002:a17:902:1566:: with SMTP id
 b35mr67790096plh.147.1563667464955; 
 Sat, 20 Jul 2019 17:04:24 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id 3sm37884825pfg.186.2019.07.20.17.04.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 17:04:24 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-18-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <63c92bca-d1f8-6dd7-35c9-9a8e87ba38b0@linaro.org>
Date: Sat, 20 Jul 2019 17:04:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-18-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [RISU PATCH v3 17/18] x86.risu: add AVX
 instructions
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 3:32 PM, Jan Bobek wrote:
> +# VEX.LIG.F3.0F.WIG 10 /r: VMOVSS xmm1, xmm2, xmm3
> +# VEX.LIG.F3.0F.WIG 10 /r: VMOVSS xmm1, m32
> +# VEX.LIG.F3.0F.WIG 11 /r: VMOVSS xmm1, xmm2, xmm3
> +# VEX.LIG.F3.0F.WIG 11 /r: VMOVSS m32, xmm1
> +VMOVSS AVX 0001000 d \
> +  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); $_->{vex}{v} = 0 unless defined $_->{modrm}{reg2}; 1 } \
> +  !memory { $d ? store(size => 4) : load(size => 4); }

Why the l => 0?  LIG does mean VEX.L ignored, so why not let it get randomized
as you do for WIG?

Not wrong as is... this is the documented value for scalar operands.  But there
is a different document markup, LZ, for required (E)VEX.L == 0.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

