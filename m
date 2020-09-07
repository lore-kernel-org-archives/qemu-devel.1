Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604F7C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66062087D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEfGM9TJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66062087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFM2R-0004KF-Rf
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLvy-0001fT-6n
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:32:06 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230]:33133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLvw-0005sr-8G
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:32:05 -0400
Received: by mail-lj1-x230.google.com with SMTP id k25so4524446ljk.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=M1UY6Pk/VMqu4wrqALMeVnXULKFkBb5baLtd5J0Zclw=;
 b=jEfGM9TJKgglBC0WPf1rds+Ho6wPySCgkVM0rYDV7OvtIWePDl2ZczoJZ9+PmpAmD9
 weU36dI+dSmDQRfOdHGTkWyZ1TeketIqf06rGJWDhH/1wVXz3+VInRVZtndoTSP8Z/Os
 EYbXreRPlS7cNgaekJP3Hq2ot/Je+i3WUdrrMAWCepz742MyyssEKYNev//EVtJeV1X7
 I3SP4/0qZeyApp1vbNj7gV6+5cLvSojIxbJ8/rLC8WOHKfFml+KHCl8/hDaAalUPhRT7
 ZYEBoDPDO3klclyusOs8YyN9Zj0ePkQQU+z/Sh5stoCc0qgbek2XrlbLeXhJ7HfHp5A8
 yIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=M1UY6Pk/VMqu4wrqALMeVnXULKFkBb5baLtd5J0Zclw=;
 b=WriNmhcApQz8R0VW6iffIg28lUP3v2yoi5gOo4ksz/0FM4LBxcNjQY9nuTGrVJYynp
 0E8BTf7QoFH0TEGT0wzQQlVCXw1RXPGT99ze/udDGn3IXPQmLF6WWXOm0EXdiSCFyLNh
 8GzKhsJxb9YcujyzA5JGasZEBtjkYRCGjD0RcZo/eQ1UmkVTpUwLUZQj2f8hN5W41V2N
 gQQpAqnCzBVFapM/TaU6+8wQOEJibwx3+jKe16XZU0qR5E3H0UnF/u0wHVrFG/G3gir8
 mk/WGVdccoKC15kfrxkPniaBuzD/9jvzL2TMGXWI4y6fec/BI94YO5Pskfa1AlYqUg1K
 A/4Q==
X-Gm-Message-State: AOAM533q7m+Diznc3BMFVtKKLpbMwu+CUfxp+xtFvXFUhno/FGMAoi/3
 w+gpptf2uuAd2SKGPO3leNMdmCvlXXpcyJ+8Jlk=
X-Google-Smtp-Source: ABdhPJxuBinJ+oGLs/TK+yqXAMHfFy1KyTHviSLRIsKE2yBKiqXpFpRuxJUTGT8cg/IrCKCLjA4R0Kd8pE3qAKOgvO8=
X-Received: by 2002:a05:651c:151:: with SMTP id
 c17mr11952051ljd.467.1599503522029; 
 Mon, 07 Sep 2020 11:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200907121127.136243-1-thuth@redhat.com>
 <CAFEAcA9qdsFdyzRwU0=D=SA+Vt-dd30PfEcNhbDhPRMYvDvukA@mail.gmail.com>
In-Reply-To: <CAFEAcA9qdsFdyzRwU0=D=SA+Vt-dd30PfEcNhbDhPRMYvDvukA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 8 Sep 2020 02:31:50 +0800
Message-ID: <CAE2XoE-aC_yxtFL1dd8mmHfeL=AtgSd+4Z48AuMa0tCGM=mG6w@mail.gmail.com>
Subject: Re: [PULL 00/14] Gitlab-CI improvements and related fixes
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003f641305aebd6f04"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x230.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003f641305aebd6f04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2020 at 2:26 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Mon, 7 Sep 2020 at 13:11, Thomas Huth <thuth@redhat.com> wrote:
> >
> >  Hi Peter,
> >
> > the following changes since commit
> 7c37270b3fbe3d034ba80e488761461676e21eb4:
> >
> >   Merge remote-tracking branch
> 'remotes/kraxel/tags/ui-20200904-pull-request' into staging (2020-09-06
> 16:23:55 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-07
> >
> > for you to fetch changes up to 88e74b6122bb40852b1c98befd47a572f0c06930=
:
> >
> >   target/microblaze: Collected fixes for env->iflags (2020-09-07
> 12:34:17 +0200)
> >
> > ----------------------------------------------------------------
> > * Fixes for cross-compiling with MinGW / compiling with MSYS2
> > * Enable cross-compiler builds in the Gitlab CI
> > * Improvements / fixes for the crypto tests in the Gitlab CI
> > * Fix for the "make check-acceptance" microblaze failure
> >   (required to get the Gitlab CI green again)
> > ----------------------------------------------------------------
>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
> for any user-visible changes.
>
> -- PMM
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003f641305aebd6f04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 8, 2020 at 2:26 AM Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Mon, 7 Sep 2020 at 13:11, Thomas Huth &lt;<a href=3D"mailto:thuth@r=
edhat.com" target=3D"_blank">thuth@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Hi Peter,<br>
&gt;<br>
&gt; the following changes since commit 7c37270b3fbe3d034ba80e488761461676e=
21eb4:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Merge remote-tracking branch &#39;remotes/kraxel/tags/ui-2=
0200904-pull-request&#39; into staging (2020-09-06 16:23:55 +0100)<br>
&gt;<br>
&gt; are available in the Git repository at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/huth/qemu.git" rel=3D"norefe=
rrer" target=3D"_blank">https://gitlab.com/huth/qemu.git</a> tags/pull-requ=
est-2020-09-07<br>
&gt;<br>
&gt; for you to fetch changes up to 88e74b6122bb40852b1c98befd47a572f0c0693=
0:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0target/microblaze: Collected fixes for env-&gt;iflags (202=
0-09-07 12:34:17 +0200)<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; * Fixes for cross-compiling with MinGW / compiling with MSYS2<br>
&gt; * Enable cross-compiler builds in the Gitlab CI<br>
&gt; * Improvements / fixes for the crypto tests in the Gitlab CI<br>
&gt; * Fix for the &quot;make check-acceptance&quot; microblaze failure<br>
&gt;=C2=A0 =C2=A0(required to get the Gitlab CI green again)<br>
&gt; ----------------------------------------------------------------<br>
<br>
<br>
Applied, thanks.<br>
<br>
Please update the changelog at <a href=3D"https://wiki.qemu.org/ChangeLog/5=
.2" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/ChangeLog/5.=
2</a><br>
for any user-visible changes.<br>
<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000003f641305aebd6f04--

