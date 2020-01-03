Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA82CC00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 23:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73358227BF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 23:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtWTl2EF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73358227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inW4E-00084G-KE
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 18:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1inW3T-0007ZW-Vs
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1inW3S-0001Yi-Gq
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:08:31 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:44262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1inW3S-0001VN-A6
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:08:30 -0500
Received: by mail-pg1-x536.google.com with SMTP id x7so24024023pgl.11
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 15:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yLrjbfP/OAMALmDOrYFfxopv7TcYyyJS0FXbPxlwM0M=;
 b=QtWTl2EFn9Y2B06E+Iwc2gIWy1p4gPM1UDRxB9j3kbzL6tjAmYG+Jm7OFqppNe84gy
 AgROhF1jVw7j3PAPkvdpjaZADjVZZQO0F1Mek8hiPCthyhUTgujUQFjzC3KiTNlHMc4T
 EnvQTqX0mhAazc+JMWL0LgFMR9JA4Y5rmrTiBGus16cCpfTviL48sqDFmzhsgrKYGECp
 uyU7rKdumiBWvQ9XKAUv05tNdtRpayeH/e0XJAQSBAlwtJA9Rnye3hipQP2j0BzaM4Dj
 6q9Gmx68u0qUbEu/VA70HWsJfGciyN6VAAjL2F42l4hnufoifkHm07AGBXnms3ojxOZW
 v6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yLrjbfP/OAMALmDOrYFfxopv7TcYyyJS0FXbPxlwM0M=;
 b=W5+SAwN309f+Fb/g9jOC3eQFzzMndOu5RiBbPucaLVt84yKaGr2a2p7imYmHuC1rRy
 mCaI9+2kjd6nXkuNQ7C7B/87lMadWa2JoAVmQdFFHeiwUbYVLFDsl3r5pcuCKOd84pCO
 ZOzxqne8WWoQ20kS9y5n5H7QAMf2S4opotQt+tnLN8XDz2bPKhRM/Za2dB38AKRg5QCG
 Qs7xGDGIU8Uwvw0IG0iyOJbQVaH1WFYLVCKCMZ0YMYDX996INsGiYyOCmeWAPNVmLGa3
 +Uj4yU/r56cnLR/8Zgi/Y/qC1Gf9RycxKPiYtLwlVrYkgTICSXVB3n1ZEbkKZLGlAo0l
 4kdw==
X-Gm-Message-State: APjAAAU7a4Nu6LuJRig1rv2fABjLd/7iB+VicHTEOSGQF7+Qe3VIGCUq
 1notP6VNQ5ITs2n28n4NiJgJ1Q==
X-Google-Smtp-Source: APXvYqxXbNBH2EDvJWKZmOfxVYWT7S0AvDL/W6ph28uUXaEOmZKWzXxKXeeIkoXBqz/UQ6Wo+Do8NQ==
X-Received: by 2002:a65:578e:: with SMTP id b14mr99090332pgr.444.1578092909187; 
 Fri, 03 Jan 2020 15:08:29 -0800 (PST)
Received: from [10.103.5.8] (59-100-211-22.bri.static-ipl.aapt.com.au.
 [59.100.211.22])
 by smtp.gmail.com with ESMTPSA id e6sm68647657pfh.32.2020.01.03.15.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 15:08:28 -0800 (PST)
Subject: Re: [PATCH v3 2/4] RISC-V: configure and turn on vector extension
 from command line
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200103033347.20909-1-zhiwei_liu@c-sky.com>
 <20200103033347.20909-3-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6ca305c-0e80-f690-a299-bbf4ebdbfbca@linaro.org>
Date: Sat, 4 Jan 2020 10:08:21 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103033347.20909-3-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::536
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

On 1/3/20 2:33 PM, LIU Zhiwei wrote:
> +        if (cpu->cfg.ext_v) {
> +            target_misa |= RVV;
> +            if (!is_power_of_2(cpu->cfg.vlen)) {
> +                error_setg(errp,
> +                       "Vector extension VLEN must be power of 2");
> +                return;
> +            }
> +            if (cpu->cfg.vlen > RV_VLEN_MAX) {
> +                error_setg(errp,
> +                       "Vector extension VLEN must <= %d", RV_VLEN_MAX);
> +                return;
> +            }
> +            if (!is_power_of_2(cpu->cfg.elen)) {
> +                error_setg(errp,
> +                       "Vector extension ELEN must be power of 2");
> +                return;
> +            }

Missing maximum on elen.
Missing minimum on vlen, which, as I discussed earlier, should be 128 to avoid
asserts in tcg-op-gvec.c.


>  #define PRIV_VERSION_1_10_0 0x00011000
>  #define PRIV_VERSION_1_11_0 0x00011100
>  
> +#define VEXT_VERSION_0_07_1 0x00000071

To match the other version number formats, surely this should be 0x00000701.


r~

