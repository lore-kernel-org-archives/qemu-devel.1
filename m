Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB15C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A902053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A902053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNf0Y-0003us-Qi
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:54:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNezH-00033Y-7B
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNezF-0001Vh-8i
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:53:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNez6-0001Eo-Ry
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:52:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id f2so10658759wmj.3
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 07:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=D1jJSz2wFM6BrJc0G4JoeRns+cDHD2HOZwclska++RY=;
	b=VtL7hS2KnCl9EHrVXaDRzxoi45LaSsAaNfFPVy/e8bFlL/6Z5gDbvzuofYCt3S3frC
	p2G5lvM60F75V/8CbBx2mZPgbPLi0VhByYERR7JCF+2+34ccT1dATIie05CDcU+tOxld
	byYcNC7Z8VAovICVvZmmQf8PvT1cavtv46v8sAt5nmUWEc4m2Ej+EiQ/+/aaFPX3P4Qx
	3unFQnntSrblPoOiGu/ohDP4ta/LqZl1wlei93BVPC9hrnY+i0iOeue8dVnHyR5nlhJL
	KqJapbcSwD5Fc5J5LluNsUYVsa8ave7u6TV0XkD4yptQnkJIA7H+z10TIW/NXbYPZPXA
	JY/A==
X-Gm-Message-State: APjAAAVw6bgwrxnSmdjzjlQqJs6VWoUv7P1uGK1ceSo/scbFv5kCYBJC
	7RbQCjQI+rLWePiIEr/6rsGi9w==
X-Google-Smtp-Source: APXvYqypYVQBOlDCw0c92PMg8LRlPtwec2oB9GHV3UkxhMjkTOPqiQOBEorGnRpBP7ktb3EG8AX+AQ==
X-Received: by 2002:a05:600c:d1:: with SMTP id u17mr9446105wmm.2.1557154365127;
	Mon, 06 May 2019 07:52:45 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	o6sm19679108wrh.55.2019.05.06.07.52.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 07:52:43 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190506142042.28096-1-clg@kaod.org>
	<20190506142042.28096-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <709186a4-10d4-dc03-f95c-7822161853e6@redhat.com>
Date: Mon, 6 May 2019 16:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506142042.28096-3-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 2/3] aspeed: add a per SoC mapping for
 the memory space
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



