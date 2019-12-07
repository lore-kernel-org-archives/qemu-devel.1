Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283E3C43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 16:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D5A20637
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 16:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuZJip/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D5A20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iddPC-0001Xv-1z
	for qemu-devel@archiver.kernel.org; Sat, 07 Dec 2019 11:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iddOI-0000fM-39
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 11:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iddOF-0008K3-S6
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 11:57:09 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:43939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iddO9-0008G5-D8; Sat, 07 Dec 2019 11:57:01 -0500
Received: by mail-oi1-x22f.google.com with SMTP id x14so2679344oic.10;
 Sat, 07 Dec 2019 08:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3oqtDTZEFM1aOe2l96t5eWqf/P2MM/74EwOzIM+HdmU=;
 b=QuZJip/vijLlHW8m7XPoXxWGjDqokjfwBnJBA+FnBdVKVBKlHUYEFmwZzIrisP0bfj
 973i8Q50e30zuCd6+b2P6aFugeYCFX1DdTUI0i/nkQs4CpXEoBE+H4FdlNk4DOQhpEBa
 rUHjvot1JhYoIuAAnkE1DOXUVLcUBIpNJWZZ31RhHfdoYmwogQoz7Jqoq0wuSQ1Yf2UA
 ryOxOsf/NKeO/MBOFpyEiLJwxANP8Ebi5UjU5K46/puWkpAjDHDIBJQv0aq8ineLVNK5
 kLDAqsnDYUCTlTKgSnjFz4qtVAO5gyJ94UBS9jUGNxm1eZRCXl2deAJ2vOup+YMup1ct
 7/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3oqtDTZEFM1aOe2l96t5eWqf/P2MM/74EwOzIM+HdmU=;
 b=WnEkipRydm2LQHrUP6JW0LhJYFVuUAIOZwlO1SylU9lmwQXK3FmQvp4Ar7kmUjeLDU
 xKYJkSK/dpRa+74EYzNs42+PIq++dlIwRVuO9lewBIRzA9rj1b9lGb1/o2+bEg056BKV
 Wm1jFWeIKec5g14t12qAHiTroLIRe9cn6YMoior5WmFILX04T0AmBcgSwIyj4jlgs5cP
 V2/nnqsv8RIM33ks28HNI+Xa996ZTKlaGr71vtqEv1nPrhLuM7snkQI6u1FkpT5ZoE+o
 WFwYPUQGf6/dLR1wFT0E9rSX6tSoWr5K1tIzfo5rVUY7aUGwqmAaHoDLPlg+bxV4bVky
 2svg==
X-Gm-Message-State: APjAAAUhAbzE7mZBsovl3V/kHBGffjL16qSNErVdswvk1/+Q3wmzP/Ey
 s4RNUOeChonm7bLyeB/1O4HOKF8flHH4HvIkG2L6qA==
X-Google-Smtp-Source: APXvYqxoEiiVn9KtuHpvdUC65yBToR//GQK87U/vLF84L8SKhBmaXD/cJc/m6Xps7KY+fymc2vIueiZvxhz56Ce/Yfc=
X-Received: by 2002:aca:bd85:: with SMTP id
 n127mr11342911oif.136.1575723921850; 
 Sat, 07 Dec 2019 05:05:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 7 Dec 2019 05:05:21 -0800 (PST)
In-Reply-To: <BN6PR2201MB125123754144B7214725BF05C6A30@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <CADgy-2vznasvwaUwNSi96Sy=ucPC=-3e=O9irqc5DSpV_uhWUg@mail.gmail.com>
 <abf5f3b6-7c05-a85b-051f-9905b8f50041@vivier.eu>
 <CADgy-2va2xVmO_a1gDwg+zkpNcLJTW5D1j=2kk1TnRMxyPaLMg@mail.gmail.com>
 <6542ac57-6b06-1337-825b-dd1187accd15@vivier.eu>
 <BN6PR2201MB125123754144B7214725BF05C6A30@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 7 Dec 2019 14:05:21 +0100
