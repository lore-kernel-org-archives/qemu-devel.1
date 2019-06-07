Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34226C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7396214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjXY+GNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7396214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZH7B-0007hS-QW
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38821)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZG9N-0008SG-Be
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZG9M-000277-Am
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:47:25 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZG9I-0001Xf-Hw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:47:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id z23so2045240ote.13
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mEL5VNuCAJ4QjXnRvkR4/WbGybXGX+dMAv+s89e3Ku8=;
 b=mjXY+GNkd0XYLhroUAl/GvVOc5ccVo1Ptr27hqYv+Iu5LAP5J2ic6T1t3Rs2NGV/jy
 3F7y5RyopIVABYAScBvRyhnjPRyflPnPZmbFXoYn48snlg8MGUmQawl2VV/Yt2ZdEI9X
 5rz/7RgBTTx/hucMegifzI6jBtcYcVGosHTzgwkV6oVe3Ub9cCEvma24kiJkr7D1sZWc
 35Qzuq8PuUfwdv8wyzST0G0sBDAfVMIQSTueOxtZhB73p8N32EfVyKnAfCDdzzH969Qr
 RH/w80hzi4+iwETMNhptrZARy9bgvhMvNDOyEY86CTYC5xZocu2/0+HitqpC+ixWtoR2
 MvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mEL5VNuCAJ4QjXnRvkR4/WbGybXGX+dMAv+s89e3Ku8=;
 b=KOUjkJbdhwPEHmuRMPt8sQAm3/AmJaSmK7xzXyiRrrFA3OcHfsgzSVAg5gxhhevx4X
 PXfwb42oTzMSUF9CeoQw5xIhFztMMwnoqp6xmm+A05ogsx+PD0PEn9fObBztJwEcGhsA
 E4wrB2ApC1+NSrG6FjLvfXV2jPK1CD2YTg/avudwS+xjNz3HPH6iDeFv/WPgVjhkv0Vi
 7KGWI5BElGDmNRtjmbOH1IaLUPQodQr0VumR1xIf1Cla6DydlrXlcu8LOn4PVz2ydQzL
 xJRGUmLuBrTiO1MDPhhmXA7tB7fFSb10AMis3LeRueSv5l94sy70ZidWov0/21OfwDXg
 EoXg==
X-Gm-Message-State: APjAAAXe+uTaCISZrHuYycKC0rHVMBNfAjgT5NcvJdF5hUcQ02ZO9ZvR
 G7Do9UubmR1UwtIhPrJD4ZnXfjjtqk9xOQ==
X-Google-Smtp-Source: APXvYqx9DkFAHWEnhz4yUXI6CzhT8C2Fthez4TYXFRYeDKsJMkDvDmuDKzwGRM6CUjFfQYM9PfcMEg==
X-Received: by 2002:a9d:27e8:: with SMTP id c95mr19889701otb.101.1559918834202; 
 Fri, 07 Jun 2019 07:47:14 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id p64sm744037oif.8.2019.06.07.07.47.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:47:13 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <555096c4-3be8-c0f9-3054-37570f0e6150@linaro.org>
Date: Fri, 7 Jun 2019 09:47:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 02/42] target/arm: Add stubs for AArch32
 VFP decodetree
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
> Add the infrastructure for building and invoking a decodetree decoder
> for the AArch32 VFP encodings.  At the moment the new decoder covers
> nothing, so we always fall back to the existing hand-written decode.
> 
> We need to have one decoder for the unconditional insns and one for
> the conditional insns, as otherwise the patterns for conditional
> insns would incorrectly match against the unconditional ones too.
> 
> Since translate.c is over 14,000 lines long and we're going to be
> touching pretty much every line of the VFP code as part of the
> decodetree conversion, we create a new translate-vfp.inc.c to hold
> the code which deals with VFP in the new scheme.  It should be
> possible to convert this into a standalone translation unit
> eventually, but the conversion process will be much simpler if we
> simply #include it midway through translate.c to start with.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/Makefile.objs       | 13 +++++++++++++
>  target/arm/translate-vfp.inc.c | 31 +++++++++++++++++++++++++++++++
>  target/arm/translate.c         | 19 +++++++++++++++++++
>  target/arm/vfp-uncond.decode   | 28 ++++++++++++++++++++++++++++
>  target/arm/vfp.decode          | 28 ++++++++++++++++++++++++++++
>  5 files changed, 119 insertions(+)
>  create mode 100644 target/arm/translate-vfp.inc.c
>  create mode 100644 target/arm/vfp-uncond.decode
>  create mode 100644 target/arm/vfp.decode

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

