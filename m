Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D558C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 01:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70AF2074A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 01:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="Uvj3Q7WV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70AF2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kENJr-0006QY-Ov
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 21:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1kENIt-0005zY-GS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 21:47:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:44498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1kENIr-0003X8-6I
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 21:47:42 -0400
Received: by mail-pl1-x62c.google.com with SMTP id q3so1929676pls.11
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=jvDocS5zJ6q2HxTzrn3Nroc/kAWwb9Q/o1z6W8B63us=;
 b=Uvj3Q7WVpRrh9ahAxB9l9L3WW46Q7I6plcSavgo8CLWbhq4uh8yg97r5Nc8XKYboIC
 R+IlO9uOPCnMi2GEAX8lZU9ErB9VjXtLAYPg/T/FYOA+H7uFag8Dtz7QfEGd4QFihrr8
 jScr0RdaT3N/OZ3rpD9bSjXMd3mZ/k7gJfrxHl+K69qfec643pq56UlGMJyzy5OyjdOp
 PRaz8kh/mGSvfV+t+bbtBTrZ800bHlk1dU+qaXcUa0pZsgS5nYJidhEn8xONTrQuZNZe
 Cm/LGXxZ676QS2TRyInKfHnhyn0cd97MuHz88THlLMNyINTx1z8ZUCuF8K62luGOZOz+
 VIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=jvDocS5zJ6q2HxTzrn3Nroc/kAWwb9Q/o1z6W8B63us=;
 b=E7CVA6EQPTC+LkpO0SiOXmlulcVo0enK08KriR22xN9bHEmOyHCIcX6UhDIC14rfTn
 CUqVB9dWXMa2+H8ppPpEq6S+AW32zo7yZt3qi8RGl2ohBaBNV6HThw5b91wjZqfpBsLb
 Bg7xHCbJBaO1w3repXdVLOswi2zE3kkeXk3HWDipy+mRgpuHfuXBYNlZ3ACdPxp2imqr
 LJH8WYxnrqMt9BSCY4qKSZ++ruZPdVqU619wAyUAQAoA05NL74somSWD4fhkznmMcexI
 fFa2fEjjvvu641TBs/A05JHTkHgGQzyERje7yoVkRc2s8Z3bGeH5J1ZdTbEAAz5zoH1z
 Cudg==
X-Gm-Message-State: AOAM532XC2GFekWwX0ayHuBZK4+DIbh2FrS6RN4054UGzyae0uoVZedH
 tnrq8UwPqIyv48tHAiwMF7pEYg==
X-Google-Smtp-Source: ABdhPJwl8x2zcFD9JC7GLvM5vmElTCTIwf8QAkcG4Iw7jasYx3UTDM0NGqd5VGkNlCGXlXPZJyfuvw==
X-Received: by 2002:a17:902:266:: with SMTP id
 93mr11046536plc.108.1599270458194; 
 Fri, 04 Sep 2020 18:47:38 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id t63sm6447636pgt.50.2020.09.04.18.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 18:47:37 -0700 (PDT)
Date: Fri, 04 Sep 2020 18:47:37 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Sep 2020 18:47:33 PDT (-0700)
Subject: Re: hw/clock: What clock rate for virt machines?
In-Reply-To: <CAKmqyKOft-F8psJ-rO65-CEjJ+s9yXG9BzSa4_cz8KfRM3FRKQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alistair23@gmail.com
Message-ID: <mhng-87708fe4-16e9-46b7-86da-89da1b77aff0@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=palmer@dabbelt.com; helo=mail-pl1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 mst@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org,
 Alistair Francis <Alistair.Francis@wdc.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 04 Sep 2020 10:52:06 PDT (-0700), alistair23@gmail.com wrote:
