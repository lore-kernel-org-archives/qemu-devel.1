Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C1EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CDE2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CDE2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ief1D-0000U6-QJ
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 07:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ief0U-0008Ox-0M
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ief0S-0001HG-Ji
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:52:49 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:37081)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ief0S-0001Ge-Cl
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:52:48 -0500
Received: from player759.ha.ovh.net (unknown [10.108.54.133])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 2D22011658D
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 13:52:45 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id C375ED2502F3;
 Tue, 10 Dec 2019 12:52:40 +0000 (UTC)
Subject: Re: [PATCH 2/2] hw/arm: ast2600: Wire up the eMMC controller
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
 <5a93d2f9d375f92e9db6b1cf8687f86beaedcbb2.1575938234.git-series.andrew@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d1d53a3f-90ed-4436-59ec-fe3fcc985817@kaod.org>
Date: Tue, 10 Dec 2019 13:52:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5a93d2f9d375f92e9db6b1cf8687f86beaedcbb2.1575938234.git-series.andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10744744289061342016
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelfedggeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.37.72
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
Cc: peter.maydell@linaro.org, joel@jms.id.au, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/2019 01:52, Andrew Jeffery wrote:
> Initialise another SDHCI model instance for the AST2600's eMMC
> controller and use the SDHCI's num_slots value introduced previously to
> determine whether we should create an SD card instance for the new slot.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

LGTM. One comment.

> ---
>  hw/arm/aspeed.c             | 13 +++++++++++++
>  hw/arm/aspeed_ast2600.c     | 21 +++++++++++++++++++++
>  include/hw/arm/aspeed_soc.h |  2 ++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 862549b1f3a9..0e08d62e9ff3 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -272,6 +272,19 @@ static void aspeed_board_init(MachineState *machine,
>          object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
>      }
>  
> +    if (bmc->soc.emmc.num_slots) {
> +        SDHCIState *emmc = &bmc->soc.emmc.slots[0];
> +        DriveInfo *dinfo = drive_get_next(IF_SD);
> +        BlockBackend *blk;
> +        DeviceState *card;
> +
> +        blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> +        card = qdev_create(qdev_get_child_bus(DEVICE(emmc), "sd-bus"),
> +                           TYPE_SD_CARD);
> +        qdev_prop_set_drive(card, "drive", blk, &error_fatal);
> +        object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
> +    }

I think we could use a function for the above ^

C.

>      arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
>  }
>  
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 931ee5aae183..723c8196c8a5 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -46,6 +46,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>      [ASPEED_ADC]       = 0x1E6E9000,
>      [ASPEED_VIDEO]     = 0x1E700000,
>      [ASPEED_SDHCI]     = 0x1E740000,
> +    [ASPEED_EMMC]      = 0x1E750000,
>      [ASPEED_GPIO]      = 0x1E780000,
>      [ASPEED_GPIO_1_8V] = 0x1E780800,
>      [ASPEED_RTC]       = 0x1E781000,
> @@ -64,6 +65,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>  
>  #define ASPEED_SOC_AST2600_MAX_IRQ 128
>  
> +/* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
>  static const int aspeed_soc_ast2600_irqmap[] = {
>      [ASPEED_UART1]     = 47,
>      [ASPEED_UART2]     = 48,
> @@ -77,6 +79,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
>      [ASPEED_ADC]       = 78,
>      [ASPEED_XDMA]      = 6,
>      [ASPEED_SDHCI]     = 43,
> +    [ASPEED_EMMC]      = 15,
>      [ASPEED_GPIO]      = 40,
>      [ASPEED_GPIO_1_8V] = 11,
>      [ASPEED_RTC]       = 13,
> @@ -215,6 +218,14 @@ static void aspeed_soc_ast2600_init(Object *obj)
>          sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]),
>                                sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDHCI);
>      }
> +
> +    sysbus_init_child_obj(obj, "emmc", OBJECT(&s->emmc), sizeof(s->emmc),
> +                          TYPE_ASPEED_SDHCI);
> +
> +    object_property_set_int(OBJECT(&s->emmc), 1, "num-slots", &error_abort);
> +
> +    sysbus_init_child_obj(obj, "emmc[*]", OBJECT(&s->emmc.slots[0]),
> +            sizeof(s->emmc.slots[0]), TYPE_SYSBUS_SDHCI);
>  }
>  
>  /*
> @@ -487,6 +498,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>                      sc->memmap[ASPEED_SDHCI]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
>                         aspeed_soc_get_irq(s, ASPEED_SDHCI));
> +
> +    /* eMMC */
> +    object_property_set_bool(OBJECT(&s->emmc), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emmc), 0, sc->memmap[ASPEED_EMMC]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_EMMC));
>  }
>  
>  static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 495c08be1b84..911443f4c071 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -56,6 +56,7 @@ typedef struct AspeedSoCState {
>      AspeedGPIOState gpio;
>      AspeedGPIOState gpio_1_8v;
>      AspeedSDHCIState sdhci;
> +    AspeedSDHCIState emmc;
>  } AspeedSoCState;
>  
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -125,6 +126,7 @@ enum {
>      ASPEED_MII4,
>      ASPEED_SDRAM,
>      ASPEED_XDMA,
> +    ASPEED_EMMC,
>  };
>  
>  #endif /* ASPEED_SOC_H */
> 


