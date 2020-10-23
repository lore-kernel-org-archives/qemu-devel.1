Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D3EC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E67220704
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk/nERDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E67220704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVsB0-0004zq-BV
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVs70-0001lj-DA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:07:46 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:37544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVs6y-0006tS-Hi
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:07:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id o18so681759edq.4
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 01:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tvOspeJfUC7lOwhudqLIhaY8C3mRkpRLrj/yjDdLR1Q=;
 b=mk/nERDsT1ybv/JbhdvXm4cZ9qaABsjJTGx7GsBQQm1nG6kGbVH8+MCia9i1mGdoSo
 SWC4QBIkQRUU1Qml5hcn0zzVYbE3oceuUvPE3vZGl1veVeAdCGsFlHAbmLiJm6Hv0gWj
 cDN7Lpsbik5wu9Ho4jNpHgX7C5wFIO+QbjUWq+qh3lOJkZBa6I2qkZJMb1eATKA/IxAf
 hhOqAoofzRRLvC8Q/+3IfM8jzN08Juj5NKLoYanpB8a1ey1w0OG7A1xrLjOyrKJAnMsm
 cuNMs9yDkB+YL8+RpsmXGApueiAHkOP3qU1SEYEoFKHIg55RvckZpZJ2yt4AfjI7Vw+z
 nDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tvOspeJfUC7lOwhudqLIhaY8C3mRkpRLrj/yjDdLR1Q=;
 b=DTgjac73U38eZBCq7uLdrtFdIJIgxkz5XurYR31lPOYGQCjcO9BKQcl8/xLvFnVU+D
 9aT/QQX2x+RBQcX16j1XT1B4kzVJllG0sBubnFEVmK1HyAwiFNE1+9M/eAM2YUtAvfiH
 4mfPN9LZFHQS9y0e0U6IJCEmvXTgoYVXHV/hXH45Mw2amPpa9w+NvSBFUU1TjIY+MTKr
 /r7BRM4MveRoq1HVNoNBM8XdUG+905lPM2dBMvd6e8/15VyIQ/70saP0AQg9INx7iPay
 JrER2Qvgj+21bhsR+V1LlHUyhgU4jEaHwDwEP9yfQsiJlSCuJ1CGGG/MTk987ykT7Aa3
 HgCA==
X-Gm-Message-State: AOAM532TfjMOqD93RcgcPndjsoPYfF2nzvUzghTQX2jhjv5xOgXybOHH
 8htmEby3QqxQ3eTaMxqvY4f7RevgSnngDqcKFTE=
X-Google-Smtp-Source: ABdhPJzanjglbBFihJ43CZEJiKoUC7SLuj4CCYtbHtrCaxgcTxgvfSl0oFbHUeulNLtieCftkiW4/8kS9IBTOWtIph8=
X-Received: by 2002:a50:a267:: with SMTP id 94mr1049968edl.30.1603440462964;
 Fri, 23 Oct 2020 01:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201023064618.21409-1-kraxel@redhat.com>
 <20201023064618.21409-3-kraxel@redhat.com>
In-Reply-To: <20201023064618.21409-3-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Oct 2020 12:07:31 +0400
Message-ID: <CAJ+F1C+JdhrzWw9JzGOJ1BHCKtRiygRZMrWDT+2_U4SLQkW_Dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-gpu: add virtio-vga module
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000036abd605b25213a2"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x52b.google.com
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

