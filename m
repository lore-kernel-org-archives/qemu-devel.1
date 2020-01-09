Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7310EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 21:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD70206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 21:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vs5Q41GU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD70206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipf1y-0002k4-EU
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 16:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipf1H-0002Cd-Uk
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 16:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipf1G-0001pn-Mm
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 16:07:07 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipf1G-0001lS-DY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 16:07:06 -0500
Received: by mail-pg1-x544.google.com with SMTP id x7so3781158pgl.11
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 13:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TtHYgZVm5surxo1DzQJ0vQ5yPpHhCV88mWsDEOv4xmQ=;
 b=Vs5Q41GUw3neUV66YXUaJK5x2qI66837BzCJ7zn71LLeGYFjTViJMf8Ah0QiHdjVYr
 cla8JNcIriSsNGcWth1Ka2uQPWKn8JpBZ1WAIj6IlJWzYqt4zlcMek3dKfhIZUWRBhQF
 /gUfC4bSku2KC1ykET56bE78GU5V5SCGYfMmCK5f+1tVLgHbQsDcumUHyiueBmZR9FDc
 ruG3ifOCq0ROMfS58Q14RTxWt6Tyzz5HGdrFQOyQwifr9DI/680RML/lJCFq4STEic2c
 XKnKinDa40+3IUzyI8GkIzxgaDLF/UnQIFutfBT7RpAen9o0g968WEMsueOSRBemV3V+
 4hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TtHYgZVm5surxo1DzQJ0vQ5yPpHhCV88mWsDEOv4xmQ=;
 b=j+RIziniLsY9EPMu2clihU4kb+caJyXPlR5v6uHiaDoxzwtXLM/w4gP12eSz01ngMq
 cuAd2lGUU67dPoR/OpujAoIkCq3ISBCUluo7cCUrw9TN4li1a8JZ/dBMVrZCe4zz51Lo
 dv7FH59d9KJIFrbQJKUSYOYAxyvq6fDaYzSlaYDT+mP3EwzX1p4pThWDclBTJZphC5V/
 S1eRn6Tg+eiYFW7o6hKwIH7ZbC8m+jqnSLMSWzYfITX8zHKB/qJ/05zJpmMuopyf9FDD
 9y2I5PfwT2yfGihVevfxXH9FNNSKS+qF33JVIOP5E0ptaUAfTmx4s2yPmpPqHoQslX5/
 GY3Q==
X-Gm-Message-State: APjAAAWzOz2fvn/C5uzixwhonN8i34zWoI2tambNOSXJ9ud3L1To781I
 0qFQFN6GEoGkiUPuqiQm78XvEC54ZjZedA==
X-Google-Smtp-Source: APXvYqyhBkntq07tBarKzbNCAmuMCILmI9N/74v92PpKcmKGjY+Ea3AzkFLvIPakXIei4+qsBp8XkA==
X-Received: by 2002:a63:62c2:: with SMTP id w185mr639182pgb.271.1578604025029; 
 Thu, 09 Jan 2020 13:07:05 -0800 (PST)
Received: from [192.168.15.12] (alanje.lnk.telstra.net. [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id q22sm9241844pfg.170.2020.01.09.13.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 13:07:04 -0800 (PST)
Subject: Re: [PATCH] target/arm/arm-semi: fix SYS_OPEN to return nonzero
 filehandle
To: Masahiro Yamada <masahiroy@kernel.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200109041228.10131-1-masahiroy@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5c6f6bae-2201-6e7a-f965-d75d70cc86e7@linaro.org>
Date: Fri, 10 Jan 2020 08:06:59 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109041228.10131-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 3:12 PM, Masahiro Yamada wrote:
> According to the specification "Semihosting for AArch32 and Aarch64",
> the SYS_OPEN operation should return:
> 
>  - A nonzero handle if the call is successful
>  - -1 if the call is not successful
> 
> So, it should never return 0.
> 
> Prior to commit 35e9a0a8ce4b ("target/arm/arm-semi: Make semihosting
> code hand out its own file descriptors"), the guest fd matched to the
> host fd. It returned a nonzero handle on success since the fd 0 is
> already used for stdin.
> 
> Now that the guest fd is the index of guestfd_array, it starts from 0.
> 
> I noticed this issue particularly because Trusted Firmware-A built with
> PLAT=qemu is no longer working. Its io_semihosting driver only handles
> a positive return value as a valid filehandle.
> 
> Basically, there are two ways to fix this:
> 
>   - Use (guestfd - 1) as the index of guestfs_arrary. We need to insert
>     increment/decrement to convert the guestfd and the array index back
>     and forth.
> 
>   - Keep using guestfd as the index of guestfs_array. The first entry
>     of guestfs_array is left unused.
> 
> I thought the latter is simpler. We end up with wasting a small piece
> of memory for the unused first entry of guestfd_array, but this is
> probably not a big deal.
> 
> Fixes: 35e9a0a8ce4b ("target/arm/arm-semi: Make semihosting code hand out its own file descriptors")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

