Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C8AC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 20:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACAC20866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 20:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1GITxy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACAC20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPI8-0000xT-E8
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 15:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiPHH-0000Fc-9c
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiPHF-0005UB-0p
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:53:39 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:40729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iiPHE-0005Lx-Me; Fri, 20 Dec 2019 15:53:36 -0500
Received: by mail-il1-x142.google.com with SMTP id c4so9086565ilo.7;
 Fri, 20 Dec 2019 12:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FtM6QrrcIKciVwrC1mDDncSHnEooOIfjatjv3KovqFg=;
 b=p1GITxy0voPm4Nwn6qrvc43gBRnquFokzniG0K8nVveu9QqtQxF+yeqs5hU4o9knmD
 H2A1RYpnRT9Zk3x+nRLpEYfVJRHEl0vGzRltFhE6QAPG77vlJbvqkvLe5yFNN1FuPhgP
 z771CcRdpm1flHLbrcLtTYLJDidhEB3Ju2pGuuKsfjkGcYZi1oUkh2f3mLn7SdPr7PVP
 ZbsVD1WIgHHK85lN5mLSidiONZ4H8J1ZLszpfjqOKRq8hPqVGpVsb/M8lUQMo8QxrPkI
 VCHw3XmuJHHFtqeYvBvR7cVsgWNcfUTZd2g0+drx3P8pJupS6iWvzotGHvhcI48WwjV4
 /mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FtM6QrrcIKciVwrC1mDDncSHnEooOIfjatjv3KovqFg=;
 b=JOwZWUM3r97D5ucm6VcKEP7GddNHOqOouaT/dK8RfcJ694P5imuZszHZ63y+f/D6Yv
 +v450MaqiIadDj9gN2lTEBq1K8/t89iN5z3qJChHUJKwVCS7j+wKSZM9/EhWUshm+oBn
 bzdRSv1z0iirUx9MpPQtWso5mDJ06I3/J1jW+y/3rHUAfTOjUAzeS8LMSHQf+/nNzSPn
 wXSRe2jeeq3gC0DEduIj8BhFHKxP78ewbZnhzn433GGXxXnpPrFKDyXZKp8owCOyGHzF
 YxVo4zgcD0hH6YHwcFlSve4ahL4AQST2gdL2iYv6cDH/btUi6H+2HkqaAp+4V2ma1leS
 9tnw==
X-Gm-Message-State: APjAAAVeP3zjQeBgE8m6tqNT1o766knwLi+c8EU/hOtsK2O/67B9DZA0
 gN/SAMYykx6EfVznx5qm6QjYNt/yVyBhOHfVx2M=
X-Google-Smtp-Source: APXvYqzMYNww3znOxAKOseSz2nJ8/ZiZToe22wjxuW2UonpP0V15XL6J3QWGY1gFcTjLKOzbo7n9Iv1wYkscynsc3KM=
X-Received: by 2002:a92:c647:: with SMTP id 7mr14409560ill.28.1576875214621;
 Fri, 20 Dec 2019 12:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20191219185127.24388-1-f4bug@amsat.org>
In-Reply-To: <20191219185127.24388-1-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 20 Dec 2019 21:53:23 +0100
Message-ID: <CAPan3Wop2qT6PS4XEqe=9OjpA34kJkO-PqNB74tfjyRfYTThLA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] hw/timer/allwinner: Make it reusable
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000005d230059a28df59"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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

