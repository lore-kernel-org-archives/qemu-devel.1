Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E2EC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFBD2098B
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKSXu1Md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFBD2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJec5-0000eR-Nz
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 11:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kJeaZ-0008Kn-VY; Sat, 19 Sep 2020 11:15:47 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:36322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kJeaY-00018j-0v; Sat, 19 Sep 2020 11:15:47 -0400
Received: by mail-ed1-x542.google.com with SMTP id w1so8850960edr.3;
 Sat, 19 Sep 2020 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ezbm6VQCb+iAgYQhoTugET5iatEBh4zyCmsFhsX85Hc=;
 b=vKSXu1MdB0ZS4bs4C9lp4I7AWshlktEwoiq88QvbTHb6k1kpy8uZJmc4OrK1N/tbXy
 qpCU5wp/vXaqc9LpBF3D8L9mEdyXyP+FuP0DvBBj+8Ydw66Muxi4cMstOl6n46B8jhg2
 FW75JKz3I1Kq51bL0ScQoy9vTei99aGh/qabP80nSW7MHX59yNXgThZQxODIC6VU+Po3
 AoZkAx+wiC0BpcaVB/AsJaDSVX+xe2n8hzpFfZRANN+1ge293harL+AH5bHUQc/G2pc4
 VK2zbOsCaxFiFa1YzfnZ/gUfHmG1arsrOzKCjlcvbmhrH2dVOnxiyAVW5hM06644IJEK
 jQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ezbm6VQCb+iAgYQhoTugET5iatEBh4zyCmsFhsX85Hc=;
 b=UZ52soPQUE8sdHPmKUE2j31P1ppRSFUR/SPkB7eutEJTWcSCnHI8plLxFEsadc5kxi
 hUhIFLaciAX8vaY9+JpTdoKkPWbpFzsIlFqpejWhajv3ZabLvLquZwpJGR0AznoK87Nk
 Xjd3b1T4R3EthRyJUMswYymw3ZHRcaIQBx5zZQ7OxD4PapyaoAElnTqMEKtqWFs3zxk7
 oGmiQDZU6JxSnb9XIGQPdNjrnp9AxMS3Dj67m8FciEEsIOzmUhATba5P3XEK2/buNEdP
 p9nMqh7SSpGSFTy5G1cDiinRIn/oSygzI1qxsxlZ/elmL0NBDDuEpV8PH249FkEeob6F
 lAIA==
X-Gm-Message-State: AOAM531BJ0Jzcwp8JebPYCWaPxqCgqGThePHqPIt8ulX5+jCTgsjpSql
 7ycN3smCTpJJPGlOts/81EjTbxPfEwPOReO9HsA=
X-Google-Smtp-Source: ABdhPJym7hMPOv1vOwnbAPeqSgzAPr89/yotQFf3oO6S5UMj89l+vm0lUmUt5gLzyKs5FQf077GgGjXb7pkvamiaWGQ=
X-Received: by 2002:aa7:dd0d:: with SMTP id i13mr44571511edv.314.1600528543561; 
 Sat, 19 Sep 2020 08:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200918204759.225810-1-marcandre.lureau@redhat.com>
 <0e14e115-797d-b91b-dec5-7a2a26836d92@redhat.com>
In-Reply-To: <0e14e115-797d-b91b-dec5-7a2a26836d92@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 19 Sep 2020 19:15:31 +0400
Message-ID: <CAJ+F1C+NDS=M+JDbAyU9itvHkBKvjCS3gtn2P1T2nvYbnn+8JA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Convert pc-bios Makefiles to meson
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004abb9505afac1799"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x542.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Qemu-s390x list <qemu-s390x@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004abb9505afac1799
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Sep 19, 2020 at 6:59 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 18/09/20 22:47, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > Here is a series of patches to convert the remaining Makefile in
> > pc-bios/ to meson. I have done various tests to check that the
> > resulting binaries are working as expected, but I didn't cover it
> > all, and I am not sure the test su=3D ite covers them all either.
>
> I don't know, the way pc-bios/ works seems just wrong to me.  pc-bios
> should IMO be its own build system with support for docker-based cross
> compilers similar to tests/tcg.
>

It could still use meson to build the binaries though (like we did for
qboot). It's more about setting up the environment for the build to compile
for the target.


> In fact one thing I was considering before falling in love with Meson :)
> was to write a simple meta-build-system for all of QEMU-owned ROMs,
> submodules such as SLOF and tests/tcg.  I never even got to the
> whiteboard phase, but if this were done, we could just build all the
> firmwares as a Meson 0.56 "external project"[1].
>
> Paolo
>
> [1]
> https://github.com/mesonbuild/meson/commit/master#diff-3a49da052fafbb5026=
73f20d188644e1
>

I suppose you meant:
https://github.com/mesonbuild/meson/commit/9d338200dacdf24c50259c309380200f=
8a53d5b5

fwiw, this version doesn't compile with gcc 4.8 (on centos6, as patchew
found out). I couldn't find a workaround yet. :(



--=20
Marc-Andr=C3=A9 Lureau

--0000000000004abb9505afac1799
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 19, 2020 at 6:59 PM Pao=
lo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 18/09/20 22:47, <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_=
blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; Here is a series of patches to convert the remaining Makefile in<br>
&gt; pc-bios/ to meson. I have done various tests to check that the<br>
&gt; resulting binaries are working as expected, but I didn&#39;t cover it<=
br>
&gt; all, and I am not sure the test su=3D ite covers them all either.<br>
<br>
I don&#39;t know, the way pc-bios/ works seems just wrong to me.=C2=A0 pc-b=
ios <br>
should IMO be its own build system with support for docker-based cross <br>
compilers similar to tests/tcg.<br></blockquote><div><br></div><div>It coul=
d still use meson to build the binaries though (like we did for qboot). It&=
#39;s more about setting up the environment for the build to compile for th=
e target.<br></div><div> <br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
In fact one thing I was considering before falling in love with Meson :) <b=
r>
was to write a simple meta-build-system for all of QEMU-owned ROMs, <br>
submodules such as SLOF and tests/tcg.=C2=A0 I never even got to the <br>
whiteboard phase, but if this were done, we could just build all the <br>
firmwares as a Meson 0.56 &quot;external project&quot;[1].<br>
<br>
Paolo<br>
<br>
[1] <a href=3D"https://github.com/mesonbuild/meson/commit/master#diff-3a49d=
a052fafbb502673f20d188644e1" rel=3D"noreferrer" target=3D"_blank">https://g=
ithub.com/mesonbuild/meson/commit/master#diff-3a49da052fafbb502673f20d18864=
4e1</a><br></blockquote><div><br></div><div>I suppose you meant: <a href=3D=
"https://github.com/mesonbuild/meson/commit/9d338200dacdf24c50259c309380200=
f8a53d5b5">https://github.com/mesonbuild/meson/commit/9d338200dacdf24c50259=
c309380200f8a53d5b5</a></div><div><br></div><div>fwiw, this version doesn&#=
39;t compile with gcc 4.8 (on centos6, as patchew found out). I couldn&#39;=
t find a workaround yet. :(<br></div><div> <br></div></div><br clear=3D"all=
"><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lur=
eau<br></div></div>

--0000000000004abb9505afac1799--

