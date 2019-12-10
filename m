Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66868C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECAE20637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THJR6EYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECAE20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iekzv-0005fV-BV
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iekyL-0004VN-45
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iekyI-0007uj-PB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:15:00 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:40512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iekyI-0007uE-I6; Tue, 10 Dec 2019 14:14:58 -0500
Received: by mail-il1-x143.google.com with SMTP id b15so17132461ila.7;
 Tue, 10 Dec 2019 11:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=alOcQcgvp6XCV+enV3qG3D/mHnMQSHhndppzu+ZmGrM=;
 b=THJR6EYuFy2c4ffOJwBwV2tVu7xDWwN+anvQQK9k3M2/FJEUncl50RXrUcdIdNqPez
 +HU/QO0vem93nw8qdJaPXnhU/VweuNwD+uk5WLq+r9IKBzxN2zBjPR6lSRhSSrqhGSmj
 LhBLPOIhkMhc9VX5Hdx078QKKYdAAhQfRKrLhDpyYCXDXdH7Jce7ECcmf0T/Junj7IfP
 mmOCXfjn+lYE4q8nKrnldPGoCOBW1mCkZPvnIkK/mnfaM1HZYrgIfIADCauHxo7iNPAT
 Chr5P3U9io3+7t1ZeCsEybz4mXcKB3vsR4Tk3fbAV7YKP7YLBT/+ZJ9cUMfxxKziU3k/
 fmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=alOcQcgvp6XCV+enV3qG3D/mHnMQSHhndppzu+ZmGrM=;
 b=d8Jmfp6cODObyXtY9K1KQ/TuO9W62pI6mOEzGOe8Hfwr6/IoIZebTW3kWWod9OKG8y
 FdVnxVrSya3co0vYy2wOkmnC2JQA9rLSeUI/7j6OdQVZ3QvjSPpIaqN0JQvJ3imvzXe0
 L5uYqRSqxgSZ6P/lII1Sha6m8tC06bqUYf8hB1LrvCyorHQK1pbKZmkYU4T82p0Yo8UE
 AC1OxNmVU1VTYvDwvQOvtvVX26RWQhhlbzT5n8h+SsEi/tvRTbB1MHnxcCNOF+lXxCN/
 +2uuQMWZeQskBAnltVFhBv9DSLhzt22MY6yB37daILe6nIC1B1yQu1yYO3lpbFdWD3UE
 /LcQ==
X-Gm-Message-State: APjAAAUzovezeHwCXfhWSBoeEj4M9X5dWoUqEk/CgOpVBYc/4CnbKBI4
 ULcp10vGEkvZGjMrI+PEaTeu6VhWFvigDBdrHh0=
X-Google-Smtp-Source: APXvYqzzy5UFNF3Yf3fNPlPr19aedwr9sNHhvCo1u1K6NZSCjdCr3w/j8e7uLYy2nzHwmQMpJvqGNEWfL/egz8IeIyY=
X-Received: by 2002:a92:5a45:: with SMTP id o66mr33950807ilb.67.1576005297574; 
 Tue, 10 Dec 2019 11:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-3-nieklinnenbank@gmail.com>
 <b14e5a75-ebe3-311e-60a8-3f71b0874a10@redhat.com>
 <CAPan3WohBP_47h1ZPP12ZuyiY43B3B6tGFMH-sK=LAAjMbwpaA@mail.gmail.com>
 <ce2125dd-004c-a5a2-81cf-b8aaae76444e@redhat.com>
 <CAPan3WrN28W-h9RYA88LbA8eWP6Me9VcNisnZhwNgC2WOgVLxg@mail.gmail.com>
 <f5983dbb-28f6-206f-a180-83633a049325@redhat.com>
In-Reply-To: <f5983dbb-28f6-206f-a180-83633a049325@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Dec 2019 20:14:46 +0100
Message-ID: <CAPan3Wru7AnjmeB5DWwgD0sDA2L1emZdMJLD2-d1g0cQH5fEOA@mail.gmail.com>
Subject: Re: [PATCH 02/10] hw: arm: add Xunlong Orange Pi PC machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ed1a5205995e531e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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

