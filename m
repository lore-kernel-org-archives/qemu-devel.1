Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983CFC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 16:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0282D206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 16:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvDecYJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0282D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEasp-0001er-0u
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 12:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEasD-0001EI-MN; Sat, 05 Sep 2020 12:17:05 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEasC-0001OL-1H; Sat, 05 Sep 2020 12:17:05 -0400
Received: by mail-lf1-x141.google.com with SMTP id z19so5429481lfr.4;
 Sat, 05 Sep 2020 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=kfNUOsDC89EMdfo5rOFf25IYWglstzJRg8nlS3U2lxM=;
 b=RvDecYJGFXZQ54kdgzHucEIeC41IGGirO6rpOcRgfrlKkDxZY8EUZ6XTI2HqrEGEjB
 qSm2sVOc16tFZfMYMIhL6nvfTulaU0L6Bm50S1Or9V6Tt4OVAtM7k/Yt3sLhYS5Sx/Gz
 QCCFpA3Eb/oJUiTTlzuv6+FGdhbwgHFYG4MxzUaTao52A+KSXTEsLlZktcc6t7Bn8dos
 WfmHeNjpjSK0rDo9/XQUajGk0SAtEE/4/a20qq5DOYo4pLuU9cShqC0PbCtlCcatOSq1
 Hg6EmgzcTChot1d6bA37a1D70vX414h0aSmrOu+KRutxvluh8ka+3BFnmq+dAWgZHQlx
 PAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=kfNUOsDC89EMdfo5rOFf25IYWglstzJRg8nlS3U2lxM=;
 b=il5ueskKPD8Z/CWCUk7PO98xnEGyY7ROVjB9kzTDSnbNLAx6H555UQVxM5n3Fiannp
 AUssAa7HV6Nq9HPaG/vyhCEOSdpscZsz2tT5oVZ+LEUAcSrOCLFf0Z1Oj9E8Ob3X8Sbp
 s9xNogT4goYlT/1LNvAX2t35tXJg893/OUj4I59Un4Hax5mkwPvszyg4DqOEc5qx4PJl
 FWaaCzIW0FtYdQc4nIpxMTb1eTtkHWVxHYb8qLkBqjsGmYHY7o3b9wktnqLvNWrDGEhz
 9PTp5sYU0kQsDjZB3DDAZ3ldDc2FT6bQ/Nv/FPVhU9jNqgOr7OSxM7kzth6QVkQXCbdD
 IB+w==
X-Gm-Message-State: AOAM530TCtXZoc0Y1Lqchi7GTdeJQh87sNIXIAracpGpfHIRJEqcrQmO
 nQ7CDtKnFZ6MhaecH7ZFQ0jzLnV7M3pggqu+1Sg=
X-Google-Smtp-Source: ABdhPJxxWOXLTIg30ouzr780aHl1/8tLwkVVrPDZ3WY89CscL3A0e0tcT7gf0Xplk7CSswX4TAZJ6XJY9JaYwFBFU3U=
X-Received: by 2002:a19:b83:: with SMTP id 125mr2265388lfl.126.1599322621911; 
 Sat, 05 Sep 2020 09:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200905063813.1875-1-luoyonggang@gmail.com>
 <aed3143c-5bf5-3b40-2c7c-1db2ac43f4c9@redhat.com>
In-Reply-To: <aed3143c-5bf5-3b40-2c7c-1db2ac43f4c9@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 6 Sep 2020 00:16:50 +0800
Message-ID: <CAE2XoE-456_zDPo46nH2erB6t8NrF5jpfRT7UcCtsCF7ts_H7Q@mail.gmail.com>
Subject: Re: [PATCH] tests: fixes test-vmstate.c compile error on msys2
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c2a5f305ae93505b"
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c2a5f305ae93505b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2020 at 4:48 PM Thomas Huth <thuth@redhat.com> wrote:

> On 05/09/2020 08.38, Yonggang Luo wrote:
> > ../tests/test-vmstate.c: In function 'int_cmp':
> > ../tests/test-vmstate.c:884:5: error: unknown type name 'uint'; did you
> mean 'uInt'?
> >   884 |     uint ua =3D GPOINTER_TO_UINT(a);
> >       |     ^~~~
> >       |     uInt
> > ../tests/test-vmstate.c:885:5: error: unknown type name 'uint'; did you
> mean 'uInt'?
> >   885 |     uint ub =3D GPOINTER_TO_UINT(b);
> >       |     ^~~~
> >       |     uInt
> > make: ***
> [Makefile.ninja:5461=EF=BC=9Atests/test-vmstate.exe.p/test-vmstate.c.obj]=
 =E9=94=99=E8=AF=AF 1
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/test-vmstate.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> > index f7b3868881..f8de709a0b 100644
> > --- a/tests/test-vmstate.c
> > +++ b/tests/test-vmstate.c
> > @@ -881,8 +881,8 @@ static gint interval_cmp(gconstpointer a,
> gconstpointer b, gpointer user_data)
> >  /* ID comparison function */
> >  static gint int_cmp(gconstpointer a, gconstpointer b, gpointer
> user_data)
> >  {
> > -    uint ua =3D GPOINTER_TO_UINT(a);
> > -    uint ub =3D GPOINTER_TO_UINT(b);
> > +    guint ua =3D GPOINTER_TO_UINT(a);
> > +    guint ub =3D GPOINTER_TO_UINT(b);
> >      return (ua > ub) - (ua < ub);
> >  }
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> Does this means quened or to be queued, if that's true, will skip this
next revision


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000c2a5f305ae93505b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 5, 2020 at 4:48 PM Thomas=
 Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 05/09/2020=
 08.38, Yonggang Luo wrote:<br>
&gt; ../tests/test-vmstate.c: In function &#39;int_cmp&#39;:<br>
&gt; ../tests/test-vmstate.c:884:5: error: unknown type name &#39;uint&#39;=
; did you mean &#39;uInt&#39;?<br>
&gt;=C2=A0 =C2=A0884 |=C2=A0 =C2=A0 =C2=A0uint ua =3D GPOINTER_TO_UINT(a);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0uInt<br>
&gt; ../tests/test-vmstate.c:885:5: error: unknown type name &#39;uint&#39;=
; did you mean &#39;uInt&#39;?<br>
&gt;=C2=A0 =C2=A0885 |=C2=A0 =C2=A0 =C2=A0uint ub =3D GPOINTER_TO_UINT(b);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0uInt<br>
&gt; make: *** [Makefile.ninja:5461=EF=BC=9Atests/test-vmstate.exe.p/test-v=
mstate.c.obj] =E9=94=99=E8=AF=AF 1<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/test-vmstate.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c<br>
&gt; index f7b3868881..f8de709a0b 100644<br>
&gt; --- a/tests/test-vmstate.c<br>
&gt; +++ b/tests/test-vmstate.c<br>
&gt; @@ -881,8 +881,8 @@ static gint interval_cmp(gconstpointer a, gconstpo=
inter b, gpointer user_data)<br>
&gt;=C2=A0 /* ID comparison function */<br>
&gt;=C2=A0 static gint int_cmp(gconstpointer a, gconstpointer b, gpointer u=
ser_data)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 uint ua =3D GPOINTER_TO_UINT(a);<br>
&gt; -=C2=A0 =C2=A0 uint ub =3D GPOINTER_TO_UINT(b);<br>
&gt; +=C2=A0 =C2=A0 guint ua =3D GPOINTER_TO_UINT(a);<br>
&gt; +=C2=A0 =C2=A0 guint ub =3D GPOINTER_TO_UINT(b);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return (ua &gt; ub) - (ua &lt; ub);<br>
&gt;=C2=A0 }<br>
<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank">thuth@redhat.com</a>&gt;<br>
<br></blockquote><div>Does this means quened or to be queued, if that&#39;s=
 true, will skip this next revision=C2=A0</div></div><br clear=3D"all"><div=
><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=
=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></d=
iv>

--000000000000c2a5f305ae93505b--

