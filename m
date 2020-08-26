Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74847C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE652080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcf/y3xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE652080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAuQg-0000DU-JH
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAuQ7-0008Ap-Vz
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:20:52 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAuQ6-0004c1-Ai
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:20:51 -0400
Received: by mail-ot1-x342.google.com with SMTP id w10so1313180oti.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dri3MyIZtP0eHpJ1Xl0e814LrUwkzyUYwdKyBj4g7dw=;
 b=rcf/y3xVcqoP2ma9OsTdObBtlL39i53nBZubnGFaAfUYremBSDv+NUKLvOS62BgX5O
 9NBIANCO7C88e8cdgB2G12lfIPfvLPlVZYP0pwMNpH3sotIPkkxPcsd0WRBPAPEz+MPw
 yGEjcPFnCrAHjNZztR7NYOSMqg1X8TgCUKizcW1E4B+mdAeayo1gslkAQQoYi4OJdL4U
 hIzjy00YRM0hCkD4hjUzlQTWFnC5IpitZtiz+GkrHvLw4UumTZqTgHIR2650HDbGeB2H
 AsE41OiggcQh+Gmk+butU5liB2kbjgW4OYD1N97KyB1gOPCnnOJcTAsn2D1Dax8G82LA
 6Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dri3MyIZtP0eHpJ1Xl0e814LrUwkzyUYwdKyBj4g7dw=;
 b=R9EKEB6AxB71HEAtliP/9BhaTY7kJj68yqXqraAfTevhyxVMeW4C2ETTgukB1uzOnT
 9QnlS0tDfNSaOjjUraU4VzFgGQ+lWmEY/Q88NXIpGdSv8P2aJxUPCLniW3ob5qKS4Gmr
 VWZGfxYX/u/wSHchRS4ch+kBB/2NvkHFYJFhvb9VY/aSuUa2o/+JMnO7E9pNpac1y7NJ
 wEzyfzlZ4a7/5+NFSsMWmIaEqE5s104DRqSyV/ObmvD8y781fY7eSV+t9z0o7HSTW4ZU
 Ilmca5Y8/p4wCLIDVm6Zg62EBl5He/700AhmP9xurNifVjqIecfK9VXUZC93JrFd1EWQ
 +hVA==
X-Gm-Message-State: AOAM532/cynTHiEqCFSeObAb0Px11lMb1o8x+vqEz2JEAtG1Nz75WZ4G
 neXlecXgZrc/VdryV2TymR8k/JTX0IT6JFcedPE=
X-Google-Smtp-Source: ABdhPJz9zqP0ImNQiqPRGmNTEDyRt4ynC730wQyOr9AtqHSL2d4DNLpXLEUUjyTRJK+L/lV9AXRxGCp7je9qw5QZjWA=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr7067731otn.333.1598444448991; 
 Wed, 26 Aug 2020 05:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-7-pannengyuan@huawei.com>
In-Reply-To: <20200814160241.7915-7-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 20:20:13 +0800
Message-ID: <CAKXe6SJ-=AbZMQ+8snQcPjnZ-r-2+FSHVCVkA2tkba6ujpJCbg@mail.gmail.com>
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

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Receiving error in local variable err, and forgot to free it.
> Considering that there is no place to deal with it. Clean up.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/gtk-gl-area.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 85f9d14c51..c740a7eb14 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -142,15 +142,14 @@ QEMUGLContext gd_gl_area_create_context(DisplayChan=
geListener *dcl,
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>      GdkWindow *window;
>      GdkGLContext *ctx;
> -    GError *err =3D NULL;
>
>      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>      window =3D gtk_widget_get_window(vc->gfx.drawing_area);
> -    ctx =3D gdk_window_create_gl_context(window, &err);
> +    ctx =3D gdk_window_create_gl_context(window, NULL);
>      gdk_gl_context_set_required_version(ctx,
>                                          params->major_ver,
>                                          params->minor_ver);
> -    gdk_gl_context_realize(ctx, &err);
> +    gdk_gl_context_realize(ctx, NULL);
>      return ctx;
>  }

Maybe we should check the return value of  'gdk_window_create_gl_context'
and 'gdk_gl_context_realize' instead of omitting it?

Thanks,
Li Qiang

>

> --
> 2.18.2
>
>

