Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B7BC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269DB2184B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Akd1uaka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269DB2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOaB-00029F-5D
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54491)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiOJq-0008Eh-PE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiOJo-0005F3-FU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:19:57 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiOJo-00050w-6O
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:19:56 -0400
Received: by mail-oi1-x244.google.com with SMTP id e189so13996649oib.11
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 12:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4TNElfhzeICSO8M8DhomXXEqirMo3CY4yJhxUTN0qV4=;
 b=Akd1uakagSbKtHTyT4zbYY5vrjFN3fZ0yeqY3LxRD1yqOqHWyaZ+xVBZvTssPpiHfF
 UNS0ojpta2E4KSUV5yF47rgCTPRXM91MsJtOcf784uUgtV0McfYMxxlBLC9Z26Y+M2Xt
 fK80++e++GEm3zm6tfigjgX20KMMfVHxRgVcqOsWes3gQxpRzatsjGxEIDqBmB3GVLst
 1yb66/uvfLL+fMtUodBv/hbEixQdJ1oIw/v879cIu3UXf1YxVXNkrfUnqS8SgDveKGRA
 PETlaVVMU91agoHDiQDaQg9AZuDcUE3w4gWQbCwM+m/HEMYigAXuTDuN8c+bJWXmk8FY
 wPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4TNElfhzeICSO8M8DhomXXEqirMo3CY4yJhxUTN0qV4=;
 b=md6INpSSaVpgh3jt8DiEC2XOVQoe7mkQ3TVqhHMx+XFFrY5Sd2+xhdOxcV6FkaecUk
 fHvji3osCR10eW8Lm2Yw9LvNuA3pysYVP9Q+bf5I/zNVVQdJu1pl+oVbu2RquokcSzYL
 XJClkWor65Lrle1uS2d4UCKkS4FiLEQSL3kP2CpdwIXEimw9LZVOqncYYqBOfow8ek85
 ZF3Be/I4lOUq6W6/4v1+ToGfvBfqvZpw9Z1dbUqkOsPv2K5VLakcAYk8Z2BzU+CpByFe
 OOxSjI4C4AvMi1GpyrQqCxxpdSi30+S1M0H6O24l71h1lp5XgedbBfIQMyNfg7/xywLB
 qLQw==
X-Gm-Message-State: APjAAAWMOdDHihTIpSFThbCAhD7umxyVBVDPRhLT/iE94wMR1q8NJR0D
 c0YpLhNInoSo/4xFBPHLpIdsy1DAcDl+R2WrhL02/g==
X-Google-Smtp-Source: APXvYqwKAzLfTjEA/vcNNC57QwGNqalNsX5J+F9E1lhwSw0frHgFKRTy9+qefM+lf/DD7a1JHWAwtlzX/bxCTAk9TFI=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr4245883oic.170.1562095181872; 
 Tue, 02 Jul 2019 12:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-4-clg@kaod.org>
In-Reply-To: <20190618165311.27066-4-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 20:19:31 +0100
Message-ID: <CAFEAcA_wCFE0BL_LjF+04MBPa2XnVgCKk4SP4nPrBjrcjmNVVQ@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 03/21] hw: timer: Add ASPEED RTC device
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 17:53, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> From: Joel Stanley <joel@jms.id.au>
>
> The RTC is modeled to provide time and date functionality. It is
> initialised at zero to match the hardware.
>
> There is no modelling of the alarm functionality, which includes the IRQ
> line. As there is no guest code to exercise this function that is
> acceptable for now.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Hi; Coverity complains about this function (CID 1402782):

> +static void aspeed_rtc_calc_offset(AspeedRtcState *rtc)
> +{
> +    struct tm tm;
> +    uint32_t year, cent;
> +    uint32_t reg1 =3D rtc->reg[COUNTER1];
> +    uint32_t reg2 =3D rtc->reg[COUNTER2];
> +
> +    tm.tm_mday =3D (reg1 >> 24) & 0x1f;
> +    tm.tm_hour =3D (reg1 >> 16) & 0x1f;
> +    tm.tm_min =3D (reg1 >> 8) & 0x3f;
> +    tm.tm_sec =3D (reg1 >> 0) & 0x3f;
> +
> +    cent =3D (reg2 >> 16) & 0x1f;
> +    year =3D (reg2 >> 8) & 0x7f;
> +    tm.tm_mon =3D ((reg2 >>  0) & 0x0f) - 1;
> +    tm.tm_year =3D year + (cent * 100) - 1900;
> +
> +    rtc->offset =3D qemu_timedate_diff(&tm);
> +}

because the tm_wday field of 'struct tm tm' is not initialized
before we call qemu_timedate_diff(). This is a false
positive because the "read" of this field is just the place
in qemu_timedate_diff() that does "struct tm tmp =3D *tm;"
before calling mktime(), and mktime() ignores tm_wday.
We could make Coverity happy by using a struct initializer
on 'tm' here; on the other hand we don't do that anywhere else
which calls qemu_timedate_diff(), so maybe I should just mark
this a false positive?

thanks
-- PMM

