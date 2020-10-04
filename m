Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E0C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 21:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC042078D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 21:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe/LHXFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC042078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPBFR-0000Yr-NY
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 17:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kPBEM-000069-Ms
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 17:07:42 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:36274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kPBEH-0002dT-3h
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 17:07:42 -0400
Received: by mail-il1-x143.google.com with SMTP id t12so6062391ilh.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jPSWkgeuQXeF8r9tu5JJyeZljsDyYvKZkjegDwYdYIc=;
 b=Fe/LHXFdMPlLbflBK+CcpRKokU3eiPxX5QVq5a2Ef1nweY/Or2cN99I0PYX5mxQFde
 5LZ+D0BNiqBjIDDsfFXtlVRYsNI7ef77WxRwY3N7fab2A0yl5HE9GRvAi1hZ0x9katS3
 iH2GtpSXpvZ6ysyRvLyaFiKqRiwDQ+Oa8rzNV4KDBzykaMpYVHJar7kFl41gBAvWFtTa
 LvgTMMARD4kB1OjHWDIjbcQEakMYbzzVQocSaHbjEtsPl6/8WcpVuPZorU6pR98y8Usx
 CN88kpne3CKsqzTH7fAE0/nlhy82itEzLOBtfK9Pbq6a0TcbU5uLkhdbbyR9TcpDOk5k
 h4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jPSWkgeuQXeF8r9tu5JJyeZljsDyYvKZkjegDwYdYIc=;
 b=SnUpSkOunPMMsIiH08euXy8FJXCfJI1tzuUIe9cllh1XZhyys00u7C7E0YjGzvc0rE
 quUyJTY8RGdwIBCCJe5pog76XJWLuaiWYXhicU3qknIyogrPLp0nLQeMzishiE5GcTcY
 VztteU8Vtkjv+7vpdOZTI9j+O4DhccWNzYCq84FLDOPIUyvKJakk7Byn0zvsQhnHidrf
 lX51szm06eI+5NcQChjNu5O1C+mQkPAzM9H/pdNf/Y3u8v204gTVpg/OOwaLhoLEkViu
 4nb0D8lZprwDfFhN5ayP+qD3xJ3Ul77WbAJBWUG+gXZIKRcylNnF26Zy6NJ+bUCY1mmf
 gQoQ==
X-Gm-Message-State: AOAM532W8NR2Awfv62+TNNeQ/XDv8xhjZuXKG43UWhw9OOX72gp/JMed
 uN74fJ/3+1WN+/LsaoJ/liEHbEktftGGjlq6ZH4=
X-Google-Smtp-Source: ABdhPJzUuMCHm3vZDkPdfgSXn10oRh04ccoA0LhXICa7WLtPzNpqyFitY7aMBqutarZPw3GFI/59OgMOOg4Ts+IBGXg=
X-Received: by 2002:a92:d6cd:: with SMTP id z13mr2023714ilp.275.1601845655748; 
 Sun, 04 Oct 2020 14:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201004182506.2038515-1-f4bug@amsat.org>
In-Reply-To: <20201004182506.2038515-1-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 4 Oct 2020 23:07:22 +0200
Message-ID: <CAPan3Wqatde4qoskcf9uiUECpNP+9KR4VfgTXPWO=S2cd73sbw@mail.gmail.com>
Subject: Re: [RFC PATCH] contrib/gitdm: Add more individual contributors
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000004bc7ca05b0dec11d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-il1-x143.google.com
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
Cc: James Hogan <jhogan@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Sven Schnelle <svens@stackframe.org>, Paul Burton <paulburton@kernel.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Finn Thain <fthain@telegraphics.com.au>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, David Carlier <devnexen@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004bc7ca05b0dec11d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Niek Linnenbank <nieklinnenbank@gmail.com>


Op zo 4 okt. 2020 20:25 schreef Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>:

> These individual contributors have a number of contributions,
> add them to the 'individual' group map.
>
> Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: David Carlier <devnexen@gmail.com>
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
> Cc: K=C5=91v=C3=A1g=C3=B3 Zolt=C3=A1n <dirty.ice.hu@gmail.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Michael Rolnik <mrolnik@gmail.com>
> Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Paul Zimmerman <pauldzim@gmail.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> Cc: Sven Schnelle <svens@stackframe.org>
> Cc: Thomas Huth <huth@tuxfamily.org>
> Cc: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> To the developers Cc'ed: If you agree with your entry, please
> reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
> care, please either reply with Nack-by or ignore this patch.
> I'll repost in 2 weeks as formal patch (not RFC) with only the
> entries acked by their author.
> ---
>  contrib/gitdm/group-map-individuals | 22 ++++++++++++++++++++++
>  contrib/gitdm/group-map-redhat      |  1 -
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/gitdm/group-map-individuals
> b/contrib/gitdm/group-map-individuals
> index cf8a2ce367..b478fd4576 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -16,3 +16,25 @@ aurelien@aurel32.net
>  balaton@eik.bme.hu
>  e.emanuelegiuseppe@gmail.com
>  andrew.smirnov@gmail.com
> +sw@weilnetz.de
> +huth@tuxfamily.org
> +laurent@vivier.eu
> +atar4qemu@gmail.com
> +hpoussin@reactos.org
> +deller@gmx.de
> +alistair@alistair23.me
> +fthain@telegraphics.com.au
> +svens@stackframe.org
> +aleksandar.qemu.devel@gmail.com
> +jhogan@kernel.org
> +paulburton@kernel.org
> +vr_qemu@t-online.de
> +nieklinnenbank@gmail.com
> +devnexen@gmail.com
> +jcd@tribudubois.net
> +dirty.ice.hu@gmail.com
> +mrolnik@gmail.com
> +pauldzim@gmail.com
> +linux@roeck-us.net
> +sundeep.lkml@gmail.com
> +ahmedkhaledkaraman@gmail.com
> diff --git a/contrib/gitdm/group-map-redhat
> b/contrib/gitdm/group-map-redhat
> index d15db2d35e..4a8ca84b36 100644
> --- a/contrib/gitdm/group-map-redhat
> +++ b/contrib/gitdm/group-map-redhat
> @@ -3,6 +3,5 @@
>  #
>
>  david@gibson.dropbear.id.au
> -laurent@vivier.eu
>  pjp@fedoraproject.org
>  armbru@pond.sub.org
> --
> 2.26.2
>
>

--0000000000004bc7ca05b0dec11d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Acked-by: Niek Linnenbank &lt;<a href=3D"mailto:niek=
linnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</div><div dir=3D"aut=
o"><br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=
=3D"gmail_attr">Op zo 4 okt. 2020 20:25 schreef Philippe Mathieu-Daud=C3=A9=
 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">These individual contributors have a number o=
