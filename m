Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FE42088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlYtLabE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FE42088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGVY-00029x-DP
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jeGQy-0001X2-51; Thu, 28 May 2020 07:10:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jeGQw-0004i8-1L; Thu, 28 May 2020 07:10:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id j16so14982959wrb.7;
 Thu, 28 May 2020 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pnRkSu0SM+ZLY61obT+Ixt0Toi3xI882oeYpRICjbBc=;
 b=GlYtLabEoZOvJLFMrpXf1RnpxK4DS979lnmBsVQ1hVDIuEgHekce1edo6woK/vE9CX
 RvnVAUahvHh5hkoAODqEIDgWYKgzHiv7OJ0s2Tl6biQ30hUI1tqsAJrpK+Ft6WReOaUU
 6T331/0TSm21MioDJ0EC1zWQmywUOMvb4g+Klz+8uuF4xk6s/Dd9ZDtuoSKlA4XZR84g
 wv/W5j195OITai9jUGWlodyKLyF/QCPZB3LsILiaSY309CHNMdW2UC/6ire2HM3Ws0c+
 G084F131XSr5NiwQXG0BGNZ8nK2UUlCnELJlKniMVgZ+2a50+SkPtwNRjc8UfWE2lfUK
 TCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pnRkSu0SM+ZLY61obT+Ixt0Toi3xI882oeYpRICjbBc=;
 b=eEwuryXpDAJqz7azFAo7idRAe+FT2Q/TiK1DCVNJNnD8LjLDtfIupxfsMyW0ajyzqh
 hXABX3ZSNlBlwr2CesJma7Vw0/O99oXu5eH3wUa3fg8XnsXUSbcw7X6qOiUQoaCgxOj/
 0thGRlKWrvILKQNIvNCzoaAi5iAIl+RUAzMfkG+X+GiDlpUbm48AFG49UvUHEHg/dKd+
 iW0oy7Isa7TlDux8ohCjjHiKgEUjL9flTTJ/n+X2lIqRVWU+7uVfkB/OWPWu9unIfq0J
 SN1Aaffr5YL2cg0uFljhxA0/qkQYVZcJ/KE6Gj8EHvcpqfm7bz3WwNxeq3VC/F6/Ic/3
 Ej2g==
X-Gm-Message-State: AOAM5308d/XixA/PQr18PSLfO+4bPfvKR00VXJSZw3w48AIvF44gDAnG
 /0s+KzZBO8HgM+e7BeVs0jQGUcWnUKxOPHebzJw=
X-Google-Smtp-Source: ABdhPJwF25Gi+0zqJH8SPOoBajsEFyvC8jm5HUzK3WQpvKNEFDahYZbjR34FvDW71CVVNn5CrAcK4n5OFCJKwtBzSIw=
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr306409wrv.162.1590664243302;
 Thu, 28 May 2020 04:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-19-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-19-armbru@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 28 May 2020 13:08:53 +0200
Message-ID: <CAHiYmc5DrMfeztrpnds0YwLetHYoPgfJbMytgMnEERmufcg8HA@mail.gmail.com>
Subject: Re: [PATCH v2 18/24] display/sm501 display/ati: Fix to realize
 "i2c-ddc"
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002dd5ca05a6b36106"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Huacai Chen <chenhuacai@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002dd5ca05a6b36106
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just adding Huacai, the original author and the new maintainer for Fuloong
2E machine.

1:04 PM =C4=8Cet, 28.05.2020. Markus Armbruster <armbru@redhat.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> sm501_init() and ati_vga_realize() create an "i2c-ddc" device, but
> neglect to realize it.  Affects machines sam460ex, shix, r2d, and
> fulong2e.
>
> In theory, a device becomes real only on realize.  In practice, the
> transition from unreal to real is a fuzzy one.  The work to make a
> device real can be spread between realize methods (fine),
> instance_init methods (wrong), and board code wiring up the device
> (fine as long as it effectively happens on realize).  Depending on
> what exactly is done where, a device can work even when we neglect
> to realize it.
>
> This one appears to work.  Nevertheless, it's a clear misuse of the
> interface.  Even when it works today (more or less by chance), it can
> break tomorrow.
>
> Fix by realizing it right away.  Visible in "info qom-tree"; here's
> the change for sam460ex:
>
>      /machine (sam460ex-machine)
>        [...]
>        /unattached (container)
>          [...]
>     -    /device[14] (sii3112)
>     +    /device[14] (i2c-ddc)
>     +    /device[15] (sii3112)
>          [rest of device[*] renumbered...]
>
> Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a
> Fixes: c82c7336de58876862e6b4dccbda29e9240fd388
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-ppc@nongnu.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/ati.c   | 2 ++
>  hw/display/sm501.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 065f197678..5c71e5f295 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -929,6 +929,8 @@ static void ati_vga_realize(PCIDevice *dev, Error
**errp)
>      bitbang_i2c_init(&s->bbi2c, i2cbus);
>      I2CSlave *i2cddc =3D I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC)=
);
>      i2c_set_slave_address(i2cddc, 0x50);
> +    object_property_set_bool(OBJECT(i2cddc), true, "realized",
> +                             &error_abort);
>
>      /* mmio register space */
>      memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index acc692531a..fbedc56715 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1816,6 +1816,8 @@ static void sm501_init(SM501State *s, DeviceState
*dev,
>      /* ddc */
>      I2CDDCState *ddc =3D I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2CDDC=
));
>      i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
> +    object_property_set_bool(OBJECT(ddc), true, "realized",
> +                             &error_abort);
>
>      /* mmio */
>      memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio",
MMIO_SIZE);
> --
> 2.21.3
>

