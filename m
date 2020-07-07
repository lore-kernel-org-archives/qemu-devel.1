Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831D7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F6220674
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tee1x5uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F6220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspBK-0004aN-JG
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsp9Q-0001DM-Hm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:04:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsp9O-00030x-Qb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:04:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id a6so45530859wrm.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x+IoXirChmdp3zBiKN8Yfjj2AmyQMe6UmqiATS78ywk=;
 b=Tee1x5uY9Bk9qY5Gi45XGEwTyPRTaWGEKqh6WCxS9yG5ymmT/WVLPDPLoDU11jT0Gk
 9810/oQVBchQgEwhLqb32r91FQCQIXz86TWUr6x/QUPtJvvbXvYjinQAC3G2up6Kjm+Y
 BXq9AX4YdT1CFKsMZCDamvvrl2uEQjvrChh1rICR7S79zPGhy+SLu7aOeEEgKMuz/1Oq
 qMch+5t1AQ8DVXD8jx9Iiqcy5wCCNVvxZp2g6g2lRyLnhh6ufz8QYX7uRtinHmx0vB8Z
 340vubs9TbHzsC31zjAxDNZp5fhCyTeSUbtWmn2ACLm7GDkOqAzrwbFnB99PWs0qHmkA
 4Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x+IoXirChmdp3zBiKN8Yfjj2AmyQMe6UmqiATS78ywk=;
 b=VSVZjARhGFz2NeJHrPLqBBIhy1ndni3ife0BkyUxBQFkj77I5rUMQmOPKOAfF2O8QJ
 md5eveXTuKd/HjGIhKet2jsKibqpiW/t3o75aY5MvG8ECNtM9JmytRMcqsf7qSfoj3Ec
 2kdR209YbJJYFtdk5DRxBpYJBtRRF+6cnlS3TSTbCKZcH/dpate/LVTJ9XZr2gmiW5Ez
 2lRN2oEFE/voxq9qTqRqd86cg5QELeSPkU+d61fUSvxOQUST+l9N/WCZCvlxAYdq/Wud
 GvSBwfaroixhPqLvswRaAr4jF68vGhXfjWgR9N4/egw3UDN0hWWOFRk0e1+ToWcH5Wjf
 Vuvw==
X-Gm-Message-State: AOAM533GP+cf7ek4rhtsh2yh+8DNVY/FC4+eBLV1BxmXvA3E32/1mDuA
 hF4dpEhbFd1Vb/LjO9YuDEA=
X-Google-Smtp-Source: ABdhPJy9nbbyk/O3LfcJWwEHNlYPVQNSzXnw51asw/r/GMcUEs0JuUqP3lhcGJsFTu2hb2TwuUFpog==
X-Received: by 2002:adf:e811:: with SMTP id o17mr58016972wrm.53.1594134289399; 
 Tue, 07 Jul 2020 08:04:49 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u23sm1466045wru.94.2020.07.07.08.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 08:04:48 -0700 (PDT)
Subject: Re: [PULL 07/15] hw/timer: RX62N 8-Bit timer (TMR)
To: Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20200621124807.17226-1-f4bug@amsat.org>
 <20200621124807.17226-8-f4bug@amsat.org>
 <CAFEAcA8c2dywr=Zxz1ExAV-48JwFU5vbBDDfA=_KE98XamnXiA@mail.gmail.com>
 <1448b050-4f78-2ae3-95db-6c47baad5909@amsat.org>
 <878sfv9xmi.wl-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1b6e18a8-6baf-7b37-b48c-9029bca88d6e@amsat.org>
