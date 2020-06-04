Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4A6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1C6206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH249+Z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1C6206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjNi-0004x3-9r
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgjMs-0004Pa-Ta; Thu, 04 Jun 2020 02:28:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgjMr-0006Pg-Nw; Thu, 04 Jun 2020 02:28:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id x13so4755217wrv.4;
 Wed, 03 Jun 2020 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jnMavzySpePqX+y55tnoGtnM1AAZep+OLH/uhTantFk=;
 b=dH249+Z60ca54BkSRgR2dQ/1gP6/iWN6DN2V0X57ZSuFHfFGoDc9Wrd7X6kz41xMLM
 QkRc9iEde+6Ah8LYnKU0Uc53elndSrhQFd2Hkd6g0sFI4xq4c64dJ/5avkDLrcfFLZo5
 Z+41z1iVtAHattIjG6xj3BQj4NrWjs9036P6WCudItCN7CqSofQGWQUANQ47cG/TNtWU
 oeJJ8HMrLww/Uuy7Do04Vd1qGjx8VZEPDy2PzL/kB46LyXUwgN5h2zKSJhENAjstMt40
 +ALZ12TojrPa6hwFKwE4+oQwX7NgnLz7GkCqw6hSwCIHwzW4LObwfyaD8lF+sPtzEfe6
 WHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jnMavzySpePqX+y55tnoGtnM1AAZep+OLH/uhTantFk=;
 b=F2FPgR2EAt3nlW03M9PoJvnFNMsbD5EGoXhRYNTc7CAh61CMoFtyJeoDhX30ISzw9E
 NIesN86JrJu5b8CN29vjx9fuXji5vYDsfz5zblZtdylpc/NJj/1Fyqowj64FPpZzUclj
 e/yMWWVA/EhFlWBGup9fOHbJ0MgezBtUzDd0C6TCjQUloRNpBl4btIgTKu4d3Ow7Hy/l
 5hHcEQAYhoKnZQMpFNGMR4xBoL/yovC3JuNZE4gRQdc4XIkl70hjzsP6qZtMqkCT8YhO
 auw/2pUSNTBq4LWTwN0ZMGcP1rfCuthXIGLyJM/nYKTOMtySWmwAj2ypo97Ctoj1vNyS
 ttYA==
X-Gm-Message-State: AOAM533vxHRo2n9qi6BjkTKPagn3xg5hSpHnJ/zTyLVtZwIXQmXDl+u5
 GmzejSPbOqw3OGaspXlblo01du4C
X-Google-Smtp-Source: ABdhPJxTxtjVc08FarGVhcfYFyvq1Bh32xcf73hb9ncNyCFbBw/Te0wvb64u2OqwjNUpXN4dJKO+Wg==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr2967706wrq.247.1591252123134; 
 Wed, 03 Jun 2020 23:28:43 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id v19sm5767431wml.26.2020.06.03.23.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 23:28:42 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] hw: arm: Set vendor property for IMX SDHCI
 emulations
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200603145258.195920-1-linux@roeck-us.net>
 <20200603145258.195920-3-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6b80c595-761f-b083-af09-867c420026e0@amsat.org>
Date: Thu, 4 Jun 2020 08:28:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603145258.195920-3-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

On 6/3/20 4:52 PM, Guenter Roeck wrote:
> Set vendor property to IMX to enable IMX specific functionality
> in sdhci code.
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
> @@ -274,6 +274,12 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
>                                   &err);
>          object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
>                                   "capareg", &err);
> +        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
> +                                 "vendor", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
>          if (err) {
>              error_propagate(errp, err);
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index f58c85aa8c..29677cfd59 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -350,6 +350,12 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>                                   &err);
>          object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
>                                   "capareg", &err);
> +        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
> +                                 "vendor", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

