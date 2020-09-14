Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA10C2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57C6217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ywzi0+8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57C6217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHiqf-00027k-Nc
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kHil4-0001G1-5a; Mon, 14 Sep 2020 03:18:38 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:53830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kHil1-0002Ab-SZ; Mon, 14 Sep 2020 03:18:37 -0400
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 4972621CBE;
 Mon, 14 Sep 2020 07:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1600067913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A89+Y/YS0F2NELAwIXVDjCWosVtbGtEz99wSRvRoBRc=;
 b=ywzi0+8yIjlJh1bJ0wnywgKZJL/8RcnWSo3IJd42U+IuxanNqnh22jUIiGpu6DYWLCry60
 pLQl9K4DZISHAarPp7fpYF0yqGBTjfmp2J0OSbw6YMhI9H76McAHYw+3sIlE+hQciseB/c
 0BF4wfNJA18SM0qF+OYHDGXKFBhzWgA=
Subject: Re: [PATCH v6 6/7] hw/misc/mps2-scc: Use the LED device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200912134041.946260-1-f4bug@amsat.org>
 <20200912134041.946260-7-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <83f6f8d3-f03b-e818-2647-1ca469919b81@greensocs.com>
Date: Mon, 14 Sep 2020 09:19:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200912134041.946260-7-f4bug@amsat.org>
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 3:40 PM, Philippe Mathieu-Daudé wrote:
> Per the 'ARM MPS2 and MPS2+ FPGA Prototyping Boards Technical
> Reference Manual' (100112_0200_07_en):
> 
>    2.1  Overview of the MPS2 and MPS2+ hardware
> 
>         The MPS2 and MPS2+ FPGA Prototyping Boards contain the
>         following components and interfaces:
> 
>         * User switches and user LEDs:
> 
>           - Two green LEDs and two push buttons that connect to
>             the FPGA.
>           - Eight green LEDs and one 8-way dip switch that connect
>             to the MCC.
> 
> Add the 8 LEDs connected to the MCC.
> 
> This replaces the 'mps2_scc_leds' trace events by the generic
> 'led_set_intensity' event.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>   include/hw/misc/mps2-scc.h |  2 ++
>   hw/misc/mps2-scc.c         | 27 ++++++++++++++++-----------
>   hw/misc/Kconfig            |  1 +
>   hw/misc/trace-events       |  1 -
>   4 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/misc/mps2-scc.h b/include/hw/misc/mps2-scc.h
> index 445e268b1fd..0009479ae83 100644
> --- a/include/hw/misc/mps2-scc.h
> +++ b/include/hw/misc/mps2-scc.h
> @@ -13,6 +13,7 @@
>   #define MPS2_SCC_H
>   
>   #include "hw/sysbus.h"
> +#include "hw/misc/led.h"
>   #include "qom/object.h"
>   
>   #define TYPE_MPS2_SCC "mps2-scc"
> @@ -28,6 +29,7 @@ struct MPS2SCC {
>   
>       /*< public >*/
>       MemoryRegion iomem;
> +    LEDState *led[8];
>   
>       uint32_t cfg0;
>       uint32_t cfg1;
> diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
> index 9d0909e7b35..ce1dfe93562 100644
> --- a/hw/misc/mps2-scc.c
> +++ b/hw/misc/mps2-scc.c
> @@ -20,11 +20,13 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "qemu/module.h"
> +#include "qemu/bitops.h"
>   #include "trace.h"
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
>   #include "hw/registerfields.h"
>   #include "hw/misc/mps2-scc.h"
> +#include "hw/misc/led.h"
>   #include "hw/qdev-properties.h"
>   
>   REG32(CFG0, 0)
> @@ -152,18 +154,10 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
>           s->cfg0 = value;
>           break;
>       case A_CFG1:
> -        /* CFG1 bits [7:0] control the board LEDs. We don't currently have
> -         * a mechanism for displaying this graphically, so use a trace event.
> -         */
> -        trace_mps2_scc_leds(value & 0x80 ? '*' : '.',
> -                            value & 0x40 ? '*' : '.',
> -                            value & 0x20 ? '*' : '.',
> -                            value & 0x10 ? '*' : '.',
> -                            value & 0x08 ? '*' : '.',
> -                            value & 0x04 ? '*' : '.',
> -                            value & 0x02 ? '*' : '.',
> -                            value & 0x01 ? '*' : '.');
>           s->cfg1 = value;
> +        for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
> +            led_set_state(s->led[i], extract32(value, i, 1));
> +        }
>           break;
>       case A_CFGDATA_OUT:
>           s->cfgdata_out = value;
> @@ -236,6 +230,9 @@ static void mps2_scc_reset(DeviceState *dev)
>       for (i = 0; i < NUM_OSCCLK; i++) {
>           s->oscclk[i] = s->oscclk_reset[i];
>       }
> +    for (i = 0; i < ARRAY_SIZE(s->led); i++) {
> +        device_cold_reset(DEVICE(s->led[i]));
> +    }
>   }
>   
>   static void mps2_scc_init(Object *obj)
> @@ -249,6 +246,14 @@ static void mps2_scc_init(Object *obj)
>   
>   static void mps2_scc_realize(DeviceState *dev, Error **errp)
>   {
> +    MPS2SCC *s = MPS2_SCC(dev);
> +
> +    for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
> +        char *name = g_strdup_printf("SCC LED%zu", i);
> +        s->led[i] = led_create_simple(OBJECT(dev), GPIO_POLARITY_ACTIVE_HIGH,
> +                                      LED_COLOR_GREEN, name);
> +        g_free(name);
> +    }
>   }
>   
>   static const VMStateDescription mps2_scc_vmstate = {
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 0cecad45aad..7557a3e7b46 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -97,6 +97,7 @@ config MPS2_FPGAIO
>   
>   config MPS2_SCC
>       bool
> +    select LED
>   
>   config TZ_MPC
>       bool
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 908272e8593..97f511aa58c 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -84,7 +84,6 @@ aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64
>   mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>   mps2_scc_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>   mps2_scc_reset(void) "MPS2 SCC: reset"
> -mps2_scc_leds(char led7, char led6, char led5, char led4, char led3, char led2, char led1, char led0) "MPS2 SCC LEDs: %c%c%c%c%c%c%c%c"
>   mps2_scc_cfg_write(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config write: function %d device %d data 0x%" PRIx32
>   mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config read: function %d device %d data 0x%" PRIx32
>   
> 

