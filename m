Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A74AC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E285B206A5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV/8JYcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E285B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEZ5L-0000gO-2V
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 10:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEZ4X-00009X-Bt; Sat, 05 Sep 2020 10:21:41 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEZ4V-0003YT-Ln; Sat, 05 Sep 2020 10:21:41 -0400
Received: by mail-lj1-x244.google.com with SMTP id u21so909806ljl.6;
 Sat, 05 Sep 2020 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=CkYCgrOFYOHaanxS5nneoW4sWN24dnYBTpjmCHA7pAc=;
 b=rV/8JYczeszo43hhmzp2+icJjJOW/LweZyM0RWLM/ZzLwhz6S6FF4CrOYsgTI/3XNh
 hfCE4Iqy/kcrR5L3VM5V9RvbH22HE4ItKwiFoI9TfX5TP5C19nThh36RTtbH7HBXVXMK
 pc9w7CFemDjkFiFIoQ1/Oo8Dy75R16KNIZzJd+aR06qfs/59aa5uacE4GnmsoKddgfZH
 M2KT03LUQCDTjPs9AwEl48urUpflfA0uXIb7S2oOIcM5c14Gm7FKY32UZ9TlZGW32I3W
 9LH4IYgNdBBo1fNHhI2RFa2AMQ6vMVagMZLFkrATbTSlavl/OAa6spQJTjOKyk+JBy0C
 4aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=CkYCgrOFYOHaanxS5nneoW4sWN24dnYBTpjmCHA7pAc=;
 b=CZvN+clXod7nVhX8W5R0wRZt/ysdO2UevXSPEJwRGAIbBKNYyieYBvKhnR+G/YZ7Vi
 zJQqQW+lOI8APXxrPop1F2AcD5wwrNW1dTp+/rfu06Rli9vOeHoRAAqtVodOiyePCZtH
 w22b3mMh8+ezmFr+XRX6xedkru6TP3Ydj01sX8SHvFJbXTV8rYUzFo7+Z2gvxv3MEKSD
 1ee57+lsivFaNaB6MSk/rmQB/Hiqmg+MYa+tCGhXdADJQtJo2m0mlBCrGZmqmMbnjcW8
 lCIvksVly/movmCOY7a8A99Vttt2mLfx0p/xG/6KnLWjiXzKS8oH85QGc9bMU+OPCIft
 9vLw==
X-Gm-Message-State: AOAM533PL/bnwXkR7ZYZU8ooqPzXY1CWewqsBXBaM/xuTWOLpwEJkiay
 0QTe5iSYSkF5e7iE7aeaqdHEuBDG81CusNn1O7o=
X-Google-Smtp-Source: ABdhPJwQ82defdarsbGeS+CqRsJkFev1XRw/OX/Tn9z/lTP7FZAp336O3xxV2+vLyi4oJzckMqFiJUpeaSIq41e/0Gw=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr5483113ljj.447.1599315697607; 
 Sat, 05 Sep 2020 07:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200905062333.1087-1-luoyonggang@gmail.com>
 <20200905062333.1087-5-luoyonggang@gmail.com>
 <2a9e7f91-9c06-3117-dbf7-952d7da55320@redhat.com>
In-Reply-To: <2a9e7f91-9c06-3117-dbf7-952d7da55320@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 5 Sep 2020 22:21:25 +0800
Message-ID: <CAE2XoE_Up6+1yeQAVBLp337nA46eGMai7p7dmTfp0uLNpE96Kg@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] meson: upgrade meson for execute custom
 ninjatool under msys2 properly
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000a2a3f05ae91b401"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
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
 qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000a2a3f05ae91b401
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2020 at 9:44 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 05/09/20 08:23, Yonggang Luo wrote:
> > The ninja options now have no need anymore.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  meson | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/meson b/meson
> > index 68ed748f84..492afe50a4 160000
> > --- a/meson
> > +++ b/meson
> > @@ -1 +1 @@
> > -Subproject commit 68ed748f84f14c2d4e62dcbd123816e5898eb04c
> > +Subproject commit 492afe50a439d70df99d6e3e59572aff55e14c6b
> >
>
> Sorry, we cannot use a random commit.  We need a release so that we can
> in parallel update the version check in the configure script.
>
> I am OK with that, just used it to verify if the new meson patch are work=
,
and the result are promising.

> Paolo
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000000a2a3f05ae91b401
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 5, 2020 at 9:44 PM Paolo =
Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 05=
/09/20 08:23, Yonggang Luo wrote:<br>
&gt; The ninja options now have no need anymore.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 meson | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/meson b/meson<br>
&gt; index 68ed748f84..492afe50a4 160000<br>
&gt; --- a/meson<br>
&gt; +++ b/meson<br>
&gt; @@ -1 +1 @@<br>
&gt; -Subproject commit 68ed748f84f14c2d4e62dcbd123816e5898eb04c<br>
&gt; +Subproject commit 492afe50a439d70df99d6e3e59572aff55e14c6b<br>
&gt; <br>
<br>
Sorry, we cannot use a random commit.=C2=A0 We need a release so that we ca=
n<br>
in parallel update the version check in the configure script.<br>
<br></blockquote><div>I am OK with that, just used it to verify if the new =
meson patch are work, and the result are promising.=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000000a2a3f05ae91b401--

