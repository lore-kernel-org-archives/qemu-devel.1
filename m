Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF230C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 19:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D691E2151B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 19:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Io1V3L8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D691E2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb7gk-0006cJ-Fr
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 14:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kb7em-00057P-Kr
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 14:44:20 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:39594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kb7ek-0006l6-DW
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 14:44:20 -0500
Received: by mail-pg1-x52e.google.com with SMTP id i7so1745199pgh.6
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 11:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Hv1oJu8D0XQVx0JrzqV8n2dAeQ+JTrJUMy+iajYdJ+4=;
 b=Io1V3L8AhNoqoLg43c+tTmbSqvfAegEfu2ivoxkuT8twoMdD/r4piXLSq6Q9lEPhqv
 TsPCi2zd+mW1W6fvY/XaRd9i7oPN53AD2yVVg/Pp4GML9r87SfwfLjsSX+cE03k0IkoS
 p5IGn7X8JQT3FKqbyo+llXw2a/X0CEI0VX4yRDAuvz/2OSlD1mnABjZf2BDaLQ8kb05C
 xjkEcQxzRxc0021oqc8eS/DdhavXfOw5riAUKhmu63HT8rs2f+tLrR7W/u5k0XDfUhCB
 Qrm6JbSFAlA06Olr4UQcpaUerKpzwweeUTBegbA9LJJKzqkFH8GfPtllV7c4XaZM8zlm
 56mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hv1oJu8D0XQVx0JrzqV8n2dAeQ+JTrJUMy+iajYdJ+4=;
 b=fN+B0NJxsHaqYI0UZNjUWDY9cJiRtpRp8oF5qjOPi2fM39vxcyS9fBC9i3rDwIeCtU
 O5sLlxrR+mDLp56MYHrQuXlbhYZ1JckyWJi1PIlgKBVerCiZ9xSHCNCRfI1ljN6UOPpo
 YlmYSeJXBPpTMBwjNHsNR1eUJf0BWFzawccbvdICz5NaEznCjtr1xp5h82QCzYndp5Pt
 P2VHJOl6QDfgHMbsMPg7tjsWnN8/nngyp5Lwlmvm/KX3VLwJzOs6738Tw9pciRFICydd
 FvvK2TgQx5xKAzUffWoWZHOz9ogutv7mgZN4v5D5oze8Dya68UoRgdg7rq8UyhIJDDMS
 LIig==
X-Gm-Message-State: AOAM5304GbUyig7ENYoO1cWWt8rZUjYCupqe2xopqUZIxgog4Ip7gcGU
 wLAjCTa79ZizeZfD8bBeKt7htQ==
X-Google-Smtp-Source: ABdhPJwQxgwG863aZZ11Zr07dvTbafeVxh0VLQDyZ08iNuftyABuWRODFCB4+HXuwk0lqWSWlCgiiA==
X-Received: by 2002:a17:90b:4c41:: with SMTP id
 np1mr1131215pjb.231.1604691856806; 
 Fri, 06 Nov 2020 11:44:16 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id e17sm2047256pfl.216.2020.11.06.11.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 11:44:15 -0800 (PST)
Subject: Re: [PULL 33/43] target/ppc: convert xxspltw to vector operations
To: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
 <20190218143049.17142-34-david@gibson.dropbear.id.au>
 <CAFEAcA9WV=x3=FDoe4kHAkzJ4jXmg=4fTs1sVYCf2s0EEvmS8A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef30c4c1-476a-9e58-fa02-25b99f36f76a@linaro.org>
Date: Fri, 6 Nov 2020 11:44:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9WV=x3=FDoe4kHAkzJ4jXmg=4fTs1sVYCf2s0EEvmS8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 10:47 AM, Peter Maydell wrote:
>> +#ifndef HOST_WORDS_BIG_ENDIAN
>> +    bofs ^= 8 | 4;
>> +#endif
> 
> The ifdef is HOST_WORDS_BIGENDIAN without the
> third underscore, so this XOR operation will be
> done on both little and big-endian hosts.

Ho hum.

> Should the ifndef line be fixed...

This.

I once had a patch set that changed all of our endian tests from defined/undef
to true/false, so that we could detect errors like this.  Perhaps I'll try to
recreate it next dev cycle...


r~

