Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64FAC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC49122314
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LALM5XhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC49122314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR0r7-0001kB-Pm
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 18:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kR0pI-0001Bg-Uh
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 18:25:24 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kR0pH-0006fz-1B
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 18:25:24 -0400
Received: by mail-lf1-x142.google.com with SMTP id r127so12239563lff.12
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RChTtjOV2zfZP6XS+ujhvKNtwv+PWfZ3Sidf9WE29Z8=;
 b=LALM5XhYIYhO0xrDn7ZRFoehVa8YjXvSPSZDW1fiKnppNxW8AJaipGx/N0KdYIx/jY
 FgadrXaDDn7v5hsad2rmDHTYxm/eCzXh+ctE/jR/Cy8xfjEleM3iwRJvSePqpypkn1qS
 /GdSgjZd6z8i8HNc1PppvkrooeH66Mk0Gqp9RLmeVFGQ2Xzes/avdWCW9/l2h3L0QJtC
 P3vyCy84dGVc2RVTiFZ64zUqF+xMK/FOHVH34Je+aq7T8AJFyZxbtQy1gVD2fnT2T233
 4TfbhMg9ETFdwhhVHId/GTzipTwjBAFpjsCli1549OySlc85uQn6H0OeDrP6I0xxz0kp
 srSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RChTtjOV2zfZP6XS+ujhvKNtwv+PWfZ3Sidf9WE29Z8=;
 b=WUgHui6vJvP6/uytT5BcC730dR1VYt1xK7io/gjYIxGBj3wYlIEyZ1lkMd13+C5UYy
 EifATAI8k8qtiRdLbms6vABAQ9e1nxWzy7wUfoUTCvw1c1qpAasCmfMuBskGHtyCp2Ic
 6clZkQHLO7g1B9M5Ju8SOXVDDwKbCm+YWAiBwBFc6GLx9ZmKbLY4gLBjiHu7broomfdf
 Js+oZUo0nC6jwxHgvHzsP+ZN9vFHBViDYqOPaBrcowOM/DNhUSaolFYXMVak0i1Zp815
 l3lalbo8YGeTesynHinRNPJ4QSdbgw20cyKGMGGrT4gBSD1FO6zu7mt4wI+kUedIY6CD
 bWCA==
X-Gm-Message-State: AOAM5311ixOZZ1NfgQpj9DvUNdohxWUj0DFYX/uNJhqkCuUh0tofJfWX
 5W9nGXg/qgAVYrrfuHFL891BaasAfWhxKLs3NaY=
X-Google-Smtp-Source: ABdhPJxJhjqJryM1qt39ZpFtvuhD56rENyzWk2EQh/QGTcHeocOZedo6MN9p+fzj1QhCvyTP5xsWhsoHeYNAIxNd+/w=
X-Received: by 2002:a19:e00a:: with SMTP id x10mr5508682lfg.603.1602282320660; 
 Fri, 09 Oct 2020 15:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201004182506.2038515-1-f4bug@amsat.org>
In-Reply-To: <20201004182506.2038515-1-f4bug@amsat.org>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Sat, 10 Oct 2020 00:25:06 +0200
Message-ID: <CALTWKrXwRn+Evakr3kY8r1Q7NK-aB3uw08QwnLpH4uL79a=XUA@mail.gmail.com>
Subject: Re: [RFC PATCH] contrib/gitdm: Add more individual contributors
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000008d957f05b1446c5f"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x142.google.com
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
 Paul Zimmerman <pauldzim@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Paul Burton <paulburton@kernel.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Finn Thain <fthain@telegraphics.com.au>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, David Carlier <devnexen@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008d957f05b1446c5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2020, 8:25 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:

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

Acked-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com <pauldzim@gmail.com>>

>

--0000000000008d957f05b1446c5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Sun, Oct 4, 2020, 8:25 PM Philippe Mathieu-Daud=C3=A9 &lt;<=
a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></div><=
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
2.26.2<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><span style=3D"font-family:sans-serif;font-size:12.8px">Acked-by: Ahm=
ed Karaman &lt;ahmedkhaledkaraman</span><a href=3D"mailto:pauldzim@gmail.co=
m" style=3D"text-decoration-line:none;color:rgb(66,133,244);font-family:san=
s-serif;font-size:12.8px">@gmail.com</a><span style=3D"font-family:sans-ser=
if;font-size:12.8px">&gt;</span><br></div><div dir=3D"auto"><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000008d957f05b1446c5f--