Message-ID: <CAL1e-=ggkB4UZ-VhxGYy9FespVviB2OOGtrv1VL7KzM8WGXbCQ@mail.gmail.com>
Subject: Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIGRTMAX - 1
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Content-Type: multipart/alternative; boundary="000000000000a0471c05991cd070"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
 "marlies.ruck@gmail.com" <marlies.ruck@gmail.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Petar Jovanovic <pjovanovic@wavecomp.com>,
 "milos.stojanovic@rt-rk.com" <milos.stojanovic@rt-rk.com>,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a0471c05991cd070
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, August 28, 2019, Aleksandar Markovic <amarkovic@wavecomp.com>
wrote:

> > From: Laurent Vivier <laurent@vivier.eu>
> > Sent: Wednesday, August 28, 2019 10:51 AM
> > To: Josh Kunz; Aleksandar Markovic; milos.stojanovic@rt-rk.com
> > Cc: marlies.ruck@gmail.com; qemu-devel@nongnu.org; riku.voipio@iki.fi;
> > qemu-trivial@nongnu.org; Peter Maydell; Shu-Chun Weng; Aleksandar
> Markovic
> > Subject: [EXTERNAL]Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and
> SIGRTMAX - 1
> >
> > Le 26/08/2019 =C3=A0 23:10, Josh Kunz a =C3=A9crit :
> > > On Wed, Aug 21, 2019 at 2:28 AM Laurent Vivier <laurent@vivier.eu
> > > <mailto:laurent@vivier.eu>> wrote:
> > >
> > >     Le 19/08/2019 =C3=A0 23:46, Josh Kunz via Qemu-devel a =C3=A9crit=
 :
