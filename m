Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A35C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08162080D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="bEd4Yk4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08162080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRsRr-0007rc-Kx
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 03:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRsQs-00070D-JJ; Mon, 12 Oct 2020 03:39:46 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:55408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRsQq-0001i2-78; Mon, 12 Oct 2020 03:39:46 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id DEE12C6011D;
 Mon, 12 Oct 2020 07:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602487775;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKgjge1fh06jMx8vwsGTl0nvq9pNxYfI0gkttuqbF24=;
 b=bEd4Yk4S8ERc5P30x4AU0QDvILkddwQAIOe2TD14Ht9robzqyKY2azPnaWf6PBb5E2glES
 LXHOGFnv5WNi89ewFQwxsErjDIZ8JlaqhGxKkNbf7eYc8ms0CshszyIyGEYmYGy+WtGbw/
 C0K3YOW2v/70HrGpXCldYQqF+aLlxXOu7EJdYH8VIbv4Xys3RBrijdOgFC5Mky2N37WF8t
 SBICdat5PuOko8vU1ahoq83GVEhVHtl0RRzHNum2G/5DnBaobkw+dxCdn6xn0lAynZ/Rj/
 mXVMtazQ4/LomJQMgVNm7VYqt3KuyRwnJITFKLPM1C+O3vuarMZp6rAgH8M8bg==
Date: Mon, 12 Oct 2020 09:30:38 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v4 3/4] hw/timer/bcm2835: Support the timer COMPARE
 registers
Message-ID: <20201012073038.fzyqnr5tdxymzhdf@sekoia-pc.home.lmichel.fr>
References: <20201010203709.3116542-1-f4bug@amsat.org>
 <20201010203709.3116542-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201010203709.3116542-4-f4bug@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602487776;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKgjge1fh06jMx8vwsGTl0nvq9pNxYfI0gkttuqbF24=;
 b=R2HYr1zSsyJ1nImzTLhKPRglCIkpfgQBkAfX5ikx6qZrBAKo4LJOPmI8BiRQz8g+yl4scm
 WLNItQXEP2DAd5BYo4bjXiZGSlwG3y5FItgLXrMwyLLr2vVgdORy6cQHIcqpI+cBRcoLge
 7Ry/0ZZuwx/fRSO7LSHhiqKS1hweSt4GAPi2oQagfvDSHooOhWURsTMbeXa749h4EzBSqt
 SsnJWXFuQ5eV1YhhErjMrtzBBF1XfKP9TNsIPNmoZ+E/ZwMUBngvhPgHwHANi4OYuuj/rp
 3qk4mR7n+um/f5j+pryUe3miVHTlODPH9ETtMqU+c9hbiQ9aHnQu4jTn8pbBwA==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602487776; a=rsa-sha256; cv=none;
 b=Ah/dCZRnJMkl3+60jBVqppIp4hMHPmgBW1Vb8Jps+h9dzI32nmKxgjZW5cx7BVdoLtcbePL59PJTYFLzPkNtY5NArCsuBDmtO4SKe1fB797nlKJUSBUnnhNKok5u6e1lI7Dl4DLujkLA6DeuDv7eHOHMdUbti/qHL2kc8/6kiiwo3PMb04HHx9zIIOK5ht2iOrWfWDV7dRBH0Ug52AWEbWaLyhxsW/+Ar4Uww2aMF7+y9J/ZRJ9h8PkgICBhI4PZPQ4YSD6/Xu52dyK5fddbRodKijHavWZVWAnJ+FDWAYhP3kdtzYxMVGzLkZ9EeVqaXDCnQ5zwFtIA0ojy8Dunpw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 03:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22:37 Sat 10 Oct     , Philippe Mathieu-Daudé wrote:
