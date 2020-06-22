Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D59C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3098D2486E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3098D2486E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnGTx-0001DI-DA
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 03:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnGSG-0008UL-Ij
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:01:20 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:44628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnGSD-000471-Fc
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:01:20 -0400
Received: from player734.ha.ovh.net (unknown [10.108.42.142])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id B67591CE7CB
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 09:01:13 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id EB30E1372A9F4;
 Mon, 22 Jun 2020 07:01:05 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0062547f419-40b9-4bb2-ac8c-1091180729f0,D5B34DF2F1998B4AFDB97B5973F1BB92C24DD330)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v4 7/8] hw/misc/pca9552: Trace GPIO change events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-8-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fb024d85-9730-e31d-622c-60601d75c7f3@kaod.org>
Date: Mon, 22 Jun 2020 09:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620225854.31160-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6285054758826249131
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekuddguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeeihfekfeduiefhhfdvleduheduleekgedtieelgfehfffhveeikeduhfffgeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpkeeirddvuddtrdduhedvrddvgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.48.182; envelope-from=clg@kaod.org;
 helo=7.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:01:15
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
> Emit a trace event when a GPIO change its state.

I understand now why you need 'pin_status'. 

We could compute 'pin_status' and 'pin_changed' in routine 
pca9552_update_pin_input() when updating the PCA9552_INPUT0/1 
register values and pass them to pca9552_display_pins_status()
or something like that.

Maybe add two different display routines also. 
 
> 
> Example booting obmc-phosphor-image:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace pca9552_gpio_change
>   1592690552.687372:pca9552_gpio_change pca1 GPIO id:0 status: 0 -> 1
>   1592690552.690169:pca9552_gpio_change pca1 GPIO id:1 status: 0 -> 1
>   1592690552.691673:pca9552_gpio_change pca1 GPIO id:2 status: 0 -> 1
>   1592690552.696886:pca9552_gpio_change pca1 GPIO id:3 status: 0 -> 1
>   1592690552.698614:pca9552_gpio_change pca1 GPIO id:13 status: 0 -> 1
>   1592690552.699833:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690552.700842:pca9552_gpio_change pca1 GPIO id:15 status: 0 -> 1
>   1592690683.841921:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690683.861660:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690684.371460:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690684.882115:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690685.391411:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690685.901391:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690686.411678:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690686.921279:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
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
> ---
>  hw/misc/pca9552.c    | 15 +++++++++++++++
>  hw/misc/trace-events |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index f0d435e310..85557b78d9 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -60,6 +60,21 @@ static void pca9552_display_pins_status(PCA9552State *s)
>          buf[i] = '\0';
>          trace_pca9552_gpio_status(s->description, buf);
>      }
> +    if (trace_event_get_state_backends(TRACE_PCA9552_GPIO_CHANGE)) {
> +        for (i = 0; i < s->nr_leds; i++) {
> +            if (extract32(pins_changed, i, 1)) {
> +                unsigned new_state = extract32(pins_status, i, 1);
> +
> +                /*
> +                 * We display the state using the PCA logic ("active-high").
> +                 * This is not the state of the LED, which signal might be
> +                 * wired "active-low" on the board.
> +                 */
> +                trace_pca9552_gpio_change(s->description, i,
> +                                          !new_state, new_state);
> +            }
> +        }
> +    }
>  }
>  
>  static void pca9552_update_pin_input(PCA9552State *s)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 7630e59652..805d2110e0 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -209,3 +209,4 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
>  
>  # pca9552.c
>  pca9552_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
> +pca9552_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
> 