--000000000000ed1a5205995e531e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Tue, Dec 10, 2019 at 9:59 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 12/6/19 11:15 PM, Niek Linnenbank wrote:
> [...]
> >      >      > +static void orangepi_machine_init(MachineClass *mc)
> >      >      > +{
> >      >      > +    mc->desc =3D "Orange Pi PC";
> >      >      > +    mc->init =3D orangepi_init;
> >      >      > +    mc->units_per_default_bus =3D 1;
> >      >      > +    mc->min_cpus =3D AW_H3_NUM_CPUS;
> >      >      > +    mc->max_cpus =3D AW_H3_NUM_CPUS;
> >      >      > +    mc->default_cpus =3D AW_H3_NUM_CPUS;
> >      >
> >      >              mc->default_cpu_type =3D
> ARM_CPU_TYPE_NAME("cortex-a7");
> >      >
> >      >      > +    mc->ignore_memory_transaction_failures =3D true;
> >      >
> >      >     You should not use this flag in new design. See the
> >     documentation in
> >      >     include/hw/boards.h:
> >      >
> >      >        * @ignore_memory_transaction_failures:
> >      >        *    [...] New board models
> >      >        *    should instead use "unimplemented-device" for all
> memory
> >      >     ranges where
> >      >        *    the guest will attempt to probe for a device that
> >     QEMU doesn't
> >      >        *    implement and a stub device is required.
> >      >
> >      >     You already use the "unimplemented-device".
> >      >
> >      > Thanks, I'm working on this now. I think that at least I'll need
> >     to add
> >      > all of the devices mentioned in the 4.1 Memory Mapping chapter o=
f
> >     the
> >      > datasheet
> >      > as an unimplemented device. Previously I only added some that I
> >     thought
> >      > were relevant.
> >      >
> >      > I added all the missing devices as unimplemented and removed the
> >      > ignore_memory_transaction_failures flag
> >
> >     I was going to say, "instead of adding *all* the devices regions yo=
u
> >     can
> >     add the likely bus decoding regions", probably:
> >
> >     0x01c0.0000   128KiB   AMBA AXI
> >     0x01c2.0000   64KiB    AMBA APB
> >
> >     But too late.
> >
> >
> > Hehe its okey, I can change it to whichever is preferable: the minimum
> set
> > with unimplemented device entries to get a working linux kernel / u-boo=
t
> or
> > just cover the full memory space from the datasheet. My initial thought
> > was that if
> > we only provide the minimum set, and the linux kernel later adds a new
> > driver for a device
> > which is not marked unimplemented, it will trigger the data abort and
> > potentially resulting in a non-booting kernel.
> >
> > But I'm not sure what is normally done here. I do see other board files
> > using the create_unimplemented_device() function,
> > but I dont know if they are covering the whole memory space or not.
>
> If they don't cover all memory regions, the guest code can trigger a
> data abort indeed. Since we don't know the memory layout of old board,
> they are still supported with ignore_memory_transaction_failures=3Dtrue,
> so guest still run unaffected.
> We expect new boards to implement the minimum layout.
> As long as your guest is happy and usable, UNIMP devices are fine,
> either as big region or individual device (this requires someone with
> access to the datasheet to verify). If you can add a UNIMP for each
> device - which is what you did - it is even better because the the unimp
> access log will be more useful, having finer granularity.
>
>  > I added all the missing devices as unimplemented and removed the
>  > ignore_memory_transaction_failures flag
>
> IOW, you already did the best you could do :)
>
> >      > from the machine. Now it seems Linux gets a data abort while
> >     probing the
> >      > uart1 serial device at 0x01c28400,
> >
> >     Did you add the UART1 as UNIMP or 16550?
> >
> >
> > I discovered what goes wrong here. See this kernel oops message:
> >
> > [    1.084985] [f08600f8] *pgd=3D6f00a811, *pte=3D01c28653, *ppte=3D01c=
28453
> > [    1.085564] Internal error: : 8 [#1] SMP ARM
> > [    1.085698] Modules linked in:
> > [    1.085940] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 5.4.0-11747-g2f13437b8917 #4
> > [    1.085968] Hardware name: Allwinner sun8i Family
> > [    1.086447] PC is at dw8250_setup_port+0x10/0x10c
> > [    1.086478] LR is at dw8250_probe+0x500/0x56c
> >
> > It tries to access the UART0 at base address 0x01c28400, which I did
> > provide. The strange
> > thing is that is accesses offset 0xf8, thus address 0x01c284f8. The
> > datasheet does not mention this register
> > but if we provide the 1KiB (0x400) I/O space it should at least read as
> > zero and writes ignored. Unfortunately the emulated
> > serial driver only maps a small portion until 0x1f:
> >
> > (qemu) info mtree
> > ...
> >      0000000001c28000-0000000001c2801f (prio 0, i/o): serial
> >      0000000001c28400-0000000001c2841f (prio 0, i/o): serial
> >      0000000001c28800-0000000001c2881f (prio 0, i/o): serial
> >
> >
> > Apparently, the register that the mainline linux kernel is using is
> > DesignWare specific:
> >
> > drivers/tty/serial/8250/8250_dwlib.c:13:
> >
> > /* Offsets for the DesignWare specific registers */
> > #define DW_UART_DLF<--->0xc0 /* Divisor Latch Fraction Register */
> > #define DW_UART_CPR<--->0xf4 /* Component Parameter Register */
> > #define DW_UART_UCV<--->0xf8 /* UART Component Version */
> >
> > I tried to find a way to increase the memory mapped size of the serial
> > device I created with serial_mm_init(),
> > but I don't think its possible with that interface.
> >
> > I did manage to get it working by overlaying the UART0 with another
> > unimplemented device
> > that does have an I/O size of 0x400, but I guess that is probably not
> > the solution we are looking for?
>
> IMHO this is the correct solution :)
>
> Memory regions have priority. By default a device has priority 0, and
> UNIMP device has priority -1000.
>
> So you can use:
>
>     serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
>                    s->irq[AW_H3_GIC_SPI_UART0], 115200,
>                    serial_hd(0), DEVICE_NATIVE_ENDIAN);
>     create_unimplemented_device("DesignWare-uart",\
>                                 AW_H3_UART0_REG_BASE,
>                                 0x400);
>
>
Now it makes much more sense to me, thanks a lot for explaining this!

