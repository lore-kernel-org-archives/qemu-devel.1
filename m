Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E3AC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 20:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6407B20833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 20:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YT2YJwYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6407B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibVbW-0005HY-Es
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 15:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibVah-0004rq-9y
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibVag-00004r-2u
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:13:11 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibVaf-0008W1-RW
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:13:10 -0500
Received: by mail-pl1-x644.google.com with SMTP id k20so2846981pls.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 12:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bHfSivU4hJr09nOJLd5vKBR8gTED97l4+uFHbFtW+SU=;
 b=YT2YJwYxZ0YMoca4Kgn0oL/Q226dFZUjRDqe7K9coMy8u0fseScJ5yBcxFOuAJ1xHc
 PQ0H02LTh5DjctptONNY5JqCVbIFLxiZViEM5RjAMNi8Kjl+xuirTFNbczy6E1Nk2Pwh
 TNd+0dHTAGaD68ND6P2PNADPMRFoBI7F1neSLMbSwvfg+vqFjBEf+S2DuEouWX4FXOto
 mly+wcx//YsDHQgzYnCp7tmm2AI2a0fDPo3pKANUHaxrf8KTJ/+y0RRXVhsQmKCUCJtm
 DtqF0gGlW7NBVV8bVE1XBiX1F/KWCboKORlTr64I6Ua017y8uZ7EzwcfbN+rbS8ILcFL
 Fj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bHfSivU4hJr09nOJLd5vKBR8gTED97l4+uFHbFtW+SU=;
 b=Hud5nVxCFZm6t7KN92bmMXkVIYxdOMwRfao11ubk/H5MkA5OiazvQZexvZhw/HMrYK
 sRCj/V7actFX9qXDqOCxLUZx3FzpKaliD83k4EaXkEPdUKXI7Qny+W+tDcds9RXXzufl
 3ubb1MBGlXXG9WVlu7qAKBEPPP7ZrOv8rN2OKAnIXt5/E2vo84HAz7pxAhpsFKvgn87w
 eCmCP83zZAQVUVa8FM2EsFMiOtSKw8Uba/8V84NnIcwCp9vNbEbCewAlUxmv9c/A6QHA
 hy/hCpmexXIcR25qlJsNAmJupETxLIGJAVoYq2F5Hv621dm33konGazZMRMAjtXrOXeu
 MkKA==
X-Gm-Message-State: APjAAAWmBkkDgwq+bJ5koOdgZ7CkRBiuA3w0NlFLMwKOzlamDjeYGrYH
 fymZ1gOjQkOyE09G2OZK2jO2eg==
X-Google-Smtp-Source: APXvYqyAX2tscoywZMHMwAEXfHEIysEcIl/DDidFuOpOXHmI8ms2yfb6HglWYDW04cXe5Qmhp/3JZA==
X-Received: by 2002:a17:902:a5cb:: with SMTP id
 t11mr10706508plq.84.1575231187730; 
 Sun, 01 Dec 2019 12:13:07 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g30sm30333407pgm.23.2019.12.01.12.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 12:13:06 -0800 (PST)
Subject: Re: [PATCH] target/arm: Allow loading elf from aliased ROM regions
To: =?UTF-8?Q?Jean-Hugues_Desch=c3=aanes?= <Jean-Hugues.Deschenes@ossiaco.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191125124055.19286-1-jean-hugues.deschenes@ossiaco.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e2857fd-aa5e-acc5-edd6-359715a636a6@linaro.org>
Date: Sun, 1 Dec 2019 12:13:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191125124055.19286-1-jean-hugues.deschenes@ossiaco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "martin.galvan@tallertechnologies.com" <martin.galvan@tallertechnologies.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 12:41 PM, Jean-Hugues Deschênes wrote:
>              initial_msp = ldl_p(rom);
>              initial_pc = ldl_p(rom + 4);
>          } else {
> -            /* Address zero not covered by a ROM blob, or the ROM blob
> -             * is in non-modifiable memory and this is a second reset after
> -             * it got copied into memory. In the latter case, rom_ptr
> -             * will return a NULL pointer and we should use ldl_phys instead.
> -             */
> -            initial_msp = ldl_phys(s->as, vecbase);
> -            initial_pc = ldl_phys(s->as, vecbase + 4);
> +            /* See if the ROM blob is aliased somewhere */
> +            hwaddr len = 0, xlat = 0;
> +            MemoryRegion *mr = address_space_translate(s->as, vecbase, &xlat,
> +                    &len, false, MEMTXATTRS_UNSPECIFIED);
> +
> +            if (mr) {
> +                rom = rom_ptr(mr->addr + xlat, 8);
> +            } else {
> +                rom = NULL;
> +            }
> +
> +            if (rom) {
> +                initial_msp = ldl_p(rom);
> +                initial_pc = ldl_p(rom + 4);
> +            } else {
> +
> +                /*
> +                 * Address zero not covered by a ROM blob, or the ROM blob
> +                 * is in non-modifiable memory and this is a second reset after
> +                 * it got copied into memory. In the latter case, rom_ptr
> +                 * will return a NULL pointer and we should use ldl_phys
> +                 * instead.
> +                 */
> +                initial_msp = ldl_phys(s->as, vecbase);
> +                initial_pc = ldl_phys(s->as, vecbase + 4);
> +            }
>          }

Can this entire section, including the rom_ptr thing just above, be replaced
with two address_space_read()?


r~

