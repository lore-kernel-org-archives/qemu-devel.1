Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F993C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E35B20663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c90wHdvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E35B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iebNZ-0007k8-BV
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 04:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iebMp-0007EY-2f
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iebMl-0007W5-Si
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:59:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iebMl-0007Vf-F2
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575968374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e2QHu6Ph865S71htPkT/UUBdpDx/ZkdeiNho1nhET5k=;
 b=c90wHdvNni8NQieT2Rzo3TjO7K2PGH6WZAB/urMRi/iAMxwfXoy8AU2MUkZyRyTvxHpB4E
 AxKa5nGuO7w+FFJymziGMdNGfV1wMvYnUoPO22aG2vP9282iljIH2rUHyrEyP3i1En81f+
 e9mQ1FYXpMUMwSICaFJNaeZhEaw3UPM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-WorKAFZpNn2wd6Hh11TLTQ-1; Tue, 10 Dec 2019 03:59:32 -0500
Received: by mail-wr1-f71.google.com with SMTP id b13so8659908wrx.22
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 00:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HSmushCCXqx0ZjKJFDVYPDB6g4G3DJlEV9vmNcF610I=;
 b=jO1k+65c/6sYVuvcviIXciJZt9SodApld3rd46NpWorZn8uzdolog788PRApCgCmRX
 GUjlbYJV51cbnCUgzFFU7chc19tdDRFC4LLrVGwmqO9M/blDiu+zYxJaBeKwmK/iIcS5
 jP6oX/u9wKj57UU4LB5V+n/hLBbiBBID6EjnRHNZ6IvZXZl6mYnlH05cijOqUq/ywC8j
 4koqqaExpCvt1CqASlz4hroVA+OIzLpJFuE+aGCzfqlkABZosYvLuxBVOxPfBnbKQTRO
 YNxI2sQ/VGppBCR5EfmDzcPHltRWA+irKN3MhLzY8eY/atkyyecHYSxlRAgSaRri/+Ry
 wKaA==
X-Gm-Message-State: APjAAAX2LLVS7HmgdDL/ol9+WZa2YULIRCPwpjaXFkK1+9IwvdDIfaEv
 cyIJRg6pgm7G2wEsqXBQlUs/lVKwDFzyomWPETzz1EGUJyvQjlhPwf7h74cOjR6D/K5djjsJ6BZ
 X+EYtRluM7TVnh90=
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr1992928wrm.80.1575968371158;
 Tue, 10 Dec 2019 00:59:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDNDN37tuvj4QXcluubT00SsQCcncU9/Ovn4d3cYzWU+Ixm5bobvwbaW/cNARBcXaqIhLERg==
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr1992908wrm.80.1575968370881;
 Tue, 10 Dec 2019 00:59:30 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id x132sm2493956wmg.0.2019.12.10.00.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 00:59:30 -0800 (PST)
Subject: Re: [PATCH 02/10] hw: arm: add Xunlong Orange Pi PC machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-3-nieklinnenbank@gmail.com>
 <b14e5a75-ebe3-311e-60a8-3f71b0874a10@redhat.com>
 <CAPan3WohBP_47h1ZPP12ZuyiY43B3B6tGFMH-sK=LAAjMbwpaA@mail.gmail.com>
 <ce2125dd-004c-a5a2-81cf-b8aaae76444e@redhat.com>
 <CAPan3WrN28W-h9RYA88LbA8eWP6Me9VcNisnZhwNgC2WOgVLxg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f5983dbb-28f6-206f-a180-83633a049325@redhat.com>
