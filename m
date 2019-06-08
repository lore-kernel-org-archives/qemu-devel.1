Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8D9C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65804208E3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBc0s2QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65804208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZhTi-0006PK-FO
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh2d-0000Nz-Df
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh2b-0008Nl-6j
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:30:15 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh2a-0008N0-U4
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:30:13 -0400
Received: by mail-oi1-x244.google.com with SMTP id y6so3722323oix.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eFc3z5Zi2+P0zeUhuGfQxDe3HZ7k941fCcKiMMtRH/k=;
 b=FBc0s2QJHCRxomeQd3ePhmcKASoj9tujP0O65W1/0EjTa43INgOy83QFNfE0uCchDT
 EDr2sLPn/pKH7MrJ9C85WNcGOv1SWOOu6Ezkm9/Zgbpilt17CljUdH7ETT/wfG785sFB
 mo7qppQJ/vxaA3eefnghv3njVSjRTgZGNVNuHPLGLYy+bCst8IKyPHUVeIJFdgfAE5lH
 0uqQLTT535oXzCX7fvW2B5U3QzvVXjVptvleA2P+CtThSf+hz9Nb0IyNYi8FAtiVimnI
 kpnIglCbFIdzjxN9EAPztbH1Qt8oS+7uSqBmOwiwNlUjgTUNspdhctUw7IBp3uBldNhI
 MfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eFc3z5Zi2+P0zeUhuGfQxDe3HZ7k941fCcKiMMtRH/k=;
 b=S5HGaIWKeT2URA5XOA4LlAaHUR/Qy5uCEOLbrAxIsq1Xr3wpDyrh0259XCMa7v5fso
 AnxyHYwMlR3Gc016syN8GQkIU+hLNOtTD+2MhHJ1s4heV2dkE8iwvtwu8u3RIfp5FDLt
 9EwcRfqhuiUcDb+1zCRCDl+eiT6TfBqVs+7xXaBys3rVGR7z1iGNGsfAkcdZwW4JSpdD
 Y9Krqsxft1rSV4P6Vddok65hFKjG6RN2I9doNtvrfG3vslYWFTksu7hEnn5aFhdZ5omi
 LaKRNoqDPBtlICbvSqZTDv2KoqbzEh+4d8Ha9Xx1Y76cEErd5gFoeNuyFPVw0nJy4Qrg
 7IEw==
X-Gm-Message-State: APjAAAWOeX9J93329FZhj88WO9tf2nW3AwW8bfDJwOcJVuyPYCKemmIE
 smmsMPlqxus+ivOxOk8VFvxRZVPLW4PUQA==
X-Google-Smtp-Source: APXvYqw9feNtyeJMSFzRMeJx0zAzjY753mAF6jHNnDwEFJ5BpDn3zLhdtVukOZqdZe41HxcZn4gzfA==
X-Received: by 2002:aca:b456:: with SMTP id d83mr7918848oif.177.1560022211814; 
 Sat, 08 Jun 2019 12:30:11 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id o32sm2255158ota.37.2019.06.08.12.30.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:30:11 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-36-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e29659da-2b0b-71c8-6500-d6612fc254de@linaro.org>
Date: Sat, 8 Jun 2019 14:10:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-36-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 35/42] target/arm: Convert the VCVT-to-f16
 insns to decodetree
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

On 6/6/19 12:46 PM, Peter Maydell wrote:
> Convert the VCVTT and VCVTB instructions which convert from
> f32 and f64 to f16 to decodetree.
> 
> Since we're no longer constrained to the old decoder's style
> using cpu_F0s and cpu_F0d we can perform a direct 16 bit
> store of the right half of the input single-precision register
> rather than doing a load/modify/store sequence on the full
> 32 bits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 62 ++++++++++++++++++++++++++
>  target/arm/translate.c         | 79 +---------------------------------
>  target/arm/vfp.decode          |  6 +++
>  3 files changed, 69 insertions(+), 78 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

