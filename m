Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8A1C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7021D22207
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7021D22207
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMo1H-00015O-I5
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 03:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kMo0M-0000W0-E3; Mon, 28 Sep 2020 03:55:26 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:38019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kMo0K-000143-Cd; Mon, 28 Sep 2020 03:55:26 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.59])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 41AB85F7F16D;
 Mon, 28 Sep 2020 09:55:13 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 28 Sep
 2020 09:55:12 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003fe85e500-6295-409b-bb34-7b73e44841f2,
 9B5560306CAF984A1CB20844932014F06B941BD6) smtp.auth=clg@kaod.org
Subject: Re: [PATCH] aspeed: Add support for the g220a-bmc board
To: John Wang <wangzhiqiang.bj@bytedance.com>, <yulei.sh@bytedance.com>,
 <xuxiaohan@bytedance.com>
References: <20200928061201.1601-1-wangzhiqiang.bj@bytedance.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d6cf7464-a0bf-2748-7e4c-732208881711@kaod.org>
Date: Mon, 28 Sep 2020 09:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200928061201.1601-1-wangzhiqiang.bj@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 48120c75-e5dd-4d99-bf8f-4053739dbdb2
X-Ovh-Tracer-Id: 10871689504203115372
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrvdehgdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgedvieejfedvhfduhfffueevheeludffhfdvkeehleegtddttdfhieegveeghfffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepfigrnhhgiihhihhqihgrnhhgrdgsjhessgihthgvuggrnhgtvgdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:55:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.011,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 8:12 AM, John Wang wrote:
> G220A is a 2 socket x86 motherboard supported by OpenBMC.
> Strapping configuration was obtained from hardware.
> 
> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>> ---
>  hw/arm/aspeed.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index bdb981d2f8..1de61f7d4f 100644
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
> @@ -798,6 +812,23 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
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

'macs_mask' is missing. You won't get network.

> +    amc->i2c_init  = NULL;

Isn't it possible to add some default I2C devices ? temperature sensors ?

Thanks,

C. 

> +    mc->default_ram_size = 1024 * MiB;
> +    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> +        aspeed_soc_num_cpus(amc->soc_name);
> +};
> +
>  static const TypeInfo aspeed_machine_types[] = {
>      {
>          .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
> @@ -835,6 +866,10 @@ static const TypeInfo aspeed_machine_types[] = {
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


