Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ACAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF32206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="aJEaygxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF32206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k584a-0003FL-Ml
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1k57ti-0005C4-Sr
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:31:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1k57tg-0000aA-S4
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:31:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id t14so8356500wmi.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vayavyalabs.com; s=vayavyalabs;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wPDM6hSpJ539DNrrLQXTby/xuAzex+8pH+OgdoatxsM=;
 b=aJEaygxEv9R3BFA0xFJgTCRztazQPYrDE9U2jIBlVjKw3LVVkBOGeNSpknuvwA5Zlf
 qHxarA2fMq834s+GEAeGbzedZTu7eMPfln1L0X4E/Y2/jEVXIl0kQYhFuGae58zW0Xdn
 0t4HGP7KsdoxiQlagc3/Kht27QdT+UpEdnwnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wPDM6hSpJ539DNrrLQXTby/xuAzex+8pH+OgdoatxsM=;
 b=hCF126pItOmUzsdrmlrgQ6DGFm8J5xp9qB+FXf4UM+KdMpaSANcIer4ZgsqY8BnXOd
 x1hhETRHdMR0y/Jms5t+x60drgiycNGu1DB0uF6YvNp89b8KdDXgNRa+2iOUyx/JBozy
 IN/Q/o/Mj+N4aRPxLlVPr2++F0wRr28WBy6rBPxkFhxDcyzXpY+n2XSyeyUy9a9VnvdL
 7Oodus546jSpY+vLFYoEl6HZOvBS+l5dXtPr5JyHaNs7dpUHNYFcrwmf9OFfWaI9wNZM
 0kDmoaAKkQkwA8NZagcvIeTRrTZtfqpZuMeueWURvpHGauduZHnztFK5XYIclUnUQ+LO
 ysDQ==
X-Gm-Message-State: AOAM531ojvVspanpWNPzQ6+c2csB+l0QDPLuu229uJHNhgYiFz2zuRGR
 Iq94+HiCI0qtjvz4GOf2YJTfII1y7IMErNo4OY6YBg==
X-Google-Smtp-Source: ABdhPJxor+WJSqG1tWse0rTLjGF2TbUNB7SrCi09oeXsMpss0vJFwJLR2HfNVzLliSGFOvluMTbXGQ7ouPdIVtOqqag=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr23860541wmu.129.1597066286794; 
 Mon, 10 Aug 2020 06:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+aXn+GrFDssmZWBCL0gh3QLX5BMhmgTQUywLSSQn=cpF2P1ZQ@mail.gmail.com>
 <87r1se3k7m.fsf@linaro.org>
 <CA+aXn+ETrBneXK3N6+gzO_7R=6mdxXr_Oig7MjOe7VzO5OD0mg@mail.gmail.com>
 <87lfim3ipq.fsf@linaro.org>
In-Reply-To: <87lfim3ipq.fsf@linaro.org>
From: Pratik Parvati <pratikp@vayavyalabs.com>
Date: Mon, 10 Aug 2020 19:01:15 +0530
Message-ID: <CA+aXn+G4EWAoGqgEuDW9j5dQSNJX2g31aGt521YL3MV9eyPzVg@mail.gmail.com>
Subject: Re: QEMU Library support
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b52c6105ac85f827"
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=pratikp@vayavyalabs.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b52c6105ac85f827
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just to hide the core QEMU implementation from the device code. QEMU core
source code remains the same for all device; So, was thinking a way of
hiding it from the rest of the device code.

Regards,
Pratik


On Mon, Aug 10, 2020 at 3:50 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Pratik Parvati <pratikp@vayavyalabs.com> writes:
>
> > As an experiment, I have modelled non-existing ARM Watchdog model (SP80=
5)
> > interfaced to the versatile PB platform. What actually I was looking is=
 -
