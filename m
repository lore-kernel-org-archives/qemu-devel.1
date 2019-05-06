Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA65C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FFD2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FFD2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57713 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNeyC-000262-6T
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:51:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hNex2-0001SS-Iu
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hNex1-0000E5-0R
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:50:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hNex0-0000Ci-PH
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:50:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id k16so17661725wrn.5
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 07:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=oGddhxqcGt3p26qoRePJnhgVFPOuUtvhSFY+L6/APkc=;
	b=AIExdU8EjoyatF0TlcGpKelbkLMZ7lkB9RgGb96FKOCBMEEv7pg2mfhEK/elVUkoN7
	wZtk+k/ayvsat0yY4xyuGPTX6+9uvLlVjw9OPg4ah8X41c6TkPP4HzcJrPZAYvIneavG
	lTdf9u/F5h4OkydO8ZJDEjl/tByBnUA/wH2YfcfXKhKssDJMA37wnqCnocrQR0wBuPkO
	B3RAs+RqMxwq+MLfOqkDHPlo+QJYSYI/kgaTuh9lHzplJr+8PK73F+I+d9cBj/gFlKLA
	0ynoUqrJmV/wG+jhGoCNbMMliL4KnMryu7GqlNqVb4d50CepNUZcLpDsTnpfpIihVnOZ
	rrrA==
X-Gm-Message-State: APjAAAWVhB4PcQfW+nSmYa3bl0m/1r7t8g1FlxgcpLkesQiV8+Lh+4gX
	mDL6q0BDXTyFtGy/8TE5gB+96xaEMe5J1k3LpGP8yw==
X-Google-Smtp-Source: APXvYqzjz0MV13bkJnC3WvF6XpOag4CTOYZNwKyZxamV+0RHqc/enuRFLSZ5HHbeITtiK/9ELB7U9x212aB8k2/ByoQ=
X-Received: by 2002:a5d:6189:: with SMTP id j9mr17756370wru.176.1557154240679; 
	Mon, 06 May 2019 07:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190506142042.28096-1-clg@kaod.org>
	<20190506142042.28096-2-clg@kaod.org>
	<9e9e4978-f010-f1ba-330c-ae51e7e65f0a@redhat.com>
