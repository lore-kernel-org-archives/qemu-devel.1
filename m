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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE18CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A53D2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeWMgas5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A53D2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMefV-0006P0-Bq
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 16:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMeeJ-0005op-H4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMeeI-0000ge-CX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:51:31 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMeeI-0000g4-4h; Mon, 21 Oct 2019 16:51:30 -0400
Received: by mail-lf1-x144.google.com with SMTP id i15so3782034lfo.7;
 Mon, 21 Oct 2019 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5WTtVVZz6t5sWIGl2Jfdn7rDBCgffyrAuKWjQK/IjzI=;
 b=GeWMgas5UcKKGD8GULjfaTE6fRUIL02TA9Fzx0HjgHQrzryK6BiP3x+gU6aKRjNTGd
 ICjAUNUyzt3AptqDpWlsYc/Qwl4BXTkaA30b+tmw1c/d7oZqiSyA6wFItBRXMeDczpMx
 4tXBSNfgp+LSyk6Lz+Vj9PAAwUAM8J56jL0jaqp98i1kMQ4g39+PkkCuLoLyy+IH2zYp
 Hn7l/qr2rF/4IN+5KGC/zbTbh7NYz3bbqJ+stQ++jm5N3mwVJ+aFnfgeLZXB4stMxzCj
 FIyXMstBjM0tSGfYNiaDCOhvSsCLkj/Oh7pJdwb2BEA0yM2bOJfRCoTGYB8or1V6LJW0
 TfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5WTtVVZz6t5sWIGl2Jfdn7rDBCgffyrAuKWjQK/IjzI=;
 b=IKde1U1PoktLdku0YtCE7boOwdTfYwikk8fxGYGaMaaWJRP8wWvb1GuNX8ZuuZCvP8
 tWscdkpqeqzFBaL5SfLqUcNiQzF+dEOPlVASC2iTujT2aUFMZkna7J8S6NJXG/zniZqQ
 PAAn9sgH0/3z8NGyMTWDBrUQii/Ji1E9c6LMY5mDSOTWrVwo47b3QjDH8Rcwr5pQSTm0
 LyWr92qungT7KDQlhTHInVdS1MeYLD+9sXTMEWkXsa8tj2N7V8JJH7t85RIeTFuxAn9e
 TBzVFhXXGaGQ2FjuaR4uD+5N6JE7Ly2GMAk9QQz8IQ/7nBL9Go4nxUZ6UF7lU+QQzgWa
 vKgA==
X-Gm-Message-State: APjAAAW6EUmi7NhWoN7BCYcxFhnyMi15C7LG47tDiKtgp341yri6t5g0
 QUOLANGVuQ9PPHSWS0X5gQj8n7SmMuUMhMs1qnI=
X-Google-Smtp-Source: APXvYqxfPAwubeYyyNtTScuTUOMFhUtAO2wtpRmicKm2KBlCvQu3okTbMHS0lxfdZ75nzH+XIgU2IruOqAhbAXIZsMc=
X-Received: by 2002:ac2:5688:: with SMTP id 8mr846813lfr.156.1571691088195;
 Mon, 21 Oct 2019 13:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <20191019234715.25750-7-f4bug@amsat.org>
In-Reply-To: <20191019234715.25750-7-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 13:46:10 -0700
Message-ID: <CAKmqyKP7GAPZU=Ncc1snttgQ5EQHZZcJPiGUJh6CtkreSE3NrA@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] hw/arm/bcm2836: Rename cpus[] as cpu[].core
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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

