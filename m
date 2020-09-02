Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C41C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9583E2071B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVA5dDLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9583E2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWJP-0002Qd-NF
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDWGU-00062U-IB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:09:42 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:44824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDWGQ-0001KS-V7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:09:42 -0400
Received: by mail-lf1-x141.google.com with SMTP id 12so181416lfb.11
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=WyOhhrd84zh65NADyZCQqurVELridGgt/zS7SKwtFKE=;
 b=VVA5dDLob0XwL7mwVQl2FWeK2fV9rFohdMzQkC6OSav6NdDKlMW/gpkoNhFzLn7rFR
 Za9h9CCxHrykTblYLZwGI35748T05qyn+EBmxton/KMueH66PE5/P4DxHiuAwoDYpj1S
 oEAaTMZsjKQHmh0GwDsA1tJYyGgziG3Fo4I2BC1l9gwQGN++MG77ZU7Fhwny4UOM8kOA
 qMLHCtgHED8ArkfAUx5Xg792653aPK1uKHFmQXv44xqastFkmWhA4QIx3UACwxyzN7Vk
 43z2oH7uHshIQareB6yPaJKy4T1osUbM3pxsg/8IBoPAlCH3O4Zd3cwhmda8N/3ikkzC
 5W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=WyOhhrd84zh65NADyZCQqurVELridGgt/zS7SKwtFKE=;
 b=Iv66pdGvTreStWY1nrP6+FGdk7hbCO8UjCFBpaFEghlDu1uCI7QgDtLqkQIe1cc+v1
 sLSPMFdYL8aqXJRlvTOjSDtzLDYFobKaL5AcZpaPzblIIfuo7g2jQe4yC7gN+cKVvh+S
 k5rwWdR0arS7VBh9IzjOpnRiFBZxW1iOS1AKJaznjbu7MrLIsmMKgaVQcfddkxO4DCD+
 Tjnp500jnRhGZga7hwo838VAluyHJplDKuMBis7UyYuZtqx/8GHy4W8O2Gb1cgdaMgNC
 RzP69n+sVYO54JIwwop56prZmZ3ajq4iDGlkbKM/XMwatlHMBe643PtdnWtrTIiuJ5Pg
 h5OA==
X-Gm-Message-State: AOAM530Nobz+bKedXObIl0685VFVEFCEDw73vzicR0tLzfoWSEKw9lbw
 2A668xo89BprPiZCMxE61VAMiKXv8LyS7FlSKDQ=
X-Google-Smtp-Source: ABdhPJxuaa0U3tcSgNUMuqYCB6TcvB2vJFewAorp40UPsNPA6EcJBhTqRKHypXFIJBEvjyDkF2IQUzcwI+Xg3rtQ+/M=
X-Received: by 2002:a05:6512:690:: with SMTP id
 t16mr3730217lfe.213.1599066577126; 
 Wed, 02 Sep 2020 10:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-6-luoyonggang@gmail.com>
 <26c3fe4a-009e-dfa2-f824-515f470924b1@redhat.com>
In-Reply-To: <26c3fe4a-009e-dfa2-f824-515f470924b1@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 01:09:25 +0800
Message-ID: <CAE2XoE9-T3U0Kn4quX5P6k6V8jKs+HSTYbrjoTK=cdY3AFf11w@mail.gmail.com>
Subject: Re: [PATCH 5/6] tests: handling signal on win32 properly
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004d499105ae57b330"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004d499105ae57b330
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, waiting for it upstream.

On Thu, Sep 3, 2020 at 1:04 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 02/09/20 19:00, Yonggang Luo wrote:
> > SIGABRT should use signal(SIGABRT, sigabrt_handler) to handle on win32
> >
> > The error:
> > E:/CI-Cor-Ready/xemu/qemu.org/tests/test-replication.c:559:33: error:
> invalid use of undefined type 'struct sigaction'
> >   559 |     sigact =3D (struct sigaction) {
> >       |                                 ^
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/test-replication.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tests/test-replication.c b/tests/test-replication.c
> > index e0b03dafc2..9ab3666a90 100644
> > --- a/tests/test-replication.c
> > +++ b/tests/test-replication.c
> > @@ -554,6 +554,9 @@ static void sigabrt_handler(int signo)
> >
> >  static void setup_sigabrt_handler(void)
> >  {
> > +#ifdef _WIN32
> > +    signal(SIGABRT, sigabrt_handler);
> > +#else
> >      struct sigaction sigact;
> >
> >      sigact =3D (struct sigaction) {
> > @@ -562,6 +565,7 @@ static void setup_sigabrt_handler(void)
> >      };
> >      sigemptyset(&sigact.sa_mask);
> >      sigaction(SIGABRT, &sigact, NULL);
> > +#endif
> >  }
> >
> >  int main(int argc, char **argv)
> >
>
> This is already fixed by a patch from Thomas.
>
> Paolo
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000004d499105ae57b330
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK, waiting for it upstream.</div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 1:04 AM=
 Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 02/09/20 19:00, Yonggang Luo wrote:<br>
&gt; SIGABRT should use signal(SIGABRT, sigabrt_handler) to handle on win32=
<br>
&gt; <br>
&gt; The error:<br>
&gt; E:/CI-Cor-Ready/xemu/<a href=3D"http://qemu.org/tests/test-replication=
.c:559:33" rel=3D"noreferrer" target=3D"_blank">qemu.org/tests/test-replica=
tion.c:559:33</a>: error: invalid use of undefined type &#39;struct sigacti=
on&#39;<br>
&gt;=C2=A0 =C2=A0559 |=C2=A0 =C2=A0 =C2=A0sigact =3D (struct sigaction) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/test-replication.c | 4 ++++<br>
&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt; <br>
&gt; diff --git a/tests/test-replication.c b/tests/test-replication.c<br>
&gt; index e0b03dafc2..9ab3666a90 100644<br>
&gt; --- a/tests/test-replication.c<br>
&gt; +++ b/tests/test-replication.c<br>
&gt; @@ -554,6 +554,9 @@ static void sigabrt_handler(int signo)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void setup_sigabrt_handler(void)<br>
&gt;=C2=A0 {<br>
&gt; +#ifdef _WIN32<br>
&gt; +=C2=A0 =C2=A0 signal(SIGABRT, sigabrt_handler);<br>
&gt; +#else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct sigaction sigact;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 sigact =3D (struct sigaction) {<br>
&gt; @@ -562,6 +565,7 @@ static void setup_sigabrt_handler(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sigemptyset(&amp;sigact.sa_mask);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sigaction(SIGABRT, &amp;sigact, NULL);<br>
&gt; +#endif<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt; <br>
<br>
This is already fixed by a patch from Thomas.<br>
<br>
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--0000000000004d499105ae57b330--

