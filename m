Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1C2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAE220738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAE220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxWy-0007JW-Cm
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1juxUx-0004Fo-C0
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:23:55 -0400
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:40846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1juxUt-0008BL-7G
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:23:55 -0400
Received: from player694.ha.ovh.net (unknown [10.110.115.231])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id B8DC621EF83
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:23:48 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id 91363143A8968;
 Mon, 13 Jul 2020 12:23:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0010353a2ee-ef43-465b-b385-6e216f2222fa,29C60B8BFD44B6CD822E82BF6A6060F4508BB267)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 1/5] hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200629173821.22037-1-f4bug@amsat.org>
 <20200629173821.22037-2-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8511de8e-45e3-e93e-acb4-eb1d75237de5@kaod.org>
Date: Mon, 13 Jul 2020 14:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629173821.22037-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5932366610059594549
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrvdekgdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.32.125.228; envelope-from=clg@kaod.org;
 helo=12.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 08:23:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 7:38 PM, Philippe Mathieu-Daudé wrote:
> Simplify aspeed_i2c_get_bus() by using a AspeedI2CState argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  include/hw/i2c/aspeed_i2c.h |  2 +-
>  hw/arm/aspeed.c             | 70 ++++++++++++++++++-------------------
>  hw/i2c/aspeed_i2c.c         |  3 +-
>  3 files changed, 37 insertions(+), 38 deletions(-)
> 
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index f1b9e5bf91..243789ae5d 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -93,6 +93,6 @@ typedef struct AspeedI2CClass {
>  
>  } AspeedI2CClass;
>  
> -I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr);
> +I2CBus *aspeed_i2c_get_bus(AspeedI2CState *s, int busnr);
>  
>  #endif /* ASPEED_I2C_H */
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 379f9672a5..1285bf82c0 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -385,13 +385,13 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
>  
>      /* The palmetto platform expects a ds3231 RTC but a ds1338 is
>       * enough to provide basic RTC features. Alarms will be missing */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), "ds1338", 0x68);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
>  
> -    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), 0x50,
> +    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                            eeprom_buf);
>  
>      /* add a TMP423 temperature sensor */
> -    dev = i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2),
> +    dev = i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 2),
>                             "tmp423", 0x4c);
>      object_property_set_int(OBJECT(dev), 31000, "temperature0", &error_abort);
>      object_property_set_int(OBJECT(dev), 28000, "temperature1", &error_abort);
> @@ -404,16 +404,16 @@ static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
>      AspeedSoCState *soc = &bmc->soc;
>      uint8_t *eeprom_buf = g_malloc0(8 * 1024);
>  
> -    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), 0x50,
> +    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 3), 0x50,
>                            eeprom_buf);
>  
>      /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7),
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 7),
>                       TYPE_TMP105, 0x4d);
>  
>      /* The AST2500 EVB does not have an RTC. Let's pretend that one is
>       * plugged on the I2C bus header */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
>  }
>  
>  static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
> @@ -428,36 +428,36 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
>  
>      /* The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
>       * good enough */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
>  }
>  
>  static void swift_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
>  
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca9552", 0x60);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 3), "pca9552", 0x60);
>  
>      /* The swift board expects a TMP275 but a TMP105 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105", 0x48);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 7), "tmp105", 0x48);
>      /* The swift board expects a pca9551 but a pca9552 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "pca9552", 0x60);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9552", 0x60);
>  
>      /* The swift board expects an Epson RX8900 RTC but a ds1338 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "ds1338", 0x32);
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x60);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "ds1338", 0x32);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x60);
>  
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp423", 0x4c);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
>      /* The swift board expects a pca9539 but a pca9552 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "pca9552", 0x74);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 9), "pca9552", 0x74);
>  
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "tmp423", 0x4c);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
>      /* The swift board expects a pca9539 but a pca9552 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "pca9552",
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 10), "pca9552",
>                       0x74);
>  
>      /* The swift board expects a TMP275 but a TMP105 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x48);
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x4a);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 12), "tmp105", 0x48);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 12), "tmp105", 0x4a);
>  }
>  
>  static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
> @@ -465,32 +465,32 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
>      AspeedSoCState *soc = &bmc->soc;
>  
>      /* bus 2 : */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x48);
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x49);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x48);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x49);
>      /* bus 2 : pca9546 @ 0x73 */
>  
>      /* bus 3 : pca9548 @ 0x70 */
>  
>      /* bus 4 : */
>      uint8_t *eeprom4_54 = g_malloc0(8 * 1024);
> -    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), 0x54,
> +    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x54,
>                            eeprom4_54);
>      /* PCA9539 @ 0x76, but PCA9552 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x76);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 4), "pca9552", 0x76);
>      /* PCA9539 @ 0x77, but PCA9552 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x77);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 4), "pca9552", 0x77);
>  
>      /* bus 6 : */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x48);
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x49);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x48);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x49);
>      /* bus 6 : pca9546 @ 0x73 */
>  
>      /* bus 8 : */
>      uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
> -    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), 0x56,
> +    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 0x56,
>                            eeprom8_56);
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x60);
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x61);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x60);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x61);
>      /* bus 8 : adc128d818 @ 0x1d */
>      /* bus 8 : adc128d818 @ 0x1f */
>  
> @@ -515,25 +515,25 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>      /* Bus 3: TODO dps310@76 */
>      dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
>      qdev_prop_set_string(dev, "description", "pca1");
> -    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3),
> +    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 3),
>                            &error_fatal);
>  
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
>  
>      /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), TYPE_TMP105,
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
>                       0x4a);
>  
>      /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
>       * good enough */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
> +    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
>  
> -    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
> +    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>                            eeprom_buf);
>      dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
>      qdev_prop_set_string(dev, "description", "pca0");
> -    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11),
> +    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 11),
>                            &error_fatal);
>      /* Bus 11: TODO ucd90160@64 */
>  }
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index fb973a983d..518a3f5c6f 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -959,9 +959,8 @@ static void aspeed_i2c_register_types(void)
>  type_init(aspeed_i2c_register_types)
>  
>  
> -I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr)
> +I2CBus *aspeed_i2c_get_bus(AspeedI2CState *s, int busnr)
>  {
> -    AspeedI2CState *s = ASPEED_I2C(dev);
>      AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
>      I2CBus *bus = NULL;
>  
> 


