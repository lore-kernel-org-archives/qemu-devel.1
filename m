Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50B5C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B26920758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBEsRopp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B26920758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYk8-0006M7-PK
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDYcM-0001TD-6y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:40:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDYcK-0003N3-Bw
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:40:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id m6so668323wrn.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rkdo8iHhkaxue97PGqqKNR8LV29yrxlgCtNFWd5dbJI=;
 b=lBEsRopplLqnTgk3hq8P3JlAryT89WzzNobXt/QHL4YpS1mIp/In4HJgZUZGWHwfr8
 tdRz9GvNQ4RYgD+bG+2buPQAfaWuRxnsy7uqobaubr0q/p2Wo5aBxAr02k1u0m/Hivyw
 LSdydgJ6eIfsW9/SyIjC+j43bIZr3uDZqcNLU0KwdO3RnIXlAibm9UjI6+m1oL72tXQe
 7NdjdEeza1lr2CvIsbfWMuSuV3GOuelQx67XbFzeSxmpbzRg6PMnVXv6HZ409zNeUqmJ
 3Apm/QguBZcahehRiY86GLsB+ILC1d6y89YELnV+WW3SYTK40Z/VKR56OOjgnA/UQmvj
 emaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rkdo8iHhkaxue97PGqqKNR8LV29yrxlgCtNFWd5dbJI=;
 b=E+zN/0qfGiW0UXlaW+xfnvvAX83UzCEpXSNA1WTwGO1XmB9Exzt73/rOnmWnaywqD5
 rlolx9Saf+/A/W9q7FGUNp+c+njrBcp/zanPnbyx0y/Od/HM+Da7aMhwZs6tnS3Al21j
 96Th+lm8P4kixFcsCImKwppuVnGyNOC3d4bLx3BHWbebVi+6y9r2ZESyWokrB7FqB1c5
 oRqgR1NXliKHwbBIK9rK6mj8obsAC0dBnwqsBBj8fmp7ZmoSwNTKjsGHt9XsNDCUl6ZY
 vexNuBTdKXxTSA4rS6Iyb92DcfIB9AZSTIxrD369MBeQ6NAPBJLMVGLhLm1vSa2xyBpJ
 Rlfw==
X-Gm-Message-State: AOAM531w4S3EujEQOpi8c2gh+ieGXimWfH9Lye2J1izYJq0dC6BtxNDg
 0jboEndqUCad5GA+OU+8NaE=
X-Google-Smtp-Source: ABdhPJwD8lArUA4E8IZQetzAiQMoGu7jNFUKlYPpzoLHrr9k1OlmvdL8J6GZZ114neNJYXHnkH7W2A==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr9041029wrp.187.1599075622790; 
 Wed, 02 Sep 2020 12:40:22 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id w21sm1026410wmk.34.2020.09.02.12.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 12:40:22 -0700 (PDT)
Subject: Re: hw/clock: What clock rate for virt machines?
To: Peter Maydell <peter.maydell@linaro.org>
References: <bbdacc80-a321-5f06-e430-973a38e7e037@amsat.org>
 <CAFEAcA8mwjWP-KhJ5bp_Qo_h81Mt_yn8k_5oepgMas9COBQgWQ@mail.gmail.com>
 <f7b28480-c841-f0d7-a848-b5f1775ec12d@amsat.org>
 <CAFEAcA-3bkPkxuMXN7Wd-zBKajzXOr+Vib7XzCzsT_8YYQzTzQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <78ed6915-e941-247f-7333-8944249a10ed@amsat.org>
Date: Wed, 2 Sep 2020 21:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-3bkPkxuMXN7Wd-zBKajzXOr+Vib7XzCzsT_8YYQzTzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.324,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 8:18 PM, Peter Maydell wrote:
> On Wed, 2 Sep 2020 at 18:03, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 9/2/20 6:49 PM, Peter Maydell wrote:
>>> On Wed, 2 Sep 2020 at 17:35, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>> Peter said "'clock' is basically meaningless for virt machines",
>>>>
>>>> I understand and agree. But how to make that explicit/obvious in
>>>> the code, when a device expects a clock frequency/period?
>>>
>>> When a particular *device* needs a clock, then presumably
>>> it has a defined purpose for it, and we can pick a
>>> frequency for it then.
>>>
>>>> See for example hw/riscv/virt.c, it uses the following (confusing
>>>> to me) in virt_machine_init():
>>>>
>>>>    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
>>>>        0, qdev_get_gpio_in(DEVICE(mmio_plic), UART0_IRQ), 399193,
>>>>        serial_hd(0), DEVICE_LITTLE_ENDIAN);
>>>
>>> In this case, the board has a model of a 16550A UART on it,
>>> which uses its input clock to determine what the actual baud
>>> rate is for particular guest settings of the divisor registers.
>>> So we need to look at:
>>>  * what does guest software expect the frequency to be?
>>
>> QEMU is supposed to model machine with no knowledge of the guest,
>> but the virt case is a particular one indeed... as it has to know
>> it is virtualized.
>>
>>>  * what is a "good" frequency which gives the guest the best
>>>    possible choices of baud rate?
>>
>> I'll think about it...
> 
> My guess is that guest code assumes "same frequency an
> x86 PC uses", but a risc-v person might know better...
> 
> (For QEMU I think it only makes a visible difference when
> you pass a host serial port through to the guest as
> otherwise we ignore whatever baud rate the guest sets.)

It makes a difference with low baudrates (TBH I only tested
what the firmwares I have use: 9600-8N1). No clue why (from
design PoV) but some odd fw use the time spent to display
chars to have a nicer 'user experience' (using polling).
With incorrect timing everything is displayed at once partly
scrambled.

The following devices are modeled with timers limiting the
transmit rate:

$ git grep qemu_clock_get_ns hw/char/
hw/char/cadence_uart.c:269:    uint64_t new_rx_time =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
hw/char/exynos4210_uart.c:393:
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
hw/char/ibex_uart.c:155:    uint64_t current_time =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
hw/char/renesas_sci.c:74:    if (sci->rx_next >
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
hw/char/renesas_sci.c:84:    sci->rx_next =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime;
hw/char/serial.c:290:    s->last_xmit_ts =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
hw/char/serial.c:899:    s->last_xmit_ts =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
hw/char/sh_serial.c:352:
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 15 * s->etu);

> 
> thanks
> -- PMM
> 

