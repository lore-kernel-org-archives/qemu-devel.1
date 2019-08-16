Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA7C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8CB2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8CB2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyeoO-0002az-Qc
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 12:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1hyelj-0000UZ-49
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hyelh-0006z7-Nh
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:07:58 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:43943)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hyelh-0006xZ-HY
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:07:57 -0400
Received: from player771.ha.ovh.net (unknown [10.109.159.154])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5BA1166A6E
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 18:07:55 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id A38588E3EAEF;
 Fri, 16 Aug 2019 16:07:48 +0000 (UTC)
To: Rashmica Gupta <rashmica.g@gmail.com>
References: <20190816073229.22787-1-rashmica.g@gmail.com>
 <20190816073229.22787-3-rashmica.g@gmail.com>
 <4d0aad7fa699a82bcbecb532551827c30c4c0f3d.camel@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <216d4828-580f-4aae-f400-e90f8db0d360@kaod.org>
Date: Fri, 16 Aug 2019 18:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4d0aad7fa699a82bcbecb532551827c30c4c0f3d.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 15337852956821851056
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeffedgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.42.102
Subject: Re: [Qemu-devel] [PATCH v5 2/3] aspeed: add a GPIO controller to
 the SoC
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
Cc: peter.maydell@linaro.org, andrew@aj.id.au, qemu-devel@nongnu.org,
 aik@ozlabs.ru, qemu-arm@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/08/2019 09:40, Rashmica Gupta wrote:
> C=C3=A9dric, this is how I thought changes to the SOC for your aspeed-4=
.1
> branch would look

Some comments,=20
 =20
> From 13a07834476fa266c352d9a075b341c483b2edf9 Mon Sep 17 00:00:00 2001
> From: Rashmica Gupta <rashmica.g@gmail.com>
> Date: Fri, 16 Aug 2019 15:18:22 +1000
> Subject: [PATCH] Aspeed SOC changes
>=20
> ---
>  include/hw/arm/aspeed_soc.h |  4 +++-
>  hw/arm/aspeed_soc.c         | 32 ++++++++++++++++++++++----------
>  2 files changed, 25 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 8673661de8..f375271d5a 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -28,6 +28,7 @@
>  #define ASPEED_WDTS_NUM  3
>  #define ASPEED_CPUS_NUM  2
>  #define ASPEED_MACS_NUM  2
> +#define ASPEED_GPIOS_NUM  2
>
> =20
>  typedef struct AspeedSoCState {
>      /*< private >*/
> @@ -48,7 +49,7 @@ typedef struct AspeedSoCState {
>      AspeedSDMCState sdmc;
>      AspeedWDTState wdt[ASPEED_WDTS_NUM];
>      FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
> -    AspeedGPIOState gpio;
> +    AspeedGPIOState gpio[ASPEED_GPIOS_NUM];

Even if they look the same, I think these are two different controllers=20
and not multiple instances of the same. So I would rather introduce a new=
=20
field 'gpio_1_8v' for the AST2600.=20

>  } AspeedSoCState;
> =20
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -61,6 +62,7 @@ typedef struct AspeedSoCInfo {
>      uint64_t sram_size;
>      int spis_num;
>      int wdts_num;
> +    int gpios_num;
>      const int *irqmap;
>      const hwaddr *memmap;
>      uint32_t num_cpus;
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 7d47647016..414b99c4f3 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -119,6 +119,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>          .sram_size    =3D 0x8000,
>          .spis_num     =3D 1,
>          .wdts_num     =3D 2,
> +        .gpios_num    =3D 1,
>          .irqmap       =3D aspeed_soc_ast2400_irqmap,
>          .memmap       =3D aspeed_soc_ast2400_memmap,
>          .num_cpus     =3D 1,
> @@ -132,6 +133,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>          .irqmap       =3D aspeed_soc_ast2500_irqmap,
>          .memmap       =3D aspeed_soc_ast2500_memmap,
>          .num_cpus     =3D 1,
> +        .gpios_num    =3D 1,
>      },
>  };
> =20
> @@ -226,9 +228,15 @@ static void aspeed_soc_init(Object *obj)
>      sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s-
>> xdma),
>                            TYPE_ASPEED_XDMA);
> =20
> -    snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
> -    sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s-
>> gpio),
> -                          typename);
> +    for (i =3D 0; i < sc->info->gpios_num; i++) {
> +        if (ASPEED_IS_AST2600(sc->info->silicon_rev)) {
> +            snprintf(typename, sizeof(typename), "aspeed.gpio%d-%s",
> i, socname);
> +        } else {
> +            snprintf(typename, sizeof(typename), "aspeed.gpio-%s",
> socname);
> +        }
> +        sysbus_init_child_obj(obj, "gpio[*]", OBJECT(&s->gpio[i]),
> sizeof(s->gpio[i]),
> +                               typename);
> +    }
>  }
> =20
>  static void aspeed_soc_realize(DeviceState *dev, Error **errp)
> @@ -410,15 +418,19 @@ static void aspeed_soc_realize(DeviceState *dev,
> Error **errp)
>                         aspeed_soc_get_irq(s, ASPEED_XDMA));
> =20
>      /* GPIO */
> -    object_property_set_bool(OBJECT(&s->gpio), true, "realized",
> &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> +    for (i =3D 0; i < sc->info->gpios_num; i++) {
> +        hwaddr addr =3D  sc->info->memmap[ASPEED_GPIO] + i * 0x800;

I would introduce ASPEED_GPIO_V1_8V instead.=20

> +        object_property_set_bool(OBJECT(&s->gpio[i]), true,
> "realized", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
> +                           aspeed_soc_get_irq(s, ASPEED_GPIO));

The interrupt is different.

C.=20

>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->info-
>> memmap[ASPEED_GPIO]);
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
> -                       aspeed_soc_get_irq(s, ASPEED_GPIO));
>  }
> +
>  static Property aspeed_soc_properties[] =3D {
>      DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
>      DEFINE_PROP_END_OF_LIST(),
>=20


