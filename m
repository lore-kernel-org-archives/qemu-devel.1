Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C764FCA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 20:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A83821744
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 20:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A83821744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRMmN-0004IS-LR
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 15:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iRMke-0003Aa-6B
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 15:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iRMkc-0004f8-KM
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 15:45:32 -0500
Received: from mail.ilande.co.uk ([46.43.2.167]:43458
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iRMkZ-0004G2-4L; Sun, 03 Nov 2019 15:45:27 -0500
Received: from host86-185-106-131.range86-185.btcentralplus.com
 ([86.185.106.131] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iRMi1-0000hk-3K; Sun, 03 Nov 2019 20:42:49 +0000
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191102154919.17775-1-laurent@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <b50a6eec-ee0e-5ec3-c4a3-cc5423e05cf5@ilande.co.uk>
Date: Sun, 3 Nov 2019 20:42:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102154919.17775-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.185.106.131
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] mos6522: fix T1 and T2 timers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.43.2.167
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/11/2019 15:49, Laurent Vivier wrote:

> With the Quadra 800 emulation, mos6522 timers processing can consume
> until 70% of the host CPU time with an idle guest (I guess the problem
> should also happen with PowerMac emulation).
> 
> On a recent system, it can be painless (except if you look at top), but
> on an old host like a PowerMac G5 the guest kernel can be terribly slow
> during the boot sequence (for instance, unpacking initramfs can take 15
> seconds rather than only 3 seconds).
> 
> We can avoid this CPU overload by enabling QEMU internal timers only if
> the mos6522 counter interrupts are enabled. Sometime the guest kernel
> wants to read the counters values, but we don't need the timers to
> update the counters.
> 
> With this patch applied, an idle Q800 consumes only 3% of host CPU time
> (and the guest can boot in a decent time).
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/misc/mos6522.c | 67 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 52 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index 57f13db266..aa3bfe1afd 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -38,8 +38,10 @@
>  
>  /* XXX: implement all timer modes */
>  
> -static void mos6522_timer_update(MOS6522State *s, MOS6522Timer *ti,
> -                                 int64_t current_time);
> +static void mos6522_timer1_update(MOS6522State *s, MOS6522Timer *ti,
> +                                  int64_t current_time);
> +static void mos6522_timer2_update(MOS6522State *s, MOS6522Timer *ti,
> +                                  int64_t current_time);
>  
>  static void mos6522_update_irq(MOS6522State *s)
>  {
> @@ -98,7 +100,11 @@ static void set_counter(MOS6522State *s, MOS6522Timer *ti, unsigned int val)
>      trace_mos6522_set_counter(1 + ti->index, val);
>      ti->load_time = get_load_time(s, ti);
>      ti->counter_value = val;
> -    mos6522_timer_update(s, ti, ti->load_time);
> +    if (ti->index == 0) {
> +        mos6522_timer1_update(s, ti, ti->load_time);
> +    } else {
> +        mos6522_timer2_update(s, ti, ti->load_time);
> +    }
>  }
>  
>  static int64_t get_next_irq_time(MOS6522State *s, MOS6522Timer *ti,
> @@ -130,19 +136,34 @@ static int64_t get_next_irq_time(MOS6522State *s, MOS6522Timer *ti,
>      trace_mos6522_get_next_irq_time(ti->latch, d, next_time - d);
>      next_time = muldiv64(next_time, NANOSECONDS_PER_SECOND, ti->frequency) +
>                           ti->load_time;
> +
>      if (next_time <= current_time) {
>          next_time = current_time + 1;
>      }
>      return next_time;
>  }
>  
> -static void mos6522_timer_update(MOS6522State *s, MOS6522Timer *ti,
> +static void mos6522_timer1_update(MOS6522State *s, MOS6522Timer *ti,
> +                                 int64_t current_time)
> +{
> +    if (!ti->timer) {
> +        return;
> +    }
> +    if ((s->ier & T1_INT) == 0 || (s->acr & T1MODE) != T1MODE_CONT) {
> +        timer_del(ti->timer);
> +    } else {
> +        ti->next_irq_time = get_next_irq_time(s, ti, current_time);
> +        timer_mod(ti->timer, ti->next_irq_time);
> +    }
> +}
> +
> +static void mos6522_timer2_update(MOS6522State *s, MOS6522Timer *ti,
>                                   int64_t current_time)
>  {
>      if (!ti->timer) {
>          return;
>      }
> -    if (ti->index == 0 && (s->acr & T1MODE) != T1MODE_CONT) {
> +    if ((s->ier & T2_INT) == 0) {
>          timer_del(ti->timer);
>      } else {
>          ti->next_irq_time = get_next_irq_time(s, ti, current_time);
> @@ -155,7 +176,7 @@ static void mos6522_timer1(void *opaque)
>      MOS6522State *s = opaque;
>      MOS6522Timer *ti = &s->timers[0];
>  
> -    mos6522_timer_update(s, ti, ti->next_irq_time);
> +    mos6522_timer1_update(s, ti, ti->next_irq_time);
>      s->ifr |= T1_INT;
>      mos6522_update_irq(s);
>  }
> @@ -165,7 +186,7 @@ static void mos6522_timer2(void *opaque)
>      MOS6522State *s = opaque;
>      MOS6522Timer *ti = &s->timers[1];
>  
> -    mos6522_timer_update(s, ti, ti->next_irq_time);
> +    mos6522_timer2_update(s, ti, ti->next_irq_time);
>      s->ifr |= T2_INT;
>      mos6522_update_irq(s);
>  }
> @@ -204,7 +225,16 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      MOS6522State *s = opaque;
>      uint32_t val;
> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>  
> +    if (now >= s->timers[0].next_irq_time) {
> +        mos6522_timer1_update(s, &s->timers[0], now);
> +        s->ifr |= T1_INT;
> +    }
> +    if (now >= s->timers[1].next_irq_time) {
> +        mos6522_timer2_update(s, &s->timers[1], now);
> +        s->ifr |= T2_INT;
> +    }
>      switch (addr) {
>      case VIA_REG_B:
>          val = s->b;
> @@ -299,8 +329,8 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>          break;
>      case VIA_REG_T1CL:
>          s->timers[0].latch = (s->timers[0].latch & 0xff00) | val;
> -        mos6522_timer_update(s, &s->timers[0],
> -                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        mos6522_timer1_update(s, &s->timers[0],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      case VIA_REG_T1CH:
>          s->timers[0].latch = (s->timers[0].latch & 0xff) | (val << 8);
> @@ -309,14 +339,14 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>          break;
>      case VIA_REG_T1LL:
>          s->timers[0].latch = (s->timers[0].latch & 0xff00) | val;
> -        mos6522_timer_update(s, &s->timers[0],
> -                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        mos6522_timer1_update(s, &s->timers[0],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      case VIA_REG_T1LH:
>          s->timers[0].latch = (s->timers[0].latch & 0xff) | (val << 8);
>          s->ifr &= ~T1_INT;
> -        mos6522_timer_update(s, &s->timers[0],
> -                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        mos6522_timer1_update(s, &s->timers[0],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      case VIA_REG_T2CL:
>          s->timers[1].latch = (s->timers[1].latch & 0xff00) | val;
> @@ -334,8 +364,8 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>          break;
>      case VIA_REG_ACR:
>          s->acr = val;
> -        mos6522_timer_update(s, &s->timers[0],
> -                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        mos6522_timer1_update(s, &s->timers[0],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      case VIA_REG_PCR:
>          s->pcr = val;
> @@ -354,6 +384,11 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>              s->ier &= ~val;
>          }
>          mos6522_update_irq(s);
> +        /* if IER is modified starts needed timers */
> +        mos6522_timer1_update(s, &s->timers[0],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        mos6522_timer2_update(s, &s->timers[1],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      default:
>      case VIA_REG_ANH:
> @@ -426,9 +461,11 @@ static void mos6522_reset(DeviceState *dev)
>      s->timers[0].frequency = s->frequency;
>      s->timers[0].latch = 0xffff;
>      set_counter(s, &s->timers[0], 0xffff);
> +    timer_del(s->timers[0].timer);
>  
>      s->timers[1].frequency = s->frequency;
>      s->timers[1].latch = 0xffff;
> +    timer_del(s->timers[1].timer);
>  }
>  
>  static void mos6522_init(Object *obj)

Nice! I've given this a quick test and seems to boot MacOS without any issues, so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.

