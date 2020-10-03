Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A416C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE56C206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwSeFbBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE56C206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOcvD-0001j8-GL
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 04:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOctu-0000qk-33
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:28:18 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOctr-0001bb-E1
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:28:17 -0400
Received: by mail-lj1-x241.google.com with SMTP id 133so87167ljj.0
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=T4anAKplHNSeyc7BxRDoU2nLIH0bgFPoKFD+Q+0y5UU=;
 b=uwSeFbBckHvh61yiSpgOgkwSdHdnV2KPIY3vXQdd2v26CnUZjG3adXKAZrI+Xe6ZCz
 0XmZRCFxoJZDTjqTMtS+Bxh65pIPrbLhTAV5gMr/qzF8RNxcUQPY7wDG2b153ZhE/yIu
 aA6kfSdRSiVW+Rsc8U5MTSjqLk12VL1dw2AoUAJwpXhqHkr+pSPdgdIjmLqYSM5I9ysX
 DWdsJeq9BwvZzAD5Kkq0ATa44g2LdDQbT4bVh2dzhxviP/n+pDx2YWESSnGAL3lnvIpH
 vkaJ1RnBhN6acgoQCKMtoNOgooHfoX9BnuV7bFSfP053oaRHTzLxgTXPk5p1x5QweLNl
 rgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=T4anAKplHNSeyc7BxRDoU2nLIH0bgFPoKFD+Q+0y5UU=;
 b=M6MscZST0BJTqL1Y/19Gcs+olomL20tqIvoRyycqY4SuqP3kjwupZSB50HD3ojTL2y
 OPKfUDnQHMVZqhf5uYpvfDWIss0tbyFfhc7xKAb41lj07uiFZeuFE0ZXtLg4mYecdRCb
 k3Bfp8egUwrxAowkCAy4Z+3PvRIRveMF/+cfunvmR0pBLcP1CzEm3yDphUW/cxHel5k9
 1f21DkxaYJRGJKKKTuZPwOPtYZo0rCGqABkSbt4FrUJpFJ0joTMsgWMc7dcnQPsGibq0
 riky73WiMwXPt2e60jk0foDFbFI5SA5Zj6LdCY1kw52ogcuovncTg4vzdf7JcEhsG3EN
 kJtw==
X-Gm-Message-State: AOAM531UTSjiIXPl9yhxJL+F/pvmC7BUeriqWoWYEehKp8Gt4fda+VEF
 UFJ2tosb6LBQVi4XtTGtMZ7fVzohkC6fEy+7M4o=
X-Google-Smtp-Source: ABdhPJxA/RX7VlGF4Zh/JvVBGMPC6dTJIALPw48QEo5npjD7yEN7dn5e/pboYA8e/6a+NqKFSQjgU8f4tDT3o0bNRgQ=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr1875487ljj.447.1601713690095; 
 Sat, 03 Oct 2020 01:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
 <CAE2XoE-RnJ2j732JfxDA2A9O0Bp4KJ2rGG0LTjrDMKvRox-VBg@mail.gmail.com>
 <d6417044-324c-0bec-a05c-1142dcdc6003@redhat.com>
In-Reply-To: <d6417044-324c-0bec-a05c-1142dcdc6003@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2020 16:28:00 +0800
Message-ID: <CAE2XoE-Z0E1TSn1pHfBK=7vcGL9qkxVwwxMOg3KhqaMMdJidiA@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000087b3e705b0c00781"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000087b3e705b0c00781
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2020 at 3:50 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/10/20 09:24, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >
> > On Fri, Oct 2, 2020 at 9:11 PM Peter Maydell <peter.maydell@linaro.org
> > <mailto:peter.maydell@linaro.org>> wrote:
> >>
> >> On Fri, 2 Oct 2020 at 14:05, Paolo Bonzini <pbonzini@redhat.com
> > <mailto:pbonzini@redhat.com>> wrote:
> >> >
> >> > On 02/10/20 14:35, Peter Maydell wrote:
> >> > >
> >> > > It would be better to do the "see if a static library is present"
> >> > > test. This isn't too hard to do in configure (compare that
> >> > > six line fix to the detection of libgio). Hopefully it is
> >> > > not too hard to do in meson ?
> >> >
> >> > Yes, something like:
> >> >
> >> > if enable_static
> >> >   skeleton =3D 'int main(void) { return 0; }'
> >> >   if not cc.links(skeleton, dependencies: libudev)
> >> >     if get_option('mpath').enabled()
> >> >         error('Cannot link with libudev')
> >> >       else
> >> >         warning('Cannot link with libudev, disabling')
> >> >         libudev =3D not_found
> >> >       endif
> >> >     endif
> >> >   endif
> >> > endif
> >>
> >> This duplicates the information that the thing that depends
> >> on libudev is mpath. Can we put this in a wrapper around
> >> dependency() so that we could just say something like
> >>   libudev =3D compile_checked_dependency('libudev',
> >>                        required: get_option('mpath').enabled(),
> >>                        static: enable_static)
> >>
> > Hi Bonzini,
> > This looks like a frequently used function, can we upstrem to meson?
>
> Yes, I think adding a "links" argument to dependency (similar to
> find_library's has_headers argument) makes sense.  That would be written
>
>     dependency('libudev',
>                required: get_option('mpath').enabled(),
>                static: enable_static,
>                links: skeleton)
make sense, may also need extra cflags and link flags.
>
> But anyway that shouldn't be a blocker for more improvements to qemu's
> meson.build.  Now that we have 5-10 dependencies converted we have a
> clearer idea of how to abstract the tests.
>
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000087b3e705b0c00781
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Oct 3, 2020 at 3:50 PM Paolo Bonzini &lt;<=
a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br=
>&gt;<br>&gt; On 03/10/20 09:24, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) =
wrote:<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; On Fri, Oct 2, 2020 at 9:11 P=
M Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayde=
ll@linaro.org</a><br>&gt; &gt; &lt;mailto:<a href=3D"mailto:peter.maydell@l=
inaro.org">peter.maydell@linaro.org</a>&gt;&gt; wrote:<br>&gt; &gt;&gt;<br>=
&gt; &gt;&gt; On Fri, 2 Oct 2020 at 14:05, Paolo Bonzini &lt;<a href=3D"mai=
lto:pbonzini@redhat.com">pbonzini@redhat.com</a><br>&gt; &gt; &lt;mailto:<a=
 href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;&gt; wrote:=
