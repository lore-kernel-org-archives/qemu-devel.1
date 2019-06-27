Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0B5C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8905204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Clc3U9wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8905204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSoL-0006Jn-VQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34491)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgSgV-00024D-1d
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgSgT-0001xy-5L
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:35:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgSgR-0001uX-EV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:35:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id v14so2163715wrr.4
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=f71s4kh9uJ8lWfKZYm5WBKZeBr81cCBGcYjn+fA9IBU=;
 b=Clc3U9wr2MaE4wDGcNA/IKDWeAc1TM279MCoNNQZJUz6egFkaWL3T3xQMCKLHNO+mN
 4PV9wVSN25j2GkB724qwRpNTxy6bazayQSfr0mNzOqlSUAgE0KJqX2k0+xuOXP/EOAHm
 uO2rGsES8wTOxSp3Xg4whywGCC/ltgTRuY26acJ/b0bwHMR6430R1K2YaUV7Yjesa6kF
 wJhJ+zB0WUJ5OFoJ2uQxa8RPUpwdiScu5hc1gdKI4QwmdR2XkIU5oNf9bZykD2Mehs+l
 LOfZTuuaB5AehezUG0mVCNamIDC29XfZRtWaT0G6NHLjSUhdDnXFX3YAbr4Rz8mXKpeH
 xz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f71s4kh9uJ8lWfKZYm5WBKZeBr81cCBGcYjn+fA9IBU=;
 b=JR2Wcvkdi1o4EMXacAveymwdBIrG4w5H2SF5yDamYIyuJhq/J+jV8jJvXRyUIFxhy9
 MRJyQj5yTO51Vk9xTTtqL6LpXfwhhN96r8FXvPr3ktgS/MMWXOn0FNvn9h02gz1KGfCy
 HutRf6gKDsI5Tj2r0SofDT7pUiHppWWV8eFsk0WHTxCOGgFN62d7FjXSmlic6bqhzNnX
 P+zWOjyCfxD+kjarLPDlj5OEdWArkvfxB0cdDMFmMqmOLP5kVGyyGJ6XN88vyJN9e/ek
 YGdHlaFydASVl2N2UNHVWHJwuX+f67bG64tiM9x+gtGiDSSkCyD+04rIj+6sNjnIRYaI
 jSDg==
X-Gm-Message-State: APjAAAUDCtUmptrCqdMxEpQme7hNU9RZEfnU3vYvteHi9QPdbP+RB1Ug
 CdF/tZlHA8onNYPpKyu1rGiCsQ==
X-Google-Smtp-Source: APXvYqyFxGBUN5p3qVOysMaylEFXaFgIWBP133Lc56zkTk5AtjBUOlIjR3ZJv2cxAGEAYkSCy1sSpg==
X-Received: by 2002:adf:fb8d:: with SMTP id a13mr2910961wrr.273.1561635314452; 
 Thu, 27 Jun 2019 04:35:14 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id c6sm7415579wma.25.2019.06.27.04.35.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 04:35:13 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1561632985-24866-9-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d42d0cdf-1cc5-b434-f974-4d5bde543271@linaro.org>
Date: Thu, 27 Jun 2019 13:35:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561632985-24866-9-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v4 08/13] tcg: Add opcodes for vector vmrgh
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
Cc: hsp.cat7@gmail.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/19 12:56 PM, Stefan Brankovic wrote:
> +void HELPER(gvec_vmrgh8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < (oprsz / 2); i += sizeof(uint8_t)) {
> +        uint8_t aa = *(uint8_t *)(a + 8 * sizeof(uint8_t) + i);
> +        uint8_t bb = *(uint8_t *)(b + 8 * sizeof(uint8_t) + i);
> +        *(uint8_t *)(d + 2 * i) = bb;
> +        *(uint8_t *)(d + 2 * i + sizeof(uint8_t)) = aa;
> +    }
> +    clear_high(d, oprsz, desc);
> +}

I tried this while developing the ARM SVE code.

The problem is that the vector element numbering differs for each host.  So
while you may be able to get the correct results out of x86, you'll the the
wrong answers when you run this same code on a big-endian host.

The same goes for the INDEX_OP_vmrgh_vec opcode you introduced.


r~

