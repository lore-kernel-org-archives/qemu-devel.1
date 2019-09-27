Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB8CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729FF2082F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+rw58Xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729FF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDyGe-00062J-Kj
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 17:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDyDj-0003w8-2f
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDyDh-0006GH-Tf
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:56:10 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:37524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDyDh-0006DB-M2; Fri, 27 Sep 2019 17:56:09 -0400
Received: by mail-lj1-x244.google.com with SMTP id l21so3901397lje.4;
 Fri, 27 Sep 2019 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+CPKxPVVDfhT0cAoc/B31bv7euMHESRzMG7B3a7nxHI=;
 b=A+rw58XpcojTsfMnbGf1OyM49U7JXN+m6O60Q3XScyxbUJMqCOdWeBnkmqVuluRs/V
 xsJ40A6TahdX42LbVMLoctRgUSCb6Ap7APfgOf6FzWvrsshXMGipFpOvlXHmqVyowoef
 i63iYOXgQvII8mRVMkOrZLRyinTvzb0AUfPfe1/ZuFH3yWbfw/QC5z/FKmiZc9VTauQC
 yRXLq6bkuUg7Z5/B5HokmdZ6e/AOu889WkQFKHQRX6jMHk4sNOQGO7cUnCNJYiwWuR7J
 hRTnAo4wF15IjLiDyA7jv74Flxkzm3ne7u40Fk/gupyfikHGBgRgoQSZqVgiu5ZqHj9C
 pDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+CPKxPVVDfhT0cAoc/B31bv7euMHESRzMG7B3a7nxHI=;
 b=p57AmytgAFMs3lZgKgwUeF8yFAQJHexohF6sLjrrcZm1AL3BASQweSe5N0SbWZRsme
 ctk0/IQeFDWiSxySurmplGYm4/x815Z7YsBE6/AudsijZUIyjKJkJ4dqKWxwEarhZYcH
 HlBIU7H+Ooz5TIDX6Yn0f8njJkWYdnl+zxe+DqyO2OWtZpzmGBGz8h2/x7nUUETXE5S8
 L8CpJI5PAG9AtQnPaJgrMJkkowtoGodVAQeaPNO3fCgScSlGwCikYHRq3mBc2dag3twb
 B7FkwLtWjnDv1ht4uepdAg/OTfxdsYbyVBX/58mvu2+ZQ7Kn/X4Enmg2z4pR/mfO6uHI
 +klQ==
X-Gm-Message-State: APjAAAWStaRDOAvkiy6KfSa9bVuoUSwmRTbXH0bL0stNSk8IrCNx8ZGz
 iBN041/bAoQImNBOvUGPIHOO6lgaiByrSi7yymY=
X-Google-Smtp-Source: APXvYqw4OYxkEITnsxWr/AxXprnY1icqVLXtkLzNFO49YPAKogyi4YFgCzoBLkymHnvrm3TM7ky56/kB3P4/3EUTO70=
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr4365011ljg.146.1569621368224; 
 Fri, 27 Sep 2019 14:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-10-f4bug@amsat.org>
In-Reply-To: <20190926173428.10713-10-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Sep 2019 14:51:17 -0700
Message-ID: <CAKmqyKP0vtp26B1rmyZYM4QXe8pJQ_nqX-NpLeqZDwTThOWjUw@mail.gmail.com>
Subject: Re: [PATCH 09/19] hw/arm/bcm2835_peripherals: Use the thermal sensor
 block
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
 =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 10:42 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Map the thermal sensor in the BCM2835 block.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/bcm2835_peripherals.c         | 13 +++++++++++++
>  include/hw/arm/bcm2835_peripherals.h |  2 ++
>  include/hw/arm/raspi_platform.h      |  1 +
>  3 files changed, 16 insertions(+)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index fdcf616c56..70bf927a02 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -111,6 +111,10 @@ static void bcm2835_peripherals_init(Object *obj)
>      object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
>                                     OBJECT(&s->gpu_bus_mr), &error_abort)=
;
>
> +    /* Thermal */
> +    sysbus_init_child_obj(obj, "thermal", &s->thermal, sizeof(s->thermal=
),
> +                          TYPE_BCM2835_THERMAL);
> +
>      /* GPIO */
>      sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
>                            TYPE_BCM2835_GPIO);
> @@ -321,6 +325,15 @@ static void bcm2835_peripherals_realize(DeviceState =
*dev, Error **errp)
>                                                    INTERRUPT_DMA0 + n));
>      }
>
> +    /* THERMAL */
> +    object_property_set_bool(OBJECT(&s->thermal), true, "realized", &err=
);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(&s->peri_mr, THERMAL_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0));
> +
>      /* GPIO */
>      object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
>      if (err) {
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm283=
5_peripherals.h
> index 62a4c7b559..be7ad9b499 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -20,6 +20,7 @@
>  #include "hw/misc/bcm2835_property.h"
>  #include "hw/misc/bcm2835_rng.h"
>  #include "hw/misc/bcm2835_mbox.h"
> +#include "hw/misc/bcm2835_thermal.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/sd/bcm2835_sdhost.h"
>  #include "hw/gpio/bcm2835_gpio.h"
> @@ -53,6 +54,7 @@ typedef struct BCM2835PeripheralState {
>      SDHCIState sdhci;
>      BCM2835SDHostState sdhost;
>      BCM2835GpioState gpio;
> +    Bcm2835ThermalState thermal;
>      UnimplementedDeviceState i2s;
>      UnimplementedDeviceState spi[1];
>      UnimplementedDeviceState i2c[3];
> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platf=
orm.h
> index cdcbca943f..61b04a1bd4 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -48,6 +48,7 @@
>  #define SPI0_OFFSET             0x204000
>  #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
>  #define OTP_OFFSET              0x20f000
> +#define THERMAL_OFFSET          0x212000
>  #define BSC_SL_OFFSET           0x214000 /* SPI slave */
>  #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
>  #define EMMC1_OFFSET            0x300000
> --
> 2.20.1
>
>