Date: Tue, 7 Jul 2020 17:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <878sfv9xmi.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 5:02 PM, Yoshinori Sato wrote:
> On Mon, 29 Jun 2020 18:58:56 +0900,
> Philippe Mathieu-Daudé wrote:
>>
>> Hi Yoshinori,
>>
>> On 6/25/20 11:25 AM, Peter Maydell wrote:
>>> On Sun, 21 Jun 2020 at 13:54, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>>
>>>> renesas_tmr: 8bit timer modules.
>>>
>>> Hi; the recent Coverity run reports a potential bug in this
>>> code: (CID 1429976)
>>>
>>>
>>>> +static uint16_t read_tcnt(RTMRState *tmr, unsigned size, int ch)
>>>> +{
>>>> +    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>>> +    int elapsed, ovf = 0;
>>>> +    uint16_t tcnt[2];
>>>
>>> Here we declare tcnt[] but do not initialize its contents...
>>>
>>>> +    uint32_t ret;
>>>> +
>>>> +    delta = (now - tmr->tick) * NANOSECONDS_PER_SECOND / tmr->input_freq;
>>>> +    if (delta > 0) {
>>>> +        tmr->tick = now;
>>>> +
>>>> +        if (FIELD_EX8(tmr->tccr[1], TCCR, CSS) == INTERNAL) {
>>>> +            /* timer1 count update */
>>>> +            elapsed = elapsed_time(tmr, 1, delta);
>>>> +            if (elapsed >= 0x100) {
>>>> +                ovf = elapsed >> 8;
>>>> +            }
>>>> +            tcnt[1] = tmr->tcnt[1] + (elapsed & 0xff);
>>>> +        }
>>>> +        switch (FIELD_EX8(tmr->tccr[0], TCCR, CSS)) {
>>>> +        case INTERNAL:
>>>> +            elapsed = elapsed_time(tmr, 0, delta);
>>>> +            tcnt[0] = tmr->tcnt[0] + elapsed;
>>>> +            break;
>>>> +        case CASCADING:
>>>> +            if (ovf > 0) {
>>>> +                tcnt[0] = tmr->tcnt[0] + ovf;
>>>> +            }
>>>> +            break;
>>>> +        }
>>>
>>> ...but not all cases here set both tcnt[0] and tcnt[1]
>>> (for instance in the "case CASCADING:" if ovf <=0 we
>>> won't set either of them)...
>>>
>>>> +    } else {
>>>> +        tcnt[0] = tmr->tcnt[0];
>>>> +        tcnt[1] = tmr->tcnt[1];
>>>> +    }
>>>> +    if (size == 1) {
>>>> +        return tcnt[ch];
>>>> +    } else {
>>>> +        ret = 0;
>>>> +        ret = deposit32(ret, 0, 8, tcnt[1]);
>>>> +        ret = deposit32(ret, 8, 8, tcnt[0]);
>>>> +        return ret;
>>>
>>> ...and so here we will end up returning uninitialized
>>> data. Presumably the spec says what value is actually
>>> supposed to be returned in these cases?
>>>
>>> PS: the "else" branch with the deposit32() calls could be
>>> rewritten more simply as
>>>   return lduw_be_p(tcnt);
>>>
>>>> +static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
>>>> +{
>>>
>>> In this function Coverity reports a missing "break" (CID 1429977):
>>>
>>>> +    case A_TCORA:
>>>> +        if (size == 1) {
>>>> +            return tmr->tcora[ch];
>>>> +        } else if (ch == 0) {
>>>> +            return concat_reg(tmr->tcora);
>>>> +        }
>>>
>>> Here execution can fall through but there is no 'break' or '/* fallthrough */'.
>>>
>>>> +    case A_TCORB:
>>>> +        if (size == 1) {
>>>> +            return tmr->tcorb[ch];
>>>> +        } else {
>>>> +            return concat_reg(tmr->tcorb);
>>>> +        }
>>>
>>> Is it correct that the A_TCORA and A_TCORB code is different?
>>> It looks odd, so if this is intentional then a comment describing
>>> why it is so might be helpful to readers.
>>
>> Can you address Peter's comments please?
> 
> This register can 8bit and 16bit access.
> 8bit case return separate single TCORA or TCORB.
> 16bit case return merged two channel's TCORA or TCORB.
> high byte: channel 0 register.
> low byte: channel 1 register

Thanks, can you send a patch to fix the potential bug?

> 
>>>
>>> thanks
>>> -- PMM
>>>
>>
> 

