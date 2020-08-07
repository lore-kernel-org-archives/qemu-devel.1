Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE189C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C47C20866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMvkpCZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C47C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xL0-00022z-Uk
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1k3xKL-0001cX-9w
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:02:09 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:44709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1k3xKI-0000TX-T5
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:02:09 -0400
Received: by mail-lf1-x144.google.com with SMTP id x24so523346lfe.11
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=JeiDiQ3DDofvQvCmWsne8jWJueduSiqAqI5VA78IdU4=;
 b=bMvkpCZO00wFXwBKCyawswkD6pra5mqzpJDtPDKpPXa6TUQ03MlO/KJor0DDKl7TfJ
 SSpcqeMEYygaOkCmS+atL9A5HdUNP/uKMe7FftoL5ApDRkZWYi8heu1Jhx9sh4GHCblw
 U9V6HqUYM8TtKE6Xn4vDWraw6rJSexiQN1elWeaHdbqykFz5Y2fl7qg9pVY2xjCkQHwx
 RFN5Om5NCQ7yg6BW5t9QSrW7KJc01VyWVtjDy0XlU5yO+J667kneWN4befA7dY10tMxN
 4e81u//aWZnVRdhxrKKE/JA0V7VH8j21YDi6fg2cpijUo+KOl9yasDHPHvdpGf2rdnuT
 DBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=JeiDiQ3DDofvQvCmWsne8jWJueduSiqAqI5VA78IdU4=;
 b=taZFcNN8IgzlDJ4rGjKU9YBiTFajQPT29ykNLkVRA1/UmdWbyS376eyyZJaBPDx5ry
 uLFfXqq9CD6+OqKwbZju2jAaw+nYBN7KKHYfV5tr9bsFs3rLjOhTm0eV36rq4HG759wy
 NqikBlCoqZNwYW9uGYskfnPCRmIxZ5iNQBdFoUJvu70dM2DZeqDZhgCHD6W50c+g98Om
 NwwwipOaBbrKBb8OpoDFuPoFSCgW054jU6Q7pTAfSOcVkoH1aU/BKduWwOVeJpRn9mZy
 nRUg/wqXebnGAKSZICGvZIWi3fVlcXYnHPSR6TGRKEncqSG13Qff9BFrjjvSddFeXEol
 7THA==
X-Gm-Message-State: AOAM5319dL/sDAVSU0oO4zf8MjcXEUOYzJ5mIFXoT/QFwY/V9FXQ1Od8
 crfsdlmGGOZNOBYtrxXvkbQwKoZdOQ52jYBiPxA=
X-Google-Smtp-Source: ABdhPJwW3KWwssE44fhzwXYpjeKHB5TVSxCYrj2klDNArMazc8QPCQI1oDTJN0Byyl3E/C1g8ofNf3CZZhnV2/dDLOQ=
X-Received: by 2002:a19:102:: with SMTP id 2mr5765831lfb.54.1596787324196;
 Fri, 07 Aug 2020 01:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
In-Reply-To: <20200807085302.7d7616df.cohuck@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 7 Aug 2020 16:01:53 +0800
Message-ID: <CAE2XoE_eMv_=zoEe-v1HiqcKX+FNobKSKzV=9eLkJNivnuYg-A@mail.gmail.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003d9e9205ac450581"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, armbru@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003d9e9205ac450581
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Could meson can generate CMake file or directly using CMake?
cause Cmake have better IDE support.

