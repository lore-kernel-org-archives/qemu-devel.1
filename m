Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 00:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DE02070B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 00:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDqAqq2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DE02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juPiv-0000u1-Sk
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 20:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1juPiE-00009E-SE; Sat, 11 Jul 2020 20:19:22 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:44601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1juPiD-000396-8N; Sat, 11 Jul 2020 20:19:22 -0400
Received: by mail-oo1-xc43.google.com with SMTP id o36so1688521ooi.11;
 Sat, 11 Jul 2020 17:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9cPmQGTSAin+ostGOfnapRULbeSJoIJ3JP1SIdBHZbc=;
 b=gDqAqq2a60yT5D3G8IZNlrzhoJknRclLX9kFVb02zPFqOSz3M/t/C/D2dasSJyvFFC
 /KTVizx+cRDUnV+ZBoBmxAFEhExumxkoumFw9Mj2YX1JZJsrceC+ntmSIJp3FvkOXYwa
 EI6p0tOLTAxqr2STJqlLN9r6eEPHsZEfuN9snidFPeX3osSiwBEDRwG1C/R+ydiMFfpa
 2i/74TjGLb9/ynkp9edVFooXkEZmIFertH5j+mZuUUqjeXc5m90CY6GxxT21UUn9iXkO
 4yn3lVR1VkAlUkrpE7iHFcxH8v9N123LUdvd68G3sfRx3Qyt/lEDjpgW7plyH6v3S4fU
 zJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9cPmQGTSAin+ostGOfnapRULbeSJoIJ3JP1SIdBHZbc=;
 b=EayEIMCUQek36YvaHZPqutNesu9od8La0khTPQdpqF8hM5Jz42C3YBNhXIAyvI4F6U
 9wrlmychjoMUhX6XhT/Z6Wgck7Z19A7WP9HHCOOOZwB9PKwVlO4AqhaAAZwHpMQo1p00
 cYLPqE9YLIs/sZ7FkuUF/mJThE3oE9kvdix6Pcndh+l7nDjKga5xnuwob9+/pXlun0FO
 TKhPDNkOq5wJoeXkVXfXVZLH11ZZnOFo6AYfYrm+7W+XGAcOjDlIvU+BgK14PFtGMVqi
 +yPOtFTvq6x+VIhE2mdF0Wh2Lvk8o4a+Gto1CS1oaytDXKdLFjjk9LlkicgPghvd+0LH
 aDow==
X-Gm-Message-State: AOAM531XrsFu8qBq7VAF7aUZgHjkQDfFQMQIAGRe+6OoeXRtZVmG0oCm
 XKid6EIFJONOORDxuYWY3PKsUdvnPtEl9v/txL8=
X-Google-Smtp-Source: ABdhPJwCvOaHVMZQOziIwX3wFE9cnx8hDUithFixgd3tSmNzUl/ZCW2zBVvwiZKR4eg28QUYLRk9/8rg1gw+kTcRVS0=
X-Received: by 2002:a4a:8257:: with SMTP id t23mr65770171oog.60.1594513159338; 
 Sat, 11 Jul 2020 17:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200628214230.2592-1-peter.maydell@linaro.org>
 <20200628214230.2592-2-peter.maydell@linaro.org>
