Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02BCC38151
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8CD25272
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrZ1qeTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8CD25272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEG47-0003Kr-Co
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 14:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEG3D-0002QG-UE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 14:03:03 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b]:38756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEG3C-0001Oh-7J
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 14:03:03 -0400
Received: by mail-il1-x12b.google.com with SMTP id w3so7133643ilh.5
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wODF9eKvbIQ2ZCV+3tzpm1GsE56FsFyCpeSPorBvJCY=;
 b=HrZ1qeTx83mmuuDmctN6LNlFxtmt1q33NmpgQQp0dZnmrzaT5V5/ymdBVvGwnBc9Wi
 WtynVaNfY+WpVp9YpTCJU65SrPSbn9U0B3PTYHMt1LvSMBkVC4EBAtaaPuXYq0E6oCtf
 677+JK+fshr8yR/1r4ujN4sx+ST18S0jzHoVtkUkJ64/1gOzrcfj9TwGm/5+Ga4AHdUU
 PfnD0opr8EIHkvQkLIsD9gotCRwEE4W+oKD2hkTvz2q5kYT6lxz3cpebrpeDyZ/H7RI9
 fOeoSdrFpE9BQ7lC8qLHMC8ptZTefHzwS+JBO+LE+0N+Zpd+MIx1IZ8LyLM/DXQUJwnw
 ihPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wODF9eKvbIQ2ZCV+3tzpm1GsE56FsFyCpeSPorBvJCY=;
 b=L0fMqxAwA65nIneZukNLa2px22Tag+KUgoUk4bo9VRDBY0MnmIjryBLYCX+LA4r67p
 LtTjc/Uf9Rx1UaMvpSELjsLYoIqiP6Ck9lqXeT3AMR0qD6N8KFv2zufELLMOZYJIvrLe
 eGuYs0S9pdRsY7Cx9PDmQGb2ckT8MrIhgQBkplxOsNiTFi/Qys2yCUe7Hm+iskDtVfmQ
 dFS3tmi1khm/MrkqnRlI0tJ8J1fWEkcZSip3ATn7XGkSrac/iNut8rOxP/wqJLSXMg2C
 /2F/J/LzFAm7SBOl4xV/ncV0WhoF+BEpnDTk0XKlQDXhB5IEvBXWZB4UXVRHQXrRkPKN
 I9TQ==
X-Gm-Message-State: AOAM532mK7azMoqlXWSKcPjX3LTQEEqClCg8Eajm6+aTlYAUWDd8Jb+B
 +wsvA3rpl93tPL3ZikZaF+ZeV8JX4u5Ft7L0I8c=
X-Google-Smtp-Source: ABdhPJyiZjZXFoT25u3p+cUcHS9cH3gJeBzOqJ9CYFj9Z8v/4jdjxCC3I6yX92iwWKwibIyVs4Fvu2/tDHxjQz3ehA0=
X-Received: by 2002:a05:6e02:ca3:: with SMTP id
 3mr9503747ilg.227.1599242581150; 
 Fri, 04 Sep 2020 11:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <bbdacc80-a321-5f06-e430-973a38e7e037@amsat.org>
 <CAFEAcA8mwjWP-KhJ5bp_Qo_h81Mt_yn8k_5oepgMas9COBQgWQ@mail.gmail.com>
 <f7b28480-c841-f0d7-a848-b5f1775ec12d@amsat.org>
 <CAFEAcA-3bkPkxuMXN7Wd-zBKajzXOr+Vib7XzCzsT_8YYQzTzQ@mail.gmail.com>
 <78ed6915-e941-247f-7333-8944249a10ed@amsat.org>
In-Reply-To: <78ed6915-e941-247f-7333-8944249a10ed@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 10:52:06 -0700
Message-ID: <CAKmqyKOft-F8psJ-rO65-CEjJ+s9yXG9BzSa4_cz8KfRM3FRKQ@mail.gmail.com>
Subject: Re: hw/clock: What clock rate for virt machines?
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x12b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 2, 2020 at 12:48 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 9/2/20 8:18 PM, Peter Maydell wrote:
> > On Wed, 2 Sep 2020 at 18:03, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> >>
> >> On 9/2/20 6:49 PM, Peter Maydell wrote:
> >>> On Wed, 2 Sep 2020 at 17:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
> >>>> Peter said "'clock' is basically meaningless for virt machines",
> >>>>
> >>>> I understand and agree. But how to make that explicit/obvious in
> >>>> the code, when a device expects a clock frequency/period?
> >>>
> >>> When a particular *device* needs a clock, then presumably
> >>> it has a defined purpose for it, and we can pick a
> >>> frequency for it then.
> >>>
> >>>> See for example hw/riscv/virt.c, it uses the following (confusing
> >>>> to me) in virt_machine_init():
> >>>>
> >>>>    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> >>>>        0, qdev_get_gpio_in(DEVICE(mmio_plic), UART0_IRQ), 399193,
> >>>>        serial_hd(0), DEVICE_LITTLE_ENDIAN);
> >>>
> >>> In this case, the board has a model of a 16550A UART on it,
> >>> which uses its input clock to determine what the actual baud
> >>> rate is for particular guest settings of the divisor registers.
> >>> So we need to look at:
> >>>  * what does guest software expect the frequency to be?
> >>
> >> QEMU is supposed to model machine with no knowledge of the guest,
> >> but the virt case is a particular one indeed... as it has to know
> >> it is virtualized.
> >>
> >>>  * what is a "good" frequency which gives the guest the best
> >>>    possible choices of baud rate?
> >>
> >> I'll think about it...
> >
> > My guess is that guest code assumes "same frequency an
> > x86 PC uses", but a risc-v person might know better...
> >
> > (For QEMU I think it only makes a visible difference when
> > you pass a host serial port through to the guest as
> > otherwise we ignore whatever baud rate the guest sets.)

I think that's the case. I suspect we just ignore whatever the guest
sets. I have never really looked into it though.

>
> It makes a difference with low baudrates (TBH I only tested
> what the firmwares I have use: 9600-8N1). No clue why (from
> design PoV) but some odd fw use the time spent to display
> chars to have a nicer 'user experience' (using polling).
> With incorrect timing everything is displayed at once partly
> scrambled.
>
> The following devices are modeled with timers limiting the
> transmit rate:
>
> $ git grep qemu_clock_get_ns hw/char/
> hw/char/cadence_uart.c:269:    uint64_t new_rx_time =3D
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> hw/char/exynos4210_uart.c:393:
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
> hw/char/ibex_uart.c:155:    uint64_t current_time =3D
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);

For the Ibex UART we want  to apply back pressure on the guest (as
that's what the main OT software expects) which is why we use this. I
think most other guest software doesn't care as much.

Alistair

> hw/char/renesas_sci.c:74:    if (sci->rx_next >
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
> hw/char/renesas_sci.c:84:    sci->rx_next =3D
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime;
> hw/char/serial.c:290:    s->last_xmit_ts =3D
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> hw/char/serial.c:899:    s->last_xmit_ts =3D
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> hw/char/sh_serial.c:352:
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 15 * s->etu);
>
> >
> > thanks
> > -- PMM
> >
>