--00000000000036abd605b25213a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 10:48 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Build virtio-gpu vga devices modular.  Must be a separate module because
> not all qemu softmmu variants come with VGA support.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  util/module.c          |  3 +++
>  hw/display/meson.build | 10 ++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/util/module.c b/util/module.c
> index 9490f975d303..503c399421c5 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -304,6 +304,9 @@ static struct {
>      { "virtio-gpu-pci-base",   "hw-", "display-virtio-gpu-pci" },
>      { "virtio-gpu-pci",        "hw-", "display-virtio-gpu-pci" },
>      { "vhost-user-gpu-pci",    "hw-", "display-virtio-gpu-pci" },
> +    { "virtio-vga-base",       "hw-", "display-virtio-vga"    },
> +    { "virtio-vga",            "hw-", "display-virtio-vga"    },
> +    { "vhost-user-vga",        "hw-", "display-virtio-vga"    },
>      { "chardev-braille",       "chardev-", "baum"             },
>      { "chardev-spicevmc",      "chardev-", "spice"            },
>      { "chardev-spiceport",     "chardev-", "spice"            },
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 669935371335..11ea2895c5fe 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -71,8 +71,14 @@ if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
>    hw_display_modules +=3D {'virtio-gpu-pci': virtio_gpu_pci_ss}
>  endif
>
> -softmmu_ss.add(when: 'CONFIG_VIRTIO_VGA', if_true: files('virtio-vga.c')=
)
> -softmmu_ss.add(when: 'CONFIG_VHOST_USER_VGA', if_true:
> files('vhost-user-vga.c'))
> +if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
> +  virtio_vga_ss =3D ss.source_set()
> +  virtio_vga_ss.add(when: 'CONFIG_VIRTIO_VGA',
> +                    if_true: [files('virtio-vga.c'), pixman])
> +  virtio_vga_ss.add(when: 'CONFIG_VHOST_USER_VGA',
> +                    if_true: files('vhost-user-vga.c'))
> +  hw_display_modules +=3D {'virtio-vga': virtio_vga_ss}
> +endif
>
>  specific_ss.add(when: [x11, opengl, 'CONFIG_MILKYMIST_TMU2'], if_true:
> files('milkymist-tmu2.c'))
>  specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
> --
> 2.27.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000036abd605b25213a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at 10:48 AM Gerd=
 Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Build v=
irtio-gpu vga devices modular.=C2=A0 Must be a separate module because<br>
not all qemu softmmu variants come with VGA support.<br>
<br>
Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" targe=
t=3D"_blank">kraxel@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0util/module.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +++<br>
=C2=A0hw/display/meson.build | 10 ++++++++--<br>
=C2=A02 files changed, 11 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/util/module.c b/util/module.c<br>
index 9490f975d303..503c399421c5 100644<br>
--- a/util/module.c<br>
+++ b/util/module.c<br>
@@ -304,6 +304,9 @@ static struct {<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;virtio-gpu-pci-base&quot;,=C2=A0 =C2=A0&quot;hw=
-&quot;, &quot;display-virtio-gpu-pci&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;virtio-gpu-pci&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;hw-&quot;, &quot;display-virtio-gpu-pci&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;vhost-user-gpu-pci&quot;,=C2=A0 =C2=A0 &quot;hw=
-&quot;, &quot;display-virtio-gpu-pci&quot; },<br>
+=C2=A0 =C2=A0 { &quot;virtio-vga-base&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0&qu=
ot;hw-&quot;, &quot;display-virtio-vga&quot;=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 { &quot;virtio-vga&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;hw-&quot;, &quot;display-virtio-vga&quot;=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 { &quot;vhost-user-vga&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 &qu=
ot;hw-&quot;, &quot;display-virtio-vga&quot;=C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;chardev-braille&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;chardev-&quot;, &quot;baum&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;chardev-spicevmc&quot;,=C2=A0 =C2=A0 =C2=A0 &qu=
ot;chardev-&quot;, &quot;spice&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;chardev-spiceport&quot;,=C2=A0 =C2=A0 =C2=A0&qu=
ot;chardev-&quot;, &quot;spice&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 },<br>
diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
index 669935371335..11ea2895c5fe 100644<br>
--- a/hw/display/meson.build<br>
+++ b/hw/display/meson.build<br>
@@ -71,8 +71,14 @@ if config_all_devices.has_key(&#39;CONFIG_VIRTIO_PCI&#39=
;)<br>
=C2=A0 =C2=A0hw_display_modules +=3D {&#39;virtio-gpu-pci&#39;: virtio_gpu_=
pci_ss}<br>
=C2=A0endif<br>
<br>
-softmmu_ss.add(when: &#39;CONFIG_VIRTIO_VGA&#39;, if_true: files(&#39;virt=
io-vga.c&#39;))<br>
-softmmu_ss.add(when: &#39;CONFIG_VHOST_USER_VGA&#39;, if_true: files(&#39;=
vhost-user-vga.c&#39;))<br>
+if config_all_devices.has_key(&#39;CONFIG_VIRTIO_VGA&#39;)<br>
+=C2=A0 virtio_vga_ss =3D ss.source_set()<br>
+=C2=A0 virtio_vga_ss.add(when: &#39;CONFIG_VIRTIO_VGA&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if_t=
rue: [files(&#39;virtio-vga.c&#39;), pixman])<br>
+=C2=A0 virtio_vga_ss.add(when: &#39;CONFIG_VHOST_USER_VGA&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if_t=
rue: files(&#39;vhost-user-vga.c&#39;))<br>
+=C2=A0 hw_display_modules +=3D {&#39;virtio-vga&#39;: virtio_vga_ss}<br>
+endif<br>
<br>
=C2=A0specific_ss.add(when: [x11, opengl, &#39;CONFIG_MILKYMIST_TMU2&#39;],=
 if_true: files(&#39;milkymist-tmu2.c&#39;))<br>
=C2=A0specific_ss.add(when: &#39;CONFIG_OMAP&#39;, if_true: files(&#39;omap=
_lcdc.c&#39;))<br>
-- <br>
2.27.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000036abd605b25213a2--

