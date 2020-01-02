Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4FBC3276C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 22:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9440421835
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 22:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be5RR40F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9440421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in8cu-0008BQ-Gd
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 17:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1in8bv-0006vY-Pi
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 17:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1in8bs-0002oz-0F
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 17:06:30 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a]:41053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1in8bq-0002m4-7w; Thu, 02 Jan 2020 17:06:26 -0500
Received: by mail-il1-x12a.google.com with SMTP id f10so35170942ils.8;
 Thu, 02 Jan 2020 14:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R0NxGTQSccVveKz1rKpEw/by0/GKdb9fm1wSFc0d/Gs=;
 b=Be5RR40Faf2BpjDHJIcBNI/JWBjFNx0EHJ/Mi6MJfSBaaqYWZiqvVNeuSNIAp8Hk6d
 Suiyb00nNr5DyfYtrS2ia7aCvW22LGPGV9dHyTHyVku55ju/qX8p1E5Qvx9lhqzyybeC
 MZ7ytI+SXJywrRz3nUpyV19fn/UVNWvDclAGMLx2uWO7rjJWAzd1K1viqcR0a4CX90/r
 esiYqljmIUiOf7nzAWySiz+0/NQUuZjV08IpGr+lboTSGmd2vH4FnVouncCjhJ5n88Dq
 zRyOMqy9JN/hpfIvekkW67gzK7ESshvBAPhSwErnZaICw6XXFL/p5RAXWs+4Zm1TIiDR
 aU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R0NxGTQSccVveKz1rKpEw/by0/GKdb9fm1wSFc0d/Gs=;
 b=ihSigAdV1wbDzCw9M60nWj+rUhgv/TFz24CrYBZIUTDeyyZ0l7yEatJyD1W5QXWghA
 ISOdP36o6UqPGCQKqj2Pkaj4VHZOXSkHJdc6xyVqmQh/0p6+NufZ06LYrOM/DG8ng/8K
 o/wtg8I0iHfG4nwnBjwsA212tRAHFZlI2kHY5k2N6+QItPrgEUUuRjG45CP/rBwO2Nxg
 oj9bbcY6n7oNHnu4R/h3soLbJhTRb8yLW/ofjoDtAc0kVsclPnmEEI3xWp5Jwn4W1957
 kMnUpLmY1x1ht8T3GMcuxKqFmqU9aqeAg94o+3Sh5v9BS1WUtEsSpYNod4jr3oYmGsk1
 sXTQ==
X-Gm-Message-State: APjAAAXKme2JF8QVnqhomtCpCQKbmlWJ29RrPJ2lXRCYa1etJcpxjwx7
 +GQznskqN+/a95khjz1vTa5pcq5PdSPjklXBhyw=
X-Google-Smtp-Source: APXvYqw4gyWUe/kxC8TQrDWIIsKazBf57uoYkeyM2NEh1rd/8mTgARpheTVTpYOg4JvFz66OhoPT5cKVkNWDrCYrWeg=
X-Received: by 2002:a92:7509:: with SMTP id q9mr49545228ilc.67.1578002784160; 
 Thu, 02 Jan 2020 14:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <CAPan3WpDbWb_cBMJPgokSLKAJndMQLvRdOav6CPpDbFv+ChN0g@mail.gmail.com>
 <9756419b-55bf-23a9-556a-d5bc5fb29331@redhat.com>
 <CAPan3WrYAK+PFtFM7ZDCVsKLc_ksGxZeHEcwB9_FK=4v5p8h=w@mail.gmail.com>
 <CAPan3WoP8MYubKaArOuWVCo65iOYNc2TpQ8KA0f_wRZwLATMAA@mail.gmail.com>
 <f331fe6e-87ce-4f04-cdc0-981281e53c9b@redhat.com>
In-Reply-To: <f331fe6e-87ce-4f04-cdc0-981281e53c9b@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 2 Jan 2020 23:06:13 +0100
Message-ID: <CAPan3WrhOdaTxKm0nVMa6XByp2VqGg5a9dgv7q4o-4bCbUTk6w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000679261059b2f67d5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12a
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000679261059b2f67d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Philippe,

