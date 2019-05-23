Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3BEC282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8622175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsPsEkDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8622175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTu3c-0006h5-UT
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:11:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTu2V-0005vB-Cy
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTu2U-0004a5-Ha
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:10:11 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:40575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTu2U-0004ZX-BY
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:10:10 -0400
Received: by mail-yw1-xc44.google.com with SMTP id 18so2750551ywe.7
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=tj+njzIlptF/VIznWoGknE1ID/zZ+Y0eBYhXAyyclxw=;
	b=TsPsEkDBbtgoeku2Ycm5czHVxfrQheE8tauVS4IuzUZAfinp1hOO6Bekhpc09wPKre
	WbR49uHA0Zpy653RQWP3M8QMm8dyP/Rfhvonkd5Jh87Ak9XL8EiVvGsP/PLG8folVlEB
	VLt9dcWAk07aoXm1Su/jhoiyqECnSXoNT9Xhw0+6ytSRFHyCP39H7wfkF8fYsf7onCOf
	QmKt8LDkaX7W3IgeLLjS9Myrb7lvrSLt5MHqtHUOeczMxGEUlqKH7CfsTJQzgwUVTOL8
	fz6J0Wc0Xv/eWxlrYdpznIdKPr6ur1eXAz1X2/M+meurAxbcRCmQp1wC7u+BU5B7smlT
	kseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tj+njzIlptF/VIznWoGknE1ID/zZ+Y0eBYhXAyyclxw=;
	b=cnc5z4I9lfzmRnEkYrFqn59ianayv/2a0mdIJ0jtoY6gZrnfi6k7uCWwzJ1ZMprJbO
	nDfDdAMdDgDV5MZuI7GDKn9JMNT6BT98aRv4r/dbKRlgNJEeNHPKUnnyUHG1ittfQR7a
	Z9sC6BOBYEbiX7wniYYDbprxmLkl4ZVykeMkkJfqnOAqErOgag+nGxilKViQZZuorTZf
	P6rsu2QDdyf7fqDspcCc14Cf4ZwXDFhlc098dhsKOtpwPoBTUhiX4hf+z0i1LbNJRyXp
	jG7N8UDIHdfC+XXRux4+6xCZoIEnR6FMh+u3WnLTIUPH0yikQyUdv7xI1+3XlErWbofR
	ML6w==
X-Gm-Message-State: APjAAAVtldxAnBu1p7SI3Hj3IOJeq3Rc2uaSaAuSB7eHwUKvO+grVU73
	Frnm2StstKaOwCiNgNPRSrl8yg==
X-Google-Smtp-Source: APXvYqwF6y04CP5s+p4f0rep7vdQvj+NL8P6zsMzuVP8AK+Mub30qXl/gy35tH6ABgBpb0tS98q2Cg==
X-Received: by 2002:a81:980b:: with SMTP id p11mr13795041ywg.48.1558642208760; 
	Thu, 23 May 2019 13:10:08 -0700 (PDT)
Received: from [10.240.229.182] ([71.46.56.19])
	by smtp.gmail.com with ESMTPSA id 193sm80624ywf.28.2019.05.23.13.10.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:10:08 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <52b8de1d-3900-2368-eead-5e98261f509f@linaro.org>
Date: Thu, 23 May 2019 16:10:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102532.10486-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: Re: [Qemu-devel] [PATCH v2 17/28] tests/tcg/aarch64: add system
 boot.S
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 6:25 AM, Alex Bennée wrote:
> This provides the bootstrap and low level helper functions for an
> aarch64 kernel. We use semihosting to handle test output and exiting
> the emulation. semihosting's parameter passing is a little funky so we
> end up using the stack and pointing to that as the parameter block.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - fix tabs
>   - 2 stage table lookup with ro and nx sections
>   - set stack to back
>   - moar comments
> ---
>  tests/tcg/aarch64/Makefile.softmmu-target |  32 +++
>  tests/tcg/aarch64/system/boot.S           | 239 ++++++++++++++++++++++
>  tests/tcg/aarch64/system/kernel.ld        |  24 +++
>  3 files changed, 295 insertions(+)
>  create mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
>  create mode 100644 tests/tcg/aarch64/system/boot.S
>  create mode 100644 tests/tcg/aarch64/system/kernel.ld

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

