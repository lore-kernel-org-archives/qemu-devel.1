Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC79CC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 13:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208642072D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 13:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec0hEZzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208642072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEYAN-0006AF-VF
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 09:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEY9l-0005Vs-EO; Sat, 05 Sep 2020 09:23:01 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEY9j-0005JH-H8; Sat, 05 Sep 2020 09:23:01 -0400
Received: by mail-lj1-x243.google.com with SMTP id a22so4668844ljp.13;
 Sat, 05 Sep 2020 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=E+8pnMJ9WJo9FNacf7boFhQZ8kmAVvNCaI5z8cCeD3k=;
 b=Ec0hEZzfuPY7o1wPTJMwJSpKwKTnM8fQXz1WDG3zFtzgCslxnP2dcIIt8AN1l4P69W
 KA0ZB11I2cBK4GkYGvAv5Euwxdspk7Vsm5R+xG9nc3uzbF5q0Q+FTSXna/l5l9KJA+Dd
 aoC1jxho+d2at/xKecQgpj8fGZbGPX2+aibitpRPyMR6zfNsnqVvvb8miZkZDUC0Cu7J
 fLAnviycZ7i7Ih8MaU3uItVfPJ3Hp4IPaOhISiPdA4vlEPdDGDrfcZSZrKd98uj2P2Cy
 P9WxUtvrCcNylIkcA7XDexAbGoza4meCe7rf9g4AobKsoIo+i9Jqouy9AtMPBLJ9c2as
 jjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=E+8pnMJ9WJo9FNacf7boFhQZ8kmAVvNCaI5z8cCeD3k=;
 b=rdFaxFc3D0jXix6NOORAMTKefwFScQJVw3eAeE4wjPZct/S9S+5H/AemX+LZOOX+rh
 yE8rh51JvB79aJiG3TX7StAfZQDoVSqQIHmaFUzxrS8Y7w80VWN1t0TnQakR6NPUZw5h
 nidH6O5NvCzdpGT8u/tPx9tiX53cz43YeAiKxc/TmK4LSgjhXM8L8NHtcleDT2DTsslN
 RpgAULTQOHOw3FNnb96kZ22+qEcyr+J2tOVlTCcVpDUUIpBG08NESAyfoQdCp8gQrfr+
 dpsj+xHjlQh+6vqaYd48NegjupVVTkdep0T4F0Vcsxr9J+DxZji2G4KG09MeM5Qy0o7I
 3dmg==
X-Gm-Message-State: AOAM531BX4hRhUpYXNyQpU4RnATwHGiUnahHb1h/LmLrdPKf4xCbtvrE
 Ky6zyvYg32bvvuPhR+G7YlpW2Ca99s9ljlX1kJ4=
X-Google-Smtp-Source: ABdhPJyrOBfqaBvsImMczkjTURG5TPPYWqj2gNEPwhYopUn/IzdskzWwQx1TbIiD+SvsPxC3pUfJtY/4HIOf92M1hVQ=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr6563286ljj.368.1599312177594; 
 Sat, 05 Sep 2020 06:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200905062333.1087-1-luoyonggang@gmail.com>
 <20200905062333.1087-4-luoyonggang@gmail.com>
 <c71e8760-39d6-6448-40b2-ba4b2468d42b@ilande.co.uk>
In-Reply-To: <c71e8760-39d6-6448-40b2-ba4b2468d42b@ilande.co.uk>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 5 Sep 2020 21:22:45 +0800
Message-ID: <CAE2XoE_VmhJWasoaZE93A6sJsLJABKNy11AD4hr3TCowex8OFA@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] ci: fixes msys2 build by upgrading capstone to
 4.0.2
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="0000000000003b05e205ae90e2d1"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003b05e205ae90e2d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2020 at 7:14 PM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 05/09/2020 07:23, Yonggang Luo wrote:
>
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  capstone  | 2 +-
> >  configure | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/capstone b/capstone
> > index 22ead3e0bf..1d23053284 160000
> > --- a/capstone
> > +++ b/capstone
> > @@ -1 +1 @@
> > -Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
> > +Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1
> > diff --git a/configure b/configure
> > index 5d8bf4d8bb..f8cbd2898c 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5117,7 +5117,7 @@ case "$capstone" in
> >        LIBCAPSTONE=3Dlibcapstone.a
> >      fi
> >      capstone_libs=3D"-Lcapstone -lcapstone"
> > -    capstone_cflags=3D"-I${source_path}/capstone/include"
> > +    capstone_cflags=3D"-I${source_path}/capstone/include
> -I${source_path}/capstone/include/capstone"
> >      ;;
> >
> >    system)
>
> Just to reiterate from the other meson thread: the reason that the curren=
t
> capstone
> won't compile under Windows is due to
> https://bugs.launchpad.net/qemu/+bug/1826175.
>
> The merged fix from
>
> https://github.com/aquynh/capstone/commit/29893c63e34ee21846744d02c396ae3=
c801b936b
> is
> really quite simple - it might be that if upgrading is not an option then
> a suitable
> WIN32 configure hack could be used.
>
Who is responsible for capstone? Capstone is not a key component, just for
disassembly, the newest version would have more function i guess.

>
>
> ATB,
>
> Mark.
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003b05e205ae90e2d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 5, 2020 at 7:14 PM Mark C=
ave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-a=
yland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 05/09/2020 07:23, Yonggang Luo wrote:<br>
<br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 capstone=C2=A0 | 2 +-<br>
&gt;=C2=A0 configure | 2 +-<br>
&gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/capstone b/capstone<br>
&gt; index 22ead3e0bf..1d23053284 160000<br>
&gt; --- a/capstone<br>
&gt; +++ b/capstone<br>
&gt; @@ -1 +1 @@<br>
&gt; -Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf<br>
&gt; +Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1<br>
&gt; diff --git a/configure b/configure<br>
&gt; index 5d8bf4d8bb..f8cbd2898c 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -5117,7 +5117,7 @@ case &quot;$capstone&quot; in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 LIBCAPSTONE=3Dlibcapstone.a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 capstone_libs=3D&quot;-Lcapstone -lcapstone&quot;<=
br>
&gt; -=C2=A0 =C2=A0 capstone_cflags=3D&quot;-I${source_path}/capstone/inclu=
de&quot;<br>
&gt; +=C2=A0 =C2=A0 capstone_cflags=3D&quot;-I${source_path}/capstone/inclu=
de -I${source_path}/capstone/include/capstone&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ;;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 system)<br>
<br>
Just to reiterate from the other meson thread: the reason that the current =
capstone<br>
won&#39;t compile under Windows is due to <a href=3D"https://bugs.launchpad=
.net/qemu/+bug/1826175" rel=3D"noreferrer" target=3D"_blank">https://bugs.l=
aunchpad.net/qemu/+bug/1826175</a>.<br>
<br>
The merged fix from<br>
<a href=3D"https://github.com/aquynh/capstone/commit/29893c63e34ee21846744d=
02c396ae3c801b936b" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/aquynh/capstone/commit/29893c63e34ee21846744d02c396ae3c801b936b</a> is<br>
really quite simple - it might be that if upgrading is not an option then a=
 suitable<br>
WIN32 configure hack could be used.<br></blockquote><div>Who is responsible=
 for capstone? Capstone is not a key component, just for disassembly, the n=
ewest version would have more function i guess.=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
<br>
ATB,<br>
<br>
Mark.<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000003b05e205ae90e2d1--

