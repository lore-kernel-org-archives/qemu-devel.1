Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDAC4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 19:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D802820719
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 19:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0InpjH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D802820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG6eW-0003KB-0P
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 15:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jG6dr-0002uw-RM
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 15:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jG6dq-0002QL-IB
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 15:52:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jG6dq-0002Q3-Bj
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 15:52:14 -0400
Received: by mail-wr1-x42d.google.com with SMTP id p10so1849744wrt.6
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=INYBBYLFUqEOW2rWRKr982rY7t35xkrPsVORhDugoxw=;
 b=k0InpjH4NwN2GsZuncqbHNAjnzZ8QH9Tib7wo3wMoGKxp2NN2iCZTZ3uGPnw7akUMU
 TtsPMllsssq2/13DiFbZWlpj4pmhgvObsYsOR5POy1HopjWKEUy6+tJ860vSzGxjYJMp
 xVd2DCfoOSfD/ZwFp0T+Os6SjoSjCwvE6aGN3d1u5XK4DyyTUjX0mf3ltm4OhuJ/qRdZ
 3pZY+jx0qd8/cISzK78N7ufwDuDwteV+eQM6Sy1hj3lPYzprYnsH8EkZw5mO/MA6d6VS
 JBg99MUAQY3p/m4VuQSYe4h7P2SPISTzyDwJVjWVqQzV880z6nHdK+A4XQe+H8b7A0PV
 n21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=INYBBYLFUqEOW2rWRKr982rY7t35xkrPsVORhDugoxw=;
 b=YSlRgLJyFyqcSERyNEeEs5DYbpMYg/J8fSZNTq8lDyGGNUZwb9szwO7IOJInN+VcFl
 6awuKtP+1mkndOt3DBdKlAuU2FlFfBfkuob1jYZSDwlIAxy5z10rhz0e3GzCoqSXCl7R
 nTVEd2ABCMYOHZ0dRbKY7t2zzCY4eppAiliPBjSzGi4F2mrt+Up2N9MW8AMA4KN447fa
 ioSMKiEpgsxkNjbipCS0Ox04MoINJpAK2skNAzDuwHKTJSmGNzA90LmzMe23yrNgstMd
 cehsA2JwhvFUTXwOxdroAupV17GWarE9mlVEmMdQhcSQRgBvqFJhj8M0tAEBqjXL/dHd
 vEvw==
X-Gm-Message-State: ANhLgQ1uRi5a9XqbAULCkG7g6I5SPD1yy3l0mJtCiE8aoPo3EXjMPw0r
 fGVCWE92SHuGYTHgngfryPvcva/1NA45B37/CeI=
X-Google-Smtp-Source: ADFU+vsWy9Z2llbomneOGondPJ5I1otGvVlF9j2Dq8YkFxcI2d1r+wzM2HfrqFj1DQsXt8iiG8eSXvMq7KrnR10a09U=
X-Received: by 2002:adf:ba47:: with SMTP id t7mr23892301wrg.147.1584906732528; 
 Sun, 22 Mar 2020 12:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <CAL1e-=gKB0qRxGntXrU0im2gjMh1tq_SLGTm+HsmgBRGXQ9+Bg@mail.gmail.com>
 <CAFEAcA-Yn_O=G-63O1Ug9=HYqN0_o_NH_nLpWmBv2bjk2Y_85A@mail.gmail.com>
In-Reply-To: <CAFEAcA-Yn_O=G-63O1Ug9=HYqN0_o_NH_nLpWmBv2bjk2Y_85A@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 22 Mar 2020 20:51:56 +0100
Message-ID: <CAHiYmc4Qv4yL8LMp_nFqx20bq-hRO-umh5R899H6hdSyKrpNBA@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cb666405a176da14"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cb666405a176da14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

18:21 Ned, 22.03.2020. Peter Maydell <peter.maydell@linaro.org> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Sun, 22 Mar 2020 at 15:29, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> > If the "progress" (in the form of deprecation) is so impotrant, than
the authors should devise it so that there is no dammage to existing
features, and no adverse effects.
> >
> > In this light, perhaps in-tree builds deorecation is 5.0 is little
premature.
>
> The idea of deprecation is to give advance warning. So it's
> better for our users if we announce it earlier, rather than
> later. Strictly speaking our deprecation policy is for
> user-facing features, not build-time stuff, where we are...

