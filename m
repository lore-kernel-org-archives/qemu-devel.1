Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BB8C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 21:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5582072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 21:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PXYn/+6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5582072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioaFu-00016G-AT
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 16:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jimw@sifive.com>) id 1ioaF2-0000T5-QA
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 16:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1ioaF1-0003qt-KI
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 16:48:52 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1ioaF1-0003ou-D2
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 16:48:51 -0500
Received: by mail-pl1-x642.google.com with SMTP id az3so22320662plb.11
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 13:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FpeHLgsmVIrcPydx9RpKfqremvL17Cg1fOeP/EzJ9Mg=;
 b=PXYn/+6OWKHej1+QBS6j5oJIqOj2Nd4m0/DLYY+SvG5epIbLK3cDbriHxEO/+s5RZ7
 PrHNr8PIujIFa60R7+9LrBJkLc3FOK/fWLGYJgCh051d2p2CPuay9jzWAFGiVSFFuU8K
 wj8Sie6HCqTLm4HsxDpmQUT6aBzMS/QFJOHUDFi+z+iFWS6u5sI2ZSU6y+dRV/5ekpCa
 SyHUEuAzT/A+cdtu/EjqrmLOY54d3oHMv/pOUwbrS/KIp/9kvhNNicYmCzk+Ek32hjYl
 g5bW/uNBKp0juysIS8wT43aeECMfUpIcfDdE109XVWgUY+ksSVx0YJWmUjjE7sajOK/0
 yIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FpeHLgsmVIrcPydx9RpKfqremvL17Cg1fOeP/EzJ9Mg=;
 b=SSINHgDjXOuDtcCU5LCW262Kg12Um2+goHT5OEv8uVaXg1qwuN2xjhdZUMx7jFwuOh
 IzOEuMi27545ix1iCNhTie1NPkR93JBeFG8WTew84hWqf7p5EBFjY3hbKMZ58eZ8Jc0x
 KLqFMNStfUE1P9YvrLwgoc43888slVs7YGomGRC5kTR5H4CE4LN8t55Tu6slnXDbHFSH
 YO08/DZb8S5Io9TKeFHmn2DD9TiBkMiEsYBGBSC/TdU0YHmK2m8g/7vuOORh3zrAYPE0
 NIcMy/g6rilbLLc8ju2V4BLiLqyqUuzE5lNNLRHhpPfy79/k3zqyxRpsoKDDEowpqU2t
 NTjg==
X-Gm-Message-State: APjAAAUBOrHznhm11xPrhCviaVkk9CbM8FxaARfbSineQhb6saKhTLmP
 ed5gD0hjjuSomtNIE3Dq/YlOVg==
X-Google-Smtp-Source: APXvYqw0v0gKNrEAgVf+HUmeacL841tMzwfCnqVaUMdnhNxpAAN5OfAqwB39fWFi+JpIRPafNHgGHQ==
X-Received: by 2002:a17:90a:230b:: with SMTP id
 f11mr45161277pje.124.1578347330114; 
 Mon, 06 Jan 2020 13:48:50 -0800 (PST)
Received: from [10.17.0.74] ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id u18sm75753175pgn.9.2020.01.06.13.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 13:48:49 -0800 (PST)
Subject: Re: [PATCH v3 2/4] RISC-V: configure and turn on vector extension
 from command line
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 richard.henderson@linaro.org, chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200103033347.20909-1-zhiwei_liu@c-sky.com>
 <20200103033347.20909-3-zhiwei_liu@c-sky.com>
From: Jim Wilson <jimw@sifive.com>
Message-ID: <2e85f9fd-c254-5403-43ac-6988c013e319@sifive.com>
Date: Mon, 6 Jan 2020 13:48:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103033347.20909-3-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 7:33 PM, LIU Zhiwei wrote:
> +            if (cpu->cfg.vlen > RV_VLEN_MAX) {
> +                error_setg(errp,
> +                       "Vector extension VLEN must <= %d", RV_VLEN_MAX);
> +                return;

There is no architectural maximum for VLEN.  This is simply an 
implementation choice so you can use static arrays instead of malloc.  I 
think this error should be reworded to something like "Vector extension 
implementation only supports VLEN <= %d."

The other errors here are for architecture requirements and are OK.

Jim

