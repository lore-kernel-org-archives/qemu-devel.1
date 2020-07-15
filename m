Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C6FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 23:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC682065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 23:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMM5vnPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC682065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvqT1-0000EL-Fn
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 19:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jvqSK-00089O-S2
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 19:04:52 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:34607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jvqSI-00007c-M7
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 19:04:52 -0400
Received: by mail-ua1-x942.google.com with SMTP id o25so1169203uar.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AeZPZ2Uh1QDWA+3pf8dsSv45o+6OCQcaEwdJfNCd86M=;
 b=UMM5vnPLCnnmT9gUkxxDN4rHOrEMMWoMAJ0jhLzXFaG+arDm1DUOlYZfPMnGw86dNA
 eP8bqL1r29mxsyeaTngdBfy69w9W71ABdj21xVYAB0GXKFhvNhuugooYHLzGv8o+N8L1
 NaAYiPTFQSoUXdapA1qQzFOdQRQVQlImPxnWL/aD03m3iblvZo1PgN6XgHbMEVlm5Lzj
 Rc9IvcK4742wmrwQbfVXiDu+/WHhKx1aSuCq4AWAmdDCAN/GPOxCEkjmXigXni5retzT
 YMRjsfhMKvZ4HBjvvg+SwjJCf/jbzelwEZ5IzTqQ2XJOr7k6dimS2xV72127cDca59ot
 gDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AeZPZ2Uh1QDWA+3pf8dsSv45o+6OCQcaEwdJfNCd86M=;
 b=sm72HFD0RLMtzLYm/8rrI1p6Lo2O28jb4vw1XuZI7ZxY5210+gDdlkCPjWQGphg1Z1
 eNGXxnOyb1YPh1yUvSpmp3c96qAxHnXCwjVdsgdX+gVQlVan+EV96+6OJ5YZzi4Mne2t
 7tQ3Dt7kNkTbwmaZOyFm5+t1pF7SyZd0D1LvuNQ5mXZFy7YmSTDR/a6TbhKjDAoHa4E2
 EH82VhHHCDaZx9g4o0JZFdmiRPhsqNqOZRtRBTAC6/b+Yg9jHWqn/q681bzlB0gBe13I
 UbpQnfLEP+eiDc+qzpwyUMblkgLQmSvuHd5mLY0zRY9sram1/JCMUJitExKr5xVE1RCB
 nTpA==
X-Gm-Message-State: AOAM532XVK2njwQxqB01g4eN9ThpXFwguAJMNqzOSgswznq8V47BCrYm
 VDRDqhH1AIG6oP+vzefL07k4PTgxLtKEwsCVOvmHvw==
X-Google-Smtp-Source: ABdhPJz80wNqxiZH7iBDvBw41TCiujvPV1JPOLM8twbCJnJiuBKTjM15Q2NKFzd2An7QntcGmT/VvTmRJ/iwSFPL0O0=
X-Received: by 2002:ab0:6ec6:: with SMTP id c6mr1646488uav.7.1594854289072;
 Wed, 15 Jul 2020 16:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-4-hskinnemoen@google.com>
 <43d97595-ef79-0ecd-a13f-25c7a986b869@amsat.org>
