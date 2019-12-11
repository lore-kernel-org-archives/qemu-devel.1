Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0973BC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 10:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94EE2073B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 10:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjgjS+6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94EE2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iezBp-0000RM-Qv
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 05:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iezBB-0008Ky-Lg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 05:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iezB8-00055Y-KY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 05:25:13 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:36875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iezB8-00051S-7P
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 05:25:10 -0500
Received: by mail-ed1-x535.google.com with SMTP id cy15so18957144edb.4
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 02:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rXhwFMG0BL17nGwkzk9W9CSbQJZYitzRX1dD1vccva8=;
 b=gjgjS+6OpeEo2LgclRLcH8qUXWj6mRIqdgebvqPEErQWDykbaLpL18R/NKAnz5M2AM
 FwkYZulewN1Wq3dD13EYWQo62TD1OhJEsZ3eipLtgDMqW0LY5CY1mpa8NPbP6N8cqlGP
 vRRdEB882uTHh67eF6WwAEr43DQg8gJMgMQTFPDOHrlngBu7MSWijT5/dX2kBeHgaxVz
 r0mWlZScSo1C3XXQGTga+aOguBQgFpzWS+Ik3hQcA8sZvwQGKU15iAZpUmWRuYjNsF6K
 GoXhCP/V4qnRHkGg4m827yJqyHgqRfjGlwJ+IeZyQG9yKmi59C4Ss8qMIZQFkfwzyfIJ
 S2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rXhwFMG0BL17nGwkzk9W9CSbQJZYitzRX1dD1vccva8=;
 b=KtzHrR22qwkmJazD3Bj4uunhMEDGR7ORZvO1vmRIDJA/Nv66uLyoQuzlIAQkUmKTxz
 j2N2y2hhtc8mh2Z0M9E4eFQZI+ZqltUj1Wj6qvGm1sAZI45o/Yu3gl8eixwCCmpY/17b
 8YzkrY0az+QZC/TYLjgdZyw3nXkfsWuKBgRIsSIyQzEoKI83IvmaVILu4KOMRfsaEm2s
 TOfE2Gxg8dwtR1VtHw1AfEmZ/ae0CssYS81dhVdNyx2OcuIbJwyjJ7cDE6F4uXvD6rSH
 Pmi/ZVn2K3pRvrG9wX/bSP1NFO4GTBoCkueOSmwK80gIIicIa5C/w/szm+pxBUJZnmWf
 eWZw==
X-Gm-Message-State: APjAAAWx8Qyxr6vP3x1EfYkchdpsoVzRrQOB7tL5dxLLZKqlblMkDnCy
 t2XuPiBfjSUv/NEuFvDby2DSVc+LOAuI9MExn2M=
X-Google-Smtp-Source: APXvYqyLnYzegmmERscotwEokNTnTKcTl+ccwWsBJbfZ4UU80dZQ0szbRZJRyiwm2CU0BBjM/gDNX5p3TqhpNi0EHp0=
X-Received: by 2002:a17:906:5246:: with SMTP id
 y6mr2387461ejm.330.1576059908214; 
 Wed, 11 Dec 2019 02:25:08 -0800 (PST)
MIME-Version: 1.0
References: <CAGbAg_CAh-U-xRh+d6wNLQVWoHXEA0xcW6021Qd4WsMJBGfgOg@mail.gmail.com>
 <CAGbAg_A5G2trFWEuAL2da169v=XFrS44g64F6yZo5phLC+T=PQ@mail.gmail.com>
 <a579e1c4-fe3f-d8d0-3064-96473eb24e3a@redhat.com>
 <CAPan3Wq=ru496SOb93YA6ytTJJbSFtTuXC_B-MPETC5_ipdE6A@mail.gmail.com>
In-Reply-To: <CAPan3Wq=ru496SOb93YA6ytTJJbSFtTuXC_B-MPETC5_ipdE6A@mail.gmail.com>
From: Esteban Bosse <estebanbosse@gmail.com>
Date: Wed, 11 Dec 2019 11:24:57 +0100
Message-ID: <CAGbAg_CX62Ds3yYZUx2Q2_53FEFO26+WZ8okPBxzfTWBbAbyQA@mail.gmail.com>
Subject: Re: BeagleBone support, omap1, omap2, omap3, etc.
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f953d105996b0ae5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::535
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f953d105996b0ae5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Niek and Philippe,

