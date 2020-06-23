Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77EFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0EE20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0EE20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnc34-0001oN-RI
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 02:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnc1u-0008NW-OU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 02:03:34 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:40365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnc1r-0002u5-Hq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 02:03:34 -0400
Received: from player697.ha.ovh.net (unknown [10.110.103.23])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 3EEF796856
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:03:28 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id BAE4A13A414DE;
 Tue, 23 Jun 2020 06:03:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0035516bf16-d497-474d-9cda-9dc3451dd498,EED1DA90FC9B795DFFB5AB62ED4F19E3D36D96F8)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v5 6/9] hw/misc/pca9552: Trace GPIO High/Low events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200622183428.12255-1-f4bug@amsat.org>
 <20200622183428.12255-7-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <68f55b15-e2c3-45fb-c834-d0e129249d7b@kaod.org>
Date: Tue, 23 Jun 2020 08:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622183428.12255-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11182156402256219056
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekfedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeeihfekfeduiefhhfdvleduheduleekgedtieelgfehfffhveeikeduhfffgeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpkeeirddvuddtrdduhedvrddvgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeljedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.43.105; envelope-from=clg@kaod.org;
 helo=5.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:03:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 8:34 PM, Philippe Mathieu-Daudé wrote:
> Add a trivial representation of the PCA9552 GPIOs.
> 
> Example booting obmc-phosphor-image:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace pca955x_gpio_status
>   1592689902.327837:pca955x_gpio_status pca-unspecified GPIOs 0-15 [*...............]
>   1592689902.329934:pca955x_gpio_status pca-unspecified GPIOs 0-15 [**..............]
>   1592689902.330717:pca955x_gpio_status pca-unspecified GPIOs 0-15 [***.............]
>   1592689902.331431:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****............]
>   1592689902.332163:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*..]
>   1592689902.332888:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........**.]
>   1592689902.333629:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
>   1592690032.793289:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
>   1592690033.303163:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
>   1592690033.812962:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
>   1592690034.323234:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
>   1592690034.832922:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
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

Reviewed-by: Cédric Le Goater <clg@kaod.org>


> ---
>  hw/misc/pca9552.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  hw/misc/trace-events |  3 +++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index d6d84c6451..13f5ed0da4 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -13,12 +13,14 @@
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
>  typedef struct PCA955xClass {
>      /*< private >*/
> @@ -49,6 +51,39 @@ static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
>      return extract32(s->regs[reg], shift, 2);
>  }
>  
> +/* Return INPUT status (bit #N belongs to GPIO #N) */
> +static uint16_t pca955x_pins_get_status(PCA955xState *s)
> +{
> +    return (s->regs[PCA9552_INPUT1] << 8) | s->regs[PCA9552_INPUT0];
> +}
> +
> +static void pca955x_display_pins_status(PCA955xState *s,
> +                                        uint16_t previous_pins_status)
> +{
> +    PCA955xClass *k = PCA955X_GET_CLASS(s);
> +    uint16_t pins_status, pins_changed;
> +    int i;
> +
> +    pins_status = pca955x_pins_get_status(s);
> +    pins_changed = previous_pins_status ^ pins_status;
> +    if (!pins_changed) {
> +        return;
> +    }
> +    if (trace_event_get_state_backends(TRACE_PCA955X_GPIO_STATUS)) {
> +        char *buf = g_newa(char, k->pin_count + 1);
> +
> +        for (i = 0; i < k->pin_count; i++) {
> +            if (extract32(pins_status, i, 1)) {
> +                buf[i] = '*';
> +            } else {
> +                buf[i] = '.';
> +            }
> +        }
> +        buf[i] = '\0';
> +        trace_pca955x_gpio_status(s->description, buf);
> +    }
> +}
> +
>  static void pca955x_update_pin_input(PCA955xState *s)
>  {
>      PCA955xClass *k = PCA955X_GET_CLASS(s);
> @@ -98,6 +133,8 @@ static uint8_t pca955x_read(PCA955xState *s, uint8_t reg)
>  
>  static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
>  {
> +    uint16_t pins_status;
> +
>      switch (reg) {
>      case PCA9552_PSC0:
>      case PCA9552_PWM0:
> @@ -110,8 +147,10 @@ static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
>      case PCA9552_LS1:
>      case PCA9552_LS2:
>      case PCA9552_LS3:
> +        pins_status = pca955x_pins_get_status(s);
>          s->regs[reg] = data;
>          pca955x_update_pin_input(s);
> +        pca955x_display_pins_status(s, pins_status);
>          break;
>  
>      case PCA9552_INPUT0:
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 5561746866..9282c60dd9 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
>  # grlib_ahb_apb_pnp.c
>  grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
>  grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
> +
> +# pca9552.c
> +pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
> 


