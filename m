Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B0DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C3125429
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C3125429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnGGR-0001hc-54
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 02:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnGFZ-00012Q-HA
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 02:48:13 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:35450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnGFW-0001vc-T5
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 02:48:13 -0400
Received: from player793.ha.ovh.net (unknown [10.108.57.49])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id C6DA11CC03A
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 08:48:08 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 1A268139F96AF;
 Mon, 22 Jun 2020 06:47:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002b68c1cf3-1eae-4278-ac23-8ee7fc1be797,D5B34DF2F1998B4AFDB97B5973F1BB92C24DD330)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v4 5/8] hw/misc/pca9552: Trace GPIO High/Low events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-6-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9e93c3d7-0896-07fa-3129-2f0142999ab5@kaod.org>
Date: Mon, 22 Jun 2020 08:47:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620225854.31160-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6064096898674887595
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekuddguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeeihfekfeduiefhhfdvleduheduleekgedtieelgfehfffhveeikeduhfffgeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpkeeirddvuddtrdduhedvrddvgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.43.205; envelope-from=clg@kaod.org;
 helo=6.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:48:09
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <cminyard@mvista.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
> Add a trivial representation of the PCA9552 GPIOs.
> 
> Example booting obmc-phosphor-image:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace pca9552_gpio_status
>   1592689902.327837:pca9552_gpio_status pca-unspecified GPIOs 0-15 [*...............]
>   1592689902.329934:pca9552_gpio_status pca-unspecified GPIOs 0-15 [**..............]
>   1592689902.330717:pca9552_gpio_status pca-unspecified GPIOs 0-15 [***.............]
>   1592689902.331431:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****............]
>   1592689902.332163:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........*..]
>   1592689902.332888:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........**.]
>   1592689902.333629:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
>   1592690032.793289:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
>   1592690033.303163:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
>   1592690033.812962:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
>   1592690034.323234:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
>   1592690034.832922:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
> 
> We notice the GPIO #14 (front-power LED) starts to blink.
> 
> This LED is described in the witherspoon device-tree [*]:
> 
>   front-power {
>       retain-state-shutdown;
>       default-state = "keep";
>       gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
>   };
> 
> [*] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts?id=b1f9be9392f0#n140
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/misc/pca9552.h |  1 +
>  hw/misc/pca9552.c         | 29 +++++++++++++++++++++++++++++
>  hw/misc/trace-events      |  3 +++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
> index c5be7f1c5e..755be2e8e5 100644
> --- a/include/hw/misc/pca9552.h
> +++ b/include/hw/misc/pca9552.h
> @@ -26,6 +26,7 @@ typedef struct PCA9552State {
>      uint8_t pointer;
>  
>      uint8_t regs[PCA9552_NR_REGS];
> +    uint16_t pins_status; /* Holds latest INPUT0 & INPUT1 status */

Hmm, that is an extra state redundant with regs.

>      uint8_t max_reg;
>      char *description; /* For debugging purpose only */
>      uint8_t nr_leds;
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index 54ccdcf6d4..f0d435e310 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -12,12 +12,14 @@
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "qemu/bitops.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/misc/pca9552.h"
>  #include "hw/misc/pca9552_regs.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> +#include "trace.h"
>  
>  #define PCA9552_LED_ON   0x0
>  #define PCA9552_LED_OFF  0x1
> @@ -34,6 +36,32 @@ static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
>      return extract32(s->regs[reg], shift, 2);
>  }
>  
> +static void pca9552_display_pins_status(PCA9552State *s)
> +{
> +    uint16_t pins_status, pins_changed;
> +    int i;
> +
> +    pins_status = (s->regs[PCA9552_INPUT1] << 8) | s->regs[PCA9552_INPUT0];
> +    pins_changed = s->pins_status ^ pins_status;
> +    if (!pins_changed) {
> +        return;
> +    }
> +    s->pins_status = pins_status;

It's nice to have but it won't kill puppies if we recompute the 
state each time when traces are on. 

> +    if (trace_event_get_state_backends(TRACE_PCA9552_GPIO_STATUS)) {
> +        char buf[PCA9552_PIN_COUNT + 1];
> +
> +        for (i = 0; i < s->nr_leds; i++) {
> +            if (extract32(pins_status, i, 1)) {
> +                buf[i] = '*';
> +            } else {
> +                buf[i] = '.';
> +            }
> +        }
> +        buf[i] = '\0';
> +        trace_pca9552_gpio_status(s->description, buf);
> +    }
> +}
> +
>  static void pca9552_update_pin_input(PCA9552State *s)
>  {
>      int i;
> @@ -57,6 +85,7 @@ static void pca9552_update_pin_input(PCA9552State *s)
>              break;
>          }

and we could test TRACE_PCA9552_GPIO_STATUS here : 
>      }
> +    pca9552_display_pins_status(s);
>  }
>  
>  static uint8_t pca9552_read(PCA9552State *s, uint8_t reg)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 5561746866..7630e59652 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
>  # grlib_ahb_apb_pnp.c
>  grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
>  grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
> +
> +# pca9552.c
> +pca9552_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
> 