On Thu, Jan 2, 2020 at 10:11 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Niek,
>
> On 1/2/20 8:52 PM, Niek Linnenbank wrote:
> > Hi Philippe,
> >
> > I'm almost ready to send out v3 here.
> >
> > Now for documentation I'm not sure yet what to do:
> >
> > 1) Where should I place board documentation?
> >      For example, the information that I wrote on the cover letter with
> > instructions on how to get the board up and running,
> >      some description of the design, where to find more inforformation,
> > datasheet sources, etc. I don't yet see any documentation
>
> We usually refer the datasheet in the implementation header, see:
>
> $ git grep -F .pdf hw/ | wc -l
> 62
>
> You can cite the datasheet globally in hw/arm/allwinner-h3.c, and then
> the particular chapters or source files in the other hw/*/allwinner-*
> files.
>
> >     for the other boards in the source. In my opinion, it is important
> > to keep that information somewhere, such that also in the future
> >     the boards can still be properly maintained. Can I / shall I place =
a
> > new file like ./docs/hw/arm/orangepi.txt for that?
>
> See docs/microvm.rst which is a recent example of machine documentation,
> the obvious name is docs/orangepi.rst.
>
> Ah great, that is very helpful! I will use the microvm.rst as example and
add a new file docs/orangepi.rst to document the board.


> Maybe refer to this file in hw/arm/orangepi.c header for completeness.
>
> >   2) Is is allowed / encouraged to provide Doxygen-style comments in th=
e
> > header files in include/hw/*?
> >     I see that some of the API's have that, but the boards and devices
> > mostly are free of Doxygen-style comments.
> >     It takes some work, but I think it can really help to give more
> > insight / background info on how things are working
> >     for the devices and boards. But if it's not preferred for QEMU, I'm
> > fine with that as well.
>
> Documentation is certainly welcome!
>
> There are 2 different schools over the codebase, one that document the
> declarations, and another that documents the implementation/definition.
>
> I personally prefer to document the headers, which is where I look when
> I want to consume an API.
> The implementation school says this can lead to documentation getting
> outdated.
>
> So if you are willing to document, I'd suggest to document your
> include/hw/ files.
>

OK, thanks for clarifying! Yes, I also prefer to have it in the header
files, it
makes the most sense indeed.


>
> Happy new year!
>

And happy new year to you as well Philippe!

Regards,
Niek

>
> Phil.
>
> > On Mon, Dec 30, 2019 at 9:10 PM Niek Linnenbank
> > <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>> wrote:
> >
> >
> >
> >     On Mon, Dec 30, 2019 at 3:56 PM Philippe Mathieu-Daud=C3=A9
> >     <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >         On 12/30/19 12:28 PM, Niek Linnenbank wrote:
> >          > Hi,
> >          >
> >          > Here a short status report of this patch series.
> >
> >         Good idea!
> >
> >          >
> >          > For V3 update I already prepared the following:
> >          >   - reworked all review comments from Philippe, except:
> >          >     - patch#8: question for the SID, whether command-line
> >         override is
> >          > required (and how is the best way for machine-specific cli
> >         arg?) [1]
> >
> >         Answered recently.
> >
> >     Thanks!
> >
> >
> >          > - added BootROM support, allows booting with only specifying
> >         -sd <IMG>
> >          > - added SDRAM controller driver, for U-Boot SPL
> >          > - added Allwinner generic RTC driver (for both Cubieboard an=
d
> >         OrangePi
> >          > PC, supports sun4i, sun6i, sun7i)
> >          > - small fixes for EMAC
> >          >
> >          > My current TODO:
> >          >   - integrate Philips acceptance tests in the series
> >
> >         You can queue them in your series, adding your Signed-off-by ta=
g
> >         after
> >         mine. See:
> >
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#si=
gn-your-work-the-developer-s-certificate-of-origin
> >
> >             The sign-off is a simple line at the end of the explanation
> >         for the
> >         patch, which certifies that you wrote it or otherwise have the
> >         right to
> >         pass it on as an open-source patch.
> >
> >         See point (c).
> >
> >     Ah that certainly helps. I'll read that page.
> >
> >          >   - integrate Philips work for generalizing the Allwinner
> >         timer, and
> >          > finish it
> >
> >         We can also do that later, and get your work merged first.
> >
> >
> >     Ok that sounds very good! Agreed, lets do the timer work later.
> >
> >
> >          >   - test and fix BSD targets (NetBSD, FreeBSD) [2, 3]
> >          >   - further generalize the series to cover very similar SoCs=
:
> >         H2+, H5
> >          >
> >          > Does anyone have more comments/requests for the V3 update?
> >          >
> >          > [1]
> >
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04049.html
> >          > [2] https://wiki.netbsd.org/ports/evbarm/allwinner/
> >          > [3]
> >          >
> >
> https://wiki.freebsd.org/action/show/arm/Allwinner?action=3Dshow&redirect=
=3DFreeBSD%2Farm%2FAllwinner
> >
> >
> >
> >     --
> >     Niek Linnenbank
> >
> >
> >
> > --
> > Niek Linnenbank
> >
>
>

--=20
Niek Linnenbank

--000000000000679261059b2f67d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey Philippe,<br></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 2, 2020 at 10:11 PM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hi Niek,<br>
<br>
On 1/2/20 8:52 PM, Niek Linnenbank wrote:<br>
&gt; Hi Philippe,<br>
&gt; <br>
&gt; I&#39;m almost ready to send out v3 here.<br>
&gt; <br>
&gt; Now for documentation I&#39;m not sure yet what to do:<br>
&gt; <br>
&gt; 1) Where should I place board documentation?<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 For example, the information that I wrote on =
the cover letter with <br>
&gt; instructions on how to get the board up and running,<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 some description of the design, where to find=
 more inforformation, <br>
&gt; datasheet sources, etc. I don&#39;t yet see any documentation<br>
<br>
We usually refer the datasheet in the implementation header, see:<br>
<br>
$ git grep -F .pdf hw/ | wc -l<br>
62<br>
<br>
You can cite the datasheet globally in hw/arm/allwinner-h3.c, and then <br>
the particular chapters or source files in the other hw/*/allwinner-* files=
.<br>
<br>
&gt;=C2=A0 =C2=A0=C2=A0 for the other boards in the source. In my opinion, =
it is important <br>
&gt; to keep that information somewhere, such that also in the future<br>
&gt;=C2=A0 =C2=A0=C2=A0 the boards can still be properly maintained. Can I =
/ shall I place a <br>
&gt; new file like ./docs/hw/arm/orangepi.txt for that?<br>
<br>
See docs/microvm.rst which is a recent example of machine documentation,<br=
>
the obvious name is docs/orangepi.rst.<br>
<br></blockquote><div>Ah great, that is very helpful! I will use the microv=
m.rst as example and</div><div>add a new file docs/orangepi.rst to document=
 the board.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
