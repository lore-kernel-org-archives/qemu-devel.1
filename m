Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA13C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 07:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDB320C01
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 07:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDB320C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNuUe-0008KL-3R
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 03:26:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hNuTe-0007nS-OK
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hNuTd-00076U-65
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:25:26 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:49656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hNuTc-000766-W3
	for qemu-devel@nongnu.org; Tue, 07 May 2019 03:25:25 -0400
Received: from player787.ha.ovh.net (unknown [10.108.57.14])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 88F5020B7BD
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 09:25:22 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player787.ha.ovh.net (Postfix) with ESMTPSA id 776695945E56;
	Tue,  7 May 2019 07:25:16 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190506142042.28096-1-clg@kaod.org>
	<20190506142042.28096-2-clg@kaod.org>
	<9e9e4978-f010-f1ba-330c-ae51e7e65f0a@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <52d028d6-d5b4-1c9b-b5ab-7a03e1b30466@kaod.org>
Date: Tue, 7 May 2019 09:25:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9e9e4978-f010-f1ba-330c-ae51e7e65f0a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 3666493049215028179
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrjeelgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.43.98
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 4:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi C=C3=A9dric,
>=20
> On 5/6/19 4:20 PM, C=C3=A9dric Le Goater wrote:
>> This will simplify the definition of new SoCs, like the AST2600 which
>> should use a different CPU and a different IRQ number layout.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Changes since v1:
>>
>>  - moved enum defining the Aspeed controller names under aspeed_soc.h
>> =20
>>  include/hw/arm/aspeed_soc.h | 37 ++++++++++++++++++++++++
>>  hw/arm/aspeed_soc.c         | 57 +++++++++++++++++++++++++++++++-----=
-
>>  2 files changed, 86 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>> index 11ec0179db50..2dd968092c69 100644
>> --- a/include/hw/arm/aspeed_soc.h
>> +++ b/include/hw/arm/aspeed_soc.h
>> @@ -57,6 +57,7 @@ typedef struct AspeedSoCInfo {
>>      const char *fmc_typename;
>>      const char **spi_typename;
>>      int wdts_num;
>> +    const int *irqmap;
>>  } AspeedSoCInfo;
>> =20
>>  typedef struct AspeedSoCClass {
>> @@ -69,4 +70,40 @@ typedef struct AspeedSoCClass {
>>  #define ASPEED_SOC_GET_CLASS(obj)                               \
>>      OBJECT_GET_CLASS(AspeedSoCClass, (obj), TYPE_ASPEED_SOC)
>> =20
>> +enum {
>> +    ASPEED_IOMEM,
>> +    ASPEED_UART1,
>> +    ASPEED_UART2,
>> +    ASPEED_UART3,
>> +    ASPEED_UART4,
>> +    ASPEED_UART5,
>> +    ASPEED_VUART,
>> +    ASPEED_FMC,
>> +    ASPEED_SPI1,
>> +    ASPEED_SPI2,
>> +    ASPEED_VIC,
>> +    ASPEED_SDMC,
>> +    ASPEED_SCU,
>> +    ASPEED_ADC,
>> +    ASPEED_SRAM,
>> +    ASPEED_GPIO,
>> +    ASPEED_RTC,
>> +    ASPEED_TIMER1,
>> +    ASPEED_TIMER2,
>> +    ASPEED_TIMER3,
>> +    ASPEED_TIMER4,
>> +    ASPEED_TIMER5,
>> +    ASPEED_TIMER6,
>> +    ASPEED_TIMER7,
>> +    ASPEED_TIMER8,
>> +    ASPEED_WDT,
>> +    ASPEED_PWM,
>> +    ASPEED_LPC,
>> +    ASPEED_IBT,
>> +    ASPEED_I2C,
>> +    ASPEED_ETH1,
>> +    ASPEED_ETH2,
>> +    ASPEED_SDRAM,
>=20
> I'd add ...:
>=20
>        ASPEED_IRQMAP_COUNT /* keep last */
>=20
>> +};
>> +
>>  #endif /* ASPEED_SOC_H */
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index a27233d4876b..29bce5c9188c 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -38,12 +38,42 @@
>>  #define ASPEED_SOC_ETH1_BASE        0x1E660000
>>  #define ASPEED_SOC_ETH2_BASE        0x1E680000
>> =20
>> -static const int uart_irqs[] =3D { 9, 32, 33, 34, 10 };
>> -static const int timer_irqs[] =3D { 16, 17, 18, 35, 36, 37, 38, 39, }=
;
>> +static const int aspeed_soc_ast2400_irqmap[] =3D {
>=20
> ... and use it here:
>=20
> static const int aspeed_soc_ast2400_irqmap[ASPEED_IRQMAP_COUNT] =3D {
>=20
> because you define ASPEED_SDRAM, and if some code access
> aspeed_soc_ast2400_irqmap[ASPEED_SDRAM] it would be uninitialized.

The ASPEED_SDRAM should be initialized in the next patch.

> Specifying the array size, the uninitialized entries are
> zero-initialized (not sure this is the default you expect although).

I am not sure to understand the problem you are describing. I think
the compiler should catch any severe issues.  no ?=20

Thanks,

C.

>=20
>> +    [ASPEED_UART1]  =3D 9,
>> +    [ASPEED_UART2]  =3D 32,
>> +    [ASPEED_UART3]  =3D 33,
>> +    [ASPEED_UART4]  =3D 34,
>> +    [ASPEED_UART5]  =3D 10,
>> +    [ASPEED_VUART]  =3D 8,
>> +    [ASPEED_FMC]    =3D 19,
>> +    [ASPEED_SDMC]   =3D 0,
>> +    [ASPEED_SCU]    =3D 21,
>> +    [ASPEED_ADC]    =3D 31,
>> +    [ASPEED_GPIO]   =3D 20,
>> +    [ASPEED_RTC]    =3D 22,
>> +    [ASPEED_TIMER1] =3D 16,
>> +    [ASPEED_TIMER2] =3D 17,
>> +    [ASPEED_TIMER3] =3D 18,
>> +    [ASPEED_TIMER4] =3D 35,
>> +    [ASPEED_TIMER5] =3D 36,
>> +    [ASPEED_TIMER6] =3D 37,
>> +    [ASPEED_TIMER7] =3D 38,
>> +    [ASPEED_TIMER8] =3D 39,
>> +    [ASPEED_WDT]    =3D 27,
>> +    [ASPEED_PWM]    =3D 28,
>> +    [ASPEED_LPC]    =3D 8,
>> +    [ASPEED_IBT]    =3D 8, /* LPC */
>> +    [ASPEED_I2C]    =3D 12,
>> +    [ASPEED_ETH1]   =3D 2,
>> +    [ASPEED_ETH2]   =3D 3,
>> +};
>> =20
>>  #define AST2400_SDRAM_BASE       0x40000000
>>  #define AST2500_SDRAM_BASE       0x80000000
>> =20
>> +/* AST2500 uses the same IRQs as the AST2400 */
>> +#define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
>> +
>>  static const hwaddr aspeed_soc_ast2400_spi_bases[] =3D { ASPEED_SOC_S=
PI_BASE };
>>  static const char *aspeed_soc_ast2400_typenames[] =3D { "aspeed.smc.s=
pi" };
>> =20
>> @@ -64,6 +94,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>>          .fmc_typename =3D "aspeed.smc.fmc",
>>          .spi_typename =3D aspeed_soc_ast2400_typenames,
>>          .wdts_num     =3D 2,
>> +        .irqmap       =3D aspeed_soc_ast2400_irqmap,
>>      }, {
>>          .name         =3D "ast2400-a1",
>>          .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
>> @@ -75,6 +106,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>>          .fmc_typename =3D "aspeed.smc.fmc",
>>          .spi_typename =3D aspeed_soc_ast2400_typenames,
>>          .wdts_num     =3D 2,
>> +        .irqmap       =3D aspeed_soc_ast2400_irqmap,
>>      }, {
>>          .name         =3D "ast2400",
>>          .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
>> @@ -86,6 +118,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>>          .fmc_typename =3D "aspeed.smc.fmc",
>>          .spi_typename =3D aspeed_soc_ast2400_typenames,
>>          .wdts_num     =3D 2,
>> +        .irqmap       =3D aspeed_soc_ast2400_irqmap,
>>      }, {
>>          .name         =3D "ast2500-a1",
>>          .cpu_type     =3D ARM_CPU_TYPE_NAME("arm1176"),
>> @@ -97,9 +130,17 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>>          .fmc_typename =3D "aspeed.smc.ast2500-fmc",
>>          .spi_typename =3D aspeed_soc_ast2500_typenames,
>>          .wdts_num     =3D 3,
>> +        .irqmap       =3D aspeed_soc_ast2500_irqmap,
>>      },
>>  };
>> =20
>> +static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
>> +{
>> +    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>> +
>> +    return qdev_get_gpio_in(DEVICE(&s->vic), sc->info->irqmap[ctrl]);
>> +}
>> +
>>  static void aspeed_soc_init(Object *obj)
>>  {
>>      AspeedSoCState *s =3D ASPEED_SOC(obj);
>> @@ -226,14 +267,14 @@ static void aspeed_soc_realize(DeviceState *dev,=
 Error **errp)
>>          return;
>>      }
>>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0, ASPEED_SOC_TIME=
R_BASE);
>> -    for (i =3D 0; i < ARRAY_SIZE(timer_irqs); i++) {
>> -        qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&s->vic), timer_irqs=
[i]);
>> +    for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
>> +        qemu_irq irq =3D aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
>>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
>>      }
>> =20
>>      /* UART - attach an 8250 to the IO space as our UART5 */
>>      if (serial_hd(0)) {
>> -        qemu_irq uart5 =3D qdev_get_gpio_in(DEVICE(&s->vic), uart_irq=
s[4]);
>> +        qemu_irq uart5 =3D aspeed_soc_get_irq(s, ASPEED_UART5);
>>          serial_mm_init(get_system_memory(),
>>                         ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE=
, 2,
>>                         uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDI=
AN);
>> @@ -247,7 +288,7 @@ static void aspeed_soc_realize(DeviceState *dev, E=
rror **errp)
>>      }
>>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, ASPEED_SOC_I2C_BASE);
>>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
>> -                       qdev_get_gpio_in(DEVICE(&s->vic), 12));
>> +                       aspeed_soc_get_irq(s, ASPEED_I2C));
>> =20
>>      /* FMC, The number of CS is set at the board level */
>>      object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err)=
;
>> @@ -259,7 +300,7 @@ static void aspeed_soc_realize(DeviceState *dev, E=
rror **errp)
>>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
>>                      s->fmc.ctrl->flash_window_base);
>>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
>> -                       qdev_get_gpio_in(DEVICE(&s->vic), 19));
>> +                       aspeed_soc_get_irq(s, ASPEED_FMC));
>> =20
>>      /* SPI */
>>      for (i =3D 0; i < sc->info->spis_num; i++) {
>> @@ -307,7 +348,7 @@ static void aspeed_soc_realize(DeviceState *dev, E=
rror **errp)
>>      }
>>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1=
_BASE);
>>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
>> -                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
>> +                       aspeed_soc_get_irq(s, ASPEED_ETH1));
>>  }
>> =20
>>  static void aspeed_soc_class_init(ObjectClass *oc, void *data)
>>
>=20
> With the array explicit size:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20


