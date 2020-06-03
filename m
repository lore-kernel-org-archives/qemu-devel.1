Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A61CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CA420659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h87sP/gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CA420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgN0h-0004JH-2s
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 02:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgN06-0003h6-HP; Wed, 03 Jun 2020 02:35:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgN05-0007rO-MB; Wed, 03 Jun 2020 02:35:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id t18so1020086wru.6;
 Tue, 02 Jun 2020 23:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g44X49qCAPWgkjJ7nHgLU91zRDnKcV7Uc1rJPNtR+qs=;
 b=h87sP/glPRQ9/XwxH0P0jpM3WkHQ1r3LXe4N9px4R3Sd3YMNZ3IP+VIlbRCcXXJXQD
 YvkSw5MIGB5XDLKxp1Mm4jbGo6Oxw+zHJlT0V+ShhbLzi6S8Hj7Gqu1Fe9MBb4m3zjNv
 nO9XdGwAX+glv3+g8mINGF6GMjYKuUCfjUQC6gSUL8J/Lg9M3FJb1jTuZD8XGweTEr78
 uQd9pS0+qOt86FXUzFY63mcCMQPSJBAoCVH4v+lFudTItrw2dl4hLtA5uRo8Ns0X9aet
 DdzaFqKtIlGLs3GmU3y7KQJPyjlZXUw7jawKehWspo8a9tF2yoC3r1UoVQ6QfDWy1JmH
 lmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=g44X49qCAPWgkjJ7nHgLU91zRDnKcV7Uc1rJPNtR+qs=;
 b=lmtT7DOhw5yISXOogu3wH9GMtfCekAp9Q7qfpqISyCNGGdYAS/sOUgtFUZiJO/6v11
 kEILpUlRFHTwSzSrRD4lPXTStkzxgQOEi4+mLiUxsTT4ZVlxJndw003bRcPOuGoqrJTP
 5IyEi0E5BOJzWAm/ojXOxmEvTJkP8NTJJ90+/Wdy9Wr+KNT06zKIwbMnsVMj7XDRz68F
 p7nNPDeIULGTqW4jcd/AhENiKNIa60ojhAJBOw5sA9JX01kMe81oy65P9preZ/A0dmYD
 6nz2nfzYDsjTAGxXN4c0Ak5zOyMK+WB4rGOGNW5idFwALp9IK1V8xwgO9eVeF43SkUrD
 6qGQ==
X-Gm-Message-State: AOAM532KKp1G48E30INGRSik/zFYjgK+3dSISVlgZSOhx2ofilF2MrIz
 Pmn3g6rnc7h9tMpglDrBovw3De6h
X-Google-Smtp-Source: ABdhPJw/F3GHhYCw6ciY41M+eYIZhlY5FVjWRP3TuS6pITU1oidPCergeJI/Upeq9eB9Mfg/gyFkMw==
X-Received: by 2002:a5d:61d0:: with SMTP id q16mr31000171wrv.182.1591166143412; 
 Tue, 02 Jun 2020 23:35:43 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c5sm1886719wrb.72.2020.06.02.23.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 23:35:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw: arm: Set vendor property for IMX SDHCI emulations
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200603052404.30788-1-linux@roeck-us.net>
 <20200603052404.30788-3-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <ccd8a8a5-0d40-2060-e9ea-c64c44a7d688@amsat.org>
Date: Wed, 3 Jun 2020 08:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603052404.30788-3-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Guenter,

On 6/3/20 7:24 AM, Guenter Roeck wrote:
> Set vendor property to IMX to enable IMX specific functionality
> in sdhci code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/arm/fsl-imx25.c  | 2 ++
>  hw/arm/fsl-imx6.c   | 2 ++
>  hw/arm/fsl-imx6ul.c | 2 ++
>  hw/arm/fsl-imx7.c   | 2 ++
>  4 files changed, 8 insertions(+)
> 
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index cdaa79c26b..2cbd985e93 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -274,6 +274,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
>                                   &err);
>          object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
>                                   "capareg", &err);
> +        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
> +                                 "vendor", &err);

Either check &err, or use &error_abort.

You can see a fix here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg695544.html

Otherwise:

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>          object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
>          if (err) {
>              error_propagate(errp, err);
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index f58c85aa8c..8e9a94e4d7 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -350,6 +350,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>                                   &err);
>          object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
>                                   "capareg", &err);
> +        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
> +                                 "vendor", &err);
>          object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
>          if (err) {
>              error_propagate(errp, err);
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index 3ecb212da6..ce1462927c 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -505,6 +505,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>              FSL_IMX6UL_USDHC2_IRQ,
>          };
>  
> +        object_property_set_uint(OBJECT(&s->usdhc[i]), SDHCI_VENDOR_IMX,
> +                                        "vendor", &error_abort);
>          object_property_set_bool(OBJECT(&s->usdhc[i]), true, "realized",
>                                   &error_abort);
>  
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index 89c3b64c06..dbf16b2814 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -416,6 +416,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>              FSL_IMX7_USDHC3_IRQ,
>          };
>  
> +        object_property_set_uint(OBJECT(&s->usdhc[i]), SDHCI_VENDOR_IMX,
> +                                 "vendor", &error_abort);
>          object_property_set_bool(OBJECT(&s->usdhc[i]), true, "realized",
>                                   &error_abort);
>  
> 