On Fri, Aug 7, 2020 at 2:54 PM Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu,  6 Aug 2020 21:13:56 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> > This the more or less final version of the Meson conversion.  Due to
> > the sheer size of the series you have been CCed only on the cover
> > letter.
> >
> > The series reaches the point where Makefile.target and unnest-vars
> > can be removed, and all builds become non-recursive.  I have also
> > converted parts of the testsuite, notably qtest since it is needed
> > for fuzzing.  What's left for _after_ the merge is: 1) unit tests;
> > 2) moving the rest of installation to meson (for which I have patches);
> > 3) moving feature detection from configure to meson.
> >
> > Things I still haven't tested:
> > - fuzzing
> > - non-x86/Linux builds
>
> So, I was planning to give it a go on s390, but I cannot even build it
> on x86 (fails configure):
>
> Build started at 2020-08-07T08:43:43.873638
> Main binary: /usr/bin/python3
> Build Options: -Doptimization=3D2 -Ddebug=3Dtrue -Dwerror=3Dtrue -Dstrip=
=3Dtrue
> -Db_pie=3Dtrue -Db_coverage=3Dfalse -Dsdl=3Dauto -Dsdl_image=3Dauto -Dvnc=
=3Denabled
> -Dvnc_sasl=3Dauto -Dvnc_jpeg=3Dauto -Dvnc_png=3Dauto -Dprefix=3D/usr/loca=
l
> -Dbindir=3D/usr/local/bin -Ddatadir=3D/usr/local/share
> -Dincludedir=3D/usr/local/include -Dlibdir=3D/usr/local/lib
> -Dlibexecdir=3D/usr/local/libexec -Dlocalstatedir=3D/usr/local/var
> -Dmandir=3D/usr/local/share/man -Dsysconfdir=3D/usr/local/etc
> Python system: Linux
> The Meson build system
> Version: 0.52.0
> Source dir: /home/cohuck/git/qemu
> Build dir: /home/cohuck/git/qemu/build
> Build type: native build
>
> meson.build:438:22: ERROR: Key must be a string.
>   config_target_h +=3D {target: configure_file(output: target +
> '-config-target.h',
>                       ^
> (Fedora 31, version from your github branch)
>
> Is there anything special I need to install beyond meson?
>
> > - static builds
> > - Docker and VM builds
> >
> > Things I have checked:
> > - x86 builds
> > - modules
> > - "make install"
> > - internal slirp/dtc/capstone.
> >
> > It should be more or less bisectable.  I have not tried building
> > _all_ steps, but I have tried both before and after each major one.
> >
> > Build system rebuild rules seem to work reliably.
> >
> > After a week or quite intense rebasing, my impression is more or less
> > the same as last December: Meson looks more daunting, but it is actuall=
y
> > much nicer to work with.
> >
> > The diffstat so far is not very favorable, but remember that:
> >
> > 1) the series leaves quite a few nearly-obsolete bits in configure,
> > Makefile and rules.mak (over 200 lines only in the makefiles).
> >
> > 2) configure test conversion will be where meson really shines.  I
> > included a couple examples just to show
> >
> >     meson: convert VNC and dependent libraries to meson
> >        4 files changed, 44 insertions(+), 134 deletions(-)
> >
> >     meson: move SDL and SDL-image detection to meson
> >        5 files changed, 30 insertions(+), 144 deletions(-)
> >
> >     meson: replace create-config with meson configure_file
> >        6 files changed, 80 insertions(+), 168 deletions(-)
> >
> > 3) the idea behind using Makefile generators is to have stable
> > code written in a high-level language instead of Makefile magic
> > that tends to grow by accretion.  So even though ninjatool is
> > large at 1000 lines of Python, it can already be considered mature
> > or even "done".  It had only ~15 lines changed since the last post,
> > and whenever debugging meson.build issues looking at build.ninja has
> > always (literally!) been enough.
> >
> > Available on git://github.com/bonzini/qemu branch meson-poc-next.
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

--0000000000003d9e9205ac450581
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Could meson can generate CMake file or directly using CMak=
e?<div>cause Cmake have better IDE support.</div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 7, 2020 at 2:5=
4 PM Cornelia Huck &lt;<a href=3D"mailto:cohuck@redhat.com">cohuck@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Thu,=C2=A0 6 Aug 2020 21:13:56 +0200<br>
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">=
pbonzini@redhat.com</a>&gt; wrote:<br>
<br>
&gt; This the more or less final version of the Meson conversion.=C2=A0 Due=
 to<br>
