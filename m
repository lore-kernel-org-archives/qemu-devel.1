Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7DCC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 03:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516C4206A3
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 03:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWS1HAU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516C4206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMllt-0006bS-Dt
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 23:55:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMll1-0005sF-2l
	for qemu-devel@nongnu.org; Fri, 03 May 2019 23:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMll0-0007Nu-37
	for qemu-devel@nongnu.org; Fri, 03 May 2019 23:54:39 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMlkz-0007Mv-Re
	for qemu-devel@nongnu.org; Fri, 03 May 2019 23:54:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id z28so3890001pfk.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 20:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=bmbADVETJjJN3yOaF50RhPlUcLm6ZMtMN3OCO71r5XE=;
	b=uWS1HAU+WvCL0FRoj/JyGdd+ZE0Ajqe5JhrzpMu3/PrV6NH+PVCjt9Kt9lNDhbLKdd
	L4RsShFsXq1iQlbN9vdlaSZg4841NOj+SXB61Owhlt7XL3hBcCeTb6pEbPIlj+t8eRBE
	08QPZWyrrmPkzb5kNDRq82zpQCrq4YEXu38fKnBXrSDj4AMTDDI3e3e0uDJWLjdFJS1J
	WIHPXOOSzYHhrnQX9FvjvL5QG3+64L9EKRRCBMaBEAmM0nfgK0FcQvbd7JNP9FLO2tc+
	Bdb1gU3qUndHsVPf/w1hZ3YoMEIgzJJo8EziWVbPJbXfG/XrUCY9uJXqGtwSWPEvhuJd
	oTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bmbADVETJjJN3yOaF50RhPlUcLm6ZMtMN3OCO71r5XE=;
	b=HMg/Cxc+GaH++Ye7gp4aayEtYqliCNYtWLdLucX1KCBFMyR9a+ILTgAANdQrqsmGqr
	LMfNHAaxj6VdeiUgrzJZqt2xsNFMvEMz7/WM7Bk8SYZ9gNGAfgS6Fg380FzC/0sO8i9q
	TsDJ3r7igN/PiUVh0uVXujAW504PeeYKrY4UcOMrNDCI31yZ9cP3dF4HDp90YyilP0Hg
	z9LkmTM95uuC7XotXPkKNWDx6fHXrS8u629eabK/wRyG/Dgl4sE073E/PIl+3tm4aS6n
	GqlJqeTYjabFx86Ty0gJOWrdS0gtmgG7wwpiOkFuwqvCjUexzLOovt++i40Lb3k0RkFR
	p+mA==
X-Gm-Message-State: APjAAAX0p4VjRIky6YHs6bFFeMNbt9zHtKOycq7YOlvX9eDEG6RMkovq
	CqH3Y0TWIQ6GXQqAhJGTikcbsA==
X-Google-Smtp-Source: APXvYqxC1c75EHDFVKIfnNeOUUHVznK2wsYBAXXerDHSlfQS2hiFO9bHWHHcn2JLfTZcRlKhdwreiw==
X-Received: by 2002:a63:ff05:: with SMTP id k5mr15310796pgi.342.1556942075891; 
	Fri, 03 May 2019 20:54:35 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	z66sm8026636pfz.83.2019.05.03.20.54.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 20:54:34 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190503171347.13747-1-peter.maydell@linaro.org>
	<20190503171347.13747-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <690764a2-4998-c6ae-9e2f-11a3bfdaa215@linaro.org>
Date: Fri, 3 May 2019 20:54:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503171347.13747-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/boot: Honour image size field
 in AArch64 Image format kernels
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504035432.ohNVt2Go06VRCCbpnJCnvGmExKP0LW2dlkJGMwtBOwI@z>

On 5/3/19 10:13 AM, Peter Maydell wrote:
> Since Linux v3.17, the kernel's Image header includes a field image_size,
> which gives the total size of the kernel including unpopulated data
> sections such as the BSS). If this is present, then return it from
> load_aarch64_image() as the true size of the kernel rather than
> just using the size of the Image file itself. This allows the code
> which calculates where to put the initrd to avoid putting it in
> the kernel's BSS area.
> 
> This means that we should be able to reliably load kernel images
> which are larger than 128MB without accidentally putting the
> initrd or dtb in locations that clash with the kernel itself.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1823998
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/boot.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

