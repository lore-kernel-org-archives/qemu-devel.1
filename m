Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3E4C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6B522243
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mmh/lUQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6B522243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP7AO-00006r-In
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 12:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jP79K-0007hR-N1
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jP79J-0002Dg-Br
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:13:58 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:32821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jP79J-0002Cy-5W
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:13:57 -0400
Received: by mail-pl1-x642.google.com with SMTP id ay1so1526081plb.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LHCr2VVYRgfUJp+jaFj5bq6dPDH1Ejyrha/BnN4ckXc=;
 b=Mmh/lUQgH0XYjZ1Z+Ao3kIimgsfVGXoGASomwZU7iShdmYrE/+ukW72CWOTEKqRZhC
 qERkdWQr2bCzHcAPJA8C/CYRcsHDGYiAUuT6Hc3NvXQIHUXC7yUErI7NoFhFvtRBmaZo
 1U0QSoUBm8QECXaVbv2rbclnZ9V1wnOZazoiywHOZruF+5sA3uWswEicJEbCZXQ2qnx+
 S62UIVzMalAmVzg0vwdX+lRgAJllGp9KdQshdb7bKJJH1lhGfNYcDIgyNE/bCW6sy81j
 Fm3zb0iA6Mjki4W49/ebUG2T9++6DRAX4oVQaloZSg6YTh55AElQ6pm0VR5cVLYoeQ28
 jbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LHCr2VVYRgfUJp+jaFj5bq6dPDH1Ejyrha/BnN4ckXc=;
 b=lemsp59KMEGXfUcvYoaaNrxT0xXpUaC5uPBpujqprLoM6pYaL2GfxpE1Fia6PMFlKL
 o1N0y5b98GnYD6GXZlUJLoSgSCKw3GqnrxBhn19aeF099GkYxi5Y9/Ps1fxPETL525YT
 9kFgIrlEojCrSAvqEhRovNXjsWoibFl8Zv5vamDHmM7AQNnrCDSHB29nykzOrkO81jsH
 WcVzulseJCCpFpq+HaGtVyNxtdUoLfGO1mOtjJsmcE/MfUhLsYvqB5S/ltDIwpalIXEs
 E7GmmZ7i2OmgDzOryJSQLbcvMiCleQd2yfLMxHc/91P+r6SBq1azQkfPx7Mtm2fCql94
 f82g==
X-Gm-Message-State: AGi0PuZbuneFoMJHB3OO/R4zq1AtcHsO7TNgQf++1qjmuBsgsBBPuVjV
 8Q1gy+Z0yXe6GQGWd5BBvTMsyQ==
X-Google-Smtp-Source: APiQypJXOpiKsMwWuodebKcvxWbRFQdF5mDogBM+LOON4DCBemyFBfVUFzIEk5lDrcfaOG2EmBgJiw==
X-Received: by 2002:a17:90a:d3ca:: with SMTP id
 d10mr6294345pjw.24.1587053635867; 
 Thu, 16 Apr 2020 09:13:55 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id x12sm9670464pfq.209.2020.04.16.09.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2020 09:13:55 -0700 (PDT)
Subject: Re: [PATCH RFC v4] target/arm: Implement SVE2 HISTCNT, HISTSEG
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200416144212.4898-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8dfe7862-5842-c356-0b59-7531dbc25fe9@linaro.org>
Date: Thu, 16 Apr 2020 09:13:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416144212.4898-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 7:42 AM, Stephen Long wrote:
> +static inline uint8_t do_histseg_cnt(uint8_t n, uint64_t m0, uint64_t m1)
> +{
> +    int esz = 0;

Clearer to use MO_8.

> +    int bits = 8 << esz;
> +    uint64_t ones = dup_const(esz, 1);
> +    uint64_t signs = ones << (bits - 1);
> +    uint64_t cmp0, cmp1;
> +
> +    cmp1 = dup_const(1, n);

Error in the esz argument here.

> +    cmp0 = cmp1 ^ m0;
> +    cmp1 = cmp1 ^ m1;
> +    cmp0 = (cmp0 - ones) & ~cmp0;
> +    cmp1 = (cmp1 - ones) & ~cmp1;
> +    return ctpop64((cmp0 | cmp1) & signs);
> +}

Ah, well, I may have been too brief in my suggestion before.  I encourage you
to have a look at the bithacks patch and understand the algorithm here -- it's
quite clever.

We cannot simply OR the two halves together, since 8 | 8 == 8 loses one from
the count of bits.  So:

  cmp0 = (cmp0 - ones) & ~cmp0 & signs;
  cmp1 = (cmp1 - ones) & ~cmp1 & signs;

  /*
   * Combine the two compares in a way that the bits do
   * not overlap, and so preserves the count of set bits.
   * If the host has a efficient instruction for ctpop,
   * then ctpop(x) + ctpop(y) has the same number of
   * operations as ctpop(x | (y >> 1)).  If the host does
   * not have an efficient ctpop, then we only want to
   * use it once.
   */
  return ctpop64(cmp0 | (cmp1 >> 1));

> +        for (j = 0; j < 64; j += 8) {
> +            uint8_t count0 = do_histseg_cnt(n0 >> j, m0, m1);
> +            out0 |= count0 << j;
> +
> +            uint8_t count1 = do_histseg_cnt(n1 >> j, m0, m1);
> +            out1 |= count1 << j;
> +        }

Wrong type for count0/count1 for shifting by e.g. 56.

You might as well just use uint64_t as the return value from do_histseg_cnt()
so that we don't get unnecessary zero-extensions from the compiler.


r~

