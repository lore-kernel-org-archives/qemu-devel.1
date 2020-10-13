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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19B7C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34AE208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFvECloE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34AE208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSG5R-0006XH-MK
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kSG4J-0005pJ-QA; Tue, 13 Oct 2020 04:54:03 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:33847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kSG4G-00081u-Co; Tue, 13 Oct 2020 04:54:03 -0400
Received: by mail-lj1-x243.google.com with SMTP id y16so18419851ljk.1;
 Tue, 13 Oct 2020 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=W8HStHR/Kr1IRrLZh9jOcNb2BMNfXksU4bFaXJfHnMs=;
 b=eFvECloEcSbjf+LOrJw5bLnu2ZihC64ntLk7dleD5H23f0K2jGPjEImm65ReNk1n8r
 RYdAatQqzQ8GkwmMsUlk610fcGjTt3zNCdcTK3fMWghwWZDUJYy4vzZx0K0x8YGUiywV
 497tsm++MJvfDqCK8fyfQMDQTA1uq+BXXgM3Qm/EZlml2Q5bmeHMZF7K0XHe9cuRVrSF
 AY2OvdwoVstii6ig7mtiX95xO/3KbeqI7mUnanXp8AXGFMxRJLMRv2SBvqw01U5hON4m
 U2nLIs3s4/vZ+pFrtIml6A4ATERIowrVdgFG/i9EI2U8gq6gCe7J4z32+7g2Tkdo7t0g
 Mxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=W8HStHR/Kr1IRrLZh9jOcNb2BMNfXksU4bFaXJfHnMs=;
 b=rYNNfcXMi2x+7O2Grxdbm8z7rQo6quDFNyMHiSlCpTnM2lCoBBBrd5PE9kOrCqx30q
 lK3EPSUT9RvRPiSuJ7Maf4OTNtyZ+5SsqZzOZLG9xTMmptcFbOpdUQGZ/1xZHxn2rrgO
 4aU8LWr6wmhPq0FmdiRnXD3BLEIvPt4nueT4nJAtZwk31pLz4sekjnID1zXPb5mKj2va
 apKHPck+D2oJ8J2sW/yVp8c+FUI5iVzL/mGTXimAfw1eQIuNqcEq1gKDfN9TVJsSOxdd
 4r2SUYtm9DlbFS4c4lp7v08AiwnmbLxFNJHyxBWLmaFFlVW99tYEV5Q6+X1aoTYzROXm
 pafQ==
X-Gm-Message-State: AOAM530Y4HCqMVZ0Nzyn6WoVavv0yXeuiAwszorYisx9rIlnrRximPa2
 UQF7yX0uTCb7M1rcTERj48Z+IPNirU03UOIsEPk=
X-Google-Smtp-Source: ABdhPJzqJubpc2zRKC+alcobw9USHIWaEC6G43ZXg73AzWcTGX7osaehpVtXSyd7lYuuraG7SkW5rR2p0b48vgk6+Sk=
X-Received: by 2002:a05:651c:1b6:: with SMTP id
 c22mr10574987ljn.447.1602579238235; 
 Tue, 13 Oct 2020 01:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201012233740.190-1-luoyonggang@gmail.com>
 <20201012233740.190-3-luoyonggang@gmail.com>
 <7431126f-cc78-57d3-fd78-bd21c5785927@redhat.com>
In-Reply-To: <7431126f-cc78-57d3-fd78-bd21c5785927@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 13 Oct 2020 16:53:45 +0800
Message-ID: <CAE2XoE_gYX9G7LS6q5GAMsAZAxpGe-M1nO=bei9+D5HKwhBnUw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] gitignore: ignore a bit more
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000038344105b1898ed2"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-level <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000038344105b1898ed2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 4:38 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:
>
> On 10/13/20 1:37 AM, Yonggang Luo wrote:
> > Enable the creating multiple build directory at the source root.
> > Ignore /meson/ and /roms/ for better search experience.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   .gitignore | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/.gitignore b/.gitignore
> > index b32bca1315..f78ee9f297 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -1,5 +1,5 @@
> >   /GNUmakefile
> > -/build/
> > +/build*/
> >   *.pyc
> >   .sdk
> >   .stgit-*
> > @@ -10,3 +10,5 @@ TAGS
> >   *~
> >   *.ast_raw
> >   *.depend_raw
> > +/meson/
> > +/roms/**/*
>
> Why?
As I said, help for searching tool ignore it, meson and roms are thirdparty
packages.
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000038344105b1898ed2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Oct 13, 2020 at 4:38 PM Philippe Mathieu-D=
aud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt=
; wrote:<br>&gt;<br>&gt; On 10/13/20 1:37 AM, Yonggang Luo wrote:<br>&gt; &=
gt; Enable the creating multiple build directory at the source root.<br>&gt=
; &gt; Ignore /meson/ and /roms/ for better search experience.<br>&gt; &gt;=
<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang=
@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=
=A0 .gitignore | 4 +++-<br>&gt; &gt; =C2=A0 1 file changed, 3 insertions(+)=
, 1 deletion(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/.gitignore b/.gitign=
ore<br>&gt; &gt; index b32bca1315..f78ee9f297 100644<br>&gt; &gt; --- a/.gi=
tignore<br>&gt; &gt; +++ b/.gitignore<br>&gt; &gt; @@ -1,5 +1,5 @@<br>&gt; =
&gt; =C2=A0 /GNUmakefile<br>&gt; &gt; -/build/<br>&gt; &gt; +/build*/<br>&g=
t; &gt; =C2=A0 *.pyc<br>&gt; &gt; =C2=A0 .sdk<br>&gt; &gt; =C2=A0 .stgit-*<=
br>&gt; &gt; @@ -10,3 +10,5 @@ TAGS<br>&gt; &gt; =C2=A0 *~<br>&gt; &gt; =C2=
=A0 *.ast_raw<br>&gt; &gt; =C2=A0 *.depend_raw<br>&gt; &gt; +/meson/<br>&gt=
; &gt; +/roms/**/*<br>&gt;<br>&gt; Why?<br>As I said, help for searching to=
ol ignore it, meson and roms are thirdparty packages.<br>&gt;<br><br><br>--=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=
=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggan=
g Luo<br></div>

--00000000000038344105b1898ed2--

