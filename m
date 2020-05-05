Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12200C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D603E206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D603E206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVqdA-0003ia-0K
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 02:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jVqbz-00027v-Ge
 for qemu-devel@nongnu.org; Tue, 05 May 2020 01:59:23 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:55724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jVqby-00052o-De
 for qemu-devel@nongnu.org; Tue, 05 May 2020 01:59:23 -0400
Received: from player695.ha.ovh.net (unknown [10.110.208.160])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 442931BB873
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 07:59:19 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id 102C811E8BFDB;
 Tue,  5 May 2020 05:59:13 +0000 (UTC)
Subject: Re: [PATCH] aspeed: Support AST2600A1 silicon revision
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20200504093703.261135-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <43c93457-c797-0d48-65bd-a68e257488ac@kaod.org>
Date: Tue, 5 May 2020 07:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504093703.261135-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 51228448656034624
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrjeehgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.110.239; envelope-from=clg@kaod.org;
 helo=8.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 01:59:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 11:37 AM, Joel Stanley wrote:
> There are minimal differences from Qemu's point of view between the A0
> and A1 silicon revisions.
> 
> As the A1 exercises different code paths in u-boot it is desirable to
> emulate that instead.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/arm/aspeed.c              |  8 ++++----
>  hw/arm/aspeed_ast2600.c      |  6 +++---
>  hw/misc/aspeed_scu.c         | 11 +++++------
>  include/hw/misc/aspeed_scu.h |  1 +
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 99a0f3fcf36e..91301efab32d 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -93,7 +93,7 @@ struct AspeedBoardState {
>  
>  /* Tacoma hardware value */
>  #define TACOMA_BMC_HW_STRAP1  0x00000000
> -#define TACOMA_BMC_HW_STRAP2  0x00000000
> +#define TACOMA_BMC_HW_STRAP2  0x00000040
>  
>  /*
>   * The max ram region is for firmwares that scan the address space
> @@ -585,7 +585,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
>      AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>  
>      mc->desc       = "Aspeed AST2600 EVB (Cortex A7)";
> -    amc->soc_name  = "ast2600-a0";
> +    amc->soc_name  = "ast2600-a1";
>      amc->hw_strap1 = AST2600_EVB_HW_STRAP1;
>      amc->hw_strap2 = AST2600_EVB_HW_STRAP2;
>      amc->fmc_model = "w25q512jv";
> @@ -600,8 +600,8 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
>      MachineClass *mc = MACHINE_CLASS(oc);
>      AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>  
> -    mc->desc       = "Aspeed AST2600 EVB (Cortex A7)";
> -    amc->soc_name  = "ast2600-a0";
> +    mc->desc       = "OpenPOWER Tacoma BMC (Cortex A7)";
> +    amc->soc_name  = "ast2600-a1";
>      amc->hw_strap1 = TACOMA_BMC_HW_STRAP1;
>      amc->hw_strap2 = TACOMA_BMC_HW_STRAP2;
>      amc->fmc_model = "mx66l1g45g";
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 1a869e09b96a..c6e0ab84ac86 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -557,9 +557,9 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
>  
>      dc->realize      = aspeed_soc_ast2600_realize;
>  
> -    sc->name         = "ast2600-a0";
> +    sc->name         = "ast2600-a1";
>      sc->cpu_type     = ARM_CPU_TYPE_NAME("cortex-a7");
> -    sc->silicon_rev  = AST2600_A0_SILICON_REV;
> +    sc->silicon_rev  = AST2600_A1_SILICON_REV;
>      sc->sram_size    = 0x10000;
>      sc->spis_num     = 2;
>      sc->ehcis_num    = 2;
> @@ -571,7 +571,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
>  }
>  
>  static const TypeInfo aspeed_soc_ast2600_type_info = {
> -    .name           = "ast2600-a0",
> +    .name           = "ast2600-a1",
>      .parent         = TYPE_ASPEED_SOC,
>      .instance_size  = sizeof(AspeedSoCState),
>      .instance_init  = aspeed_soc_ast2600_init,
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 9d7482a9df19..ec4fef900e27 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -431,6 +431,7 @@ static uint32_t aspeed_silicon_revs[] = {
>      AST2500_A0_SILICON_REV,
>      AST2500_A1_SILICON_REV,
>      AST2600_A0_SILICON_REV,
> +    AST2600_A1_SILICON_REV,
>  };
>  
>  bool is_supported_silicon_rev(uint32_t silicon_rev)
> @@ -649,12 +650,10 @@ static const MemoryRegionOps aspeed_ast2600_scu_ops = {
>      .valid.unaligned = false,
>  };
>  
> -static const uint32_t ast2600_a0_resets[ASPEED_AST2600_SCU_NR_REGS] = {
> -    [AST2600_SILICON_REV]       = AST2600_SILICON_REV,
> -    [AST2600_SILICON_REV2]      = AST2600_SILICON_REV,
> -    [AST2600_SYS_RST_CTRL]      = 0xF7CFFEDC | 0x100,
> +static const uint32_t ast2600_a1_resets[ASPEED_AST2600_SCU_NR_REGS] = {
> +    [AST2600_SYS_RST_CTRL]      = 0xF7C3FED8,
>      [AST2600_SYS_RST_CTRL2]     = 0xFFFFFFFC,
> -    [AST2600_CLK_STOP_CTRL]     = 0xEFF43E8B,
> +    [AST2600_CLK_STOP_CTRL]     = 0xFFFF7F8A,
>      [AST2600_CLK_STOP_CTRL2]    = 0xFFF0FFF0,
>      [AST2600_SDRAM_HANDSHAKE]   = 0x00000040,  /* SoC completed DRAM init */
>      [AST2600_HPLL_PARAM]        = 0x1000405F,
> @@ -684,7 +683,7 @@ static void aspeed_2600_scu_class_init(ObjectClass *klass, void *data)
>  
>      dc->desc = "ASPEED 2600 System Control Unit";
>      dc->reset = aspeed_ast2600_scu_reset;
> -    asc->resets = ast2600_a0_resets;
> +    asc->resets = ast2600_a1_resets;
>      asc->calc_hpll = aspeed_2500_scu_calc_hpll; /* No change since AST2500 */
>      asc->apb_divider = 4;
>      asc->nr_regs = ASPEED_AST2600_SCU_NR_REGS;
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index 1d7f7ffc1598..a6739bb846b6 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -41,6 +41,7 @@ typedef struct AspeedSCUState {
>  #define AST2500_A0_SILICON_REV   0x04000303U
>  #define AST2500_A1_SILICON_REV   0x04010303U
>  #define AST2600_A0_SILICON_REV   0x05000303U
> +#define AST2600_A1_SILICON_REV   0x05010303U
>  
>  #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) == 0x04)
>  
> 


