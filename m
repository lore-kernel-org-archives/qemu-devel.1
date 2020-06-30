Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D157C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F8720675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KADdr3Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F8720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCQl-00059V-7K
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqCJy-0003Md-13; Tue, 30 Jun 2020 05:12:54 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:35892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqCJw-0004Ge-BB; Tue, 30 Jun 2020 05:12:53 -0400
Received: by mail-ej1-x644.google.com with SMTP id dr13so19765150ejc.3;
 Tue, 30 Jun 2020 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8iQDYWLq2u9U5xO0oyhVLNoOu7M5Iw5Mjo3XfjJvw3w=;
 b=KADdr3WiMXnyneFk9ij8RDw7BELQ2bahsWBFtEZ9jAClAAB6YK+QGRo9WDvUQac0Lv
 bALAdqdnuI5WUDwXHjCrgL46+ojD8//TBcuiA8+DHgibK5DKjz9iBkF14+W53I7xbLpV
 P3umzuKu0wUDSwQ6Y+e5hTLZTbk++ZRcTc0Fhlg0DP+ehxABLuo4ugIu0DBMwlvIblDE
 5DRkGPYskILZL+CzEnPf7O+tLhQ4+hXMNbYAP08Bn9CFdo0p+jttLfzBB4ZxaXLsdttr
 g1GMY4qLuiIYCv2hPdXvwW8wptb28Lz2tXeXWyPASdu/FnY+JxVz0XtyMNAnEnOywQ43
 LcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8iQDYWLq2u9U5xO0oyhVLNoOu7M5Iw5Mjo3XfjJvw3w=;
 b=rHlt9wNU4eXiDXHNd7XiQVPah4ShjtNwvSy12x8GKIMMFiScvDzW3PyyK4poJBUe2C
 OnA3I5XxU5z8TpeOWW7j/ERlG/GUh7CynFCqgxRjq6vWyrtPYbM2Lwk/N7mOiN6dhHnZ
 CjBeBGRcVj+DFGMniIJqN64RbGvIAVSzbj8gv6/bFRMFTyL0+8q9fIZgntJPnz1O6Klk
 LgHZdhlEO8e1MssjWsJ49iGEnZ7WIwTXqGJl8WsgQri1rpnaTRx0iGU7dA4N2V6ok4+I
 K/+MPCOS1hOUE/E3Eld40Oaq2UtTd4FDAJW+K0UsLo4rzXWQIZoRuxBVXBS5aFCLx736
 HYkg==
X-Gm-Message-State: AOAM5322m5XCT4zUrtXEfYrdNfmzXdLy8zQN7+kSlQXUdPz0WR0Cg1W0
 G0gIuJmsZyIwN0oTjzeSYUJXEhLdZqg=
X-Google-Smtp-Source: ABdhPJwmVsGXn6XJj/ifBr8VYcc1SB0wwco/zZTKJXIVCV0wQ9d1BTnwFSsoRQD+0kaoTLwK+d6P8w==
X-Received: by 2002:a17:906:3b83:: with SMTP id
 u3mr16947370ejf.207.1593508370579; 
 Tue, 30 Jun 2020 02:12:50 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x9sm1548419ejw.28.2020.06.30.02.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 02:12:49 -0700 (PDT)
Subject: Re: [PATCH v3 25/26] arm/{bcm2835,fsl-imx25,fsl-imx6}: Fix realize
 error API violations
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200630090351.1247703-1-armbru@redhat.com>
 <20200630090351.1247703-26-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <205a9997-be98-50d3-050d-54e5a461cb0a@amsat.org>
Date: Tue, 30 Jun 2020 11:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630090351.1247703-26-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 11:03 AM, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
> 
> bcm2835_peripherals_realize(), fsl_imx25_realize() and
> fsl_imx6_realize() are wrong that way: they pass &err to
> object_property_set_uint() and object_property_set_bool() without
> checking it, and then to sysbus_realize().  Harmless, because the
> former can't actually fail here.
> 
> Fix by passing &error_abort instead.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/bcm2835_peripherals.c | 12 ++++--------
>  hw/arm/fsl-imx25.c           | 12 +++++-------
>  hw/arm/fsl-imx6.c            | 12 +++++-------
>  3 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 1e975d7eec..7ffdf62067 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -283,16 +283,12 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>       * For the exact details please refer to the Arasan documentation:
>       *   SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf
>       */
> -    object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version", &err);
> +    object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version",
> +                             &error_abort);
>      object_property_set_uint(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "capareg",
> -                             &err);
> +                             &error_abort);
>      object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-quirk",
> -                             &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> -
> +                             &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
>      if (err) {
>          error_propagate(errp, err);
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index f32f9bce0f..7ab5c98fbe 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -260,15 +260,13 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
>          };
>  
>          object_property_set_uint(OBJECT(&s->esdhc[i]), 2, "sd-spec-version",
> -                                 &err);
> +                                 &error_abort);
>          object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
> -                                 "capareg", &err);
> +                                 "capareg",
> +                                 &error_abort);
>          object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
> -                                 "vendor", &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> +                                 "vendor",
> +                                 &error_abort);
>          sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err);
>          if (err) {
>              error_propagate(errp, err);
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index d4bc4fae93..4ae3c3efc2 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -336,15 +336,13 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>  
>          /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
>          object_property_set_uint(OBJECT(&s->esdhc[i]), 3, "sd-spec-version",
> -                                 &err);
> +                                 &error_abort);
>          object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
> -                                 "capareg", &err);
> +                                 "capareg",
> +                                 &error_abort);
>          object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
> -                                 "vendor", &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> +                                 "vendor",
> +                                 &error_abort);
>          sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err);
>          if (err) {
>              error_propagate(errp, err);
> 