Maybe refer to this file in hw/arm/orangepi.c header for completeness.<br>
<br>
&gt;=C2=A0 =C2=A02) Is is allowed / encouraged to provide Doxygen-style com=
ments in the <br>
&gt; header files in include/hw/*?<br>
&gt;=C2=A0 =C2=A0=C2=A0 I see that some of the API&#39;s have that, but the=
 boards and devices <br>
&gt; mostly are free of Doxygen-style comments.<br>
&gt;=C2=A0 =C2=A0=C2=A0 It takes some work, but I think it can really help =
to give more <br>
&gt; insight / background info on how things are working<br>
&gt;=C2=A0 =C2=A0=C2=A0 for the devices and boards. But if it&#39;s not pre=
ferred for QEMU, I&#39;m <br>
&gt; fine with that as well.<br>
<br>
Documentation is certainly welcome!<br>
<br>
There are 2 different schools over the codebase, one that document the <br>
declarations, and another that documents the implementation/definition.<br>
<br>
I personally prefer to document the headers, which is where I look when <br=
>
I want to consume an API.<br>
The implementation school says this can lead to documentation getting <br>
outdated.<br>
<br>
So if you are willing to document, I&#39;d suggest to document your <br>
include/hw/ files.<br></blockquote><div><br></div><div>OK, thanks for clari=
fying! Yes, I also prefer to have it in the header files, it</div><div>make=
s the most sense indeed.<br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
Happy new year!<br></blockquote><div><br></div><div>And happy new year to y=
ou as well Philippe!</div><div><br></div><div>Regards,</div><div>Niek<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Phil.<br>
<br>
&gt; On Mon, Dec 30, 2019 at 9:10 PM Niek Linnenbank <br>
&gt; &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">niek=
linnenbank@gmail.com</a> &lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.=
com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Mon, Dec 30, 2019 at 3:56 PM Philippe Mathieu-Da=
ud=C3=A9<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:philmd@redhat.com" target=3D"=
_blank">philmd@redhat.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.co=
m" target=3D"_blank">philmd@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 12/30/19 12:28 PM, Niek Linnenbank=
 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Here a short status report of t=
his patch series.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Good idea!<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; For V3 update I already prepare=
d the following:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0- reworked all revi=
ew comments from Philippe, except:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0 - patch#8: q=
uestion for the SID, whether command-line<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0override is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; required (and how is the best w=
ay for machine-specific cli<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg?) [1]<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Answered recently.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks!<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; - added BootROM support, allows=
 booting with only specifying<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-sd &lt;IMG&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; - added SDRAM controller driver=
, for U-Boot SPL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; - added Allwinner generic RTC d=
river (for both Cubieboard and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OrangePi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; PC, supports sun4i, sun6i, sun7=
i)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; - small fixes for EMAC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; My current TODO:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0- integrate Philips=
 acceptance tests in the series<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0You can queue them in your series, ad=
ding your Signed-off-by tag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0after<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mine. See:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.kernel.org/doc=
/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s=
-certificate-of-origin" rel=3D"noreferrer" target=3D"_blank">https://www.ke=
rnel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the=
-developer-s-certificate-of-origin</a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The sign-off is a simpl=
e line at the end of the explanation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0patch, which certifies that you wrote=
 it or otherwise have the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0right to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass it on as an open-source patch.<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0See point (c).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Ah that certainly helps. I&#39;ll read that page.<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0- integrate Philips=
 work for generalizing the Allwinner<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timer, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; finish it<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0We can also do that later, and get yo=
ur work merged first.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Ok that sounds very good! Agreed, lets do the timer=
 work later.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0- test and fix BSD =
targets (NetBSD, FreeBSD) [2, 3]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0- further generaliz=
e the series to cover very similar SoCs:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0H2+, H5<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Does anyone have more comments/=
requests for the V3 update?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; [1]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.gnu.org/arch=
ive/html/qemu-devel/2019-12/msg04049.html" rel=3D"noreferrer" target=3D"_bl=
ank">https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04049.html</a=
><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; [2] <a href=3D"https://wiki.net=
bsd.org/ports/evbarm/allwinner/" rel=3D"noreferrer" target=3D"_blank">https=
://wiki.netbsd.org/ports/evbarm/allwinner/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; [3]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://wiki.freebsd.org/a=
ction/show/arm/Allwinner?action=3Dshow&amp;redirect=3DFreeBSD%2Farm%2FAllwi=
nner" rel=3D"noreferrer" target=3D"_blank">https://wiki.freebsd.org/action/=
show/arm/Allwinner?action=3Dshow&amp;redirect=3DFreeBSD%2Farm%2FAllwinner</=
a><br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0Niek Linnenbank<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Niek Linnenbank<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000679261059b2f67d5--

