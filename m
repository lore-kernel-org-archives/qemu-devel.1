Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66516C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C30820716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C30820716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jne3Z-0007xA-Fq
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jne2y-0007L5-K7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:12:48 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:39125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jne2w-0004rx-05
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:12:48 -0400
Received: from player798.ha.ovh.net (unknown [10.110.171.250])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 33B822181B0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:12:35 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id 2A1C313BD8F79;
 Tue, 23 Jun 2020 08:12:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002dd50692f-5cec-4588-ab1e-0a843df684a3,EED1DA90FC9B795DFFB5AB62ED4F19E3D36D96F8)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 2/3] hw/arm/aspeed: Rename AspeedBoardState as
 AspeedMachineState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200623072132.2868-1-f4bug@amsat.org>
 <20200623072132.2868-3-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <64e627fb-3044-d13a-717f-5a5fb854f200@kaod.org>
Date: Tue, 23 Jun 2020 10:12:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623072132.2868-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13362743045705206739
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekgedgtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkeeirddvuddtrdduhedvrddvgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.39.161; envelope-from=clg@kaod.org;
 helo=15.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 04:12:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 9:21 AM, Philippe Mathieu-Daudé wrote:
> To have a more consistent naming, rename AspeedBoardState
> as AspeedMachineState.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  include/hw/arm/aspeed.h |  4 ++--
>  hw/arm/aspeed.c         | 20 ++++++++++----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 95b4daece8..5114ba0bd4 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -11,7 +11,7 @@
>  
>  #include "hw/boards.h"
>  
> -typedef struct AspeedBoardState AspeedBoardState;
> +typedef struct AspeedMachineState AspeedMachineState;
>  
>  #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
>  #define ASPEED_MACHINE(obj) \
> @@ -45,7 +45,7 @@ typedef struct AspeedMachineClass {
>      const char *spi_model;
>      uint32_t num_cs;
>      uint32_t macs_mask;
> -    void (*i2c_init)(AspeedBoardState *bmc);
> +    void (*i2c_init)(AspeedMachineState *bmc);
>  } AspeedMachineClass;
>  
>  
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 31765792a2..680345beca 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -32,7 +32,7 @@ static struct arm_boot_info aspeed_board_binfo = {
>      .board_id = -1, /* device-tree-only board */
>  };
>  
> -struct AspeedBoardState {
> +struct AspeedMachineState {
>      AspeedSoCState soc;
>      MemoryRegion ram_container;
>      MemoryRegion max_ram;
> @@ -253,7 +253,7 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo)
>  
>  static void aspeed_machine_init(MachineState *machine)
>  {
> -    AspeedBoardState *bmc;
> +    AspeedMachineState *bmc;
>      AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
>      AspeedSoCClass *sc;
>      DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
> @@ -261,7 +261,7 @@ static void aspeed_machine_init(MachineState *machine)
>      int i;
>      NICInfo *nd = &nd_table[0];
>  
> -    bmc = g_new0(AspeedBoardState, 1);
> +    bmc = g_new0(AspeedMachineState, 1);
>  
>      memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-container",
>                         4 * GiB);
> @@ -374,7 +374,7 @@ static void aspeed_machine_init(MachineState *machine)
>      arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
>  }
>  
> -static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
> +static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
>      DeviceState *dev;
> @@ -396,7 +396,7 @@ static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
>      object_property_set_int(OBJECT(dev), 110000, "temperature3", &error_abort);
>  }
>  
> -static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
> +static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
>      uint8_t *eeprom_buf = g_malloc0(8 * 1024);
> @@ -413,13 +413,13 @@ static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
>  }
>  
> -static void ast2600_evb_i2c_init(AspeedBoardState *bmc)
> +static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
>  {
>      /* Start with some devices on our I2C busses */
>      ast2500_evb_i2c_init(bmc);
>  }
>  
> -static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
> +static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
>  
> @@ -428,7 +428,7 @@ static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
>  }
>  
> -static void swift_bmc_i2c_init(AspeedBoardState *bmc)
> +static void swift_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
>  
> @@ -457,7 +457,7 @@ static void swift_bmc_i2c_init(AspeedBoardState *bmc)
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x4a);
>  }
>  
> -static void sonorapass_bmc_i2c_init(AspeedBoardState *bmc)
> +static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
>  
> @@ -501,7 +501,7 @@ static void sonorapass_bmc_i2c_init(AspeedBoardState *bmc)
>  
>  }
>  
> -static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
> +static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
>      uint8_t *eeprom_buf = g_malloc0(8 * 1024);
> 