In-Reply-To: <43d97595-ef79-0ecd-a13f-25c7a986b869@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 15 Jul 2020 16:04:37 -0700
Message-ID: <CAFQmdRZPMdvXYLQqXMhnv3DT8SHYjvPSBHg-v2YaDb7Zi3xc3Q@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] hw/timer: Add NPCM7xx Timer device model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::942;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x942.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 12:25 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
> > The NPCM730 and NPCM750 SoCs have three timer modules each holding five
> > timers and some shared registers (e.g. interrupt status).
> >
> > Each timer runs at 25 MHz divided by a prescaler, and counts down from =
a
> > configurable initial value to zero. When zero is reached, the interrupt
> > flag for the timer is set, and the timer is disabled (one-shot mode) or
> > reloaded from its initial value (periodic mode).
> >
> > This implementation is sufficient to boot a Linux kernel configured for
> > NPCM750. Note that the kernel does not seem to actually turn on the
> > interrupts.
> >
> > Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> > ---
> >  include/hw/timer/npcm7xx_timer.h |  96 +++++++
> >  hw/timer/npcm7xx_timer.c         | 468 +++++++++++++++++++++++++++++++
> >  hw/timer/Makefile.objs           |   1 +
> >  hw/timer/trace-events            |   5 +
> >  4 files changed, 570 insertions(+)
> >  create mode 100644 include/hw/timer/npcm7xx_timer.h
> >  create mode 100644 hw/timer/npcm7xx_timer.c
> >
> ...
>
> > +/* The reference clock frequency is always 25 MHz. */
> > +#define NPCM7XX_TIMER_REF_HZ            (25000000)
> > +
> > +/* Return the value by which to divide the reference clock rate. */
> > +static uint32_t npcm7xx_timer_prescaler(const NPCM7xxTimer *t)
> > +{
> > +    return extract32(t->tcsr, NPCM7XX_TCSR_PRESCALE_START,
> > +                     NPCM7XX_TCSR_PRESCALE_LEN) + 1;
> > +}
> > +
> > +/* Convert a timer cycle count to a time interval in nanoseconds. */
> > +static int64_t npcm7xx_timer_count_to_ns(NPCM7xxTimer *t, uint32_t cou=
nt)
> > +{
> > +    int64_t ns =3D count;
> > +
> > +    ns *=3D NANOSECONDS_PER_SECOND / NPCM7XX_TIMER_REF_HZ;
> > +    ns *=3D npcm7xx_timer_prescaler(t);
> > +
> > +    return ns;
> > +}
> > +
> > +/* Convert a time interval in nanoseconds to a timer cycle count. */
> > +static uint32_t npcm7xx_timer_ns_to_count(NPCM7xxTimer *t, int64_t ns)
> > +{
> > +    int64_t count;
> > +
> > +    count =3D ns / (NANOSECONDS_PER_SECOND / NPCM7XX_TIMER_REF_HZ);
> > +    count /=3D npcm7xx_timer_prescaler(t);
> > +
> > +    return count;
> > +}
> > +
> > +/*
> > + * Raise the interrupt line if there's a pending interrupt and interru=
pts are
> > + * enabled for this timer. If not, lower it.
> > + */
> > +static void npcm7xx_timer_check_interrupt(NPCM7xxTimer *t)
> > +{
> > +    NPCM7xxTimerCtrlState *tc =3D t->ctrl;
> > +    /* Find the array index of this timer. */
> > +    int index =3D t - tc->timer;
>
> As you suggested in another device in this series, using a getter
> here is clearer.

Definitely.

> > +
> > +    g_assert(index >=3D 0 && index < NPCM7XX_TIMERS_PER_CTRL);
> > +
> > +    if ((t->tcsr & NPCM7XX_TCSR_IE) && (tc->tisr & BIT(index))) {
> > +        qemu_irq_raise(t->irq);
> > +        trace_npcm7xx_timer_irq(DEVICE(tc)->canonical_path, index, 1);
> > +    } else {
> > +        qemu_irq_lower(t->irq);
> > +        trace_npcm7xx_timer_irq(DEVICE(tc)->canonical_path, index, 0);
> > +    }
> > +}
> > +
> > +/* Start or resume the timer. */
> > +static void npcm7xx_timer_start(NPCM7xxTimer *t)
> > +{
> > +    int64_t now;
> > +
> > +    now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +    t->expires_ns =3D now + t->remaining_ns;
> > +    timer_mod(&t->qtimer, t->expires_ns);
> > +}
> > +
> > +/*
> > + * Called when the counter reaches zero. Sets the interrupt flag, and =
either
> > + * restarts or disables the timer.
> > + */
> > +static void npcm7xx_timer_reached_zero(NPCM7xxTimer *t)
> > +{
> > +    NPCM7xxTimerCtrlState *tc =3D t->ctrl;
> > +    int index =3D t - tc->timer;
> > +
> > +    g_assert(index >=3D 0 && index < NPCM7XX_TIMERS_PER_CTRL);
> > +
> > +    tc->tisr |=3D BIT(index);
> > +
> > +    if (t->tcsr & NPCM7XX_TCSR_PERIODIC) {
> > +        t->remaining_ns =3D npcm7xx_timer_count_to_ns(t, t->ticr);
> > +        if (t->tcsr & NPCM7XX_TCSR_CEN) {
> > +            npcm7xx_timer_start(t);
> > +        }
> > +    } else {
> > +        t->tcsr &=3D ~(NPCM7XX_TCSR_CEN | NPCM7XX_TCSR_CACT);
> > +    }
> > +
> > +    npcm7xx_timer_check_interrupt(t);
> > +}
> > +
> > +/* Stop counting. Record the time remaining so we can continue later. =
*/
> > +static void npcm7xx_timer_pause(NPCM7xxTimer *t)
> > +{
> > +    int64_t now;
> > +
> > +    timer_del(&t->qtimer);
> > +    now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +    t->remaining_ns =3D t->expires_ns - now;
> > +    if (t->remaining_ns <=3D 0) {
>
> Can this happen? Shouldn't we get npcm7xx_timer_expired() before?

I was thinking the timer might expire right after calling timer_del(),
and handling it before we expire the timer makes bookkeeping easier.
But if QEMU_CLOCK_VIRTUAL is stopped while this code is running (even
on multi-cpu systems?), then I agree it can't happen.

If it can't possibly happen, then it should be appropriate to add

    g_assert(t->remaining_ns > 0);

right?

> > +        npcm7xx_timer_reached_zero(t);
> > +    }
> > +}
> > +
> > +/*
> > + * Restart the timer from its initial value. If the timer was enabled =
and stays
> > + * enabled, adjust the QEMU timer according to the new count. If the t=
imer is
> > + * transitioning from disabled to enabled, the caller is expected to s=
tart the
> > + * timer later.
> > + */
> > +static void npcm7xx_timer_restart(NPCM7xxTimer *t, uint32_t old_tcsr)
> > +{
> > +    t->remaining_ns =3D npcm7xx_timer_count_to_ns(t, t->ticr);
> > +
> > +    if (old_tcsr & t->tcsr & NPCM7XX_TCSR_CEN) {
> > +        npcm7xx_timer_start(t);
> > +    }
> > +}
> > +
> > +/* Register read and write handlers */
> > +
> > +static void npcm7xx_timer_write_tcsr(NPCM7xxTimer *t, uint32_t new_tcs=
r)
> > +{
> > +    uint32_t old_tcsr =3D t->tcsr;
> > +
> > +    if (new_tcsr & NPCM7XX_TCSR_RSVD) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits in 0x%08x ig=
nored\n",
> > +                      __func__, new_tcsr);
> > +        new_tcsr &=3D ~NPCM7XX_TCSR_RSVD;
> > +    }
> > +    if (new_tcsr & NPCM7XX_TCSR_CACT) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read-only bits in 0x%08x i=
gnored\n",
> > +                      __func__, new_tcsr);
> > +        new_tcsr &=3D ~NPCM7XX_TCSR_CACT;
> > +    }
> > +
> > +    t->tcsr =3D (t->tcsr & NPCM7XX_TCSR_CACT) | new_tcsr;
> > +
> > +    if ((old_tcsr ^ new_tcsr) & NPCM7XX_TCSR_IE) {
> > +        npcm7xx_timer_check_interrupt(t);
> > +    }
> > +    if (new_tcsr & NPCM7XX_TCSR_CRST) {
> > +        npcm7xx_timer_restart(t, old_tcsr);
> > +        t->tcsr &=3D ~NPCM7XX_TCSR_CRST;
> > +    }
> > +    if ((old_tcsr ^ new_tcsr) & NPCM7XX_TCSR_CEN) {
> > +        if (new_tcsr & NPCM7XX_TCSR_CEN) {
> > +            npcm7xx_timer_start(t);
> > +        } else {
> > +            npcm7xx_timer_pause(t);
> > +        }
> > +    }
> > +}
> > +
> > +static void npcm7xx_timer_write_ticr(NPCM7xxTimer *t, uint32_t new_tic=
r)
> > +{
> > +    t->ticr =3D new_ticr;
> > +
> > +    npcm7xx_timer_restart(t, t->tcsr);
> > +}
> > +
> > +static uint32_t npcm7xx_timer_read_tdr(NPCM7xxTimer *t)
> > +{
> > +    if (t->tcsr & NPCM7XX_TCSR_CEN) {
> > +        int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +
> > +        return npcm7xx_timer_ns_to_count(t, t->expires_ns - now);
> > +    }
> > +
> > +    return npcm7xx_timer_ns_to_count(t, t->remaining_ns);
> > +}
> > +
> > +static uint64_t npcm7xx_timer_read(void *opaque, hwaddr offset, unsign=
ed size)
> > +{
> > +    NPCM7xxTimerCtrlState *s =3D opaque;
> > +    uint64_t value =3D 0;
> > +    hwaddr reg;
> > +
> > +    reg =3D offset / sizeof(uint32_t);
> > +    switch (reg) {
> > +    case NPCM7XX_TIMER_TCSR0:
> > +        value =3D s->timer[0].tcsr;
> > +        break;
> > +    case NPCM7XX_TIMER_TCSR1:
> > +        value =3D s->timer[1].tcsr;
>
> Maybe add:
>
> static hwaddr timer_index(hwaddr reg)
> {
>     return reg - NPCM7XX_TIMER_TCSR0;
> }
>
> And use shorter:
>
>     case NPCM7XX_TIMER_TCSR0:
>     case NPCM7XX_TIMER_TCSR1:
>     case NPCM7XX_TIMER_TCSR2:
>     case NPCM7XX_TIMER_TCSR3:
>     case NPCM7XX_TIMER_TCSR4:
>         value =3D s->timer[timer_index(reg)].tcsr;
>         break;
>
> Similarly with NPCM7XX_TIMER_TDRx and in npcm7xx_timer_write().

Sorry, that won't work because the registers for the various modules
are not grouped together.

> > +        break;
> > +    case NPCM7XX_TIMER_TCSR2:
> > +        value =3D s->timer[2].tcsr;
> > +        break;
> > +    case NPCM7XX_TIMER_TCSR3:
> > +        value =3D s->timer[3].tcsr;
> > +        break;
> > +    case NPCM7XX_TIMER_TCSR4:
> > +        value =3D s->timer[4].tcsr;
> > +        break;
> > +
> > +    case NPCM7XX_TIMER_TICR0:
> > +        value =3D s->timer[0].ticr;
> > +        break;
> > +    case NPCM7XX_TIMER_TICR1:
> > +        value =3D s->timer[1].ticr;
> > +        break;
> > +    case NPCM7XX_TIMER_TICR2:
> > +        value =3D s->timer[2].ticr;
> > +        break;
> > +    case NPCM7XX_TIMER_TICR3:
> > +        value =3D s->timer[3].ticr;
> > +        break;
> > +    case NPCM7XX_TIMER_TICR4:
> > +        value =3D s->timer[4].ticr;
> > +        break;
> > +
> > +    case NPCM7XX_TIMER_TDR0:
> > +        value =3D npcm7xx_timer_read_tdr(&s->timer[0]);
> > +        break;
> > +    case NPCM7XX_TIMER_TDR1:
> > +        value =3D npcm7xx_timer_read_tdr(&s->timer[1]);
> > +        break;
> > +    case NPCM7XX_TIMER_TDR2:
> > +        value =3D npcm7xx_timer_read_tdr(&s->timer[2]);
> > +        break;
> > +    case NPCM7XX_TIMER_TDR3:
> > +        value =3D npcm7xx_timer_read_tdr(&s->timer[3]);
> > +        break;
> > +    case NPCM7XX_TIMER_TDR4:
> > +        value =3D npcm7xx_timer_read_tdr(&s->timer[4]);
> > +        break;
> > +
> > +    case NPCM7XX_TIMER_TISR:
> > +        value =3D s->tisr;
> > +        break;
> > +
> > +    case NPCM7XX_TIMER_WTCR:
> > +        value =3D s->wtcr;
> > +        break;
> > +
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid offset 0x%04x\n",
> > +                      __func__, (unsigned int)offset);
> > +        break;
> > +    }
> > +
> > +    trace_npcm7xx_timer_read(DEVICE(s)->canonical_path, offset, value)=
;
> > +
> > +    return value;
> > +}
> > +
> > +static void npcm7xx_timer_write(void *opaque, hwaddr offset,
> > +                                uint64_t v, unsigned size)
> > +{
> > +    uint32_t reg =3D offset / sizeof(uint32_t);
> > +    NPCM7xxTimerCtrlState *s =3D opaque;
> > +    uint32_t value =3D v;
> > +
> > +    trace_npcm7xx_timer_write(DEVICE(s)->canonical_path, offset, value=
);
> > +
> > +    switch (reg) {
> > +    case NPCM7XX_TIMER_TCSR0:
> > +        npcm7xx_timer_write_tcsr(&s->timer[0], value);
> > +        return;
> > +    case NPCM7XX_TIMER_TCSR1:
> > +        npcm7xx_timer_write_tcsr(&s->timer[1], value);
> > +        return;
> > +    case NPCM7XX_TIMER_TCSR2:
> > +        npcm7xx_timer_write_tcsr(&s->timer[2], value);
> > +        return;
> > +    case NPCM7XX_TIMER_TCSR3:
> > +        npcm7xx_timer_write_tcsr(&s->timer[3], value);
> > +        return;
> > +    case NPCM7XX_TIMER_TCSR4:
> > +        npcm7xx_timer_write_tcsr(&s->timer[4], value);
> > +        return;
> > +
> > +    case NPCM7XX_TIMER_TICR0:
> > +        npcm7xx_timer_write_ticr(&s->timer[0], value);
> > +        return;
> > +    case NPCM7XX_TIMER_TICR1:
> > +        npcm7xx_timer_write_ticr(&s->timer[1], value);
> > +        return;
> > +    case NPCM7XX_TIMER_TICR2:
> > +        npcm7xx_timer_write_ticr(&s->timer[2], value);
> > +        return;
> > +    case NPCM7XX_TIMER_TICR3:
> > +        npcm7xx_timer_write_ticr(&s->timer[3], value);
> > +        return;
> > +    case NPCM7XX_TIMER_TICR4:
> > +        npcm7xx_timer_write_ticr(&s->timer[4], value);
> > +        return;
> > +
> > +    case NPCM7XX_TIMER_TDR0:
> > +    case NPCM7XX_TIMER_TDR1:
> > +    case NPCM7XX_TIMER_TDR2:
> > +    case NPCM7XX_TIMER_TDR3:
> > +    case NPCM7XX_TIMER_TDR4:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: register @ 0x%04x is read-=
only\n",
> > +                      __func__, (unsigned int)offset);
> > +        return;
> > +
> > +    case NPCM7XX_TIMER_TISR:
> > +        s->tisr &=3D ~value;
> > +        return;
> > +
> > +    case NPCM7XX_TIMER_WTCR:
> > +        qemu_log_mask(LOG_UNIMP, "%s: WTCR write not implemented: 0x%0=
8x\n",
> > +                      __func__, value);
> > +        return;
> > +    }
> > +
> > +    qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid offset 0x%04x\n",
> > +                  __func__, (unsigned int)offset);
> > +}
> > +
> > +static const struct MemoryRegionOps npcm7xx_timer_ops =3D {
> > +    .read       =3D npcm7xx_timer_read,
> > +    .write      =3D npcm7xx_timer_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid      =3D {
> > +        .min_access_size        =3D 4,
> > +        .max_access_size        =3D 4,
> > +        .unaligned              =3D false,
> > +    },
> > +};
> > +
> > +/* Called when the QEMU timer expires. */
> > +static void npcm7xx_timer_expired(void *opaque)
> > +{
> > +    NPCM7xxTimer *t =3D opaque;
> > +
> > +    if (t->tcsr & NPCM7XX_TCSR_CEN) {
> > +        npcm7xx_timer_reached_zero(t);
> > +    }
> > +}
> ...

