Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E4BC32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 23:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B406246AC
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 23:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8Kw9nfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B406246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isxXY-0000cN-DO
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 18:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isxWe-0008MR-Jk
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 18:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isxWc-0007ZH-QZ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 18:29:08 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:43034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isxWc-0007X3-Hn; Sat, 18 Jan 2020 18:29:06 -0500
Received: by mail-il1-x143.google.com with SMTP id v69so24357347ili.10;
 Sat, 18 Jan 2020 15:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zw3S/Be/mVikt/giv2OItRvu2uInDpVhbCy9MsAMSi0=;
 b=g8Kw9nfbYpvuzL4FiZwgpm2eUBOgzD2A1k9wt227ZbYz1rQ0b9bkZgLdATuTRk5mfW
 S08dUAxXazljkmdEouQv4C0jJLWe7x7ZpBFMJnPjP8bUYmtDMS/QKc0vh1Xq+T1Jw+55
 C7SSvv/uA0yN1Y28IjqDrIhtnSmFEPIDHsFCzYB+aAlzK2c7WVCgt4dhyWcwXz2JQCS/
 bDpPSipPcsXkDbqun/FP+40ayCBwoaHb74ITaCOfjExBWg7THwk3WPlO7k37TDa/bd+y
 233ALH434xwEGUgOMmqv9NyNhHnECYl2TQIob7/9/zQk7pAL8hkZMqaR+oKkdzqBkwOD
 qSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zw3S/Be/mVikt/giv2OItRvu2uInDpVhbCy9MsAMSi0=;
 b=ICwfjygYUP0h5qxnjl+jl22fxU3vXLBGDSJdrBlKu1J4HkXXIarPUmykTB+PUnTYHg
 NA370Ul0mwU3E3tFJcY14ueMi9hmVJHttQjIjGDiHG7x6zZQKpdHBr5K2T4NwMosjf2a
 e3iQl+CiAGEzi9GwvQYiiMcuto1r0uuF9uZJFxRDwvw6bFlcaplf2Np+LWQbCook+LcI
 5b80O/hi+CARNEQ5IqUuGQ9W/4nihqoIUKuEDqbThP0b9iNUbHHCnlKxwrYvHs/Z4lWt
 ZpuHsrY9vdBaHU5NCGWyLPsP6SW1LCsaTwM54micjeXa4bvy9qI0nRbm8lXWO8v6r2Lk
 RlJw==
X-Gm-Message-State: APjAAAWFIn+MMJkBbhopaK7lni1zLmuPf8EAOVxwPw3g3erUAT6VkmqL
 QAkZw5tuSdvDDFPismvGKLe8Bmx1u7IaxT31hXs=
X-Google-Smtp-Source: APXvYqxinQr2qEIEaWesS3c9BMnUV35iKVxtpas6hyXSzbSzv187ERFWdRJbt6yGjKbBSD5PfaQg/D8XZx1Jn92Xsnc=
X-Received: by 2002:a92:af08:: with SMTP id n8mr4581175ili.217.1579390145788; 
 Sat, 18 Jan 2020 15:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-4-nieklinnenbank@gmail.com>
 <CAPan3Woz1KdHpPA87ZfgzF+GE=RGOFDGdpDD3aMVkuUJwNSQNA@mail.gmail.com>
 <6dda3ab6-f537-8864-55ef-20d5d523f416@redhat.com>
In-Reply-To: <6dda3ab6-f537-8864-55ef-20d5d523f416@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 19 Jan 2020 00:28:54 +0100
Message-ID: <CAPan3WpJjA1c08qbWBm7pvkvdmBV5mouCNwT9A5NSX96gBSiPQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] hw/arm/allwinner-h3: add Clock Control Unit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009a008a059c726cb4"
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Taylor Simpson <tsimpson@quicinc.com>,
 qemu-arm <qemu-arm@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009a008a059c726cb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Sat, Jan 18, 2020 at 4:37 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Niek,
