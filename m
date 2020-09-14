Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFDCC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F11217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="cAg3RQKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F11217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHitO-0004Db-0F
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kHikt-0000oH-AU; Mon, 14 Sep 2020 03:18:27 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:53774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kHikr-00029f-7Y; Mon, 14 Sep 2020 03:18:26 -0400
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 6378A21CBE;
 Mon, 14 Sep 2020 07:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1600067902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tl8+9pox6Y0GrVZQtjT/RRM08CiZQzm/z7WLyiFM7QE=;
 b=cAg3RQKxS+3savFp6Ufp2fUi+7DaHkPCkPfRqZaMGkMoZiKzPx6VlnXKzxhiN5LHardiZm
 vNp+0bP5LmTAol7xkNiP+QaH3ucEZJjL8lLOz+aTrjoBzxsKYfeyKiLT6eWQCZUwuxvMM5
 TLt/j656q6F/5A8t9rpxoQIJZsq+ie8=
Subject: Re: [PATCH v6 5/7] hw/misc/mps2-fpgaio: Use the LED device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200912134041.946260-1-f4bug@amsat.org>
 <20200912134041.946260-6-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <1cc1dc36-4f6c-7001-8af1-0009ce6c1596@greensocs.com>
Date: Mon, 14 Sep 2020 09:19:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200912134041.946260-6-f4bug@amsat.org>
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
> Add the 2 LEDs connected to the FPGA.
> 
> This replaces the 'mps2_fpgaio_leds' trace events by the generic
> 'led_set_intensity' event.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>   include/hw/misc/mps2-fpgaio.h |  2 ++
>   hw/misc/mps2-fpgaio.c         | 23 ++++++++++++++++++-----
>   hw/misc/Kconfig               |  1 +
>   hw/misc/trace-events          |  1 -
>   4 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/misc/mps2-fpgaio.h b/include/hw/misc/mps2-fpgaio.h
> index 991f5b731e8..513e3be6f13 100644
> --- a/include/hw/misc/mps2-fpgaio.h
> +++ b/include/hw/misc/mps2-fpgaio.h
> @@ -22,6 +22,7 @@
>   #define MPS2_FPGAIO_H
>   
>   #include "hw/sysbus.h"
> +#include "hw/misc/led.h"
>   #include "qom/object.h"
>   
>   #define TYPE_MPS2_FPGAIO "mps2-fpgaio"
> @@ -35,6 +36,7 @@ struct MPS2FPGAIO {
>   
>       /*< public >*/
>       MemoryRegion iomem;
> +    LEDState *led[2];
>   
>       uint32_t led0;
>       uint32_t prescale;
> diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
> index 2f3fbeef348..6af0e8f837a 100644
> --- a/hw/misc/mps2-fpgaio.c
> +++ b/hw/misc/mps2-fpgaio.c
> @@ -24,6 +24,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/registerfields.h"
>   #include "hw/misc/mps2-fpgaio.h"
> +#include "hw/misc/led.h"
>   #include "hw/qdev-properties.h"
>   #include "qemu/timer.h"
>   
> @@ -176,12 +177,9 @@ static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
>   
>       switch (offset) {
>       case A_LED0:
> -        /* LED bits [1:0] control board LEDs. We don't currently have
> -         * a mechanism for displaying this graphically, so use a trace event.
> -         */
> -        trace_mps2_fpgaio_leds(value & 0x02 ? '*' : '.',
> -                               value & 0x01 ? '*' : '.');
>           s->led0 = value & 0x3;
> +        led_set_state(s->led[0], value & 0x01);
> +        led_set_state(s->led[1], value & 0x02);
>           break;
>       case A_PRESCALE:
>           resync_counter(s);
> @@ -239,6 +237,10 @@ static void mps2_fpgaio_reset(DeviceState *dev)
>       s->counter = 0;
>       s->pscntr = 0;
>       s->pscntr_sync_ticks = now;
> +
> +    for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
> +        device_cold_reset(DEVICE(s->led[i]));
> +    }
>   }
>   
>   static void mps2_fpgaio_init(Object *obj)
> @@ -251,6 +253,16 @@ static void mps2_fpgaio_init(Object *obj)
>       sysbus_init_mmio(sbd, &s->iomem);
>   }
>   
> +static void mps2_fpgaio_realize(DeviceState *dev, Error **errp)
> +{
> +    MPS2FPGAIO *s = MPS2_FPGAIO(dev);
> +
> +    s->led[0] = led_create_simple(OBJECT(dev), GPIO_POLARITY_ACTIVE_HIGH,
> +                                  LED_COLOR_GREEN, "USERLED0");
> +    s->led[1] = led_create_simple(OBJECT(dev), GPIO_POLARITY_ACTIVE_HIGH,
> +                                  LED_COLOR_GREEN, "USERLED1");
> +}
> +
>   static bool mps2_fpgaio_counters_needed(void *opaque)
>   {
>       /* Currently vmstate.c insists all subsections have a 'needed' function */
> @@ -299,6 +311,7 @@ static void mps2_fpgaio_class_init(ObjectClass *klass, void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->vmsd = &mps2_fpgaio_vmstate;
> +    dc->realize = mps2_fpgaio_realize;
>       dc->reset = mps2_fpgaio_reset;
>       device_class_set_props(dc, mps2_fpgaio_properties);
>   }
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 5c151fa3a83..0cecad45aad 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -93,6 +93,7 @@ config MIPS_ITU
>   
>   config MPS2_FPGAIO
>       bool
> +    select LED
>   
>   config MPS2_SCC
>       bool
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 5f3f6121bc9..908272e8593 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -92,7 +92,6 @@ mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC
>   mps2_fpgaio_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 FPGAIO read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>   mps2_fpgaio_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 FPGAIO write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>   mps2_fpgaio_reset(void) "MPS2 FPGAIO: reset"
> -mps2_fpgaio_leds(char led1, char led0) "MPS2 FPGAIO LEDs: %c%c"
>   
>   # msf2-sysreg.c
>   msf2_sysreg_write(uint64_t offset, uint32_t val, uint32_t prev) "msf2-sysreg write: addr 0x%08" PRIx64 " data 0x%" PRIx32 " prev 0x%" PRIx32
> 

