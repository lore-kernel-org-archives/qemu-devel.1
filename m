Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79275C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA752084D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA752084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsRp-0000TT-Cv
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1hxsQZ-0008H8-RH
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hxsQY-0008W5-LZ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:30:55 -0400
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:50942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hxsQY-0008VY-EG
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:30:54 -0400
Received: from player759.ha.ovh.net (unknown [10.108.57.188])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 798CC223613
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 14:30:52 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 4E6E18E26E40;
 Wed, 14 Aug 2019 12:30:43 +0000 (UTC)
To: Rashmica Gupta <rashmica.g@gmail.com>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20190814071433.22243-1-rashmica.g@gmail.com>
 <20190814071433.22243-3-rashmica.g@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <977d1a64-c9b5-445b-454e-45569c486e1d@kaod.org>
Date: Wed, 14 Aug 2019 14:30:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814071433.22243-3-rashmica.g@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18373560583225773045
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddruddvkedghedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.57.200
Subject: Re: [Qemu-devel] [PATCH v4 2/3] aspeed: add a GPIO controller to
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
Cc: andrew@aj.id.au, aik@ozlabs.ru, qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/08/2019 09:14, Rashmica Gupta wrote:
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> ---
>  hw/arm/aspeed_soc.c         | 17 +++++++++++++++++
>  include/hw/arm/aspeed_soc.h |  3 +++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index c6fb3700f2..ff422c8ad1 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -124,6 +124,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .spis_num     = 1,
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
> +        .gpio_typename = "aspeed.gpio-ast2400",

I suppose this patch is based on mainline and not my tree.

My current patchset has removed all these typenames but that's OK. 
It's a minor change we can handle depending on which patch gets
merged first. 

A part from that, it looks good.

Thanks,

C.

  
>          .wdts_num     = 2,
>          .irqmap       = aspeed_soc_ast2400_irqmap,
>          .memmap       = aspeed_soc_ast2400_memmap,
> @@ -136,6 +137,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .spis_num     = 1,
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
> +        .gpio_typename = "aspeed.gpio-ast2400",
>          .wdts_num     = 2,
>          .irqmap       = aspeed_soc_ast2400_irqmap,
>          .memmap       = aspeed_soc_ast2400_memmap,
> @@ -148,6 +150,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .spis_num     = 1,
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
> +        .gpio_typename = "aspeed.gpio-ast2400",
>          .wdts_num     = 2,
>          .irqmap       = aspeed_soc_ast2400_irqmap,
>          .memmap       = aspeed_soc_ast2400_memmap,
> @@ -160,6 +163,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .spis_num     = 2,
>          .fmc_typename = "aspeed.smc.ast2500-fmc",
>          .spi_typename = aspeed_soc_ast2500_typenames,
> +        .gpio_typename = "aspeed.gpio-ast2500",
>          .wdts_num     = 3,
>          .irqmap       = aspeed_soc_ast2500_irqmap,
>          .memmap       = aspeed_soc_ast2500_memmap,
> @@ -246,6 +250,9 @@ static void aspeed_soc_init(Object *obj)
>  
>      sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
>                            TYPE_ASPEED_XDMA);
> +
> +    sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s->gpio),
> +                          sc->info->gpio_typename);
>  }
>  
>  static void aspeed_soc_realize(DeviceState *dev, Error **errp)
> @@ -425,6 +432,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>                      sc->info->memmap[ASPEED_XDMA]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
>                         aspeed_soc_get_irq(s, ASPEED_XDMA));
> +
> +    /* GPIO */
> +    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->info->memmap[ASPEED_GPIO]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_GPIO));
>  }
>  static Property aspeed_soc_properties[] = {
>      DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index cef605ad6b..fa04abddd8 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -22,6 +22,7 @@
>  #include "hw/ssi/aspeed_smc.h"
>  #include "hw/watchdog/wdt_aspeed.h"
>  #include "hw/net/ftgmac100.h"
> +#include "hw/gpio/aspeed_gpio.h"
>  
>  #define ASPEED_SPIS_NUM  2
>  #define ASPEED_WDTS_NUM  3
> @@ -47,6 +48,7 @@ typedef struct AspeedSoCState {
>      AspeedSDMCState sdmc;
>      AspeedWDTState wdt[ASPEED_WDTS_NUM];
>      FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
> +    AspeedGPIOState gpio;
>  } AspeedSoCState;
>  
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -60,6 +62,7 @@ typedef struct AspeedSoCInfo {
>      int spis_num;
>      const char *fmc_typename;
>      const char **spi_typename;
> +    const char *gpio_typename;
>      int wdts_num;
>      const int *irqmap;
>      const hwaddr *memmap;
> 


