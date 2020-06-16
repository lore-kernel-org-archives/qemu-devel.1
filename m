Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D731C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D212208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D212208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEEB-00005a-Mh
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlEDJ-0007n4-Ro
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:13:29 -0400
Received: from 11.mo6.mail-out.ovh.net ([188.165.38.119]:51705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlEDG-0005Mb-6w
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:13:29 -0400
Received: from player772.ha.ovh.net (unknown [10.108.57.178])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id CBEEB21A5D8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 18:13:22 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 260F6137DED0D;
 Tue, 16 Jun 2020 16:13:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0028284699e-bacd-44c9-8e8a-fb2914693776,EBFB3A1CCBA6C973625B067ACEBAD7C75398389C)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 1/2] hw/misc/pca9552: Trace LED On/Off events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200616094542.25415-1-f4bug@amsat.org>
 <20200616094542.25415-2-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ce02c953-073a-3843-5830-930cc194117c@kaod.org>
Date: Tue, 16 Jun 2020 18:13:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616094542.25415-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17267363925485521678
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -77
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudejtddguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculddvfedmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhvedvheeifedtveefleelfffghedtgfdvgeetieejtedujeeguddtudduhfetkeenucffohhmrghinhepohhpvghnphhofigvrhdrgiihiienucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.38.119; envelope-from=clg@kaod.org;
 helo=11.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 12:13:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, PDS_OTHER_BAD_TLD=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>

Download an OpenBMC witherspoon flash image : 

wget https://openpower.xyz/job/openbmc-build/lastSuccessfulBuild/distro=ubuntu,label=builder,target=witherspoon/artifact/deploy/images/witherspoon/obmc-phosphor-image-witherspoon.ubi.mtd

and run :

qemu-system-arm -M witherspoon-bmc -nic user -drive file=obmc-phosphor-image-witherspoon.ubi.mtd,format=raw,if=mtd -nographic

The system has a set of daemons controlling the status of the leds :

 1148 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/cffps1/68
 1149 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/cffps1/69
 1150 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/fan0
 1151 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/fan1
 1152 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/fan2
 1153 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/fan3
 1154 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/front/fault
 1155 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/front/id
 1156 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/front/power
 1157 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/power/button
 1158 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/rear/fault
 1159 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/rear/id
 1160 root      7164 S    phosphor-ledcontroller -p /sys/class/leds/rear/power


If activated, the pca9552 traces will appear on the QEMU monitor.

Thanks,

C.

> ---
>  hw/misc/pca9552.c    | 7 +++++++
>  hw/misc/trace-events | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index cac729e35a..a3d0decbff 100644
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
> @@ -45,9 +46,15 @@ static void pca9552_update_pin_input(PCA9552State *s)
>          switch (config) {
>          case PCA9552_LED_ON:
>              s->regs[input_reg] |= 1 << input_shift;
> +            if (input_shift < s->nr_leds) {
> +                trace_pca9552_led_set(input_shift, true);
> +            }
>              break;
>          case PCA9552_LED_OFF:
>              s->regs[input_reg] &= ~(1 << input_shift);
> +            if (input_shift < s->nr_leds) {
> +                trace_pca9552_led_set(input_shift, false);
> +            }
>              break;
>          case PCA9552_LED_PWM0:
>          case PCA9552_LED_PWM1:
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 5561746866..ed80d0d1be 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
>  # grlib_ahb_apb_pnp.c
>  grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
>  grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
> +
> +# pca9552.c
> +pca9552_led_set(unsigned id, bool state) "LED#%d state:%u"
> 


