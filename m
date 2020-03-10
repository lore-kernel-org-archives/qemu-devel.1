Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D27FC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1444215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9bU/XTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1444215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38971 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBkIW-0005Tj-23
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 15:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBkHV-0004Ui-QL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBkHT-0001ZG-Vj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:11:09 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:36080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBkHT-0001XR-Mn; Tue, 10 Mar 2020 15:11:07 -0400
Received: by mail-il1-x142.google.com with SMTP id h3so1763276ils.3;
 Tue, 10 Mar 2020 12:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3gMdxSJmlSDTB6U+PsygXS1ZLglBM1WGKJh6I0PUIas=;
 b=q9bU/XTGgQcSWoczCmuKUyjiuoNTTwzVLqAsmrnPETChOXvam9o4K/FqoYt3yqPY53
 lQQHSHziF+UqO7FLUWAG5EEZo8/jYXaA0sVdVB9sw+ZKxPgac4PYmQiSN4l5GontHctJ
 gliAiEkaGUqLSIDMutqbWteLwgh4mQ1rEIyjQytZ2aMN8ZrvT5qB3mMGOU1fRc7PSpak
 uuqatI5Pu5hDnLhgvkZaB5LcAPnn5b3EFnwT4lwFkNgMJQVnObLx77PaW4Xe9jwUWDFN
 Xh6Jv35IFccx/koUEf8CjhG2Rw1i+yRCk7J+oeuXZF0qbQohyZcVSB6fhOVKy2fPyV93
 YrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3gMdxSJmlSDTB6U+PsygXS1ZLglBM1WGKJh6I0PUIas=;
 b=cnvqD67IUKBgwpS0+WDPgN84TJTJxDV7+LLOOi6WSIKiJDCK12BsbLvMfKFxXliyao
 3cKzyZxVANoCWLNYbpnoiqkF62YYc8XyEMZMXMZHtkuJCfcSYV/uNzqH4iAzLkk208j+
 tsmXAqEc44Xwk6u/ukCX2bWVR1jqAAqXcx7Dh/DV72m4IYHALqks3tAOAdczaUhYCXfe
 /48BSPfHwYKwT2qqTSgVrFINkH8H23j6gAjase82Osj19vN5Lpy8lj+pxS0HLXNUO3PX
 vujc+335bUQ3NeinCm6j9rRIfJ09NRi/BWspXZ8WSRZFajPo/PaX8rPO4H+IxPNnnvM9
 ue4w==
X-Gm-Message-State: ANhLgQ158D5IEwH8V2l9aE6e7ZLB4ASbqmPigF6KNMYvrDWElvZpD2bB
 AXtMZpsipNJyfBDwMrTdfNMIyKhC9uAkbE6hXCc=
X-Google-Smtp-Source: ADFU+vvTdoCgNh6xJ6gZYB9keC8Fkn9Ci3/Td4qI0ykOpx5clQVYmaPDDJgEqegvBS0QrsPYAqYyi0YJhwbUEVkT+rI=
X-Received: by 2002:a92:58d0:: with SMTP id z77mr13401762ilf.67.1583867467126; 
 Tue, 10 Mar 2020 12:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
 <CAPan3WqOT1B4xuJeAYUh4Np1UjJuypCDSQVGeV2yyNbH5mBxKw@mail.gmail.com>
 <87pndkiq0x.fsf@linaro.org>