<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; On 02/10/20 14:35, Peter Mayde=
ll wrote:<br>&gt; &gt;&gt; &gt; &gt;<br>&gt; &gt;&gt; &gt; &gt; It would be=
 better to do the &quot;see if a static library is present&quot;<br>&gt; &g=
t;&gt; &gt; &gt; test. This isn&#39;t too hard to do in configure (compare =
that<br>&gt; &gt;&gt; &gt; &gt; six line fix to the detection of libgio). H=
opefully it is<br>&gt; &gt;&gt; &gt; &gt; not too hard to do in meson ?<br>=
&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Yes, something like:<br>&gt; &gt;&=
gt; &gt;<br>&gt; &gt;&gt; &gt; if enable_static<br>&gt; &gt;&gt; &gt; =C2=
=A0 skeleton =3D &#39;int main(void) { return 0; }&#39;<br>&gt; &gt;&gt; &g=
t; =C2=A0 if not cc.links(skeleton, dependencies: libudev)<br>&gt; &gt;&gt;=
 &gt; =C2=A0 =C2=A0 if get_option(&#39;mpath&#39;).enabled()<br>&gt; &gt;&g=
t; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 error(&#39;Cannot link with libudev&#39=
;)<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 else<br>&gt; &gt;&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 warning(&#39;Cannot link with libudev, disablin=
g&#39;)<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 libudev =3D not_f=
ound<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 endif<br>&gt; &gt;&gt; &gt;=
 =C2=A0 =C2=A0 endif<br>&gt; &gt;&gt; &gt; =C2=A0 endif<br>&gt; &gt;&gt; &g=
t; endif<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; This duplicates the information =
that the thing that depends<br>&gt; &gt;&gt; on libudev is mpath. Can we pu=
t this in a wrapper around<br>&gt; &gt;&gt; dependency() so that we could j=
ust say something like<br>&gt; &gt;&gt; =C2=A0 libudev =3D compile_checked_=
dependency(&#39;libudev&#39;,<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required: get_option=
(&#39;mpath&#39;).enabled(),<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static: enable_stati=
c)<br>&gt; &gt;&gt;<br>&gt; &gt; Hi Bonzini,<br>&gt; &gt; This looks like a=
 frequently used function, can we upstrem to meson?<br>&gt;<br>&gt; Yes, I =
think adding a &quot;links&quot; argument to dependency (similar to<br>&gt;=
 find_library&#39;s has_headers argument) makes sense.=C2=A0 That would be =
written<br>&gt;<br>&gt; =C2=A0 =C2=A0 dependency(&#39;libudev&#39;,<br>&gt;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required: get_optio=
n(&#39;mpath&#39;).enabled(),<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0static: enable_static,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0links: skeleton)<div>make sense, may also ne=
ed extra cflags and link flags.<br>&gt;<br>&gt; But anyway that shouldn&#39=
;t be a blocker for more improvements to qemu&#39;s<br>&gt; meson.build.=C2=
=A0 Now that we have 5-10 dependencies converted we have a<br>&gt; clearer =
idea of how to abstract the tests.<br>&gt;<br>&gt; Paolo<br>&gt;<br><br><br=
>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br=
>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yongga=
ng Luo</div></div>

--00000000000087b3e705b0c00781--

