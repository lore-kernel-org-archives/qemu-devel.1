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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E9EC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827F22098B
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsASpxtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827F22098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJg14-0007Ly-Mg
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJfeM-0001Ex-BZ; Sat, 19 Sep 2020 12:23:46 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:33440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJfeK-0001ZU-6j; Sat, 19 Sep 2020 12:23:45 -0400
Received: by mail-lj1-x243.google.com with SMTP id k25so7577726ljk.0;
 Sat, 19 Sep 2020 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=h1dK1H3qIZ3YtwRio+FVOyiBNnTsEnjaiHbmZEifJpc=;
 b=IsASpxtbYTzFKN5Pb/jq2DCqAuLlJcakbL5rKMoTwJqTu+LkZTMMcrItBa4/ozTBXM
 wODn57Taqk5qUvuLK1WSqpIhp1+bGK+xT/xe9FKnxTFTLQllckK2QaPGbt/epVeDo57T
 YkT9RGbnnmIChdzHgsvohlvS8oP6v1oBioQys+MKDbNUd6xk1L804mSjWTyTVnt2mfLX
 T5IIcgFaTLewib1n4T6FHQhtDOVb3gJmNNCvl+HMtpZU8BkZFOyjrWpPVetopYJZ6OwB
 FDb3cercUleTbpvNlmotXacpmZslD3mwrJOL+87d3jqoY4wz01MbwLN9+GFsIrSdZmpE
 RGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=h1dK1H3qIZ3YtwRio+FVOyiBNnTsEnjaiHbmZEifJpc=;
 b=CxjoFzn9Vj1HYzitYIEIWyLbpAc9WnA/+EvmlvuFM/0E1eYqFREJTCWwGjT1nouFSt
 11qe2cHfd9u1xQYtRGSw0WAFmTrrZ4TF/ZUOGaL9Fzkgemarr6PcDCPguuwqnelPZPwH
 jmi29qXSCEkOl7oVNgNhPLk71/jI5Z7FjqxtP0lv4XArDguO4SVlg0xJjQLgd8rt1vZQ
 hx6e+Rvrl6zpfmSSYo4fFiZmR25V8BAjr2XAQc4MZM+GXol4btJwcFmsQ6FAAxz3hv7T
 po7pOGuz/n9DJiJyPhr9phiuxQ1G/e2IaXvXAvRY1D2GrJls6h3hPBcHwuKOEvv1LCev
 FErQ==
X-Gm-Message-State: AOAM533LtWEJqD/VG6ptV/Jr8F9cZkKj5N8APQf5MCUvyR2izRatYx0M
 RSAZNMk8J2MYKLVqq5GS6IagCPBuLk7eu2JP5AA=
X-Google-Smtp-Source: ABdhPJyl54WJITNX7jUozJdJNDECrHaBqibsGogCe/foCCFcmIpGSceBbOzJiS9YUD2pwGJ6IRKSv2lqsfRTLds19aw=
X-Received: by 2002:a05:651c:1119:: with SMTP id
 d25mr12281989ljo.300.1600532621507; 
 Sat, 19 Sep 2020 09:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200918160250.1141-1-luoyonggang@gmail.com>
 <CAE2XoE9Vf3Zixv6Ds0BmO9O5EWWjPbG-0EkP0BEbPikuCc4SVg@mail.gmail.com>
 <5c0699e8-62ef-8f29-182f-a0744c727bae@redhat.com>
In-Reply-To: <5c0699e8-62ef-8f29-182f-a0744c727bae@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 20 Sep 2020 00:23:31 +0800
Message-ID: <CAE2XoE-Z5zLjs1aKmghXoXLUm7tguro5GFLBFPOKhv1Uq42b2A@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Fixes curses on msys2/mingw
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005b3f5805afad0ae0"
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-level <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005b3f5805afad0ae0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2020 at 11:03 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 18/09/20 18:10, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >> Yonggang Luo (4):
> >>   curses: Fixes compiler error that complain don't have langinfo.h on
> >>     msys2/mingw
> >>   curses: Fixes curses compiling errors.
> >>   win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURC=
E
> >>     are defined on msys2/mingw
> >>   configure: Fixes ncursesw detection under msys2/mingw by convert the=
m
> >>     to meson
>
> Hi, patches 1-3 are okay, but for patch 4 I think it's better to wait
> for Meson 0.56 which will likely embed all the magic needed to test
> curses (https://github.com/mesonbuild/meson/pull/7757).
>
> Paolo
>
Wonderfull, I think there is no need fixing configure anymore, so I convert
it to meson

Waiting https://github.com/mesonbuild/meson/pull/7757 to be merged.
In deed when I convert to meson, I am facing a problem that
DNCURSES_WIDECHAR  can not be tested with the library.

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000005b3f5805afad0ae0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Sep 19, 2020 at 11:03 PM Paolo Bonzini &lt=
;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.c=
om</a>&gt; wrote:<br>&gt;<br>&gt; On 18/09/20 18:10, =E7=BD=97=E5=8B=87=E5=
=88=9A(Yonggang Luo) wrote:<br>&gt; &gt;<br>&gt; &gt;&gt; Yonggang Luo (4):=
<br>&gt; &gt;&gt; =C2=A0 curses: Fixes compiler error that complain don&#39=
;t have langinfo.h on<br>&gt; &gt;&gt; =C2=A0 =C2=A0 msys2/mingw<br>&gt; &g=
t;&gt; =C2=A0 curses: Fixes curses compiling errors.<br>&gt; &gt;&gt; =C2=
=A0 win32: Simplify gmtime_r detection not depends on if =C2=A0_POSIX_C_SOU=
RCE<br>&gt; &gt;&gt; =C2=A0 =C2=A0 are defined on msys2/mingw<br>&gt; &gt;&=
gt; =C2=A0 configure: Fixes ncursesw detection under msys2/mingw by convert=
 them<br>&gt; &gt;&gt; =C2=A0 =C2=A0 to meson<br>&gt;<br>&gt; Hi, patches 1=
-3 are okay, but for patch 4 I think it&#39;s better to wait<br>&gt; for Me=
son 0.56 which will likely embed all the magic needed to test<br>&gt; curse=
s (<a href=3D"https://github.com/mesonbuild/meson/pull/7757" target=3D"_bla=
nk">https://github.com/mesonbuild/meson/pull/7757</a>).<br>&gt;<br>&gt; Pao=
lo<br>&gt;<div>Wonderfull, I think there is no need fixing configure anymor=
e, so I convert it to meson</div><div><br></div><div>Waiting=C2=A0<a href=
=3D"https://github.com/mesonbuild/meson/pull/7757" target=3D"_blank">https:=
//github.com/mesonbuild/meson/pull/7757</a> to be merged.</div><div>In deed=
 when I convert to meson, I am facing a problem that=C2=A0<br>DNCURSES_WIDE=
CHAR=C2=A0 can not be tested with the library.=C2=A0<br><br>--<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=
=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div><=
/div>

--0000000000005b3f5805afad0ae0--

