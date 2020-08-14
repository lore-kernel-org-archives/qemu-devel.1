Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C514DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8561E20829
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGlWvjM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8561E20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6dGx-0002dS-Qu
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6dGM-000234-6c
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:13:06 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6dGK-0006O3-Il
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:13:05 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ep8so4683319pjb.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZFuA5der7b54aAokYnIBx1jHUrMnEJxZB+HuaWuvMko=;
 b=lGlWvjM+T9RBppmxl5xAfMbJAletGk9yLD/N8Ur05Ya3J8cn34nqJVZ6h+rin5rLBl
 LZwr+uQrcOuMiIFuBlv2RyRo433Kqn0oNrnE2keXtHAgpTpSxc0wwx0FuaPFjKeM8MHa
 H+F70zSVKTA6d3fBBSlJrTEB8Zf4HwTkPwJDtU+gM/mmOcVJpTiPASg09wD39brud5bk
 WKFoJn2TOmL5qvH2F7dhc4hE0Ls56+SoGC/h316itgKTt1YLZAyLxyW64L+eLeN/P7Cc
 g9R8MIcL6cFKIbYt5mpQWNK3uN16TA93Fxh1feHAsglZ7KDFKzq2nSkqxWoND7z/1sJo
 ytwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZFuA5der7b54aAokYnIBx1jHUrMnEJxZB+HuaWuvMko=;
 b=O/HnfkiyhckleqMeIaeXQ5j/6WDrydFlb4UeQY4EZqAJiQcb/G12S8NJwaryE/ksbu
 ATxFIAKal3U1ayh9qfJRn5lRtlCpux4xC18l6fheVLrGQRF40nXO2sWUbPGpmZzzXJCd
 j4tUI8ngmTm27os3i8T5uZTtJQuMFAKMHCwUUUoc1DIEm6HXsp+QejgRcmUfkTb2y2Xf
 fqyWFfKvrZ5/rUYgoQxbFdu7h8CF2GK8139DXab0ZeELq794GMCSZZNbcaYu3+UOCy4S
 ysVA4wfBmJntWpxOtQ4CISRSr1NdAKXujaQZaE5Hsu6Q/AqvvrI9o7lwiye2kG36n2cE
 /zdw==
X-Gm-Message-State: AOAM533fufXT9/rpwCcy69UVtTQkmM4Axy1+H9lJV+mGMXxCQsLTkbZf
 5cNuNyGf6wo0EK9rthMmMDs6Sw==
X-Google-Smtp-Source: ABdhPJxY/umssUV4UvAtYViXyJbQETPS/HSc2hk484f51KOk42mmDzJBZQ4R39lZZ4lyi6uivrtNsg==
X-Received: by 2002:a17:902:7b82:: with SMTP id
 w2mr2728335pll.39.1597425182949; 
 Fri, 14 Aug 2020 10:13:02 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e4sm10062198pfd.204.2020.08.14.10.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:13:01 -0700 (PDT)
Subject: Re: [PATCH] hw/net/allwinner-sun8i-emac: Use AddressSpace for DMA
 transfers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200814122907.27732-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3ed25d03-c534-a2ae-07da-87c1ac5212d2@linaro.org>
Date: Fri, 14 Aug 2020 10:12:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814122907.27732-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Niek Linnenbank <nieklinnenbank@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 5:29 AM, Philippe Mathieu-Daudé wrote:
> Allow the device to execute the DMA transfers in a different
> AddressSpace.
> 
> The H3 SoC keeps using the system_memory address space,
> but via the proper dma_memory_access() API.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Tested with:
>   AVOCADO_ALLOW_LARGE_STORAGE=1 avocado run -t machine:orangepi-pc tests/acceptance/
> ---
>  include/hw/net/allwinner-sun8i-emac.h |  6 ++++
>  hw/arm/allwinner-h3.c                 |  2 ++
>  hw/net/allwinner-sun8i-emac.c         | 46 +++++++++++++++++----------
>  3 files changed, 38 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


