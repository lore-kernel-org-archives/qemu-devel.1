Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB6DC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5B320868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksyvPKsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5B320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKsp-0005iM-Vb
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZJI4-0002T1-Jq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZJI2-0001EA-Lm
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:08:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZJI1-00014D-CR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:08:34 -0400
Received: by mail-ot1-x341.google.com with SMTP id c3so2697151otr.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xSxr2khXk/E2wuomvgD1zBa6o7VMFaqnrO/SqCVlTc8=;
 b=ksyvPKsSN8sSK8T0sDDfSAznRFlErxOKyt+r5n13AL5dFHLTrfRl69LmRTc0mlXbNk
 4SD8iOnPFAeq64f0F6LW9jqJgI1S82Df8zP7/S/b43N1HrzqdsLLpgzxkBJwhsGUysrI
 ybMLsX9ixfzK8i3xEyu2dxQSp/iuex+mJgGtM5/j8+eaG7pTmXOXCSYne1EzsgxSObZj
 B9I7dcGb5t5XEAKI79HYZc19tZFJaGbYm86idsESG6fUeelDIXgxRyRinvq+Ku6euG7Q
 E41XscN0FNqEWuldDFkHak8ZT/4JGH6n5fehCIylI0LgUFhH9VnOrbETOAtYlNzvd7bj
 EUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xSxr2khXk/E2wuomvgD1zBa6o7VMFaqnrO/SqCVlTc8=;
 b=RCapJxp590SR4/2qviP3cwLST1fg/BwDrcf8KvDvOFhtqT4lzeVxXN+0vsOWD8wIy2
 eQ9qTiFPRszt/yIBLm1o5Vk7hrqSvDWEVewt2iwLtU+mOCxSZTKJQowN/tkF0qkfEurt
 e0TPxuJ8ztOGZAK69IunINVcqp36Ih04cjZYbVWt7aLelRhNijRBZoTRljcVw1Cqea8y
 FaAJitN6INnJHOy8DUD29urj0D0upZg/8gFDs8DI8j1XDo4wEqPxBhSftbpJS+xurwo6
 auuFn6MBUYFZTIiNaZlp7NoYFykl8BSIbvrZJMAupxxJSgkKaeb4KHxJli9OPDwN247Y
 YOHQ==
X-Gm-Message-State: APjAAAXRyGsnjmYQ/Wr/bwjZqg2wwD0EN4ZxAgYlBQxJIhxsYrpJuMqr
 xPzsvQFDbiNzz8q14FVZdOZkJILz6uSjlw==
X-Google-Smtp-Source: APXvYqwob0bj2I88FRURw+21k0zJBZZh3hKZCXShb0Ioo17k87ktVOuj0CBsiq2UFIJYlKgDLJn8MQ==
X-Received: by 2002:a9d:6453:: with SMTP id m19mr3172037otl.70.1559930905732; 
 Fri, 07 Jun 2019 11:08:25 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id s110sm1021947otb.34.2019.06.07.11.08.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 11:08:24 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <119282bd-4a60-e9a6-99c2-4fa2ddb1ecc0@linaro.org>
Date: Fri, 7 Jun 2019 13:08:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 13/42] target/arm: Convert
 "single-precision" register moves to decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the "single-precision" register moves to decodetree:
>  * VMSR
>  * VMRS
>  * VMOV between general purpose register and single precision
> 
> Note that the VMSR/VMRS conversions make our handling of
> the "should this UNDEF?" checks consistent between the two
> instructions:
>  * VMSR to MVFR0, MVFR1, MVFR2 now UNDEF from EL0
>    (previously was a nop)
>  * VMSR to FPSID now UNDEFs from EL0 or if VFPv3 or better
>    (previously was a nop)
>  * VMSR to FPINST and FPINST2 now UNDEF if VFPv3 or better
>    (previously would write to the register, which had no
>    guest-visible effect because we always UNDEF reads)
> 
> We also tighten up the decode: we were previously underdecoding
> some SBZ or SBO bits.
> 
> The conversion of VMOV_single includes the expansion out of the
> gen_mov_F0_vreg()/gen_vfp_mrs() and gen_mov_vreg_F0()/gen_vfp_msr()
> sequences into the simpler direct load/store of the TCG temp via
> neon_{load,store}_reg32(): we know in the new function that we're
> always single-precision, we don't need to use the old-and-deprecated
> cpu_F0* TCG globals, and we don't happen to have the declaration of
> gen_vfp_msr() and gen_vfp_mrs() at the point in the file where the
> new function is.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 161 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c         | 148 +-----------------------------
>  target/arm/vfp.decode          |   4 +
>  3 files changed, 168 insertions(+), 145 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