In-Reply-To: <87pndkiq0x.fsf@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Mar 2020 20:10:55 +0100
Message-ID: <CAPan3WrDCruqwFW6R010u4Cjhx7N6cEZ_9CfpZai8cp=G_m8nA@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bfdd0605a084e1aa"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bfdd0605a084e1aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 9:16 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>
> > Hi Alex,
> >
> > On Wed, Mar 4, 2020 at 9:55 PM Niek Linnenbank <nieklinnenbank@gmail.co=
m
> >
> > wrote:
> >
> >> Hello Alex,
> >>
> >> On Wed, Mar 4, 2020 at 11:35 AM Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg>
> >> wrote:
> >>
> >>>
> >>> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
> >>>
> >>> > The Xunlong Orange Pi PC machine is a functional ARM machine
> >>> > based on the Allwinner H3 System-on-Chip. It supports mainline
> >>> > Linux, U-Boot, NetBSD and is covered by acceptance tests.
> >>> >
> >>> > This commit adds a documentation text file with a description
> >>> > of the machine and instructions for the user.
> >>>
> >>> This is great, thanks for taking the time to include documentation.
> >>>
> >>
> >> Sure, I'm happy to contribute it. I tried to include most relevant
> >> information
> >> in there for developers and potential users of the machine. If somethi=
ng
> >> is missing
> >> just let me know and I'll make an update for it.
> >>
> >>
> >>>
> >>> >
> >>> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> >>> > ---
> >>> >  docs/orangepi.rst | 226
> >>> > ++++++++++++++++++++++++++++++++++++++++++++++
> >>>
> >>> I suspect there is a better place to put this is than the top level. =
I
> >>> wonder if it should be docs/specs?
> >>>
> >>
> >> Yeah I'm fine to move it to a different subdirectory if needed. Right
> now
> >> its placed in docs,
> >> as it seems that documents for machines are also placed there, for
> example
> >> docs/microvm.rst
> >>
> >>
> >>>
> >>> >  MAINTAINERS       |   1 +
> >>> >  2 files changed, 227 insertions(+)
> >>> >  create mode 100644 docs/orangepi.rst
> >>> >
> >>> > diff --git a/docs/orangepi.rst b/docs/orangepi.rst
> >>> > new file mode 100644
> >>> > index 0000000000..a9b46f553c
> >>> > --- /dev/null
> >>> > +++ b/docs/orangepi.rst
> >>> > @@ -0,0 +1,226 @@
> >>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>> > +Orange Pi PC Machine Type
> >>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>> > +
> >>> > +The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> >>> > +based embedded computer with mainline support in both U-Boot
> >>> > +and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> >>> > +1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> >>> > +various other I/O.
> >>>
> >>> When Peter's document PR goes in later this week there will also be a=
:
> >>>
> >>>   docs/system/target-arm.rst
> >>>
> >>> which would benefit from a section for the Orange Pi in it.
> >>>
> >>
> >> Nice, I'll have a look at it when it gets merged and add a section for
> >> Orange Pi.
> >> I'll try to include that in the next version of this series.
> >>
> >>
> >>>
> >>> > +
> >>> > +Supported devices
> >>> > +-----------------
> >>> > +
> >>> > +The Orange Pi PC machine supports the following devices:
> >>> > +
> >>> > + * SMP (Quad Core Cortex A7)
> >>> > + * Generic Interrupt Controller configuration
> >>> > + * SRAM mappings
> >>> > + * SDRAM controller
> >>> > + * Real Time Clock
> >>> > + * Timer device (re-used from Allwinner A10)
> >>> > + * UART
> >>> > + * SD/MMC storage controller
> >>> > + * EMAC ethernet
> >>>
> >>> Do we ever exercise the ethernet in the acceptance tests? I see we ha=
ve
> >>> some that boots a full OS but boot console only seems to touch the
> >>> serial console.
> >>>
> >>
> >> Good point. Currently in the acceptance tests U-Boot and Linux detect
> >> the ethernet device, but there are no explicit checks for that in the
> >> acceptance tests
> >> nor any actual packet transmission.
> >>
> >> I'll try to extend the current tests in the next version of this serie=
s
> to
> >> include some
> >> basic checks for the ethernet device, perhaps with DHCP or a ping.
> >> I'm open to suggestions for the preferred way to do this.
> >>
> >
> > FYI, I added some coverage for the ethernet device by extending the
> > test_arm_orangepi_sd test with a few lines like:
> >
> > +        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up',
> 'eth0:
> > Link is Up')
> > +        exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
> > +                                                'udhcpc: lease of
> > 10.0.2.15 obtained')
> > +        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
> > +            '3 packets transmitted, 3 packets received, 0% packet loss=
')
> >
>
> That will work as a smoke test. Are you going to re-spin this week so we
> can get the final reviews done?
>

