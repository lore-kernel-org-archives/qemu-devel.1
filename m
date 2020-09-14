Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0089CC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F7C217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/B2j5zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F7C217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrvy-0001l1-54
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 13:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHqI2-0005EF-BD; Mon, 14 Sep 2020 11:21:10 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:43465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHqHy-0002R0-UN; Mon, 14 Sep 2020 11:21:10 -0400
Received: by mail-lj1-x234.google.com with SMTP id u4so18973890ljd.10;
 Mon, 14 Sep 2020 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=wiBPlbHq0ocqw4fuwVjBBbjEGqDi4667VPPjPjKXhg4=;
 b=e/B2j5zQ6aPAhIwzTxD1NSYWa8hF1przpbOMS+8b8d09Y1stXYm6JWmx353lJA4F8l
 EuFkxcRI4BP2+t+WJH9uipowKd7c8l+hruQ2VS7sVekuUEM11GRAzlCIFtJAbVtysFO0
 9Kbj8TbhuUtPQn4t78qgVNDMQzYKEMKqmiZInabhO0LZ6gKaoMtfkRugVbSD8v0e3QlP
 iJE+cuHlQOqriRfO3KrODkCVIgH155PfNSfSb1x9t6oVdov/q9MqMXEKg5IdKEYMkFJj
 fc8gfyU/ebf+tBNfGzLEORWRaNBrnKgQYxT2/Lh2NBB1ypsu8v6M9t4SavJCQ59ix/bS
 0O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=wiBPlbHq0ocqw4fuwVjBBbjEGqDi4667VPPjPjKXhg4=;
 b=lAuE4t3avn6mZIOyTVMR9LkzB7UVgd65ZPUdmL2yqO4+PpF+qPbxMt48OIshTvMAbA
 i/kKAxbj3hKQz7uIgce9SWiiHBTWmDfIPjEYD4GSRoQ5o5fv7TOGPvFvkyBn8M4aN2vf
 lIRI3KfmsIUOKK4nIlO9DET31iNQs19Qw4bpY5yiXGM45hortZIKoq6Xu0uv+zQSw7Kf
 5rvPppLC1Hgq1EBC0eyLAMMVjFhhziR7n4rbD5Hp49zmho6Xy0Xzxf24fjguRqK+DKeO
 cCRr+3p0y0TneT/AnSFpQGfgj5lFqk6AR0XKD35mkvPYRKntRdgStfh//hrrD0/3MdVy
 T09w==
X-Gm-Message-State: AOAM53221HR1IGb3JzJExadnV0ZYyUItT1NmOw3xRvmrMhHZ+8Pj1ET3
 RUueUOryU6dRCXjJyf1zq5esdtB3cvL5x4LPo/g=
X-Google-Smtp-Source: ABdhPJwVnaaK/ZOtZDnYp0SvyhzRI9Wda2J6G00UTL5mzVUtz3ODlHZNvy4wfpPdxX0BcpOP0j5yh6MH60BTMAxLzPo=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr5654600ljj.368.1600096864173; 
 Mon, 14 Sep 2020 08:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-12-luoyonggang@gmail.com>
 <c6ed5abf-2c71-bded-7efc-33baa0b415af@redhat.com>
 <CAE2XoE-mFPm=chadNahHgCsa3tSjxRXMH3te29ODV=emWdLjYA@mail.gmail.com>
 <d6dd1c31-4bf0-3fd0-4c32-7216c8b3435c@redhat.com>
 <CAFEAcA98VD2f3TQBDrfFv4swwu2Txhs2KXXKiHgFGsN7P_B3AQ@mail.gmail.com>
