Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0809C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72FA21475
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72FA21475
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSkG-0004sp-2F
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlSg4-0006X5-Dc
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:40:09 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:41338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlSg1-0004w0-LE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:40:08 -0400
Received: from player732.ha.ovh.net (unknown [10.108.42.145])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id B463E284C45
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:40:02 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id 0B5DB135614FC;
 Wed, 17 Jun 2020 07:39:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00226115da8-341e-42d1-a4fb-ea711af0f1cf,ABECD89738EEB0C75E5395B338997A57DB3A3EEE)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2] hw/misc/pca9552: Trace LED On/Off events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200617064734.26956-1-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <46689112-c5cc-0cac-fc93-0bfb57f404fc@kaod.org>
Date: Wed, 17 Jun 2020 09:39:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617064734.26956-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14470628553968421828
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeeihfekfeduiefhhfdvleduheduleekgedtieelgfehfffhveeikeduhfffgeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.52.148; envelope-from=clg@kaod.org;
 helo=10.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 03:40:03
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
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 8:47 AM, Philippe Mathieu-Daudé wrote:
> Example booting obmc-phosphor-image:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace pca\*
>   26033@1592376001.873828:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
>   26033@1592376001.874169:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
>   26033@1592376001.874348:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
>   26033@1592376001.874514:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
>   26033@1592376001.879601:pca9552_led_state 0x5594a9f57560 LEDs [........ .......*]
>   26033@1592376001.880507:pca9552_led_state 0x5594a9f57560 LEDs [........ ......**]
>   26033@1592376001.880885:pca9552_led_state 0x5594a9f57560 LEDs [........ .....***]
>   26033@1592376001.881228:pca9552_led_state 0x5594a9f57560 LEDs [........ ....****]
>   26033@1592376001.881601:pca9552_led_state 0x5594a9f57560 LEDs [..*..... ....****]
>   26033@1592376001.881952:pca9552_led_state 0x5594a9f57560 LEDs [.**..... ....****]
>   26033@1592376001.882299:pca9552_led_state 0x5594a9f57560 LEDs [***..... ....****]
>   26033@1592376065.090910:pca9552_led_state 0x5594a9f57560 LEDs [*.*..... ....****]
>   26033@1592376065.600649:pca9552_led_state 0x5594a9f57560 LEDs [***..... ....****]
>   26033@1592376066.110565:pca9552_led_state 0x5594a9f57560 LEDs [*.*..... ....****]
>   26033@1592376066.620390:pca9552_led_state 0x5594a9f57560 LEDs [***..... ....****]

It looks better but the ordering is wrong.

> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/misc/pca9552.c    | 18 ++++++++++++++++++
>  hw/misc/trace-events |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index cac729e35a..693f6c3b24 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -17,6 +17,7 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> +#include "trace.h"
>  
>  #define PCA9552_LED_ON   0x0
>  #define PCA9552_LED_OFF  0x1
> @@ -95,6 +96,23 @@ static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
>      case PCA9552_LS3:
>          s->regs[reg] = data;
>          pca9552_update_pin_input(s);
> +        if (trace_event_get_state_backends(TRACE_PCA9552_LED_STATE)) {
> +            char buf[2][9];
> +
> +            for (int i = 0; i < 2; i++) {
> +                uint8_t val = s->regs[PCA9552_INPUT0 + i];
> +                sprintf(buf[i], "%c%c%c%c%c%c%c%c",
> +                        val & 0x80 ? '*' : '.',
> +                        val & 0x40 ? '*' : '.',
> +                        val & 0x20 ? '*' : '.',
> +                        val & 0x10 ? '*' : '.',
> +                        val & 0x08 ? '*' : '.',
> +                        val & 0x04 ? '*' : '.',
> +                        val & 0x02 ? '*' : '.',
> +                        val & 0x01 ? '*' : '.');
> +            }
> +            trace_pca9552_led_state(s, buf[1], buf[0]);
> +        }
>          break;

or something like this : 

 static void pca9552_update_pin_input(PCA9552State *s)
 {
     int i;
+    char state[s->nr_leds + 1];
 
     for (i = 0; i < s->nr_leds; i++) {
         uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
@@ -45,9 +47,11 @@ static void pca9552_update_pin_input(PCA
         switch (config) {
         case PCA9552_LED_ON:
             s->regs[input_reg] |= 1 << input_shift;
+            state[i] = '*';
             break;
         case PCA9552_LED_OFF:
             s->regs[input_reg] &= ~(1 << input_shift);
+            state[i] = '.';
             break;
         case PCA9552_LED_PWM0:
         case PCA9552_LED_PWM1:
@@ -56,6 +60,9 @@ static void pca9552_update_pin_input(PCA
             break;
         }
     }
+    state[i] = 0;
+
+    trace_pca9552_led_state(s, state);
 }



The pin usage is described in the witherspoon DTS : 

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts?id=b1f9be9392f0#n78

The front-power led is blinking. I suppose it means the BMC is on but not the host.￼


Cheers,

C. 

>  
>      case PCA9552_INPUT0:
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 5561746866..21e52f192d 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
>  # grlib_ahb_apb_pnp.c
>  grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
>  grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
> +
> +# pca9552.c
> +pca9552_led_state(void *object, const char *bufhi, const char *buflo) "%p LEDs [%s %s]"
> 


