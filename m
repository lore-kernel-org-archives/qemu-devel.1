Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C128CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 00:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C87206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 00:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zon9W1El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C87206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juPm8-0002OK-R4
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 20:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1juPlX-0001iP-W0; Sat, 11 Jul 2020 20:22:48 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1juPlW-0003Wp-85; Sat, 11 Jul 2020 20:22:47 -0400
Received: by mail-oi1-x244.google.com with SMTP id x83so7982494oif.10;
 Sat, 11 Jul 2020 17:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oZ00LcG+6NseoTgPAtEBCbzXEaU2ZdzV1e/l/jb4AMA=;
 b=Zon9W1ElGKBYqP0HaKxRQh/dREXL/+1E99KltdTKfEiraZBjRUviy0LIJ5swp0iRXq
 +ixrsvgNxKfjtFuVR4st9t59dvvyDnYKytJHYXK17ubCnlMb8xWdLYQ4XZeokoEzrbIM
 +9rvumeDN6uvaiAB9z2dOTT2nepgF0bdnskbBXT50cecCHMSAnp2nb3A/tHMGE1F1tVz
 avndKs73h6slC1ya1TzBaHwmbTT6lpkAdiezvOtY3NwEOkIALyUKwPodIBNjdDxM7coo
 dvfBn5CBeOsNKm73yZB6SU19sNSnOFJzsWbmy+feP7ZqTpEV9Wh9S1uxwD63P6YBBsCJ
 1CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oZ00LcG+6NseoTgPAtEBCbzXEaU2ZdzV1e/l/jb4AMA=;
 b=dmzI8TZbfUwZ044KLy2sKztr+YcgBFfzoZsb6romFCay3jZAFqBZMF+tx++nTz29oC
 xOYr7e7+Q3nSO3duzx39sMQD3QOLjZlvzvfAjxlG+jX7X8TCjZoRCD3EZBW5vx0vX5Ai
 SQtJTUonVNBAJWnk23oWL7Wi2+0rK1qMz+mbwyhxdAEO3Tong8aG7CbSg8ohZ/Qd8nL+
 0T1biqdTqXlLLZiXsMgJe15JNGDibPx7KTbwVX65YI2IvKCtmqoZIkaYO5oFeuFlmSy0
 Px64huGp1EiuHiitpHErVe6HxAgTbmNthIxxYAsYg71PGMLF+6F2JJSTarQre2w35f9i
 dEMg==
X-Gm-Message-State: AOAM532e8NP/mKCZE1NMpplCndi0p9teyissGaaA6b9Vn7lF6ledJntW
 dZ8sbybEhRzRBH1hamjK+HdOoss5vvEiTSAq/o4=
X-Google-Smtp-Source: ABdhPJxQJ7AZ2jlGRxlDUwnioKmoTSaZrO0jshutrp1VME047IZzpSa+J3zOhOun18QQQ3OecG/ESfAuqhzCbP1H850=
X-Received: by 2002:a05:6808:486:: with SMTP id
 z6mr9635087oid.56.1594513364731; 
 Sat, 11 Jul 2020 17:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200628214230.2592-1-peter.maydell@linaro.org>
 <20200628214230.2592-3-peter.maydell@linaro.org>
In-Reply-To: <20200628214230.2592-3-peter.maydell@linaro.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 12 Jul 2020 08:22:08 +0800
Message-ID: <CAKXe6SKv_QAeo4g+2n4uYO2cztDvV06adPShT6KEqzBGRJs9BQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/palm.c: Encapsulate misc GPIO handling in a
 device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-arm@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2020=E5=B9=B46=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=885:43=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Replace the free-floating set of IRQs and palmte_onoff_gpios()