Thank you very much for your support and all the information provided,
I will create a new "roadmap" with all this excellent information and try
again.

Thank you again and best regards,
Esteban Bosse

El mar., 10 dic. 2019 a las 20:51, Niek Linnenbank (<
nieklinnenbank@gmail.com>) escribi=C3=B3:

> Hello Philippe and Esteban,
>
> On Tue, Dec 10, 2019 at 10:55 AM Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com>
> wrote:
>
>> Hi Esteban,
>>
>> On 12/3/19 4:24 PM, Esteban Bosse wrote:
>> > Ping
>> >
>> > El mi=C3=A9., 6 nov. 2019 16:04, Esteban Bosse <estebanbosse@gmail.com
>> > <mailto:estebanbosse@gmail.com>> escribi=C3=B3:
>> >
>> >     Hello!
>> >
>> >     Some months ago I started to work trying to port the Beaglebone
>> >     support from the old qemu-linaro fork to the new QEMU mainstream.
>> >
>> >     During my work I found that the Beaglebone have an OMAP3 mpu this
>> >     mpu has very strong relation with the OMAP2 and OMAP1 in qemu, the=
y
>> >     implement a lot of functions in common.
>> >
>> >     Then I understood that the omap1 and omap2 don't implement things
>> >     like QOM and needs a lot of work to upgrade it, at the same time
>> >     they are some boards like: omap1_sx, palm, nseries that implement
>> >     this mpus.
>> >
>> >     Looking the datasheet of the omap1 I realized that it's an very ol=
d
>> >     device and some questions like "make sense work with this old
>> >     device?" comes to my mind.
>>
>> The OMAP3 reuse various components of the OMAP1/2.
>> Although in old shape, the OMAP1/2 are in the codebase and work.
>> It make sense to me to start upgrading the OMAP1/2 to new QOM standard,
>> then add the OMAP3 missing parts.
>>
>> The previous recommendations from Peter are still valid:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg636936.html
>>
>> Or you can use the schema followed by Niek when adding the Allwinner H3:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg662591.html
>>
>> That is:
>>
>> - Add tests using old code (booting Linux, network access in guest)
>> - Add an empty board
>> - Plug an empty OMAP SoC into the board, add the PoP LPDRAM
>> - Add a ARM926 core into the SoC
>> - Add most of the devices as UnimplementedDevice
>> - Add the interrupt controller in the SoC
>> - Add the UART in the SoC
>> - Add the Timers in the SoC
>> - Try to boot a Linux kernel (UART, TMR, then IRQ tested)
>> - Add the SD controller in the SoC
>> - Plug a drive to the SD in the board
>> - Try to boot u-boot
>> - You can now start the OMAP2 using a ARM1136 core
>> - Add the missing UNIMP devices (loop to previous steps)
>> - Add network controller
>> - Run tests (booting Linux, network access in guest)
>> - Remove old code
>>
>> >     When I went to the KVM Forum the last week I talked with some of
>> >     you, and you help my with different ideas and proposal to make thi=
s
>> >     task, but I can't see the right way to make this work because it i=
s
>> >     a lot of work.
>> >
>> >     My motivation is learn more about embedded devices, architecture,
>> >     kernel, etc. and of course contribute to the community.
>> >
>> >     I would love to hear your opinions about this 3 related devices wi=
th
>> >     they respected boards.
>> >
>> >     Maybe someone is interested to work with me.
>> >     I dream to make this work beautiful (like the musca board with the
>> >     armsse and armv7m modules) with a good variety of tests. And in th=
e
>> >     same time I would like to write some documentation about the proce=
ss
>> >     with the final idea to "make an easier way for new contributors".
>>
>> Very good idea.
>>
>> Niek, since you recently did the same, do you mind sharing your
>> experience, tell us what was not clear or hard to understand, so we can
>> have a better idea what part of the documentation/process we should
>> improve first, to help and welcome new contributors?
>>
>
> Sure! Based on my own experience with the Allwinner H3, I can fully
> recommend the steps
> described above by Philippe to get the work done. Those are mostly the
> things I did as well.
>
> I think the best advice I can give you to get started is, start with the
> bare minimum: kernel output.
> What I mean by that is, get the linux source and compile it for your
> target machine. Next, take the QEMU source and choose
> any existing machine that come closest to the machine or SoC that you wan=
t
> to implement.
> Then, just try to get the kernel output working via the serial console by
> loading it with -kernel, -append and -dtb arguments.
>
> If you are lucky, serial output already works since the machine is simila=
r
> to the one you want to implement. If not,
> you may need to check for things like the load address and DRAM addresses
> first and try to get output
> by reading the kernel dmesg via GDB [1]. If you start QEMU with -s -S
> arguments, connect with gdb
> and give the 'lx-dmesg' command you'll read the kernel output before it
> goes to the serial device.
> If you at least selected the right processor and things like the load
> address are OK, chances are good
> that you at least get some logging.  And then, you have a starting point
> to start the real work using the
> steps described above by Philippe.
>
> Regards,
> Niek
>
> [1]
> https://www.kernel.org/doc/html/v4.10/dev-tools/gdb-kernel-debugging.html
>
>
>
>>
>> >
>> >     If someone want to work with me in this task, should know that I
>> >     don't have to much experience and I'm doing this job in my free ti=
me
>> >     (this means that I work only in my free time).
>> >
>> >     I appreciate any kind of comment or advice.
>> >
>> >     Thanks for your time ;)
>> >     EstebanB
>> >
>>
>>
>
> --
> Niek Linnenbank
>
>

