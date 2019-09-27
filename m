Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD99DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8888C2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBUBYcop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8888C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqzl-000435-P1
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iDq3v-0003x0-NN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iDq3t-0006cl-Kj
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:13:31 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:34602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iDq3t-0006cc-F2
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:13:29 -0400
Received: by mail-oi1-x22a.google.com with SMTP id 83so5162701oii.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ufqWhA1xptL5MvMRMB0CrtCoAeUgmM7mm7ovkYrPNPw=;
 b=EBUBYcopA2ADdGQ4xtYTiXpTm9coWHxDQjov+D4cZ1aacm5J36sIlbWzvG59TB5Qgo
 2W6rXtSRRrVldM7GnLOnrb8FA0EGh9WUjVuO8RnUWLnsUIPugQRtD0mH3PfwaMcImJ3Z
 y6dee8W9s1LkhWSGwlCjads5TUvxGI8DAXbt4vmPWGVcDkXkaDW7OCJCDn2Df+VkGHdF
 xjM8AeDtF7uYRcAwSf7Ea73FpOFqjqmilQky4u8SM0IIuqiefRMiV2QuFSbdqELS9CCz
 y3D174MFUu+eAyxLQQn3z2LwKD3joWQlmvL8Qp2Ae/iUEK+aAsIQ1OFooR28DYjUfwwc
 O1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ufqWhA1xptL5MvMRMB0CrtCoAeUgmM7mm7ovkYrPNPw=;
 b=aFM4Tn8/tSzqSFgX0nWe3MmJZWyq+z8b78HLaay771+fHFhZQ0VMEVpLXsEsZvT1nY
 cDggWiHtrjkKbXnPZaCX7UxgG/NeBijjSxFaulb5pBPEHNSzgewN6th739cSkOG5UUia
 q8KgDJiCpfR9Y6ZFK5IRtFf1W27ztCtz0VYu6bapC3kBipS0dYJ7BmTb6KP+/lxa4GFt
 F+Z1gDLGQdb/obHbcQgR0HI4sTwyHeNfG/Ofx1R+DGT3sBBFUS/kYEi8QHub3VXK/bxc
 UqIFhiJruUppoC19dmz0JWDQIX1udY8YwqARjey98vanYpFoQ0ChOMBP/pOFSpum+DTa
 P6gg==
X-Gm-Message-State: APjAAAUohgYLhBP3pajdmm9BrVhqwxMhMPRvwydyGa9GkLlMSgsCSbNF
 IvgGbgPOQyoXX4wFdo/s6yHOMzLNUzzZJ4qr7VDv/A==
X-Google-Smtp-Source: APXvYqwe0qfXc4LILaYm2ceS61M6xTmmBMzk4smrUNL2ltVQb6q+xFD1OOko/b+V3AcPjpKEl6pDHP/id9na/+ULKeg=
X-Received: by 2002:aca:c505:: with SMTP id v5mr6492878oif.79.1569586409214;
 Fri, 27 Sep 2019 05:13:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 27 Sep 2019 05:13:28
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 27 Sep 2019 05:13:28
 -0700 (PDT)
In-Reply-To: <CAL1e-=ibwvMWj3T8iPAyDqhsRTnxUZPxhos6BaVoOtbTWO9WPg@mail.gmail.com>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <5746cc58-c132-ef29-6ff4-da07c6086dac@ilande.co.uk>
 <3fe632b7-e83c-9b26-9338-1d7a9c881e0d@linaro.org>
 <CABLmASFUnBnn2DZidKFAiaMb7gExYttgvEv12uce9EPi6NL9Qw@mail.gmail.com>
 <f1eeb1de-a6e7-bb83-3501-705382da4b14@ilande.co.uk>
 <CAL1e-=gtgzRHzZyX9r69_zB5-v-ThYeuxBameoF12TBs59M95w@mail.gmail.com>
 <db28c297-290b-3641-d87a-67fde65312a8@ilande.co.uk>
 <CAL1e-=ibwvMWj3T8iPAyDqhsRTnxUZPxhos6BaVoOtbTWO9WPg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 27 Sep 2019 14:13:28 +0200
Message-ID: <CAL1e-=hKo4q4Xox+E4niQoq5sJRNoZ7m9POkZ4sbu7t+DK0ojA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/16] tcg/ppc: Add vector opcodes
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="0000000000005d996e059387d0de"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005d996e059387d0de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

