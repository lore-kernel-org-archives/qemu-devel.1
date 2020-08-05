Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F09C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5A121744
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IscuB6N6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5A121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Ixh-0005gp-GB
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 08:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1k3Iwk-0004kc-MQ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 08:55:06 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1k3Iwi-0007AJ-77
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 08:55:06 -0400
Received: by mail-lf1-x144.google.com with SMTP id c15so6902765lfi.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=NwSrvaVUQtHqn6Xhysf1L61XAmkuRccG/I8g5yNgps0=;
 b=IscuB6N6CoT46qBXohrEtbiLa/3+37pp1c+q4cSnsZGwsvlmrv5hutVgAE9lRvgWQk
 99ObjNSlAy09yVIPPyJ75Q9SaxPLvt5/34tn0wzkKvb+4d0FQnGDeMJd4JcbdVfBf4f3
 KYpRgpygbMf0fdY4CIg+iRCx0yiXcNwebmX2Ub4zl2jRDbeZ5tYpfXXbHexICralNTAD
 fqq3R1w4IUZYQQ8rsxDJGb9obBvvxGltBO1Kw16gp51DR0i8J+zWTTRcE82uv9yoD9FE
 w2Z2HaFCTKzyycy1Eav2fNRQKSlU5jhV2gsK6C+dWHmspwxHTawkbb2VU38EJKWTMY+0
 FZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=NwSrvaVUQtHqn6Xhysf1L61XAmkuRccG/I8g5yNgps0=;
 b=A0jEoSn1mred6VOPxOnBTt99zzPVwsPftBybwmYIfdoF9nUtx8dBa23D+5DIkN+nzb
 rGPa5NpGWA9oePeGX72mIICOguAG5IhhZysMQMfjmbtr8ZnoZrjtzm6lM4SUr+23ZXRi
 MXE+iVcVwNYMt9IK8ebezLFiz4KWZQbhb2ngvQUZHCqMIbbDp6TF0JTMVb+Bi6kYgfyS
 mbapDI63PElL3UiN55WJ9lA4/0KkDCdWmThstLpRhPNeAhCQQRmGpBnIJtKZdxjAnk9w
 G+AZWKQHrc5W07e6YEe7e7Ptu5VGriE+SuQBFWhJbQHT0Vsj5NRQyWs9OoSMEuiiX7x7
 Hv0g==
X-Gm-Message-State: AOAM532oktyX7bVAs7nSJeesK45sxxCLyhXAsPH2NaE2IpnLT1xMm6S9
 jNN9opxsBNxSGleAti3C9S8MDqrk2WXLxO45A+Y=
X-Google-Smtp-Source: ABdhPJwmk26LAdIIdmuUfpAnaSDj+SU/osuKanlC9wL0mUBLQr7mf21QbZrqGn9gbktoV1AuDOfySUeTWJSggSnDWjc=
X-Received: by 2002:a05:6512:1182:: with SMTP id
 g2mr1552043lfr.126.1596632100445; 
 Wed, 05 Aug 2020 05:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-12-thuth@redhat.com>
 <4cdba8c7-c6a1-e561-9e84-1dae8cf4cd04@weilnetz.de>
 <20200805091154.GD4127670@redhat.com>
In-Reply-To: <20200805091154.GD4127670@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 5 Aug 2020 20:54:48 +0800
Message-ID: <CAE2XoE_CsJ4nn+0Hurf+DacFqHzdsP-cQbZyX4pz8Hwv2LzsaA@mail.gmail.com>
Subject: Re: [PATCH 11/11] dockerfiles/debian-win64-cross: Download WHPX MinGW
 headers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002f21af05ac20e107"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-level <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002f21af05ac20e107
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixes in mingw seems not possible and would broken lots of things, the
better way may change all include of Windows API headers to lowercase,


On Wed, Aug 5, 2020 at 5:12 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Tue, Aug 04, 2020 at 08:32:18PM +0200, Stefan Weil wrote:
> > Am 04.08.20 um 19:00 schrieb Thomas Huth:
> >
> > > To compile-test the WHPX accelerator, we need to download these syste=
m
> > > headers first (they are unfortunately not part of any released and
> > > packaged MinGW toolchain yet).
> > >
> > > Idea taken from another patch by Stefan Weil.
> > >
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >  tests/docker/dockerfiles/debian-win64-cross.docker | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker
> b/tests/docker/dockerfiles/debian-win64-cross.docker
> > > index 2fc9cfcbc6..4cc4a3f365 100644
> > > --- a/tests/docker/dockerfiles/debian-win64-cross.docker
> > > +++ b/tests/docker/dockerfiles/debian-win64-cross.docker
> > > @@ -32,7 +32,14 @@ RUN apt-get update && \
> > >          mxe-$TARGET-w64-mingw32.shared-sdl2 \
> > >          mxe-$TARGET-w64-mingw32.shared-sdl2-mixer \
> > >          mxe-$TARGET-w64-mingw32.shared-sdl2-gfx \
> > > -        mxe-$TARGET-w64-mingw32.shared-zlib
> > > +        mxe-$TARGET-w64-mingw32.shared-zlib \
> > > +        curl && \
> > > +    curl -s -S -o
> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvEmulation.h \
> > > +        "
> https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-he=
aders/include/winhvemulation.h?format=3Draw"
> && \
> > > +    curl -s -S -o
> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvPlatform.h \
> > > +        "
> https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-he=
aders/include/winhvplatform.h?format=3Draw"
> && \
> > > +    curl -s -S -o
> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/winhvplatformdefs.h \
> > > +        "
> https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-he=
aders/include/winhvplatformdefs.h?format=3Draw
> "
> > >
> > >  # Specify the cross prefix for this image (see tests/docker/common.r=
c)
> > >  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dx86_64-w64-mingw32.shared-
> >
> >
> > I expect a build failure: Mingw-w64 decided to use lower case filenames=
,
> > and those header files include each other.
> >
> > We need both lower case filenames (for Mingw-w64) and camel case
> > filenames (for QEMU). That's why I used additional symlinks.
>
> Hmm, this feels wrong. Either QEMU or Mingw-w64 is broken here.
>
> Mingw-w64 needs to match whatever upper/lower case scheme that Windows
> has used for these headers. QEMU also needs to match whatever Windows
> used.
>
> Mingw originally commited the files with mixed case, and then later
> renamed then to lower case, but the commit doing the rename gives
> zero information about why it did that.
>
> The microsoft docs appear to show that camel case is required:
>
>
> https://docs.microsoft.com/en-us/virtualization/api/hypervisor-platform/h=
ypervisor-platform
>
> so I think mingw just needs fixing to revert that broken commit
> the changed to lowercase.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000002f21af05ac20e107
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Fixes in mingw seems not possible and would broken lots of=
 things, the better way may change all include of Windows API headers to lo=
