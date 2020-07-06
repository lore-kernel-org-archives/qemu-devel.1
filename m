Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A1BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3110420708
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O50exWR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3110420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTnm-0008W1-DV
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsTms-00076T-4E; Mon, 06 Jul 2020 12:16:10 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:38259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsTmq-000619-2U; Mon, 06 Jul 2020 12:16:09 -0400
Received: by mail-il1-x141.google.com with SMTP id s21so18232951ilk.5;
 Mon, 06 Jul 2020 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jmXfsXUcrMyDhuGgwizq9hHr2suvn5ExzLDQJR6dd+k=;
 b=O50exWR2Kb/fmJrXTjWTOo3fBm5a0XJkvO6TkdCPLh9DYEmW+VxnHEJO/+3KvuPqbP
 RsGRsmMiRBVVXXItd09ClyDoqzSH5T07OnBwl646EsIpyAifEu11zR1FGdeUPoFRN+OI
 U/UdZlW7j8+7n837SC8maf4Fuyh3jRCkG4F7883mXw/xVQGdlGQYNxHmyoPsv0dAwGJI
 92aocYgi5Tjqfy2nSVQBFkYmKFj3omqYtchgzNBtjswADIbxO3YPF+jwSI9OxkJIjEL2
 IF64hN/l1FARCtviw1K+84bAH5qJgKdmSMcZiexVugcRCMoniNIs8EWT2CRWelnn5vmM
 IRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jmXfsXUcrMyDhuGgwizq9hHr2suvn5ExzLDQJR6dd+k=;
 b=Et0zIyS1EAs8LKpBtlJGiAIqH1pO6u5AcSQ/1RbcPFgW2E/d/quaPbOQXOpDXHXCxK
 uXkoJ07CmHlzdb4Fm2vrT9Uzjg6vAfwb2po8+Hpe9Se8IxFaVMEcNx2hty8qEF0tpkRe
 LsNoYyUG/NVbsI0qTDNuBSEWWV+HQ72+R9J5r4MOYpfGpBwWWJSrfQO3GU+PyFMZpc86
 4ehFjm06aeXAFV9tO0i8c53A3JFZRhIeVQJPB7+nN0W2mmn3Io1w++SXD7BBGHeWCSoG
 BoY/OuO6mak3HZkxazvef6tsV01alCSSautzXD2DCaD0CMaqhMfeNGOHOlnDWdh8UkJq
 Ru5A==
X-Gm-Message-State: AOAM530H9xPEgy8zKQ4cVy8kfZw2t8X4EdyoFTb29qmV3Mp6rriaHpHX
 A8XzBtB7Co0P4GRREoDTmCEHPfulVYNf9yHqPVA=
X-Google-Smtp-Source: ABdhPJzExAX8s6Woh8/JFOEL/tSpfoTOZznYmhO54jDwwWcLjSOY9xD+7+uWD/S/O9RzluWVpsSA+xb1qz/UZ/f9Kik=
X-Received: by 2002:a92:bb84:: with SMTP id x4mr32007885ilk.177.1594052166361; 
 Mon, 06 Jul 2020 09:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200705204630.4133-1-f4bug@amsat.org>
 <20200705204630.4133-8-f4bug@amsat.org>
In-Reply-To: <20200705204630.4133-8-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:06:19 -0700
Message-ID: <CAKmqyKOuSuaaf547WtR84Y5gqC0XTJfykPD_Xv5VFuJu1HeOTQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] hw/sd/pl181: Do not create SD card within the
 SDHCI controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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