05.09.2019. 13.43, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> ping for Richard
>
> 03.09.2019. 20.34, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > On 03/09/2019 18:37, Aleksandar Markovic wrote:
> >
> > > On Tue, Sep 3, 2019 at 7:05 PM Mark Cave-Ayland <
> > > mark.cave-ayland@ilande.co.uk> wrote:
> > >
> > >> On 01/07/2019 19:34, Howard Spoelstra wrote:
> > >>
> > >>> On Mon, Jul 1, 2019 at 12:30 PM Richard Henderson <
> > >>> richard.henderson@linaro.org> wrote:
> > >>>
> > >>>> On 6/30/19 7:58 PM, Mark Cave-Ayland wrote:
> > >>>>> I don't have space for a full set of images on the G4, however
I've
> > >>>> tried boot tests
> > >>>>> on installer CDs for MacOS 9, OS X 10.2, Linux and HelenOS and it
looks
> > >>>> good here.
> > >>>>>
> > >>>>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
[PPC32]
> > >>>>
> > >>>> Thanks!
> > >>>>
> > >>>> Hi
> > >>>
> > >>> I just compiled the v6 set applied to current master on my G5,
Ubuntu 16.
> > >>> command line:
> > >>> ./qemu-system-ppc -L pc-bios -boot c m 512 -M mac99,via=3Dpmu \
> > >>> -netdev user,id=3Dnet1 -device sungem,netdev=3Dnet1 \
> > >>> -drive file=3D10.3.img,format=3Draw,media=3Ddisk \
> > >>>
> > >>> With no specific cpu set, Mac OS 9.2 hard disk image and 9.2 iso do
not
> > >> get
> > >>> to the desktop, they just hang while still in the openbios window.
They
> > >>> need -cpu G4 on the command line to get to the desktop.
> > >>>
> > >>> OSX 10.3 installed image boots to desktop.
> > >>> OSX 10.3 iso boots to installer
> > >>> OSX 10.4 installed image boots to desktop.
> > >>> OSX 10.4 iso boot to installer
> > >>> OSX 10.5 installed image boots to desktop.
> > >>> OSX 10.5 iso boots to installer
> > >>>
> > >>> So there seems to be a difference between hosts: If ran on a G4 hos=
t
> > >> there
> > >>> is no need to add -cpu G4 to run Mac OS 9.x, while there is when
ran on a
> > >>> G5 host.
> > >>
> > >> Are there any outstanding issues with this patchset now, or is it
ready to
> > >> be merged?
> > >> I'm really looking forward to seeing the improved performance when
testing
> > >> QEMU on my
> > >> Mac Mini :)
> > >>
> > >>
> > > Howard pointed to some illogical quirks of command line:
> > >
> > >> If ran on a G4 host there is no need to add -cpu G4 to run Mac OS
9.x,
> > >> while there is when ran on a G5 host.
> > >
> > > I am not sure if Howard says that this is a consequence of this serie=
s
> > > though.
> >
> > No, that has been an existing issue for a long time :)
> >
> > > Overall, I think this is a very good series - however, I had a number
of
> > > minor
> > > objections to multiple patches, that don't affect (or affect in a
minimal
> > > way)
> > > provided functionality - those objections are not addressed, nor
properly
> > > discussed - but I do think they should be addressed in order to get
the
> > > series
> > > in a better shape before upstreaming.
> >
> > I've had a quick look at some of your review comments, and certainly I
can see how
> > the earlier revisions have benefited from your feedback. There has been
a lot of
> > positive discussion, and Richard has taken the time to respond and
update the
> > patchset over several weeks to its latest revision.
> >
> > AFAICT the only remaining issue is that related to the ISA flags, but
to me this
> > isn't something that should prevent the patchset being merged. I can
certainly see
> > how the current flags implementation may not be considered technically
correct, but
> > then from your comments I don't see that it would be something that
would be
> > particularly difficult to change at a later date either.
> >
> > The things that are important to me are i) is the patchset functionally
correct and
> > ii) is it understandable and maintainable. I would say that the first
point is
> > clearly true (both myself and Howard have spent a lot of time testing
it), and given
> > that I had to delve into these patches to fix the R2 register issue on
32-bit PPC
> > then I can confirm that the contents of the patches were a reasonably
accurate
> > representation of the changes described within. And that's from someone
like me who
> > is mostly still a TCG beginner :)
> >
> > From a slightly more selfish position as the PPC Mac machine
maintainer, these
> > patches make a significant difference to me in that they reduce the
MacOS boot times
> > during everyday testing. Now for someone like myself who works on QEMU
as a hobby
> > outside of family life and a full time job, those few minutes are
really important to
> > me and soon add up really quickly during testing.
> >
> > I would really like these patches to be merged soon, since the worst
thing that can
> > happen is that the patchset ends up bit-rotting and then all the time
and effort put
> > into writing, testing and reviewing the patches by Richard, Howard,
David, myself and
> > indeed your review time will all end up going to waste.
> >
> >
> > ATB,
> >
> > Mark.
> >