f contributions,<br>
add them to the &#39;individual&#39; group map.<br>
<br>
Cc: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com" targe=
t=3D"_blank" rel=3D"noreferrer">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
Cc: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.c=
om" target=3D"_blank" rel=3D"noreferrer">aleksandar.qemu.devel@gmail.com</a=
>&gt;<br>
Cc: Alistair Francis &lt;<a href=3D"mailto:alistair@alistair23.me" target=
=3D"_blank" rel=3D"noreferrer">alistair@alistair23.me</a>&gt;<br>
Cc: Artyom Tarasenko &lt;<a href=3D"mailto:atar4qemu@gmail.com" target=3D"_=
blank" rel=3D"noreferrer">atar4qemu@gmail.com</a>&gt;<br>
Cc: David Carlier &lt;<a href=3D"mailto:devnexen@gmail.com" target=3D"_blan=
k" rel=3D"noreferrer">devnexen@gmail.com</a>&gt;<br>
Cc: Finn Thain &lt;<a href=3D"mailto:fthain@telegraphics.com.au" target=3D"=
_blank" rel=3D"noreferrer">fthain@telegraphics.com.au</a>&gt;<br>
Cc: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blan=
k" rel=3D"noreferrer">linux@roeck-us.net</a>&gt;<br>
Cc: Helge Deller &lt;<a href=3D"mailto:deller@gmx.de" target=3D"_blank" rel=
=3D"noreferrer">deller@gmx.de</a>&gt;<br>
Cc: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos.org" targe=
t=3D"_blank" rel=3D"noreferrer">hpoussin@reactos.org</a>&gt;<br>
Cc: James Hogan &lt;<a href=3D"mailto:jhogan@kernel.org" target=3D"_blank" =
rel=3D"noreferrer">jhogan@kernel.org</a>&gt;<br>
Cc: Jean-Christophe Dubois &lt;<a href=3D"mailto:jcd@tribudubois.net" targe=
t=3D"_blank" rel=3D"noreferrer">jcd@tribudubois.net</a>&gt;<br>
Cc: K=C5=91v=C3=A1g=C3=B3 Zolt=C3=A1n &lt;<a href=3D"mailto:dirty.ice.hu@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">dirty.ice.hu@gmail.com</a>&gt=
;<br>
Cc: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" target=3D"_blan=
k" rel=3D"noreferrer">laurent@vivier.eu</a>&gt;<br>
Cc: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blan=
k" rel=3D"noreferrer">mrolnik@gmail.com</a>&gt;<br>
Cc: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">nieklinnenbank@gmail.com</a>&gt;<br>
Cc: Paul Burton &lt;<a href=3D"mailto:paulburton@kernel.org" target=3D"_bla=
nk" rel=3D"noreferrer">paulburton@kernel.org</a>&gt;<br>
Cc: Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com" target=3D"_bla=
nk" rel=3D"noreferrer">pauldzim@gmail.com</a>&gt;<br>
Cc: Stefan Weil &lt;<a href=3D"mailto:sw@weilnetz.de" target=3D"_blank" rel=
=3D"noreferrer">sw@weilnetz.de</a>&gt;<br>
Cc: Subbaraya Sundeep &lt;<a href=3D"mailto:sundeep.lkml@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">sundeep.lkml@gmail.com</a>&gt;<br>
Cc: Sven Schnelle &lt;<a href=3D"mailto:svens@stackframe.org" target=3D"_bl=
ank" rel=3D"noreferrer">svens@stackframe.org</a>&gt;<br>
Cc: Thomas Huth &lt;<a href=3D"mailto:huth@tuxfamily.org" target=3D"_blank"=
 rel=3D"noreferrer">huth@tuxfamily.org</a>&gt;<br>