On 5/6/19 4:20 PM, Cédric Le Goater wrote:
> This will simplify the definition of new SoCs, like the AST2600 which
> should use a slightly different address space and have a different set
> of controllers.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  Changes since v1:
> 
>  - removed AspeedSoCInfo 'sdram_base' field
>  - fixed clang compilation
> 
>  include/hw/arm/aspeed_soc.h |   3 +-
>  hw/arm/aspeed.c             |   8 +--
>  hw/arm/aspeed_soc.c         | 117 ++++++++++++++++++++++--------------
>  3 files changed, 77 insertions(+), 51 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 2dd968092c69..70fa1c5a3887 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -50,14 +50,13 @@ typedef struct AspeedSoCInfo {
>      const char *name;
>      const char *cpu_type;
>      uint32_t silicon_rev;
> -    hwaddr sdram_base;
>      uint64_t sram_size;
>      int spis_num;
> -    const hwaddr *spi_bases;
>      const char *fmc_typename;
>      const char **spi_typename;
>      int wdts_num;
>      const int *irqmap;
> +    const hwaddr *memmap;
>  } AspeedSoCInfo;
>  
>  typedef struct AspeedSoCClass {
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index eb434d9bae27..ef92eb2a7028 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -191,8 +191,8 @@ static void aspeed_board_init(MachineState *machine,
>                                          &error_abort);
>  
>      memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_size);
> -    memory_region_add_subregion(get_system_memory(), sc->info->sdram_base,
> -                                &bmc->ram);
> +    memory_region_add_subregion(get_system_memory(),
> +                                sc->info->memmap[ASPEED_SDRAM], &bmc->ram);
>      object_property_add_const_link(OBJECT(&bmc->soc), "ram", OBJECT(&bmc->ram),
>                                     &error_abort);
>  
> @@ -201,7 +201,7 @@ static void aspeed_board_init(MachineState *machine,
>      memory_region_init_io(&bmc->max_ram, NULL, &max_ram_ops, NULL,
>                            "max_ram", max_ram_size  - ram_size);
>      memory_region_add_subregion(get_system_memory(),
> -                                sc->info->sdram_base + ram_size,
> +                                sc->info->memmap[ASPEED_SDRAM] + ram_size,
>                                  &bmc->max_ram);
>  
>      aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abort);
> @@ -236,7 +236,7 @@ static void aspeed_board_init(MachineState *machine,
>      aspeed_board_binfo.initrd_filename = machine->initrd_filename;
>      aspeed_board_binfo.kernel_cmdline = machine->kernel_cmdline;
>      aspeed_board_binfo.ram_size = ram_size;
> -    aspeed_board_binfo.loader_start = sc->info->sdram_base;
> +    aspeed_board_binfo.loader_start = sc->info->memmap[ASPEED_SDRAM];
>  
>      if (cfg->i2c_init) {
>          cfg->i2c_init(bmc);
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 29bce5c9188c..bd83618ceba9 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -22,21 +22,58 @@
>  #include "hw/i2c/aspeed_i2c.h"
>  #include "net/net.h"
>  
> -#define ASPEED_SOC_UART_5_BASE      0x00184000
>  #define ASPEED_SOC_IOMEM_SIZE       0x00200000
> -#define ASPEED_SOC_IOMEM_BASE       0x1E600000
> -#define ASPEED_SOC_FMC_BASE         0x1E620000
> -#define ASPEED_SOC_SPI_BASE         0x1E630000
> -#define ASPEED_SOC_SPI2_BASE        0x1E631000
> -#define ASPEED_SOC_VIC_BASE         0x1E6C0000
> -#define ASPEED_SOC_SDMC_BASE        0x1E6E0000
> -#define ASPEED_SOC_SCU_BASE         0x1E6E2000
> -#define ASPEED_SOC_SRAM_BASE        0x1E720000
> -#define ASPEED_SOC_TIMER_BASE       0x1E782000
> -#define ASPEED_SOC_WDT_BASE         0x1E785000
> -#define ASPEED_SOC_I2C_BASE         0x1E78A000
> -#define ASPEED_SOC_ETH1_BASE        0x1E660000
> -#define ASPEED_SOC_ETH2_BASE        0x1E680000
> +
> +static const hwaddr aspeed_soc_ast2400_memmap[] = {

static const hwaddr aspeed_soc_ast2400_memmap[ASPEED_MODULE_COUNT] = {...

> +    [ASPEED_IOMEM]  = 0x1E600000,
> +    [ASPEED_FMC]    = 0x1E620000,
> +    [ASPEED_SPI1]   = 0x1E630000,
> +    [ASPEED_VIC]    = 0x1E6C0000,
> +    [ASPEED_SDMC]   = 0x1E6E0000,
> +    [ASPEED_SCU]    = 0x1E6E2000,
> +    [ASPEED_ADC]    = 0x1E6E9000,
> +    [ASPEED_SRAM]   = 0x1E720000,
> +    [ASPEED_GPIO]   = 0x1E780000,
> +    [ASPEED_RTC]    = 0x1E781000,
> +    [ASPEED_TIMER1] = 0x1E782000,
> +    [ASPEED_WDT]    = 0x1E785000,
> +    [ASPEED_PWM]    = 0x1E786000,
> +    [ASPEED_LPC]    = 0x1E789000,
> +    [ASPEED_IBT]    = 0x1E789140,
> +    [ASPEED_I2C]    = 0x1E78A000,
> +    [ASPEED_ETH1]   = 0x1E660000,
> +    [ASPEED_ETH2]   = 0x1E680000,
> +    [ASPEED_UART1]  = 0x1E783000,
> +    [ASPEED_UART5]  = 0x1E784000,
> +    [ASPEED_VUART]  = 0x1E787000,
> +    [ASPEED_SDRAM]  = 0x40000000,
> +};
> +
> +static const hwaddr aspeed_soc_ast2500_memmap[] = {

Ditto.

> +    [ASPEED_IOMEM]  = 0x1E600000,
> +    [ASPEED_FMC]    = 0x1E620000,
> +    [ASPEED_SPI1]   = 0x1E630000,
> +    [ASPEED_SPI2]   = 0x1E631000,
> +    [ASPEED_VIC]    = 0x1E6C0000,
> +    [ASPEED_SDMC]   = 0x1E6E0000,
> +    [ASPEED_SCU]    = 0x1E6E2000,
> +    [ASPEED_ADC]    = 0x1E6E9000,
> +    [ASPEED_SRAM]   = 0x1E720000,
> +    [ASPEED_GPIO]   = 0x1E780000,
> +    [ASPEED_RTC]    = 0x1E781000,
> +    [ASPEED_TIMER1] = 0x1E782000,
> +    [ASPEED_WDT]    = 0x1E785000,
> +    [ASPEED_PWM]    = 0x1E786000,
> +    [ASPEED_LPC]    = 0x1E789000,
> +    [ASPEED_IBT]    = 0x1E789140,
> +    [ASPEED_I2C]    = 0x1E78A000,
> +    [ASPEED_ETH1]   = 0x1E660000,
> +    [ASPEED_ETH2]   = 0x1E680000,
> +    [ASPEED_UART1]  = 0x1E783000,
> +    [ASPEED_UART5]  = 0x1E784000,
> +    [ASPEED_VUART]  = 0x1E787000,
> +    [ASPEED_SDRAM]  = 0x80000000,
> +};
>  
>  static const int aspeed_soc_ast2400_irqmap[] = {
>      [ASPEED_UART1]  = 9,
> @@ -68,17 +105,9 @@ static const int aspeed_soc_ast2400_irqmap[] = {
>      [ASPEED_ETH2]   = 3,
>  };
>  
> -#define AST2400_SDRAM_BASE       0x40000000
> -#define AST2500_SDRAM_BASE       0x80000000
> -
> -/* AST2500 uses the same IRQs as the AST2400 */
>  #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
>  
> -static const hwaddr aspeed_soc_ast2400_spi_bases[] = { ASPEED_SOC_SPI_BASE };
>  static const char *aspeed_soc_ast2400_typenames[] = { "aspeed.smc.spi" };
> -
> -static const hwaddr aspeed_soc_ast2500_spi_bases[] = { ASPEED_SOC_SPI_BASE,
> -                                                       ASPEED_SOC_SPI2_BASE};
>  static const char *aspeed_soc_ast2500_typenames[] = {
>      "aspeed.smc.ast2500-spi1", "aspeed.smc.ast2500-spi2" };
>  
> @@ -87,50 +116,46 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .name         = "ast2400-a0",
>          .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
>          .silicon_rev  = AST2400_A0_SILICON_REV,
> -        .sdram_base   = AST2400_SDRAM_BASE,
>          .sram_size    = 0x8000,
>          .spis_num     = 1,
> -        .spi_bases    = aspeed_soc_ast2400_spi_bases,
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
>          .wdts_num     = 2,
>          .irqmap       = aspeed_soc_ast2400_irqmap,
> +        .memmap       = aspeed_soc_ast2400_memmap,
>      }, {
>          .name         = "ast2400-a1",
>          .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
>          .silicon_rev  = AST2400_A1_SILICON_REV,
> -        .sdram_base   = AST2400_SDRAM_BASE,
>          .sram_size    = 0x8000,
>          .spis_num     = 1,
> -        .spi_bases    = aspeed_soc_ast2400_spi_bases,
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
>          .wdts_num     = 2,
>          .irqmap       = aspeed_soc_ast2400_irqmap,
> +        .memmap       = aspeed_soc_ast2400_memmap,
>      }, {
>          .name         = "ast2400",
>          .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
>          .silicon_rev  = AST2400_A0_SILICON_REV,
> -        .sdram_base   = AST2400_SDRAM_BASE,
>          .sram_size    = 0x8000,
>          .spis_num     = 1,
> -        .spi_bases    = aspeed_soc_ast2400_spi_bases,
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
>          .wdts_num     = 2,
>          .irqmap       = aspeed_soc_ast2400_irqmap,
> +        .memmap       = aspeed_soc_ast2400_memmap,
>      }, {
>          .name         = "ast2500-a1",
>          .cpu_type     = ARM_CPU_TYPE_NAME("arm1176"),
>          .silicon_rev  = AST2500_A1_SILICON_REV,
> -        .sdram_base   = AST2500_SDRAM_BASE,
>          .sram_size    = 0x9000,
>          .spis_num     = 2,
> -        .spi_bases    = aspeed_soc_ast2500_spi_bases,
>          .fmc_typename = "aspeed.smc.ast2500-fmc",
>          .spi_typename = aspeed_soc_ast2500_typenames,
>          .wdts_num     = 3,
>          .irqmap       = aspeed_soc_ast2500_irqmap,
> +        .memmap       = aspeed_soc_ast2500_memmap,
>      },
>  };
>  
> @@ -220,8 +245,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      Error *err = NULL, *local_err = NULL;
>  
>      /* IO space */
> -    create_unimplemented_device("aspeed_soc.io",
> -                                ASPEED_SOC_IOMEM_BASE, ASPEED_SOC_IOMEM_SIZE);
> +    create_unimplemented_device("aspeed_soc.io", sc->info->memmap[ASPEED_IOMEM],
> +                                ASPEED_SOC_IOMEM_SIZE);
>  
>      /* CPU */
>      object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
> @@ -237,8 +262,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> -    memory_region_add_subregion(get_system_memory(), ASPEED_SOC_SRAM_BASE,
> -                                &s->sram);
> +    memory_region_add_subregion(get_system_memory(),
> +                                sc->info->memmap[ASPEED_SRAM], &s->sram);
>  
>      /* SCU */
>      object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
> @@ -246,7 +271,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, ASPEED_SOC_SCU_BASE);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->info->memmap[ASPEED_SCU]);
>  
>      /* VIC */
>      object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
> @@ -254,7 +279,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, ASPEED_SOC_VIC_BASE);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->info->memmap[ASPEED_VIC]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 0,
>                         qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
> @@ -266,7 +291,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0, ASPEED_SOC_TIMER_BASE);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
> +                    sc->info->memmap[ASPEED_TIMER1]);
>      for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
>          qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
> @@ -275,8 +301,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      /* UART - attach an 8250 to the IO space as our UART5 */
>      if (serial_hd(0)) {
>          qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_UART5);
> -        serial_mm_init(get_system_memory(),
> -                       ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE, 2,
> +        serial_mm_init(get_system_memory(), sc->info->memmap[ASPEED_UART5], 2,
>                         uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>      }
>  
> @@ -286,7 +311,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, ASPEED_SOC_I2C_BASE);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->info->memmap[ASPEED_I2C]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
>                         aspeed_soc_get_irq(s, ASPEED_I2C));
>  
> @@ -296,7 +321,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, ASPEED_SOC_FMC_BASE);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->info->memmap[ASPEED_FMC]);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
>                      s->fmc.ctrl->flash_window_base);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
> @@ -312,7 +337,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>              error_propagate(errp, err);
>              return;
>          }
> -        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, sc->info->spi_bases[i]);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
> +                        sc->info->memmap[ASPEED_SPI1 + i]);
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 1,
>                          s->spi[i].ctrl->flash_window_base);
>      }
> @@ -323,7 +349,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, ASPEED_SOC_SDMC_BASE);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->info->memmap[ASPEED_SDMC]);
>  
>      /* Watch dog */
>      for (i = 0; i < sc->info->wdts_num; i++) {
> @@ -333,7 +359,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>              return;
>          }
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
> -                        ASPEED_SOC_WDT_BASE + i * 0x20);
> +                        sc->info->memmap[ASPEED_WDT] + i * 0x20);
>      }
>  
>      /* Net */
> @@ -346,7 +372,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BASE);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0,
> +                    sc->info->memmap[ASPEED_ETH1]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
>                         aspeed_soc_get_irq(s, ASPEED_ETH1));
>  }
> 

Using ASPEED_MODULE_COUNT:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

