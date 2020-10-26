Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779E5C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA030207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlwgjIPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA030207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAWm-0002Ht-Ue
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 17:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXAUm-0000Tt-Ge; Mon, 26 Oct 2020 17:57:40 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXAUk-0004F0-E3; Mon, 26 Oct 2020 17:57:40 -0400
Received: by mail-ej1-x643.google.com with SMTP id c15so16079203ejs.0;
 Mon, 26 Oct 2020 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+z2T54+lubO+eTL8uNz1bF4KBhuuk2J1BX73PNywKJg=;
 b=MlwgjIPcyRgl2RBuPv3p7BPmlGScCZrGqRVkyXbrqufifeAtBIFHi9I1A9oRdzOEWA
 IkZiUMOWUdyCQOIjWSnpFqnC5enMhQG9+cad9sij1HoxoIu+5DyIsI5mD6WF/ycqLkoR
 TpIIh2vPBnDFvOdvaSzCjL4/zY5lHgGTFT1NsZyt39nFzi4kIQ5Z1A0EIMeNn81mYNAY
 uwBwxIk+0FrGFJ3qShwJRraydkXD637SuSMs6f8+91I9imWbhXRZRult8/LH9OK8AuGs
 txhBzR4z08QBdGXydB4hWGKniQklwHLPTeLDwkNdp1IychuORhX6T/84rJa8YxOxLcap
 NeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+z2T54+lubO+eTL8uNz1bF4KBhuuk2J1BX73PNywKJg=;
 b=ra+wHZwZMLXpvAKvFadbXm8+aCkPpz6wbaakoihft8xXYPWfXPbipyv5i49qOhA3CJ
 Jx/7jkOomzZRcprrxNs3a9CbUvkyEaOln142rW/LITJ4hMzjbBN04/haZBt7wXuUwMAW
 XvF/RooiplAe4H8JmwmVL+TqU2amTSNXnG7n/WjUcJs4fRT2JmLX1SEzvXh9RFspUnU1
 bMsYfw60Tw1gJFZavpYIK/GCS7X2sUF0opiI4vTjjn9w04CvFBOgvl6z4Jab490g4NSc
 BBZcWU4Asmak8CrqLkLPr76iS/LVz99AzhE9CADgpaKo3V+IZrwgod3daKr5cG0+W1Iv
 t/mg==
X-Gm-Message-State: AOAM530SxeeS9B4zKgyENSvKRrhn2tHg8COlrimY/mx//Bev5F1pC8HV
 LA8yIR/u6OyDqzxf4n0lmsDk2Aqhpls=
X-Google-Smtp-Source: ABdhPJxB+Lhe7NTfnVSUvlegOc+4RaA4tXLuDHhfwgxR93YgF7eUFUuTydargTMXU8JvxrvswfD6kg==
X-Received: by 2002:a17:906:d292:: with SMTP id
 ay18mr18118111ejb.244.1603749456278; 
 Mon, 26 Oct 2020 14:57:36 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p3sm5814136edy.38.2020.10.26.14.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 14:57:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/timer/armv7m_systick: Rewrite to use ptimers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
References: <20201015151829.14656-1-peter.maydell@linaro.org>
 <20201015151829.14656-3-peter.maydell@linaro.org>
 <CAFEAcA-4qq=kknVKck_tGdFaj6F8QP9MCOiqvydLcs4F+tmffA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d9e1c66d-7b4d-3f3a-1e98-afdc8e2946cc@amsat.org>
Date: Mon, 26 Oct 2020 22:57:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-4qq=kknVKck_tGdFaj6F8QP9MCOiqvydLcs4F+tmffA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 5:31 PM, Peter Maydell wrote:
> On Thu, 15 Oct 2020 at 16:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> The armv7m systick timer is a 24-bit decrementing, wrap-on-zero,
>> clear-on-write counter. Our current implementation has various
>> bugs and dubious workarounds in it (for instance see
>> https://bugs.launchpad.net/qemu/+bug/1872237).

Nice cleanup :)

Nitpicking we should replace the 24-bit 0xffffff constant by
a definition.

> 
> ...and 10 minutes after sending this I realized I'd forgotten
> to finish removing the no-longer-needed state struct fields.
> This should be squashed in:
> 
> diff --git a/include/hw/timer/armv7m_systick.h
> b/include/hw/timer/armv7m_systick.h
> index 84496faaf96..d57e299fd89 100644
> --- a/include/hw/timer/armv7m_systick.h
> +++ b/include/hw/timer/armv7m_systick.h
> @@ -26,8 +26,6 @@ struct SysTickState {
>       /*< public >*/
> 
>       uint32_t control;
> -    uint32_t reload;
> -    int64_t tick;
>       ptimer_state *ptimer;
>       MemoryRegion iomem;
>       qemu_irq irq;
> diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
> index 2f192011eb0..5ac3a8a7e81 100644
> --- a/hw/timer/armv7m_systick.c
> +++ b/hw/timer/armv7m_systick.c
> @@ -219,7 +219,6 @@ static const VMStateDescription vmstate_systick = {
>       .minimum_version_id = 2,
>       .fields = (VMStateField[]) {
>           VMSTATE_UINT32(control, SysTickState),
> -        VMSTATE_INT64(tick, SysTickState),
>           VMSTATE_PTIMER(ptimer, SysTickState),
>           VMSTATE_END_OF_LIST()
>       }

Patch + hunk:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

