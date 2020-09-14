Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4561EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A5D21548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="lwESvzt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A5D21548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHipv-0000pM-N3
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kHikX-0008Ki-JM; Mon, 14 Sep 2020 03:18:05 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:53706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kHikU-00025A-P3; Mon, 14 Sep 2020 03:18:05 -0400
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id A4AD721CC2;
 Mon, 14 Sep 2020 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1600067878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5muaI6LprhA3jkfe/RwrGHJHaEBuyEq2QYF3taxHigw=;
 b=lwESvzt27MsEr23g+sR45ifIuPEbRknkanvmkyW6ziRxVD/XA7/3N67HjUW8tYitZ4yJZ6
 YnWseqPHGNEINehsSd/Vvg6K/hTaokuAJhdpRWbUxRYnkDNBEj32mNLUNcSm6KkO5xaXkh
 GJkWraSRo86B5uMq6G3jNdF5WxpLiT0=
Subject: Re: [PATCH v6 2/7] hw/misc/led: Allow connecting from GPIO output
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200912134041.946260-1-f4bug@amsat.org>
 <20200912134041.946260-3-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <f092c9df-db98-41fc-4ba2-34d6eafc095c@greensocs.com>
Date: Mon, 14 Sep 2020 09:18:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200912134041.946260-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 03:17:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 3:40 PM, Philippe Mathieu-Daudé wrote:
> Some devices expose GPIO lines.
> 
> Add a GPIO qdev input to our LED device, so we can
> connect a GPIO output using qdev_connect_gpio_out().
> 
> When used with GPIOs, the intensity can only be either
> minium or maximum. This depends of the polarity of the
> GPIO (which can be inverted).
> Declare the GpioPolarity type to model the polarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>   include/hw/misc/led.h  | 10 ++++++++++
>   include/hw/qdev-core.h | 16 ++++++++++++++++
>   hw/misc/led.c          | 17 ++++++++++++++++-
>   3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
> index 286d37c75c1..aa359b87c20 100644
> --- a/include/hw/misc/led.h
> +++ b/include/hw/misc/led.h
> @@ -9,6 +9,7 @@
>   #define HW_MISC_LED_H
>   
>   #include "qom/object.h"
> +#include "hw/qdev-core.h"
>   
>   #define TYPE_LED "led"
>   
> @@ -37,10 +38,17 @@ struct LEDState {
>       /* Public */
>   
>       uint8_t intensity_percent;
> +    qemu_irq irq;
>   
>       /* Properties */
>       char *description;
>       char *color;
> +    /*
> +     * Determines whether a GPIO is using a positive (active-high)
> +     * logic (when used with GPIO, the intensity at reset is related
> +     * to the GPIO polarity).
> +     */
> +    bool gpio_active_high;
>   };
>   typedef struct LEDState LEDState;
>   DECLARE_INSTANCE_CHECKER(LEDState, LED, TYPE_LED)
> @@ -72,6 +80,7 @@ void led_set_state(LEDState *s, bool is_emitting);
>   /**
>    * led_create_simple: Create and realize a LED device
>    * @parentobj: the parent object
> + * @gpio_polarity: GPIO polarity
>    * @color: color of the LED
>    * @description: description of the LED (optional)
>    *
> @@ -81,6 +90,7 @@ void led_set_state(LEDState *s, bool is_emitting);
>    * Returns: The newly allocated and instantiated LED object.
>    */
>   LEDState *led_create_simple(Object *parentobj,
> +                            GpioPolarity gpio_polarity,
>                               LEDColor color,
>                               const char *description);
>   
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index e025ba9653f..ec1f1efc37b 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -423,6 +423,22 @@ void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
>   void qdev_machine_creation_done(void);
>   bool qdev_machine_modified(void);
>   
> +/**
> + * GpioPolarity: Polarity of a GPIO line
> + *
> + * GPIO lines use either positive (active-high) logic,
> + * or negative (active-low) logic.
> + *
> + * In active-high logic (%GPIO_POLARITY_ACTIVE_HIGH), a pin is
> + * active when the voltage on the pin is high (relative to ground);
> + * whereas in active-low logic (%GPIO_POLARITY_ACTIVE_LOW), a pin
> + * is active when the voltage on the pin is low (or grounded).
> + */
> +typedef enum {
> +    GPIO_POLARITY_ACTIVE_LOW,
> +    GPIO_POLARITY_ACTIVE_HIGH
> +} GpioPolarity;
> +
>   /**
>    * qdev_get_gpio_in: Get one of a device's anonymous input GPIO lines
>    * @dev: Device whose GPIO we want
> diff --git a/hw/misc/led.c b/hw/misc/led.c
> index 1e2f49c5710..c5fa09a613a 100644
> --- a/hw/misc/led.c
> +++ b/hw/misc/led.c
> @@ -10,6 +10,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/misc/led.h"
> +#include "hw/irq.h"
>   #include "trace.h"
>   
>   #define LED_INTENSITY_PERCENT_MAX   100
> @@ -53,11 +54,19 @@ void led_set_state(LEDState *s, bool is_emitting)
>       led_set_intensity(s, is_emitting ? LED_INTENSITY_PERCENT_MAX : 0);
>   }
>   
> +static void led_set_state_gpio_handler(void *opaque, int line, int new_state)
> +{
> +    LEDState *s = LED(opaque);
> +
> +    assert(line == 0);
> +    led_set_state(s, !!new_state != s->gpio_active_high);
> +}
> +
>   static void led_reset(DeviceState *dev)
>   {
>       LEDState *s = LED(dev);
>   
> -    led_set_state(s, false);
> +    led_set_state(s, s->gpio_active_high);
>   }
>   
>   static const VMStateDescription vmstate_led = {
> @@ -84,11 +93,14 @@ static void led_realize(DeviceState *dev, Error **errp)
>       if (s->description == NULL) {
>           s->description = g_strdup("n/a");
>       }
> +
> +    qdev_init_gpio_in(DEVICE(s), led_set_state_gpio_handler, 1);
>   }
>   
>   static Property led_properties[] = {
>       DEFINE_PROP_STRING("color", LEDState, color),
>       DEFINE_PROP_STRING("description", LEDState, description),
> +    DEFINE_PROP_BOOL("gpio-active-high", LEDState, gpio_active_high, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -119,6 +131,7 @@ static void led_register_types(void)
>   type_init(led_register_types)
>   
>   LEDState *led_create_simple(Object *parentobj,
> +                            GpioPolarity gpio_polarity,
>                               LEDColor color,
>                               const char *description)
>   {
> @@ -126,6 +139,8 @@ LEDState *led_create_simple(Object *parentobj,
>       DeviceState *dev;
>   
>       dev = qdev_new(TYPE_LED);
> +    qdev_prop_set_bit(dev, "gpio-active-high",
> +                      gpio_polarity == GPIO_POLARITY_ACTIVE_HIGH);
>       qdev_prop_set_string(dev, "color", led_color_name[color]);
>       if (!description) {
>           static unsigned undescribed_led_id;
> 

