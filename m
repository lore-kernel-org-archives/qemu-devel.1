Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F27C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 22:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0062721707
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 22:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR+Pb+4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0062721707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWSLk-0007xI-IS
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 18:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWSKG-0007Vb-Oy
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 18:47:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWSKF-0001aD-2b
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 18:47:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id k18so7644199wmj.5
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OXK9CpMEpIL1JchRDCYvDfdOqoLMfpBpqesvrtK7ZyA=;
 b=OR+Pb+4+aEevDqTgOhxHG2EifYfZQC8m1WdtXm0RtCvqIkcqPveOsFNS+AvgPXT6dx
 aHrI3pzHshIwi6gzM7QiwyKGfeBYRZY17CRcvDsCWYpU3nAMceaHf1Uisnk0HEQKbUzI
 lHKThBN3nnZA62DHFtugrnD2E4sPZBUf4kikSN9cula1j3D/qZx12yBbYqALH2P3wHXP
 45fPnqpmBc+mVoAhF3rad2aztmcAHRveouNcRDtC+rqR0yqhLyGKg+Aven14JVTPsxk7
 x1ahelCU5TVjz5sEcjF0R6wGq91mm3czxQ8k45+Cg6nRqzOXvWqQYPAZKH0GEywLxoeF
 +30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OXK9CpMEpIL1JchRDCYvDfdOqoLMfpBpqesvrtK7ZyA=;
 b=JdNsa+RERTl6OEO7hf+/Sf08UtO5TDCjrtLj3MYQRfM8L8IijZ13vY4Fi9v+IB8wCT
 v5wRV3sLgpbwTnbliMs6CD3fDD1HLTaat4H8zzWJDBXTV303vocS67GqupJQpzMRNmon
 FcYkonX7lktc57B8d6DcyeXwGxFOVlLKpOyBkOFvGjs5O8s7DoSjY7kBldTyz2JaHCio
 z0nXVt/QCUK0SA3TVneTIfsAxnR+3ugIcPJwtt7gJ5QJFNEFG+KgritcfYuB+o82H36r
 C/XmrZfUOdNya46HspFV2bVBuwFmKOx6Vy7QHxKjpuC98VyuwlbK7sBgVKSztrwTcQWj
 9YVA==
X-Gm-Message-State: AOAM530hLC2hpc/PKP5kBdJQLWW9/l5AygVDF7vBwVz712YsWs72MQ9x
 0xfpRCdtJvoAFK2cnkjrgN5GnsLvjF8=
X-Google-Smtp-Source: ABdhPJyIb9gRIV15y64rita+od1jCKpNjSN+nafNAdasyfTp2J33U1mWkrYCxyi8SDKZpHvIXyYjLg==
X-Received: by 2002:a7b:c085:: with SMTP id r5mr8556072wmh.17.1603579668742;
 Sat, 24 Oct 2020 15:47:48 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v6sm12271229wmj.6.2020.10.24.15.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 15:47:48 -0700 (PDT)
Subject: Re: [PATCH 08/20] hw/timer: Renesas TMU/CMT module.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-9-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd6bc3f1-f10a-f2af-ccda-d21ff60801a3@amsat.org>
Date: Sun, 25 Oct 2020 00:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-9-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> TMU - SH4 Timer module.
> CMT - Compare and match timer used by some Renesas MCUs.
> 
> The two modules have similar interfaces and have been merged.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   include/hw/timer/renesas_timer.h | 103 +++++
>   hw/timer/renesas_timer.c         | 639 +++++++++++++++++++++++++++++++
>   hw/timer/Kconfig                 |   4 +-
>   hw/timer/meson.build             |   2 +-
>   4 files changed, 745 insertions(+), 3 deletions(-)
>   create mode 100644 include/hw/timer/renesas_timer.h
>   create mode 100644 hw/timer/renesas_timer.c
...

> +static void update_clk(RenesasTimerBaseState *tmr, int ch)
> +{
> +    RenesasTimerBaseClass *tc = RenesasTimer_GET_CLASS(tmr);
> +    int t;
> +    t = tc->divrate(tmr, ch);
> +    if (t > 0) {
> +        t = tmr->input_freq / t;

If the clock is connected between INIT and REALIZE,
then t=0 and ...

> +        tmr->ch[ch].clk = NANOSECONDS_PER_SECOND / t;

... you get a DIV#0 here.

You can avoid it using clock_get_hz(tmr->pck) instead of
tmr->input_freq, which can be removed IMO.

> +    } else {
> +        tmr->ch[ch].clk = 0;
> +    }
> +}
...

> +static void tmr_pck_update(void *opaque)
> +{
> +    RenesasTimerBaseState *tmr = RenesasTimerBase(opaque);
> +    int64_t now;
> +    int i;
> +    struct rtimer_ch *ch;
> +    for (i = 0; i < TIMER_CH_CMT; i++) {
> +        if (tmr->ch[i].start) {
> +            tmr->ch[i].cnt = read_tcnt(tmr, i);
> +        }
> +    }
> +    if (clock_is_enabled(tmr->pck)) {
> +        tmr->input_freq = clock_get_hz(tmr->pck);
> +        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        for (i = 0; i < TIMER_CH_CMT; i++) {
> +            update_clk(tmr, i);
> +            ch = &tmr->ch[i];
> +            if (ch->start) {
> +                ch->next = ch->base = now;
> +                if (tmr->direction == countup) {
> +                    ch->next += (ch->cor - ch->cnt) * ch->clk;
> +                } else {
> +                    ch->next += ch->cnt * ch->clk;
> +                }
> +                timer_mod(ch->timer, ch->next);
> +            }
> +        }
> +    } else {
> +        for (i = 0; i < TIMER_CH_CMT; i++) {
> +            if (tmr->ch[i].timer) {
> +                timer_del(tmr->ch[i].timer);
> +            }
> +        }
> +    }
> +}
...

> +static void cmt_init(Object *obj)
> +{
> +    SysBusDevice *d = SYS_BUS_DEVICE(obj);
> +    RenesasCMTState *cmt = RenesasCMT(obj);
> +    RenesasTimerBaseState *tmr = RenesasTimerBase(cmt);
> +    int i;
> +
> +    tmr->direction = countup;
> +    memory_region_init_io(&tmr->memory, obj, &cmt_ops,
> +                          tmr, "renesas-cmt", 0x10);
> +    sysbus_init_mmio(d, &tmr->memory);
> +
> +    for (i = 0; i < TIMER_CH_CMT; i++) {
> +        sysbus_init_irq(d, &tmr->ch[i].irq);
> +    }
> +    tmr->pck = qdev_init_clock_in(DEVICE(obj), "pck",
> +                                  tmr_pck_update, tmr);
> +}
...

