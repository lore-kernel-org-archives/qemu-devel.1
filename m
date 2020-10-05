Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 22:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE1B2074F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 22:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="h9s98Ogb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE1B2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPZSC-0008UN-Mc
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 18:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kPZOj-0007k0-An; Mon, 05 Oct 2020 18:56:01 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:33645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kPZOh-0002md-9p; Mon, 05 Oct 2020 18:56:01 -0400
Received: by mail-qv1-xf42.google.com with SMTP id cy2so6990929qvb.0;
 Mon, 05 Oct 2020 15:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gPKf2w9mX4wYAK4imtSS4zpT61Op7JZnKhqQzehCEVM=;
 b=h9s98OgbpV+4KhUR5qQMSsvBs7Dc+A1VSABFVLr9p3w77LoDE0MDK58TVGy6fqkRSE
 rvznW1OL1zuShPpeisGoKyOtdY9oUlxPGGh3zfoBW5iw/SXXYc39imBh68GF/HTObjnS
 v+yZLWDFcAwjNIhGOTZ5mSamRRcH/CSSkNjWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gPKf2w9mX4wYAK4imtSS4zpT61Op7JZnKhqQzehCEVM=;
 b=JLjPSA+FGjJ6qpUnSNN1gBqGeiVoaK6rDBXAYVbT6y6rwVziTjktdw0SrA3AiB8IF3
 BYRN9PuMmvAgX9MZBhoENmFuaVZZy1P4V5AUA6Sr20qWEdIFE/lOg5rgpATeEvLtWjlR
 Ln40y4Q319xRn6+zhKwDI/88jQ1DOR1kmWFRk4BDghpihbEPLL9cXpch+S0KeFE49abe
 Z3NbW4JGt2tL4XUuh4XIY7BwRgQUvUT9kQgl1FwhFGX2d9dFmaNVIhbS90C9ll7gsLyz
 UYlrHCfI4C8Jttw1ADrn8Q8d1MTO9tL0VaNrTcLzi3ZnwJmYw0HxKFYWzxii45q4QvDP
 dRaA==
X-Gm-Message-State: AOAM533uZ5xwmRCYNlPdC9r1xfgQUtaQz549jyBJXAAzmOFdpNW4O5mq
 bq/1VZC1Fra9xI5XR+05GBX0dt6ZQbfSDIaj27A=
X-Google-Smtp-Source: ABdhPJygRqoK1E0/bHhR9oF1YXlo8Euh0h4PbYaonH+x2seg+cF1QKANa8x1CV2r1orOS1QsaBnTOai31+96XTwbmWQ=
X-Received: by 2002:a0c:f984:: with SMTP id t4mr2029982qvn.18.1601938557454;
 Mon, 05 Oct 2020 15:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200929055309.509-1-wangzhiqiang.bj@bytedance.com>
 <20200929055309.509-2-wangzhiqiang.bj@bytedance.com>
In-Reply-To: <20200929055309.509-2-wangzhiqiang.bj@bytedance.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 5 Oct 2020 22:55:45 +0000
Message-ID: <CACPK8Xf-R=1UrEVxF92Y4HGXadWfdvHjmjyDnH5K3GSJTkq7YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] aspeed: Add support for the g220a-bmc board
To: John Wang <wangzhiqiang.bj@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=joel.stan@gmail.com; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, clkg@kaod.org,
 xuxiaohan@bytedance.com, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 at 05:53, John Wang <wangzhiqiang.bj@bytedance.com> wrote:
>
> G220A is a 2 socket x86 motherboard supported by OpenBMC.
> Strapping configuration was obtained from hardware.
>
> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/arm/aspeed.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index bdb981d2f8..04c8ad2bcd 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -120,6 +120,20 @@ struct AspeedMachineState {
>          SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
>          SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
>
> +#define G220A_BMC_HW_STRAP1 (                                      \
> +        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
> +        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
> +        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
> +        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
> +        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
> +        SCU_HW_STRAP_2ND_BOOT_WDT |                                     \
> +        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
> +        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
> +        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
> +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_64M_DRAM) |                       \
> +        SCU_AST2500_HW_STRAP_RESERVED1)
> +
>  /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
>  #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
>
> @@ -559,6 +573,30 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>      /* Bus 11: TODO ucd90160@64 */
>  }
>
> +static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    AspeedSoCState *soc = &bmc->soc;
> +    DeviceState *dev;
> +
> +    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
> +                                         "emc1413", 0x4c));
> +    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
> +
> +    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 12),
> +                                         "emc1413", 0x4c));
> +    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
> +
> +    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 13),
> +                                         "emc1413", 0x4c));
> +    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
> +    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
> +}
> +
>  static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
>  {
>      return ASPEED_MACHINE(obj)->mmio_exec;
> @@ -798,6 +836,24 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
>          aspeed_soc_num_cpus(amc->soc_name);
>  };
>
> +static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Bytedance G220A BMC (ARM1176)";
> +    amc->soc_name  = "ast2500-a1";
> +    amc->hw_strap1 = G220A_BMC_HW_STRAP1;
> +    amc->fmc_model = "n25q512a";
> +    amc->spi_model = "mx25l25635e";
> +    amc->num_cs    = 2;
> +    amc->macs_mask  = ASPEED_MAC1_ON | ASPEED_MAC2_ON;
> +    amc->i2c_init  = g220a_bmc_i2c_init;
> +    mc->default_ram_size = 1024 * MiB;
> +    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> +        aspeed_soc_num_cpus(amc->soc_name);
> +};
> +
>  static const TypeInfo aspeed_machine_types[] = {
>      {
>          .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
> @@ -835,6 +891,10 @@ static const TypeInfo aspeed_machine_types[] = {
>          .name          = MACHINE_TYPE_NAME("tacoma-bmc"),
>          .parent        = TYPE_ASPEED_MACHINE,
>          .class_init    = aspeed_machine_tacoma_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("g220a-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_g220a_class_init,
>      }, {
>          .name          = TYPE_ASPEED_MACHINE,
>          .parent        = TYPE_MACHINE,
> --
> 2.25.1
>

