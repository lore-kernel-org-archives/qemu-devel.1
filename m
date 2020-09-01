Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E742C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A52206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOyQg+R/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A52206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7O8-0000tR-EV
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kD78K-0008Kz-2u
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:19:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kD78H-00050r-PD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:19:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id c10so1270479otm.13
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SOuZZHNJe7G5K9d88wg/fVd21rOXeRexL4QSV+CubOA=;
 b=rOyQg+R/Dx34HDngaMGiNvulZ1Nx6diSczwwLZaUwzOCJcdl35sNnzp9fgH7+d6Q36
 EaatObbTcLnVuFs91AdwwInoqyC5ghjM0NQOh9ZR7D9vme1X0cp4QSH5xL1FyEZObpSf
 0olBTiB3+bYYPjV9KcEPxIytQtQNnx2s8RLvdG510hxI2EeIm13tQ5+FEYDbu+HQM0Fb
 Dz1uNI0o2J/Fx9q30YfFSOevZ7ccFz19lb6EenLfRkCJps7fzst5LgsRO7cmCTUqr/tb
 DPpZtqz1IrR6vHONqUsSbXEuUgtHfrXuChdGyglhY1buWrnuOMI+UGYpF8gGw/DF3WXN
 k2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SOuZZHNJe7G5K9d88wg/fVd21rOXeRexL4QSV+CubOA=;
 b=kzJzak5KEF8whO+RVbUvq4ZiH2UUiDycfYuODoFB4tN10lHQ6r6lYy61ubOXIh8Lhi
 vWLLFCE9REmUvZj21/DwsTkkyoKrPeAG05pFzlnh5N02uURXVtXIjmJ5hPShZGK6WtYJ
 6NAWfL1GsOlOaI41WVl3K5Nwsw+uuKUjgA8pz0p3FRFMPyxY5j1OId1JAMTgLt/6KSJv
 dEoorprZbJcsOQG4gk3DwDgPwmFug2pgk/ueXQuFPrlr/NrSPP5YCmk2yAUqLNhmdGpW
 kxdBc6bKigBSHbMTaIEZ/g/7Ccb9IRo7Ae3CwWuG/EjOAPYfMtCE+EkNItUf2gRqntXE
 0ZHg==
X-Gm-Message-State: AOAM532BzcL47kXtvjWEHqmHdZVOYhwnLze2T+WA6cH/Fh7FiLgyaD7a
 GLIwvwjXonOWKdiE2jlt6wHMNEQ1mRUwM75Gy5E=
X-Google-Smtp-Source: ABdhPJw8t05XPEZWHcmBdTCSVq2nX3hbmxCPHQ3gHHd/4seoCP0a1t+Dnky58U7rmq1GRH+XlDkYw5/6A/64SktfGwY=
X-Received: by 2002:a9d:4699:: with SMTP id z25mr1454734ote.353.1598969969412; 
 Tue, 01 Sep 2020 07:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200901140944.24101-1-kraxel@redhat.com>
In-Reply-To: <20200901140944.24101-1-kraxel@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 1 Sep 2020 22:18:52 +0800
Message-ID: <CAKXe6SLXwR2CtbBZ2kDDEe-JRbZvtfNwJvSEsiTkm=5xRSrshg@mail.gmail.com>
Subject: Re: [PATCH v2] cirrus: handle wraparound in cirrus_invalidate_region
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: Li Qiang <liq3ea@163.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:12=E5=86=99=E9=81=93=EF=BC=9A
>
> Code simply asserts that there is no wraparound instead of handling
> it properly.  The assert() can be triggered by the guest (must be
> privilidged inside the guest though).  Fix it.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880189
> Cc: Li Qiang <liq3ea@163.com>
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@163.com>

> ---
>  hw/display/cirrus_vga.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 212d6f5e6145..5d1f62e50e67 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -640,10 +640,16 @@ static void cirrus_invalidate_region(CirrusVGAState=
 * s, int off_begin,
>      }
>
>      for (y =3D 0; y < lines; y++) {
> -        off_cur =3D off_begin;
> +        off_cur =3D off_begin & s->cirrus_addr_mask;
>          off_cur_end =3D ((off_cur + bytesperline - 1) & s->cirrus_addr_m=
ask) + 1;
> -        assert(off_cur_end >=3D off_cur);
> -        memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off=
_cur);
> +        if (off_cur_end >=3D off_cur) {
> +            memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end -=
 off_cur);
> +        } else {
> +            /* wraparound */
> +            memory_region_set_dirty(&s->vga.vram, off_cur,
> +                                    s->cirrus_addr_mask + 1 - off_cur);
> +            memory_region_set_dirty(&s->vga.vram, 0, off_cur_end);
> +        }
>          off_begin +=3D off_pitch;
>      }
>  }
> --
> 2.27.0
>
>

