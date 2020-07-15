Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F1420672
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhDKNCzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F1420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvbo2-0000yt-MX
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 03:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvbnM-0000OL-Fh; Wed, 15 Jul 2020 03:25:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvbnK-0004XW-H6; Wed, 15 Jul 2020 03:25:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id 17so4521470wmo.1;
 Wed, 15 Jul 2020 00:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c8rt87mBU4r4NAeW3yIBplNcVJzAtJMbr2kmdgaXPRo=;
 b=qhDKNCzRzvmjgDXXAVr/S0c9OfoMeOcdZhy7RVn0ZeNiku8LnUuWHjhdNbY7GCkjP9
 c1rafEZQpoN96+0aAIe36Rv4XZEu40JQK9U1hXFcx9rTHqQpPPiu7EvTGPYJOqhDP7o3
 1qJ9BxjZek007s8G0RwJ0zFKCiR4kPg1tdtMoApZT60VAvUZlQJajPSr9bojhbtWsgi4
 /AyJgIoCg0BksY8A25333svI9C7PVq6HiYoAEfUBoenCsX7+9/FgGJEw18doo2AnFLn3
 DWV2Eb89q9iu1/7u+J6IrCd32ehX18oRuJEgJ5uIAiEYlBcLvvjaxyV13D2cBL9P+fP9
 fxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c8rt87mBU4r4NAeW3yIBplNcVJzAtJMbr2kmdgaXPRo=;
 b=Lr1VNPXVwT9glv/Ao1Ye8B3DmmTIUIggTqTS0bX4BSQZxZXF3jFmUH8/QAR5ZQK5zs
 gNO1lHixWjNfA4xqKIJVA6+OUNyWMnVVGQBV9bU7lj1yNWsa5K/FAQJtZrXBv2CzsGLV
 NVoVxUh13p82dJ5JFDJBpQp/xeSM+zOcERgalUMtNn7G/JVmHCR4EeF1//QDX3mia/nR
 uFxAWj7MvZwIYDS6mIyy+6y2EBko4plXd1HYXUStimQxHl5avQLON3aOZx7e5r9yI+f4
 1GGUl2r9o/63zRmNzcHGr8Yjoy+2FXFwAEFSYI+GHdmufU4phkdCMyM8Fm8yfh5N69EP
 GS+g==
X-Gm-Message-State: AOAM532tWM/z7SbKCPVEIvPRlrfeci1M+OYXa+tS4nSi6w2BRKG4WXrk
 bpn0wQqOsmqWfK6DyMxhPOc=
X-Google-Smtp-Source: ABdhPJxuA0TSmRaon7wZIwdwRmQN9e5IDCmU/rVLC8ytOSFx7R6xumDm0pCam8tevweBAJ20KAtGTQ==
X-Received: by 2002:a05:600c:20d3:: with SMTP id
 y19mr7628416wmm.10.1594797932591; 
 Wed, 15 Jul 2020 00:25:32 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t15sm2094526wmj.14.2020.07.15.00.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 00:25:31 -0700 (PDT)
Subject: Re: [PATCH v5 03/11] hw/timer: Add NPCM7xx Timer device model
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-4-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <43d97595-ef79-0ecd-a13f-25c7a986b869@amsat.org>
Date: Wed, 15 Jul 2020 09:25:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709003608.3834629-4-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
> The NPCM730 and NPCM750 SoCs have three timer modules each holding five
> timers and some shared registers (e.g. interrupt status).
> 
> Each timer runs at 25 MHz divided by a prescaler, and counts down from a
> configurable initial value to zero. When zero is reached, the interrupt
> flag for the timer is set, and the timer is disabled (one-shot mode) or
> reloaded from its initial value (periodic mode).
> 
> This implementation is sufficient to boot a Linux kernel configured for
> NPCM750. Note that the kernel does not seem to actually turn on the
> interrupts.
> 
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  include/hw/timer/npcm7xx_timer.h |  96 +++++++
>  hw/timer/npcm7xx_timer.c         | 468 +++++++++++++++++++++++++++++++
>  hw/timer/Makefile.objs           |   1 +
>  hw/timer/trace-events            |   5 +
>  4 files changed, 570 insertions(+)
>  create mode 100644 include/hw/timer/npcm7xx_timer.h
>  create mode 100644 hw/timer/npcm7xx_timer.c
> 
...