Allright, I'll use this approach to finish the work for removing
mc->ignore_memory_transaction_failures.

Regards,
Niek


> (Or cleaner, add a create_designware_uart(...) function that does both).
>
> (qemu) info mtree
> ...
>     0000000001c28000-0000000001c2801f (prio 0, i/o): serial
>     0000000001c28000-0000000001c283ff (prio -1000, i/o): DesignWare-uart
>
> You could create an UNIMP region of 0x400 - 0x20 =3D 0x3e0, but that woul=
d
> appear this is a different device, so I don't recommend that.
>
>  > I wonder, did any of the other SoC / boards have this problem when
>  > removing mc->ignore_memory_transaction_failures?
>
>

--=20
Niek Linnenbank

--000000000000ed1a5205995e531e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 10, 2019 at 9:59 AM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 12/6/19 11:15 PM, Niek Linnenbank wrote:<br>
[...]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void orangep=
i_machine_init(MachineClass *mc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&g=
t;desc =3D &quot;Orange Pi PC&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&g=
t;init =3D orangepi_init;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&g=
t;units_per_default_bus =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&g=
t;min_cpus =3D AW_H3_NUM_CPUS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&g=
t;max_cpus =3D AW_H3_NUM_CPUS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&g=
t;default_cpus =3D AW_H3_NUM_CPUS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mc-&gt;default_cpu_type =3D ARM_CPU_TYPE_NAME(&quot;cortex-a7&quot;);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&g=
t;ignore_memory_transaction_failures =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0You should not use this fl=
ag in new design. See the<br>
&gt;=C2=A0 =C2=A0 =C2=A0documentation in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0include/hw/boards.h:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @ignore_memory_t=
ransaction_failures:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 [..=
.] New board models<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 sho=
uld instead use &quot;unimplemented-device&quot; for all memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0ranges where<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 the=
 guest will attempt to probe for a device that<br>
&gt;=C2=A0 =C2=A0 =C2=A0QEMU doesn&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 imp=
lement and a stub device is required.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0You already use the &quot;=
unimplemented-device&quot;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Thanks, I&#39;m working on this now. I think =
that at least I&#39;ll need<br>
&gt;=C2=A0 =C2=A0 =C2=A0to add<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; all of the devices mentioned in the 4.1 Memor=
y Mapping chapter of<br>
&gt;=C2=A0 =C2=A0 =C2=A0the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; datasheet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; as an unimplemented device. Previously I only=
 added some that I<br>
&gt;=C2=A0 =C2=A0 =C2=A0thought<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; were relevant.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I added all the missing devices as unimplemen=
ted and removed the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ignore_memory_transaction_failures flag<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I was going to say, &quot;instead of adding *all* t=
he devices regions you<br>
&gt;=C2=A0 =C2=A0 =C2=A0can<br>
&gt;=C2=A0 =C2=A0 =C2=A0add the likely bus decoding regions&quot;, probably=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A00x01c0.0000=C2=A0 =C2=A0128KiB=C2=A0 =C2=A0AMBA AXI=
<br>
&gt;=C2=A0 =C2=A0 =C2=A00x01c2.0000=C2=A0 =C2=A064KiB=C2=A0 =C2=A0 AMBA APB=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0But too late.<br>
&gt; <br>
&gt; <br>
&gt; Hehe its okey, I can change it to whichever is preferable: the minimum=
 set<br>
&gt; with unimplemented device entries to get a working linux kernel / u-bo=
ot or<br>
&gt; just cover the full memory space from the datasheet. My initial though=
t <br>
&gt; was that if<br>
&gt; we only provide the minimum set, and the linux kernel later adds a new=
 <br>
&gt; driver for a device<br>
&gt; which is not marked unimplemented, it will trigger the data abort and =
<br>
&gt; potentially resulting in a non-booting kernel.<br>
&gt; <br>
&gt; But I&#39;m not sure what is normally done here. I do see other board =
files <br>
&gt; using the create_unimplemented_device() function,<br>
&gt; but I dont know if they are covering the whole memory space or not.<br=
>
<br>
If they don&#39;t cover all memory regions, the guest code can trigger a <b=
r>
data abort indeed. Since we don&#39;t know the memory layout of old board, =
<br>
they are still supported with ignore_memory_transaction_failures=3Dtrue, <b=
r>
so guest still run unaffected.<br>
We expect new boards to implement the minimum layout.<br>
As long as your guest is happy and usable, UNIMP devices are fine, <br>
either as big region or individual device (this requires someone with <br>
access to the datasheet to verify). If you can add a UNIMP for each <br>
device - which is what you did - it is even better because the the unimp <b=
r>
access log will be more useful, having finer granularity.<br>
<br>
=C2=A0&gt; I added all the missing devices as unimplemented and removed the=
<br>
=C2=A0&gt; ignore_memory_transaction_failures flag<br>
<br>
IOW, you already did the best you could do :)<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; from the machine. Now it seems Linux gets a d=
ata abort while<br>
&gt;=C2=A0 =C2=A0 =C2=A0probing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; uart1 serial device at 0x01c28400,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Did you add the UART1 as UNIMP or 16550?<br>
&gt; <br>
&gt; <br>
&gt; I discovered what goes wrong here. See this kernel oops message:<br>
&gt; <br>
&gt; [=C2=A0 =C2=A0 1.084985] [f08600f8] *pgd=3D6f00a811, *pte=3D01c28653, =
*ppte=3D01c28453<br>
&gt; [=C2=A0 =C2=A0 1.085564] Internal error: : 8 [#1] SMP ARM<br>
&gt; [=C2=A0 =C2=A0 1.085698] Modules linked in:<br>
&gt; [=C2=A0 =C2=A0 1.085940] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4=
.0-11747-g2f13437b8917 #4<br>
&gt; [=C2=A0 =C2=A0 1.085968] Hardware name: Allwinner sun8i Family<br>
&gt; [=C2=A0 =C2=A0 1.086447] PC is at dw8250_setup_port+0x10/0x10c<br>
&gt; [=C2=A0 =C2=A0 1.086478] LR is at dw8250_probe+0x500/0x56c<br>
&gt; <br>
&gt; It tries to access the UART0 at base address 0x01c28400, which I did <=
br>
&gt; provide. The strange<br>
&gt; thing is that is accesses offset 0xf8, thus address 0x01c284f8. The <b=
r>
&gt; datasheet does not mention this register<br>
&gt; but if we provide the 1KiB (0x400) I/O space it should at least read a=
s <br>
&gt; zero and writes ignored. Unfortunately the emulated<br>
&gt; serial driver only maps a small portion until 0x1f:<br>
&gt; <br>
&gt; (qemu) info mtree<br>
&gt; ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 0000000001c28000-0000000001c2801f (prio 0, i/o): s=
erial<br>
&gt;=C2=A0 =C2=A0 =C2=A0 0000000001c28400-0000000001c2841f (prio 0, i/o): s=
erial<br>
&gt;=C2=A0 =C2=A0 =C2=A0 0000000001c28800-0000000001c2881f (prio 0, i/o): s=
erial<br>
&gt; <br>
&gt; <br>
&gt; Apparently, the register that the mainline linux kernel is using is <b=
r>
&gt; DesignWare specific:<br>
&gt; <br>
&gt; drivers/tty/serial/8250/8250_dwlib.c:13:<br>
&gt; <br>
&gt; /* Offsets for the DesignWare specific registers */<br>
&gt; #define DW_UART_DLF&lt;---&gt;0xc0 /* Divisor Latch Fraction Register =
*/<br>
&gt; #define DW_UART_CPR&lt;---&gt;0xf4 /* Component Parameter Register */<=
br>
&gt; #define DW_UART_UCV&lt;---&gt;0xf8 /* UART Component Version */<br>
&gt; <br>
&gt; I tried to find a way to increase the memory mapped size of the serial=
 <br>
&gt; device I created with serial_mm_init(),<br>
&gt; but I don&#39;t think its possible with that interface.<br>
&gt; <br>
&gt; I did manage to get it working by overlaying the UART0 with another <b=
r>
&gt; unimplemented device<br>
&gt; that does have an I/O size of 0x400, but I guess that is probably not =
<br>
&gt; the solution we are looking for?<br>
<br>
IMHO this is the correct solution :)<br>
<br>
Memory regions have priority. By default a device has priority 0, and <br>
UNIMP device has priority -1000.<br>
<br>
So you can use:<br>
<br>
=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;=
irq[AW_H3_GIC_SPI_UART0], 115200,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial=
_hd(0), DEVICE_NATIVE_ENDIAN);<br>
=C2=A0 =C2=A0 create_unimplemented_device(&quot;DesignWare-uart&quot;,\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AW_H3_UART0_REG_BASE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x400);<br>
<br></blockquote><div><br></div><div>Now it makes much more sense to me, th=
anks a lot for explaining this!</div><div><br></div><div>Allright, I&#39;ll=
 use this approach to finish the work for removing mc-&gt;ignore_memory_tra=
nsaction_failures.<br></div><div><br></div><div>Regards,</div><div>Niek<br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
(Or cleaner, add a create_designware_uart(...) function that does both).<br=
>
<br>
(qemu) info mtree<br>
...<br>
=C2=A0 =C2=A0 0000000001c28000-0000000001c2801f (prio 0, i/o): serial<br>
=C2=A0 =C2=A0 0000000001c28000-0000000001c283ff (prio -1000, i/o): DesignWa=
re-uart<br>
<br>
You could create an UNIMP region of 0x400 - 0x20 =3D 0x3e0, but that would =
<br>
appear this is a different device, so I don&#39;t recommend that.<br>
<br>
=C2=A0&gt; I wonder, did any of the other SoC / boards have this problem wh=
en<br>
=C2=A0&gt; removing mc-&gt;ignore_memory_transaction_failures?<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000ed1a5205995e531e--