> On Wed, Sep 2, 2020 at 12:48 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 9/2/20 8:18 PM, Peter Maydell wrote:
>> > On Wed, 2 Sep 2020 at 18:03, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> >>
>> >> On 9/2/20 6:49 PM, Peter Maydell wrote:
>> >>> On Wed, 2 Sep 2020 at 17:35, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> >>>> Peter said "'clock' is basically meaningless for virt machines",
>> >>>>
>> >>>> I understand and agree. But how to make that explicit/obvious in
>> >>>> the code, when a device expects a clock frequency/period?
>> >>>
>> >>> When a particular *device* needs a clock, then presumably
>> >>> it has a defined purpose for it, and we can pick a
>> >>> frequency for it then.
>> >>>
>> >>>> See for example hw/riscv/virt.c, it uses the following (confusing
>> >>>> to me) in virt_machine_init():
>> >>>>
>> >>>>    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
>> >>>>        0, qdev_get_gpio_in(DEVICE(mmio_plic), UART0_IRQ), 399193,
>> >>>>        serial_hd(0), DEVICE_LITTLE_ENDIAN);
>> >>>
>> >>> In this case, the board has a model of a 16550A UART on it,
>> >>> which uses its input clock to determine what the actual baud
>> >>> rate is for particular guest settings of the divisor registers.
>> >>> So we need to look at:
>> >>>  * what does guest software expect the frequency to be?
>> >>
>> >> QEMU is supposed to model machine with no knowledge of the guest,
>> >> but the virt case is a particular one indeed... as it has to know
>> >> it is virtualized.
>> >>
>> >>>  * what is a "good" frequency which gives the guest the best
>> >>>    possible choices of baud rate?
>> >>
>> >> I'll think about it...
>> >
>> > My guess is that guest code assumes "same frequency an
>> > x86 PC uses", but a risc-v person might know better...
>> >
>> > (For QEMU I think it only makes a visible difference when
>> > you pass a host serial port through to the guest as
>> > otherwise we ignore whatever baud rate the guest sets.)
>
> I think that's the case. I suspect we just ignore whatever the guest
> sets. I have never really looked into it though.

IIRC that's essentially what we do for all the clock stuff in QEMU.  Sometimes
we fake things a bit better by doing something like always instantly setting
the "clock has locked" bit pattern or snaping multipliers to something close to
viable, but I don't think it gets a whole lot better than that.

>> It makes a difference with low baudrates (TBH I only tested
>> what the firmwares I have use: 9600-8N1). No clue why (from
>> design PoV) but some odd fw use the time spent to display
>> chars to have a nicer 'user experience' (using polling).
>> With incorrect timing everything is displayed at once partly
>> scrambled.
>>
>> The following devices are modeled with timers limiting the
>> transmit rate:
>>
>> $ git grep qemu_clock_get_ns hw/char/
>> hw/char/cadence_uart.c:269:    uint64_t new_rx_time =
>> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> hw/char/exynos4210_uart.c:393:
>> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
>> hw/char/ibex_uart.c:155:    uint64_t current_time =
>> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>
> For the Ibex UART we want  to apply back pressure on the guest (as
> that's what the main OT software expects) which is why we use this. I
> think most other guest software doesn't care as much.

I'd bet a bunch of embedded software blows up when the UART suddenly becomes
very fast, whether it just exposes some bug or because the programmer knows
that's how the system behaves and the software is just taking advantage of it.
While I guess we can fix what we run in to I fell like this is going to be a
losing battle in QEMU -- I guess it's an extreme case, but imagine trying to
emulate the behavior of our DDR controller (right now we just treat all the
control registers as opaque memory, they're far from that).

> Alistair
>
>> hw/char/renesas_sci.c:74:    if (sci->rx_next >
>> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
>> hw/char/renesas_sci.c:84:    sci->rx_next =
>> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime;
>> hw/char/serial.c:290:    s->last_xmit_ts =
>> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> hw/char/serial.c:899:    s->last_xmit_ts =
>> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> hw/char/sh_serial.c:352:
>> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 15 * s->etu);
>>
>> >
>> > thanks
>> > -- PMM
>> >
>>