On Sun, Jul 5, 2020 at 1:52 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> SDHCI controllers provide a SD Bus to plug SD cards, but don't
> come with SD card plugged in :) Let the machine/board object
> create and plug the SD cards when required.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/integratorcp.c | 13 +++++++++++++
>  hw/arm/realview.c     | 12 ++++++++++++
>  hw/arm/versatilepb.c  | 26 ++++++++++++++++++++++++--
>  hw/arm/vexpress.c     | 11 +++++++++++
>  hw/sd/pl181.c         | 19 +------------------
>  5 files changed, 61 insertions(+), 20 deletions(-)
>
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index 2595e4d052..9bf25945d2 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -25,6 +25,7 @@
>  #include "hw/char/pl011.h"
>  #include "hw/hw.h"
>  #include "hw/irq.h"
> +#include "hw/sd/sd.h"
>
>  #define TYPE_INTEGRATOR_CM "integrator_core"
>  #define INTEGRATOR_CM(obj) \
> @@ -595,6 +596,7 @@ static void integratorcp_init(MachineState *machine)
>      MemoryRegion *ram_alias =3D g_new(MemoryRegion, 1);
>      qemu_irq pic[32];
>      DeviceState *dev, *sic, *icp;
> +    DriveInfo *dinfo;
>      int i;
>
>      cpuobj =3D object_new(machine->cpu_type);
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
> +
>      sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
>
>      if (nd_table[0].used)
> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
> index 8dc5f77139..4df8ea4fce 100644
> --- a/hw/arm/realview.c
> +++ b/hw/arm/realview.c
> @@ -27,6 +27,7 @@
>  #include "hw/intc/realview_gic.h"
>  #include "hw/irq.h"
>  #include "hw/i2c/arm_sbcon_i2c.h"
> +#include "hw/sd/sd.h"
>
>  #define SMP_BOOT_ADDR 0xe0000000
>  #define SMP_BOOTREG_ADDR 0x10000030
> @@ -69,6 +70,7 @@ static void realview_init(MachineState *machine,
>      qemu_irq mmc_irq[2];
>      PCIBus *pci_bus =3D NULL;
>      NICInfo *nd;
> +    DriveInfo *dinfo;
>      I2CBus *i2c;
>      int n;
>      unsigned int smp_cpus =3D machine->smp.cpus;
> @@ -236,6 +238,16 @@ static void realview_init(MachineState *machine,
>          qemu_irq_invert(qdev_get_gpio_in(gpio2, 0)));
>      qdev_connect_gpio_out_named(dev, "card-read-only", 0, mmc_irq[0]);
>      qdev_connect_gpio_out_named(dev, "card-inserted", 0, mmc_irq[1]);
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
>
>      sysbus_create_simple("pl031", 0x10017000, pic[10]);
>
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index 45a13ae2b9..7fb9da5a47 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -25,6 +25,7 @@
>  #include "hw/block/flash.h"
>  #include "qemu/error-report.h"
>  #include "hw/char/pl011.h"
> +#include "hw/sd/sd.h"
>
>  #define VERSATILE_FLASH_ADDR 0x34000000
>  #define VERSATILE_FLASH_SIZE (64 * 1024 * 1024)
> @@ -309,10 +310,31 @@ static void versatile_init(MachineState *machine, i=
nt board_id)
>      /* Wire up the mux control signals from the SYS_CLCD register */
>      qdev_connect_gpio_out(sysctl, 0, qdev_get_gpio_in(dev, 0));
>
> -    sysbus_create_varargs("pl181", 0x10005000, sic[22], sic[1], NULL);
> +    dev =3D sysbus_create_varargs("pl181", 0x10005000, sic[22], sic[1], =
NULL);
>      /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
> -    sysbus_create_varargs("pl181", 0x1000b000, sic[23], sic[2], NULL);
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
> +
> +    dev =3D sysbus_create_varargs("pl181", 0x1000b000, sic[23], sic[2], =
NULL);
>      /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
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
>
>      /* Add PL031 Real Time Clock. */
>      sysbus_create_simple("pl031", 0x101e8000, pic[10]);
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index 16629d6599..a2f70588bd 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -43,6 +43,7 @@
>  #include "hw/cpu/a9mpcore.h"
>  #include "hw/cpu/a15mpcore.h"
>  #include "hw/i2c/arm_sbcon_i2c.h"
> +#include "hw/sd/sd.h"
>
>  #define VEXPRESS_BOARD_ID 0x8e0
>  #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
> @@ -628,6 +629,16 @@ static void vexpress_common_init(MachineState *machi=
ne)
>                            qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_W=
PROT));
>      qdev_connect_gpio_out_named(dev, "card-inserted", 0,
>                            qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_C=
ARDIN));
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
>
>      sysbus_create_simple("pl050_keyboard", map[VE_KMI0], pic[12]);
>      sysbus_create_simple("pl050_mouse", map[VE_KMI1], pic[13]);
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index f6de06ece8..f69488ebac 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -17,7 +17,6 @@
>  #include "qemu/module.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> -#include "hw/qdev-properties.h"
>
>  //#define DEBUG_PL181 1
>
> @@ -518,30 +517,14 @@ static void pl181_init(Object *obj)
>                          TYPE_PL181_BUS, dev, "sd-bus");
>  }
>
> -static void pl181_realize(DeviceState *dev, Error **errp)
> -{
> -    DeviceState *card;
> -    DriveInfo *dinfo;
> -
> -    /* FIXME use a qdev drive property instead of drive_get_next() */
> -    card =3D qdev_new(TYPE_SD_CARD);
> -    dinfo =3D drive_get_next(IF_SD);
> -    qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
> -                            &error_fatal);
> -    qdev_realize_and_unref(card,
> -                           qdev_get_child_bus(dev, "sd-bus"),
> -                           &error_fatal);
> -}
> -
>  static void pl181_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *k =3D DEVICE_CLASS(klass);
>
>      k->vmsd =3D &vmstate_pl181;
>      k->reset =3D pl181_reset;
> -    /* Reason: init() method uses drive_get_next() */
> +    /* Reason: output IRQs should be wired up */
>      k->user_creatable =3D false;
> -    k->realize =3D pl181_realize;
>  }
>
>  static const TypeInfo pl181_info =3D {
> --
> 2.21.3
>
>

