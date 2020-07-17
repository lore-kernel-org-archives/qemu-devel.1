Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680C0C433ED
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3212C20737
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+Cp5qx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3212C20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwLSB-00009E-Go
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 04:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwLRb-0007xC-Sr; Fri, 17 Jul 2020 04:10:11 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwLRa-0006Lq-Cz; Fri, 17 Jul 2020 04:10:11 -0400
Received: by mail-ej1-x644.google.com with SMTP id lx13so9860584ejb.4;
 Fri, 17 Jul 2020 01:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1rLsucYSazwups+3sxbPn4vlbmq9LgJeurMTfNn3444=;
 b=I+Cp5qx6Vs5rMdwvkbGCtItSGEBSjNW3S5LKbjBJ5IFCZVlFlOAw98SN2nsA6hTVLS
 T6o21FYxuwwPYMgfsLJDi99/Y1TZJ3ldj/LgF72EKwVmcHw27gP6QLGpzlfO3/kK3fpf
 CkkYC3/TLNwpOSAqWHSoLTLEDbaAs2QQxEkPAzswr4+OIyoP7K0pEnwuH9nThA+T0KwY
 qh5+SOZA1NRAtbxa9EHiuuPNKrzsnbVwI8uP07I0dYCHtaUldai0YlSAy87XOI8CaZgd
 ysKLDTseyb7I9Sabf/k0XH4uOCBBeIhYz08t4RGOyLjZJqbxdTCtBVoPP5o+qlXaLXJH
 29FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1rLsucYSazwups+3sxbPn4vlbmq9LgJeurMTfNn3444=;
 b=UIilX1c9gdHg4QXlNgrmv8SHHVoEPHmNOeTWUAUya41b5cIoP5IrT34quFWJYiZdiD
 iCFw4fUZmsn6/rL4eKC4VtTNA50RmjhDp6kkj3+I9nELXzICfHIJLuQlNX3DSWl1Vg1F
 32lhgtgsYbuN5oxW8zaZ59kCW+HeLEfQ110dXFDJsJPeqA4M5cT8szyP4Abq9ZYharsk
 cRLewMT8yOUcvKlzEAd7Fde28ttmCZIINp+ftiEz/E1XDHYv2cHjEiLFXDIvOT0N9IUe
 aNbLhvITIZggC2n2r7nhivLfUR4H86bfbQlzxQXC3nrp58ML3YbcyUb3eDuivjyKgecv
 pSLQ==
X-Gm-Message-State: AOAM533iUX000y/HB0DedNnkcneMEiGCB+4hCCfQ3DbstUvrpfeMN45U
 IjvOKZR/Z6ugss/dW/a+HWs=
X-Google-Smtp-Source: ABdhPJw14qnyI2ltD1nnQ3neUSkGt3EQZWDQhhqml7kc4dgCGvQR2aZQecTeI3QHprKLC36u2Dth0w==
X-Received: by 2002:a17:906:e215:: with SMTP id
 gf21mr7228217ejb.310.1594973408219; 
 Fri, 17 Jul 2020 01:10:08 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u5sm7173847ejz.15.2020.07.17.01.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 01:10:07 -0700 (PDT)
Subject: Re: [PATCH v6 03/13] hw/timer: Add NPCM7xx Timer device model
To: Havard Skinnemoen <hskinnemoen@google.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200717060258.1602319-1-hskinnemoen@google.com>
 <20200717060258.1602319-4-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c8786cce-6555-d4c4-ada9-7dec05b0853c@amsat.org>
Date: Fri, 17 Jul 2020 10:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200717060258.1602319-4-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: kfting@nuvoton.com, Avi.Fishman@nuvoton.com, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 8:02 AM, Havard Skinnemoen wrote:
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
>  include/hw/timer/npcm7xx_timer.h |  96 ++++++
>  hw/timer/npcm7xx_timer.c         | 489 +++++++++++++++++++++++++++++++
>  hw/timer/Makefile.objs           |   1 +
>  hw/timer/trace-events            |   5 +
>  4 files changed, 591 insertions(+)
>  create mode 100644 include/hw/timer/npcm7xx_timer.h
>  create mode 100644 hw/timer/npcm7xx_timer.c
...

> +/*
> + * Raise the interrupt line if there's a pending interrupt and interrupts are
> + * enabled for this timer. If not, lower it.
> + */
> +static void npcm7xx_timer_check_interrupt(NPCM7xxTimer *t)
> +{
> +    NPCM7xxTimerCtrlState *tc = t->ctrl;
> +    int index = npcm7xx_timer_index(tc, t);
> +
> +    if ((t->tcsr & NPCM7XX_TCSR_IE) && (tc->tisr & BIT(index))) {
> +        qemu_irq_raise(t->irq);
> +        trace_npcm7xx_timer_irq(DEVICE(tc)->canonical_path, index, 1);
> +    } else {
> +        qemu_irq_lower(t->irq);
> +        trace_npcm7xx_timer_irq(DEVICE(tc)->canonical_path, index, 0);
> +    }

Maybe simpler:

  bool pending = (t->tcsr & NPCM7XX_TCSR_IE) && (tc->tisr & BIT(index));

  trace_npcm7xx_timer_irq(DEVICE(tc)->canonical_path, index, pending);
  qemu_set_irq(t->irq, pending);

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

