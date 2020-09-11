Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2473C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EBC21D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="pLSrqU9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EBC21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGpBq-0005Hv-M8
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kGp8E-00043F-Hk; Fri, 11 Sep 2020 15:54:50 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:32920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kGp8C-0003Ue-BO; Fri, 11 Sep 2020 15:54:50 -0400
Received: from [172.17.10.18] (unknown [172.17.10.18])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 68CC821C1F;
 Fri, 11 Sep 2020 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1599854085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnYKkyD7t5KPzHFTsZpMrBWGznVj5cmE40e4PmNOBgA=;
 b=pLSrqU9MCAsttFR3KW3st0bKvUVOQrgacn8OVGxUAWxBNioDd3WgAIjNCv4ObLxq06Ezyh
 1c/S7hzYcRkds4ScYcumqdokvYn7KapDG9Iszdq3AqpjjwX2wP7DJXCTOzp5ojTemc4fd/
 zXFN7AaxLea3NKar9U96jeLvY48t7k0=
Subject: Re: [PATCH v5 7/7] hw/arm/tosa: Replace fprintf() calls by LED devices
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-8-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <de100cf8-70d1-6b73-c8b8-a7f0ce854f64@greensocs.com>
Date: Fri, 11 Sep 2020 21:55:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910205429.727766-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:41:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 10:54 PM, Philippe Mathieu-Daudé wrote:
> The recently added LED device reports LED status changes with
> the 'led_set_intensity' trace event. It is less invasive than
> the fprintf() calls. We need however to have a binary built
> with tracing support.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>   hw/arm/tosa.c  | 40 +++++++++++++++-------------------------
>   hw/arm/Kconfig |  1 +
>   2 files changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index 90eef1f14dd..f23651fd775 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -24,6 +24,7 @@
>   #include "hw/irq.h"
>   #include "hw/ssi/ssi.h"
>   #include "hw/sysbus.h"
> +#include "hw/misc/led.h"
>   #include "exec/address-spaces.h"
>   
>   #define TOSA_RAM 0x04000000
> @@ -81,26 +82,6 @@ typedef struct TosaMiscGPIOState {
>       SysBusDevice parent_obj;
>   } TosaMiscGPIOState;
>   
> -static void tosa_gpio_leds(void *opaque, int line, int level)
> -{
> -    switch (line) {
> -    case 0:
> -        fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
> -        break;
> -    case 1:
> -        fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
> -        break;
> -    case 2:
> -        fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
> -        break;
> -    case 3:
> -        fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -}
> -
>   static void tosa_reset(void *opaque, int line, int level)
>   {
>       if (level) {
> @@ -112,7 +93,6 @@ static void tosa_misc_gpio_init(Object *obj)
>   {
>       DeviceState *dev = DEVICE(obj);
>   
> -    qdev_init_gpio_in_named(dev, tosa_gpio_leds, "leds", 4);
>       qdev_init_gpio_in_named(dev, tosa_reset, "reset", 1);
>   }
>   
> @@ -122,6 +102,7 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
>                   TC6393xbState *tmio)
>   {
>       DeviceState *misc_gpio;
> +    LEDState *led[4];
>   
>       misc_gpio = sysbus_create_simple(TYPE_TOSA_MISC_GPIO, -1, NULL);
>   
> @@ -143,14 +124,23 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
>                           qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_JC_CF_IRQ),
>                           NULL);
>   
> +    led[0] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
> +                               LED_COLOR_BLUE, "bluetooth");
> +    led[1] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
> +                               LED_COLOR_GREEN, "note");
> +    led[2] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
> +                               LED_COLOR_AMBER, "charger-error");
> +    led[3] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
> +                               LED_COLOR_GREEN, "wlan");
> +
>       qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED,
> -                          qdev_get_gpio_in_named(misc_gpio, "leds", 0));
> +                          qdev_get_gpio_in(DEVICE(led[0]), 0));
>       qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED,
> -                          qdev_get_gpio_in_named(misc_gpio, "leds", 1));
> +                          qdev_get_gpio_in(DEVICE(led[1]), 0));
>       qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED,
> -                          qdev_get_gpio_in_named(misc_gpio, "leds", 2));
> +                          qdev_get_gpio_in(DEVICE(led[2]), 0));
>       qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED,
> -                          qdev_get_gpio_in_named(misc_gpio, "leds", 3));
> +                          qdev_get_gpio_in(DEVICE(led[3]), 0));
>   
>       qdev_connect_gpio_out(scp1, TOSA_GPIO_TC6393XB_L3V_ON, tc6393xb_l3v_get(tmio));
>   
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 06ba1c355b1..bbcfa098ae2 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -150,6 +150,7 @@ config TOSA
>       select ZAURUS  # scoop
>       select MICRODRIVE
>       select PXA2XX
> +    select LED
>   
>   config SPITZ
>       bool
> 