>
> On 1/13/20 8:18 PM, Niek Linnenbank wrote:
> > Hi,
> >
> > Just a friendly reminder for review of this patch and the others in thi=
s
> > series
> > that don't yet have a reviewed-by tag :-)
>
> You are right to ping the list after a week.
>
> Cc'ing Damien for this particular patch, he might have good advises.
>
>
> Looking at the stats from your cover:
>
>   include/hw/arm/allwinner-h3.h          | 164 +++++
>   include/hw/misc/allwinner-cpucfg.h     |  54 ++
>   include/hw/misc/allwinner-h3-ccu.h     |  67 ++
>   include/hw/misc/allwinner-h3-dramc.h   | 107 +++
>   include/hw/misc/allwinner-h3-sysctrl.h |  68 ++
>   include/hw/net/allwinner-sun8i-emac.h  | 103 +++
>   include/hw/rtc/allwinner-rtc.h         | 129 ++++
>   include/hw/sd/allwinner-sdhost.h       | 136 ++++
>   hw/arm/allwinner-h3.c                  | 477 ++++++++++++++
>   hw/arm/orangepi.c                      | 125 ++++
>   hw/misc/allwinner-cpucfg.c             | 282 ++++++++
>   hw/misc/allwinner-h3-ccu.c             | 243 +++++++
>   hw/misc/allwinner-h3-dramc.c           | 358 ++++++++++
>   hw/misc/allwinner-h3-sysctrl.c         | 140 ++++
>   hw/misc/allwinner-sid.c                | 170 +++++
>   hw/net/allwinner-sun8i-emac.c          | 871 +++++++++++++++++++++++++
>   hw/rtc/allwinner-rtc.c                 | 386 +++++++++++
>   hw/sd/allwinner-sdhost.c               | 848 ++++++++++++++++++++++++
>
>   39 files changed, 5267 insertions(+), 2 deletions(-)
>
> This is a LOT of code to process, keep in mind your series touches
> different subsystems with different maintainers. It is hard to know all
> of them in details.
>
> Yes, true indeed. I'll be patient and wait for more feedback when it come=
s.


> Since your SoC is in the same family than the A10, I've Cc'ed Beniamino
> Galvani. You should Cc him in your v4, hopefully he can help reviewing.
>
> OK good idea. I'll add Beniamino in CC for v4!


> Regarding the System Control Unit and SDRAM Controller, as I don't know
> this SoC so I have to digest the whole datasheet, so it takes me time,
> bare with me (I'm using my hobby time to review your work).
>
> Yes the SDRAM controller is something that needs a good read to understan=
d
it,
especially also in the U-Boot sources which is using it. No hurry there, I
very much
appreciate all the time you already took for reviewing this series. It
encourages me
to continue with it as well. I'm also doing this work in my hobby time.


> The last patch I plan to review in your series is the SD/MMC one:
>   10 files changed, 1053 insertions(+), 2 deletions(-)
>
> It is 1/5th of your series in a single patch, each time I try to look at
> it I get scared. Anyway today I could test NetBSD booting from a SD card
> so I am more confident.
>
>
Thanks for testing that Philippe! Yes the SD/MMC host device is indeed
relatively large compared to the other patches.


> Anyway, don't forget this comment from the New Contribution page:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor
>
>    Peer review only works if everyone chips in a bit of review time.
>    If everyone submitted more patches than they reviewed, we would
>    have a patch backlog. A good goal is to try to review at least
>    as many patches from others as what you submit.
>
> With the quality of your patches, even if this is your first
> contribution, it is obvious you now understand various part of QEMU.
> Don't be shy to look at other patches on the list and help the
> community, as the reviewed authors might review you back :)
>
> Thanks for reminding about that. You are right, indeed I should start
reviewing
other patches as well to return the favor and help others.

Regards,
Niek

That said, your series is almost there!

Regards,
>
> Phil.
>
> >
> > Regards,
> > Niek
>
>

--=20
Niek Linnenbank

