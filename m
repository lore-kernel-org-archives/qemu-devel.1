Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C6FC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FEA20727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hib+sE8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FEA20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOCl-0007s4-7q
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBOBw-0006yo-Fk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBOBu-0000kS-PL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:35:56 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:42526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBOBu-0000jv-Id; Mon, 09 Mar 2020 15:35:54 -0400
Received: by mail-io1-xd41.google.com with SMTP id q128so10349972iof.9;
 Mon, 09 Mar 2020 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VslxQD5mjwP9d8RwPmpfr07T+MCRCllTZgrsy2E+pms=;
 b=hib+sE8lHyVO4pmAJGBiDiFHavijvtBbmV+VysS3LwlJX3ofKE0M4INKjJMMX5ZTww
 +siOWuOuAROhc/IDaTMAPos2uUpBj1bLMQ5GTca23SKIVweOHxY/RmJcCHGyT5KBhUUM
 p/VbRbgnIu2Q4jqsItnbDQQ1mrd+NHzLr+sbje6jHvaejWcBTq6uKkg8kZOLqcplqQXB
 DQTNuRP+NBT9tgD6rF7UjiEhwSKd4zHaK1tF2IzGpTzzlvPnK38uNAqyIa9YQ+BrRuoU
 kvd2oT4tiDl9x5Ah3lR0i3r4beW2NZpvc7S2nWFTdvyUOdL2iAcx4SGvyrcAZs2eU+eH
 YRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VslxQD5mjwP9d8RwPmpfr07T+MCRCllTZgrsy2E+pms=;
 b=LpSmISOoi28IdqNV48qYHl31xQ2DvdYgstwGj6oxiOLo5TvZ7oOk9+dwQ0NfNU0CE/
 ug9oeQ36Ncu45rI8mFMYJ1nqJydNUvZepRWp9tElfqQ38lQqajIVMyKU05YZP+JgsmPD
 uO4cX+z9xurMb1AIQqwrsztl9+NbiL+GzQbQg/OxO4UzdE49439jiE0YMM6dVQTr+5cX
 WD9lCWLP/uDF0N/XCyC37ffusgvCOhB+JYOpCUUEjrXF68kkSROHV6eQYJSTx4xUpfla
 ERDp8lt+CMk9u1Vui80RxXmG6LbxhjFavpSoRbhw0/32OFRsmJXRorm7cfwxS0AoGfUr
 /NFQ==
X-Gm-Message-State: ANhLgQ0fy7Hy7CbxG4EUF6/K2oddtOwW6ZFC91eBr+VTVHr0VHrUcq6P
 lSlWOHZgKYQWdWZmmkJ3dRr9jUN/+dspZKPouHc=
X-Google-Smtp-Source: ADFU+vs3TAacZFigCb7I0mJXfNDoYnoXWdD5TCBm5PdkKd1XnkwZ7XkdmxB7ngptHThEq1233YQD+oNQtuTaOEqREwo=
X-Received: by 2002:a6b:2bc2:: with SMTP id r185mr9793071ior.60.1583782553572; 
 Mon, 09 Mar 2020 12:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
In-Reply-To: <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 9 Mar 2020 20:35:42 +0100
Message-ID: <CAPan3WqOT1B4xuJeAYUh4Np1UjJuypCDSQVGeV2yyNbH5mBxKw@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000081dc3505a0711c08"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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

--00000000000081dc3505a0711c08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Wed, Mar 4, 2020 at 9:55 PM Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

