Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A99C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7ACF20657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7ACF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvh8U-0005Iq-1i
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jvh7t-0004m4-W0
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:07:10 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:48097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jvh7r-0004M2-W1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:07:09 -0400
Received: from player760.ha.ovh.net (unknown [10.108.35.131])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6CB701D06CC
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 15:07:05 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-1163-216.w90-76.abo.wanadoo.fr
 [90.76.222.216]) (Authenticated sender: clg@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id AF603146088DE;
 Wed, 15 Jul 2020 13:06:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00294115017-e106-4692-96f8-6419b92a0bb1,D1878713575E7557A8ED5F979EF3ECB62B482302)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH] hw/arm/aspeed: Add board model for Supermicro X11 BMC
To: erik-smit <erik.lucas.smit@gmail.com>
References: <20200714203604.5676-1-erik.lucas.smit@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <be8642a8-7fcd-db96-98e8-4f98bf736992@kaod.org>
Date: Wed, 15 Jul 2020 15:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200714203604.5676-1-erik.lucas.smit@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18408744955681016640
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfedvgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhephfffgeelfeejudevuedvvdeigeduteetveffhfffudeggfegleeljeeuieefuedvnecukfhppedtrddtrddtrddtpdeltddrjeeirddvvddvrddvudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeitddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.45.168; envelope-from=clg@kaod.org;
 helo=20.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 09:07:05
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


> Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
> -- 
> checkpatch was complaining about the length of
> aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc, void *data)

in which way ? line too long ? If so, you can insert a return inside
the parameter list.

> so I renamed it to aspeed_machine_smx11_bmc_class_init. Not sure if
> that's the right way to go, since then it's out of sync with the machine
> name "supermicrox11-bmc". But renaming the machine name to "smx11-bmc"
> makes it less descriptive...

You should put the patch comments below the '---' 
 
> ---
>  hw/arm/aspeed.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 379f9672a5..e74a89f427 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -57,6 +57,20 @@ struct AspeedMachineState {
>          SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
>          SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
>  
> +/* TODO: Find the actual hardware value */

If you can access the BMC console, you can do that from u-boot.

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
> @@ -600,6 +614,22 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
>          aspeed_soc_num_cpus(amc->soc_name);
>  };
>  
> +static void aspeed_machine_smx11_bmc_class_init(ObjectClass *oc, void *data)
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
> @@ -728,6 +758,10 @@ static const TypeInfo aspeed_machine_types[] = {
>          .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
>          .parent        = TYPE_ASPEED_MACHINE,
>          .class_init    = aspeed_machine_palmetto_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_smx11_bmc_class_init,
>      }, {
>          .name          = MACHINE_TYPE_NAME("ast2500-evb"),
>          .parent        = TYPE_ASPEED_MACHINE,
> -- 
> 2.25.1