In-Reply-To: <CAFEAcA98VD2f3TQBDrfFv4swwu2Txhs2KXXKiHgFGsN7P_B3AQ@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 23:20:52 +0800
Message-ID: <CAE2XoE_mD-0=1-9cLrQAqxsX4J1Ji9mV6pVSg6+JqmEdtzuUfA@mail.gmail.com>
Subject: Re: [PATCH v8 11/27] meson: Use -b to ignore CR vs. CR-LF issues on
 Windows
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003206ff05af4795a2"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x234.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003206ff05af4795a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 10:41 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Sun, 13 Sep 2020 at 19:51, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
> wrote:
> >
> > On 9/13/20 6:01 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > >
> > >
> > > On Sun, Sep 13, 2020 at 11:35 PM Philippe Mathieu-Daud=C3=A9
> > > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> > >
> > >     On 9/13/20 12:44 AM, Yonggang Luo wrote:
> > >     > On windows, a difference in line endings causes testsuite
> failures
> > >     > complaining that every single line in files such as
> > >     > 'tests/qapi-schemadoc-good.texi' is wrong.  Fix it by adding -b
> to
> > >     diff.
> > >
> > >     Isn't '--strip-trailing-cr' more adapted?
> > >
> > > er, I did that before.....
> >
> > So, yes/no? We can not follow all patches, so better if you
> > add a note about your changes, either in the patch description
> > if you think it's worthwhile keeping that information in the
> > git history, else below the '---' separator, so that information
> > is stripped from the patch when applying.
> >
> > Looking at the archive I see Thomas said this option is not
> > POSIX thus not portable.
> >
> > What about adding this?
> >
> > "Ideally we would use the '--strip-trailing-cr' option, but not
> > being POSIX is a portability problem (i.e. BSDs and Solaris
> > based OSes). Instead use the '-b' option which, although doing
> > slightly more, produce the expected result on Windows."
>
> The other important point to note here is that because
> texi output is mostly not case-sensitive, we are not
> losing important test coverage by not checking for exact
> whitespace matches between the known-good output and
> the generated output. If we were checking the doc-good.out
> text file, -b would be bad because there whitespace is
> important and is part of what we need to be checking.
>
> (Also the texi stuff is going to go away soon I hope :-))
>
So continue with -b are accepted? or I just diable it on win32?

>
> thanks
> -- PMM
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003206ff05af4795a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 14, 2020 at 10:41 PM Pete=
r Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lin=
aro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Sun, 13 Sep 2020 at 19:51, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; On 9/13/20 6:01 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<b=
r>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Sun, Sep 13, 2020 at 11:35 PM Philippe Mathieu-Daud=C3=A9<br>
&gt; &gt; &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd=
@redhat.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_=
blank">philmd@redhat.com</a>&gt;&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0On 9/13/20 12:44 AM, Yonggang Luo wrote:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; On windows, a difference in line endings =
causes testsuite failures<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; complaining that every single line in fil=
es such as<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; &#39;tests/qapi-schemadoc-good.texi&#39; =
is wrong.=C2=A0 Fix it by adding -b to<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0diff.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Isn&#39;t &#39;--strip-trailing-cr&#39; more a=
dapted?<br>
&gt; &gt;<br>
&gt; &gt; er, I did that before.....<br>
&gt;<br>
&gt; So, yes/no? We can not follow all patches, so better if you<br>
&gt; add a note about your changes, either in the patch description<br>
&gt; if you think it&#39;s worthwhile keeping that information in the<br>
&gt; git history, else below the &#39;---&#39; separator, so that informati=
on<br>
&gt; is stripped from the patch when applying.<br>
&gt;<br>
&gt; Looking at the archive I see Thomas said this option is not<br>
&gt; POSIX thus not portable.<br>
&gt;<br>
&gt; What about adding this?<br>
&gt;<br>
&gt; &quot;Ideally we would use the &#39;--strip-trailing-cr&#39; option, b=
ut not<br>
&gt; being POSIX is a portability problem (i.e. BSDs and Solaris<br>
&gt; based OSes). Instead use the &#39;-b&#39; option which, although doing=
<br>
&gt; slightly more, produce the expected result on Windows.&quot;<br>
<br>
The other important point to note here is that because<br>
texi output is mostly not case-sensitive, we are not<br>
losing important test coverage by not checking for exact<br>
whitespace matches between the known-good output and<br>
the generated output. If we were checking the doc-good.out<br>
text file, -b would be bad because there whitespace is<br>
important and is part of what we need to be checking.<br>
<br>
(Also the texi stuff is going to go away soon I hope :-))<br></blockquote><=
div>So continue with -b are accepted? or I just diable it on win32?=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000003206ff05af4795a2--

