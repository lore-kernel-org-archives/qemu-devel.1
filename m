Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB77C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E15722264
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3YsQkhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E15722264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxC0-00007x-Hx
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kZxAU-0007ur-Tk
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:20:14 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:44578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kZxAS-00013T-Ac
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:20:14 -0500
Received: by mail-lj1-x234.google.com with SMTP id o13so10914093ljj.11
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=QGJPvyEojuYe5Suen1aO3nJsrgXUG3FXRvjTMVEmpq0=;
 b=J3YsQkhI7wKMDWoi+o2PcCCGrKIZw/dMwnXWjdRpF2CLmRKthiy6Rdjio2fecaQCIc
 G9OK2PlSbi9e8iszvAQdosr0kv+v+EIOyEytX/nz6K/pUkF2VSU8asTo5QoqUlkQkKrn
 UVD3Eci32wtDt8aRiPZ6IYMNr8TDNjD2CHMmXK0g3DK8T/02N7cOWSryyCjdqZYfPcu1
 2mhMi042SeJhtH9YtuBJ7Bcs60ITv+bPREADW8J4zbvqnkHu/0F8ZYhI6ZEtCGKj4Ecd
 vFu7iKYV2mPNl1Kfmu1I2v+dRhqMckPH9lRYCaLvPXSBedo1GB4saKsLjdrU9742BrfN
 GUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=QGJPvyEojuYe5Suen1aO3nJsrgXUG3FXRvjTMVEmpq0=;
 b=qvjD//sQ2bktyl45v6rqmA6uPTQIQRmo0VMPhbUoHqlCzlERWsqa0+TDvZ9E3YpSYd
 coH4XE0YcAL76uaOrh/bojC+//jdwjMKls4e1alhHdL7+8+mAbliscHpasJE5HRy+V/I
 du0uJYq+F30CnId0H9H1cJcqqTxu7HycneUJEaPAB0GgoPlcBvpTksVY5yE8ZRVyK043
 GKY0jy2lmXh+y7jVPZYLmQWTo44b4LBHcM2pEoAjp+PFhw08SK+2f2AeW54i4xRpLYB5
 XCgvQ4PhrXRWOXvxCUiBITb65969hwVp30j4WkNyrR6hHbviBH8bnDr3qcRJlSU6Pc9G
 p3UA==
X-Gm-Message-State: AOAM531TMmzUjpx/FsFYNAo5IFOXXe5lislo/yYo9alvHcoyiwU2tzZK
 96Uq/cowXpF9kNvxF4PdmDbz0IUn8JLMzHgp77I=
X-Google-Smtp-Source: ABdhPJwXJHKh+7izLejhXwVfLx9jZfC6PqDN/wo+Suu61KyPN3Qzl/RVVLTNflFagxVc+q9/h+I8gVch2Ys7nK6wf8g=
X-Received: by 2002:a2e:99c8:: with SMTP id l8mr8136008ljj.300.1604413208313; 
 Tue, 03 Nov 2020 06:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20200821102329.29777-1-pbonzini@redhat.com>
 <20200821102329.29777-63-pbonzini@redhat.com>
 <f896a0d5-721e-2346-58c2-38e26c2c352e@redhat.com>
In-Reply-To: <f896a0d5-721e-2346-58c2-38e26c2c352e@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 3 Nov 2020 22:19:55 +0800
Message-ID: <CAE2XoE9vwFNdJ4NAQXeNEDJkEEiLSXWqf8_dsKKx3FzKpsvFcQ@mail.gmail.com>
Subject: Re: [PULL v8 062/152] meson: infrastructure for building emulators
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005ae02305b3348f6a"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x234.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005ae02305b3348f6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2020 at 9:41 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:
>
> On 8/21/20 12:21 PM, Paolo Bonzini wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  Makefile               |  74 ++----------------
> >  Makefile.target        |  19 +++--
> >  configure              |   6 --
> >  hw/i386/fw_cfg.c       |   2 +-
> >  hw/i386/pc.c           |   2 +-
> >  hw/i386/pc_piix.c      |   2 +-
> >  hw/i386/x86.c          |   2 +-
> >  hw/vfio/pci-quirks.c   |   2 +-
> >  hw/virtio/virtio-mem.c |   2 +-
> >  include/qemu/osdep.h   |   2 +-
> >  meson.build            | 166 ++++++++++++++++++++++++++++++++++++++++-
> >  rules.mak              |   8 --
> >  scripts/create_config  |   2 +
> >  scripts/grepy.sh       |   3 +
> >  scripts/minikconf.py   |   0
> >  softmmu/qtest.c        |   2 +-
> >  16 files changed, 192 insertions(+), 102 deletions(-)
> >  create mode 100755 scripts/grepy.sh
> >  mode change 100755 =3D> 100644 scripts/minikconf.py
> ...
>
> > diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> > index c55abfb01a..33441ad484 100644
> > --- a/hw/i386/fw_cfg.c
> > +++ b/hw/i386/fw_cfg.c
> > @@ -22,7 +22,7 @@
> >  #include "hw/nvram/fw_cfg.h"
> >  #include "e820_memory_layout.h"
> >  #include "kvm_i386.h"
> > -#include "config-devices.h"
> > +#include CONFIG_DEVICES
Mybe add config-devices.h back and detecting the target_cpu and include it
properly?
>
> Suggestion: add a comment to this include, because it is hard to
> figure out what it does (if you don't have minikconf + meson
> background). At least it was not obvious to me. (other
> occurrences in the codebase).
>
> Regards,
>
> Phil.
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000005ae02305b3348f6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Nov 3, 2020 at 9:41 PM Philippe Mathieu-Da=
ud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt;=
 wrote:<br>&gt;<br>&gt; On 8/21/20 12:21 PM, Paolo Bonzini wrote:<br>&gt; &=
gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;<br>&gt; &gt; Signed-o=
ff-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@re=
dhat.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0Makefile =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A074 ++----------------<br>&gt; &=
gt; =C2=A0Makefile.target =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A019 +++--<br>&g=
t; &gt; =C2=A0configure =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 6 --<br>&gt; &gt; =C2=A0hw/i386/fw_cfg.c =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 2 +-<br>&gt; &gt; =C2=A0hw/i386/pc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 2 +-<br>&gt; &gt; =C2=A0hw/i386/pc_piix.c =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 2 +-<br>&gt; &gt; =C2=A0hw/i386/x86.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 2 +-<br>&gt; &gt; =C2=A0hw/vfio/pci-quirks.c =C2=A0 | =C2=A0=
 2 +-<br>&gt; &gt; =C2=A0hw/virtio/virtio-mem.c | =C2=A0 2 +-<br>&gt; &gt; =
=C2=A0include/qemu/osdep.h =C2=A0 | =C2=A0 2 +-<br>&gt; &gt; =C2=A0meson.bu=
ild =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 166 ++++++++++++++++++++++++=
++++++++++++++++-<br>&gt; &gt; =C2=A0rules.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 8 --<br>&gt; &gt; =C2=A0scripts/create_config =
=C2=A0| =C2=A0 2 +<br>&gt; &gt; =C2=A0scripts/grepy.sh =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 3 +<br>&gt; &gt; =C2=A0scripts/minikconf.py =C2=A0 | =C2=A0 0<br>=
&gt; &gt; =C2=A0softmmu/qtest.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 2 +-<br=
>&gt; &gt; =C2=A016 files changed, 192 insertions(+), 102 deletions(-)<br>&=
gt; &gt; =C2=A0create mode 100755 scripts/grepy.sh<br>&gt; &gt; =C2=A0mode =
change 100755 =3D&gt; 100644 scripts/minikconf.py<br>&gt; ...<br>&gt;<br>&g=
t; &gt; diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c<br>&gt; &gt; index=
 c55abfb01a..33441ad484 100644<br>&gt; &gt; --- a/hw/i386/fw_cfg.c<br>&gt; =
&gt; +++ b/hw/i386/fw_cfg.c<br>&gt; &gt; @@ -22,7 +22,7 @@<br>&gt; &gt; =C2=
=A0#include &quot;hw/nvram/fw_cfg.h&quot;<br>&gt; &gt; =C2=A0#include &quot=
;e820_memory_layout.h&quot;<br>&gt; &gt; =C2=A0#include &quot;kvm_i386.h&qu=
ot;<br>&gt; &gt; -#include &quot;config-devices.h&quot;<br>&gt; &gt; +#incl=
ude CONFIG_DEVICES<div>Mybe add config-devices.h back and detecting the tar=
get_cpu and include it properly?<br>&gt;<br>&gt; Suggestion: add a comment =
to this include, because it is hard to<br>&gt; figure out what it does (if =
you don&#39;t have minikconf + meson<br>&gt; background). At least it was n=
ot obvious to me. (other<br>&gt; occurrences in the codebase).<br>&gt;<br>&=
gt; Regards,<br>&gt;<br>&gt; Phil.<br>&gt;<br>&gt;<br><br><br>--<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=
=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div><=
/div>

--0000000000005ae02305b3348f6a--