--0000000000009a008a059c726cb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 18, 2020 at 4:37 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi Niek,<br>
<br>
On 1/13/20 8:18 PM, Niek Linnenbank wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; Just a friendly reminder for review of this patch and the others in th=
is <br>
&gt; series<br>
&gt; that don&#39;t yet have a reviewed-by tag :-)<br>
<br>
You are right to ping the list after a week.<br>
<br>
Cc&#39;ing Damien for this particular patch, he might have good advises.<br=
>
<br>
<br>
Looking at the stats from your cover:<br>
<br>
=C2=A0 include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 16=
4 +++++<br>
=C2=A0 include/hw/misc/allwinner-cpucfg.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 54 ++<=
br>
=C2=A0 include/hw/misc/allwinner-h3-ccu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 67 ++<=
br>
=C2=A0 include/hw/misc/allwinner-h3-dramc.h=C2=A0 =C2=A0| 107 +++<br>
=C2=A0 include/hw/misc/allwinner-h3-sysctrl.h |=C2=A0 68 ++<br>
=C2=A0 include/hw/net/allwinner-sun8i-emac.h=C2=A0 | 103 +++<br>
=C2=A0 include/hw/rtc/allwinner-rtc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12=
9 ++++<br>
=C2=A0 include/hw/sd/allwinner-sdhost.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 136 +++=
+<br>
=C2=A0 hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 477 ++++++++++++++<br>
=C2=A0 hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 125 ++++<br>
=C2=A0 hw/misc/allwinner-cpucfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 282 ++++++++<br>
=C2=A0 hw/misc/allwinner-h3-ccu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 243 +++++++<br>
=C2=A0 hw/misc/allwinner-h3-dramc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 358 ++++++++++<br>
=C2=A0 hw/misc/allwinner-h3-sysctrl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14=
0 ++++<br>
=C2=A0 hw/misc/allwinner-sid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 170 +++++<br>
=C2=A0 hw/net/allwinner-sun8i-emac.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 87=
1 +++++++++++++++++++++++++<br>
=C2=A0 hw/rtc/allwinner-rtc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 386 +++++++++++<br>
=C2=A0 hw/sd/allwinner-sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 848 ++++++++++++++++++++++++<br>
<br>
=C2=A0 39 files changed, 5267 insertions(+), 2 deletions(-)<br>
<br>
This is a LOT of code to process, keep in mind your series touches <br>
different subsystems with different maintainers. It is hard to know all <br=
>
of them in details.<br>
<br></blockquote><div>Yes, true indeed. I&#39;ll be patient and wait for mo=
re feedback when it comes.</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
Since your SoC is in the same family than the A10, I&#39;ve Cc&#39;ed Benia=
mino <br>
Galvani. You should Cc him in your v4, hopefully he can help reviewing.<br>
<br></blockquote><div>OK good idea. I&#39;ll add Beniamino in CC for v4!<br=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Regarding the System Control Unit and SDRAM Controller, as I don&#39;t know=
 <br>
this SoC so I have to digest the whole datasheet, so it takes me time, <br>
bare with me (I&#39;m using my hobby time to review your work).<br>
<br></blockquote><div>Yes the SDRAM controller is something that needs a go=
od read to understand it,</div><div>especially also in the U-Boot sources w=
hich is using it. No hurry there, I very much</div><div>appreciate all the =
time you already took for reviewing this series. It encourages me</div><div=
>to continue with it as well. I&#39;m also doing this work in my hobby time=
.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
The last patch I plan to review in your series is the SD/MMC one:<br>
=C2=A0 10 files changed, 1053 insertions(+), 2 deletions(-)<br>
<br>
It is 1/5th of your series in a single patch, each time I try to look at <b=
r>
it I get scared. Anyway today I could test NetBSD booting from a SD card <b=
r>
so I am more confident.<br>
<br></blockquote><div><br></div><div>Thanks for testing that Philippe! Yes =
the SD/MMC host device is indeed</div><div>relatively large compared to the=
 other patches.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
Anyway, don&#39;t forget this comment from the New Contribution page:<br>
<a href=3D"https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor" =
rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/Contribute/Submi=
tAPatch#Return_the_favor</a><br>
<br>
=C2=A0 =C2=A0Peer review only works if everyone chips in a bit of review ti=
me.<br>
=C2=A0 =C2=A0If everyone submitted more patches than they reviewed, we woul=
d<br>
=C2=A0 =C2=A0have a patch backlog. A good goal is to try to review at least=
<br>
=C2=A0 =C2=A0as many patches from others as what you submit.<br>
<br>
With the quality of your patches, even if this is your first <br>
contribution, it is obvious you now understand various part of QEMU.<br>
Don&#39;t be shy to look at other patches on the list and help the <br>
community, as the reviewed authors might review you back :)<br>
<br></blockquote><div>Thanks for reminding about that. You are right, indee=
d I should start reviewing</div><div>other patches as well to return the fa=
vor and help others.<br></div><div><br></div><div>Regards,</div><div>Niek<b=
r></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
That said, your series is almost there!</blockquote><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
Regards,<br>
<br>
Phil.<br>
<br>
&gt; <br>
&gt; Regards,<br>
&gt; Niek<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000009a008a059c726cb4--

