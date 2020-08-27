Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82B2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8438B207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBcDt8Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8438B207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBFQt-0000tT-Oa
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 06:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kBFPy-0008TZ-V2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:46:06 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:36811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kBFPw-0005LF-HT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:46:06 -0400
Received: by mail-ej1-x642.google.com with SMTP id l2so7011838eji.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=22xc2SjZ+e5fffMjk99p7GquOG3nhvfuveDZ8Pz0DS4=;
 b=sBcDt8JfYbNrLPbWvQtvjN7IesEFLb/EMV6rzbUN64cyh80iexHcE2FgUPz6fhjs7e
 Wb4hj5cCgHWgRZDpZvqOh9/kuTqPPZm/4YDytWyWRZzPMjDnBTQzBQs1pn+xrb+038b6
 fyXPXVxLwbqiMQJvOLZEdxOb+gd/ouW7iNi36XVa7nM1j9CirdXX6rktRzVW/PbGeplN
 ND933uhQJkmcMdtAm6WY8VlDCjy9FJHxZw8WpiNplcWGjUwnhzuwZ0ACnvzZ/bPFzI9L
 EWpytP8N2vesZBlQu2rCUeNNTqIfy3CB0gLMO+EOeHoEjiofguFQeEtgqMY5NyMVDWc5
 D/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=22xc2SjZ+e5fffMjk99p7GquOG3nhvfuveDZ8Pz0DS4=;
 b=NgV+m3Bp7CJhIrXpwgoA6nJ/NUzSJGA9WBYg0tuWM6jYCS5OrMxCw9NYSyWL93ATZd
 i1ErElLDpOjAgiCZOSvH+zDAZrQCDKGEovqVWgByyBgHlQIaZKIsqZlxE2YiyPx8OMkq
 Ks5zEBAJAOrzJhOD9ICe9xOJNXsQy1uDk4TqbZbbCaAZN0PbEHXC3P6fp5VEsFUfQFJZ
 Im7eT/86NNAVScO7DTW9rZkbNaHYCWutoZBbP9QyQLI7E1/uoG/3ADO4OI6hCIVZAECD
 I6fOEzQP7KkhZHWTWxUgcffgpE8i58FFpLqDHuWhqS4oEdWsrVrQ1J92ju8kmhJTwGuL
 llaw==
X-Gm-Message-State: AOAM5334uNZexJgfklATVjgFMsd7fQTx4GTzShj845SWL7rIKFhZR6xq
 oC3AF9DEwqHsDk0bQEZvHYj/gVRjaE4MbqXPENs=
X-Google-Smtp-Source: ABdhPJyjbmpO/9gsoTEiNaDsML17ODMdl0BcpYZ95BxQtKU58KRZaIpuyc//4wU4FC5k32GAH2gV+s9vRfA7IJX8htM=
X-Received: by 2002:a17:906:f150:: with SMTP id
 gw16mr12297815ejb.532.1598525161762; 
 Thu, 27 Aug 2020 03:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200827064629.23080-1-kraxel@redhat.com>
In-Reply-To: <20200827064629.23080-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 27 Aug 2020 14:45:48 +0400
Message-ID: <CAJ+F1C+dj8Y88cWv0uUQ1W9QfvBWksh-eJePwhoJM0gvPZ_ieg@mail.gmail.com>
Subject: Re: [PATCH] meson: fix qxl module build
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006e749b05add9a4d5"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006e749b05add9a4d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2020 at 10:47 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Drop qxl object from softmmu source set, it is built as module.
>
> Also drop CONFIG_QXL condition from qxl_ss.add.  First because it is
> pointless, the whole thing is wrapped into "has_key('CONFIG_QXL')".
> Second because it doesn't work for some reason.  Looks like the source
> files are not added to the set for some reason and we end up with an
> empty hw-display-qxl.so.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/display/meson.build | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 78adaf9db463..becbedd24c23 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -41,12 +41,10 @@ specific_ss.add(when: 'CONFIG_VGA', if_true:
> files('vga.c'))
>
>  if config_all_devices.has_key('CONFIG_QXL')
>    qxl_ss =3D ss.source_set()
> -  qxl_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c',
> 'qxl-render.c'))
> +  qxl_ss.add(files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
>    hw_display_modules +=3D {'qxl': qxl_ss}
>  endif
>
> -softmmu_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c',
> 'qxl-logger.c', 'qxl-render.c'))
> -
>  softmmu_ss.add(when: 'CONFIG_DPCD', if_true: files('dpcd.c'))
>  softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true:
> files('xlnx_dp.c'))
>
> --
> 2.27.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000006e749b05add9a4d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 27, 2020 at 10:47 AM Gerd=
 Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Drop qx=
l object from softmmu source set, it is built as module.<br>
<br>
Also drop CONFIG_QXL condition from qxl_ss.add.=C2=A0 First because it is<b=
r>
pointless, the whole thing is wrapped into &quot;has_key(&#39;CONFIG_QXL&#3=
9;)&quot;.<br>
Second because it doesn&#39;t work for some reason.=C2=A0 Looks like the so=
urce<br>
files are not added to the set for some reason and we end up with an<br>
empty hw-display-qxl.so.<br>
<br>
Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" targe=
t=3D"_blank">kraxel@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;=C2=A0 <br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">---<br>
=C2=A0hw/display/meson.build | 4 +---<br>
=C2=A01 file changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
index 78adaf9db463..becbedd24c23 100644<br>
--- a/hw/display/meson.build<br>
+++ b/hw/display/meson.build<br>
@@ -41,12 +41,10 @@ specific_ss.add(when: &#39;CONFIG_VGA&#39;, if_true: fi=
les(&#39;vga.c&#39;))<br>
<br>
=C2=A0if config_all_devices.has_key(&#39;CONFIG_QXL&#39;)<br>
=C2=A0 =C2=A0qxl_ss =3D ss.source_set()<br>
-=C2=A0 qxl_ss.add(when: &#39;CONFIG_QXL&#39;, if_true: files(&#39;qxl.c&#3=
9;, &#39;qxl-logger.c&#39;, &#39;qxl-render.c&#39;))<br>
+=C2=A0 qxl_ss.add(files(&#39;qxl.c&#39;, &#39;qxl-logger.c&#39;, &#39;qxl-=
render.c&#39;))<br>
=C2=A0 =C2=A0hw_display_modules +=3D {&#39;qxl&#39;: qxl_ss}<br>
=C2=A0endif<br>
<br>
-softmmu_ss.add(when: &#39;CONFIG_QXL&#39;, if_true: files(&#39;qxl.c&#39;,=
 &#39;qxl-logger.c&#39;, &#39;qxl-render.c&#39;))<br>
-<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_DPCD&#39;, if_true: files(&#39;dpcd.=
c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_XLNX_ZYNQMP_ARM&#39;, if_true: files=
(&#39;xlnx_dp.c&#39;))<br>
<br>
-- <br>
2.27.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000006e749b05add9a4d5--

