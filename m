Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9843EC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667DC2184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CnHEiK2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667DC2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hih7B-0006Xz-V5
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38472)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hih3N-0004iL-SY
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hih3I-0004iX-G2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:20:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hih37-0004Xb-4A
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:19:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id f17so2837665wme.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5+tYeKH61CC+8q23OH16Fn4Bg+yjGZyh+46gD2kLkzY=;
 b=CnHEiK2jEnV5gAWNFgYCFslgUoMj1uQ8lFv9AQzIRVneWmm3SvyjndGA9e/lkNQYLL
 mmtxKnWNvsGpJ0W2zVYNl28psqmMO8p4v7mJGKrHjr8B888QR3H2pFpVObcNWb9O4pDD
 UlaIO/fA3U0Fj46DQvgoFJHFwq77xoX6pTXpN+ojSWFWS/JvVptIqcCs9FFY2q12YUxe
 nnBWa6YOxNvMl/Ghq0+bJliIYhLv2DsEYYMMvIPZNJ0x5LN2/q45+4oPWJ6o2ceidzrW
 ABoxB1Nq7FjsB7mqmlkMDVVvUTcQ+FdrSh5HdfO7896j0NEKnN9UQG1u8X04fVbq39YU
 yrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5+tYeKH61CC+8q23OH16Fn4Bg+yjGZyh+46gD2kLkzY=;
 b=IzcUzaoR5atKRsZj5rfgaGgJ3VH9WOoUEASKyvOnNImQi6+m0zScjvqT55300n5qrQ
 RkJZdzwXj5Y/+NWBOK9xLiXwYcJQjAh5JIvWBEEEva0pJo9UwavXryQCcfaxbZz2nDMq
 8P9anLtO4MXMLPTcPaunnkgr+8PttK2XFOXAJXfr6y7/46gS5Tb5x0krWCxMjngg54dU
 Tl32n2mD7UtQSDMqMOvxNZX74qHRbW3rb8nRg17IQ2/HqNhWVplKRbRySKfrFCucd0wO
 bF+DeTQo6cF+p4QwAdMMh9pIYPW6e6cX56iMzYGgEXFQVJKMqa8ZcmsMorD9/5ZZXl52
 LJAQ==
X-Gm-Message-State: APjAAAUscUE9sF/H0ME1kIWIx8+mHwpcK8xkdFOLu4r3ld4CJTTxy3MV
 NqDIwfNQ0GXDBF0CIZtdX5y2/A==
X-Google-Smtp-Source: APXvYqx3xfl9tAv9gKQDG5ywStgZVcJnAwME0Xq7PpsQ7n6tec8/BwF5pHUyko2Y7oc+cFU3bLmyog==
X-Received: by 2002:a1c:1bc9:: with SMTP id b192mr8368712wmb.152.1562167189584; 
 Wed, 03 Jul 2019 08:19:49 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id h19sm6758009wrb.81.2019.07.03.08.19.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 08:19:49 -0700 (PDT)
To: Georg Kotheimer <georg.kotheimer@kernkonzept.com>, qemu-devel@nongnu.org
References: <20190703142617.21073-1-georg.kotheimer@kernkonzept.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <345cc679-deac-ce52-664b-0ac5883671ca@linaro.org>
Date: Wed, 3 Jul 2019 17:19:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190703142617.21073-1-georg.kotheimer@kernkonzept.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Select FPU gdb xml file based on
 the supported extensions
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 4:26 PM, Georg Kotheimer wrote:
> The size of the FPU registers depends solely on the floating point
> extensions supported by the target architecture.
> However, in the previous implementation the floating point register
> size was derived from whether the target architecture is 32-bit or
> 64-bit.
> 
...
> -#if defined(TARGET_RISCV32)
> -    if (env->misa & RVF) {
> +
> +    if (env->misa & RVD) {
>          gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> -                                 36, "riscv-32bit-fpu.xml", 0);
> +                                 36, "riscv-fpu-d.xml", 0);
> +    } else if (env->misa & RVF) {
> +        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> +                                 36, "riscv-fpu-f.xml", 0);
>      }

While this appears reasonable, I wonder if RVF w/o RVD actually works?

Examining the two get/set functions, they always transfer 64 bits for the fpu
registers.

In addition, there's a suspicious use of sizeof(target_ulong) when transferring
the fpu related csr registers, which definitely shouldn't work with the shared
files above.  If the xml file is correct, this should always be uint32_t.


r~

