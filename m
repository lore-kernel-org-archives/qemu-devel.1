Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7DAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6892E20775
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfgBrDY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6892E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtbX4-0003WG-OH
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 14:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbWB-0002zA-Oq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:43:35 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbW7-0001Gh-Cq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:43:35 -0400
Received: by mail-ot1-x344.google.com with SMTP id n24so2379774otr.13
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 11:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XLCJhvCmRGA/0A3mO5tinIdkZXp2MxZF5s0OuyMW6Gg=;
 b=GfgBrDY7xJ5Z0WIAmSfTnBJDsvSAnsbBIvts2KgmX4fyTHFm3tEstfZ9O7SkZXc2lm
 dGt9VB4f6D+qpDLUf+czfOaLjcp6TAJKFzHBKwSCIQR7QgYdO7OovXp3d3XC8Pf6X+ze
 oR/McFSdnH3C1TdRA4jU+Bu0q/E8m7WDtz/6GT94nLsIEHZNCE2SwoQLw937Vinx7aMP
 RZXZuVZlsdI8h1GGeIWxNtkTIGMyyd2BxaWoyvlkjPlaaareeeWV1WlVkxlGHptGbVYp
 n7gYuEBXUcR3cLu7HbprHgk2U30bj25ZFqxukun9y9wdZVNdH69PaPBpNpn4phXO1j77
 ZQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XLCJhvCmRGA/0A3mO5tinIdkZXp2MxZF5s0OuyMW6Gg=;
 b=edqO120mEIKsbbE50sjdNghwfnlGrh8IFCB3Qmu84ZSORXJFlKKIi1m9xqhO0lhlgT
 /9QEvLPqM7Q2GEsBvA8XrAbfTpoa0lSuGgtJkyoqNQIubUF5FRz6G7A8Y4v0iBRJIc2A
 AYiK7ZK3ucCU+sOMTK6fICS6imurI0QpMMtNIxIBeHtoXsXWpK+k5dfUC05SJalRzpyU
 j8gbss2n2eHu2yElA3H1egTYF68iHJzWZEd8oZTh7gX2hNNqJMcuY6jm26Kh3VQ+X0QA
 y/VnarBVZZuO2h8UtljssLeP/14OCbo+80B7iGrlvht2bDw+JE+Q34ke2YEc6wFtQtAh
 RmEw==
X-Gm-Message-State: AOAM5336oYBPfzNvTaNWN2Icip3B5LtA+n3K31Jh/WEtqYocez73+pk+
 oaBz7fh4yc3hd+v4AvexJRyCNP8YNt8OVsjb5ZRHFA==
X-Google-Smtp-Source: ABdhPJz/IbCzr7qeZgqIZ6hhHWQnHX4whPhRitW6xAowp1mTV6z3AVWrhUuzgfIwxti+bTRtIKf9XQjAWIP1TueQpv8=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr47488751otk.221.1594320209958; 
 Thu, 09 Jul 2020 11:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200705213350.24725-1-f4bug@amsat.org>
 <20200705213350.24725-2-f4bug@amsat.org>
In-Reply-To: <20200705213350.24725-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 19:43:18 +0100
Message-ID: <CAFEAcA8=sJ6JsrPFyN14OjN1zPORvZDf+QLoShT0O+j6GgwDmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/sd/pxa2xx_mmci: Do not create SD card within the
 SDHCI controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 Jul 2020 at 22:33, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> SDHCI controllers provide a SD Bus to plug SD cards, but don't
> come with SD card plugged in :) Let the machine/board object
> create and plug the SD cards when required.

This too is not an SDHCI controller.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/pxa.h |  3 +--
>  hw/arm/pxa2xx.c      | 39 +++++++++++++++++++++++++++++----------
>  hw/sd/pxa2xx_mmci.c  | 11 ++---------
>  3 files changed, 32 insertions(+), 21 deletions(-)
> @@ -2135,15 +2136,24 @@ PXA2xxState *pxa270_init(MemoryRegion *address_sp=
ace,
>
>      s->gpio =3D pxa2xx_gpio_init(0x40e00000, s->cpu, s->pic, 121);
>
> -    dinfo =3D drive_get(IF_SD, 0, 0);
> -    if (!dinfo && !qtest_enabled()) {
> -        warn_report("missing SecureDigital device");
> -    }
>      s->mmc =3D pxa2xx_mmci_init(address_space, 0x41100000,
> -                    dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                      qdev_get_gpio_in(s->pic, PXA2XX_PIC_MMC),
>                      qdev_get_gpio_in(s->dma, PXA2XX_RX_RQ_MMCI),
>                      qdev_get_gpio_in(s->dma, PXA2XX_TX_RQ_MMCI));
> +    dinfo =3D drive_get(IF_SD, 0, 0);
> +    if (dinfo) {
> +        DeviceState *carddev;
> +
> +        /* Create and plug in the sd card */
> +        carddev =3D qdev_new(TYPE_SD_CARD);
> +        qdev_prop_set_drive_err(carddev, "drive",
> +                                blk_by_legacy_dinfo(dinfo), &error_fatal=
);
> +        qdev_realize_and_unref(carddev, qdev_get_child_bus(DEVICE(s->mmc=
),
> +                                                           "sd-bus"),
> +                               &error_fatal);
> +    } else if (!qtest_enabled()) {
> +        warn_report("missing SecureDigital device");
> +    }

When we finally get round to qdevifying the PXA2xx this will
have to move up another layer, since pxa270_init() is
effectively the SoC, not the board model. But for the moment
this is as far as we can sensibly lift the code.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

