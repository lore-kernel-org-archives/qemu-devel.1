Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577CFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A1B20715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZZQB2mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A1B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTX3-0000KN-Ep
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 11:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsTW5-00088P-Bx; Mon, 06 Jul 2020 11:58:49 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsTW3-0001iY-KT; Mon, 06 Jul 2020 11:58:49 -0400
Received: by mail-io1-xd43.google.com with SMTP id q74so16303929iod.1;
 Mon, 06 Jul 2020 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mKKcigg475g4N5X0X8xo5+Vll3KSlqiH6YNr9EZUX1A=;
 b=jZZQB2mPthZPH0EYjofNRF9+BASAe23g47XL+reBmorK3DCgWUwcyBUBN/PYSsN47T
 5VKVRucvO0R6wAm2e0FiN3aar1PvDDrepdBseVBVlahU8Mk9UlW45FzfVoVS8jEfeoKa
 7a7XUMuW0yqw7p5t4mQAjFOYmryCAZAPpw0IdgtAz76OZ+MrWL4lgJiVwhi/pGDByOEs
 hMXp9xEzgAvmCQ5JuDSKx0vsd1fadkgpYvXIzdJUzOnI8xtkNtM0DHmrrr5OZSkz6CuT
 v4RGhDZJkAFkTrzIDsm7mthYyiFCfKSd73+NBJvcfj6LW5XV1ZXqV1R5R7U7AXUuU5a3
 v31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mKKcigg475g4N5X0X8xo5+Vll3KSlqiH6YNr9EZUX1A=;
 b=XBLra60FQi/ez9oJcnXCbsdFyAtHFdeoImk8dUE93mwBGWscJFELxAeGBWkqa6urZO
 YUUIeeQIrJYxP3oVQ8nTaZT+qrFoGyO1skZNSciwZ3kZ3TCmHNp+Pn11iBO4cYZ3Ruky
 YUpYLcs70vSRMe6SkFpn3EXIyQ9kDsWCSb4bXB9bd0Bf0LAcxnkEUAryEQfz3dMdowAI
 avYCKjkuqHsMItYfUSbc3Vmq3vb8MFN3fzTA6ibdLgNwkuGyvQdL0C3TdJON1hL+KBpd
 rp+wuSLAEq8HoJ01TgYUTdd7ZePIrk1/itcrDIruU2L+ZdYzf/4JGfuj4Hdw0ga3ccgW
 gEWQ==
X-Gm-Message-State: AOAM533JAVqFaav4G5jfGf41rkpQ8kIR3uwWPAQ+ads8XFS+CQKo64q5
 Dizvh+QU5D8Y3CbIjEAKpcxhXR0lM2kBIuYWqYo=
X-Google-Smtp-Source: ABdhPJxceGx4gftcAXtx8Omlhn25tRNGqkrB2VxMkDSh14kMcayuyMK18fsaQah2hfvevOUVVzfbDhTaaFCq/wxBps8=
X-Received: by 2002:a05:6638:dd3:: with SMTP id
 m19mr55462185jaj.106.1594051126113; 
 Mon, 06 Jul 2020 08:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200705204630.4133-1-f4bug@amsat.org>
 <20200705204630.4133-6-f4bug@amsat.org>
In-Reply-To: <20200705204630.4133-6-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 08:48:58 -0700
Message-ID: <CAKmqyKP2_y5vfrP+EMjOxv+Xkqx2SLKvwoWyX2Qnw1VigjGUJQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] hw/sd/pl181: Use named GPIOs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 5, 2020 at 1:50 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> To make the code easier to manage/review/use, rename the
> cardstatus[0] variable as 'card_readonly' and name the GPIO
> "card-read-only".
> Similarly with cardstatus[1], renamed as 'card_inserted' and
> name its GPIO "card-inserted".
>
> Adapt the users accordingly by using the qdev_init_gpio_out_named()
> function.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/integratorcp.c | 4 ++--
>  hw/arm/realview.c     | 4 ++--
>  hw/arm/vexpress.c     | 4 ++--
>  hw/sd/pl181.c         | 8 +++++---
>  4 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index b11a846355..2595e4d052 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -645,9 +645,9 @@ static void integratorcp_init(MachineState *machine)
>      sysbus_create_simple(TYPE_INTEGRATOR_DEBUG, 0x1a000000, 0);
>
>      dev =3D sysbus_create_varargs("pl181", 0x1c000000, pic[23], pic[24],=
 NULL);
