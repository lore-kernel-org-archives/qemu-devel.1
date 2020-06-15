Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC332C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BD12074D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbeNEfx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BD12074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkp0m-0005lC-Js
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkp0A-0005EO-LL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:18:14 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkp08-0002Sf-SF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:18:14 -0400
Received: by mail-ot1-x344.google.com with SMTP id e5so13025555ote.11
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C9iU4xzLDYGTz5JXVfcQMLl8F0Fm+tJzkudP0dqBOnw=;
 b=MbeNEfx8v+yWc+GRLCSHSsUJTP6X+CoJmAaxBG05trp5Kkxx52q5XBfDh7T0Ec9VM7
 0VT/UzZS/Ds647O7LtJIl5sLi9h0ayOigyllgkAjVmAo8EQTTiDqGiIg0vGYY5roG1Yz
 jb03g/siksYQyZPAH9tgPplvSDqLi+Ki7KPWry6XldiKCCcL/znLkKQeDoi5+1HxlARH
 RhF2rQzSh69+jpLI0T9k2hbZEGqBSwXQVB1Y4sKfPENRwWFHp2QRQFZCBIYtlpGXZR0k
 /sdwPlj35LEYyAk/7GsFTjP9AbMlTuaNCV3yhBpcE1HJvl54BLqmo5IgaSnC1Wz6uEeZ
 h+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C9iU4xzLDYGTz5JXVfcQMLl8F0Fm+tJzkudP0dqBOnw=;
 b=PyhNR2FFCss86WqxYV6k+d4O+oga1FhjUI8M32mSWWEfzl4q6ptas/01ZV6jdgbiyV
 EB+dtKwlfAIf49ykbdUHX/dqbC8vwKSsymmZHxbZqtbt12FwfJZPnNKui7MdMasPUf/B
 US0j+mYhGiUYF9Rbzc/7zXlpGvbXJ6fAzMYX5+aQE0G0PlQ/GLwpM0h2ToXvWJXh1jrr
 Hh0gOUV9FR6C4RQAqfFRjGkwAb5XKm72QBFQbTlEwL0k+Tcsu/BUKKrwql4X2Aek0dmd
 xJuinvdo6RSOMVrcjiMGUJR3TALaLe8DH4rUWLjp/eBctvP9xpd0H6143mE1siiCknjM
 U69A==
X-Gm-Message-State: AOAM530u6phuOb/fis0aaWO6Rr0xwpQdyyi9ixv7MItniIBnIvlXJ8UZ
 9IsSH/pTjKG4bT1dL7inbInSFQCH3iaV5ROc2Bgfsw==
X-Google-Smtp-Source: ABdhPJyZ/g3A3pcMGHn3ta0y0KXbBnah7TKkT3bhrVb+0N9qJX95LCQ0UyYP/+1AgTyLkIigmJRKWpST0kPobaNcBuI=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr20428357otn.221.1592227091647; 
 Mon, 15 Jun 2020 06:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200603145258.195920-1-linux@roeck-us.net>
 <20200603145258.195920-3-linux@roeck-us.net>
In-Reply-To: <20200603145258.195920-3-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 14:18:00 +0100
Message-ID: <CAFEAcA9HE0Be9QNfGKxp4YL-V_+khUNS4KOL43LBC9mQd75eLA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw: arm: Set vendor property for IMX SDHCI
 emulations
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 15:53, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Set vendor property to IMX to enable IMX specific functionality
> in sdhci code.
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Added missing error checks
>     Added Philippe's Tested-by: tag
>
>  hw/arm/fsl-imx25.c  | 6 ++++++
>  hw/arm/fsl-imx6.c   | 6 ++++++
>  hw/arm/fsl-imx6ul.c | 2 ++
>  hw/arm/fsl-imx7.c   | 2 ++
>  4 files changed, 16 insertions(+)
>
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index cdaa79c26b..a853ffcc00 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -274,6 +274,12 @@ static void fsl_imx25_realize(DeviceState *dev, Erro=
r **errp)
>                                   &err);
>          object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPAB=
ILITIES,
>                                   "capareg", &err);
> +        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
> +                                 "vendor", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }

The existing error handling in this function is wrong -- for multiple
calls that take a pointer to a local Error*, the
check-and-error_propagate() has to be done after each call, it can't
be rolled up into a single check after all the calls. (see
include/qapi/error.h for the patterns that are valid).

On the other hand this change is correct-in-itself so I guess it
isn't making the problem worse...

thanks
-- PMM