> > some sort of QEMU library, where I can model new device outside the QEM=
U
> > source hierarchy and still be able to compile it using QEMU library and
> > include files to add support for the new device. If QEMU doesn't provid=
e
> a
> > library, Is there a flexibly that I can tweak something inside the QEMU
> to
> > generate it?
>
> Not really. While most devices are fairly standalone they can access all
> sorts of QEMU APIs. Why not just implement your device inside the QEMU
> source tree?
>
> >
> > Regards,
> > Pratik
> >
> >
> > On Mon, Aug 10, 2020 at 3:18 PM Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
> wrote:
> >
> >>
> >> Pratik Parvati <pratikp@vayavyalabs.com> writes:
> >>
> >> > Hi team,
> >> >
> >> > Lately, I have been working on QEMU modeling and interfacing it into
> the
> >> > existing platform. What actually I wanted to check is; whether QEMU
> >> > supports library that gives developers a clean interface to develop
> and
> >> > integrate peripheral model in to QEMU. I know of the Greensocs Syste=
mC
> >> > bridge - but that was quite difficult to work with in past.
> >>
> >> Not really - with a few exceptions like vhost-user and in KVM device
> >> emulation all devices are emulated in the QEMU code base. As a result
> >> the best way to maintain a device is to have it integrated upstream
> >> (along with some tests to ensure it is working).
> >>
> >> As you note there are various forks of QEMU that support device
> >> modelling but none of these features have been merged upstream and wou=
ld
> >> likely need to assuage worries about such interfaces being used to avo=
id
> >> GPL compliance.
> >>
> >> What sort of devices are you looking to model? Are these existing
> >> devices or experimental/research things?
> >>
> >> --
> >> Alex Benn=C3=A9e
> >>
>
>
> --
> Alex Benn=C3=A9e
>

--000000000000b52c6105ac85f827
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Just to hide the core QEMU implementation=C2=A0from the de=
vice code. QEMU core source code remains the same for all device; So, was t=
hinking a way of hiding it from the rest of the device code.<div><br clear=
=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"=
gmail_signature"><div dir=3D"ltr">Regards,<div>Pratik</div></div></div></di=
v><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Mon, Aug 10, 2020 at 3:50 PM Alex Benn=C3=A9e &lt;<a href=3D=
"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Pratik Parvati &lt;<a href=3D"mailto:pratikp@vayavyalabs.com" target=3D"_bl=
ank">pratikp@vayavyalabs.com</a>&gt; writes:<br>
<br>
&gt; As an experiment, I have modelled non-existing ARM Watchdog model (SP8=
05)<br>
&gt; interfaced to the versatile PB platform. What actually I was looking i=
s -<br>
&gt; some sort of QEMU library, where I can model new device outside the QE=
MU<br>
&gt; source hierarchy and still be able to compile it using QEMU library an=
d<br>
&gt; include files to add support for the new device. If QEMU doesn&#39;t p=
rovide a<br>
&gt; library, Is there a flexibly that I can tweak something inside the QEM=
U to<br>
&gt; generate it?<br>
<br>
Not really. While most devices are fairly standalone they can access all<br=
>
sorts of QEMU APIs. Why not just implement your device inside the QEMU<br>
source tree?<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Pratik<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Aug 10, 2020 at 3:18 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Pratik Parvati &lt;<a href=3D"mailto:pratikp@vayavyalabs.com" targ=
et=3D"_blank">pratikp@vayavyalabs.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Hi team,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Lately, I have been working on QEMU modeling and interfacing =
it into the<br>
&gt;&gt; &gt; existing platform. What actually I wanted to check is; whethe=
r QEMU<br>
&gt;&gt; &gt; supports library that gives developers a clean interface to d=
evelop and<br>
&gt;&gt; &gt; integrate peripheral model in to QEMU. I know of the Greensoc=
s SystemC<br>
&gt;&gt; &gt; bridge - but that was quite difficult to work with in past.<b=
r>
&gt;&gt;<br>
&gt;&gt; Not really - with a few exceptions like vhost-user and in KVM devi=
ce<br>
&gt;&gt; emulation all devices are emulated in the QEMU code base. As a res=
ult<br>
&gt;&gt; the best way to maintain a device is to have it integrated upstrea=
m<br>
&gt;&gt; (along with some tests to ensure it is working).<br>
&gt;&gt;<br>
&gt;&gt; As you note there are various forks of QEMU that support device<br=
>
&gt;&gt; modelling but none of these features have been merged upstream and=
 would<br>
&gt;&gt; likely need to assuage worries about such interfaces being used to=
 avoid<br>
&gt;&gt; GPL compliance.<br>
&gt;&gt;<br>
&gt;&gt; What sort of devices are you looking to model? Are these existing<=
br>
&gt;&gt; devices or experimental/research things?<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Alex Benn=C3=A9e<br>
&gt;&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div>

--000000000000b52c6105ac85f827--

