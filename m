Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D4CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1140C2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1140C2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnc3s-00031q-Bo
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 02:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnc36-00028q-3G
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 02:04:48 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:46205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnc33-0003av-D7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 02:04:47 -0400
Received: from player770.ha.ovh.net (unknown [10.110.208.168])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id E73F7A743B
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:04:42 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id 0B1BE13B83C25;
 Tue, 23 Jun 2020 06:04:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005bb6fd418-f195-42fa-9c2e-2cb2f37260b5,EED1DA90FC9B795DFFB5AB62ED4F19E3D36D96F8)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v5 8/9] hw/misc/pca9552: Trace GPIO change events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200622183428.12255-1-f4bug@amsat.org>
 <20200622183428.12255-9-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <78e0f05b-fca9-8ce3-6034-eb70f99588e2@kaod.org>
Date: Tue, 23 Jun 2020 08:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622183428.12255-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11203267025706257328
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekfedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeeihfekfeduiefhhfdvleduheduleekgedtieelgfehfffhveeikeduhfffgeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpkeeirddvuddtrdduhedvrddvgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.251.53; envelope-from=clg@kaod.org;
 helo=1.mo178.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:04:43
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
> Emit a trace event when a GPIO change its state.
> 
> Example booting obmc-phosphor-image:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace pca955x_gpio_change
>   1592690552.687372:pca955x_gpio_change pca1 GPIO id:0 status: 0 -> 1
>   1592690552.690169:pca955x_gpio_change pca1 GPIO id:1 status: 0 -> 1
>   1592690552.691673:pca955x_gpio_change pca1 GPIO id:2 status: 0 -> 1
>   1592690552.696886:pca955x_gpio_change pca1 GPIO id:3 status: 0 -> 1
>   1592690552.698614:pca955x_gpio_change pca1 GPIO id:13 status: 0 -> 1
>   1592690552.699833:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690552.700842:pca955x_gpio_change pca1 GPIO id:15 status: 0 -> 1
>   1592690683.841921:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690683.861660:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690684.371460:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690684.882115:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690685.391411:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690685.901391:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690686.411678:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690686.921279:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
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
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>


> ---
>  hw/misc/pca9552.c    | 15 +++++++++++++++
>  hw/misc/trace-events |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index 13f5ed0da4..5997eef8b2 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -82,6 +82,21 @@ static void pca955x_display_pins_status(PCA955xState *s,
>          buf[i] = '\0';
>          trace_pca955x_gpio_status(s->description, buf);
>      }
> +    if (trace_event_get_state_backends(TRACE_PCA955X_GPIO_CHANGE)) {
> +        for (i = 0; i < k->pin_count; i++) {
> +            if (extract32(pins_changed, i, 1)) {
> +                unsigned new_state = extract32(pins_status, i, 1);
> +
> +                /*
> +                 * We display the state using the PCA logic ("active-high").
> +                 * This is not the state of the LED, which signal might be
> +                 * wired "active-low" on the board.
> +                 */
> +                trace_pca955x_gpio_change(s->description, i,
> +                                          !new_state, new_state);
> +            }
> +        }
> +    }
>  }
>  
>  static void pca955x_update_pin_input(PCA955xState *s)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 9282c60dd9..7ccf683dd1 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -209,3 +209,4 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
>  
>  # pca9552.c
>  pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
> +pca955x_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
> 


