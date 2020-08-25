Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D74C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52C62067C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj9k0fat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52C62067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAV02-00018x-0S
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 05:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUzV-0000iK-1j
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:11:41 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUzT-00051J-DO
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:11:40 -0400
Received: by mail-lj1-x241.google.com with SMTP id w14so12949095ljj.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=ub5RKdkaNN/lEwSq5HQOH1UAn6HlBWZ83xe3Dlr6mKc=;
 b=Nj9k0fatoZpHmZQzYAfSgpZ57VQ3R+J9y+nGkjBE/MT3AxwUHcykB6sGAIhE3JctXg
 MhLNy/JgwWqbaVKHs2R1bMbCi/rSoTYUiJT83x0mTdZ+lHxENI9OTdd7a+WyeYlurL/O
 p5D2ow9+0vDT/uSJW5BGH1SJcvg+V+mOTSq77LKXvDwaKBb2tptnWPLWXoDs/6WYbRvU
 YpOJggM//pJpdKeTTAaC5CUKlXCCPkzdsfI2z3+5A1qAYIbH0cRZ6TOMJKNROdvtt27O
 v2Z8skJbk0KtMy1Z93dYkN4l48MaQI20PQte5A0otiRzKmPwqNYxXjPxEZMwoUQTrWz3
 rBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=ub5RKdkaNN/lEwSq5HQOH1UAn6HlBWZ83xe3Dlr6mKc=;
 b=klRTAIIbhOiRJ/AAI3m0cmin2/zpRuB9nxbKy189nu0zc8oBmlCWTVA0Va40JVhYw7
 FiDFFTfKP4LeotDjhSPmAX+iycteYOQYgR1Ruaid7rwSLb6wOOdmnoIN0uIIFkPZZ4n7
 aLj1gpnBaIppvVmhhaoJ1duebXcDkJuBDbNpZPoQyVNdgpnjT3sE0zZcvowjGH1wdeMr
 chGJbxo5JbjImzL+XVUFvlouRKB5M8hjX2HgfepZdimUQmtw3F2kyUsJKUdR037ByNpK
 4ZdIH+U3UOWA0LCYNyDlIusKjlNIt/EmhePAoOJovkk8hyPfHGRoY1BR4EE7VRQxJXKL
 NGcA==
X-Gm-Message-State: AOAM531NGlxzY0567PVPlDhnxnJYCu3cpGckrz4WE0I/rzIrHXRXzdd0
 nWoX3qtY7YEcJkPFgra56OCE2bRiY8kV+YE4Vmw=
X-Google-Smtp-Source: ABdhPJxnuXVcby0OzkucqlYUsGdnwfqkSeHdmE9G1F8m5GVSL1f5DIFbiAKAyFbJp3Utuzae/+aqxUxF/S7Qsi7E+Qg=
X-Received: by 2002:a2e:9a8e:: with SMTP id p14mr4065999lji.300.1598346697389; 
 Tue, 25 Aug 2020 02:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200825083500.359-1-luoyonggang@gmail.com>
 <20200825083500.359-4-luoyonggang@gmail.com>
 <20200825085949.GC107278@redhat.com>
In-Reply-To: <20200825085949.GC107278@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 25 Aug 2020 17:11:26 +0800
Message-ID: <CAE2XoE_jgZg8wjKZ5J5gPaR5VLORosJDv3+kr=re+LHqzbNoVg@mail.gmail.com>
Subject: Re: [PATCH 4/5] meson: !/bin/sh are msys2 friendly.
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000203b1805adb01709"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000203b1805adb01709
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, works, msys2 sh compiled and run

On Tue, Aug 25, 2020 at 4:59 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Tue, Aug 25, 2020 at 04:34:59PM +0800, luoyonggang@gmail.com wrote:
> > From: Yonggang Luo <luoyonggang@gmail.com>
> >
> > ---
> >  scripts/undefsym.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh
> > index b9ec332e95..8189308b2c 100755
> > --- a/scripts/undefsym.sh
> > +++ b/scripts/undefsym.sh
> > @@ -1,4 +1,4 @@
> > -#! /usr/bin/env bash
> > +#!/bin/sh
>
> Does this script actually work on non-bash shells ?  If not, then this
> change will likely break on plaforms where /bin/sh is not bash.
>
> >
> >  # Before a shared module's DSO is produced, a static library is built
> for it
> >  # and passed to this script.  The script generates -Wl,-u options to
> force
> > --
> > 2.27.0.windows.1
> >
> >
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

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000203b1805adb01709
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, works, msys2 sh compiled and run</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2020=
 at 4:59 PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.c=
om">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Tue, Aug 25, 2020 at 04:34:59PM +0800, <a href=3D=
"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a> =
wrote:<br>
&gt; From: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=
=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; <br>
&gt; ---<br>
&gt;=C2=A0 scripts/undefsym.sh | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh<br>
&gt; index b9ec332e95..8189308b2c 100755<br>
&gt; --- a/scripts/undefsym.sh<br>
&gt; +++ b/scripts/undefsym.sh<br>
&gt; @@ -1,4 +1,4 @@<br>
&gt; -#! /usr/bin/env bash<br>
&gt; +#!/bin/sh<br>
<br>
Does this script actually work on non-bash shells ?=C2=A0 If not, then this=
<br>
change will likely break on plaforms where /bin/sh is not bash.<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Before a shared module&#39;s DSO is produced, a static library=
 is built for it<br>
&gt;=C2=A0 # and passed to this script.=C2=A0 The script generates -Wl,-u o=
ptions to force<br>
&gt; -- <br>
&gt; 2.27.0.windows.1<br>
&gt; <br>
&gt; <br>
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
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000203b1805adb01709--