If an end-user feature works only in in-tree builds (so, explitely said:
not in out-of-tree builds), this is not a build-time stuff, but user-facing
feature issue.

If someone is keen on removing any feature (as is truly in this case), I
expect at least some moderate investigation being done on what could be
affected (prior to announcing deprecation), rather than attitude "ok, let's
announce deprecation, see if someone start clamoring, and, if not, we are
good to go with removing". For me, this slightly disappointing.

I haven't seen anyone doing a sufficiently thourough analysis on what
happens without in-tree builds, and doesn't work in out-of-tree builds in a
proper way.

But, ok, this is just my opinion, probably unpopular within dev comunity,
since it requires additional effort by us. Still, we should guide ourself
with "what is right to do", and not "what is easy to do" principles.

Regards,
Aleksandar

> less strict about how much notice we give people. But it
> seems to me that if it's easy to give some advance notice
> then why shouldn't we do so?
>
> I agree that we should obviously make sure that everything
> that currently assumes an in-tree build also works with an
> out-of-tree build before we drop the support...
>
> (Also, if we don't announce that we're planning to drop
> support, nobody's going to report to us issues which
> we need to fix :-))
>
> thanks
> -- PMM
>

--000000000000cb666405a176da14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">18:21 Ned, 22.03.2020. Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On Sun, 22 Mar 2020 at 15:29, Aleksandar Markovic<br>
&gt; &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@g=
mail.com</a>&gt; wrote:<br>
&gt; &gt; If the &quot;progress&quot; (in the form of deprecation) is so im=
potrant, than the authors should devise it so that there is no dammage to e=
xisting features, and no adverse effects.<br>
&gt; &gt;<br>
&gt; &gt; In this light, perhaps in-tree builds deorecation is 5.0 is littl=
e premature.<br>
&gt;<br>
&gt; The idea of deprecation is to give advance warning. So it&#39;s<br>
&gt; better for our users if we announce it earlier, rather than<br>
&gt; later. Strictly speaking our deprecation policy is for<br>
&gt; user-facing features, not build-time stuff, where we are...</p>
<p dir=3D"ltr">If an end-user feature works only in in-tree builds (so, exp=
litely said: not in out-of-tree builds), this is not a build-time stuff, bu=
t user-facing feature issue.</p>
<p dir=3D"ltr">If someone is keen on removing any feature (as is truly in t=
his case), I expect at least some moderate investigation being done on what=
 could be affected (prior to announcing deprecation), rather than attitude =
&quot;ok, let&#39;s announce deprecation, see if someone start clamoring, a=
nd, if not, we are good to go with removing&quot;. For me, this slightly di=
sappointing.</p>
<p dir=3D"ltr">I haven&#39;t seen anyone doing a sufficiently thourough ana=
lysis on what happens without in-tree builds, and doesn&#39;t work in out-o=
f-tree builds in a proper way.</p>
<p dir=3D"ltr">But, ok, this is just my opinion, probably unpopular within =
dev comunity, since it requires additional effort by us. Still, we should g=
uide ourself with &quot;what is right to do&quot;, and not &quot;what is ea=
sy to do&quot; principles.</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar<br><br></p>
<p dir=3D"ltr">&gt; less strict about how much notice we give people. But i=
t<br>
&gt; seems to me that if it&#39;s easy to give some advance notice<br>
&gt; then why shouldn&#39;t we do so?<br>
&gt;<br>
&gt; I agree that we should obviously make sure that everything<br>
&gt; that currently assumes an in-tree build also works with an<br>
&gt; out-of-tree build before we drop the support...<br>
&gt;<br>
&gt; (Also, if we don&#39;t announce that we&#39;re planning to drop<br>
&gt; support, nobody&#39;s going to report to us issues which<br>
&gt; we need to fix :-))<br>
&gt;<br>
&gt; thanks<br>
&gt; -- PMM<br>
&gt;<br>
</p>

--000000000000cb666405a176da14--

