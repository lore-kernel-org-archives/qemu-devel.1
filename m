Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6DBC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 15:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39362173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 15:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stX8bg6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39362173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvkaT-0003Bv-4q
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 11:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvka0-0002ay-Mi
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 11:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvkZz-000151-Nr
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 11:43:52 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvkZz-00013Z-Ft
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 11:43:51 -0400
Received: by mail-pf1-x442.google.com with SMTP id m30so44331399pff.8
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9d84VbIVt4jjibDMNJI2YnvtvcFe4PhCYXQq/m+rW9s=;
 b=stX8bg6KKmAt8OjkgL3Wxsz9JeeJKPpg6wYsqROe0aSyI29F+3G5HnFLYJLXyJrVVV
 dHhZnMWVJCA8KsBEqiGkZnQ8sVE7TfkTCnvRtGEbYbJKc3r3YaTuUOJggg23IGBRKHNM
 YNE0ZxKXCyA4Txxx+W7md2+D2SCkkZPXO3UTD3GMFAtQClz5R5ZO5zYkFLAyBvCb4D9t
 Mpgxd/FDvMd+qzW+xrlg+AG+0/+Dk/A+p8DOL4mOgbcJvA5TPslnXnuupH/45fzTPnop
 hACseYyUPEHVM9YhbBIwOemouF0iDlaggk5qbrY2cPDIvf9JO7eEAkZ5ZejiJrfT4Q1+
 /+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9d84VbIVt4jjibDMNJI2YnvtvcFe4PhCYXQq/m+rW9s=;
 b=LCwQ5DKuzfK1ASEYzqF72et2eNqOrBUreN2Zc25CqgyWFLmq6Dw9ZXgBopRKTliOoI
 1QLigHhlWpC+jEyrQa19T2Rpl2vmKycwrdQ6PZ2cxiYEtV3wWG9uGnDXsmh77i2CPvMg
 BDKQd9FZ9CZR2qcuT8x5nGyvN2VD3DQn2zMUXWVeVUNUZctzV+NJh3kNyCoCBqX8tVxo
 u72JcJs5bMFWySSmInZbDVXANQKXyXSYb6P3ZP52Ki3gpf509fuXOc44WjNKWYiRRatz
 TQnowjrJiHxDfGqdehJ1Ur6QYB2B/CEp1dSUBkn0xsQwSmq2kZY+3ZN93YeMIQWCYXLx
 Af7g==
X-Gm-Message-State: APjAAAXnQeSouPMoXzOeMxGJvwmeNnu+M10y9VJZsU1hsXujkrMLnbig
 8eRbfHZedgtSDVr9zA6Xnf61UQ==
X-Google-Smtp-Source: APXvYqxfg1F7BJ0gks9TCbVT+vJgoaHQqdsON63JGGJ8nxrEKehhMotNDSDcWkac9W0lpIfK8SqiKg==
X-Received: by 2002:a17:90a:db52:: with SMTP id
 u18mr4727536pjx.107.1565279029109; 
 Thu, 08 Aug 2019 08:43:49 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b136sm125480578pfb.73.2019.08.08.08.43.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 08:43:48 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-12-richard.henderson@linaro.org>
 <CAL1e-=gwyGB4ibo_B5W1MpFy-9bB7=5juqTJVBdD9N6XFOOsSQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0f37edc5-2fb6-c92d-fb47-a381af649072@linaro.org>
Date: Thu, 8 Aug 2019 08:43:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gwyGB4ibo_B5W1MpFy-9bB7=5juqTJVBdD9N6XFOOsSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 11/67] target/arm: Add stubs for aa32
 decodetree
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
 "open list:Stellaris" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 4:41 AM, Aleksandar Markovic wrote:
>     +/*
>     + * Include the generated decoders.
>     + * Note that the T32 decoder reuses some of the trans_* functions
>     + * initially declared by the A32 decoder, which results in duplicate
>     + * declaration warnings.  Suppress them.
>     + */
>     +
>     +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
>     +# pragma GCC diagnostic push
>     +# pragma GCC diagnostic ignored "-Wredundant-decls"
>     +# ifdef __clang__
>     +#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
>     +# endif
>     +#endif
>     +
> 
> 
> This looks more like a "band aid" solution rather than the right one.

What would the "right" solution be, would you say?

A couple of days ago Phil suggested moving these pragmas into the generated
code, so that this need not be done by hand in the several targets that use
multiple decoders.  That sounds reasonable to me.


r~