wercase,<div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">On Wed, Aug 5, 2020 at 5:12 PM Daniel P. Berrang=C3=
=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, A=
ug 04, 2020 at 08:32:18PM +0200, Stefan Weil wrote:<br>
&gt; Am 04.08.20 um 19:00 schrieb Thomas Huth:<br>
&gt; <br>
&gt; &gt; To compile-test the WHPX accelerator, we need to download these s=
ystem<br>
&gt; &gt; headers first (they are unfortunately not part of any released an=
d<br>
&gt; &gt; packaged MinGW toolchain yet).<br>
&gt; &gt;<br>
&gt; &gt; Idea taken from another patch by Stefan Weil.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com=
" target=3D"_blank">thuth@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 tests/docker/dockerfiles/debian-win64-cross.docker | 9 ++++=
++++-<br>
&gt; &gt;=C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b=
/tests/docker/dockerfiles/debian-win64-cross.docker<br>
&gt; &gt; index 2fc9cfcbc6..4cc4a3f365 100644<br>
&gt; &gt; --- a/tests/docker/dockerfiles/debian-win64-cross.docker<br>
&gt; &gt; +++ b/tests/docker/dockerfiles/debian-win64-cross.docker<br>
&gt; &gt; @@ -32,7 +32,14 @@ RUN apt-get update &amp;&amp; \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mxe-$TARGET-w64-mingw32.shared-=
sdl2 \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mxe-$TARGET-w64-mingw32.shared-=
sdl2-mixer \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mxe-$TARGET-w64-mingw32.shared-=
sdl2-gfx \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 mxe-$TARGET-w64-mingw32.shared-zlib<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mxe-$TARGET-w64-mingw32.shared-zlib =
\<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 curl &amp;&amp; \<br>
&gt; &gt; +=C2=A0 =C2=A0 curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.=
shared/include/WinHvEmulation.h \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<a href=3D"https://sourceforge=
.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvem=
ulation.h?format=3Draw" rel=3D"noreferrer" target=3D"_blank">https://source=
forge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/wi=
nhvemulation.h?format=3Draw</a>&quot; &amp;&amp; \<br>
&gt; &gt; +=C2=A0 =C2=A0 curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.=
shared/include/WinHvPlatform.h \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<a href=3D"https://sourceforge=
.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvpl=
atform.h?format=3Draw" rel=3D"noreferrer" target=3D"_blank">https://sourcef=
orge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/win=
hvplatform.h?format=3Draw</a>&quot; &amp;&amp; \<br>
&gt; &gt; +=C2=A0 =C2=A0 curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.=
shared/include/winhvplatformdefs.h \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<a href=3D"https://sourceforge=
.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvpl=
atformdefs.h?format=3Draw" rel=3D"noreferrer" target=3D"_blank">https://sou=
rceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include=
/winhvplatformdefs.h?format=3Draw</a>&quot;<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 # Specify the cross prefix for this image (see tests/docker=
/common.rc)<br>
&gt; &gt;=C2=A0 ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dx86_64-w64-mingw32=
.shared-<br>
&gt; <br>
&gt; <br>
&gt; I expect a build failure: Mingw-w64 decided to use lower case filename=
s,<br>
&gt; and those header files include each other.<br>
&gt; <br>
&gt; We need both lower case filenames (for Mingw-w64) and camel case<br>
&gt; filenames (for QEMU). That&#39;s why I used additional symlinks.<br>
<br>
Hmm, this feels wrong. Either QEMU or Mingw-w64 is broken here.<br>
<br>
Mingw-w64 needs to match whatever upper/lower case scheme that Windows<br>
has used for these headers. QEMU also needs to match whatever Windows<br>
used.<br>
<br>
Mingw originally commited the files with mixed case, and then later<br>
renamed then to lower case, but the commit doing the rename gives<br>
zero information about why it did that.<br>
<br>
The microsoft docs appear to show that camel case is required:<br>
<br>
=C2=A0 <a href=3D"https://docs.microsoft.com/en-us/virtualization/api/hyper=
visor-platform/hypervisor-platform" rel=3D"noreferrer" target=3D"_blank">ht=
tps://docs.microsoft.com/en-us/virtualization/api/hypervisor-platform/hyper=
visor-platform</a><br>
<br>
so I think mingw just needs fixing to revert that broken commit<br>
the changed to lowercase.<br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--0000000000002f21af05ac20e107--