> function with a simple QOM device that encapsulates this
> behaviour.
>
> This fixes Coverity issue CID 1421944, which points out that
> the memory returned by qemu_allocate_irqs() is leaked.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/arm/palm.c | 61 +++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 52 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
> index 569836178f6..e7bc9ea4c6a 100644
> --- a/hw/arm/palm.c
> +++ b/hw/arm/palm.c
> @@ -124,6 +124,21 @@ static void palmte_button_event(void *opaque, int ke=
ycode)
>                          !(keycode & 0x80));
>  }
>
> +/*
> + * Encapsulation of some GPIO line behaviour for the Palm board
> + *
> + * QEMU interface:
> + *  + unnamed GPIO inputs 0..6: for the various miscellaneous input line=
s
> + */
> +
> +#define TYPE_PALM_MISC_GPIO "palm-misc-gpio"
> +#define PALM_MISC_GPIO(obj) \
> +    OBJECT_CHECK(PalmMiscGPIOState, (obj), TYPE_PALM_MISC_GPIO)
> +
> +typedef struct PalmMiscGPIOState {
> +    SysBusDevice parent_obj;
> +} PalmMiscGPIOState;
> +
>  static void palmte_onoff_gpios(void *opaque, int line, int level)
>  {
>      switch (line) {
> @@ -151,23 +166,44 @@ static void palmte_onoff_gpios(void *opaque, int li=
ne, int level)
>      }
>  }
>
> +static void palm_misc_gpio_init(Object *obj)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +
> +    qdev_init_gpio_in(dev, palmte_onoff_gpios, 7);
> +}
> +
> +static const TypeInfo palm_misc_gpio_info =3D {
> +    .name =3D TYPE_PALM_MISC_GPIO,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(PalmMiscGPIOState),
> +    .instance_init =3D palm_misc_gpio_init,
> +    /*
> +     * No class init required: device has no internal state so does not
> +     * need to set up reset or vmstate, and has no realize method.
> +     */
> +};
> +
>  static void palmte_gpio_setup(struct omap_mpu_state_s *cpu)
>  {
> -    qemu_irq *misc_gpio;
> +    DeviceState *misc_gpio;
> +
> +    misc_gpio =3D sysbus_create_simple(TYPE_PALM_MISC_GPIO, -1, NULL);
>
>      omap_mmc_handlers(cpu->mmc,
>                      qdev_get_gpio_in(cpu->gpio, PALMTE_MMC_WP_GPIO),
>                      qemu_irq_invert(omap_mpuio_in_get(cpu->mpuio)
>                              [PALMTE_MMC_SWITCH_GPIO]));
>
> -    misc_gpio =3D qemu_allocate_irqs(palmte_onoff_gpios, cpu, 7);
> -    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,     misc_gpi=
o[0]);
> -    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,       misc_gpi=
o[1]);
> -    qdev_connect_gpio_out(cpu->gpio, 11,                        misc_gpi=
o[2]);
> -    qdev_connect_gpio_out(cpu->gpio, 12,                        misc_gpi=
o[3]);
> -    qdev_connect_gpio_out(cpu->gpio, 13,                        misc_gpi=
o[4]);
> -    omap_mpuio_out_set(cpu->mpuio, 1,                           misc_gpi=
o[5]);
> -    omap_mpuio_out_set(cpu->mpuio, 3,                           misc_gpi=
o[6]);
> +    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,
> +                          qdev_get_gpio_in(misc_gpio, 0));
> +    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,
> +                          qdev_get_gpio_in(misc_gpio, 1));
> +    qdev_connect_gpio_out(cpu->gpio, 11, qdev_get_gpio_in(misc_gpio, 2))=
;
> +    qdev_connect_gpio_out(cpu->gpio, 12, qdev_get_gpio_in(misc_gpio, 3))=
;
> +    qdev_connect_gpio_out(cpu->gpio, 13, qdev_get_gpio_in(misc_gpio, 4))=
;
> +    omap_mpuio_out_set(cpu->mpuio, 1, qdev_get_gpio_in(misc_gpio, 5));
> +    omap_mpuio_out_set(cpu->mpuio, 3, qdev_get_gpio_in(misc_gpio, 6));
>
>      /* Reset some inputs to initial state.  */
>      qemu_irq_lower(qdev_get_gpio_in(cpu->gpio, PALMTE_USBDETECT_GPIO));
> @@ -276,3 +312,10 @@ static void palmte_machine_init(MachineClass *mc)
>  }
>
>  DEFINE_MACHINE("cheetah", palmte_machine_init)
> +
> +static void palm_register_types(void)
> +{
> +    type_register_static(&palm_misc_gpio_info);
> +}
> +
> +type_init(palm_register_types)
> --
> 2.20.1
>
>

