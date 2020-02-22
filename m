Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5313DC35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 22:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38F02071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 22:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BItsVZ5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38F02071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5d8v-0002N1-7b
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 17:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j5d85-0001cL-Ur
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 17:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j5d84-00066U-0O
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 17:20:09 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:46169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j5d83-00065y-No; Sat, 22 Feb 2020 17:20:07 -0500
Received: by mail-il1-x144.google.com with SMTP id t17so4643760ilm.13;
 Sat, 22 Feb 2020 14:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wf19ROFw0VvNQCCnFp3H1GGS0f6QDhdMaLKTKF7v1R4=;
 b=BItsVZ5n2XvWfJn7TpWfwfSRqvHqoDQzK4ZCmXCFwYZ0zvLxg1kiAtZK44yWFANU7f
 tuXE1rxMEBNZ9SSPvaOLomS9nYIDaW5TRV9xbc87Nuujclzcrmo6d0lvdJ7oiAaO8LiV
 i3jDIAYDVkmTybhGwvg9so0nRjeOgjmrK1NzyYlWVddKw7vl7vwjUyK8kluqx3wOzt0j
 72oSneWZjU242K4SyyhRmJ/MJmf6bxNJ4UpY/N3G0gmFEUSud10urVoYg26kWDrX84FG
 i0URWAuCok/pAIIUL/MiuqNTyOkHwPnW42lpZN6K5DAaGGP4SylHptYPXTbVfzAhwN6i
 zDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wf19ROFw0VvNQCCnFp3H1GGS0f6QDhdMaLKTKF7v1R4=;
 b=QqV33kFkDCjCCck0YTTFPpl1XdP1ktgJbrBABiM1VTbFt1hBbjsI4qnP3NweJYlVmf
 yz7F76hS0WvcWb7HBVB9vn4rrGVyEmFi6tLTQPvIZ7u6WYQzXgerj8WbDdp2Q3E3IooD
 S0mahDgj/sv60rUsANmguHqBZAO2KPKb3JzHn6sz5FVprJ7h7Mzm93RYnj/iCK70/3EE
 rEoOeesoV+45A2tS3TLz1bWGKMtDgqqLpXlzQP8rh2js9PUEbLdHumAyy5kZNT0465AB
 34AlUmPWXcm+I1im0aTrsvi0cH52uzV8Yj4ewI/ZVKpqhGZ2D5WTmzLnQkecZXxs8Ru4
 UZIg==
X-Gm-Message-State: APjAAAURAOM1hGLD2JcQ7nB/6J81+8b2Op+/18JGH7BV0vHOjVPO0P11
 q2dzAe6x3w5iueEt8q/o06NxGpjtMnphXx/Ok4g=
X-Google-Smtp-Source: APXvYqwYgQtbPiWKP43YXN+q0wsOCSXylW1Q2iCf71Vs2h0zxQjb7/ddRMwPKLwoWd0QDI2BtI/ie29iuwORpKuRk1w=
X-Received: by 2002:a92:81d9:: with SMTP id q86mr45087404ilk.67.1582410006280; 
 Sat, 22 Feb 2020 14:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-13-f4bug@amsat.org>
In-Reply-To: <20200217114533.17779-13-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 22 Feb 2020 23:19:55 +0100
Message-ID: <CAPan3Wr=hxEu_XdKWEYJAZXJY4hHf774O2UfsJd0OmCHc8X0OQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] hw/arm/raspi: Add the Raspberry Pi B+ machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000503eeb059f318a90"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000503eeb059f318a90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Philippe,

Very nice to see that the Raspberry 1 will be supported again, thanks for
contributing this!

I tried to bring up the machine using raspbian 2019-09-26. It ran throught
the early kernel initialisation
but for me it gets stuck at this point:

./arm-softmmu/qemu-system-arm -M raspi1b -kernel
$HOME/raspi/boot/kernel.img -append 'printk.time=3D0
earlycon=3Dpl011,0x20201000 console=3DttyAMA0 rootwait root=3D/dev/mmcblk0p=
2' \
-dtb $HOME/raspi/boot/bcm2708-rpi-b-plus.dtb -m 512 -sd
$HOME/raspi/2019-09-26-raspbian-buster-lite.img -serial stdio -s

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.19.75+ (dom@buildbot) (gcc version 4.9.3
(crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1270 Tue Sep 24 18:38:54
BST 2019
[    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7
(ARMv7), cr=3D00c5387d
[    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
[    0.000000] OF: fdt: Machine model: Raspberry Pi Model B+
[    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] cma: Reserved 8 MiB at 0x1b800000
[    0.000000] random: get_random_bytes called from start_kernel+0x8c/0x49c
with crng_init=3D0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 11368=
0
[    0.000000] Kernel command line: printk.time=3D0 earlycon=3Dpl011,0x2020=
1000
console=3DttyAMA0 rootwait root=3D/dev/mmcblk0p2
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 434380K/458752K available (6973K kernel code, 635K rwdata, 2080K
rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xdc800000 - 0xff800000   ( 560 MB)
    lowmem  : 0xc0000000 - 0xdc000000   ( 448 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0x(ptrval) - 0x(ptrval)   (6975 kB)
      .init : 0x(ptrval) - 0x(ptrval)   ( 464 kB)
      .data : 0x(ptrval) - 0x(ptrval)   ( 636 kB)
       .bss : 0x(ptrval) - 0x(ptrval)   ( 798 kB)
SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
ftrace: allocating 25197 entries in 74 pages
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every
2147483647500ns
clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:
1911260446275 ns
bcm2835: system timer (irq =3D 27)
Console: colour dummy device 80x30

Maybe it should switch to the graphical console here, but I dont see the
boot splash logo either (when using -stdio instead of -nographic).
With -M raspi2 and -dtb bcm2709-rpi-2-b.dtb the same raspbian image can
fully boot to the login console.

Regards,
Niek



On Mon, Feb 17, 2020 at 12:51 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

>   $ qemu-system-arm -M raspi1b -serial stdio \
>       -kernel raspberrypi/firmware/boot/kernel.img \
>       -dtb raspberrypi/firmware/boot/bcm2708-rpi-b.dtb \
>       -append 'printk.time=3D0 earlycon=3Dpl011,0x20201000 console=3DttyA=
MA0'
>   [    0.000000] Booting Linux on physical CPU 0x0
>   [    0.000000] Linux version 4.19.69+ (dom@buildbot) (gcc version 4.9.3
> (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1261 Tue Sep 3 20:21:01
> BST 2019
>   [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7
> (ARMv7), cr=3D00c5387d
>   [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
>   [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B
>   [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
>   [    0.000000] bootconsole [pl11] enabled
>   [    0.000000] Memory policy: Data cache writeback
>   [    0.000000] cma: Reserved 8 MiB at 0x1b800000
>   [    0.000000] random: get_random_bytes called from
> start_kernel+0x8c/0x49c with crng_init=3D0
>   [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
> 113680
>   [    0.000000] Kernel command line: printk.time=3D0
> earlycon=3Dpl011,0x20201000 console=3DttyAMA0
>   Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>   Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>   Memory: 434380K/458752K available (6971K kernel code, 635K rwdata, 2080=
K
> rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)
>   ...
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 3537a329ac..2d9f4e3085 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -324,6 +324,15 @@ static void
> raspi_machine_class_common_init(MachineClass *mc,
>      mc->default_ram_size =3D board_ram_size(board_rev);
>  };
>
> +static void raspi1b_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> +
> +    rmc->board_rev =3D 0x900032;
> +    raspi_machine_class_common_init(mc, rmc->board_rev);
> +};
> +
>  static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -348,6 +357,10 @@ static void raspi3b_machine_class_init(ObjectClass
> *oc, void *data)
>
>  static const TypeInfo raspi_machine_types[] =3D {
>      {
> +        .name           =3D MACHINE_TYPE_NAME("raspi1b"),
> +        .parent         =3D TYPE_RASPI_MACHINE,
> +        .class_init     =3D raspi1b_machine_class_init,
> +    }, {
>          .name           =3D MACHINE_TYPE_NAME("raspi2b"),
>          .parent         =3D TYPE_RASPI_MACHINE,
>          .class_init     =3D raspi2b_machine_class_init,
> --
> 2.21.1
>
>
>

--=20
Niek Linnenbank

--000000000000503eeb059f318a90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey Philippe,</div><div><br></div><div>Very nice to s=
ee that the Raspberry 1 will be supported again, thanks for contributing th=
is!</div><div><br></div><div>I tried to bring up the machine using raspbian=
 2019-09-26. It ran throught the early kernel initialisation</div><div>but =
for me it gets stuck at this point:</div><div><br></div><div>./arm-softmmu/=
qemu-system-arm -M raspi1b -kernel $HOME/raspi/boot/kernel.img -append &#39=
;printk.time=3D0 earlycon=3Dpl011,0x20201000 console=3DttyAMA0 rootwait roo=
t=3D/dev/mmcblk0p2&#39; \</div><div>-dtb $HOME/raspi/boot/bcm2708-rpi-b-plu=
s.dtb -m 512 -sd $HOME/raspi/2019-09-26-raspbian-buster-lite.img -serial st=
dio -s</div><div><br></div><div>[ =C2=A0 =C2=A00.000000] Booting Linux on p=
hysical CPU 0x0<br>[ =C2=A0 =C2=A00.000000] Linux version 4.19.75+ (dom@bui=
ldbot) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #=
1270 Tue Sep 24 18:38:54 BST 2019<br>[ =C2=A0 =C2=A00.000000] CPU: ARMv6-co=
mpatible processor [410fb767] revision 7 (ARMv7), cr=3D00c5387d<br>[ =C2=A0=
 =C2=A00.000000] CPU: VIPT aliasing data cache, unknown instruction cache<b=
r>[ =C2=A0 =C2=A00.000000] OF: fdt: Machine model: Raspberry Pi Model B+<br=
>[ =C2=A0 =C2=A00.000000] earlycon: pl11 at MMIO 0x20201000 (options &#39;&=
#39;)<br>[ =C2=A0 =C2=A00.000000] bootconsole [pl11] enabled<br>[ =C2=A0 =
=C2=A00.000000] Memory policy: Data cache writeback<br>[ =C2=A0 =C2=A00.000=
000] cma: Reserved 8 MiB at 0x1b800000<br>[ =C2=A0 =C2=A00.000000] random: =
get_random_bytes called from start_kernel+0x8c/0x49c with crng_init=3D0<br>=
[ =C2=A0 =C2=A00.000000] Built 1 zonelists, mobility grouping on.=C2=A0 Tot=
al pages: 113680<br>[ =C2=A0 =C2=A00.000000] Kernel command line: printk.ti=
me=3D0 earlycon=3Dpl011,0x20201000 console=3DttyAMA0 rootwait root=3D/dev/m=
mcblk0p2<br>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)=
<br>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<br>Memor=
y: 434380K/458752K available (6973K kernel code, 635K rwdata, 2080K rodata,=
 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)<br>Virtual kerne=
l memory layout:<br>=C2=A0 =C2=A0 vector =C2=A0: 0xffff0000 - 0xffff1000 =
=C2=A0 ( =C2=A0 4 kB)<br>=C2=A0 =C2=A0 fixmap =C2=A0: 0xffc00000 - 0xfff000=
00 =C2=A0 (3072 kB)<br>=C2=A0 =C2=A0 vmalloc : 0xdc800000 - 0xff800000 =C2=
=A0 ( 560 MB)<br>=C2=A0 =C2=A0 lowmem =C2=A0: 0xc0000000 - 0xdc000000 =C2=
=A0 ( 448 MB)<br>=C2=A0 =C2=A0 modules : 0xbf000000 - 0xc0000000 =C2=A0 ( =
=C2=A016 MB)<br>=C2=A0 =C2=A0 =C2=A0 .text : 0x(ptrval) - 0x(ptrval) =C2=A0=
 (6975 kB)<br>=C2=A0 =C2=A0 =C2=A0 .init : 0x(ptrval) - 0x(ptrval) =C2=A0 (=
 464 kB)<br>=C2=A0 =C2=A0 =C2=A0 .data : 0x(ptrval) - 0x(ptrval) =C2=A0 ( 6=
36 kB)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0.bss : 0x(ptrval) - 0x(ptrval) =C2=A0 =
( 798 kB)<br>SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nod=
es=3D1<br>ftrace: allocating 25197 entries in 74 pages<br>NR_IRQS: 16, nr_i=
rqs: 16, preallocated irqs: 16<br>sched_clock: 32 bits at 1000kHz, resoluti=
on 1000ns, wraps every 2147483647500ns<br>clocksource: timer: mask: 0xfffff=
fff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns<br>bcm2835: syste=
m timer (irq =3D 27)<br>Console: colour dummy device 80x30</div><div><br></=
div><div>Maybe it should switch to the graphical console here, but I dont s=
ee the boot splash logo either (when using -stdio instead of -nographic).</=
div><div>With -M raspi2 and -dtb bcm2709-rpi-2-b.dtb the same raspbian imag=
e can fully boot to the login console.<br></div><div><br></div><div>Regards=
,</div><div>Niek<br></div><div><br></div><div><br></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 17, 202=
0 at 12:51 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat=
.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">=C2=A0 $ qemu-system-arm -M raspi1b -serial stdio \<br=
>
=C2=A0 =C2=A0 =C2=A0 -kernel raspberrypi/firmware/boot/kernel.img \<br>
=C2=A0 =C2=A0 =C2=A0 -dtb raspberrypi/firmware/boot/bcm2708-rpi-b.dtb \<br>
=C2=A0 =C2=A0 =C2=A0 -append &#39;printk.time=3D0 earlycon=3Dpl011,0x202010=
00 console=3DttyAMA0&#39;<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] Booting Linux on physical CPU 0x0<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] Linux version 4.19.69+ (dom@buildbot) (gcc =
version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1261 Tue Sep=
 3 20:21:01 BST 2019<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] CPU: ARMv6-compatible processor [410fb767] =
revision 7 (ARMv7), cr=3D00c5387d<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] CPU: VIPT aliasing data cache, unknown inst=
ruction cache<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] OF: fdt: Machine model: Raspberry Pi Model =
B<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] earlycon: pl11 at MMIO 0x20201000 (options =
&#39;&#39;)<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] bootconsole [pl11] enabled<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] Memory policy: Data cache writeback<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] cma: Reserved 8 MiB at 0x1b800000<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] random: get_random_bytes called from start_=
kernel+0x8c/0x49c with crng_init=3D0<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] Built 1 zonelists, mobility grouping on.=C2=
=A0 Total pages: 113680<br>
=C2=A0 [=C2=A0 =C2=A0 0.000000] Kernel command line: printk.time=3D0 earlyc=
on=3Dpl011,0x20201000 console=3DttyAMA0<br>
=C2=A0 Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)<br>
=C2=A0 Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
=C2=A0 Memory: 434380K/458752K available (6971K kernel code, 635K rwdata, 2=
080K rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)<br>
=C2=A0 ...<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0hw/arm/raspi.c | 13 +++++++++++++<br>
=C2=A01 file changed, 13 insertions(+)<br>
<br>
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c<br>
index 3537a329ac..2d9f4e3085 100644<br>
--- a/hw/arm/raspi.c<br>
+++ b/hw/arm/raspi.c<br>
@@ -324,6 +324,15 @@ static void raspi_machine_class_common_init(MachineCla=
ss *mc,<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_ram_size =3D board_ram_size(board_rev);<=
br>
=C2=A0};<br>
<br>
+static void raspi1b_machine_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
+=C2=A0 =C2=A0 RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 rmc-&gt;board_rev =3D 0x900032;<br>
+=C2=A0 =C2=A0 raspi_machine_class_common_init(mc, rmc-&gt;board_rev);<br>
+};<br>
+<br>
=C2=A0static void raspi2b_machine_class_init(ObjectClass *oc, void *data)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MachineClass *mc =3D MACHINE_CLASS(oc);<br>
@@ -348,6 +357,10 @@ static void raspi3b_machine_class_init(ObjectClass *oc=
, void *data)<br>
<br>
=C2=A0static const TypeInfo raspi_machine_types[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D MACHINE_TYPE_NAME(&quot;raspi1b&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D T=
YPE_RASPI_MACHINE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D raspi1b_mac=
hine_class_init,<br>
+=C2=A0 =C2=A0 }, {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D MACHINE_TYPE_NAME(&quot;raspi2b&quot;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D TYPE_RASPI_MACHINE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =C2=A0=3D raspi2=
b_machine_class_init,<br>
-- <br>
2.21.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--000000000000503eeb059f318a90--

