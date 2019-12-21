Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E22C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 12:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0C72070C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 12:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzoXBwAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0C72070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iidUr-0006us-IM
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 07:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iidUA-0006Oc-0h
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 07:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iidU8-0003h1-Ci
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 07:03:53 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iidU7-0003b0-Vh; Sat, 21 Dec 2019 07:03:52 -0500
Received: by mail-ot1-x343.google.com with SMTP id w21so7754740otj.7;
 Sat, 21 Dec 2019 04:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=uM60FLfWItZ2H12vNMdK31k4/HMlT2W6hNndX4nQuXk=;
 b=BzoXBwAPISbLKvvV4csf2S3K7e0+4LxqJzrkkIoyU5E8oheOxg/3qRZ+jPT0JJyu5C
 UZeaIPHUjrxVKagcy1IZFfxmzR8i4S3IGjlCfYzu7bwbg0pbR7d1gGGa87Niva64o91B
 PTfq1M9TyFqGqJcOmelh0+z5ISI2utlbcLBzxxKOtsJPt0Fs6rwrzCBMOZotUCsU8x1Q
 XvBESybfVXa03XJ4Uj30rLs6EKipyOBuSfudSKoXMup+2EJ8H70BygoEHauakPMY8rgl
 oll2Qwq/Ibon9U9YjmTcTbIMOm26t6GRMvos/T+lKcnIs1dGmjyyMMX4utJxh1DtZmfo
 Vtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=uM60FLfWItZ2H12vNMdK31k4/HMlT2W6hNndX4nQuXk=;
 b=QvbsJePkcSlQmXgrX1VZOfiWRfDFTectd1KqwTCbQjsdSwbymzdJpnxqr/OEgSUQjV
 +4uOGKj0oQYV2VcwUBXerELQPs5h7b5oXiQ5QQ3aJS98OtjMlARWDhj0YPzF7nQEqv2u
 0uyk1n+Q7ldvv92lNuBljMNgw4fdc8yDOuqM+KI8H7j5kGQuSA67hzS5pMMqot8ED79d
 DwnTDM6BQWHpzQGATBm4x9MnGug9wjtbIyigA6cjfKS3QlX0zFMF+5G4H72DL62tQLf4
 P1eDHWYm0dMu3kVzaMSSjwn+2hvxH20+42zVjcob8nj26R7VDAU3knGX6NuSrsOnLJuT
 zGag==
X-Gm-Message-State: APjAAAX8UWKTwBFQGYw9gDYQhBSO57Y6MjuqhDkEJCK0RjIKqwpiDDnU
 7WBi39t6ZCDQCUz8bV59g5cwoRd1E9j+gfhdamjirA==
X-Google-Smtp-Source: APXvYqyWaeCSKptsu57fjknHip1e17+ldo7wCpLN4Sdyl21ZexP5Cx50epyci40Ku1LF/Rckz8SLWTdjbtXDTyjgbS4=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr19717277otk.64.1576929830544; 
 Sat, 21 Dec 2019 04:03:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 21 Dec 2019 04:03:49 -0800 (PST)
In-Reply-To: <alpine.LNX.2.21.1.1912210941150.53@nippy.intranet>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=jN-8zEnCvxq4actoBcrjBviqfxBjGCTT7mBxmSPhiF3w@mail.gmail.com>
 <067319c3-b426-bb83-56da-6612180d35c5@vivier.eu>
 <alpine.LNX.2.21.1.1912210941150.53@nippy.intranet>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 21 Dec 2019 13:03:49 +0100
Message-ID: <CAL1e-=iz8VDjYkObcsid6eKimH+a62Ttk5f+=2xoFGVgpg-EdQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: multipart/alternative; boundary="00000000000062a8f3059a359640"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Herve Poussineau <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000062a8f3059a359640
Content-Type: text/plain; charset="UTF-8"

On Saturday, December 21, 2019, Finn Thain <fthain@telegraphics.com.au>
wrote:

> On Fri, 20 Dec 2019, Laurent Vivier wrote:
>
> > Le 20/12/2019 ? 12:38, Aleksandar Markovic a ?crit?:
> > > On Sat, Dec 14, 2019 at 2:29 AM Finn Thain <fthain@telegraphics.com.au>
> wrote:
> > >>
> > >> Hi All,
> > >>
> > >> There is a bug in the DP8393X emulation that can stop packet
> reception.
> > >>
> > >> Whilst debugging that issue I found that the receiver algorithm
> differs
> > >> from the one described in the National Semiconductor datasheet.
> > >>
> > >
> > > Finn, could you please provide the link to the exact datasheet that
> > > you used for reference, so that we are on the same page while looking
> > > at your code?
> >
> > According to his comments ,"National Semiconductor DP83932C" and
> > sections seem to be the same, I think the datasheet is:
> >
> > https://www.eit.lth.se/fileadmin/eit/courses/datablad/Periphery/
> Communication/DP83932C.pdf
> >
>
> Yes. I know of 3 datasheets from National Semiconductor,
>
> 11719  DP83934CVUL-20/25 MHz SONIC-T Systems-Oriented Network Interface
> Controller with Twisted Pair Interface
> 10492  DP83932C-20/25/33 MHz SONIC Systems-Oriented Network Interface
> Controller
> 11722  DP83916 SONIC-16 Systems-Oriented Network Interface Controller
>
> The publication numbered 10492 is the one that Laurent linked to. It and
> 11722 both have the same table of contents. The references I gave in the
> patch descriptions are applicable to these. (Having said that, I see now
> that I did mess up one reference. I'll fix it.)
>
> The "1995 National Ethernet Databook" on bitsavers has more information.
> https://mirrorservice.org/sites/www.bitsavers.org/components/national/_
> dataBooks/1995_National_Ethernet_Databook.pdf
>
> --


Finn,

I truly appreciate your detailed response.

Aleksandar


> > Thanks,
> > Laurent
> >
>

--00000000000062a8f3059a359640
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, December 21, 2019, Finn Thain &lt;<a href=3D"mailto:ft=
hain@telegraphics.com.au">fthain@telegraphics.com.au</a>&gt; wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On Fri, 20 Dec 2019, Laurent Vivier wrote:<br>
<br>
&gt; Le 20/12/2019 ? 12:38, Aleksandar Markovic a ?crit?:<br>
&gt; &gt; On Sat, Dec 14, 2019 at 2:29 AM Finn Thain &lt;<a href=3D"mailto:=
fthain@telegraphics.com.au">fthain@telegraphics.com.au</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hi All,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; There is a bug in the DP8393X emulation that can stop packet =
reception.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Whilst debugging that issue I found that the receiver algorit=
hm differs<br>
&gt; &gt;&gt; from the one described in the National Semiconductor datashee=
t.<br>
&gt; &gt;&gt;<br>
&gt; &gt; <br>
&gt; &gt; Finn, could you please provide the link to the exact datasheet th=
at<br>
&gt; &gt; you used for reference, so that we are on the same page while loo=
king<br>
&gt; &gt; at your code?<br>
&gt; <br>
&gt; According to his comments ,&quot;National Semiconductor DP83932C&quot;=
 and<br>
&gt; sections seem to be the same, I think the datasheet is:<br>
&gt; <br>
&gt; <a href=3D"https://www.eit.lth.se/fileadmin/eit/courses/datablad/Perip=
hery/Communication/DP83932C.pdf" target=3D"_blank">https://www.eit.lth.se/<=
wbr>fileadmin/eit/courses/<wbr>datablad/Periphery/<wbr>Communication/DP8393=
2C.pdf</a><br>
&gt; <br>
<br>
Yes. I know of 3 datasheets from National Semiconductor,<br>
<br>
11719=C2=A0 DP83934CVUL-20/25 MHz SONIC-T Systems-Oriented Network Interfac=
e <br>
Controller with Twisted Pair Interface<br>
10492=C2=A0 DP83932C-20/25/33 MHz SONIC Systems-Oriented Network Interface =
<br>
Controller<br>
11722=C2=A0 DP83916 SONIC-16 Systems-Oriented Network Interface Controller<=
br>
<br>
The publication numbered 10492 is the one that Laurent linked to. It and <b=
r>
11722 both have the same table of contents. The references I gave in the <b=
r>
patch descriptions are applicable to these. (Having said that, I see now <b=
r>
that I did mess up one reference. I&#39;ll fix it.)<br>
<br>
The &quot;1995 National Ethernet Databook&quot; on bitsavers has more infor=
mation. <br>
<a href=3D"https://mirrorservice.org/sites/www.bitsavers.org/components/nat=
ional/_dataBooks/1995_National_Ethernet_Databook.pdf" target=3D"_blank">htt=
ps://mirrorservice.org/<wbr>sites/www.bitsavers.org/<wbr>components/nationa=
l/_<wbr>dataBooks/1995_National_<wbr>Ethernet_Databook.pdf</a><br>
<br>
--=C2=A0</blockquote><div><br></div><div>Finn,</div><div><br></div><div>I t=
ruly appreciate your detailed response.</div><div><br></div><div>Aleksandar=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Thanks,<br>
&gt; Laurent<br>
&gt; <br>
</blockquote>

--00000000000062a8f3059a359640--

