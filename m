Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425C7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5308D206CA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6sUAiUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5308D206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvtr-0000hu-7q
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUvia-0002eL-QG
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:46:41 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUviY-0002Xi-3o
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:46:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id e2so2953393wme.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8V2Slx5tD9PTSE5xqYsvaksAO0OiuvgS8+CETC5+GhQ=;
 b=V6sUAiUNGhc+wN8LAZo5eNU6wIbfPn9j39DEzSuWHPSORDOafbUQtajB4LVt8IHDIg
 pWrR2qpIpFrWwJY3NaN0YbaShpsdNSo8G3DiG7986EQKEm41E5BB/60SsAWZ0wSHVaJ6
 WXlVWKdKodhlXMDyTNVwDWePH2zrmz3VIh6cRGZ7cNo3X31aZgOGrjZPoDpFIw0aR8h1
 P4+dos7TSM0K9bnALDZAc81DCZ5u89ZjfNVRAnR8SEnUZ79bidst+iUN3jJACbs8DAYl
 v75BuUBhwJaG6PXkHAtGFIz6lPmX+pXA5b7ZejaacFSNqzOo3GaMgJgglp4OrhFhaKRB
 cenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8V2Slx5tD9PTSE5xqYsvaksAO0OiuvgS8+CETC5+GhQ=;
 b=k2UusUBE7jqZEE9dWArzGap6PdjErUeaEBRQcFiWCFlDZNKov8fldbBs+UjktZJyT9
 CJp1U7Duo5nlhVJX+W7Lj0hjeJwXex49eeSgFtaL4Rdvl+htwL1p7cfxbY+fCvEx8azT
 jSDCx1ndbILbNrhVh4NjWnfG9V9kCeNy3d4UpePvB9AAzjt5ZZKX34haKRrZlryQsIsn
 ulw08ZtXhrZgAxoqh9cv3daQZBRj4yO3U/AcFd4yzsO4pPa/buUwGvaBSKMCw+U7aA04
 Kz4x0YFT4IA8RPhI3Fl76W1aqItOjQ+UPMAZauPDrJ8ePlQ4eSACzCdqOAWIkOXyotzO
 iU0A==
X-Gm-Message-State: AOAM530Hgq8zgqrOy8at9wbaNu+xB9Tm0pikZKn7o6JwTJ0z5/7ZD6ab
 EqBvJbu3+KSLRY/KoiIpLVg=
X-Google-Smtp-Source: ABdhPJzzy2Dwv7442naJgE399jZMUQlve8SQhl8VJA+0bZFdnvMky8nNK5mHB5C6UORifPMQ0ki4NQ==
X-Received: by 2002:a1c:98d2:: with SMTP id a201mr3980122wme.166.1603215994315; 
 Tue, 20 Oct 2020 10:46:34 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x10sm4073214wrp.62.2020.10.20.10.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 10:46:33 -0700 (PDT)
Subject: Re: [PULL 09/31] hw/core/clock: introduce clock object
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
 <20200430115142.13430-10-peter.maydell@linaro.org>
 <f295c99f-0405-1c26-6f58-12abdec8bd3d@amsat.org>
 <9fc9b0cf-4919-40b5-0430-cfac6fd7bbef@amsat.org>
 <CAFEAcA-pZ_=FvPC7TtzhcfM3rdgL8c_VOyDHo5ycBb5ezUPufw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0e4c70ce-9c26-a2d6-9308-827774656882@amsat.org>
Date: Tue, 20 Oct 2020 19:46:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-pZ_=FvPC7TtzhcfM3rdgL8c_VOyDHo5ycBb5ezUPufw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 6:46 PM, Peter Maydell wrote:
> On Tue, 20 Oct 2020 at 17:06, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 10/17/20 1:47 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Damien, Peter,
>>>
>>>> +/*
>>>> + * macro helpers to convert to hertz / nanosecond
>>>> + */
>>>> +#define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_SECOND / 1000000000llu))
>>>> +#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_SECOND / 1000000000llu))
>>>> +#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_SECOND / (hz) :
>>>> 0u)
>>>
>>> I'm having Floating Point Exception using a frequency of 1GHz.
>>>
>>> Using frequency >=1GHz we have CLOCK_PERIOD_FROM_HZ(hz) > 0x100000000.
>>>
>>> Then CLOCK_PERIOD_TO_NS(0x100000000) = 0.
>>>
>>> So for frequency >=1GHz clock_get_ns() returns 0.
>>
>> So Peter suggested on IRC to rewrite the code consuming this API
>> to avoid reaching this limit :)
>>
>> Still some assert would help other developers triggering the same
>> issue to quicker figure how to bypass the problem.
> 
> The fundamental problem here is that if you have a 2GHz
> clock then it is just not possible to have an API which
> says "give me the period of this clock in nanoseconds
> as an integer".
> 
> Even for clocks which have lower frequencies, there is
> still a rounding/accuracy problem when converting to
> a nanoseconds count. I think these macros and the
> functions that wrap them are in retrospect a mistake,
> and we should replace them with other APIs that allow
> calculations which can avoid the rounding problem
> (eg if what you need is "how many nanoseconds is it
> until 5000 ticks have expired" we would need an API
> for that, rather than trying to calculate it as
> 5000 * nanoseconds_per_tick).
> 
> It looks like currently the only uses of CLOCK_PERIOD_TO_NS()
> and clock_get_ns() are:
>   * some tracepoints in the clock code itself
>   * mips_cp0_period_set(), which does:
>      env->cp0_count_ns = cpu->cp0_count_rate
>                          * clock_get_ns(MIPS_CPU(cpu)->clock);
>     so I think it is trying to calculate "nanoseconds for
>     X ticks of the clock".
> 
> CLOCK_PERIOD_TO_HZ() and clock_get_hz() are used by:
>   * the qdev_print() code that prints a human-readable
>     description of the clock
>   * hw/char/cadence_uart.c and hw/char/ibex_uart.c code
>     that calculates a baud rate given the input clock
> 
> CLOCK_PERIOD_FROM_HZ and CLOCK_PERIOD_FROM_NS are
> used only in the clock_update*() and clock_set*()
> functions. I think those should all be OK, because
> they're just setting the period of the clock (possibly
> propagating it to connected clocks), and we can
> assume the caller uses whatever unit they naturally
> have available as the accurate way to set the clock.
> 
> So that suggests to me that we should look at designing
> APIs for:
>   * "give me the time in nanoseconds for X ticks of this clock"
>   * "give me a human-readable string describing this clock"
>     for the qdev_print() monitor output

Half of it is commit 709616c713f
("util/cutils: Introduce freq_to_str() to display Hertz units")

Other half on the list:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg749603.html

> 
> and we should adjust the clock_set and clock_update tracepoints
> to trace the raw period values (perhaps with an extra
> "approx %"PRIu64" ns" for the benefit of humans reading traces).
> Then we can delete CLOCK_PERIOD_TO_NS() and clock_get_ns().
> 
> Not sure about what the UART code should be doing. Given
> that it's basically calculating baud rates it does eventually
> want to get a frequency in hz but maybe we should arrange
> for the frequency-division part to happen before we
> convert from clock-period to hz rather than after.
> 
> thanks
> -- PMM
> 