> -    qdev_connect_gpio_out(dev, 0,
> +    qdev_connect_gpio_out_named(dev, "card-read-only", 0,
>                            qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_WPROT=
, 0));
> -    qdev_connect_gpio_out(dev, 1,
> +    qdev_connect_gpio_out_named(dev, "card-inserted", 0,
>                            qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CARDI=
N, 0));
>      sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
>
> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
> index b6c0a1adb9..8dc5f77139 100644
> --- a/hw/arm/realview.c
> +++ b/hw/arm/realview.c
> @@ -234,8 +234,8 @@ static void realview_init(MachineState *machine,
>      mmc_irq[1] =3D qemu_irq_split(
>          qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_CARDIN),
>          qemu_irq_invert(qdev_get_gpio_in(gpio2, 0)));
> -    qdev_connect_gpio_out(dev, 0, mmc_irq[0]);
> -    qdev_connect_gpio_out(dev, 1, mmc_irq[1]);
> +    qdev_connect_gpio_out_named(dev, "card-read-only", 0, mmc_irq[0]);
> +    qdev_connect_gpio_out_named(dev, "card-inserted", 0, mmc_irq[1]);
>
>      sysbus_create_simple("pl031", 0x10017000, pic[10]);
>
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index 5bf9cff8a8..16629d6599 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -624,9 +624,9 @@ static void vexpress_common_init(MachineState *machin=
e)
>
>      dev =3D sysbus_create_varargs("pl181", map[VE_MMCI], pic[9], pic[10]=
, NULL);
>      /* Wire up MMC card detect and read-only signals */
> -    qdev_connect_gpio_out(dev, 0,
> +    qdev_connect_gpio_out_named(dev, "card-read-only", 0,
>                            qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_W=
PROT));
> -    qdev_connect_gpio_out(dev, 1,
> +    qdev_connect_gpio_out_named(dev, "card-inserted", 0,
>                            qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_C=
ARDIN));
>
>      sysbus_create_simple("pl050_keyboard", map[VE_KMI0], pic[12]);
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index 86219c851d..ab4cd733a4 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -60,7 +60,8 @@ typedef struct PL181State {
>      uint32_t fifo[PL181_FIFO_LEN]; /* TODO use Fifo32 */
>      qemu_irq irq[2];
>      /* GPIO outputs for 'card is readonly' and 'card inserted' */
> -    qemu_irq cardstatus[2];
> +    qemu_irq card_readonly;
> +    qemu_irq card_inserted;
>  } PL181State;
>
>  static const VMStateDescription vmstate_pl181 =3D {
> @@ -479,7 +480,7 @@ static void pl181_reset(DeviceState *d)
>      s->mask[1] =3D 0;
>
>      /* We can assume our GPIO outputs have been wired up now */
> -    sd_set_cb(s->card, s->cardstatus[0], s->cardstatus[1]);
> +    sd_set_cb(s->card, s->card_readonly, s->card_inserted);
>      /* Since we're still using the legacy SD API the card is not plugged
>       * into any bus, and we must reset it manually.
>       */
> @@ -496,7 +497,8 @@ static void pl181_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->irq[0]);
>      sysbus_init_irq(sbd, &s->irq[1]);
> -    qdev_init_gpio_out(dev, s->cardstatus, 2);
> +    qdev_init_gpio_out_named(dev, &s->card_readonly, "card-read-only", 1=
);
> +    qdev_init_gpio_out_named(dev, &s->card_inserted, "card-inserted", 1)=
;
>  }
>
>  static void pl181_realize(DeviceState *dev, Error **errp)
> --
> 2.21.3
>
>