In-Reply-To: <9e9e4978-f010-f1ba-330c-ae51e7e65f0a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 6 May 2019 16:50:29 +0200
Message-ID: <CAP+75-X8FCjcvQLTM8mVM8dT5BmCE1xmonHQpyusPEShyv9tzQ@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 1/3] aspeed: add a per SoC mapping for
 the interrupt space
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 6, 2019 at 4:48 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
> On 5/6/19 4:20 PM, C=C3=A9dric Le Goater wrote:
> > This will simplify the definition of new SoCs, like the AST2600 which
> > should use a different CPU and a different IRQ number layout.
> >
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > ---
> >
> >  Changes since v1:
> >
> >  - moved enum defining the Aspeed controller names under aspeed_soc.h
> >
> >  include/hw/arm/aspeed_soc.h | 37 ++++++++++++++++++++++++
> >  hw/arm/aspeed_soc.c         | 57 +++++++++++++++++++++++++++++++------
> >  2 files changed, 86 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> > index 11ec0179db50..2dd968092c69 100644
> > --- a/include/hw/arm/aspeed_soc.h
> > +++ b/include/hw/arm/aspeed_soc.h
> > @@ -57,6 +57,7 @@ typedef struct AspeedSoCInfo {
> >      const char *fmc_typename;
> >      const char **spi_typename;
> >      int wdts_num;
> > +    const int *irqmap;
> >  } AspeedSoCInfo;
> >
> >  typedef struct AspeedSoCClass {
> > @@ -69,4 +70,40 @@ typedef struct AspeedSoCClass {
> >  #define ASPEED_SOC_GET_CLASS(obj)                               \
> >      OBJECT_GET_CLASS(AspeedSoCClass, (obj), TYPE_ASPEED_SOC)
> >
> > +enum {
> > +    ASPEED_IOMEM,
> > +    ASPEED_UART1,
> > +    ASPEED_UART2,
> > +    ASPEED_UART3,
> > +    ASPEED_UART4,
> > +    ASPEED_UART5,
> > +    ASPEED_VUART,
> > +    ASPEED_FMC,
> > +    ASPEED_SPI1,
> > +    ASPEED_SPI2,
> > +    ASPEED_VIC,
> > +    ASPEED_SDMC,
> > +    ASPEED_SCU,
> > +    ASPEED_ADC,
> > +    ASPEED_SRAM,
> > +    ASPEED_GPIO,
> > +    ASPEED_RTC,
> > +    ASPEED_TIMER1,
> > +    ASPEED_TIMER2,
> > +    ASPEED_TIMER3,
> > +    ASPEED_TIMER4,
> > +    ASPEED_TIMER5,
> > +    ASPEED_TIMER6,
> > +    ASPEED_TIMER7,
> > +    ASPEED_TIMER8,
> > +    ASPEED_WDT,
> > +    ASPEED_PWM,
> > +    ASPEED_LPC,
> > +    ASPEED_IBT,
> > +    ASPEED_I2C,
> > +    ASPEED_ETH1,
> > +    ASPEED_ETH2,
> > +    ASPEED_SDRAM,
>
> I'd add ...:
>
>        ASPEED_IRQMAP_COUNT /* keep last */

Better name after reading patch 2/3: ASPEED_MODULE_COUNT?

> > +};
> > +
> >  #endif /* ASPEED_SOC_H */
> > diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> > index a27233d4876b..29bce5c9188c 100644
> > --- a/hw/arm/aspeed_soc.c
> > +++ b/hw/arm/aspeed_soc.c
> > @@ -38,12 +38,42 @@
> >  #define ASPEED_SOC_ETH1_BASE        0x1E660000
> >  #define ASPEED_SOC_ETH2_BASE        0x1E680000
> >
> > -static const int uart_irqs[] =3D { 9, 32, 33, 34, 10 };
> > -static const int timer_irqs[] =3D { 16, 17, 18, 35, 36, 37, 38, 39, };
> > +static const int aspeed_soc_ast2400_irqmap[] =3D {
>
> ... and use it here:
>
> static const int aspeed_soc_ast2400_irqmap[ASPEED_IRQMAP_COUNT] =3D {
>
> because you define ASPEED_SDRAM, and if some code access
> aspeed_soc_ast2400_irqmap[ASPEED_SDRAM] it would be uninitialized.
> Specifying the array size, the uninitialized entries are
> zero-initialized (not sure this is the default you expect although).
>
> > +    [ASPEED_UART1]  =3D 9,
> > +    [ASPEED_UART2]  =3D 32,
> > +    [ASPEED_UART3]  =3D 33,
> > +    [ASPEED_UART4]  =3D 34,
> > +    [ASPEED_UART5]  =3D 10,
> > +    [ASPEED_VUART]  =3D 8,
> > +    [ASPEED_FMC]    =3D 19,
> > +    [ASPEED_SDMC]   =3D 0,
> > +    [ASPEED_SCU]    =3D 21,
> > +    [ASPEED_ADC]    =3D 31,
> > +    [ASPEED_GPIO]   =3D 20,
> > +    [ASPEED_RTC]    =3D 22,
> > +    [ASPEED_TIMER1] =3D 16,
> > +    [ASPEED_TIMER2] =3D 17,
> > +    [ASPEED_TIMER3] =3D 18,
> > +    [ASPEED_TIMER4] =3D 35,
> > +    [ASPEED_TIMER5] =3D 36,
> > +    [ASPEED_TIMER6] =3D 37,
> > +    [ASPEED_TIMER7] =3D 38,
> > +    [ASPEED_TIMER8] =3D 39,
> > +    [ASPEED_WDT]    =3D 27,
> > +    [ASPEED_PWM]    =3D 28,
> > +    [ASPEED_LPC]    =3D 8,
> > +    [ASPEED_IBT]    =3D 8, /* LPC */
> > +    [ASPEED_I2C]    =3D 12,
> > +    [ASPEED_ETH1]   =3D 2,
> > +    [ASPEED_ETH2]   =3D 3,
> > +};
> >
> >  #define AST2400_SDRAM_BASE       0x40000000
> >  #define AST2500_SDRAM_BASE       0x80000000
> >
> > +/* AST2500 uses the same IRQs as the AST2400 */
> > +#define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
> > +
> >  static const hwaddr aspeed_soc_ast2400_spi_bases[] =3D { ASPEED_SOC_SP=
I_BASE };
> >  static const char *aspeed_soc_ast2400_typenames[] =3D { "aspeed.smc.sp=
i" };
> >
> > @@ -64,6 +94,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
> >          .fmc_typename =3D "aspeed.smc.fmc",
> >          .spi_typename =3D aspeed_soc_ast2400_typenames,
> >          .wdts_num     =3D 2,
> > +        .irqmap       =3D aspeed_soc_ast2400_irqmap,
> >      }, {
> >          .name         =3D "ast2400-a1",
> >          .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
> > @@ -75,6 +106,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
> >          .fmc_typename =3D "aspeed.smc.fmc",
> >          .spi_typename =3D aspeed_soc_ast2400_typenames,
> >          .wdts_num     =3D 2,
> > +        .irqmap       =3D aspeed_soc_ast2400_irqmap,
> >      }, {
> >          .name         =3D "ast2400",
> >          .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
> > @@ -86,6 +118,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
> >          .fmc_typename =3D "aspeed.smc.fmc",
> >          .spi_typename =3D aspeed_soc_ast2400_typenames,
> >          .wdts_num     =3D 2,
> > +        .irqmap       =3D aspeed_soc_ast2400_irqmap,
> >      }, {
> >          .name         =3D "ast2500-a1",
> >          .cpu_type     =3D ARM_CPU_TYPE_NAME("arm1176"),
> > @@ -97,9 +130,17 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
> >          .fmc_typename =3D "aspeed.smc.ast2500-fmc",
> >          .spi_typename =3D aspeed_soc_ast2500_typenames,
> >          .wdts_num     =3D 3,
> > +        .irqmap       =3D aspeed_soc_ast2500_irqmap,
> >      },
> >  };
> >
> > +static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
> > +{
> > +    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
> > +
> > +    return qdev_get_gpio_in(DEVICE(&s->vic), sc->info->irqmap[ctrl]);
> > +}
> > +
> >  static void aspeed_soc_init(Object *obj)
> >  {
> >      AspeedSoCState *s =3D ASPEED_SOC(obj);
> > @@ -226,14 +267,14 @@ static void aspeed_soc_realize(DeviceState *dev, =
Error **errp)
> >          return;
> >      }
> >      sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0, ASPEED_SOC_TIMER=
_BASE);
> > -    for (i =3D 0; i < ARRAY_SIZE(timer_irqs); i++) {
> > -        qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&s->vic), timer_irqs[=
i]);
> > +    for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
> > +        qemu_irq irq =3D aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
> >          sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
> >      }
> >
> >      /* UART - attach an 8250 to the IO space as our UART5 */
> >      if (serial_hd(0)) {
> > -        qemu_irq uart5 =3D qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs=
[4]);
> > +        qemu_irq uart5 =3D aspeed_soc_get_irq(s, ASPEED_UART5);
> >          serial_mm_init(get_system_memory(),
> >                         ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE,=
 2,
> >                         uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIA=
N);
> > @@ -247,7 +288,7 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
> >      }
> >      sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, ASPEED_SOC_I2C_BASE);
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
> > -                       qdev_get_gpio_in(DEVICE(&s->vic), 12));
> > +                       aspeed_soc_get_irq(s, ASPEED_I2C));
> >
> >      /* FMC, The number of CS is set at the board level */
> >      object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
> > @@ -259,7 +300,7 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
> >      sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
> >                      s->fmc.ctrl->flash_window_base);
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
> > -                       qdev_get_gpio_in(DEVICE(&s->vic), 19));
> > +                       aspeed_soc_get_irq(s, ASPEED_FMC));
> >
> >      /* SPI */
> >      for (i =3D 0; i < sc->info->spis_num; i++) {
> > @@ -307,7 +348,7 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
> >      }
> >      sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_=
BASE);
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
> > -                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
> > +                       aspeed_soc_get_irq(s, ASPEED_ETH1));
> >  }
> >
> >  static void aspeed_soc_class_init(ObjectClass *oc, void *data)
> >
>
> With the array explicit size:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