OK Alex!
Yes, as I just replied to Peter as well, I'm finalizing / testing the v7
update now and will send it to the list in a few hours.
I'll reserve some extra time the coming days so I can reply & respin
quickly.

Regards,
Niek


>
> > Regards,
> > Niek
> >
> >
> >> Regards,
> >> Niek
> >>
> >>
> >>
> >>
> >>
> >>
> >>>
> >>> <snip>
> >>>
> >>> --
> >>> Alex Benn=C3=A9e
> >>>
> >>
> >>
> >> --
> >> Niek Linnenbank
> >>
> >>
>
>
> --
> Alex Benn=C3=A9e
>


--=20
Niek Linnenbank

--000000000000bfdd0605a084e1aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10, 2020 at 9:16 AM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_=
blank">nieklinnenbank@gmail.com</a>&gt; writes:<br>
<br>
&gt; Hi Alex,<br>
&gt;<br>
&gt; On Wed, Mar 4, 2020 at 9:55 PM Niek Linnenbank &lt;<a href=3D"mailto:n=
ieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;=
<br>
&gt; wrote:<br>
&gt;<br>
&gt;&gt; Hello Alex,<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Mar 4, 2020 at 11:35 AM Alex Benn=C3=A9e &lt;<a href=3D"ma=
ilto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&g=
t;<br>
&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com=
" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt; writes:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt; The Xunlong Orange Pi PC machine is a functional ARM mach=
ine<br>
&gt;&gt;&gt; &gt; based on the Allwinner H3 System-on-Chip. It supports mai=
nline<br>
&gt;&gt;&gt; &gt; Linux, U-Boot, NetBSD and is covered by acceptance tests.=
<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; This commit adds a documentation text file with a descrip=
tion<br>
&gt;&gt;&gt; &gt; of the machine and instructions for the user.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This is great, thanks for taking the time to include documenta=
tion.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Sure, I&#39;m happy to contribute it. I tried to include most rele=
vant<br>
&gt;&gt; information<br>
&gt;&gt; in there for developers and potential users of the machine. If som=
ething<br>
&gt;&gt; is missing<br>
&gt;&gt; just let me know and I&#39;ll make an update for it.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:niek=
linnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br=
>
&gt;&gt;&gt; &gt; ---<br>
&gt;&gt;&gt; &gt;=C2=A0 docs/orangepi.rst | 226<br>
&gt;&gt;&gt; &gt; ++++++++++++++++++++++++++++++++++++++++++++++<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I suspect there is a better place to put this is than the top =
level. I<br>
&gt;&gt;&gt; wonder if it should be docs/specs?<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Yeah I&#39;m fine to move it to a different subdirectory if needed=
. Right now<br>
&gt;&gt; its placed in docs,<br>
&gt;&gt; as it seems that documents for machines are also placed there, for=
 example<br>