&gt; the sheer size of the series you have been CCed only on the cover<br>
&gt; letter.<br>
&gt; <br>
&gt; The series reaches the point where Makefile.target and unnest-vars<br>
&gt; can be removed, and all builds become non-recursive.=C2=A0 I have also=
<br>
&gt; converted parts of the testsuite, notably qtest since it is needed<br>
&gt; for fuzzing.=C2=A0 What&#39;s left for _after_ the merge is: 1) unit t=
ests;<br>
&gt; 2) moving the rest of installation to meson (for which I have patches)=
;<br>
&gt; 3) moving feature detection from configure to meson.<br>
&gt; <br>
&gt; Things I still haven&#39;t tested:<br>
&gt; - fuzzing<br>
&gt; - non-x86/Linux builds<br>
<br>
So, I was planning to give it a go on s390, but I cannot even build it<br>
on x86 (fails configure):<br>
<br>
Build started at 2020-08-07T08:43:43.873638<br>
Main binary: /usr/bin/python3<br>
Build Options: -Doptimization=3D2 -Ddebug=3Dtrue -Dwerror=3Dtrue -Dstrip=3D=
true -Db_pie=3Dtrue -Db_coverage=3Dfalse -Dsdl=3Dauto -Dsdl_image=3Dauto -D=
vnc=3Denabled -Dvnc_sasl=3Dauto -Dvnc_jpeg=3Dauto -Dvnc_png=3Dauto -Dprefix=
=3D/usr/local -Dbindir=3D/usr/local/bin -Ddatadir=3D/usr/local/share -Dincl=
udedir=3D/usr/local/include -Dlibdir=3D/usr/local/lib -Dlibexecdir=3D/usr/l=
ocal/libexec -Dlocalstatedir=3D/usr/local/var -Dmandir=3D/usr/local/share/m=
an -Dsysconfdir=3D/usr/local/etc<br>
Python system: Linux<br>
The Meson build system<br>
Version: 0.52.0<br>
Source dir: /home/cohuck/git/qemu<br>
Build dir: /home/cohuck/git/qemu/build<br>
Build type: native build<br>
<br>
meson.build:438:22: ERROR: Key must be a string.<br>
=C2=A0 config_target_h +=3D {target: configure_file(output: target + &#39;-=
config-target.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^<br>
(Fedora 31, version from your github branch)<br>
<br>
Is there anything special I need to install beyond meson?<br>
<br>
&gt; - static builds<br>
&gt; - Docker and VM builds<br>
&gt; <br>
&gt; Things I have checked:<br>
&gt; - x86 builds<br>
&gt; - modules<br>
&gt; - &quot;make install&quot;<br>
&gt; - internal slirp/dtc/capstone.<br>
&gt; <br>
&gt; It should be more or less bisectable.=C2=A0 I have not tried building<=
br>
&gt; _all_ steps, but I have tried both before and after each major one.<br=
>
&gt; <br>
&gt; Build system rebuild rules seem to work reliably.<br>
&gt; <br>
&gt; After a week or quite intense rebasing, my impression is more or less<=
br>
&gt; the same as last December: Meson looks more daunting, but it is actual=
ly<br>
&gt; much nicer to work with.<br>
&gt; <br>
&gt; The diffstat so far is not very favorable, but remember that:<br>
&gt; <br>
&gt; 1) the series leaves quite a few nearly-obsolete bits in configure,<br=
>
&gt; Makefile and rules.mak (over 200 lines only in the makefiles).<br>
&gt; <br>
&gt; 2) configure test conversion will be where meson really shines.=C2=A0 =
I<br>
&gt; included a couple examples just to show<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0meson: convert VNC and dependent libraries to meson=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 4 files changed, 44 insertions(+), 134 dele=
tions(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0meson: move SDL and SDL-image detection to meson<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 5 files changed, 30 insertions(+), 144 dele=
tions(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0meson: replace create-config with meson configure_f=
ile<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 6 files changed, 80 insertions(+), 168 dele=
tions(-)<br>
&gt; <br>
&gt; 3) the idea behind using Makefile generators is to have stable<br>
&gt; code written in a high-level language instead of Makefile magic<br>
&gt; that tends to grow by accretion.=C2=A0 So even though ninjatool is<br>
&gt; large at 1000 lines of Python, it can already be considered mature<br>
&gt; or even &quot;done&quot;.=C2=A0 It had only ~15 lines changed since th=
e last post,<br>
&gt; and whenever debugging meson.build issues looking at build.ninja has<b=
r>
&gt; always (literally!) been enough.<br>
&gt; <br>
&gt; Available on git://<a href=3D"http://github.com/bonzini/qemu" rel=3D"n=
oreferrer" target=3D"_blank">github.com/bonzini/qemu</a> branch meson-poc-n=
ext.<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--0000000000003d9e9205ac450581--

