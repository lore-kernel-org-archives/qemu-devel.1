Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47060C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC72920848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC72920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0Dd-0007Tp-Q1
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kO01I-0000eR-29; Thu, 01 Oct 2020 10:57:20 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:59095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kO016-0004El-Nm; Thu, 01 Oct 2020 10:57:15 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.89])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 2526767AABF5;
 Thu,  1 Oct 2020 16:56:44 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 1 Oct 2020
 16:56:43 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0014e327c74-a191-404d-9aa2-32b0dd6415cc,
 2FD1C644E9D11323632A639817FC6AC7C89AF497) smtp.auth=clg@kaod.org
Subject: Re: [PATCH 2/2] aspeed: Add support for the g220a-bmc board
To: John Wang <wangzhiqiang.bj@bytedance.com>, <clkg@kaod.org>,
 <yulei.sh@bytedance.com>, <xuxiaohan@bytedance.com>, <joel@jms.id.au>
References: <20200929055309.509-1-wangzhiqiang.bj@bytedance.com>
 <20200929055309.509-2-wangzhiqiang.bj@bytedance.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a4ff4f18-34fa-d3bd-9a63-dfbc8fb41f84@kaod.org>
Date: Thu, 1 Oct 2020 16:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929055309.509-2-wangzhiqiang.bj@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 3bd53426-2c3c-4576-acb3-f3cfe2650e32
X-Ovh-Tracer-Id: 17162092281946802991
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopeifrghnghiihhhiqhhirghnghdrsghjsegshihtvggurghntggvrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 10:56:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 7:53 AM, John Wang wrote:
> G220A is a 2 socket x86 motherboard supported by OpenBMC.
> Strapping configuration was obtained from hardware.
> 
> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>


One quick question below.

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

On real HW, is it a mx25l25635e or a mx25l25635f ? 

Thanks

C.

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
> 


