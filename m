Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C6DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EE523750
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qafsc2n5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EE523750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqZx-0006Cw-EK
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpqZ3-0005JZ-7V
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:59:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpqZ1-0003uW-Nq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:59:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id f139so15481893wmf.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0rdWlDVP5YWuUzGRPIYzNCS2o4FJGY1HxnmFGPFkTtE=;
 b=Qafsc2n5mNi6i6LkTMFa33O2Mw23kzCsTIgXTB+lB2M5qz+RgL6ke9m6kaCeW4pkY0
 u5QuI4uDa4eIWwygSl0tmkHjjMi5P41eyq++rkm1m5PTEu6amWAuN0DKKivvFP4eOXXy
 MOmz+KUPw+y1Kgf0ZsXTzZ5Yvmg/pAq56oTwGe26m0aukxw4toTdtVSiSC2hOkAoxsFS
 FbIZt4Chfev6PL8x5hZEolk2YCMmjEiV83ZYszLtNls7SJ79aWr0ra1IdCXEvmjXvNna
 GUIIFRfuoFKuc97sIs0pXUi2Or/EOj0OvRjjbelelbJmsuJaCPGgCWlgkf2HAH6SXjmG
 eX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0rdWlDVP5YWuUzGRPIYzNCS2o4FJGY1HxnmFGPFkTtE=;
 b=cInYl/gziSrXYW8Z81cXcWAsSjerXZftH8sm2bOl69fiaBJjbS6GWnY+1HadFNEcpL
 O9G3BcnWdtb0sr/iGDxw4RJrmU0/yY6sHQ7fb7jAulhqoELKRFq7RE2C1OICMaBt+SgI
 olKohHLv0/S0X40OEqbuWo/+bPK5VhgSbboNDxPCb2vj85EG+Kqo3s3c+VC/yC53hiPO
 ktfMQWnYUupo26QW/nT/RN2KUx9LhqkERNGMbkkDxG3DMifUDiQG5yollMZyzgajmcHp
 3EZVt50kp0CUlpzAGEBOQBjPP1xkZeJs/Bsre5gAoHZJ69pwgNi/552Oa5K1X84nDvYW
 GeeQ==
X-Gm-Message-State: AOAM532yW3QGv96z0r8Naizvk/74vm5+W8D05Lua331D1vW78RGGrUav
 nzVwrS4/lWjO/5u77vXY4lg=
X-Google-Smtp-Source: ABdhPJxBhT1pGITqGjaAvnRGzGRC5wwkSW+JdrA8x9wQlAknQ4pxcz20q0ByJv4DFU6fisYrTBnRQw==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr15277079wml.95.1593424738191; 
 Mon, 29 Jun 2020 02:58:58 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z2sm29720070wmc.2.2020.06.29.02.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:58:57 -0700 (PDT)
Subject: Re: [PULL 07/15] hw/timer: RX62N 8-Bit timer (TMR)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
 <20200621124807.17226-8-f4bug@amsat.org>
 <CAFEAcA8c2dywr=Zxz1ExAV-48JwFU5vbBDDfA=_KE98XamnXiA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1448b050-4f78-2ae3-95db-6c47baad5909@amsat.org>
Date: Mon, 29 Jun 2020 11:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8c2dywr=Zxz1ExAV-48JwFU5vbBDDfA=_KE98XamnXiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori,

On 6/25/20 11:25 AM, Peter Maydell wrote:
> On Sun, 21 Jun 2020 at 13:54, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>>
>> renesas_tmr: 8bit timer modules.
> 
> Hi; the recent Coverity run reports a potential bug in this
> code: (CID 1429976)
> 
> 
>> +static uint16_t read_tcnt(RTMRState *tmr, unsigned size, int ch)
>> +{
>> +    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> +    int elapsed, ovf = 0;
>> +    uint16_t tcnt[2];
> 
> Here we declare tcnt[] but do not initialize its contents...
> 
>> +    uint32_t ret;
>> +
>> +    delta = (now - tmr->tick) * NANOSECONDS_PER_SECOND / tmr->input_freq;
>> +    if (delta > 0) {
>> +        tmr->tick = now;
>> +
>> +        if (FIELD_EX8(tmr->tccr[1], TCCR, CSS) == INTERNAL) {
>> +            /* timer1 count update */
>> +            elapsed = elapsed_time(tmr, 1, delta);
>> +            if (elapsed >= 0x100) {
>> +                ovf = elapsed >> 8;
>> +            }
>> +            tcnt[1] = tmr->tcnt[1] + (elapsed & 0xff);
>> +        }
>> +        switch (FIELD_EX8(tmr->tccr[0], TCCR, CSS)) {
>> +        case INTERNAL:
>> +            elapsed = elapsed_time(tmr, 0, delta);
>> +            tcnt[0] = tmr->tcnt[0] + elapsed;
>> +            break;
>> +        case CASCADING:
>> +            if (ovf > 0) {
>> +                tcnt[0] = tmr->tcnt[0] + ovf;
>> +            }
>> +            break;
>> +        }
> 
> ...but not all cases here set both tcnt[0] and tcnt[1]
> (for instance in the "case CASCADING:" if ovf <=0 we
> won't set either of them)...
> 
>> +    } else {
>> +        tcnt[0] = tmr->tcnt[0];
>> +        tcnt[1] = tmr->tcnt[1];
>> +    }
>> +    if (size == 1) {
>> +        return tcnt[ch];
>> +    } else {
>> +        ret = 0;
>> +        ret = deposit32(ret, 0, 8, tcnt[1]);
>> +        ret = deposit32(ret, 8, 8, tcnt[0]);
>> +        return ret;
> 
> ...and so here we will end up returning uninitialized
> data. Presumably the spec says what value is actually
> supposed to be returned in these cases?
> 
> PS: the "else" branch with the deposit32() calls could be
> rewritten more simply as
>   return lduw_be_p(tcnt);
> 
>> +static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
>> +{
> 
> In this function Coverity reports a missing "break" (CID 1429977):
> 
>> +    case A_TCORA:
>> +        if (size == 1) {
>> +            return tmr->tcora[ch];
>> +        } else if (ch == 0) {
>> +            return concat_reg(tmr->tcora);
>> +        }
> 
> Here execution can fall through but there is no 'break' or '/* fallthrough */'.
> 
>> +    case A_TCORB:
>> +        if (size == 1) {
>> +            return tmr->tcorb[ch];
>> +        } else {
>> +            return concat_reg(tmr->tcorb);
>> +        }
> 
> Is it correct that the A_TCORA and A_TCORB code is different?
> It looks odd, so if this is intentional then a comment describing
> why it is so might be helpful to readers.

Can you address Peter's comments please?

> 
> thanks
> -- PMM
> 

