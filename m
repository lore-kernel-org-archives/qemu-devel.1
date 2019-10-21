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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A142086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqjTxfQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A142086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMeTd-0001sD-4B
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 16:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMeSo-0001SO-5D
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMeSm-00041n-TJ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:39:38 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMeSm-00041U-LC; Mon, 21 Oct 2019 16:39:36 -0400
Received: by mail-lf1-x143.google.com with SMTP id v8so10624304lfa.12;
 Mon, 21 Oct 2019 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ntm1D5h5OfUL8y8PGWbfe0PVJvym9MJEG4JfLC0dxaU=;
 b=GqjTxfQTuRLPQSQnw9O9qZ8xU54QBXnbf16M/Rbf8cbWfaQuMM/s8OnRqOEAxyh6gR
 V1ara2uwGoO15oyGK4Ng0N1YPMDjzNlN/rCTwincftiJ9RHJkTxzSoeuOVFlo0pOtkmP
 t6s6ZIkr5L6SOewQ8ccxDk6tEoAMmaw2tpWuBIp8BY53T2azrHmMxRoS+ZLTQyg8CYK/
 jUfNlUsY2P7Uy93G/D3fBhForQnO+LXqvM0qf9ZrDM4aGjPb2t0yi+bbMPywlGHGzoM+
 Vro6O4dveifhy+FiMpuf5Z/l+L/gXrHMSsN1CeGMp+uoaEc5DgDDduKLEXI82u6OqxKw
 4AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ntm1D5h5OfUL8y8PGWbfe0PVJvym9MJEG4JfLC0dxaU=;
 b=MWQUlDoMbt4Y552LOhBeVJ9t+uNgyOII9aQIC8yUNE//CYFsTdOry5StukDq0WF+V1
 QDNcokFSlmjo9V89Pf6l6XzjrSxMyLTahw6yyMY3dQzsRXLnyBJXCU1QwHSVyYgklqZj
 Lm5qFmAyIOgiyoZKVTvk4rYC1nih+TMlQCtpyQ9JVqaZhTmlWUKAk977F9/Thkoox4Gs
 iMKtBuCdIll7oR8Vk0wwo7kDzUIGQteeCA9TN4DFnjm8ayAe2fCanwQ/U6TuL6U1LxHj
 UiGbC/vQQq7ejjER375TgNtR52JM7Xjetrp/oMAWA/ob9VsGzETyQfTY7I2JiUsTHPVO
 81IQ==
X-Gm-Message-State: APjAAAXigdXhPAqoUN0W2jyYL9z188RTj4ZFsY86Ab9ahA3i2CChtERY
 7yrBeWgvf5qytxQnu9ab2wrFkJqDjIwOY2ZLo6A=
X-Google-Smtp-Source: APXvYqzNnLhvovvuPmcD2f1lrxMOhPp7To6zmkfjgutU8rbKHqZkxFaVV4LcP0C0ZiAfhF7Iay7yMoVqBI5RWH045o8=
X-Received: by 2002:a19:ac01:: with SMTP id g1mr16394192lfc.141.1571690375241; 
 Mon, 21 Oct 2019 13:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <20191019234715.25750-6-f4bug@amsat.org>
In-Reply-To: <20191019234715.25750-6-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 13:34:10 -0700
Message-ID: <CAKmqyKPrjtKomoRuE-Cd7=mK3TuPnFmVyCdg2scvvZNZs8ru-Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] hw/arm/bcm2836: Make the SoC code modular
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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

On Sat, Oct 19, 2019 at 4:50 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> This file creates the BCM2836/BCM2837 blocks.
> The biggest differences with the BCM2838 we are going to add, are
> the base addresses of the interrupt controller and the peripherals.
> Add these addresses in the BCM283XInfo structure to make this
> block more modular. Remove the MCORE_OFFSET offset as it is
> not useful and rather confusing.
>
> Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/bcm2836.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 723aef6bf5..019e67b906 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -16,15 +16,11 @@
>  #include "hw/arm/raspi_platform.h"
>  #include "hw/sysbus.h"
>
> -/* Peripheral base address seen by the CPU */
> -#define BCM2836_PERI_BASE       0x3F000000
> -
> -/* "QA7" (Pi2) interrupt controller and mailboxes etc. */
> -#define BCM2836_CONTROL_BASE    0x40000000
> -
>  struct BCM283XInfo {
>      const char *name;
>      const char *cpu_type;
> +    hwaddr peri_base; /* Peripheral base address seen by the CPU */
> +    hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
>      int clusterid;
>  };
>
> @@ -32,12 +28,16 @@ static const BCM283XInfo bcm283x_socs[] =3D {
>      {
>          .name =3D TYPE_BCM2836,
>          .cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7"),
> +        .peri_base =3D 0x3f000000,
> +        .ctrl_base =3D 0x40000000,
>          .clusterid =3D 0xf,
>      },
>  #ifdef TARGET_AARCH64
>      {
>          .name =3D TYPE_BCM2837,
>          .cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53"),
> +        .peri_base =3D 0x3f000000,
> +        .ctrl_base =3D 0x40000000,
>          .clusterid =3D 0x0,
>      },
>  #endif
> @@ -104,7 +104,7 @@ static void bcm2836_realize(DeviceState *dev, Error *=
*errp)
>      }
>
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
> -                            BCM2836_PERI_BASE, 1);
> +                            info->peri_base, 1);
>
>      /* bcm2836 interrupt controller (and mailboxes, etc.) */
>      object_property_set_bool(OBJECT(&s->control), true, "realized", &err=
);
> @@ -113,7 +113,7 @@ static void bcm2836_realize(DeviceState *dev, Error *=
*errp)
>          return;
>      }
>
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, BCM2836_CONTROL_BASE=
);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
>
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
>          qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
> @@ -126,7 +126,7 @@ static void bcm2836_realize(DeviceState *dev, Error *=
*errp)
>
>          /* set periphbase/CBAR value for CPU-local registers */
>          object_property_set_int(OBJECT(&s->cpus[n]),
> -                                BCM2836_PERI_BASE + MSYNC_OFFSET,
> +                                info->peri_base,
>                                  "reset-cbar", &err);
>          if (err) {
>              error_propagate(errp, err);
> --
> 2.21.0
>
>

