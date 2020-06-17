Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC72C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB64C20679
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB64C20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlQM9-0003UI-6m
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlQLR-0002xM-E2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:10:43 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:37860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlQLO-0006Tj-Cb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:10:41 -0400
Received: from player698.ha.ovh.net (unknown [10.110.171.5])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id C3207168878
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 07:10:27 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id 5B88D136ACACF;
 Wed, 17 Jun 2020 05:10:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002cbf81f5b-57a4-4961-9d61-367f63aa2de7,ABECD89738EEB0C75E5395B338997A57DB3A3EEE)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 2/2] hw/misc/pca9552: Make LEDs 13-15 also GPIOs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200616094542.25415-1-f4bug@amsat.org>
 <20200616094542.25415-3-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <84d0fee0-9711-e066-466a-836274408068@kaod.org>
Date: Wed, 17 Jun 2020 07:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616094542.25415-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11944390639203552014
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.79.46; envelope-from=clg@kaod.org;
 helo=10.mo179.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:10:28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 11:45 AM, Philippe Mathieu-Daudé wrote:
> The PCA9552 has 3 GPIOs, add them.

This is an example of an HW configuration. All pins can be used
as GPIOs. 
 
> See 'PCA9552 Product Datasheet Rev. 05 - 9 March 2006',
> chapter 6.4 'Pins used as GPIOs':
> 
>   LED pins not used to control LEDs can be used as general
>   purpose I/Os (GPIOs).
>   For use as input, set LEDn to high-impedance (01) and then
>   read the pin state via the input register.
>   For use as output, connect external pull-up resistor to the
>   pin and size it according to the DC recommended operating
>   characteristics. LED output pin is HIGH when the output is
>   programmed as high-impedance, and LOW when the output is
>   programmed LOW through the ‘LED selector’ register. The
>   output can be pulse-width controlled when PWM0 or PWM1 are
>   used.
>
>
> And chapter 8 'Application design-in information':
> 
>   LED0 to LED12 are used as LED drivers.
>   LED13 to LED15 are used as regular GPIOs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/misc/pca9552.h |  2 ++
>  hw/misc/pca9552.c         | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
> index ebb43c63fe..7e47ea312d 100644
> --- a/include/hw/misc/pca9552.h
> +++ b/include/hw/misc/pca9552.h
> @@ -15,6 +15,7 @@
>  #define PCA9552(obj) OBJECT_CHECK(PCA9552State, (obj), TYPE_PCA9552)
>  
>  #define PCA9552_NR_REGS 10
> +#define PCA9552_NR_GPIOS 3
>  
>  typedef struct PCA9552State {
>      /*< private >*/
> @@ -27,6 +28,7 @@ typedef struct PCA9552State {
>      uint8_t regs[PCA9552_NR_REGS];
>      uint8_t max_reg;
>      uint8_t nr_leds;
> +    qemu_irq gpio[PCA9552_NR_GPIOS];
>  } PCA9552State;
>  
>  #endif
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index a3d0decbff..6ca6c0dbc2 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -12,8 +12,10 @@
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "qemu/bitops.h"
>  #include "hw/misc/pca9552.h"
>  #include "hw/misc/pca9552_regs.h"
> +#include "hw/irq.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> @@ -48,12 +50,16 @@ static void pca9552_update_pin_input(PCA9552State *s)
>              s->regs[input_reg] |= 1 << input_shift;
>              if (input_shift < s->nr_leds) {
>                  trace_pca9552_led_set(input_shift, true);
> +            } else {
> +                qemu_set_irq(s->gpio[input_shift - s->nr_leds], 1);

It is simpler to set the irq level in pca9552_gpio_set().

>              }
>              break;
>          case PCA9552_LED_OFF:
>              s->regs[input_reg] &= ~(1 << input_shift);
>              if (input_shift < s->nr_leds) {
>                  trace_pca9552_led_set(input_shift, false);
> +            } else {
> +                qemu_set_irq(s->gpio[input_shift - s->nr_leds], 0);
>              }
>              break;
>          case PCA9552_LED_PWM0:
> @@ -65,6 +71,16 @@ static void pca9552_update_pin_input(PCA9552State *s)
>      }
>  }
>  
> +static void pca9552_gpio_set(void *opaque, int n, int enable)
> +{
> +    PCA9552State *s = opaque;
> +
> +    /* LED13 to LED15 are used as regular GPIOs. */
> +    s->regs[PCA9552_LS3] = deposit32(s->regs[PCA9552_LS3], n + 1, 1,
> +                                     enable ? PCA9552_LED_ON : PCA9552_LED_OFF);> +    pca9552_update_pin_input(s);

I would introduce a set_pin() helper instead. See pca9552_pin_get_config().
pca9552_gpio_set() would look like :

	pca9552_set_pin(s, n, enable ? PCA9552_LED_ON : PCA9552_LED_OFF);
	pca9552_update_pin_input(s);
	qemu_set_irq(s->gpio[n], enable);

> +}
> +
>  static uint8_t pca9552_read(PCA9552State *s, uint8_t reg)
>  {
>      switch (reg) {
> @@ -308,6 +324,8 @@ static void pca9552_initfn(Object *obj)
>                              NULL, NULL);
>          g_free(name);
>      }
> +    qdev_init_gpio_in(DEVICE(obj), pca9552_gpio_set, PCA9552_NR_GPIOS);
> +    qdev_init_gpio_out(DEVICE(obj), s->gpio, PCA9552_NR_GPIOS);
>  }
>  
>  static void pca9552_class_init(ObjectClass *klass, void *data)
> 