> Hello Alex,
>
> On Wed, Mar 4, 2020 at 11:35 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>
> wrote:
>
>>
>> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>>
>> > The Xunlong Orange Pi PC machine is a functional ARM machine
>> > based on the Allwinner H3 System-on-Chip. It supports mainline
>> > Linux, U-Boot, NetBSD and is covered by acceptance tests.
>> >
>> > This commit adds a documentation text file with a description
>> > of the machine and instructions for the user.
>>
>> This is great, thanks for taking the time to include documentation.
>>
>
> Sure, I'm happy to contribute it. I tried to include most relevant
> information
> in there for developers and potential users of the machine. If something
> is missing
> just let me know and I'll make an update for it.
>
>
>>
>> >
>> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>> > ---
>> >  docs/orangepi.rst | 226
>> > ++++++++++++++++++++++++++++++++++++++++++++++
>>
>> I suspect there is a better place to put this is than the top level. I
>> wonder if it should be docs/specs?
>>
>
> Yeah I'm fine to move it to a different subdirectory if needed. Right now
> its placed in docs,
> as it seems that documents for machines are also placed there, for exampl=
e
> docs/microvm.rst
>
>
>>
>> >  MAINTAINERS       |   1 +
>> >  2 files changed, 227 insertions(+)
>> >  create mode 100644 docs/orangepi.rst
>> >
>> > diff --git a/docs/orangepi.rst b/docs/orangepi.rst
>> > new file mode 100644
>> > index 0000000000..a9b46f553c
>> > --- /dev/null
>> > +++ b/docs/orangepi.rst
>> > @@ -0,0 +1,226 @@
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> > +Orange Pi PC Machine Type
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> > +
>> > +The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
>> > +based embedded computer with mainline support in both U-Boot
>> > +and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
>> > +1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
>> > +various other I/O.
>>
>> When Peter's document PR goes in later this week there will also be a:
>>
>>   docs/system/target-arm.rst
>>
>> which would benefit from a section for the Orange Pi in it.
>>
>
> Nice, I'll have a look at it when it gets merged and add a section for
> Orange Pi.
> I'll try to include that in the next version of this series.
>
>
>>
>> > +
>> > +Supported devices
>> > +-----------------
>> > +
>> > +The Orange Pi PC machine supports the following devices:
>> > +
>> > + * SMP (Quad Core Cortex A7)
>> > + * Generic Interrupt Controller configuration
>> > + * SRAM mappings
>> > + * SDRAM controller
>> > + * Real Time Clock
>> > + * Timer device (re-used from Allwinner A10)
>> > + * UART
>> > + * SD/MMC storage controller
>> > + * EMAC ethernet
>>
>> Do we ever exercise the ethernet in the acceptance tests? I see we have
>> some that boots a full OS but boot console only seems to touch the
>> serial console.
>>
>
> Good point. Currently in the acceptance tests U-Boot and Linux detect
> the ethernet device, but there are no explicit checks for that in the
> acceptance tests
> nor any actual packet transmission.
>
> I'll try to extend the current tests in the next version of this series t=
o
> include some
> basic checks for the ethernet device, perhaps with DHCP or a ping.
> I'm open to suggestions for the preferred way to do this.
>

FYI, I added some coverage for the ethernet device by extending the
test_arm_orangepi_sd test with a few lines like:

+        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up', 'eth0:
Link is Up')
+        exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
+                                                'udhcpc: lease of
10.0.2.15 obtained')
+        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
+            '3 packets transmitted, 3 packets received, 0% packet loss')

Regards,
Niek


> Regards,
> Niek
>
>
>
>
>
>
>>
>> <snip>
>>
>> --
>> Alex Benn=C3=A9e
>>
>
>
> --
> Niek Linnenbank
>
>

--=20
Niek Linnenbank

--00000000000081dc3505a0711c08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Alex,<br></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 4, 2020 at 9:55 PM Niek Linne=
nbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr"><div dir=3D"ltr">Hello Alex,<br></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 4, 2020 at =
11:35 AM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" tar=
get=3D"_blank">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><br>
Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_=
blank">nieklinnenbank@gmail.com</a>&gt; writes:<br>
<br>
&gt; The Xunlong Orange Pi PC machine is a functional ARM machine<br>
&gt; based on the Allwinner H3 System-on-Chip. It supports mainline<br>
&gt; Linux, U-Boot, NetBSD and is covered by acceptance tests.<br>
&gt;<br>
&gt; This commit adds a documentation text file with a description<br>
&gt; of the machine and instructions for the user.<br>
<br>
This is great, thanks for taking the time to include documentation.<br></bl=
ockquote><div><br></div><div>Sure, I&#39;m happy to contribute it. I tried =
to include most relevant information</div><div>in there for developers and =
potential users of the machine. If something is missing</div><div>just let =
me know and I&#39;ll make an update for it.<br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/orangepi.rst | 226<br>
&gt; ++++++++++++++++++++++++++++++++++++++++++++++<br>
<br>
I suspect there is a better place to put this is than the top level. I<br>
wonder if it should be docs/specs?<br></blockquote><div><br></div><div>Yeah=
 I&#39;m fine to move it to a different subdirectory if needed. Right now i=