Cc: Volker R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de" target=
=3D"_blank" rel=3D"noreferrer">vr_qemu@t-online.de</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank" rel=3D"noreferrer">f4bug@amsat.org</a>&gt;<br>
---<br>
To the developers Cc&#39;ed: If you agree with your entry, please<br>
reply with a Reviewed-by/Acked-by tag. If you disagree or doesn&#39;t<br>
care, please either reply with Nack-by or ignore this patch.<br>
I&#39;ll repost in 2 weeks as formal patch (not RFC) with only the<br>
entries acked by their author.<br>
---<br>
=C2=A0contrib/gitdm/group-map-individuals | 22 ++++++++++++++++++++++<br>
=C2=A0contrib/gitdm/group-map-redhat=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 -<br>
=C2=A02 files changed, 22 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-=
individuals<br>
index cf8a2ce367..b478fd4576 100644<br>
--- a/contrib/gitdm/group-map-individuals<br>
+++ b/contrib/gitdm/group-map-individuals<br>
@@ -16,3 +16,25 @@ <a href=3D"mailto:aurelien@aurel32.net" target=3D"_blank=
" rel=3D"noreferrer">aurelien@aurel32.net</a><br>
=C2=A0<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blank" rel=3D"norefe=
rrer">balaton@eik.bme.hu</a><br>
=C2=A0<a href=3D"mailto:e.emanuelegiuseppe@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">e.emanuelegiuseppe@gmail.com</a><br>
=C2=A0<a href=3D"mailto:andrew.smirnov@gmail.com" target=3D"_blank" rel=3D"=
noreferrer">andrew.smirnov@gmail.com</a><br>
+<a href=3D"mailto:sw@weilnetz.de" target=3D"_blank" rel=3D"noreferrer">sw@=
weilnetz.de</a><br>
+<a href=3D"mailto:huth@tuxfamily.org" target=3D"_blank" rel=3D"noreferrer"=
>huth@tuxfamily.org</a><br>
+<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank" rel=3D"noreferrer">=
laurent@vivier.eu</a><br>
+<a href=3D"mailto:atar4qemu@gmail.com" target=3D"_blank" rel=3D"noreferrer=
">atar4qemu@gmail.com</a><br>
+<a href=3D"mailto:hpoussin@reactos.org" target=3D"_blank" rel=3D"noreferre=
r">hpoussin@reactos.org</a><br>
+<a href=3D"mailto:deller@gmx.de" target=3D"_blank" rel=3D"noreferrer">dell=
er@gmx.de</a><br>
+<a href=3D"mailto:alistair@alistair23.me" target=3D"_blank" rel=3D"norefer=
rer">alistair@alistair23.me</a><br>
+<a href=3D"mailto:fthain@telegraphics.com.au" target=3D"_blank" rel=3D"nor=
eferrer">fthain@telegraphics.com.au</a><br>
+<a href=3D"mailto:svens@stackframe.org" target=3D"_blank" rel=3D"noreferre=
r">svens@stackframe.org</a><br>
+<a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">aleksandar.qemu.devel@gmail.com</a><br>
+<a href=3D"mailto:jhogan@kernel.org" target=3D"_blank" rel=3D"noreferrer">=
jhogan@kernel.org</a><br>
+<a href=3D"mailto:paulburton@kernel.org" target=3D"_blank" rel=3D"noreferr=
er">paulburton@kernel.org</a><br>
+<a href=3D"mailto:vr_qemu@t-online.de" target=3D"_blank" rel=3D"noreferrer=
">vr_qemu@t-online.de</a><br>
+<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank" rel=3D"noref=
errer">nieklinnenbank@gmail.com</a><br>
+<a href=3D"mailto:devnexen@gmail.com" target=3D"_blank" rel=3D"noreferrer"=
>devnexen@gmail.com</a><br>
+<a href=3D"mailto:jcd@tribudubois.net" target=3D"_blank" rel=3D"noreferrer=
">jcd@tribudubois.net</a><br>
+<a href=3D"mailto:dirty.ice.hu@gmail.com" target=3D"_blank" rel=3D"norefer=
rer">dirty.ice.hu@gmail.com</a><br>
+<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank" rel=3D"noreferrer">=
mrolnik@gmail.com</a><br>
+<a href=3D"mailto:pauldzim@gmail.com" target=3D"_blank" rel=3D"noreferrer"=
>pauldzim@gmail.com</a><br>
+<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank" rel=3D"noreferrer"=
>linux@roeck-us.net</a><br>
+<a href=3D"mailto:sundeep.lkml@gmail.com" target=3D"_blank" rel=3D"norefer=
rer">sundeep.lkml@gmail.com</a><br>
+<a href=3D"mailto:ahmedkhaledkaraman@gmail.com" target=3D"_blank" rel=3D"n=
oreferrer">ahmedkhaledkaraman@gmail.com</a><br>
diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redha=
t<br>
index d15db2d35e..4a8ca84b36 100644<br>
--- a/contrib/gitdm/group-map-redhat<br>
+++ b/contrib/gitdm/group-map-redhat<br>
@@ -3,6 +3,5 @@<br>
=C2=A0#<br>
<br>
=C2=A0<a href=3D"mailto:david@gibson.dropbear.id.au" target=3D"_blank" rel=
=3D"noreferrer">david@gibson.dropbear.id.au</a><br>
-<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank" rel=3D"noreferrer">=
laurent@vivier.eu</a><br>
=C2=A0<a href=3D"mailto:pjp@fedoraproject.org" target=3D"_blank" rel=3D"nor=
eferrer">pjp@fedoraproject.org</a><br>
=C2=A0<a href=3D"mailto:armbru@pond.sub.org" target=3D"_blank" rel=3D"noref=
errer">armbru@pond.sub.org</a><br>
-- <br>
2.26.2<br>
<br>
</blockquote></div></div></div>

--0000000000004bc7ca05b0dec11d--

