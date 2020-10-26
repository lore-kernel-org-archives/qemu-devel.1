Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED6AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15F121D7B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWj5FsmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15F121D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8pA-000454-K1
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kX8d7-0006jN-Gb
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:58:09 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kX8d5-00056Y-3g
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:58:09 -0400
Received: by mail-ed1-x544.google.com with SMTP id t20so10783273edr.11
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1skMF1FXAmMmpFw26QEM0qWNPguwRSmgvg6h/1JLm68=;
 b=rWj5FsmOSQytgC7mgB4/P8piFR1vi3LbcIbg3trhkJw65+YOrR34MwT8mvWUERRoJ5
 otOyGBnnP9/GPA/BoYrR6knQ69BAudVhc7yi+uEOkrDgsDKEIYar2u+Nd7sadssx15Ga
 t2SoeidnkYE6pp0QPwB5DKf5xoQsf8sJroVOkTY4ryUrobV+Y3+jTGATW1OEVqDu/lqK
 JNRALTv7vcqIYAp7ciNa2sHb1lVhrAk3fM8E4BBfdhKM9TmAbTOBLZthcj0W98W/wKJW
 FHq3WE9w9oEvQLv88Estjtssbfv9PDH0FmVYq3cHXJfHxbiE2YNcMzDq0K2ejwWZARY3
 aSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1skMF1FXAmMmpFw26QEM0qWNPguwRSmgvg6h/1JLm68=;
 b=XRxC8pnLx+Azvk4WUA93FkfzMjn7IDb45zXbacANsJRPJUVQq5u4zxxtU3yezKJORc
 6iLaEc5Wb2XC9nDrhgePNpT6FIC3C2nu+zoqnLUyXYVJLd3bdHEU2bISOzv01hiF3YQW
 iGxwM7HmDlVHKN7QQcxLXrOAMnlDI2agE4HurcJX8d+6YURRSXkA9vnDNrEYJe2KHrrw
 DmGV4AeyTv/P9MSSsA5qQAxJl/UvY6UFNjEcoc2S1xr5c+FGdT2nHie2U3DQTWPFbtYQ
 xvujBx4tQoIRxQEH6sBUV1CyjPsknx6qau6UsxC2zmgYztFrlpAUStpnYXMcujaz4lVD
 XUpw==
X-Gm-Message-State: AOAM533jNpxT2i0xcSv9Au4+mL+jT8zLff3G+bSNm1oDmACn2K4nujCH
 LegdS6eZvAVeU5KaFNeWeuEz1TsWUFRudQAF/Z0=
X-Google-Smtp-Source: ABdhPJwD6LSAqdYeR25ofkv+KLWsy6gl8PH9eqR/LSwm6SMIja9Jq1gDE8CoeGCqUpFXlgsx1JAtHsa447EkoKh4rYU=
X-Received: by 2002:a05:6402:1615:: with SMTP id
 f21mr18078526edv.257.1603742285322; 
 Mon, 26 Oct 2020 12:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201026142851.28735-1-kraxel@redhat.com>