--000000000000f953d105996b0ae5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Niek and Philippe,<br><br>Thank you very much for yo=
ur support and all the information provided,=C2=A0<br>I will create a new &=
quot;roadmap&quot; with all this excellent=C2=A0information and try again.<=
br><br>Thank you again and best=C2=A0regards,<div>Esteban Bosse</div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">El mar=
., 10 dic. 2019 a las 20:51, Niek Linnenbank (&lt;<a href=3D"mailto:nieklin=
nenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;) escribi=C3=B3:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div d=
ir=3D"ltr"><div>Hello Philippe and Esteban,</div><div><br></div></div><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 10,=
 2019 at 10:55 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi Esteban,<br>
<br>
On 12/3/19 4:24 PM, Esteban Bosse wrote:<br>
&gt; Ping<br>
&gt; <br>
&gt; El mi=C3=A9., 6 nov. 2019 16:04, Esteban Bosse &lt;<a href=3D"mailto:e=
stebanbosse@gmail.com" target=3D"_blank">estebanbosse@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:estebanbosse@gmail.com" target=3D"_blank"=
>estebanbosse@gmail.com</a>&gt;&gt; escribi=C3=B3:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hello!<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Some months ago I started to work trying to port th=
e Beaglebone<br>
&gt;=C2=A0 =C2=A0 =C2=A0support from the old qemu-linaro fork to the new QE=
MU mainstream.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0During my work I found that the Beaglebone have an =
OMAP3 mpu this<br>
&gt;=C2=A0 =C2=A0 =C2=A0mpu has very strong relation with the OMAP2 and OMA=
P1 in qemu, they<br>
&gt;=C2=A0 =C2=A0 =C2=A0implement a lot of functions in common.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Then I understood that the omap1 and omap2 don&#39;=
t implement things<br>
&gt;=C2=A0 =C2=A0 =C2=A0like QOM and needs a lot of work to upgrade it, at =
the same time<br>
&gt;=C2=A0 =C2=A0 =C2=A0they are some boards like: omap1_sx, palm, nseries =
that implement<br>
&gt;=C2=A0 =C2=A0 =C2=A0this mpus.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Looking the datasheet of the omap1 I realized that =
it&#39;s an very old<br>
&gt;=C2=A0 =C2=A0 =C2=A0device and some questions like &quot;make sense wor=
k with this old<br>
&gt;=C2=A0 =C2=A0 =C2=A0device?&quot; comes to my mind.<br>
<br>
The OMAP3 reuse various components of the OMAP1/2.<br>
Although in old shape, the OMAP1/2 are in the codebase and work.<br>
It make sense to me to start upgrading the OMAP1/2 to new QOM standard, <br=
>
then add the OMAP3 missing parts.<br>
<br>
The previous recommendations from Peter are still valid:<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg636936.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg636936.html</a><br>
<br>
Or you can use the schema followed by Niek when adding the Allwinner H3:<br=
>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg662591.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg662591.html</a><br>
<br>
That is:<br>
<br>
- Add tests using old code (booting Linux, network access in guest)<br>
- Add an empty board<br>
- Plug an empty OMAP SoC into the board, add the PoP LPDRAM<br>
- Add a ARM926 core into the SoC<br>
- Add most of the devices as UnimplementedDevice<br>
- Add the interrupt controller in the SoC<br>
- Add the UART in the SoC<br>
- Add the Timers in the SoC<br>
- Try to boot a Linux kernel (UART, TMR, then IRQ tested)<br>
- Add the SD controller in the SoC<br>
- Plug a drive to the SD in the board<br>
- Try to boot u-boot<br>
- You can now start the OMAP2 using a ARM1136 core<br>
- Add the missing UNIMP devices (loop to previous steps)<br>
- Add network controller<br>
- Run tests (booting Linux, network access in guest)<br>
- Remove old code<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0When I went to the KVM Forum the last week I talked=
 with some of<br>
