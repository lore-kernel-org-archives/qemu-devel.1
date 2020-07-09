Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD522C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9423D2078B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIlpkZei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9423D2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtbAL-00054p-Tq
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 14:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtb9c-0004T3-5k
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:20:16 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtb9a-00047E-3i
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:20:15 -0400
Received: by mail-oi1-x242.google.com with SMTP id h17so2664185oie.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=79iJKhuASA6U5zffmPecA5tdiCRnbtSTpnpwP3NfifY=;
 b=XIlpkZeiGm7R9oXs5/lsIchSxepNWIyWIf5Fa7spDj1sxne/ThrC0pkhYCUtnAqmmU
 EPthyrvUQ895g+CcB8QCBL76i13bviumbdm3m+n/N8YUkC4h1kRmNIj01fcxYVCvMz9X
 VdI1UphyaJnF4BW1xPjfRTDz9WpL0eQwvLiGy7i8kqr4O9Fl9NKq7OCoIgG8FqZ6FI1i
 XoZx+yG2tXO6bkOOpvm6PHiGPaV/3Fxg5qFEXWPke+QZqsMWoPvlSGgHNDaXl4EKaGyi
 2OjNxEU1tMpeAch6G1woQHpQdhCEqJcGSQajAxIx1Y+GEsOuQieG084fcp2TIosFUVvy
 Fg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=79iJKhuASA6U5zffmPecA5tdiCRnbtSTpnpwP3NfifY=;
 b=MMz4kxRBBV0TyVLSqo4EOY5cXAxp/aggUuGQtP5VIsHjZu6n2HHmmC5xisZAZ8U8JW
 wjIffMmSiDbXWifdHZaSOWrgE0SYFfP+sQxGsgqhqK174wjzXpzu3Tv8XQbPuB5iDZR0
 XG9tg0VB/qCZgnQ7e+xqVQxzMrQbCpnilBnr+ip4hf4F3gkTftcQoJUuKVLTfubeP/od
 GSLm5Jj34mcThYAytjgBOEdy7tsrLfOdgeq+bCKDhmLwvwPRxASTNBEe0xpTYl8fORHA
 bMOeiXqoNfOdk1z007lgt+4QugBKSGJIxBv22NubYkmOEpwwcE6r89Nn0SAy40u3l4u6
 FSIQ==
X-Gm-Message-State: AOAM532sKZKGkn32OuMEGs/uip4NUtu3JGJNoozXZJN7UvmYrKQLslgS
 iJWYhVwaNH4+7UpY3ZnJEmPD8ss37oMi5HRrUw4jmQ==
X-Google-Smtp-Source: ABdhPJyhI78AlaGlkgJV1v3nlXAlcQETNelsLqACtfq2gCiD2wqjghOZ5wZYkO2mIvaE2XyoAhxSH15Amg+2b3SzNb8=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr1183515oib.163.1594318812632; 
 Thu, 09 Jul 2020 11:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200705204630.4133-1-f4bug@amsat.org>
 <20200705204630.4133-8-f4bug@amsat.org>
In-Reply-To: <20200705204630.4133-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 19:20:01 +0100
Message-ID: <CAFEAcA9_RBJ75RuutubdQUJhk9N1Rs+A1pR9ZnCfzV_Gs=Z7Ag@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] hw/sd/pl181: Do not create SD card within the
 SDHCI controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 Jul 2020 at 21:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> SDHCI controllers provide a SD Bus to plug SD cards, but don't
> come with SD card plugged in :) Let the machine/board object
> create and plug the SD cards when required.

Nit on the commit message: the PL181 isn't an SDHCI controller
(which is a theoretically standard controller as regards
register interface etc, and which in QEMU we model in hw/sd/sdhci.c);
it's just a plain old MMC/SD card controller.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/integratorcp.c | 13 +++++++++++++
>  hw/arm/realview.c     | 12 ++++++++++++
>  hw/arm/versatilepb.c  | 26 ++++++++++++++++++++++++--
>  hw/arm/vexpress.c     | 11 +++++++++++
>  hw/sd/pl181.c         | 19 +------------------
>  5 files changed, 61 insertions(+), 20 deletions(-)

> @@ -649,6 +651,17 @@ static void integratorcp_init(MachineState *machine)
>                            qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_WPROT=
, 0));
>      qdev_connect_gpio_out_named(dev, "card-inserted", 0,
>                            qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CARDI=
N, 0));
> +    dinfo =3D drive_get_next(IF_SD);
> +    if (dinfo) {
> +        DeviceState *card;
> +
> +        card =3D qdev_new(TYPE_SD_CARD);
> +        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo=
),
> +                                &error_fatal);
> +        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
> +                               &error_fatal);
> +    }

So instead of the pl181 creating the card object, the board
now does it, and only if there actually is an IF_SD drive to
use with it. I guess that makes sense. (If it turns out that
something depends on the existence of the card-without-backing
we could do what xlnx-zcu102.c for instance does, and create
the card in the board wtih a NULL backing drive, but let's not
do that unless we're obliged to.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

