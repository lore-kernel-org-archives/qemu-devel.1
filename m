Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE79CC3F2C6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 19:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9189A2467D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 19:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgbJV2S5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9189A2467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j87xd-00044G-Oy
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 14:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j87ws-0003Vc-Ki
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 14:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j87wr-0003zu-Fx
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 14:38:54 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j87wr-0003zR-A6
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 14:38:53 -0500
Received: by mail-pj1-x1041.google.com with SMTP id dw13so2690219pjb.4
 for <qemu-devel@nongnu.org>; Sat, 29 Feb 2020 11:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=StRG4BSuxFQ2H38OzVfgarWR3LEb8zLZ+DGlIBRMe7c=;
 b=ZgbJV2S5fvjPN7e3KnkuHzeJz6ffDFLb5zJJc3LbX6T9ALwhJ/Dp/YjtCmnBykg5dl
 hjcVh6MaYBwY5aJLue9AlGkx9Lte4fCCLBIFFt4y/9rAT81L2DhUd694J914kueVKAlT
 fowdmdHpjBx0vW4HA6NzDV/iiHjkWVd8Mr4zYXHXRyGvcyt6S7VsHPT8iqccZ+2Zoh0/
 hkObkqyWD6EDBXeLMshaZQxCazue0Xr/pC1uniu0RIaEMSR1KszGCHiy2BvX6314BM+U
 mzdrBFNvo/4QB7ZpVSzkP1n2DrxsMAWrN+rKGcy83y6+ydHxrjicJnmuuqA/ZrN/WWdB
 hCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=StRG4BSuxFQ2H38OzVfgarWR3LEb8zLZ+DGlIBRMe7c=;
 b=t8jrGWv7PepbMWxfutvhKUT36g4wcyjz2Wp+WW78qy7lhYufHNYBgEFTCX4EwYBcKX
 HiwJt5XKDfUIGkpuk2SdpzuJqTb2JsF4eP2I7HS1Ezb5s+Nf/iv13Jy0DfgEahvHjQAc
 Ut6qiTj1mG6coc17uiHhjNgmx+BK/j8cW1W8CxrmWY1dUhASg6kqlKX9T3H1zFwMsMwd
 AWayu2M+yfuSG/uCFsbY4nymgXlTm2pDCLltRv9bG+STBfYiK32hHc0Ye7Rp2/N03Uxk
 2qVreEYHvpeOzZa6PAL+GGl2ZM/u2mPu+rZ5lu8Xc4lLNx9qXBZkGbSxC9tXdgsTJ7lc
 bjew==
X-Gm-Message-State: APjAAAVk0JJPNV0xt34rLHrLaSwL0I+i8cUP5kLAkHh7QP8gpU4wYNSW
 vPs5ROHTgVOUQXwq+lBLihTC/Q==
X-Google-Smtp-Source: APXvYqyvkUqCQzSURvKooCVVlvs7c6x/7ri6CL9yQgo1TbW595U2fxzGnvj2ZLSpAUZTkteC73TZNg==
X-Received: by 2002:a17:902:6504:: with SMTP id
 b4mr10129785plk.291.1583005131985; 
 Sat, 29 Feb 2020 11:38:51 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 s206sm15912403pfs.100.2020.02.29.11.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Feb 2020 11:38:51 -0800 (PST)
Subject: Re: [PATCH 0/5] hw/arm: Remove big-endian checks on machine code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200228125351.29482-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0899e78b-0082-a826-2e15-b44c76e6c716@linaro.org>
Date: Sat, 29 Feb 2020 11:38:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228125351.29482-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/28/20 4:53 AM, Philippe Mathieu-Daudé wrote:
> We only build the little-endian softmmu configurations.
> Checking for big endian is pointless, remove the unused code.
> 
> Philippe Mathieu-Daudé (5):
>   hw/arm/gumstix: Simplify since the machines are little-endian only
>   hw/arm/mainstone: Simplify since the machines are little-endian only
>   hw/arm/omap_sx1: Simplify since the machines are little-endian only
>   hw/arm/z2: Simplify since the machines are little-endian only
>   hw/arm/musicpal: Simplify since the machines are little-endian only

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

