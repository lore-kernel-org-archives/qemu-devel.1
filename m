Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04C3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BDB20882
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 23:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeIusKIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BDB20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMh0b-000526-OW
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 19:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMgzt-0004Hc-4o
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMgzr-0008G4-S6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 19:21:57 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMgzr-0008EO-Kb; Mon, 21 Oct 2019 19:21:55 -0400
Received: by mail-lj1-x241.google.com with SMTP id q78so2266lje.5;
 Mon, 21 Oct 2019 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ymyDcWCkCuddsYs1BhHDz4vL8exwnWFox1xI8IHDN1I=;
 b=XeIusKIiDRvYnncKObsPUUarrnjjnidqAoUrGBzEvvKxP3dP7Y2GIghAINcZNxIKNn
 PezvDUo2hhV00kui/LyWjTPrih+Hb414XiJD+2WICgz19ja9EGP5qasrqEIYC85bSmnU
 XJbrE9glPdRC+Yrio83gv2aSTeWvqhRte0NqfemJWRNoL2FoalpBYOucl93y6QtRkEDb
 aT0HIp8nON8hS+2hG5gJnlRCcAH23vP2r90ibE5YAZekBOqsvYkMjSEmjm8SrB3ErAgP
 TXeyuAc1dGm8dExe0EXVYNwGLelJPeazujhkV/ztf+WzfMdxshUGV+dAqKoMTYDnFYIs
 7f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ymyDcWCkCuddsYs1BhHDz4vL8exwnWFox1xI8IHDN1I=;
 b=SP9ixbNTF5FeUG7GqQ7H6l3lLB4v3RPV3+rZvqQFYAw4mXTqONn58VR8+/icaeK+Pa
 hIMar1FTKpp69ExpLT+X6YqebD2Wuhv0zRz3nfqJrsxUrvo8os+WaDtv77yDzUo59KhI
 1bVlfvAy9FwJ6li/SnCl4lineDea+tV9Po2acScrHr5g2k49kDGhJIou5Mz80PWJ7KvT
 ztJPNF0ItYGYoZeoEZwpJd9mjwfR+ukXj4Hn2Dux7ey10vCj1pqsfCht+mjwbnpUhNSh
 N7mTHkRESH+MtDXn6IoK5ED+GgVumJ1AlXtI4cFBWvOA5Ed9+aPUWZTvFrNxZTb4vJrS
 GlUw==
X-Gm-Message-State: APjAAAV5wF3w8kx1pwalnNObTKPbZQTm6lhN0pJrG4EmCqA7dLbf9IK8
 U3j0KEMK28jKk8xwuDzspuqoNX9UQQOyToRfDzE=
X-Google-Smtp-Source: APXvYqwNssyYWW0ZVtpPtmiNqlO7FT+mopgIOh4Mzf8UOZEK2ilNcQN3sfo1naG5bUQcPbFinK7z2/pbQ1kp9ebf/H0=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr16370839ljm.7.1571700114294; 
 Mon, 21 Oct 2019 16:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <20191019234715.25750-9-f4bug@amsat.org>
In-Reply-To: <20191019234715.25750-9-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 16:16:38 -0700
Message-ID: <CAKmqyKOP_ufTVnEBxKc2ZKALpYc2A=qi0A40Xv0C2bCOKA1-zg@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] hw/arm/bcm2835_peripherals: Add const link
 property in realize()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 4:53 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> The VideoCore GPU is indenpendant from the Peripheral block. In
> the next commit, we will move its instantiation to the SoC block.
> The "gpu-bus" object will not be accessible in init() but later
> in realize(). As a preliminary step to keep the diff clearer, move
> the const link property creation from init() to realize().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/bcm2835_peripherals.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 17207ae07e..d51e9c8def 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -82,9 +82,6 @@ static void bcm2835_peripherals_init(Object *obj)
>      object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-=
size",
>                                &error_abort);
>
> -    object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
> -                                   OBJECT(&s->gpu_bus_mr), &error_abort)=
;
> -
>      /* Property channel */
>      sysbus_init_child_obj(obj, "property", &s->property, sizeof(s->prope=
rty),
>                            TYPE_BCM2835_PROPERTY);
> @@ -93,8 +90,6 @@ static void bcm2835_peripherals_init(Object *obj)
>
>      object_property_add_const_link(OBJECT(&s->property), "fb",
>                                     OBJECT(&s->fb), &error_abort);
> -    object_property_add_const_link(OBJECT(&s->property), "dma-mr",
> -                                   OBJECT(&s->gpu_bus_mr), &error_abort)=
;
>
>      /* Random Number Generator */
>      sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
> @@ -112,9 +107,6 @@ static void bcm2835_peripherals_init(Object *obj)
>      sysbus_init_child_obj(obj, "dma", &s->dma, sizeof(s->dma),
>                            TYPE_BCM2835_DMA);
>
> -    object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
> -                                   OBJECT(&s->gpu_bus_mr), &error_abort)=
;
> -
>      /* Thermal */
>      sysbus_init_child_obj(obj, "thermal", &s->thermal, sizeof(s->thermal=
),
>                            TYPE_BCM2835_THERMAL);
> @@ -156,6 +148,7 @@ static void bcm2835_peripherals_realize(DeviceState *=
dev, Error **errp)
>      memory_region_add_subregion_overlap(&s->gpu_bus_mr, BCM2835_VC_PERI_=
BASE,
>                                          &s->peri_mr_alias, 1);
>
> +    obj =3D OBJECT(&s->gpu_bus_mr);
>      /* RAM is aliased four times (different cache configurations) on the=
 GPU */
>      for (n =3D 0; n < 4; n++) {
>          memory_region_init_alias(&s->ram_alias[n], OBJECT(s),
> @@ -236,6 +229,12 @@ static void bcm2835_peripherals_realize(DeviceState =
*dev, Error **errp)
>          return;
>      }
>
> +    object_property_add_const_link(OBJECT(&s->fb), "dma-mr", obj, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
>      object_property_set_uint(OBJECT(&s->fb), ram_size - vcram_size,
>                               "vcram-base", &err);
>      if (err) {
> @@ -255,6 +254,11 @@ static void bcm2835_peripherals_realize(DeviceState =
*dev, Error **errp)
>                         qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_FB=
));
>
>      /* Property channel */
> +    object_property_add_const_link(OBJECT(&s->property), "dma-mr", obj, =
&err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&s->property), true, "realized", &er=
r);
>      if (err) {
>          error_propagate(errp, err);
> @@ -323,6 +327,11 @@ static void bcm2835_peripherals_realize(DeviceState =
*dev, Error **errp)
>                                 INTERRUPT_SDIO));
>
>      /* DMA Channels */
> +    object_property_add_const_link(OBJECT(&s->dma), "dma-mr", obj, &err)=
;
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&s->dma), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
> --
> 2.21.0
>
>