--0000000000005d996e059387d0de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">ping</p>
<p dir=3D"ltr">05.09.2019. 13.43, &quot;Aleksandar Markovic&quot; &lt;<a hr=
ef=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&g=
t; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br=
>
&gt;<br>
&gt;<br>
&gt; ping for Richard<br>
&gt;<br>
&gt; 03.09.2019. 20.34, &quot;Mark Cave-Ayland&quot; &lt;<a href=3D"mailto:=
mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>&gt; =D1=98=
=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; &gt;<br>
&gt; &gt; On 03/09/2019 18:37, Aleksandar Markovic wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; On Tue, Sep 3, 2019 at 7:05 PM Mark Cave-Ayland &lt;<br>
&gt; &gt; &gt; <a href=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-a=
yland@ilande.co.uk</a>&gt; wrote:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;&gt; On 01/07/2019 19:34, Howard Spoelstra wrote:<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; On Mon, Jul 1, 2019 at 12:30 PM Richard Henderson &l=
t;<br>
&gt; &gt; &gt;&gt;&gt; <a href=3D"mailto:richard.henderson@linaro.org">rich=
ard.henderson@linaro.org</a>&gt; wrote:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; On 6/30/19 7:58 PM, Mark Cave-Ayland wrote:<br>
&gt; &gt; &gt;&gt;&gt;&gt;&gt; I don&#39;t have space for a full set of ima=
ges on the G4, however I&#39;ve<br>
&gt; &gt; &gt;&gt;&gt;&gt; tried boot tests<br>
&gt; &gt; &gt;&gt;&gt;&gt;&gt; on installer CDs for MacOS 9, OS X 10.2, Lin=
ux and HelenOS and it looks<br>
&gt; &gt; &gt;&gt;&gt;&gt; good here.<br>
&gt; &gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt;&gt; Tested-by: Mark Cave-Ayland &lt;<a href=3D"m=
ailto:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>&gt; =
[PPC32]<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; Thanks!<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; Hi<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; I just compiled the v6 set applied to current master=
 on my G5, Ubuntu 16.<br>
&gt; &gt; &gt;&gt;&gt; command line:<br>
&gt; &gt; &gt;&gt;&gt; ./qemu-system-ppc -L pc-bios -boot c m 512 -M mac99,=
via=3Dpmu \<br>
&gt; &gt; &gt;&gt;&gt; -netdev user,id=3Dnet1 -device sungem,netdev=3Dnet1 =
\<br>
&gt; &gt; &gt;&gt;&gt; -drive file=3D10.3.img,format=3Draw,media=3Ddisk \<b=
r>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; With no specific cpu set, Mac OS 9.2 hard disk image=
 and 9.2 iso do not<br>
&gt; &gt; &gt;&gt; get<br>
&gt; &gt; &gt;&gt;&gt; to the desktop, they just hang while still in the op=
enbios window. They<br>
&gt; &gt; &gt;&gt;&gt; need -cpu G4 on the command line to get to the deskt=
op.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; OSX 10.3 installed image boots to desktop.<br>
&gt; &gt; &gt;&gt;&gt; OSX 10.3 iso boots to installer<br>
&gt; &gt; &gt;&gt;&gt; OSX 10.4 installed image boots to desktop.<br>
&gt; &gt; &gt;&gt;&gt; OSX 10.4 iso boot to installer<br>
&gt; &gt; &gt;&gt;&gt; OSX 10.5 installed image boots to desktop.<br>
&gt; &gt; &gt;&gt;&gt; OSX 10.5 iso boots to installer<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; So there seems to be a difference between hosts: If =
ran on a G4 host<br>
&gt; &gt; &gt;&gt; there<br>
&gt; &gt; &gt;&gt;&gt; is no need to add -cpu G4 to run Mac OS 9.x, while t=
here is when ran on a<br>
&gt; &gt; &gt;&gt;&gt; G5 host.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Are there any outstanding issues with this patchset now,=
 or is it ready to<br>
