Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37968C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 05:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B9F206C9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 05:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B9F206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI3t8-00006J-UW
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 01:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kI3sS-0007wy-EE; Tue, 15 Sep 2020 01:51:40 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:33931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kI3sQ-0001Qv-AV; Tue, 15 Sep 2020 01:51:40 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.134])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 8CE4B61A6B98;
 Tue, 15 Sep 2020 07:51:20 +0200 (CEST)
Received: from kaod.org (37.59.142.104) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 15 Sep
 2020 07:51:19 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0055e50704d-b25b-4e82-a853-c034a5087724,
 9746AEA542B49782F630A24C3A5DB92DD62FF7A2) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v6 4/7] hw/arm/aspeed: Add the 3 front LEDs drived by the
 PCA9552 #1
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 <qemu-devel@nongnu.org>
References: <20200912134041.946260-1-f4bug@amsat.org>
 <20200912134041.946260-5-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fc955f9a-7489-8386-06e7-c13e0bbcf041@kaod.org>
Date: Tue, 15 Sep 2020 07:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912134041.946260-5-f4bug@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 031be12d-d0d1-4124-9ae1-a206849e5c31
X-Ovh-Tracer-Id: 6221722886646762488
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeijedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheeutdehgefhvdehtdeuleetgedvfeeukedtfeeihfffffeiuddutdduhffgvedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepfhegsghughesrghmshgrthdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 01:49:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 3:40 PM, Philippe Mathieu-Daudé wrote:
> The Witherspoon has 3 LEDs connected to a PCA9552. Add them.
> The names and reset values are taken from:
> https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml
> 
> Example booting obmc-phosphor-image:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace led_change_intensity
>   1592693373.997015:led_change_intensity LED desc:'front-fault-4' color:green intensity 0% -> 100%
>   1592693373.997632:led_change_intensity LED desc:'front-power-3' color:green intensity 0% -> 100%
>   1592693373.998239:led_change_intensity LED desc:'front-id-5' color:green intensity 0% -> 100%
>   1592693500.291805:led_change_intensity LED desc:'front-power-3' color:green intensity 100% -> 0%
>   1592693500.312041:led_change_intensity LED desc:'front-power-3' color:green intensity 0% -> 100%
>   1592693500.821254:led_change_intensity LED desc:'front-power-3' color:green intensity 100% -> 0%
>   1592693501.331517:led_change_intensity LED desc:'front-power-3' color:green intensity 0% -> 100%
>   1592693501.841367:led_change_intensity LED desc:'front-power-3' color:green intensity 100% -> 0%
>   1592693502.350839:led_change_intensity LED desc:'front-power-3' color:green intensity 0% -> 100%
>   1592693502.861134:led_change_intensity LED desc:'front-power-3' color:green intensity 100% -> 0%
>   1592693503.371090:led_change_intensity LED desc:'front-power-3' color:green intensity 0% -> 100%
> 
> We notice the front-power LED starts to blink at a ~2Hz rate.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  hw/arm/aspeed.c | 20 ++++++++++++++++++++
>  hw/arm/Kconfig  |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 8bfb1c79ddc..83e322ea983 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -20,6 +20,7 @@
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "hw/misc/pca9552.h"
>  #include "hw/misc/tmp105.h"
> +#include "hw/misc/led.h"
>  #include "hw/qdev-properties.h"
>  #include "qemu/log.h"
>  #include "sysemu/block-backend.h"
> @@ -521,9 +522,20 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
>  
>  static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>  {
> +    static const struct {
> +        unsigned gpio_id;
> +        LEDColor color;
> +        const char *description;
> +        bool gpio_polarity;
> +    } pca1_leds[] = {
> +        {13, LED_COLOR_GREEN, "front-fault-4",  GPIO_POLARITY_ACTIVE_LOW},
> +        {14, LED_COLOR_GREEN, "front-power-3",  GPIO_POLARITY_ACTIVE_LOW},
> +        {15, LED_COLOR_GREEN, "front-id-5",     GPIO_POLARITY_ACTIVE_LOW},
> +    };
>      AspeedSoCState *soc = &bmc->soc;
>      uint8_t *eeprom_buf = g_malloc0(8 * 1024);
>      DeviceState *dev;
> +    LEDState *led;
>  
>      /* Bus 3: TODO bmp280@77 */
>      /* Bus 3: TODO max31785@52 */
> @@ -534,6 +546,14 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>                                  aspeed_i2c_get_bus(&soc->i2c, 3),
>                                  &error_fatal);
>  
> +    for (size_t i = 0; i < ARRAY_SIZE(pca1_leds); i++) {
> +        led = led_create_simple(OBJECT(bmc),
> +                                pca1_leds[i].gpio_polarity,
> +                                pca1_leds[i].color,
> +                                pca1_leds[i].description);
> +        qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
> +                              qdev_get_gpio_in(DEVICE(led), 0));
> +    }
>      i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
>      i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
>  
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index bc3a423940b..06ba1c355b1 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -394,6 +394,7 @@ config ASPEED_SOC
>      select TMP105
>      select TMP421
>      select UNIMP
> +    select LED
>  
>  config MPS2
>      bool
> 


