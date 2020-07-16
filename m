Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2FAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D675620578
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D675620578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvx3a-0000fe-5h
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jvx32-0000F7-EP
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:07:12 -0400
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:59153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jvx30-00025z-FZ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:07:12 -0400
Received: from player778.ha.ovh.net (unknown [10.110.171.125])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 3390C16EA11
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 08:07:06 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-1163-216.w90-76.abo.wanadoo.fr
 [90.76.222.216]) (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 6D6681467E9A0;
 Thu, 16 Jul 2020 06:06:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00411f495fb-f0a1-4623-9cd1-f33dd25c4f8b,2A9D1999911B15737EB689736E4AAE1772229697)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2] hw/arm/aspeed: Add board model for Supermicro X11 BMC
To: erik-smit <erik.lucas.smit@gmail.com>
References: <20200715173418.186-1-erik.lucas.smit@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b3c8ef39-5a1e-c49d-6ab8-342f42be088c@kaod.org>
Date: Thu, 16 Jul 2020 08:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200715173418.186-1-erik.lucas.smit@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17188550929903225664
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfeefgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpledtrdejiedrvddvvddrvdduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.39.218; envelope-from=clg@kaod.org;
 helo=6.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 02:07:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/20 7:34 PM, erik-smit wrote:
> Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
> Changed in v2:
>  - matched aspeed_machine_supermicrox11_bmc_class_init function name to
>    machine name
> 
>  hw/arm/aspeed.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 379f9672a5..ef042471be 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -57,6 +57,20 @@ struct AspeedMachineState {
>          SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
>          SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
>  
> +/* TODO: Find the actual hardware value */
> +#define SUPERMICROX11_BMC_HW_STRAP1 (                                   \
> +        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
> +        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2) |                           \
> +        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
> +        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |       \
> +        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
> +        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |                \
> +        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
> +        SCU_HW_STRAP_SPI_WIDTH |                                        \
> +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
> +        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
> +
>  /* AST2500 evb hardware value: 0xF100C2E6 */
>  #define AST2500_EVB_HW_STRAP1 ((                                        \
>          AST2500_HW_STRAP1_DEFAULTS |                                    \
> @@ -600,6 +614,23 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
>          aspeed_soc_num_cpus(amc->soc_name);
>  };
>  
> +static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
> +                                                        void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Supermicro X11 BMC (ARM926EJ-S)";
> +    amc->soc_name  = "ast2400-a1";
> +    amc->hw_strap1 = SUPERMICROX11_BMC_HW_STRAP1;
> +    amc->fmc_model = "mx25l25635e";
> +    amc->spi_model = "mx25l25635e";
> +    amc->num_cs    = 1;
> +    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
> +    amc->i2c_init  = palmetto_bmc_i2c_init;
> +    mc->default_ram_size = 256 * MiB;
> +}
> +
>  static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -728,6 +759,10 @@ static const TypeInfo aspeed_machine_types[] = {
>          .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
>          .parent        = TYPE_ASPEED_MACHINE,
>          .class_init    = aspeed_machine_palmetto_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
>      }, {
>          .name          = MACHINE_TYPE_NAME("ast2500-evb"),
>          .parent        = TYPE_ASPEED_MACHINE,
> 