&gt; &gt; &gt;&gt; be merged?<br>
&gt; &gt; &gt;&gt; I&#39;m really looking forward to seeing the improved pe=
rformance when testing<br>
&gt; &gt; &gt;&gt; QEMU on my<br>
&gt; &gt; &gt;&gt; Mac Mini :)<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; Howard pointed to some illogical quirks of command line:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;&gt; If ran on a G4 host there is no need to add -cpu G4 to r=
un Mac OS 9.x,<br>
&gt; &gt; &gt;&gt; while there is when ran on a G5 host.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I am not sure if Howard says that this is a consequence of t=
his series<br>
&gt; &gt; &gt; though.<br>
&gt; &gt;<br>
&gt; &gt; No, that has been an existing issue for a long time :)<br>
&gt; &gt;<br>
&gt; &gt; &gt; Overall, I think this is a very good series - however, I had=
 a number of<br>
&gt; &gt; &gt; minor<br>
&gt; &gt; &gt; objections to multiple patches, that don&#39;t affect (or af=
fect in a minimal<br>
&gt; &gt; &gt; way)<br>
&gt; &gt; &gt; provided functionality - those objections are not addressed,=
 nor properly<br>
&gt; &gt; &gt; discussed - but I do think they should be addressed in order=
 to get the<br>
&gt; &gt; &gt; series<br>
&gt; &gt; &gt; in a better shape before upstreaming.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;ve had a quick look at some of your review comments, and ce=
rtainly I can see how<br>
&gt; &gt; the earlier revisions have benefited from your feedback. There ha=
s been a lot of<br>
&gt; &gt; positive discussion, and Richard has taken the time to respond an=
d update the<br>
&gt; &gt; patchset over several weeks to its latest revision.<br>
&gt; &gt;<br>
&gt; &gt; AFAICT the only remaining issue is that related to the ISA flags,=
 but to me this<br>
&gt; &gt; isn&#39;t something that should prevent the patchset being merged=
. I can certainly see<br>
&gt; &gt; how the current flags implementation may not be considered techni=
cally correct, but<br>
&gt; &gt; then from your comments I don&#39;t see that it would be somethin=
g that would be<br>
&gt; &gt; particularly difficult to change at a later date either.<br>
&gt; &gt;<br>
&gt; &gt; The things that are important to me are i) is the patchset functi=
onally correct and<br>
&gt; &gt; ii) is it understandable and maintainable. I would say that the f=
irst point is<br>
&gt; &gt; clearly true (both myself and Howard have spent a lot of time tes=
ting it), and given<br>
&gt; &gt; that I had to delve into these patches to fix the R2 register iss=
ue on 32-bit PPC<br>
&gt; &gt; then I can confirm that the contents of the patches were a reason=
ably accurate<br>
&gt; &gt; representation of the changes described within. And that&#39;s fr=
om someone like me who<br>
&gt; &gt; is mostly still a TCG beginner :)<br>
&gt; &gt;<br>
&gt; &gt; From a slightly more selfish position as the PPC Mac machine main=
tainer, these<br>
&gt; &gt; patches make a significant difference to me in that they reduce t=
he MacOS boot times<br>
&gt; &gt; during everyday testing. Now for someone like myself who works on=
 QEMU as a hobby<br>
&gt; &gt; outside of family life and a full time job, those few minutes are=
 really important to<br>
&gt; &gt; me and soon add up really quickly during testing.<br>
&gt; &gt;<br>
&gt; &gt; I would really like these patches to be merged soon, since the wo=
rst thing that can<br>
&gt; &gt; happen is that the patchset ends up bit-rotting and then all the =
time and effort put<br>
&gt; &gt; into writing, testing and reviewing the patches by Richard, Howar=
d, David, myself and<br>
&gt; &gt; indeed your review time will all end up going to waste.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; ATB,<br>
&gt; &gt;<br>
&gt; &gt; Mark.<br>
&gt; &gt;<br>
</p>

--0000000000005d996e059387d0de--

