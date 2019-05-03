Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1394C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCA72081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+k8C5z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCA72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMd4t-0003ob-2Y
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 14:38:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd42-0003VT-5Q
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd3y-000660-FH
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:37:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMd3x-00061z-EL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:37:38 -0400
Received: by mail-pg1-x544.google.com with SMTP id i21so3098572pgi.12
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=V6v1H4veMezA7U8koUrcn/PB5xP12Lqjn2u3RScSDBA=;
	b=X+k8C5z4EABbxz+ATD9bg/jWRa36dDNyhXqYWeE3T2XP3FmdXOxEPspJqGiQhVScDa
	O15jYS1wT7y8HvphWhETuJgbsS8E8OROc69v6ikaoT+qtMujOKH+8J9BDSUUs8aTrrLb
	yOwNpUYvhg0jLIG6H/1QkAWhHogeusyZOHy0dBOAypDC90M5H3a1vkvNEwNdvR8Yg8ip
	SyQvVdtcFXkXpD7MMbs7y/Pf4CmptyihK91ZliQp04MBr/FdSHzN/WJFAs8KeaTTuA6m
	0aMKkGJx4lKHMmXAOYzWilawvjXlRa9Wsy1aF1hVGbtcVNN8GbmPSuxJlZeta6p4cKnF
	omfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=V6v1H4veMezA7U8koUrcn/PB5xP12Lqjn2u3RScSDBA=;
	b=kILXAgfQ1A+NyNRDdKC6f+2cba8mezah1fd/tDGgplDs3XTwQrVqrsJIWxj8vS6C8r
	twkmPorun3eXhGjKud/V63YUOYgv+oX35tU4u408jfSSunVtHoy2Rma7VnjOOV6U8KgA
	ltlOGP12Wq9jYZ7ynGHffhphmzzwzQL+1JfnohHAiZcKgy1vDUhvBSs4onIK+dJWTO/R
	Cpdvs2NILvFQA3P4GE8PuYavchqxTr487+qwVxj1azx+3ZS5J4eaGdB9UUZ9euatDdsQ
	NHzGsBN+f2CzlomUeKGlW+b+UUXBEYqLFOJYagV0b//Ndz/bd28dHjtdfrzvncAGvTkk
	KBgQ==
X-Gm-Message-State: APjAAAVrzRTEBcNSryKhRSXyiStNFdDHuz3XVKKMP6uYY+RLv4sSRf6p
	ZM1Cq/E37UOYV3zIGBp0ffQVow==
X-Google-Smtp-Source: APXvYqx6+MhAPJEhm4p6F0nKiV3DLX6RrQhTUUVjBto0G2cZC/oIiOIW6OMuL+JBbs5FTOvRH6L1Fw==
X-Received: by 2002:a63:4c1a:: with SMTP id z26mr12483222pga.324.1556908653866;
	Fri, 03 May 2019 11:37:33 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	e62sm4397501pfa.50.2019.05.03.11.37.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 11:37:33 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-5-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fc9eb698-c408-86eb-2c8e-7a2b7e9f7e97@linaro.org>
Date: Fri, 3 May 2019 11:37:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502143409.59600-5-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH RFC v8 04/12] target/rx: RX disassembler
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503183730.-hwg6xBeXMhXvqMtBopvyiwt4YAGxuv47N4UQr01MlY@z>

On 5/2/19 7:34 AM, Yoshinori Sato wrote:
> +static int32_t li(DisasContext *ctx, int sz)
> +{
> +    int32_t addr;
> +    bfd_byte buf[4];
> +    addr = ctx->addr;
> +
> +    switch (sz) {
> +    case 1:
> +        ctx->addr += 1;
> +        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
> +        return buf[0];
> +    case 2:
> +        ctx->addr += 2;
> +        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
> +        return buf[1] << 8 | buf[0];
> +    case 3:
> +        ctx->addr += 3;
> +        ctx->dis->read_memory_func(addr, buf, 3, ctx->dis);
> +        return buf[2] << 16 | buf[1] << 8 | buf[0];
> +    case 0:
> +        ctx->addr += 4;
> +        ctx->dis->read_memory_func(addr, buf, 4, ctx->dis);
> +        return buf[3] << 24 | buf[2] << 16 | buf[1] << 8 | buf[0];
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

These should be computing signed values.  This is already correct over in
translate.c.  Also, we can make use of some endian-specific unaligned load
functions from <qemu/bswap.h>.  So for the 4 cases:

  return (int8_t)buf[0];

  return ldsw_le_p(buf);

  return (int8_t)buf[2] << 16 | buf[1] << 8 | buf[0];

  return ldl_le_p(buf);


r~