> > >     > Hi all,
> > >     >
> > >     > I have also experienced issues with SIGRTMIN + 1, and am
> interested in
> > >     > moving this patch forwards. Anything I can do here to help?
> Would the
> > >     > maintainers prefer myself or Marli re-submit the patch?
> > >     >
> > >     > The Go issue here seems particularly sticky. Even if we update
> the Go
> > >     > runtime, users may try and run older binaries built with older
> > >     versions of
> > >     > Go for quite some time (months? years?). Would it be better to
> > >     hide this
> > >     > behind some kind of build-time flag
> > >     (`--enable-sigrtmin-plus-one-proxy` or
> > >     > something), so that some users can opt-in, but older binaries
> > >     still work as
> > >     > expected?
> > >     >
> > >     > Also, here is a link to the original thread this message is in
> > >     reply to
> > >     > in-case my mail-client doesn't set up the reply properly:
> > >     > https://lists.nongnu.org/archive/html/qemu-devel/2019-
> 07/msg01303.html
> > >
> > >     The problem here is we break something to fix something else.
> > >
> > >     I'm wondering if the series from Aleksandar Markovic, "linux-user=
:
> > >     Support signal passing for targets having more signals than host"
> [1]
> > >     can fix the problem in a better way?
> > >
> > >
> > > That patch[1] (which I'll refer to as the MUX patch to avoid confusio=
n)
> > > does not directly fix the issue addressed by this patch (re-wiring
> > > SIGRTMIN+1), but since it basically implements generic signal
> > > multiplexing, it could be re-worked to address this case as well. The
> > > way it handles `si_code` spooks me a little bit. It could easily be
> > > broken by a kernel version change, and such a breakage could be hard =
to
> > > detect or lead to surprising results. Other than that, it looks like =
a
> > > reasonable implementation.
> > >
> > > That said, overall, fixing the SIGRTMIN+1 issue using a more-generic
> > > signal-multiplexing mechanism doesn't seem *that* much better to me. =
It
> > > adds a lot of complexity, and only saves a single signal (assuming
> glibc
> > > doesn't add more reserved signals). The "big win" is additional
> > > emulation features, like those introduced in MUX patch (being able to
> > > utilize signals outside of the host range). If having those features =
in
> > > QEMU warrants the additional complexity, then re-working this patch
> > > on-top of that infrastructure seems like a good idea.
> > >
> > > If the maintainers want to go down that route, then I would be happy =
to
> > > re-work this patch utilizing the infrastructure from the MUX patch.
> > > Unfortunately it will require non-trivial changes, so it may be best =
to
> > > wait until that patch is merged. I could also provide a patch "on top
> > > of" the MUX patch, if that's desired/more convenient.
> > >
> > > Just one last note, if you do decide to merge the MUX patch, then it
> > > would be best to use SIGRTMAX (instead of SIGRTMAX-1) as the
> > > multiplexing signal if possible, to avoid breaking go binaries.
> > >
> >
> > Personally, I prefer a solution that breaks nothing.
> >
> > Aleksandar, Milos,
> >
> > do you have an updated version of you series "Support signal passing fo=
r
> > targets having more signals than host"?
> >
>
> Milos is unfortunetely working on an entirely different project now, and
> can't spare enough time to finish the series. I am also busy with other
> issues, even though I would like very much this or equivalent solution to
> be integrated. Alternatively, someone in the team may have time later thi=
s
> year, but I do not know that yet  - perhaps somebody else (Josh) can take
> over the series?
>
>

Hello, all.

From my side, status quo. Milos (who ironically works in the office next to
mine) expressed interest in modifying his solution to be in accordance with
what Peter said, says that this is doable, but requires a lot of meticulous
work - however, he is too involved into his project for months to go. I am
also involved in other things, and, furthermore, has less background
knowledge than Milos. That said, we in MIPS would like the solution
described by Peter as much as other platforms, if not more.

All this taken into account, perhaps this can be a project for Outreachy or
Google Summer of Code, mentored by Peter?

The perhaps largest problem with that is that the person doing it would
need some steep learning curve (on signals in general, and their treatment
in QEMU), that can take some significant time.

Yours,
Aleksandar


> Sincerely,
> Aleksandar
>
>
> > Thanks,
> > Laurent
> >
>

--000000000000a0471c05991cd070
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, August 28, 2019, Aleksandar Markovic &lt;<a href=3D"m=
ailto:amarkovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt; wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">&gt; From: Laurent Vivier &lt;<a href=3D"mailto:=
laurent@vivier.eu">laurent@vivier.eu</a>&gt;<br>
&gt; Sent: Wednesday, August 28, 2019 10:51 AM<br>
&gt; To: Josh Kunz; Aleksandar Markovic; <a href=3D"mailto:milos.stojanovic=
@rt-rk.com">milos.stojanovic@rt-rk.com</a><br>
&gt; Cc: <a href=3D"mailto:marlies.ruck@gmail.com">marlies.ruck@gmail.com</=
a>; <a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>; <a =
href=3D"mailto:riku.voipio@iki.fi">riku.voipio@iki.fi</a>; &gt; <a href=3D"=
mailto:qemu-trivial@nongnu.org">qemu-trivial@nongnu.org</a>; Peter Maydell;=
 Shu-Chun Weng; Aleksandar Markovic<br>
&gt; Subject: [EXTERNAL]Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIG=
RTMAX - 1<br>
&gt; <br>
&gt; Le 26/08/2019 =C3=A0 23:10, Josh Kunz a =C3=A9crit :<br>
&gt; &gt; On Wed, Aug 21, 2019 at 2:28 AM Laurent Vivier &lt;<a href=3D"mai=
lto:laurent@vivier.eu">laurent@vivier.eu</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu=
</a>&gt;&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Le 19/08/2019 =C3=A0 23:46, Josh Kunz via Qemu=
-devel a =C3=A9crit :<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi all,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; I have also experienced issues with SIGRT=
MIN + 1, and am interested in<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; moving this patch forwards. Anything I ca=
n do here to help? Would the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; maintainers prefer myself or Marli re-sub=
mit the patch?<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; The Go issue here seems particularly stic=
ky. Even if we update the Go<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; runtime, users may try and run older bina=
ries built with older<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0versions of<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; Go for quite some time (months? years?). =
Would it be better to<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0hide this<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; behind some kind of build-time flag<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0(`--enable-sigrtmin-plus-one-<wbr>proxy` or<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; something), so that some users can opt-in=
, but older binaries<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0still work as<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; expected?<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; Also, here is a link to the original thre=
ad this message is in<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0reply to<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; in-case my mail-client doesn&#39;t set up=
 the reply properly:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"https://lists.nongnu.org/archi=
ve/html/qemu-devel/2019-07/msg01303.html" target=3D"_blank">https://lists.n=
ongnu.org/<wbr>archive/html/qemu-devel/2019-<wbr>07/msg01303.html</a><br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0The problem here is we break something to fix =
something else.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0I&#39;m wondering if the series from Aleksanda=
r Markovic, &quot;linux-user:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Support signal passing for targets having more=
 signals than host&quot; [1]<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0can fix the problem in a better way?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; That patch[1] (which I&#39;ll refer to as the MUX patch to avoid =
confusion)<br>
&gt; &gt; does not directly fix the issue addressed by this patch (re-wirin=
g<br>
&gt; &gt; SIGRTMIN+1), but since it basically implements generic signal<br>
&gt; &gt; multiplexing, it could be re-worked to address this case as well.=
 The<br>
&gt; &gt; way it handles `si_code` spooks me a little bit. It could easily =
be<br>
&gt; &gt; broken by a kernel version change, and such a breakage could be h=
ard to<br>
&gt; &gt; detect or lead to surprising results. Other than that, it looks l=
ike a<br>
&gt; &gt; reasonable implementation.<br>
&gt; &gt;<br>
&gt; &gt; That said, overall, fixing the SIGRTMIN+1 issue using a more-gene=
ric<br>
&gt; &gt; signal-multiplexing mechanism doesn&#39;t seem *that* much better=
 to me. It<br>
&gt; &gt; adds a lot of complexity, and only saves a single signal (assumin=
g glibc<br>
&gt; &gt; doesn&#39;t add more reserved signals). The &quot;big win&quot; i=
s additional<br>
&gt; &gt; emulation features, like those introduced in MUX patch (being abl=
e to<br>
&gt; &gt; utilize signals outside of the host range). If having those featu=
res in<br>
&gt; &gt; QEMU warrants the additional complexity, then re-working this pat=
ch<br>
&gt; &gt; on-top of that infrastructure seems like a good idea.<br>
&gt; &gt;<br>
&gt; &gt; If the maintainers want to go down that route, then I would be ha=
ppy to<br>
&gt; &gt; re-work this patch utilizing the infrastructure from the MUX patc=
h.<br>
&gt; &gt; Unfortunately it will require non-trivial changes, so it may be b=
est to<br>
&gt; &gt; wait until that patch is merged. I could also provide a patch &qu=
ot;on top<br>
&gt; &gt; of&quot; the MUX patch, if that&#39;s desired/more convenient.<br=
>
&gt; &gt;<br>
&gt; &gt; Just one last note, if you do decide to merge the MUX patch, then=
 it<br>
&gt; &gt; would be best to use SIGRTMAX (instead of SIGRTMAX-1) as the<br>
&gt; &gt; multiplexing signal if possible, to avoid breaking go binaries.<b=
r>
&gt; &gt;<br>
&gt; <br>
&gt; Personally, I prefer a solution that breaks nothing.<br>
&gt; <br>
&gt; Aleksandar, Milos,<br>
&gt; <br>
&gt; do you have an updated version of you series &quot;Support signal pass=
ing for<br>
&gt; targets having more signals than host&quot;?<br>
&gt; <br>
<br>
Milos is unfortunetely working on an entirely different project now, and ca=
n&#39;t spare enough time to finish the series. I am also busy with other i=
ssues, even though I would like very much this or equivalent solution to be=
 integrated. Alternatively, someone in the team may have time later this ye=
ar, but I do not know that yet=C2=A0 - perhaps somebody else (Josh) can tak=
e over the series?<br>
<br></blockquote><div><br></div><div><br></div><div>Hello, all.</div><div><=
br></div><div>From my side, status quo. Milos (who ironically works in the =
office next to mine) expressed interest in modifying his solution to be in =
accordance with what Peter said, says that this is doable, but requires a l=
ot of meticulous work - however, he is too involved into his project for mo=
nths to go. I am also involved in other things, and, furthermore, has less =
background knowledge than Milos. That said, we in MIPS would like the solut=
ion described by Peter as much as other platforms, if not more.</div><div><=
br></div><div>All this taken into account, perhaps this can be a project fo=
r Outreachy or Google Summer of Code, mentored by Peter?</div><div><br></di=
v><div>The perhaps largest problem with that is that the person doing it wo=
uld need some steep learning curve (on signals in general, and their treatm=
ent in QEMU), that can take some significant time.</div><div><br></div><div=
>Yours,</div><div>Aleksandar</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
Sincerely,<br>
Aleksandar<br>
<br>
<br>
&gt; Thanks,<br>
&gt; Laurent<br>
&gt; <br>
</blockquote>

--000000000000a0471c05991cd070--