ts placed in docs,</div><div>as it seems that documents for machines are al=
so placed there, for example docs/microvm.rst<br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 2 files changed, 227 insertions(+)<br>
&gt;=C2=A0 create mode 100644 docs/orangepi.rst<br>
&gt;<br>
&gt; diff --git a/docs/orangepi.rst b/docs/orangepi.rst<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..a9b46f553c<br>
&gt; --- /dev/null<br>
&gt; +++ b/docs/orangepi.rst<br>
&gt; @@ -0,0 +1,226 @@<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
&gt; +Orange Pi PC Machine Type<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
&gt; +<br>
&gt; +The Xunlong Orange Pi PC is an Allwinner H3 System on Chip<br>
&gt; +based embedded computer with mainline support in both U-Boot<br>
&gt; +and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,<br>
&gt; +1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and<br>
&gt; +various other I/O.<br>
<br>
When Peter&#39;s document PR goes in later this week there will also be a:<=
br>
<br>
=C2=A0 docs/system/target-arm.rst<br>
<br>
which would benefit from a section for the Orange Pi in it.<br></blockquote=
><div><br></div><div>Nice, I&#39;ll have a look at it when it gets merged a=
nd add a section for Orange Pi.</div><div>I&#39;ll try to include that in t=
he next version of this series.<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +Supported devices<br>
&gt; +-----------------<br>
&gt; +<br>
&gt; +The Orange Pi PC machine supports the following devices:<br>
&gt; +<br>
&gt; + * SMP (Quad Core Cortex A7)<br>
&gt; + * Generic Interrupt Controller configuration<br>
&gt; + * SRAM mappings<br>
&gt; + * SDRAM controller<br>
&gt; + * Real Time Clock<br>
&gt; + * Timer device (re-used from Allwinner A10)<br>
&gt; + * UART<br>
&gt; + * SD/MMC storage controller<br>
&gt; + * EMAC ethernet<br>
<br>
Do we ever exercise the ethernet in the acceptance tests? I see we have<br>
some that boots a full OS but boot console only seems to touch the<br>
serial console.<br></blockquote><div><br></div><div>Good point. Currently i=
n the acceptance tests U-Boot and Linux detect</div><div>the ethernet devic=
e, but there are no explicit checks for that in the acceptance tests</div><=
div>nor any actual packet transmission. <br></div><div><br></div><div>I&#39=
;ll try to extend the current tests in the next version of this series to i=
nclude some</div><div>basic checks for the ethernet device, perhaps with DH=
CP or a ping.</div><div>I&#39;m open to suggestions for the preferred way t=
o do this.<br></div></div></div></blockquote><div><br></div><div>FYI, I add=
ed some coverage for the ethernet device by extending the test_arm_orangepi=
_sd test with a few lines like:</div><div><br></div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0exec_command_and_wait_for_pattern(self, &#39;ifconfig eth0 up&=
#39;, &#39;eth0: Link is Up&#39;)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0exec_comm=
and_and_wait_for_pattern(self, &#39;udhcpc eth0&#39;,<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&#39;udhcpc: lease of 10.0.2.15 obtained&#39;)<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0exec_command_and_wait_for_pattern(self, &#39;ping -c 3 10.0.2.2&#=
39;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;3 packets transmitt=
ed, 3 packets received, 0% packet loss&#39;)<br></div><div>=C2=A0</div><div=
>Regards,</div><div>Niek<br></div><div><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div></=
div><div><br></div><div>Regards,</div><div>Niek<br></div><div><br></div><di=
v><br></div><br><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
&lt;snip&gt;<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000081dc3505a0711c08--