In-Reply-To: <20200628214230.2592-2-peter.maydell@linaro.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 12 Jul 2020 08:18:43 +0800
Message-ID: <CAKXe6SJts9hBWrFCZY8+fa+2iqEoH-5N9rfTeUA8th=sOq46MQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm/palm.c: Detabify
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc43.google.com
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
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=885:45=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Remove hard-tabs from palm.c.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/arm/palm.c | 64 +++++++++++++++++++++++++--------------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
> index 97ca105d297..569836178f6 100644
> --- a/hw/arm/palm.c
> +++ b/hw/arm/palm.c
> @@ -61,21 +61,21 @@ static const MemoryRegionOps static_ops =3D {
>  /* Palm Tunsgten|E support */
>
>  /* Shared GPIOs */
> -#define PALMTE_USBDETECT_GPIO  0
> -#define PALMTE_USB_OR_DC_GPIO  1
> -#define PALMTE_TSC_GPIO                4
> -#define PALMTE_PINTDAV_GPIO    6
> -#define PALMTE_MMC_WP_GPIO     8
> -#define PALMTE_MMC_POWER_GPIO  9
> -#define PALMTE_HDQ_GPIO                11
> -#define PALMTE_HEADPHONES_GPIO 14
> -#define PALMTE_SPEAKER_GPIO    15
> +#define PALMTE_USBDETECT_GPIO   0
> +#define PALMTE_USB_OR_DC_GPIO   1
> +#define PALMTE_TSC_GPIO                 4
> +#define PALMTE_PINTDAV_GPIO     6
> +#define PALMTE_MMC_WP_GPIO      8
> +#define PALMTE_MMC_POWER_GPIO   9
> +#define PALMTE_HDQ_GPIO                 11
> +#define PALMTE_HEADPHONES_GPIO  14
> +#define PALMTE_SPEAKER_GPIO     15
>  /* MPU private GPIOs */
> -#define PALMTE_DC_GPIO         2
> -#define PALMTE_MMC_SWITCH_GPIO 4
> -#define PALMTE_MMC1_GPIO       6
> -#define PALMTE_MMC2_GPIO       7
> -#define PALMTE_MMC3_GPIO       11
> +#define PALMTE_DC_GPIO          2
> +#define PALMTE_MMC_SWITCH_GPIO  4
> +#define PALMTE_MMC1_GPIO        6
> +#define PALMTE_MMC2_GPIO        7
> +#define PALMTE_MMC3_GPIO        11
>
>  static MouseTransformInfo palmte_pointercal =3D {
>      .x =3D 320,
> @@ -100,17 +100,17 @@ static struct {
>      int column;
>  } palmte_keymap[0x80] =3D {
>      [0 ... 0x7f] =3D { -1, -1 },
> -    [0x3b] =3D { 0, 0 }, /* F1   -> Calendar */
> -    [0x3c] =3D { 1, 0 }, /* F2   -> Contacts */
> -    [0x3d] =3D { 2, 0 }, /* F3   -> Tasks List */
> -    [0x3e] =3D { 3, 0 }, /* F4   -> Note Pad */
> -    [0x01] =3D { 4, 0 }, /* Esc  -> Power */
> -    [0x4b] =3D { 0, 1 }, /*         Left */
> -    [0x50] =3D { 1, 1 }, /*         Down */
> -    [0x48] =3D { 2, 1 }, /*         Up */
> -    [0x4d] =3D { 3, 1 }, /*         Right */
> -    [0x4c] =3D { 4, 1 }, /*         Centre */
> -    [0x39] =3D { 4, 1 }, /* Spc  -> Centre */
> +    [0x3b] =3D { 0, 0 },  /* F1   -> Calendar */
> +    [0x3c] =3D { 1, 0 },  /* F2   -> Contacts */
> +    [0x3d] =3D { 2, 0 },  /* F3   -> Tasks List */
> +    [0x3e] =3D { 3, 0 },  /* F4   -> Note Pad */
> +    [0x01] =3D { 4, 0 },  /* Esc  -> Power */
> +    [0x4b] =3D { 0, 1 },  /*         Left */
> +    [0x50] =3D { 1, 1 },  /*         Down */
> +    [0x48] =3D { 2, 1 },  /*         Up */
> +    [0x4d] =3D { 3, 1 },  /*         Right */
> +    [0x4c] =3D { 4, 1 },  /*         Centre */
> +    [0x39] =3D { 4, 1 },  /* Spc  -> Centre */
>  };
>
>  static void palmte_button_event(void *opaque, int keycode)
> @@ -161,13 +161,13 @@ static void palmte_gpio_setup(struct omap_mpu_state=
_s *cpu)
>                              [PALMTE_MMC_SWITCH_GPIO]));
>
>      misc_gpio =3D qemu_allocate_irqs(palmte_onoff_gpios, cpu, 7);
> -    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,    misc_gpio=
[0]);
> -    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,      misc_gpio=
[1]);
> -    qdev_connect_gpio_out(cpu->gpio, 11,                       misc_gpio=
[2]);
> -    qdev_connect_gpio_out(cpu->gpio, 12,                       misc_gpio=
[3]);
> -    qdev_connect_gpio_out(cpu->gpio, 13,                       misc_gpio=
[4]);
> -    omap_mpuio_out_set(cpu->mpuio, 1,                          misc_gpio=
[5]);
> -    omap_mpuio_out_set(cpu->mpuio, 3,                          misc_gpio=
[6]);
> +    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,     misc_gpi=
o[0]);
> +    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,       misc_gpi=
o[1]);
> +    qdev_connect_gpio_out(cpu->gpio, 11,                        misc_gpi=
o[2]);
> +    qdev_connect_gpio_out(cpu->gpio, 12,                        misc_gpi=
o[3]);
> +    qdev_connect_gpio_out(cpu->gpio, 13,                        misc_gpi=
o[4]);
> +    omap_mpuio_out_set(cpu->mpuio, 1,                           misc_gpi=
o[5]);
> +    omap_mpuio_out_set(cpu->mpuio, 3,                           misc_gpi=
o[6]);
>
>      /* Reset some inputs to initial state.  */
>      qemu_irq_lower(qdev_get_gpio_in(cpu->gpio, PALMTE_USBDETECT_GPIO));
> --
> 2.20.1
>
>

