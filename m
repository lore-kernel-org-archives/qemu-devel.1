Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9D6C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 09:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A934B206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 09:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A934B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdAKA-000604-1R
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 05:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hdAJ9-0005Sa-OR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hdAJ8-00029R-Hj
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:21:39 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:58597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hdAJ8-00026l-Bf
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:21:38 -0400
Received: from player691.ha.ovh.net (unknown [10.108.54.209])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id BB5EF6D9B7
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 11:21:35 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 6DE2470C8AAB;
 Tue, 18 Jun 2019 09:21:29 +0000 (UTC)
To: Rashmica Gupta <rashmica.g@gmail.com>, qemu-arm@nongnu.org
References: <20190618085154.21498-1-rashmica.g@gmail.com>
 <20190618085154.21498-3-rashmica.g@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <07308eea-1249-98d2-6e3a-d701c97410ee@kaod.org>
Date: Tue, 18 Jun 2019 11:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618085154.21498-3-rashmica.g@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12474689493473135571
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeiledgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.49.171
Subject: Re: [Qemu-devel] [PATCH 2/2] aspeed: add a GPIO controller to the
 SoC
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
Cc: andrew@aj.id.au, qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/06/2019 10:51, Rashmica Gupta wrote:
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> ---
>  hw/arm/aspeed_soc.c         | 17 +++++++++++++++++
>  include/hw/arm/aspeed_soc.h |  3 +++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 1cc98b9f40..8583869acf 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -23,6 +23,7 @@
>  #include "net/net.h"
>  
>  #define ASPEED_SOC_IOMEM_SIZE       0x00200000
> +#define ASPEED_SOC_GPIO_BASE        0x1E780000
>

You should put this value in the memmap array.

C. 


>  static const hwaddr aspeed_soc_ast2400_memmap[] = {
>      [ASPEED_IOMEM]  = 0x1E600000,
> @@ -120,6 +121,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .spis_num     = 1,
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
> +        .gpio_typename = "aspeed.gpio-ast2400",
>          .wdts_num     = 2,
>          .irqmap       = aspeed_soc_ast2400_irqmap,
>          .memmap       = aspeed_soc_ast2400_memmap,
> @@ -131,6 +133,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .spis_num     = 1,
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
> +        .gpio_typename = "aspeed.gpio-ast2400",
>          .wdts_num     = 2,
>          .irqmap       = aspeed_soc_ast2400_irqmap,
>          .memmap       = aspeed_soc_ast2400_memmap,
> @@ -142,6 +145,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .spis_num     = 1,
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
> +        .gpio_typename = "aspeed.gpio-ast2400",
>          .wdts_num     = 2,
>          .irqmap       = aspeed_soc_ast2400_irqmap,
>          .memmap       = aspeed_soc_ast2400_memmap,
> @@ -153,6 +157,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .spis_num     = 2,
>          .fmc_typename = "aspeed.smc.ast2500-fmc",
>          .spi_typename = aspeed_soc_ast2500_typenames,
> +        .gpio_typename = "aspeed.gpio-ast2500",
>          .wdts_num     = 3,
>          .irqmap       = aspeed_soc_ast2500_irqmap,
>          .memmap       = aspeed_soc_ast2500_memmap,
> @@ -225,6 +230,8 @@ static void aspeed_soc_init(Object *obj)
>  
>      sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
>                            sizeof(s->ftgmac100), TYPE_FTGMAC100);
> +    sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s->gpio),
> +                          sc->info->gpio_typename);
>  }
>  
>  static void aspeed_soc_realize(DeviceState *dev, Error **errp)
> @@ -366,6 +373,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>                      sc->info->memmap[ASPEED_ETH1]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
>                         aspeed_soc_get_irq(s, ASPEED_ETH1));
> +
> +    /* GPIO */
> +    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, ASPEED_SOC_GPIO_BASE);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
> +            qdev_get_gpio_in(DEVICE(&s->vic), 20));
>  }
>  
>  static void aspeed_soc_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 88b901d5df..28ff2bedb4 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -20,6 +20,7 @@
>  #include "hw/ssi/aspeed_smc.h"
>  #include "hw/watchdog/wdt_aspeed.h"
>  #include "hw/net/ftgmac100.h"
> +#include "hw/gpio/aspeed_gpio.h"
>  
>  #define ASPEED_SPIS_NUM  2
>  #define ASPEED_WDTS_NUM  3
> @@ -40,6 +41,7 @@ typedef struct AspeedSoCState {
>      AspeedSDMCState sdmc;
>      AspeedWDTState wdt[ASPEED_WDTS_NUM];
>      FTGMAC100State ftgmac100;
> +    AspeedGPIOState gpio;
>  } AspeedSoCState;
>  
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -53,6 +55,7 @@ typedef struct AspeedSoCInfo {
>      int spis_num;
>      const char *fmc_typename;
>      const char **spi_typename;
> +    const char *gpio_typename;
>      int wdts_num;
>      const int *irqmap;
>      const hwaddr *memmap;
> 


