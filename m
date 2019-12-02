Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92A3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA5A20717
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bsdimp-com.20150623.gappssmtp.com header.i=@bsdimp-com.20150623.gappssmtp.com header.b="NmiisyQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA5A20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqZp-0002E4-KQ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wlosh@bsdimp.com>) id 1ibqZ0-0001mn-37
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wlosh@bsdimp.com>) id 1ibqYy-0001O5-Mu
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:36:49 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30]:35895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1ibqYy-0001N1-8G
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:36:48 -0500
Received: by mail-qv1-xf30.google.com with SMTP id b18so265977qvy.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h0UDZlJ7G0HmQzw7oNmMWVuWsOhKmK21rgz+8egp2iY=;
 b=NmiisyQwYQMnoBp9Nji1kAC2HY9KNpLyAo4VjMdC/SUZvAoVEm8wRvYTLZKJGWJimY
 4VXf6+57UpYC9L7LfBBGwPHbq5dMomZ9nBnITK3XWBOYQUR2NdFERiO54eKFMyzz756H
 RV45HnEaoUJX/pOig+o08pgrWuNAY6kAxXs2qoGBqPWMyg6dxCodlehMdMMoiXMOmGa/
 SVBUCYloUKueb0GpMNt96Uaf0qP47cRz+7ynJevDm3Dmo4sopq7nXYJrHqMjVCKBSF2k
 nUEdqyj0F989xB2eHN8t/dR83gPb1V2vVaDGGgNLV138Lo261dccdysGcVVotJNr1/8i
 O8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h0UDZlJ7G0HmQzw7oNmMWVuWsOhKmK21rgz+8egp2iY=;
 b=BCLbCFpcPQP5MnyS+EBs0CZJmnPN76aq8UE5MX2kzL7/22zfItnfsj8BY2J0l0q+Nc
 Ow4+giTUBIBv3pED/cO9s5bnxveTJHgFbcTqFxZN41W4WgV928KQwLT3RccIA14WJioZ
 TX3jkDZRHJVJknhj/tdS4cNVBp01jrYPxryCTFe+uXL+NS55L7TxPlDYZcMjHqXoOzZE
 AdaGt2QWUu6f5BzFBpdBqDF0UL03WG9+xCVxbLwrajrYY5vybmrsXRWa95UbsrMvoShC
 JwYR9qgk85I7WWqRduZiglAkEdfw26s7+84XOWju7VmhThdFC0sGRKRrr5Qbtiyhx8rz
 8zTw==
X-Gm-Message-State: APjAAAVlBHEQiC5YY0rDRgrAL0ulw+P6Y1MnU8tXNlRfE6l07xJ7qtbR
 CfiMJZGT+3JAMoLA1dsYdYKgrIyM+BrnP9Gd3kKICg==
X-Google-Smtp-Source: APXvYqyNm1Yj7lrzgGFDwUCPBPNHpGA5TorRM/rv4brbKbQTo0b5cyjbp2FDfk8thgaFS+6tzXMzplD4FBzHu72qxUc=
X-Received: by 2002:a0c:c125:: with SMTP id f34mr493460qvh.22.1575311806658;
 Mon, 02 Dec 2019 10:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20191202140552.GA5353@localhost.localdomain>
 <20191202170018.GD139090@stefanha-x1.localdomain>
 <CAFEAcA_fB1o95JitpzcZ4rtspxfD8dfkUZ3ZOcdMcAQpDFtYYQ@mail.gmail.com>
 <20191202182840.GA24511@localhost.localdomain>
In-Reply-To: <20191202182840.GA24511@localhost.localdomain>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 2 Dec 2019 11:36:35 -0700
Message-ID: <CANCZdfpWw=4dD4b_9K4FSoXZkBEVwsQkyuQtdiFk0mkb8MYtsg@mail.gmail.com>
Subject: Re: [RFC] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a5917f0598bcdc5a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f30
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
 Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jeff Nelson <jen@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a5917f0598bcdc5a
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 2, 2019 at 11:29 AM Cleber Rosa <crosa@redhat.com> wrote:

> On Mon, Dec 02, 2019 at 05:08:35PM +0000, Peter Maydell wrote:
> > On Mon, 2 Dec 2019 at 17:00, Stefan Hajnoczi <stefanha@redhat.com>
> wrote:
> > >
> > > On Mon, Dec 02, 2019 at 09:05:52AM -0500, Cleber Rosa wrote:
> > > > To exemplify my point, if one specific test run as part of
> "check-tcg"
> > > > is found to be faulty on a specific job (say on a specific OS), the
> > > > entire "check-tcg" test set may be disabled as a CI-level maintenance
> > > > action.  Of course a follow up action to deal with the specific test
> > > > is required, probably in the form of a Launchpad bug and patches
> > > > dealing with the issue, but without necessarily a CI related angle to
> > > > it.
> > >
> > > I think this coarse level of granularity is unrealistic.  We cannot
> > > disable 99 tests because of 1 known failure.  There must be a way of
> > > disabling individual tests.  You don't need to implement it yourself,
> > > but I think this needs to be solved by someone before a gating CI can
> be
> > > put into use.
> > >
> > > It probably involves adding a "make EXCLUDE_TESTS=foo,bar check"
> > > variable so that .gitlab-ci.yml can be modified to exclude specific
> > > tests on certain OSes.
> >
> > We don't have this at the moment, so I'm not sure we need to
> > add it as part of moving to doing merge testing via gitlab ?
> > The current process is "if the pullreq causes a test to fail
> > then the pullreq needs to be changed, perhaps by adding a
> > patch which disables the test on a particular platform if
> > necessary". Making that smoother might be nice, but I would
> > be a little wary about adding requirements to the move-to-gitlab
> > that don't absolutely need to be there.
> >
> > thanks
> > -- PMM
> >
>
> Right, it goes without saying that:
>
> 1) I acknowledge the problem (and I can have a long conversation
> about it :)
>