> +/* The reference clock frequency is always 25 MHz. */
> +#define NPCM7XX_TIMER_REF_HZ            (25000000)
> +
> +/* Return the value by which to divide the reference clock rate. */
> +static uint32_t npcm7xx_timer_prescaler(const NPCM7xxTimer *t)
> +{
> +    return extract32(t->tcsr, NPCM7XX_TCSR_PRESCALE_START,
> +                     NPCM7XX_TCSR_PRESCALE_LEN) + 1;
> +}
> +
> +/* Convert a timer cycle count to a time interval in nanoseconds. */
> +static int64_t npcm7xx_timer_count_to_ns(NPCM7xxTimer *t, uint32_t count)
> +{
> +    int64_t ns = count;
> +
> +    ns *= NANOSECONDS_PER_SECOND / NPCM7XX_TIMER_REF_HZ;
> +    ns *= npcm7xx_timer_prescaler(t);
> +
> +    return ns;
> +}
> +
> +/* Convert a time interval in nanoseconds to a timer cycle count. */
> +static uint32_t npcm7xx_timer_ns_to_count(NPCM7xxTimer *t, int64_t ns)
> +{
> +    int64_t count;
> +
> +    count = ns / (NANOSECONDS_PER_SECOND / NPCM7XX_TIMER_REF_HZ);
> +    count /= npcm7xx_timer_prescaler(t);
> +
> +    return count;
> +}
> +
> +/*
> + * Raise the interrupt line if there's a pending interrupt and interrupts are
> + * enabled for this timer. If not, lower it.
> + */
> +static void npcm7xx_timer_check_interrupt(NPCM7xxTimer *t)
> +{
> +    NPCM7xxTimerCtrlState *tc = t->ctrl;
> +    /* Find the array index of this timer. */
> +    int index = t - tc->timer;

As you suggested in another device in this series, using a getter
here is clearer.

> +
> +    g_assert(index >= 0 && index < NPCM7XX_TIMERS_PER_CTRL);
> +
> +    if ((t->tcsr & NPCM7XX_TCSR_IE) && (tc->tisr & BIT(index))) {
> +        qemu_irq_raise(t->irq);
> +        trace_npcm7xx_timer_irq(DEVICE(tc)->canonical_path, index, 1);
> +    } else {
> +        qemu_irq_lower(t->irq);
> +        trace_npcm7xx_timer_irq(DEVICE(tc)->canonical_path, index, 0);
> +    }
> +}
> +
> +/* Start or resume the timer. */
> +static void npcm7xx_timer_start(NPCM7xxTimer *t)
> +{
> +    int64_t now;
> +
> +    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    t->expires_ns = now + t->remaining_ns;
> +    timer_mod(&t->qtimer, t->expires_ns);
> +}
> +
> +/*
> + * Called when the counter reaches zero. Sets the interrupt flag, and either
> + * restarts or disables the timer.
> + */
> +static void npcm7xx_timer_reached_zero(NPCM7xxTimer *t)
> +{
> +    NPCM7xxTimerCtrlState *tc = t->ctrl;
> +    int index = t - tc->timer;
> +
> +    g_assert(index >= 0 && index < NPCM7XX_TIMERS_PER_CTRL);
> +
> +    tc->tisr |= BIT(index);
> +
> +    if (t->tcsr & NPCM7XX_TCSR_PERIODIC) {
> +        t->remaining_ns = npcm7xx_timer_count_to_ns(t, t->ticr);
> +        if (t->tcsr & NPCM7XX_TCSR_CEN) {
> +            npcm7xx_timer_start(t);
> +        }
> +    } else {
> +        t->tcsr &= ~(NPCM7XX_TCSR_CEN | NPCM7XX_TCSR_CACT);
> +    }
> +
> +    npcm7xx_timer_check_interrupt(t);
> +}
> +
> +/* Stop counting. Record the time remaining so we can continue later. */
> +static void npcm7xx_timer_pause(NPCM7xxTimer *t)
> +{
> +    int64_t now;
> +
> +    timer_del(&t->qtimer);
> +    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    t->remaining_ns = t->expires_ns - now;
> +    if (t->remaining_ns <= 0) {

Can this happen? Shouldn't we get npcm7xx_timer_expired() before?

> +        npcm7xx_timer_reached_zero(t);
> +    }
> +}
> +
> +/*
> + * Restart the timer from its initial value. If the timer was enabled and stays
> + * enabled, adjust the QEMU timer according to the new count. If the timer is
> + * transitioning from disabled to enabled, the caller is expected to start the
> + * timer later.
> + */
> +static void npcm7xx_timer_restart(NPCM7xxTimer *t, uint32_t old_tcsr)
> +{
> +    t->remaining_ns = npcm7xx_timer_count_to_ns(t, t->ticr);
> +
> +    if (old_tcsr & t->tcsr & NPCM7XX_TCSR_CEN) {
> +        npcm7xx_timer_start(t);
> +    }
> +}
> +
> +/* Register read and write handlers */
> +
> +static void npcm7xx_timer_write_tcsr(NPCM7xxTimer *t, uint32_t new_tcsr)
> +{
> +    uint32_t old_tcsr = t->tcsr;
> +
> +    if (new_tcsr & NPCM7XX_TCSR_RSVD) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits in 0x%08x ignored\n",
> +                      __func__, new_tcsr);
> +        new_tcsr &= ~NPCM7XX_TCSR_RSVD;
> +    }
> +    if (new_tcsr & NPCM7XX_TCSR_CACT) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read-only bits in 0x%08x ignored\n",
> +                      __func__, new_tcsr);
> +        new_tcsr &= ~NPCM7XX_TCSR_CACT;
> +    }
> +
> +    t->tcsr = (t->tcsr & NPCM7XX_TCSR_CACT) | new_tcsr;
> +
> +    if ((old_tcsr ^ new_tcsr) & NPCM7XX_TCSR_IE) {
> +        npcm7xx_timer_check_interrupt(t);
> +    }
> +    if (new_tcsr & NPCM7XX_TCSR_CRST) {
> +        npcm7xx_timer_restart(t, old_tcsr);
> +        t->tcsr &= ~NPCM7XX_TCSR_CRST;
> +    }
> +    if ((old_tcsr ^ new_tcsr) & NPCM7XX_TCSR_CEN) {
> +        if (new_tcsr & NPCM7XX_TCSR_CEN) {
> +            npcm7xx_timer_start(t);
> +        } else {
> +            npcm7xx_timer_pause(t);
> +        }
> +    }
> +}
> +
> +static void npcm7xx_timer_write_ticr(NPCM7xxTimer *t, uint32_t new_ticr)
> +{
> +    t->ticr = new_ticr;
> +
> +    npcm7xx_timer_restart(t, t->tcsr);
> +}
> +
> +static uint32_t npcm7xx_timer_read_tdr(NPCM7xxTimer *t)
> +{
> +    if (t->tcsr & NPCM7XX_TCSR_CEN) {
> +        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +        return npcm7xx_timer_ns_to_count(t, t->expires_ns - now);
> +    }
> +
> +    return npcm7xx_timer_ns_to_count(t, t->remaining_ns);
> +}
> +
> +static uint64_t npcm7xx_timer_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    NPCM7xxTimerCtrlState *s = opaque;
> +    uint64_t value = 0;
> +    hwaddr reg;
> +
> +    reg = offset / sizeof(uint32_t);
> +    switch (reg) {
> +    case NPCM7XX_TIMER_TCSR0:
> +        value = s->timer[0].tcsr;
> +        break;
> +    case NPCM7XX_TIMER_TCSR1:
> +        value = s->timer[1].tcsr;

Maybe add:

static hwaddr timer_index(hwaddr reg)
{
    return reg - NPCM7XX_TIMER_TCSR0;
}

And use shorter:

    case NPCM7XX_TIMER_TCSR0:
    case NPCM7XX_TIMER_TCSR1:
    case NPCM7XX_TIMER_TCSR2:
    case NPCM7XX_TIMER_TCSR3:
    case NPCM7XX_TIMER_TCSR4:
        value = s->timer[timer_index(reg)].tcsr;
        break;

Similarly with NPCM7XX_TIMER_TDRx and in npcm7xx_timer_write().

> +        break;
> +    case NPCM7XX_TIMER_TCSR2:
> +        value = s->timer[2].tcsr;
> +        break;
> +    case NPCM7XX_TIMER_TCSR3:
> +        value = s->timer[3].tcsr;
> +        break;
> +    case NPCM7XX_TIMER_TCSR4:
> +        value = s->timer[4].tcsr;
> +        break;
> +
> +    case NPCM7XX_TIMER_TICR0:
> +        value = s->timer[0].ticr;
> +        break;
> +    case NPCM7XX_TIMER_TICR1:
> +        value = s->timer[1].ticr;
> +        break;
> +    case NPCM7XX_TIMER_TICR2:
> +        value = s->timer[2].ticr;
> +        break;
> +    case NPCM7XX_TIMER_TICR3:
> +        value = s->timer[3].ticr;
> +        break;
> +    case NPCM7XX_TIMER_TICR4:
> +        value = s->timer[4].ticr;
> +        break;
> +
> +    case NPCM7XX_TIMER_TDR0:
> +        value = npcm7xx_timer_read_tdr(&s->timer[0]);
> +        break;
> +    case NPCM7XX_TIMER_TDR1:
> +        value = npcm7xx_timer_read_tdr(&s->timer[1]);
> +        break;
> +    case NPCM7XX_TIMER_TDR2:
> +        value = npcm7xx_timer_read_tdr(&s->timer[2]);
> +        break;
> +    case NPCM7XX_TIMER_TDR3:
> +        value = npcm7xx_timer_read_tdr(&s->timer[3]);
> +        break;
> +    case NPCM7XX_TIMER_TDR4:
> +        value = npcm7xx_timer_read_tdr(&s->timer[4]);
> +        break;
> +
> +    case NPCM7XX_TIMER_TISR:
> +        value = s->tisr;
> +        break;
> +
> +    case NPCM7XX_TIMER_WTCR:
> +        value = s->wtcr;
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid offset 0x%04x\n",
> +                      __func__, (unsigned int)offset);
> +        break;
> +    }
> +
> +    trace_npcm7xx_timer_read(DEVICE(s)->canonical_path, offset, value);
> +
> +    return value;
> +}
> +
> +static void npcm7xx_timer_write(void *opaque, hwaddr offset,
> +                                uint64_t v, unsigned size)
> +{
> +    uint32_t reg = offset / sizeof(uint32_t);
> +    NPCM7xxTimerCtrlState *s = opaque;
> +    uint32_t value = v;
> +
> +    trace_npcm7xx_timer_write(DEVICE(s)->canonical_path, offset, value);
> +
> +    switch (reg) {
> +    case NPCM7XX_TIMER_TCSR0:
> +        npcm7xx_timer_write_tcsr(&s->timer[0], value);
> +        return;
> +    case NPCM7XX_TIMER_TCSR1:
> +        npcm7xx_timer_write_tcsr(&s->timer[1], value);
> +        return;
> +    case NPCM7XX_TIMER_TCSR2:
> +        npcm7xx_timer_write_tcsr(&s->timer[2], value);
> +        return;
> +    case NPCM7XX_TIMER_TCSR3:
> +        npcm7xx_timer_write_tcsr(&s->timer[3], value);
> +        return;
> +    case NPCM7XX_TIMER_TCSR4:
> +        npcm7xx_timer_write_tcsr(&s->timer[4], value);
> +        return;
> +
> +    case NPCM7XX_TIMER_TICR0:
> +        npcm7xx_timer_write_ticr(&s->timer[0], value);
> +        return;
> +    case NPCM7XX_TIMER_TICR1:
> +        npcm7xx_timer_write_ticr(&s->timer[1], value);
> +        return;
> +    case NPCM7XX_TIMER_TICR2:
> +        npcm7xx_timer_write_ticr(&s->timer[2], value);
> +        return;
> +    case NPCM7XX_TIMER_TICR3:
> +        npcm7xx_timer_write_ticr(&s->timer[3], value);
> +        return;
> +    case NPCM7XX_TIMER_TICR4:
> +        npcm7xx_timer_write_ticr(&s->timer[4], value);
> +        return;
> +
> +    case NPCM7XX_TIMER_TDR0:
> +    case NPCM7XX_TIMER_TDR1:
> +    case NPCM7XX_TIMER_TDR2:
> +    case NPCM7XX_TIMER_TDR3:
> +    case NPCM7XX_TIMER_TDR4:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: register @ 0x%04x is read-only\n",
> +                      __func__, (unsigned int)offset);
> +        return;
> +
> +    case NPCM7XX_TIMER_TISR:
> +        s->tisr &= ~value;
> +        return;
> +
> +    case NPCM7XX_TIMER_WTCR:
> +        qemu_log_mask(LOG_UNIMP, "%s: WTCR write not implemented: 0x%08x\n",
> +                      __func__, value);
> +        return;
> +    }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid offset 0x%04x\n",
> +                  __func__, (unsigned int)offset);
> +}
> +
> +static const struct MemoryRegionOps npcm7xx_timer_ops = {
> +    .read       = npcm7xx_timer_read,
> +    .write      = npcm7xx_timer_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid      = {
> +        .min_access_size        = 4,
> +        .max_access_size        = 4,
> +        .unaligned              = false,
> +    },
> +};
> +
> +/* Called when the QEMU timer expires. */
> +static void npcm7xx_timer_expired(void *opaque)
> +{
> +    NPCM7xxTimer *t = opaque;
> +
> +    if (t->tcsr & NPCM7XX_TCSR_CEN) {
> +        npcm7xx_timer_reached_zero(t);
> +    }
> +}
...