> This peripheral has 1 free-running timer and 4 compare registers.
> 
> Only the free-running timer is implemented. Add support the
> COMPARE registers (each register is wired to an IRQ).
> 
> Reference: "BCM2835 ARM Peripherals" datasheet [*]
>             chapter 12 "System Timer":
> 
>   The System Timer peripheral provides four 32-bit timer channels
>   and a single 64-bit free running counter. Each channel has an
>   output compare register, which is compared against the 32 least
>   significant bits of the free running counter values. When the
>   two values match, the system timer peripheral generates a signal
>   to indicate a match for the appropriate channel. The match signal
>   is then fed into the interrupt controller.
> 
> This peripheral is used since Linux 3.7, commit ee4af5696720
> ("ARM: bcm2835: add system timer").
> 
> [*] https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
> v4:
> - Fix arithmetic to correctly get value in future (Richard)
> - Use 32-bit argument value (Richard)
> v3:
> - Only compare 32 least significant bits of the free running
>   counter values (Luc)
> ---
>  include/hw/timer/bcm2835_systmr.h | 11 +++++--
>  hw/timer/bcm2835_systmr.c         | 48 ++++++++++++++++++++-----------
>  hw/timer/trace-events             |  6 ++--
>  3 files changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
> index f15788a78d8..bd3097d746b 100644
> --- a/include/hw/timer/bcm2835_systmr.h
> +++ b/include/hw/timer/bcm2835_systmr.h
> @@ -11,6 +11,7 @@
>  
>  #include "hw/sysbus.h"
>  #include "hw/irq.h"
> +#include "qemu/timer.h"
>  #include "qom/object.h"
>  
>  #define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
> @@ -18,18 +19,24 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2835SystemTimerState, BCM2835_SYSTIMER)
>  
>  #define BCM2835_SYSTIMER_COUNT 4
>  
> +typedef struct {
> +    unsigned id;
> +    QEMUTimer timer;
> +    qemu_irq irq;
> +    BCM2835SystemTimerState *state;
> +} BCM2835SystemTimerCompare;
> +
>  struct BCM2835SystemTimerState {
>      /*< private >*/
>      SysBusDevice parent_obj;
>  
>      /*< public >*/
>      MemoryRegion iomem;
> -    qemu_irq irq;
> -
>      struct {
>          uint32_t ctrl_status;
>          uint32_t compare[BCM2835_SYSTIMER_COUNT];
>      } reg;
> +    BCM2835SystemTimerCompare tmr[BCM2835_SYSTIMER_COUNT];
>  };
>  
>  #endif
> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
> index b234e83824f..67669a57ff3 100644
> --- a/hw/timer/bcm2835_systmr.c
> +++ b/hw/timer/bcm2835_systmr.c
> @@ -28,20 +28,13 @@ REG32(COMPARE1,     0x10)
>  REG32(COMPARE2,     0x14)
>  REG32(COMPARE3,     0x18)
>  
> -static void bcm2835_systmr_update_irq(BCM2835SystemTimerState *s)
> +static void bcm2835_systmr_timer_expire(void *opaque)
>  {
> -    bool enable = !!s->reg.ctrl_status;
> +    BCM2835SystemTimerCompare *tmr = opaque;
>  
> -    trace_bcm2835_systmr_irq(enable);
> -    qemu_set_irq(s->irq, enable);
> -}
> -
> -static void bcm2835_systmr_update_compare(BCM2835SystemTimerState *s,
> -                                          unsigned timer_index)
> -{
> -    /* TODO fow now, since neither Linux nor U-boot use these timers. */
> -    qemu_log_mask(LOG_UNIMP, "COMPARE register %u not implemented\n",
> -                  timer_index);
> +    trace_bcm2835_systmr_timer_expired(tmr->id);
> +    tmr->state->reg.ctrl_status |= 1 << tmr->id;
> +    qemu_set_irq(tmr->irq, 1);
>  }
>  
>  static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
> @@ -75,19 +68,33 @@ static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
>  }
>  
>  static void bcm2835_systmr_write(void *opaque, hwaddr offset,
> -                                 uint64_t value, unsigned size)
> +                                 uint64_t value64, unsigned size)
>  {
>      BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
> +    int index;
> +    uint32_t value = value64;
> +    uint32_t triggers_delay_us;
> +    uint64_t now;
>  
>      trace_bcm2835_systmr_write(offset, value);
>      switch (offset) {
>      case A_CTRL_STATUS:
>          s->reg.ctrl_status &= ~value; /* Ack */
> -        bcm2835_systmr_update_irq(s);
> +        for (index = 0; index < ARRAY_SIZE(s->tmr); index++) {
> +            if (extract32(value, index, 1)) {
> +                trace_bcm2835_systmr_irq_ack(index);
> +                qemu_set_irq(s->tmr[index].irq, 0);
> +            }
> +        }
>          break;
>      case A_COMPARE0 ... A_COMPARE3:
> -        s->reg.compare[(offset - A_COMPARE0) >> 2] = value;
> -        bcm2835_systmr_update_compare(s, (offset - A_COMPARE0) >> 2);
> +        index = (offset - A_COMPARE0) >> 2;
> +        s->reg.compare[index] = value;
> +        now = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
> +        /* Compare lower 32-bits of the free-running counter. */
> +        triggers_delay_us = value - now;
> +        trace_bcm2835_systmr_run(index, triggers_delay_us);
> +        timer_mod(&s->tmr[index].timer, now + triggers_delay_us);
>          break;
>      case A_COUNTER_LOW:
>      case A_COUNTER_HIGH:
> @@ -125,7 +132,14 @@ static void bcm2835_systmr_realize(DeviceState *dev, Error **errp)
>      memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_systmr_ops,
>                            s, "bcm2835-sys-timer", 0x20);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
> -    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> +
> +    for (size_t i = 0; i < ARRAY_SIZE(s->tmr); i++) {
> +        s->tmr[i].id = i;
> +        s->tmr[i].state = s;
> +        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->tmr[i].irq);
> +        timer_init_us(&s->tmr[i].timer, QEMU_CLOCK_VIRTUAL,
> +                      bcm2835_systmr_timer_expire, &s->tmr[i]);
> +    }
>  }
>  
>  static const VMStateDescription bcm2835_systmr_vmstate = {
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index b996d992000..7a4326d9566 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -77,9 +77,11 @@ nrf51_timer_write(uint8_t timer_id, uint64_t addr, uint32_t value, unsigned size
>  nrf51_timer_set_count(uint8_t timer_id, uint8_t counter_id, uint32_t value) "timer %u counter %u count 0x%" PRIx32
>  
>  # bcm2835_systmr.c
> -bcm2835_systmr_irq(bool enable) "timer irq state %u"
> +bcm2835_systmr_timer_expired(unsigned id) "timer #%u expired"
> +bcm2835_systmr_irq_ack(unsigned id) "timer #%u acked"
>  bcm2835_systmr_read(uint64_t offset, uint64_t data) "timer read: offset 0x%" PRIx64 " data 0x%" PRIx64
> -bcm2835_systmr_write(uint64_t offset, uint64_t data) "timer write: offset 0x%" PRIx64 " data 0x%" PRIx64
> +bcm2835_systmr_write(uint64_t offset, uint32_t data) "timer write: offset 0x%" PRIx64 " data 0x%" PRIx32
> +bcm2835_systmr_run(unsigned id, uint64_t delay_us) "timer #%u expiring in %"PRIu64" us"
>  
>  # avr_timer16.c
>  avr_timer16_read(uint8_t addr, uint8_t value) "timer16 read addr:%u value:%u"
> -- 
> 2.26.2
> 

-- 