--00000000000005d230059a28df59
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Thu, Dec 19, 2019 at 7:51 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Hi,
>
> Niek added the H3 SoC in [1] and noticed in [2] the timer
> controller is very similar (less timers, watchdog register
> placed at different address).
>
> On 12/18/19 9:14 PM, Niek Linnenbank wrote:
> > Actually, I copied the timer support code from the existing cubieboard.=
c
> > that has
> > the Allwinner A10, so potentially the same problem is there.
> >
> > While looking more closer at this part, I now also discovered that the
> > timer module from the Allwinner H3 is
> > mostly a stripped down version of the timer module in the Allwinner A10=
:
> >
> >    Allwinner A10, 10.2 Timer Register List, page 85:
> > https://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manual_V1.5.pdf
> >
> > The A10 version has six timers, where the H3 has only two. That should
> > be fine I would say, the guest would simply
> > use those available on H3 and ignore the rest. There is however one
> > conflicting difference: the WDOG0 registers in the Allwinner H3 start
> > at a different offset and are also different. The current A10 timer doe=
s
> > not currently implement the watchdog part.
> [...]
> > So in my opinion its a bit of a trade off here: we can keep it like thi=
s
> > and re-use the A10 timer for now, and perhaps
> > attempt to generalize that module for proper use in both SoCs. Or we ca=
n
> > introduce a new H3 specific timer module.
> > What do you think?
>
> As an answer to his question, this series is to help him to
> reuse the A10 timer controller instead of adding a new model
> to the codebase.
>

Great!! This certainly answers my question indeed!

I've applied this patch on top of the allwinner H3 v2 series to test it,
and after
changing the type from AwA10PITState to the new AllwinnerTmrCtrlState,
the code compiled and ran linux/u-boot without any problems:

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 357bdfa711..fa0219fa1b 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -76,7 +76,7 @@ typedef struct AwH3State {

     ARMCPU cpus[AW_H3_NUM_CPUS];
     const hwaddr *memmap;
-    AwA10PITState timer;
+    AllwinnerTmrCtrlState timer;
     AwH3ClockState ccu;
     AwH3CpuCfgState cpucfg;
     AwH3SysconState syscon;

Also, I tested with the A10 cubieboard machine, and it also still works
fine:

./arm-softmmu/qemu-system-arm -M cubieboard -kernel zImage -nographic
-append 'console=3DttyS0,115200 earlyprintk usbcore.nousb root=3D/dev/sda r=
o
init=3D/sbin/init' -dtb sun4i-a10-cubieboard.dtb -m 512 -drive
file=3Drootfs.ext2,if=3Dnone,id=3Ddrive-sata0-0-0,format=3Draw -device
ide-hd,bus=3Dide.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0 -nic user
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.2.11 (me@host) (gcc version 5.4.0 20160609
(Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)) #1 SMP Fri Sep 13 22:48:39 CEST 201=
9
[    0.000000] CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7),
cr=3D10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing
instruction cache
[    0.000000] OF: fdt: Machine model: Cubietech Cubieboard
...

So for me this works with both the H3 and A10:
  Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek

>
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg665532.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg666304.html
>
> Philippe Mathieu-Daud=C3=A9 (13):
>   hw/timer/allwinner: Use the AW_A10_PIT_TIMER_NR definition
>   hw/timer/allwinner: Add AW_PIT_TIMER_MAX definition
>   hw/timer/allwinner: Remove unused definitions
>   hw/timer/allwinner: Move definitions from header to source
>   hw/timer/allwinner: Rename the ptimer field
>   hw/timer/allwinner: Rename 'timer_context' as 'timer'
>   hw/timer/allwinner: Move timer specific fields into AwA10TimerContext
>   hw/timer/allwinner: Add a timer_count field
>   hw/timer/allwinner: Rename AwA10TimerContext as AllwinnerTmrState
>   hw/timer/allwinner: Rename AwA10PITState as AllwinnerTmrCtrlState
>   hw/timer/allwinner: Introduce TYPE_AW_COMMON_PIT abstract device
>   hw/timer/allwinner: Rename AW_A10_PIT() as AW_TIMER_CTRL()
>   hw/timer/allwinner: Rename functions not specific to the A10 SoC
>
>  include/hw/arm/allwinner-a10.h       |   2 +-
>  include/hw/timer/allwinner-a10-pit.h |  54 ++----
>  hw/timer/allwinner-a10-pit.c         | 271 +++++++++++++++++----------
>  3 files changed, 192 insertions(+), 135 deletions(-)
>
> --
> 2.21.0
>
>