&gt;&gt; docs/microvm.rst<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
&gt;&gt;&gt; &gt;=C2=A0 2 files changed, 227 insertions(+)<br>
&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 docs/orangepi.rst<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; diff --git a/docs/orangepi.rst b/docs/orangepi.rst<br>
&gt;&gt;&gt; &gt; new file mode 100644<br>
&gt;&gt;&gt; &gt; index 0000000000..a9b46f553c<br>
&gt;&gt;&gt; &gt; --- /dev/null<br>
&gt;&gt;&gt; &gt; +++ b/docs/orangepi.rst<br>
&gt;&gt;&gt; &gt; @@ -0,0 +1,226 @@<br>
&gt;&gt;&gt; &gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt; +Orange Pi PC Machine Type<br>
&gt;&gt;&gt; &gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt; +<br>
&gt;&gt;&gt; &gt; +The Xunlong Orange Pi PC is an Allwinner H3 System on Ch=
ip<br>
&gt;&gt;&gt; &gt; +based embedded computer with mainline support in both U-=
Boot<br>
&gt;&gt;&gt; &gt; +and Linux. The board comes with a Quad Core Cortex A7 @ =
1.3GHz,<br>
&gt;&gt;&gt; &gt; +1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and<b=
r>
&gt;&gt;&gt; &gt; +various other I/O.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; When Peter&#39;s document PR goes in later this week there wil=
l also be a:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0docs/system/target-arm.rst<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; which would benefit from a section for the Orange Pi in it.<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Nice, I&#39;ll have a look at it when it gets merged and add a sec=
tion for<br>
&gt;&gt; Orange Pi.<br>
&gt;&gt; I&#39;ll try to include that in the next version of this series.<b=
r>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt; +<br>
&gt;&gt;&gt; &gt; +Supported devices<br>
&gt;&gt;&gt; &gt; +-----------------<br>
&gt;&gt;&gt; &gt; +<br>
&gt;&gt;&gt; &gt; +The Orange Pi PC machine supports the following devices:=
<br>
&gt;&gt;&gt; &gt; +<br>
&gt;&gt;&gt; &gt; + * SMP (Quad Core Cortex A7)<br>
&gt;&gt;&gt; &gt; + * Generic Interrupt Controller configuration<br>
&gt;&gt;&gt; &gt; + * SRAM mappings<br>
&gt;&gt;&gt; &gt; + * SDRAM controller<br>
&gt;&gt;&gt; &gt; + * Real Time Clock<br>
&gt;&gt;&gt; &gt; + * Timer device (re-used from Allwinner A10)<br>
&gt;&gt;&gt; &gt; + * UART<br>
&gt;&gt;&gt; &gt; + * SD/MMC storage controller<br>
&gt;&gt;&gt; &gt; + * EMAC ethernet<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Do we ever exercise the ethernet in the acceptance tests? I se=
e we have<br>
&gt;&gt;&gt; some that boots a full OS but boot console only seems to touch=
 the<br>
&gt;&gt;&gt; serial console.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Good point. Currently in the acceptance tests U-Boot and Linux det=
ect<br>
&gt;&gt; the ethernet device, but there are no explicit checks for that in =
the<br>
&gt;&gt; acceptance tests<br>
&gt;&gt; nor any actual packet transmission.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ll try to extend the current tests in the next version of th=
is series to<br>
&gt;&gt; include some<br>
&gt;&gt; basic checks for the ethernet device, perhaps with DHCP or a ping.=
<br>
&gt;&gt; I&#39;m open to suggestions for the preferred way to do this.<br>
&gt;&gt;<br>
&gt;<br>
&gt; FYI, I added some coverage for the ethernet device by extending the<br=
>
&gt; test_arm_orangepi_sd test with a few lines like:<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &=
#39;ifconfig eth0 up&#39;, &#39;eth0:<br>
&gt; Link is Up&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &=
#39;udhcpc eth0&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &#39;udhcpc: lease of<br>
&gt; 10.0.2.15 obtained&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &=
#39;ping -c 3 10.0.2.2&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;3 packets transmitted,=
 3 packets received, 0% packet loss&#39;)<br>
&gt;<br>
<br>
That will work as a smoke test. Are you going to re-spin this week so we<br=
>
can get the final reviews done?<br></blockquote><div><br></div><div>OK Alex=
!</div><div>Yes, as I just replied to Peter as well, I&#39;m finalizing / t=
esting the v7 update now and will send it to the list in a few hours.</div>=
<div>I&#39;ll reserve some extra time the coming days so I can reply &amp; =
respin quickly.<br></div><div><br></div><div>Regards,</div><div>Niek<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Regards,<br>
&gt; Niek<br>
&gt;<br>
&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Niek<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &lt;snip&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Alex Benn=C3=A9e<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Niek Linnenbank<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000bfdd0605a084e1aa--

