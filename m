Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 11:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD1720656
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 11:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6QQ/DCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD1720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmvu-00005m-HD
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 07:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkmut-000800-VN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 07:04:40 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkmus-0003b6-3Q
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 07:04:39 -0400
Received: by mail-oi1-x243.google.com with SMTP id a3so15522324oid.4
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IVf/Kn5dhClrebtEPL3ia6ygu/P0VQbssj01F791Qlc=;
 b=M6QQ/DCkWsWdbZQZRQ27lCPMGYEgd7+TckUk+k/R7ktyghdsbBHaQDGNndJ6JEkDWl
 GstVPNM906UC1ZCyVPbhcdhrYvOP4C5LudMNjKQb7lCO2G44t79tdVK56encpRLUq6Iq
 neju4Wjm/n7OlDQVpGTJEhVY1vjenKikdv4PrOkk++pb75JUZGNN0ObSsdqmwxMKB8FI
 YPulanHhH6aQxjOw8BmiO0HkGDPNEg34CQyBaDQV+QXTXtQWxhW/Wd7AVe36Ani/CYBQ
 y45h3Y8+bPAI5cnmm9eP1nF3W49DAFicJVf6A4+6uGNgBxV0ss4Xq7trJ1diLnWB5JZP
 irew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IVf/Kn5dhClrebtEPL3ia6ygu/P0VQbssj01F791Qlc=;
 b=q9pHzjIGdcTjEcY86S4lAchhAro/2FNxZUaWunlw1Y6ruQa2K3wafkZyOb+E5PPoWZ
 sbcewBJVpl3dv7uY9DdNR8nxpq1nGjA0BZimwmnZMV0FyqWGk/Srtv9bLGaOrQ77VknK
 TeByub9YiZBpG37cx13l09Tse7Yu6Hg6X8LTUmc8mD2u/XIvV46nUv72YRtD2XgzQ5qi
 wzePtdTUf7vJBAg2BK1HlvYmYT2fGkiKYz9iKoAFttu6S0XgYRZORlL7sgjjjpmgOhLc
 aLSqKfxvlFwq+whdsnY199/49n2wqARtq127fhVxDLS+cbMSbw45A9FbaZCUzoR1onrr
 SjOw==
X-Gm-Message-State: AOAM5338nNcCo8FTEn0VagR8cWAYqAO/qqYoAJogYYlk6f1kRrZLWl6s
 1K7Nre15z+Dwtn/fBs57oEEt3PnCpA8vZT2y06r24syG64g=
X-Google-Smtp-Source: ABdhPJxxZJqBZoh8dt7wrrAarXrExOhyVN8N+LuB36vK7sQzd4c5FD6b9XBhkhP6krLOd8EMk55MCITRz6hh8lRNl+U=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr8348577oia.163.1592219076585; 
 Mon, 15 Jun 2020 04:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200610084551.28222-1-vav@sysgo.com>
In-Reply-To: <20200610084551.28222-1-vav@sysgo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 12:04:25 +0100
Message-ID: <CAFEAcA9uF01LnFy6o4Yy=aeuy9ixyGWZFVGtR66ah3w1458O5g@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/a9gtimer: Clear pending interrupt, after the
 clear of Event flag
To: Vaclav Vanc <vav@sysgo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "open list:ARM cores" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jun 2020 at 09:47, Vaclav Vanc <vav@sysgo.com> wrote:
>
> A9 Global Timer is used with Edge triggered interrupts (This is true
> at least for Zynq and i.MX6 processors).
> When Event Flag is cleared in Interrupt Status Register and new interrupt
> was supposed to be scheduled, interrupt request is never cleared.
> Since interrupt in GIC is configured as Edge triggered, new interrupts
> are not registered (because interrupt is stuck at pending and GIC thinks
> it was already serviced). As a result interrupts from timer does not work
> anymore.
>
> Note: This happens only when interrupt was not serviced before the next
> interrupt is suppose to be scheduled. This happens for example during
> the increased load of the host system.
>
> Interrupt is now always cleared when Event Flag is cleared.
> This is in accordance to A9 Global Timer documentation.
>
> Signed-off-by: Vaclav Vanc <vav@sysgo.com>
> ---
>  hw/timer/a9gtimer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
> index 7233068a37..732889105e 100644
> --- a/hw/timer/a9gtimer.c
> +++ b/hw/timer/a9gtimer.c
> @@ -206,6 +206,9 @@ static void a9_gtimer_write(void *opaque, hwaddr addr, uint64_t value,
>      case R_INTERRUPT_STATUS:
>          a9_gtimer_update(s, false);
>          gtb->status &= ~value;
> +        if (gtb->status == 0) {
> +            qemu_set_irq(gtb->irq, 0);
> +        }
>          break;

Hi; thanks for this patch. I can see the situation you're trying to address,
but I can't find anything in the docs that convinces me that this change
is the right way to fix it.

The problem we have is that the a9_gtimer_update() function (which is
going to get called after this code at the end of the a9_gtimer_write()
function) updates the gtb->status bit based on whether the timer has
currently passed the compare value. So effectively we do the "has the
count gone past the compare value" check not only when the timer expires
but also at every register write. My best guess is that the real hardware
only does an expiry-check when it does a counter value update. If that's
the case then in the situation you outline the guest clearing the event
flag should mean that the interrupt is not re-asserted until the counter
next increments past the compare value (ie not for a little while) whereas
with your patch it will be instantly re-asserted.

(Unfortunately the A9 TRM is not clear on the behaviour here. It would
probably be possible to write some test code to check the real h/w
behaviour.)

thanks
-- PMM

