Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE3FC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752A7208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqkFtAWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752A7208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSGZy-000809-Fq
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 05:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kSGXQ-0005qp-Lw; Tue, 13 Oct 2020 05:24:08 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kSGXO-00037S-VU; Tue, 13 Oct 2020 05:24:08 -0400
Received: by mail-lf1-x141.google.com with SMTP id l28so6032706lfp.10;
 Tue, 13 Oct 2020 02:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=i+eBoAJiGHBNbr1kvVNmo+HnJL20iQZ60j9+GiS1TVE=;
 b=gqkFtAWlzpbwJznxrae6+wSMRw68Uibx2KzFOg2hOXg0dqNxcB8Tmhz2rb4CZuB+yQ
 ozj3o6yoi9VU4JEsio9fV/u8FlMNko4c0i4k47/vws1gRJiHa0SwXaVLhLAGO0iP95zz
 ZvdAB00b1XMsjASzFPr1ZWjoVfJWwPnt383LfpbeMVApCP+Dv4pk6sn18a0Xu+78R5gJ
 sK11fjf9fouJIVIBgEzKoCUFjIWmQjkStcuMf+PtRGKae21bKeMwwg+Uvqeka/u7ukyp
 A4bn759BX8l04LVK0jaxkZjCOJyKMFi7tibAKo/ZqitciTHREGAJrOKcXYhg4kHpQUp2
 m0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=i+eBoAJiGHBNbr1kvVNmo+HnJL20iQZ60j9+GiS1TVE=;
 b=J9dfE4xfLs8JQ+ggtXWt3vjtd6zWNTAYIZitkNbIYdwIcOhAVx+ormGXPAGJL0Mtga
 oNYh3bsxh1NxkBuCS3A/15UhSWsjlv9M5lPpL+4Wk8tYE+wiVqyamBjbFSV3/FILIfxb
 2MPKej60Y0Jai42dcO91x4TngULZLNqtqy8eXv3d8pne36JKEHEx3WwZIgZPRF7esT9r
 seFIQr8NbjB+nxZIRcmbT1koR1PBnXswphmOC9+kGv5gsIv0AJe0MPfyErdmiwlMNvGF
 lvtN9xOpAL/FH3P5HlGAV1Tda7doaeoZ9xDQJnVSxGChArZbcOlh6/VErHnbczU5qxa+
 0CPg==
X-Gm-Message-State: AOAM53347CTULv2n5xPBgnYtjyjbb04WjcY/sueZSh2m2CZMMxlmfHcJ
 VWQH8VvJuiFYk9c/s4kyG83aoKcBLZE8FK0YvUA=
X-Google-Smtp-Source: ABdhPJzqxg1k149kKnuEa+cxC4mQi7RYUuMD7jEq+GK1T85u8ioC4Xunjuek4BvwwJSH3ssPr7BS/PcSDYxAZGZEUoU=
X-Received: by 2002:a19:8a84:: with SMTP id m126mr9053120lfd.377.1602581044077; 
 Tue, 13 Oct 2020 02:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201012233740.190-1-luoyonggang@gmail.com>
 <20201012233740.190-3-luoyonggang@gmail.com>
 <7431126f-cc78-57d3-fd78-bd21c5785927@redhat.com>
 <CAE2XoE_gYX9G7LS6q5GAMsAZAxpGe-M1nO=bei9+D5HKwhBnUw@mail.gmail.com>
 <0c0ff749-9b79-e24f-6576-e0a396db37d7@redhat.com>
