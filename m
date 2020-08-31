Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4571C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9B220719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9B220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCm46-0007OP-Rk
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCm3G-0005mJ-Ub
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:49:00 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCm3E-0003Km-Ky
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:48:57 -0400
Received: by mail-ej1-f67.google.com with SMTP id d11so9088367ejt.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 08:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9JbQ2L5CEXviABFZjA1WI+SKVNA86hi2b5i361b601Q=;
 b=dBxqkhThuFWq3ToinFatB0Br8+vfldqzmtarQliJ1e7XG4k4hw7Pt1zOlSfA+5bdmw
 XYmROB3i+S36Th/CotUuryIQMGLVSP+mgumiB0vBmlmDg5b8ok/jUhEjeoeY1ZTi8uxq
 ZgCMonjCQKkSX3BgWW7rHV6U8u7Q/EHFX3DSEZHJJOVPQV/gr0tF9z9TwZjy7zhrV/cf
 AEDB5X189IADiQ8CMqQMDM79Vj4jmpgBPV/iM4wCmZpxhUhYhcx8hzIX9HSHHjRaQVPB
 OEJbjFIhpnjhRKSuahP5K3FlDbDQDEF93hwxW4aUNX7cwK6blJhwwHmoPd6H2o2aPqBB
 6/Lg==
X-Gm-Message-State: AOAM5313bZtseZ3mK9u5E8D0NYufHD9s07wRzzGNIqozWKD4JwwRo4jP
 l+Vqo89tR8diNyzD8Ami3AumQtUWFJyAw8/Q4Ys=
X-Google-Smtp-Source: ABdhPJxraFIhltL/UNhPf7KlPnLp6mGafr5LttLnjKtHQSDdQ+JqcJ1cPe+DVP9/PIYY64qSVIgdaP11V5198Z1bydA=
X-Received: by 2002:a17:906:c1c3:: with SMTP id
 bw3mr1773968ejb.8.1598888934768; 
 Mon, 31 Aug 2020 08:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200830204640.482214-1-sw@weilnetz.de>
In-Reply-To: <20200830204640.482214-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 17:48:13 +0200
Message-ID: <CAAdtpL5eOO8JDZgGL-PzoM1UE2mshb+y7zNuQ+DdgtUdTgej6g@mail.gmail.com>
Subject: Re: [PATCH] meson: add pixman dependency to chardev/baum module
To: Stefan Weil <sw@weilnetz.de>
Content-Type: multipart/alternative; boundary="000000000000fe055805ae2e560f"
Received-SPF: pass client-ip=209.85.218.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 11:48:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fe055805ae2e560f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 30 ao=C3=BBt 2020 22:47, Stefan Weil <sw@weilnetz.de> a =C3=A9crit =
:

> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>
>
> Together with Paolo's patch (https://patchwork.kernel.org/patch/11745207/=
)
> this fixed the build with --enable-modules for me.
>
> Stefan
>
>
>  chardev/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/meson.build b/chardev/meson.build
> index 7726837e34..27a9a28f4c 100644
> --- a/chardev/meson.build
> +++ b/chardev/meson.build
> @@ -38,7 +38,7 @@ chardev_modules =3D {}
>
>  if config_host.has_key('CONFIG_BRLAPI') and sdl.found()
>    module_ss =3D ss.source_set()
> -  module_ss.add(when: [sdl, brlapi], if_true: files('baum.c'))
> +  module_ss.add(when: [sdl, brlapi], if_true: [files('baum.c'), pixman])
>    chardev_modules +=3D { 'baum': module_ss }
>  endif
>
> --
> 2.28.0
>
>
>

--000000000000fe055805ae2e560f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le dim. 30 ao=C3=BBt 2020 22:47, Stefan Weil &lt;<a href=
=3D"mailto:sw@weilnetz.de">sw@weilnetz.de</a>&gt; a =C3=A9crit=C2=A0:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Signed-off-by: Stefan Weil &lt;<a href=
=3D"mailto:sw@weilnetz.de" target=3D"_blank" rel=3D"noreferrer">sw@weilnetz=
.de</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">Review=
ed-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat=
.org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:sans-=
serif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-family:san=
s-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
---<br>
<br>
<br>
Together with Paolo&#39;s patch (<a href=3D"https://patchwork.kernel.org/pa=
tch/11745207/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://patc=
hwork.kernel.org/patch/11745207/</a>)<br>
this fixed the build with --enable-modules for me.<br>
<br>
Stefan<br>
<br>
<br>
=C2=A0chardev/meson.build | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/chardev/meson.build b/chardev/meson.build<br>
index 7726837e34..27a9a28f4c 100644<br>
--- a/chardev/meson.build<br>
+++ b/chardev/meson.build<br>
@@ -38,7 +38,7 @@ chardev_modules =3D {}<br>
<br>
=C2=A0if config_host.has_key(&#39;CONFIG_BRLAPI&#39;) and sdl.found()<br>
=C2=A0 =C2=A0module_ss =3D ss.source_set()<br>
-=C2=A0 module_ss.add(when: [sdl, brlapi], if_true: files(&#39;baum.c&#39;)=
)<br>
+=C2=A0 module_ss.add(when: [sdl, brlapi], if_true: [files(&#39;baum.c&#39;=
), pixman])<br>
=C2=A0 =C2=A0chardev_modules +=3D { &#39;baum&#39;: module_ss }<br>
=C2=A0endif<br>
<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000fe055805ae2e560f--