Just make sure that any pipeline and mandatory CI steps don't slow things
down too much... While the examples have talked about 1 or 2 pull requests
getting done in parallel, and that's great, the problem is when you try to
land 10 or 20 all at once, one that causes the failure and you aren't sure
which one it actually is... Make sure whatever you design has sane
exception case handling to not cause too much collateral damage... I worked
one place that would back everything out if a once-a-week CI test ran and
had failures... That CI test-run took 2 days to run, so it wasn't practical
to run it often, or for every commit. In the end, though, the powers that
be implemented a automated bisection tool that made it marginally less
sucky..

Warner

--000000000000a5917f0598bcdc5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 2, 2019 at 11:29 AM Clebe=
r Rosa &lt;<a href=3D"mailto:crosa@redhat.com">crosa@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Dec =
02, 2019 at 05:08:35PM +0000, Peter Maydell wrote:<br>
&gt; On Mon, 2 Dec 2019 at 17:00, Stefan Hajnoczi &lt;<a href=3D"mailto:ste=
fanha@redhat.com" target=3D"_blank">stefanha@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Mon, Dec 02, 2019 at 09:05:52AM -0500, Cleber Rosa wrote:<br>
&gt; &gt; &gt; To exemplify my point, if one specific test run as part of &=
quot;check-tcg&quot;<br>
&gt; &gt; &gt; is found to be faulty on a specific job (say on a specific O=
S), the<br>
&gt; &gt; &gt; entire &quot;check-tcg&quot; test set may be disabled as a C=
I-level maintenance<br>
&gt; &gt; &gt; action.=C2=A0 Of course a follow up action to deal with the =
specific test<br>
&gt; &gt; &gt; is required, probably in the form of a Launchpad bug and pat=
ches<br>
&gt; &gt; &gt; dealing with the issue, but without necessarily a CI related=
 angle to<br>
&gt; &gt; &gt; it.<br>
&gt; &gt;<br>
&gt; &gt; I think this coarse level of granularity is unrealistic.=C2=A0 We=
 cannot<br>
&gt; &gt; disable 99 tests because of 1 known failure.=C2=A0 There must be =
a way of<br>
&gt; &gt; disabling individual tests.=C2=A0 You don&#39;t need to implement=
 it yourself,<br>
&gt; &gt; but I think this needs to be solved by someone before a gating CI=
 can be<br>
&gt; &gt; put into use.<br>
&gt; &gt;<br>
&gt; &gt; It probably involves adding a &quot;make EXCLUDE_TESTS=3Dfoo,bar =
check&quot;<br>
&gt; &gt; variable so that .gitlab-ci.yml can be modified to exclude specif=
ic<br>
&gt; &gt; tests on certain OSes.<br>
&gt; <br>
&gt; We don&#39;t have this at the moment, so I&#39;m not sure we need to<b=
r>
&gt; add it as part of moving to doing merge testing via gitlab ?<br>
&gt; The current process is &quot;if the pullreq causes a test to fail<br>
&gt; then the pullreq needs to be changed, perhaps by adding a<br>
&gt; patch which disables the test on a particular platform if<br>
&gt; necessary&quot;. Making that smoother might be nice, but I would<br>
&gt; be a little wary about adding requirements to the move-to-gitlab<br>
&gt; that don&#39;t absolutely need to be there.<br>
&gt; <br>
&gt; thanks<br>
&gt; -- PMM<br>
&gt; <br>
<br>
Right, it goes without saying that:<br>
<br>
1) I acknowledge the problem (and I can have a long conversation<br>
about it :)<br></blockquote><div><br></div><div>Just make sure that any pip=
eline and mandatory CI steps don&#39;t slow things down too much... While t=
he examples have talked about 1 or 2 pull requests getting done in parallel=
, and that&#39;s great, the problem is when you try to land 10 or 20 all at=
 once, one that causes the failure and you aren&#39;t sure which one it act=
ually is... Make sure whatever you design has sane exception case handling =
to not cause too much collateral damage... I worked one place that would ba=
ck everything out if a once-a-week CI test ran and had failures... That CI =
test-run took 2 days to run, so it wasn&#39;t practical to run it often, or=
 for every commit. In the end, though, the powers that be implemented a aut=
omated bisection tool that made it marginally less sucky..</div><div><br></=
div><div>Warner=C2=A0</div></div></div>

--000000000000a5917f0598bcdc5a--