--0000000000002dd5ca05a6b36106
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Just adding Huacai, the original author and the new maintain=
er for Fuloong 2E machine.</p>
<p dir=3D"ltr">1:04 PM =C4=8Cet, 28.05.2020. Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; sm501_init() and ati_vga_realize() create an &quot;i2c-ddc&quot; devic=
e, but<br>
&gt; neglect to realize it.=C2=A0 Affects machines sam460ex, shix, r2d, and=
<br>
&gt; fulong2e.<br>
&gt;<br>
&gt; In theory, a device becomes real only on realize.=C2=A0 In practice, t=
he<br>
&gt; transition from unreal to real is a fuzzy one.=C2=A0 The work to make =
a<br>
&gt; device real can be spread between realize methods (fine),<br>
&gt; instance_init methods (wrong), and board code wiring up the device<br>
&gt; (fine as long as it effectively happens on realize).=C2=A0 Depending o=
n<br>
&gt; what exactly is done where, a device can work even when we neglect<br>
&gt; to realize it.<br>
&gt;<br>
&gt; This one appears to work.=C2=A0 Nevertheless, it&#39;s a clear misuse =
of the<br>
&gt; interface.=C2=A0 Even when it works today (more or less by chance), it=
 can<br>
&gt; break tomorrow.<br>
&gt;<br>
&gt; Fix by realizing it right away.=C2=A0 Visible in &quot;info qom-tree&q=
uot;; here&#39;s<br>
&gt; the change for sam460ex:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0/machine (sam460ex-machine)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0[...]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0/unattached (container)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[...]<br>
&gt; =C2=A0 =C2=A0 -=C2=A0 =C2=A0 /device[14] (sii3112)<br>
&gt; =C2=A0 =C2=A0 +=C2=A0 =C2=A0 /device[14] (i2c-ddc)<br>
&gt; =C2=A0 =C2=A0 +=C2=A0 =C2=A0 /device[15] (sii3112)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[rest of device[*] renumbered...]<br=
>
&gt;<br>
&gt; Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a<br>
&gt; Fixes: c82c7336de58876862e6b4dccbda29e9240fd388<br>
&gt; Cc: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@e=
ik.bme.hu</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:qemu-ppc@nongnu.org">qemu-ppc@nongnu.org</a><br>
&gt; Cc: Magnus Damm &lt;<a href=3D"mailto:magnus.damm@gmail.com">magnus.da=
mm@gmail.com</a>&gt;<br>
&gt; Cc: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org"=
>f4bug@amsat.org</a>&gt;<br>
&gt; Cc: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gm=
ail.com">aleksandar.qemu.devel@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.c=
om">armbru@redhat.com</a>&gt;<br>
&gt; Tested-by: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">ba=
laton@eik.bme.hu</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0hw/display/ati.c=C2=A0 =C2=A0| 2 ++<br>
&gt; =C2=A0hw/display/sm501.c | 2 ++<br>
&gt; =C2=A02 files changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/display/ati.c b/hw/display/ati.c<br>
&gt; index 065f197678..5c71e5f295 100644<br>
&gt; --- a/hw/display/ati.c<br>
&gt; +++ b/hw/display/ati.c<br>
&gt; @@ -929,6 +929,8 @@ static void ati_vga_realize(PCIDevice *dev, Error =
**errp)<br>
&gt; =C2=A0 =C2=A0 =C2=A0bitbang_i2c_init(&amp;s-&gt;bbi2c, i2cbus);<br>
&gt; =C2=A0 =C2=A0 =C2=A0I2CSlave *i2cddc =3D I2C_SLAVE(qdev_create(BUS(i2c=
bus), TYPE_I2CDDC));<br>
&gt; =C2=A0 =C2=A0 =C2=A0i2c_set_slave_address(i2cddc, 0x50);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(i2cddc), true, &quot;re=
alized&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0/* mmio register space */<br>
&gt; =C2=A0 =C2=A0 =C2=A0memory_region_init_io(&amp;s-&gt;mm, OBJECT(s), &a=
mp;ati_mm_ops, s,<br>
&gt; diff --git a/hw/display/sm501.c b/hw/display/sm501.c<br>
&gt; index acc692531a..fbedc56715 100644<br>
&gt; --- a/hw/display/sm501.c<br>
&gt; +++ b/hw/display/sm501.c<br>
&gt; @@ -1816,6 +1816,8 @@ static void sm501_init(SM501State *s, DeviceStat=
e *dev,<br>
&gt; =C2=A0 =C2=A0 =C2=A0/* ddc */<br>
&gt; =C2=A0 =C2=A0 =C2=A0I2CDDCState *ddc =3D I2CDDC(qdev_create(BUS(s-&gt;=
i2c_bus), TYPE_I2CDDC));<br>
&gt; =C2=A0 =C2=A0 =C2=A0i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(ddc), true, &quot;reali=
zed&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0/* mmio */<br>
&gt; =C2=A0 =C2=A0 =C2=A0memory_region_init(&amp;s-&gt;mmio_region, OBJECT(=
dev), &quot;sm501.mmio&quot;, MMIO_SIZE);<br>
&gt; -- <br>
&gt; 2.21.3<br>
&gt;<br>
</p>

--0000000000002dd5ca05a6b36106--