In-Reply-To: <0c0ff749-9b79-e24f-6576-e0a396db37d7@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 13 Oct 2020 17:23:53 +0800
Message-ID: <CAE2XoE_+MFkOcCMQRwm-fWOyiz04FjmA3_5uRa_qqqUbrgwXgA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] gitignore: ignore a bit more
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000db28d705b189f9a2"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000db28d705b189f9a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 5:02 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 13/10/2020 10.53, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >
> > On Tue, Oct 13, 2020 at 4:38 PM Philippe Mathieu-Daud=C3=A9 <
philmd@redhat.com
> > <mailto:philmd@redhat.com>> wrote:
> >>
> >> On 10/13/20 1:37 AM, Yonggang Luo wrote:
> >> > Enable the creating multiple build directory at the source root.
> >> > Ignore /meson/ and /roms/ for better search experience.
> >> >
> >> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
> > <mailto:luoyonggang@gmail.com>>
> >> > ---
> >> >   .gitignore | 4 +++-
> >> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/.gitignore b/.gitignore
> >> > index b32bca1315..f78ee9f297 100644
> >> > --- a/.gitignore
> >> > +++ b/.gitignore
> >> > @@ -1,5 +1,5 @@
> >> >   /GNUmakefile
> >> > -/build/
> >> > +/build*/
>
> The naming of your private build directories is IMHO something that shoul=
d
> not be part of the public .gitignore file. I think you can use your
> ~/.gitignore file for that.
>
> >> >   *.pyc
> >> >   .sdk
> >> >   .stgit-*
> >> > @@ -10,3 +10,5 @@ TAGS
> >> >   *~
> >> >   *.ast_raw
> >> >   *.depend_raw
> >> > +/meson/
> >> > +/roms/**/*
> >>
> >> Why?
> > As I said, help for searching tool ignore it, meson and roms are
thirdparty
> > packages.
>
> Hmm, but "git status" should still show whether there are modifications i=
n
> the subdirectories, so IMHO this should not be ignored?
Yeap, it's doens't affect git, just affect search tools. If this is
improper, skip it, I can use it locally
>
>  Thomas
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000db28d705b189f9a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Oct 13, 2020 at 5:02 PM Thomas Huth &lt;<a=
 href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<b=
r>&gt; On 13/10/2020 10.53, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote=
:<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; On Tue, Oct 13, 2020 at 4:38 PM Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@r=
edhat.com</a><br>&gt; &gt; &lt;mailto:<a href=3D"mailto:philmd@redhat.com">=
philmd@redhat.com</a>&gt;&gt; wrote:<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; On 1=
0/13/20 1:37 AM, Yonggang Luo wrote:<br>&gt; &gt;&gt; &gt; Enable the creat=
ing multiple build directory at the source root.<br>&gt; &gt;&gt; &gt; Igno=
re /meson/ and /roms/ for better search experience.<br>&gt; &gt;&gt; &gt;<b=
r>&gt; &gt;&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoy=
onggang@gmail.com">luoyonggang@gmail.com</a><br>&gt; &gt; &lt;mailto:<a hre=
f=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;&gt;<br>&gt=
; &gt;&gt; &gt; ---<br>&gt; &gt;&gt; &gt; =C2=A0 .gitignore | 4 +++-<br>&gt=
; &gt;&gt; &gt; =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>&g=
t; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; diff --git a/.gitignore b/.gitignore=
<br>&gt; &gt;&gt; &gt; index b32bca1315..f78ee9f297 100644<br>&gt; &gt;&gt;=
 &gt; --- a/.gitignore<br>&gt; &gt;&gt; &gt; +++ b/.gitignore<br>&gt; &gt;&=
gt; &gt; @@ -1,5 +1,5 @@<br>&gt; &gt;&gt; &gt; =C2=A0 /GNUmakefile<br>&gt; =
&gt;&gt; &gt; -/build/<br>&gt; &gt;&gt; &gt; +/build*/<br>&gt;<br>&gt; The =
naming of your private build directories is IMHO something that should<br>&=
gt; not be part of the public .gitignore file. I think you can use your<br>=
&gt; ~/.gitignore file for that.<br>&gt;<br>&gt; &gt;&gt; &gt; =C2=A0 *.pyc=
<br>&gt; &gt;&gt; &gt; =C2=A0 .sdk<br>&gt; &gt;&gt; &gt; =C2=A0 .stgit-*<br=
>&gt; &gt;&gt; &gt; @@ -10,3 +10,5 @@ TAGS<br>&gt; &gt;&gt; &gt; =C2=A0 *~<=
br>&gt; &gt;&gt; &gt; =C2=A0 *.ast_raw<br>&gt; &gt;&gt; &gt; =C2=A0 *.depen=
d_raw<br>&gt; &gt;&gt; &gt; +/meson/<br>&gt; &gt;&gt; &gt; +/roms/**/*<br>&=
gt; &gt;&gt;<br>&gt; &gt;&gt; Why?<br>&gt; &gt; As I said, help for searchi=
ng tool ignore it, meson and roms are thirdparty<br>&gt; &gt; packages.<br>=
&gt;<br>&gt; Hmm, but &quot;git status&quot; should still show whether ther=
e are modifications in<br>&gt; the subdirectories, so IMHO this should not =
be ignored?<div>Yeap, it&#39;s doens&#39;t affect git, just affect search t=
ools. If this is improper, skip it, I can use it locally<br>&gt;<br>&gt; =
=C2=A0Thomas<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000db28d705b189f9a2--

