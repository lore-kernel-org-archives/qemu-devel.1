Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165C4C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 20:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D009420842
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 20:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r732cWA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D009420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9b3r-0006Um-0M
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 15:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j9b3B-00064M-Cw
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 15:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j9b39-0006vH-Sy
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 15:55:29 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j9b39-0006u5-Mu; Wed, 04 Mar 2020 15:55:27 -0500
Received: by mail-io1-xd44.google.com with SMTP id u17so3954510iog.11;
 Wed, 04 Mar 2020 12:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tCYBHibbb2c0kOq2/NWI7/bnXq/tZU8evQiteP6O2K4=;
 b=r732cWA/FW4udgN24NkT+TgnhylOuXn7dTbT0Nkko6aPS3TM4c2zlJpOXiHIhYzAQP
 gUmkWK+P4OK8bADvQEOBuOMLJnmNeCzpH2Spm7N+Tmt64C9kLMJZPLAwTT+ELsuyUV4S
 32R6+yNY5b5XFEnxMp/h3fXESkKu8q8yY3Dqr+GqnNH4I5Lpas2OLqwwcoT/TFBJFIso
 B1WrFh4T/D4GQ7JOaGM42cmnu9UlDnnwcFtBDb3APxA8wKOYdI61ivJ41+AfwvJTWB5A
 Vp62+jTtiEAm1lI3K4lSa1CVNgJKFE7xdQIPPTIHt0gr5HpegGvtSz8wZWgv+AZoFpu3
 U2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tCYBHibbb2c0kOq2/NWI7/bnXq/tZU8evQiteP6O2K4=;
 b=EH3tnQxbwt+YRj1HJSzQ4zw1540qXzZWpVyF+PGA92NG/TB8IMA3nvMSqa6ar02K03
 IGMv1vJ+fxAYhjEXELPPsolS9DLVXJMAG8TgUlM3A05KwILbWXWb5i4/Aja2HSldfOZd
 3TOsrWT6s1wBuL2QDdEDM5cmRKlgv3svUnzZ/l2ZEoMz08FlPr05XzIVwg0xbbrX5D3v
 +OQldcPdwDYVlcyRCE4QvZkdacKMN0JlAsU5I8DhuGcume/6XxspJfS5N1ps/OnyrLMQ
 Ni/Fun0ybz8xtU4ODvcf2Qt91DuBzko2mP3OvI5GFRyWHCl1RBC2jZC16Btalrk/ggdP
 5AHg==
X-Gm-Message-State: ANhLgQ1m0E/3+xgFwyZSMTOochGnxXt6wULy2huP9Vm7ccu6suwC6OwO
 /Kc/KMKpCRO/Sg8zL0tJsWJd32kVuMipCX+OX0U=
X-Google-Smtp-Source: ADFU+vvAe2J/yt+oGJMdKuj5frcC9FF8UYgN931ICOso9gqaBMCyOMhNuzoKppvy6DpiTkBFEuuWuInHg48CejvWCSs=
X-Received: by 2002:a6b:b7d8:: with SMTP id h207mr3594261iof.306.1583355326852; 
 Wed, 04 Mar 2020 12:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
In-Reply-To: <871rq876h3.fsf@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 4 Mar 2020 21:55:15 +0100
Message-ID: <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cf72ba05a00da3b1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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

--000000000000cf72ba05a00da3b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alex,

On Wed, Mar 4, 2020 at 11:35 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>
> > The Xunlong Orange Pi PC machine is a functional ARM machine
> > based on the Allwinner H3 System-on-Chip. It supports mainline
> > Linux, U-Boot, NetBSD and is covered by acceptance tests.
> >
> > This commit adds a documentation text file with a description
> > of the machine and instructions for the user.
>
> This is great, thanks for taking the time to include documentation.
>

Sure, I'm happy to contribute it. I tried to include most relevant
information
in there for developers and potential users of the machine. If something is
missing
just let me know and I'll make an update for it.


>
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >  docs/orangepi.rst | 226
> > ++++++++++++++++++++++++++++++++++++++++++++++
>
> I suspect there is a better place to put this is than the top level. I
> wonder if it should be docs/specs?
>

Yeah I'm fine to move it to a different subdirectory if needed. Right now
its placed in docs,
as it seems that documents for machines are also placed there, for example
docs/microvm.rst


>
> >  MAINTAINERS       |   1 +
> >  2 files changed, 227 insertions(+)
> >  create mode 100644 docs/orangepi.rst
> >
> > diff --git a/docs/orangepi.rst b/docs/orangepi.rst
> > new file mode 100644
> > index 0000000000..a9b46f553c
> > --- /dev/null
> > +++ b/docs/orangepi.rst
> > @@ -0,0 +1,226 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +Orange Pi PC Machine Type
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> > +based embedded computer with mainline support in both U-Boot
> > +and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> > +1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> > +various other I/O.
>
> When Peter's document PR goes in later this week there will also be a:
>
>   docs/system/target-arm.rst
>
> which would benefit from a section for the Orange Pi in it.
>

Nice, I'll have a look at it when it gets merged and add a section for
Orange Pi.
I'll try to include that in the next version of this series.


>
> > +
> > +Supported devices
> > +-----------------
> > +
> > +The Orange Pi PC machine supports the following devices:
> > +
> > + * SMP (Quad Core Cortex A7)
> > + * Generic Interrupt Controller configuration
> > + * SRAM mappings
> > + * SDRAM controller
> > + * Real Time Clock
> > + * Timer device (re-used from Allwinner A10)
> > + * UART
> > + * SD/MMC storage controller
> > + * EMAC ethernet
>
> Do we ever exercise the ethernet in the acceptance tests? I see we have
> some that boots a full OS but boot console only seems to touch the
> serial console.
>

Good point. Currently in the acceptance tests U-Boot and Linux detect
the ethernet device, but there are no explicit checks for that in the
acceptance tests
nor any actual packet transmission.

I'll try to extend the current tests in the next version of this series to
include some
basic checks for the ethernet device, perhaps with DHCP or a ping.
I'm open to suggestions for the preferred way to do this.

Regards,
Niek






>
> <snip>
>
> --
> Alex Benn=C3=A9e
>


--=20
Niek Linnenbank

--000000000000cf72ba05a00da3b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Alex,<br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 4, 2020 at 11:=
35 AM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.b=
ennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><br>
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
o do this.<br></div><div><br></div><div>Regards,</div><div>Niek<br></div><d=
iv><br></div><div><br></div><br><div><br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
&lt;snip&gt;<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000cf72ba05a00da3b1--

