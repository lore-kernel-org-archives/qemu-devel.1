Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0964C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CFB21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIs/BnrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CFB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hla4o-0006li-Cc
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33979)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hla3w-00069p-Av
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hla3v-0001cu-5C
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:28:44 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:34762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hla3u-0001b2-Uo
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:28:43 -0400
Received: by mail-io1-xd41.google.com with SMTP id k8so13033316iot.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BCz8PmncgLDLTIfcsUMQ4RV6JzaofBiCvQ8WjkMCpgc=;
 b=WIs/BnrSAXnqOL5CFVMtUFUyCyCp2CEsYh2IPq/3FxVhE+X0FruVDikziOFFTDMJlE
 LUk+WQvnl+RZeWXbgwHj38Ox/j/MJuflHSAAf9744M8KfPm37HJyDdPIvhSGsPU8+hUG
 6P4fjbUd+WgU2MateZpPByf7js6KwNKxBEV9G5jdVXNK2k1sdMgUKPsTt0Ovq5JdLcJ/
 kBRP45VvekAxZI2NlUgmjVdScS20wX70p3B5Y+dsEw3LTcUmDS7XkscjQnN6dOmRsrrL
 pvtrHkjRzGnp1W8TuO5QX4AONpske7kpCR61trxDh3n6xecSF+k9wD1uAuS9UDIz0/4c
 p7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BCz8PmncgLDLTIfcsUMQ4RV6JzaofBiCvQ8WjkMCpgc=;
 b=RCJ/FINa1D6R7ceOKvr2Blw0ESTXePZZjTZ3+k/WhyGV0LG6ASFowMCDhmpF1Zb5v3
 oEZSAxHPHJGIyoAxkVdQQiQhgCW8IJLJQMiOtkf3McP0EejX71qsvx55B2zQFFRvV3Br
 VYGC5ZqexrJcIz3ASL4qvI8ItIuwXPeqf5nCPNmTC5+jeHmQX9TZ1/sOx0N1VpGizjmL
 vb2BxwpoZrsF1dpnQuVdv3FdtFL7yozaA8VIeCUyrnGOVNeE/7HpSavGPJIfIswxeix1
 +f/5wOP49qjJfU98kqrd4tK/CwNSMq+UcsEfFtmDfsw2a1gqGPVACgJAOJUA90zUF3fk
 jWBA==
X-Gm-Message-State: APjAAAVbDfu5XP8+9lSKugNcM/2bPmQp+8LzDzJ7gzUQZ7Vct7gJQSFm
 MuDvpkgF7BqKOWd56CjMP9uGnw==
X-Google-Smtp-Source: APXvYqzu8luan2W9ZjcMhU48gOVl3JYjHxmokqMNt0tB24R2wH2JuzXaMtq9IakNqhSXBD5WRH861A==
X-Received: by 2002:a5d:890d:: with SMTP id b13mr4491321ion.124.1562855322156; 
 Thu, 11 Jul 2019 07:28:42 -0700 (PDT)
Received: from [192.168.43.94] ([208.54.80.147])
 by smtp.gmail.com with ESMTPSA id p3sm6097301iom.7.2019.07.11.07.28.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 07:28:41 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
 <9e107b82-4a51-e2ea-ee1e-19c4d4e05d01@linaro.org>
 <5f9b2e47-9fd8-8825-2169-c9398099d515@gmail.com>
 <e2f9fb4a-ef08-4630-e33f-7c827254a3d6@linaro.org>
 <68048912-a5f6-7885-4a5d-17957e3cb890@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c1afbb8a-3ece-e521-fdb3-1936cfc4e729@linaro.org>
Date: Thu, 11 Jul 2019 15:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <68048912-a5f6-7885-4a5d-17957e3cb890@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 06/14] x86.risu: add MMX
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

On 7/11/19 3:29 PM, Jan Bobek wrote:
> However, I downloaded a fresh copy of Intel SDM off the Intel website
> this morning (just to make sure) and in Volume 2B, Section "4.3
> Instructions (M-U)," page 4-208 titled "PADDB/PADDW/PADDD/PADDQ—Add
> Packed Integers," there's the NP 0F D4 /r PADDQ mm, mm/m64 instruction
> in the 4th row, and the CPUID column says MMX. On the other hand, I
> can't find it in the Volume 1, Section 5.4 "MMX(tm) Instructions," or
> in Vol. 1, Chapter 9 "Programming with Intel(R) MMX(tm) Technology,"
> so it's a bit confusing.
> 
> If you know for a fact that it didn't come until SSE2 and the manual
> is wrong, I will change it.

Interesting.  I see what you see in

  253665-069US January 2019

but I first looked at

  325462-058US April 2016

which definitely has this marked as SSE2.

In the 2019 version, "5.6.3 SSE2 128-Bit SIMD Integer Instructions" is the
first mention of PADDQ.  Whereas "5.4.3 MMX Packed Arithmetic Instructions"
mentions PADD{B,W,D} but not Q.

I tend to think that this is a bug in the current manual.

Checking in binutils I see

> paddq, 2, 0x660fd4, None, 2, CpuSSE2, Modrm|No_bSuf|No_wSuf|No_lSuf|No_sSuf|No_qSuf|No_ldSuf, { RegXMM|Unspecified|BaseIndex, RegXMM }
> paddq, 2, 0xfd4, None, 2, CpuSSE2, Modrm|IgnoreSize|No_bSuf|No_wSuf|No_lSuf|No_sSuf|No_qSuf|No_ldSuf|NoAVX, { Qword|Unspecified|BaseIndex|RegMMX, RegMMX }

and both contain CpuSSE2. If you like, I could run this by one of the Intel GCC
folk to be sure.


r~