&gt;=C2=A0 =C2=A0 =C2=A0you, and you help my with different ideas and propo=
sal to make this<br>
&gt;=C2=A0 =C2=A0 =C2=A0task, but I can&#39;t see the right way to make thi=
s work because it is<br>
&gt;=C2=A0 =C2=A0 =C2=A0a lot of work.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0My motivation is learn more about embedded devices,=
 architecture,<br>
&gt;=C2=A0 =C2=A0 =C2=A0kernel, etc. and of course contribute to the commun=
ity.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I would love to hear your opinions about this 3 rel=
ated devices with<br>
&gt;=C2=A0 =C2=A0 =C2=A0they respected boards.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Maybe someone is interested to work with me.<br>
&gt;=C2=A0 =C2=A0 =C2=A0I=C2=A0dream to make this work beautiful (like the =
musca board with the<br>
&gt;=C2=A0 =C2=A0 =C2=A0armsse and armv7m modules) with a good variety of t=
ests. And in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0same time I would like to write some documentation =
about the process<br>
&gt;=C2=A0 =C2=A0 =C2=A0with the final idea to &quot;make an easier way for=
 new contributors&quot;.<br>
<br>
Very good idea.<br>
<br>
Niek, since you recently did the same, do you mind sharing your <br>
experience, tell us what was not clear or hard to understand, so we can <br=
>
have a better idea what part of the documentation/process we should <br>
improve first, to help and welcome new contributors?<br></blockquote><div><=
br></div><div>Sure! Based on my own experience with the Allwinner H3, I can=
 fully recommend the steps</div><div>described above by Philippe to get the=
 work done. Those are mostly the things I did as well.</div><div><br></div>=
<div>I think the best advice I can give you to get started is, start with t=
he bare minimum: kernel output.</div><div>What I mean by that is, get the l=
inux source and compile it for your target machine. Next, take the QEMU sou=
rce and choose</div><div>any existing machine that come closest to the mach=
ine or SoC that you want to implement.</div><div>Then, just try to get the =
kernel output working via the serial console by loading it with -kernel, -a=
ppend and -dtb arguments.</div><div><br></div><div>If you are lucky, serial=
 output already works since the machine is similar to the one you want to i=
mplement. If not,</div><div>you may need to check for things like the load =
address and DRAM addresses first and try to get output</div><div>by reading=
 the kernel dmesg via GDB [1]. If you start QEMU with -s -S arguments, conn=
ect with gdb</div><div>and give the &#39;lx-dmesg&#39; command you&#39;ll r=
ead the kernel output before it goes to the serial device.</div><div>If you=
 at least selected the right processor and things like the load address are=
 OK, chances are good</div><div>that you at least get some logging.=C2=A0 A=
nd then, you have a starting point to start the real work using the</div><d=
iv>steps described above by Philippe.<br></div><div><br></div><div>Regards,=
</div><div>Niek<br></div><div><br></div><div>[1] <a href=3D"https://www.ker=
nel.org/doc/html/v4.10/dev-tools/gdb-kernel-debugging.html" target=3D"_blan=
k">https://www.kernel.org/doc/html/v4.10/dev-tools/gdb-kernel-debugging.htm=
l</a></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0If someone want to work with me in this task, shoul=
d know that I<br>
&gt;=C2=A0 =C2=A0 =C2=A0don&#39;t have to much experience and I&#39;m doing=
 this job in my free time<br>
&gt;=C2=A0 =C2=A0 =C2=A0(this means that I work only in my free time).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I appreciate any kind of comment or advice.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks for your time ;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0EstebanB<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>
</blockquote></div>

--000000000000f953d105996b0ae5--