Date: Tue, 10 Dec 2019 09:59:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3WrN28W-h9RYA88LbA8eWP6Me9VcNisnZhwNgC2WOgVLxg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: WorKAFZpNn2wd6Hh11TLTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 11:15 PM, Niek Linnenbank wrote:
[...]
>      >=C2=A0 =C2=A0 =C2=A0 > +static void orangepi_machine_init(MachineCl=
ass *mc)
>      >=C2=A0 =C2=A0 =C2=A0 > +{
>      >=C2=A0 =C2=A0 =C2=A0 > +=C2=A0 =C2=A0 mc->desc =3D "Orange Pi PC";
>      >=C2=A0 =C2=A0 =C2=A0 > +=C2=A0 =C2=A0 mc->init =3D orangepi_init;
>      >=C2=A0 =C2=A0 =C2=A0 > +=C2=A0 =C2=A0 mc->units_per_default_bus =3D=
 1;
>      >=C2=A0 =C2=A0 =C2=A0 > +=C2=A0 =C2=A0 mc->min_cpus =3D AW_H3_NUM_CP=
US;
>      >=C2=A0 =C2=A0 =C2=A0 > +=C2=A0 =C2=A0 mc->max_cpus =3D AW_H3_NUM_CP=
US;
>      >=C2=A0 =C2=A0 =C2=A0 > +=C2=A0 =C2=A0 mc->default_cpus =3D AW_H3_NU=
M_CPUS;
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mc->default_cpu_ty=
pe =3D ARM_CPU_TYPE_NAME("cortex-a7");
>      >
>      >=C2=A0 =C2=A0 =C2=A0 > +=C2=A0 =C2=A0 mc->ignore_memory_transaction=
_failures =3D true;
>      >
>      >=C2=A0 =C2=A0 =C2=A0You should not use this flag in new design. See=
 the
>     documentation in
>      >=C2=A0 =C2=A0 =C2=A0include/hw/boards.h:
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @ignore_memory_transaction_failures:
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 [...] New board models
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 should instead use "unim=
plemented-device" for all memory
>      >=C2=A0 =C2=A0 =C2=A0ranges where
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 the guest will attempt t=
o probe for a device that
>     QEMU doesn't
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 implement and a stub dev=
ice is required.
>      >
>      >=C2=A0 =C2=A0 =C2=A0You already use the "unimplemented-device".
>      >
>      > Thanks, I'm working on this now. I think that at least I'll need
>     to add
>      > all of the devices mentioned in the 4.1 Memory Mapping chapter of
>     the
>      > datasheet
>      > as an unimplemented device. Previously I only added some that I
>     thought
>      > were relevant.
>      >
>      > I added all the missing devices as unimplemented and removed the
>      > ignore_memory_transaction_failures flag
>=20
>     I was going to say, "instead of adding *all* the devices regions you
>     can
>     add the likely bus decoding regions", probably:
>=20
>     0x01c0.0000=C2=A0 =C2=A0128KiB=C2=A0 =C2=A0AMBA AXI
>     0x01c2.0000=C2=A0 =C2=A064KiB=C2=A0 =C2=A0 AMBA APB
>=20
>     But too late.
>=20
>=20
> Hehe its okey, I can change it to whichever is preferable: the minimum se=
t
> with unimplemented device entries to get a working linux kernel / u-boot =
or
> just cover the full memory space from the datasheet. My initial thought=
=20
> was that if
> we only provide the minimum set, and the linux kernel later adds a new=20
> driver for a device
> which is not marked unimplemented, it will trigger the data abort and=20
> potentially resulting in a non-booting kernel.
>=20
> But I'm not sure what is normally done here. I do see other board files=
=20
> using the create_unimplemented_device() function,
> but I dont know if they are covering the whole memory space or not.

If they don't cover all memory regions, the guest code can trigger a=20
data abort indeed. Since we don't know the memory layout of old board,=20
they are still supported with ignore_memory_transaction_failures=3Dtrue,=20
so guest still run unaffected.
We expect new boards to implement the minimum layout.
As long as your guest is happy and usable, UNIMP devices are fine,=20
either as big region or individual device (this requires someone with=20
access to the datasheet to verify). If you can add a UNIMP for each=20
device - which is what you did - it is even better because the the unimp=20
access log will be more useful, having finer granularity.

 > I added all the missing devices as unimplemented and removed the
 > ignore_memory_transaction_failures flag

IOW, you already did the best you could do :)

>      > from the machine. Now it seems Linux gets a data abort while
>     probing the
>      > uart1 serial device at 0x01c28400,
>=20
>     Did you add the UART1 as UNIMP or 16550?
>=20
>=20
> I discovered what goes wrong here. See this kernel oops message:
>=20
> [    1.084985] [f08600f8] *pgd=3D6f00a811, *pte=3D01c28653, *ppte=3D01c28=
453
> [    1.085564] Internal error: : 8 [#1] SMP ARM
> [    1.085698] Modules linked in:
> [    1.085940] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-11747-g2f1=
3437b8917 #4
> [    1.085968] Hardware name: Allwinner sun8i Family
> [    1.086447] PC is at dw8250_setup_port+0x10/0x10c
> [    1.086478] LR is at dw8250_probe+0x500/0x56c
>=20
> It tries to access the UART0 at base address 0x01c28400, which I did=20
> provide. The strange
> thing is that is accesses offset 0xf8, thus address 0x01c284f8. The=20
> datasheet does not mention this register
> but if we provide the 1KiB (0x400) I/O space it should at least read as=
=20
> zero and writes ignored. Unfortunately the emulated
> serial driver only maps a small portion until 0x1f:
>=20
> (qemu) info mtree
> ...
>      0000000001c28000-0000000001c2801f (prio 0, i/o): serial
>      0000000001c28400-0000000001c2841f (prio 0, i/o): serial
>      0000000001c28800-0000000001c2881f (prio 0, i/o): serial
>=20
>=20
> Apparently, the register that the mainline linux kernel is using is=20
> DesignWare specific:
>=20
> drivers/tty/serial/8250/8250_dwlib.c:13:
>=20
> /* Offsets for the DesignWare specific registers */
> #define DW_UART_DLF<--->0xc0 /* Divisor Latch Fraction Register */
> #define DW_UART_CPR<--->0xf4 /* Component Parameter Register */
> #define DW_UART_UCV<--->0xf8 /* UART Component Version */
>=20
> I tried to find a way to increase the memory mapped size of the serial=20
> device I created with serial_mm_init(),
> but I don't think its possible with that interface.
>=20
> I did manage to get it working by overlaying the UART0 with another=20
> unimplemented device
> that does have an I/O size of 0x400, but I guess that is probably not=20
> the solution we are looking for?

IMHO this is the correct solution :)

Memory regions have priority. By default a device has priority 0, and=20
UNIMP device has priority -1000.

So you can use:

    serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
                   s->irq[AW_H3_GIC_SPI_UART0], 115200,
                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
    create_unimplemented_device("DesignWare-uart",\
                                AW_H3_UART0_REG_BASE,
                                0x400);

(Or cleaner, add a create_designware_uart(...) function that does both).

(qemu) info mtree
...
    0000000001c28000-0000000001c2801f (prio 0, i/o): serial
    0000000001c28000-0000000001c283ff (prio -1000, i/o): DesignWare-uart

You could create an UNIMP region of 0x400 - 0x20 =3D 0x3e0, but that would=
=20
appear this is a different device, so I don't recommend that.

 > I wonder, did any of the other SoC / boards have this problem when
 > removing mc->ignore_memory_transaction_failures?


