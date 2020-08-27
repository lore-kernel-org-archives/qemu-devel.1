Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB08DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830FB22CBB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj/uBTTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830FB22CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBFrD-0002NB-Qi
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kBFls-0003qi-Ig
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:08:44 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kBFlq-00083s-HS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:08:44 -0400
Received: by mail-ot1-x342.google.com with SMTP id h17so2020597otl.9
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Vgb9J0f1Ipdc9fIe+BzsG8rmlf9GAt4bpEVf0yQFjoI=;
 b=mj/uBTTFgYs+qSiRMyxe5HOW77kEwUkXkh3mT4qCVb22G4ZSBIP6eX3p6uet7wU/mg
 L9t7S31IPsx+BhKlETmlW3U3kkq5zHe++kExqlwMZPKghRbwwSfYqNRpC3OJzvksbyGG
 zaQ0TARBT2/GciDdsBbWNzjCeUVxEOaYawWKEgTZSFOeyJYsiMRyM0jTtw/Vs202KuUN
 BsdaNnylwh1hed4tvZtlaXImizQ/wckDP7kbxRieFMuf0PfCXPsDvH+/1tE27Dj0PV0A
 mwz6bOuwI6DkmLI7ZBgw1EBK10ikVDmyirrobwxYQY+cfv6Gok5IwGHv8Rlo1+xm8JZf
 TDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Vgb9J0f1Ipdc9fIe+BzsG8rmlf9GAt4bpEVf0yQFjoI=;
 b=K1HD2gs1o0AlNNyI2xi2rhIhX5KMa9esl1b51I3DFxk5aG243BCxAolLcG/Lph+WvS
 g+vhBGhLFk45eGW2uBYm3fR6692fgb7vzPyMQ/mMSbdlBpzBAa0olgjMqwoNq1xQpMhD
 833LMaBEA1feiYO3zarHp/FYCmN3XMHZvO6jCbaTw48qqDjjsJBB/xOH3qE3WSgA4Rza
 rKztsitla5bfOAdI5nTcRB8jRgFQULSDZ/Iv4s2HRGrz5x/2WqZaP3gywDEZToAc8RWE
 zVjKpmqra5LBrOSj+/DWTppGt2DOgh5RTHH5z/x2uvCGpJMH8rWdKhmyMM07TL++CfR/
 vxMg==
X-Gm-Message-State: AOAM5319pF+Zi588fA5X9Akhz1wb4wGF6be2deaILDpIiiwEWK8Knafd
 mwOXPpra6ykOr/fQkt0SYYsQUGBkPNxoDiH1SXE=
X-Google-Smtp-Source: ABdhPJypx7X6kwawgDvncksIufn/IZBwCP1+MA1uOG3RggF8tWfG3EA2CcspLO9gXxgK72xyVqJyG/ddD9pzllDk/mI=
X-Received: by 2002:a9d:4699:: with SMTP id z25mr9380395ote.353.1598526520950; 
 Thu, 27 Aug 2020 04:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-7-pannengyuan@huawei.com>
 <CAKXe6SJ-=AbZMQ+8snQcPjnZ-r-2+FSHVCVkA2tkba6ujpJCbg@mail.gmail.com>
 <0f8c0192-da25-d5a9-dd9e-2ef72f3f8a6c@huawei.com>
In-Reply-To: <0f8c0192-da25-d5a9-dd9e-2ef72f3f8a6c@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 27 Aug 2020 19:08:05 +0800
Message-ID: <CAKXe6S+jHfadzhFczKa0=ZQ_nmjhSNXW_-Vw0_cJ453vRYPJ7A@mail.gmail.com>
Subject: Re: [PATCH 06/12] ui/gtk-gl-area: Plug memleak in
 gd_gl_area_create_context()
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:06=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2020/8/26 20:20, Li Qiang wrote:
> > Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=881=
4=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:15=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> Receiving error in local variable err, and forgot to free it.
> >> Considering that there is no place to deal with it. Clean up.
> >>
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> >> ---
> >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >> ---
> >>  ui/gtk-gl-area.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> >> index 85f9d14c51..c740a7eb14 100644
> >> --- a/ui/gtk-gl-area.c
> >> +++ b/ui/gtk-gl-area.c
> >> @@ -142,15 +142,14 @@ QEMUGLContext gd_gl_area_create_context(DisplayC=
hangeListener *dcl,
> >>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl)=
;
> >>      GdkWindow *window;
> >>      GdkGLContext *ctx;
> >> -    GError *err =3D NULL;
> >>
> >>      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
> >>      window =3D gtk_widget_get_window(vc->gfx.drawing_area);
> >> -    ctx =3D gdk_window_create_gl_context(window, &err);
> >> +    ctx =3D gdk_window_create_gl_context(window, NULL);
> >>      gdk_gl_context_set_required_version(ctx,
> >>                                          params->major_ver,
> >>                                          params->minor_ver);
> >> -    gdk_gl_context_realize(ctx, &err);
> >> +    gdk_gl_context_realize(ctx, NULL);
> >>      return ctx;
> >>  }
> >
> > Maybe we should check the return value of  'gdk_window_create_gl_contex=
t'
> > and 'gdk_gl_context_realize' instead of omitting it?
>
> OK, Agree with you.
>
> How about check the value like the below?

I think it is OK.

> (Return NULL when error happens in gdk_gl_context_realize. It's different=
 from the original.)

Don't familiar with the internal of how gtk-gl work.

Maybe you can wait for other review or Gerd's decision.

Thanks,
Li Qiang

>
> Thanks.
>
> --------
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 85f9d14c51..98c22d23f5 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -147,10 +147,21 @@ QEMUGLContext gd_gl_area_create_context(DisplayChan=
geListener *dcl,
>      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>      window =3D gtk_widget_get_window(vc->gfx.drawing_area);
>      ctx =3D gdk_window_create_gl_context(window, &err);
> +    if (err) {
> +        g_printerr("Create gdk gl context failed: %s\n", err->message);
> +        g_error_free(err);
> +        return NULL;
> +    }
>      gdk_gl_context_set_required_version(ctx,
>                                          params->major_ver,
>                                          params->minor_ver);
>      gdk_gl_context_realize(ctx, &err);
> +    if (err) {
> +        g_printerr("Realize gdk gl context failed: %s\n", err->message);
> +        g_error_free(err);
> +        g_clear_object(&ctx);
> +        return NULL;
> +    }
>      return ctx;
>  }
>
>
> >
> > Thanks,
> > Li Qiang
> >
> >>
> >
> >> --
> >> 2.18.2
> >>
> >>
> > .
> >
>