--=20
Niek Linnenbank

--00000000000005d230059a28df59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 19, 2019 at 7:51 P=
M Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@=
amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi,<br>
<br>
Niek added the H3 SoC in [1] and noticed in [2] the timer<br>
controller is very similar (less timers, watchdog register<br>
placed at different address).<br>
<br>
On 12/18/19 9:14 PM, Niek Linnenbank wrote:<br>
&gt; Actually, I copied the timer support code from the existing cubieboard=
.c<br>
&gt; that has<br>
&gt; the Allwinner A10, so potentially the same problem is there.<br>
&gt;<br>
&gt; While looking more closer at this part, I now also discovered that the=
<br>
&gt; timer module from the Allwinner H3 is<br>
&gt; mostly a stripped down version of the timer module in the Allwinner A1=
0:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Allwinner A10, 10.2 Timer Register List, page 85:<br>
&gt; <a href=3D"https://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manu=
al_V1.5.pdf" rel=3D"noreferrer" target=3D"_blank">https://linux-sunxi.org/i=
mages/1/1e/Allwinner_A10_User_manual_V1.5.pdf</a><br>
&gt;<br>
&gt; The A10 version has six timers, where the H3 has only two. That should=
<br>
&gt; be fine I would say, the guest would simply<br>
&gt; use those available on H3 and ignore the rest. There is however one<br=
>
&gt; conflicting difference: the WDOG0 registers in the Allwinner H3 start<=
br>
&gt; at a different offset and are also different. The current A10 timer do=
es<br>
&gt; not currently implement the watchdog part.<br>
[...]<br>
&gt; So in my opinion its a bit of a trade off here: we can keep it like th=
is<br>
&gt; and re-use the A10 timer for now, and perhaps<br>
&gt; attempt to generalize that module for proper use in both SoCs. Or we c=
an<br>
&gt; introduce a new H3 specific timer module.<br>
&gt; What do you think?<br>
<br>
As an answer to his question, this series is to help him to<br>
reuse the A10 timer controller instead of adding a new model<br>
to the codebase.<br></blockquote><div><br></div><div>Great!! This certainly=
 answers my question indeed!</div><div><br></div><div>I&#39;ve applied this=
 patch on top of the allwinner H3 v2 series to test it, and after</div><div=