In-Reply-To: <20201026142851.28735-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 26 Oct 2020 23:57:52 +0400
Message-ID: <CAJ+F1CJX3VL7izzBuohTb6GOEW3W8n3jUsi3Zhkn0JfyfY6Xrg@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: only compile virtio-gpu-3d.c for
 CONFIG_VIRGL=y
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003a5d4505b298593e"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003a5d4505b298593e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 6:29 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> There is no actual code in the CONFIG_VIRGL=3Dn case.  So building is
> (a) pointless and (b) makes macos ranlib complain.
>
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  hw/display/virtio-gpu-3d.c | 4 ----
>  hw/display/meson.build     | 4 +++-
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 1bd33d7aedc6..0b0c11474dd3 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -17,8 +17,6 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-gpu.h"
>
> -#ifdef CONFIG_VIRGL
> -
>  #include <virglrenderer.h>
>
>  static struct virgl_renderer_callbacks virtio_gpu_3d_cbs;
> @@ -633,5 +631,3 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>
>      return capset2_max_ver ? 2 : 1;
>  }
> -
> -#endif /* CONFIG_VIRGL */
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 0d5ddecd6503..5906b96b830e 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -57,7 +57,9 @@ softmmu_ss.add(when: [pixman, 'CONFIG_ATI_VGA'],
> if_true: files('ati.c', 'ati_2d
>  if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>    virtio_gpu_ss =3D ss.source_set()
>    virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_GPU',
> -                    if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c',
> 'virtio-gpu-3d.c'), pixman, virgl])
> +                    if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c')=
,
> pixman, virgl])
> +  virtio_gpu_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRGL'],
> +                    if_true: [files('virtio-gpu-3d.c'), pixman, virgl])
>    virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_GPU', if_true:
> files('vhost-user-gpu.c'))
>    hw_display_modules +=3D {'virtio-gpu': virtio_gpu_ss}
>  endif
> --
> 2.27.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000003a5d4505b298593e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 26, 2020 at 6:29 PM Gerd =
Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">There is=
 no actual code in the CONFIG_VIRGL=3Dn case.=C2=A0 So building is<br>
(a) pointless and (b) makes macos ranlib complain.<br>
<br>
Reported-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" targe=
t=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" targe=
t=3D"_blank">kraxel@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/display/virtio-gpu-3d.c | 4 ----<br>
=C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0| 4 +++-<br>
=C2=A02 files changed, 3 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c<br>
index 1bd33d7aedc6..0b0c11474dd3 100644<br>
--- a/hw/display/virtio-gpu-3d.c<br>
+++ b/hw/display/virtio-gpu-3d.c<br>
@@ -17,8 +17,6 @@<br>
=C2=A0#include &quot;hw/virtio/virtio.h&quot;<br>
=C2=A0#include &quot;hw/virtio/virtio-gpu.h&quot;<br>
<br>
-#ifdef CONFIG_VIRGL<br>
-<br>
=C2=A0#include &lt;virglrenderer.h&gt;<br>
<br>
=C2=A0static struct virgl_renderer_callbacks virtio_gpu_3d_cbs;<br>
@@ -633,5 +631,3 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return capset2_max_ver ? 2 : 1;<br>
=C2=A0}<br>
-<br>
-#endif /* CONFIG_VIRGL */<br>
diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
index 0d5ddecd6503..5906b96b830e 100644<br>
--- a/hw/display/meson.build<br>
+++ b/hw/display/meson.build<br>
@@ -57,7 +57,9 @@ softmmu_ss.add(when: [pixman, &#39;CONFIG_ATI_VGA&#39;], =
if_true: files(&#39;ati.c&#39;, &#39;ati_2d<br>
=C2=A0if config_all_devices.has_key(&#39;CONFIG_VIRTIO_GPU&#39;)<br>
=C2=A0 =C2=A0virtio_gpu_ss =3D ss.source_set()<br>
=C2=A0 =C2=A0virtio_gpu_ss.add(when: &#39;CONFIG_VIRTIO_GPU&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if_t=
rue: [files(&#39;virtio-gpu-base.c&#39;, &#39;virtio-gpu.c&#39;, &#39;virti=
o-gpu-3d.c&#39;), pixman, virgl])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if_t=
rue: [files(&#39;virtio-gpu-base.c&#39;, &#39;virtio-gpu.c&#39;), pixman, v=
irgl])<br>
+=C2=A0 virtio_gpu_ss.add(when: [&#39;CONFIG_VIRTIO_GPU&#39;, &#39;CONFIG_V=
IRGL&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if_t=
rue: [files(&#39;virtio-gpu-3d.c&#39;), pixman, virgl])<br>
=C2=A0 =C2=A0virtio_gpu_ss.add(when: &#39;CONFIG_VHOST_USER_GPU&#39;, if_tr=
ue: files(&#39;vhost-user-gpu.c&#39;))<br>
=C2=A0 =C2=A0hw_display_modules +=3D {&#39;virtio-gpu&#39;: virtio_gpu_ss}<=
br>
=C2=A0endif<br>
-- <br>
2.27.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000003a5d4505b298593e--

