Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DDFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA8220672
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9Xunwrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA8220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvkgU-0006Kw-ES
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 12:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jvkff-0005i6-66; Wed, 15 Jul 2020 12:54:15 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:33320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jvkfc-0000y2-1S; Wed, 15 Jul 2020 12:54:14 -0400
Received: by mail-io1-xd44.google.com with SMTP id d18so2995822ion.0;
 Wed, 15 Jul 2020 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pWHYr+QKGsr9PbnPnffx8m+ox3oeLE77HK4ac7O9cD4=;
 b=Z9XunwrsGJRylXgHA4fOfTVgHeeVywrzs0wBqQnTUP1tI0Sj7o8USO5RL4zCzZqR/z
 EkMsem0F8Qr0+mMbhsr76oqk1S2nraHJgWOFY7Nzbn6J7SmE8tudNMg8szZI+/NQrRT0
 oAGTL/rDSNQt9ISMecy0dQW3sEcZlwN/9ZxkpAfnFe+bl9jDr2ugjUyJttbI/tHFxgWR
 k8Y+ir0Zy2nHLlrsihT+I0deY5Z0pELWOMSgXcZZJ2FpO9InhSc2I9fg4HdIpk0qUJhK
 03xYcW5ZpnGV2u5ORLhzPdtd8TFp6lYxn1BlliUw9fXEeusOpEOhwGcN2XV0iB8YninF
 O0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pWHYr+QKGsr9PbnPnffx8m+ox3oeLE77HK4ac7O9cD4=;
 b=dZo/B27/8CO/JdGKQJCQspC5rlmNtbuCRBHShP6iZkr9IzLGSsngRhwkrh4oOgh6Yx
 rvscC/LqFBSntfFr6LN5YJ8Fa6wnOD+7KArxJ+3pB98Oa9hZjVJnH7NCB/gYn41IcEom
 aDvuF1dozvQnpJZnTnBmAbTg2RrNPcbPvR9cpYS7DrB5fAX4DYOeskDuXGDljy5iLc4y
 Sy8tvNaA/Xn6UCJOeXe24Utw7tKeXkhst3UiM98s/wr0bU4Xq/jikcuk0kG9YXqfgzYb
 yJneJ+XMcTnEuu7e5+5k93O0cTeuVHHg+BCspncbLtBHRcWI4Aa9qHw4lpP6c8HzE0Fo
 H91g==
X-Gm-Message-State: AOAM53017JBisFA9LG6FQ+qNDFOEdGXgvEr2wxn7p+fPqkIFoWrVR6iJ
 dRZtJs+2xsOAgRBB3K9Gz/y/IKoUraojWgwhgzk=
X-Google-Smtp-Source: ABdhPJy9IUTK4I0jigH0pAOy7P1F8QrMU7I2glhUrPkwnxEiDTrYBsjSkw2RvabkCtPJ5svosZq/cz+PuRoHz3nWTLs=
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr239277iop.14.1594832049968;
 Wed, 15 Jul 2020 09:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200715140440.3540942-1-armbru@redhat.com>
 <20200715140440.3540942-3-armbru@redhat.com>
In-Reply-To: <20200715140440.3540942-3-armbru@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 15 Jul 2020 18:53:59 +0200
Message-ID: <CAPan3WoowPGN27U-FeK3Vk88p8HZTvmC0eDbrm86WNwwd44hqA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 2/2] hw: Mark nd_table[] misuse in realize methods
 FIXME
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d09bd305aa7dc591"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd44.google.com
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 alistair@alistair23.me, mark.cave-ayland@ilande.co.uk,
 QEMU Developers <qemu-devel@nongnu.org>, sundeep.lkml@gmail.com,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 palmer@dabbelt.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d09bd305aa7dc591
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 15, 2020, 16:04 Markus Armbruster <armbru@redhat.com> wrote:

> nd_table[] contains NIC configuration for boards to pick up.  Device
> code has no business looking there.  Several devices do it anyway.
> Two of them already have a suitable FIXME comment: "allwinner-a10" and
> "msf2-soc".  Copy it to the others: "allwinner-h3", "xlnx-versal",
> "xlnx,zynqmp", "sparc32-ledma", "riscv.sifive.u.soc".
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

---
>  hw/arm/allwinner-h3.c | 1 +
>  hw/arm/xlnx-versal.c  | 1 +
>  hw/arm/xlnx-zynqmp.c  | 1 +
>  hw/dma/sparc32_dma.c  | 1 +
>  hw/riscv/sifive_u.c   | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 8e09468e86..ff92ded82c 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -358,6 +358,7 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
>                                "sd-bus");
>
>      /* EMAC */
> +    /* FIXME use qdev NIC properties instead of nd_table[] */
>      if (nd_table[0].used) {
>          qemu_check_nic_model(&nd_table[0], TYPE_AW_SUN8I_EMAC);
>          qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index ead038b971..e3aa4bd1e5 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -160,6 +160,7 @@ static void versal_create_gems(Versal *s, qemu_irq
> *pic)
>          object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
>                                  TYPE_CADENCE_GEM);
>          dev = DEVICE(&s->lpd.iou.gem[i]);
> +        /* FIXME use qdev NIC properties instead of nd_table[] */
>          if (nd->used) {
>              qemu_check_nic_model(nd, "cadence_gem");
>              qdev_set_nic_properties(dev, nd);
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 772cfa3771..5855e5d5bf 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -455,6 +455,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev,
> Error **errp)
>      for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
>          NICInfo *nd = &nd_table[i];
>
> +        /* FIXME use qdev NIC properties instead of nd_table[] */
>          if (nd->used) {
>              qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
>              qdev_set_nic_properties(DEVICE(&s->gem[i]), nd);
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 9459178866..bcd1626fbd 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -341,6 +341,7 @@ static void sparc32_ledma_device_realize(DeviceState
> *dev, Error **errp)
>      DeviceState *d;
>      NICInfo *nd = &nd_table[0];
>
> +    /* FIXME use qdev NIC properties instead of nd_table[] */
>      qemu_check_nic_model(nd, TYPE_LANCE);
>
>      d = qdev_new(TYPE_LANCE);
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 19a976c9a6..e5682c38a9 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -714,6 +714,7 @@ static void sifive_u_soc_realize(DeviceState *dev,
> Error **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0,
> memmap[SIFIVE_U_OTP].base);
>
> +    /* FIXME use qdev NIC properties instead of nd_table[] */
>      if (nd->used) {
>          qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
>          qdev_set_nic_properties(DEVICE(&s->gem), nd);
> --
> 2.26.2
>
>

--000000000000d09bd305aa7dc591
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jul 15, 2020, 16:04 Markus Armbruster &lt;<a h=
ref=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">nd_table[] contains NIC configuration for bo=
ards to pick up.=C2=A0 Device<br>
code has no business looking there.=C2=A0 Several devices do it anyway.<br>
Two of them already have a suitable FIXME comment: &quot;allwinner-a10&quot=
; and<br>
&quot;msf2-soc&quot;.=C2=A0 Copy it to the others: &quot;allwinner-h3&quot;=
, &quot;xlnx-versal&quot;,<br>
&quot;xlnx,zynqmp&quot;, &quot;sparc32-ledma&quot;, &quot;riscv.sifive.u.so=
c&quot;.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto">Reviewed-by: Niek Linnenbank &lt;<a href=
=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
---<br>
=C2=A0hw/arm/allwinner-h3.c | 1 +<br>
=C2=A0hw/arm/xlnx-versal.c=C2=A0 | 1 +<br>
=C2=A0hw/arm/xlnx-zynqmp.c=C2=A0 | 1 +<br>
=C2=A0hw/dma/sparc32_dma.c=C2=A0 | 1 +<br>
=C2=A0hw/riscv/sifive_u.c=C2=A0 =C2=A0| 1 +<br>
=C2=A05 files changed, 5 insertions(+)<br>
<br>
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
index 8e09468e86..ff92ded82c 100644<br>
--- a/hw/arm/allwinner-h3.c<br>
+++ b/hw/arm/allwinner-h3.c<br>
@@ -358,6 +358,7 @@ static void allwinner_h3_realize(DeviceState *dev, Erro=
r **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;sd-bus&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* EMAC */<br>
+=C2=A0 =C2=A0 /* FIXME use qdev NIC properties instead of nd_table[] */<br=
>
=C2=A0 =C2=A0 =C2=A0if (nd_table[0].used) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_check_nic_model(&amp;nd_table[0], TY=
PE_AW_SUN8I_EMAC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_nic_properties(DEVICE(&amp;s-&gt=
;emac), &amp;nd_table[0]);<br>
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c<br>
index ead038b971..e3aa4bd1e5 100644<br>
--- a/hw/arm/xlnx-versal.c<br>
+++ b/hw/arm/xlnx-versal.c<br>
@@ -160,6 +160,7 @@ static void versal_create_gems(Versal *s, qemu_irq *pic=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_initialize_child(OBJECT(s), name, =
&amp;s-&gt;lpd.iou.gem[i],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_CADENCE_GEM);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev =3D DEVICE(&amp;s-&gt;lpd.iou.gem[i])=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME use qdev NIC properties instead of nd=
_table[] */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nd-&gt;used) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_check_nic_model(nd, &q=
uot;cadence_gem&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_nic_properties(dev=
, nd);<br>
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c<br>
index 772cfa3771..5855e5d5bf 100644<br>
--- a/hw/arm/xlnx-zynqmp.c<br>
+++ b/hw/arm/xlnx-zynqmp.c<br>
@@ -455,6 +455,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; XLNX_ZYNQMP_NUM_GEMS; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NICInfo *nd =3D &amp;nd_table[i];<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME use qdev NIC properties instead of nd=
_table[] */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nd-&gt;used) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_check_nic_model(nd, TY=
PE_CADENCE_GEM);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_nic_properties(DEV=
ICE(&amp;s-&gt;gem[i]), nd);<br>
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c<br>
index 9459178866..bcd1626fbd 100644<br>
--- a/hw/dma/sparc32_dma.c<br>
+++ b/hw/dma/sparc32_dma.c<br>
@@ -341,6 +341,7 @@ static void sparc32_ledma_device_realize(DeviceState *d=
ev, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *d;<br>
=C2=A0 =C2=A0 =C2=A0NICInfo *nd =3D &amp;nd_table[0];<br>
<br>
+=C2=A0 =C2=A0 /* FIXME use qdev NIC properties instead of nd_table[] */<br=
>
=C2=A0 =C2=A0 =C2=A0qemu_check_nic_model(nd, TYPE_LANCE);<br>
<br>
=C2=A0 =C2=A0 =C2=A0d =3D qdev_new(TYPE_LANCE);<br>
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c<br>
index 19a976c9a6..e5682c38a9 100644<br>
--- a/hw/riscv/sifive_u.c<br>
+++ b/hw/riscv/sifive_u.c<br>
@@ -714,6 +714,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Erro=
r **errp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;otp), 0, memm=
ap[SIFIVE_U_OTP].base);<br>
<br>
+=C2=A0 =C2=A0 /* FIXME use qdev NIC properties instead of nd_table[] */<br=
>
=C2=A0 =C2=A0 =C2=A0if (nd-&gt;used) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_check_nic_model(nd, TYPE_CADENCE_GEM=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_nic_properties(DEVICE(&amp;s-&gt=
;gem), nd);<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div></div></div>

--000000000000d09bd305aa7dc591--