>changing the type from AwA10PITState to the new AllwinnerTmrCtrlState,</di=
v><div>the code compiled and ran linux/u-boot without any problems:</div><d=
iv><br></div><div><span style=3D"font-family:monospace">diff --git a/includ=
e/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h<br>index 357bdfa711=
..fa0219fa1b 100644<br>--- a/include/hw/arm/allwinner-h3.h<br>+++ b/include=
/hw/arm/allwinner-h3.h<br>@@ -76,7 +76,7 @@ typedef struct AwH3State {<br>=
=C2=A0<br>=C2=A0 =C2=A0 =C2=A0ARMCPU cpus[AW_H3_NUM_CPUS];<br>=C2=A0 =C2=A0=
 =C2=A0const hwaddr *memmap;<br>- =C2=A0 =C2=A0AwA10PITState timer;<br>+ =
=C2=A0 =C2=A0AllwinnerTmrCtrlState timer;<br>=C2=A0 =C2=A0 =C2=A0AwH3ClockS=
tate ccu;<br>=C2=A0 =C2=A0 =C2=A0AwH3CpuCfgState cpucfg;<br>=C2=A0 =C2=A0 =
=C2=A0AwH3SysconState syscon;<br></span></div><div><br></div><div>Also, I t=
ested with the A10 cubieboard machine, and it also still works fine:</div><=
div><br></div><div><span style=3D"font-family:monospace">./arm-softmmu/qemu=
-system-arm -M cubieboard -kernel zImage -nographic -append &#39;console=3D=
ttyS0,115200 earlyprintk usbcore.nousb root=3D/dev/sda ro init=3D/sbin/init=
&#39; -dtb sun4i-a10-cubieboard.dtb -m 512 -drive file=3Drootfs.ext2,if=3Dn=
one,id=3Ddrive-sata0-0-0,format=3Draw -device ide-hd,bus=3Dide.0,drive=3Ddr=
ive-sata0-0-0,id=3Dsata0-0-0 -nic user<br></span></div><div><span style=3D"=
font-family:monospace"> [ =C2=A0 =C2=A00.000000] Booting Linux on physical =
CPU 0x0<br>[ =C2=A0 =C2=A00.000000] Linux version 5.2.11 (me@host) (gcc ver=
sion 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)) #1 SMP Fri Sep =
13 22:48:39 CEST 2019<br>[ =C2=A0 =C2=A00.000000] CPU: ARMv7 Processor [410=
fc080] revision 0 (ARMv7), cr=3D10c5387d<br>[ =C2=A0 =C2=A00.000000] CPU: P=
IPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache<br>[ =
=C2=A0 =C2=A00.000000] OF: fdt: Machine model: Cubietech Cubieboard<br></sp=
an></div><div><span style=3D"font-family:monospace">...</span></div><div><s=
pan style=3D"font-family:monospace"><br></span></div><div><span style=3D"fo=
nt-family:monospace"><font face=3D"arial,sans-serif">So for me this works w=
ith both the H3 and A10: <br></font></span></div><div><span style=3D"font-f=
amily:monospace"><font face=3D"arial,sans-serif">=C2=A0 Tested-by: Niek Lin=
nenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmai=
l.com</a>&gt;</font><br></span></div><div>=C2=A0</div><div>Regards,</div><d=
iv>Niek<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[1] <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg665532=
.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qe=
mu-devel@nongnu.org/msg665532.html</a><br>
[2] <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg666304=
.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qe=
mu-devel@nongnu.org/msg666304.html</a><br>
<br>
Philippe Mathieu-Daud=C3=A9 (13):<br>
=C2=A0 hw/timer/allwinner: Use the AW_A10_PIT_TIMER_NR definition<br>
=C2=A0 hw/timer/allwinner: Add AW_PIT_TIMER_MAX definition<br>
=C2=A0 hw/timer/allwinner: Remove unused definitions<br>
=C2=A0 hw/timer/allwinner: Move definitions from header to source<br>
=C2=A0 hw/timer/allwinner: Rename the ptimer field<br>
=C2=A0 hw/timer/allwinner: Rename &#39;timer_context&#39; as &#39;timer&#39=
;<br>
=C2=A0 hw/timer/allwinner: Move timer specific fields into AwA10TimerContex=
t<br>
=C2=A0 hw/timer/allwinner: Add a timer_count field<br>
=C2=A0 hw/timer/allwinner: Rename AwA10TimerContext as AllwinnerTmrState<br=
>
=C2=A0 hw/timer/allwinner: Rename AwA10PITState as AllwinnerTmrCtrlState<br=
>
=C2=A0 hw/timer/allwinner: Introduce TYPE_AW_COMMON_PIT abstract device<br>
=C2=A0 hw/timer/allwinner: Rename AW_A10_PIT() as AW_TIMER_CTRL()<br>
=C2=A0 hw/timer/allwinner: Rename functions not specific to the A10 SoC<br>
<br>
=C2=A0include/hw/arm/allwinner-a10.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
=C2=A0include/hw/timer/allwinner-a10-pit.h |=C2=A0 54 ++----<br>
=C2=A0hw/timer/allwinner-a10-pit.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 271 +=
++++++++++++++++----------<br>
=C2=A03 files changed, 192 insertions(+), 135 deletions(-)<br>
<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000005d230059a28df59--