On Sat, Oct 19, 2019 at 4:49 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> As we are going to add more core-specific fields, add a 'cpu'
> structure and move the ARMCPU field there as 'core'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/bcm2836.c         | 26 ++++++++++++++------------
>  include/hw/arm/bcm2836.h |  4 +++-
>  2 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 019e67b906..221ff06895 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -51,8 +51,9 @@ static void bcm2836_init(Object *obj)
>      int n;
>
>      for (n =3D 0; n < BCM283X_NCPUS; n++) {
> -        object_initialize_child(obj, "cpu[*]", &s->cpus[n], sizeof(s->cp=
us[n]),
> -                                info->cpu_type, &error_abort, NULL);
> +        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
> +                                sizeof(s->cpu[n].core), info->cpu_type,
> +                                &error_abort, NULL);
>      }
>
>      sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control=
),
> @@ -122,10 +123,10 @@ static void bcm2836_realize(DeviceState *dev, Error=
 **errp)
>
>      for (n =3D 0; n < BCM283X_NCPUS; n++) {
>          /* TODO: this should be converted to a property of ARM_CPU */
> -        s->cpus[n].mp_affinity =3D (info->clusterid << 8) | n;
> +        s->cpu[n].core.mp_affinity =3D (info->clusterid << 8) | n;
>
>          /* set periphbase/CBAR value for CPU-local registers */
> -        object_property_set_int(OBJECT(&s->cpus[n]),
> +        object_property_set_int(OBJECT(&s->cpu[n].core),
>                                  info->peri_base,
>                                  "reset-cbar", &err);
>          if (err) {
> @@ -134,14 +135,15 @@ static void bcm2836_realize(DeviceState *dev, Error=
 **errp)
>          }
>
>          /* start powered off if not enabled */
> -        object_property_set_bool(OBJECT(&s->cpus[n]), n >=3D s->enabled_=
cpus,
> +        object_property_set_bool(OBJECT(&s->cpu[n].core), n >=3D s->enab=
led_cpus,
>                                   "start-powered-off", &err);
>          if (err) {
>              error_propagate(errp, err);
>              return;
>          }
>
> -        object_property_set_bool(OBJECT(&s->cpus[n]), true, "realized", =
&err);
> +        object_property_set_bool(OBJECT(&s->cpu[n].core), true,
> +                                 "realized", &err);
>          if (err) {
>              error_propagate(errp, err);
>              return;
> @@ -149,18 +151,18 @@ static void bcm2836_realize(DeviceState *dev, Error=
 **errp)
>
>          /* Connect irq/fiq outputs from the interrupt controller. */
>          qdev_connect_gpio_out_named(DEVICE(&s->control), "irq", n,
> -                qdev_get_gpio_in(DEVICE(&s->cpus[n]), ARM_CPU_IRQ));
> +                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_IRQ));
>          qdev_connect_gpio_out_named(DEVICE(&s->control), "fiq", n,
> -                qdev_get_gpio_in(DEVICE(&s->cpus[n]), ARM_CPU_FIQ));
> +                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_FIQ));
>
>          /* Connect timers from the CPU to the interrupt controller */
> -        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_PHYS,
> +        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_PHYS,
>                  qdev_get_gpio_in_named(DEVICE(&s->control), "cntpnsirq",=
 n));
> -        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_VIRT,
> +        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_VIRT,
>                  qdev_get_gpio_in_named(DEVICE(&s->control), "cntvirq", n=
));
> -        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_HYP,
> +        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_HYP,
>                  qdev_get_gpio_in_named(DEVICE(&s->control), "cnthpirq", =
n));
> -        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_SEC,
> +        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_SEC,
>                  qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", =
n));
>      }
>  }
> diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
> index 97187f72be..92a6544816 100644
> --- a/include/hw/arm/bcm2836.h
> +++ b/include/hw/arm/bcm2836.h
> @@ -35,7 +35,9 @@ typedef struct BCM283XState {
>      char *cpu_type;
>      uint32_t enabled_cpus;
>
> -    ARMCPU cpus[BCM283X_NCPUS];
> +    struct {
> +        ARMCPU core;
> +    } cpu[BCM283X_NCPUS];
>      BCM2836ControlState control;
>      BCM2835PeripheralState peripherals;
>  } BCM283XState;
> --
> 2.21.0
>
>

