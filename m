Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F45C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2C820848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2C820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTL5g-0000iP-4e
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTL4J-0007qt-Rg
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:26:31 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTL4I-0001NO-6N
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:26:31 -0400
Received: by mail-ej1-f66.google.com with SMTP id a3so1878444ejy.11
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 01:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D4dDi6l7QuQv0ulKXXAvNZfVpvwYBS5WLPfkK6imH8k=;
 b=ptRyAxjgi+zAavNNK/BjKIiO/sDb7nfbJ/v6VuOwaEEY6Phtwmek70NQMjvfKMutaT
 S2oROlPAa7ExswDenfjabfY+J0HFgkioQANCPp7dmglbaY2TDeldN/u0rYQu0a3//YWQ
 TPvHf+Xyxy5NA+98pKH5MGar2dYLMKtMnvTMHj35daP4LxXPsDjLd9EYGcXVrlRiA8Ba
 jZzImQVHKgwamS2AZxJNZ2hPFMeksiUJRArDhor0yuizI5zls9fSKQL4bxXAGjID0IvN
 nTwTJ0sklftr7Njm3fVy3Dc4EFh48pZJCiqCuk3Vh9qo5vfUv8azZDO7SKYsZIveELTy
 ZGtg==
X-Gm-Message-State: AOAM5325IAIz5qWIhqTlKsDPpWW4yWjLhrd/cOXrOyMl/feoHwU17COL
 NQnLpxtkjuq0u3BR+sjYDEUl+MX/38urEcVLUPc=
X-Google-Smtp-Source: ABdhPJwY8oL+8xbzcSM+Q05wZiIAytAD52B/SBTBRc8cN2CUrT6DFofDnYrxi2sO1eZG9Kb9U6UjqcrYoE6BZu1y/CI=
X-Received: by 2002:a17:906:bc42:: with SMTP id
 s2mr2461223ejv.251.1602836788831; 
 Fri, 16 Oct 2020 01:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201015201840.282956-1-brogers@suse.com>
In-Reply-To: <20201015201840.282956-1-brogers@suse.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Oct 2020 10:26:16 +0200
Message-ID: <CAAdtpL73mOJM1Jp45fh_CrN45eQ4ezLnEzUzMGTjUYNKZufQPA@mail.gmail.com>
Subject: Re: [PATCH] meson: Only install icons and qemu.desktop if have_system
To: Bruce Rogers <brogers@suse.com>
Content-Type: multipart/alternative; boundary="0000000000006e6d0405b1c58570"
Received-SPF: pass client-ip=209.85.218.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 04:26:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, HTML_MESSAGE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006e6d0405b1c58570
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 15 oct. 2020 22:22, Bruce Rogers <brogers@suse.com> a =C3=A9crit :

> These files are not needed for a linux-user only install.


> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  ui/meson.build | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/ui/meson.build b/ui/meson.build
> index 78ad792ffb..fb36d305ca 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -113,8 +113,11 @@ if have_system or xkbcommon.found()
>  endif
>
>  subdir('shader')
> -subdir('icons')
>
> -install_data('qemu.desktop', install_dir: config_host['qemu_desktopdir']=
)
> +if have_system
>

Some tools could have an icon, QSD later?

For now:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

+  subdir('icons')
> +
> +  install_data('qemu.desktop', install_dir:
> config_host['qemu_desktopdir'])
> +endif
>
>  modules +=3D {'ui': ui_modules}
> --
> 2.28.0
>
>
>

--0000000000006e6d0405b1c58570
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le jeu. 15 oct. 2020 22:22, Bruce Rogers &lt;<a href=3D"ma=
ilto:brogers@suse.com">brogers@suse.com</a>&gt; a =C3=A9crit=C2=A0:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">These files are not needed for a linux-use=
r only install.</blockquote></div></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Bruce Rogers &lt;<a href=3D"mailto:brogers@suse.com" target=
=3D"_blank" rel=3D"noreferrer">brogers@suse.com</a>&gt;<br>
---<br>
=C2=A0ui/meson.build | 7 +++++--<br>
=C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/ui/meson.build b/ui/meson.build<br>
index 78ad792ffb..fb36d305ca 100644<br>
--- a/ui/meson.build<br>
+++ b/ui/meson.build<br>
@@ -113,8 +113,11 @@ if have_system or xkbcommon.found()<br>
=C2=A0endif<br>
<br>
=C2=A0subdir(&#39;shader&#39;)<br>
-subdir(&#39;icons&#39;)<br>
<br>
-install_data(&#39;qemu.desktop&#39;, install_dir: config_host[&#39;qemu_de=
sktopdir&#39;])<br>
+if have_system<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Some tools could have an icon, QSD later?</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">For now:=C2=A0</div><div dir=3D"auto">Revi=
ewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org"=
>f4bug@amsat.org</a>&gt;<br></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 subdir(&#39;icons&#39;)<br>
+<br>
+=C2=A0 install_data(&#39;qemu.desktop&#39;, install_dir: config_host[&#39;=
qemu_desktopdir&#39;])<br>
+endif<br>
<br>
=C2=A0modules +=3D {&#39;ui&#39;: ui_modules}<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000006e6d0405b1c58570--

