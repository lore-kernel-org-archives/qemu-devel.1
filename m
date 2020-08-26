Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616F3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3571F2087D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3571F2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArrS-00020W-Bp
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kArqn-0001Re-As; Wed, 26 Aug 2020 05:36:13 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:36839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kArql-0007zu-CR; Wed, 26 Aug 2020 05:36:12 -0400
Received: by mail-ej1-f65.google.com with SMTP id l2so1935395eji.3;
 Wed, 26 Aug 2020 02:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2/q5de0KwxEsVLf+vB5ZV1S2o31SGrIX59NRPZ6CivY=;
 b=HQ/hm8MxZz6Uz2xhma4D5Ax46nRMJUWzBoTSG0dG40AvRXtyC0DGu3oCLIcjG5lpzC
 SCJqAbSb8ddb5LLEkaj+1Wlq/tR0iq3MV8mVTbs40IGYuQ00GvdLBAGi5GiMoO/asWTm
 gZASVPjPAiwopL/gRZLw8A+NvqHa7eSw0qwZ+G1aCMR4ivreYOyw1LaRy617Sct3DTfC
 10QgQIXqfH/NyJUP6/c5U/z0xFd0OfLokMC79zDoOztZ+/MaXB/aPtX+jhDbNQ4UC2OX
 5QrnJJQBGOfZQUQ0KSoZa7O+Jfg4jHl+jCl6KWvLt+82iiQMh0nk9AVTeEVvTdN6ucFM
 lQ6A==
X-Gm-Message-State: AOAM531s23ZlBqE8lWG0xYLzC6Mg1+pyGdSgUpv2FFnDmTgRLUtph2U5
 N/cFPkoJPLUizuPqvg1T/O0/3wYsbt2HXYNH1fs=
X-Google-Smtp-Source: ABdhPJzO8n7lX2zEcQ45woa6HJ0PNDbUEjIQ2B4pJ6TS/HlasRxMIn5BzK03y7Ird04H0yRCQUABNm/ZUWixr3e+TOE=
X-Received: by 2002:a17:906:640c:: with SMTP id
 d12mr14598157ejm.388.1598434569310; 
 Wed, 26 Aug 2020 02:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200825160847.18091-1-peter.maydell@linaro.org>
In-Reply-To: <20200825160847.18091-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Aug 2020 11:35:57 +0200
Message-ID: <CAAdtpL709BVOXDbhDRVqgueveVeT0c0dv=weZDaLf84xGkz6dQ@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/armv7m_systick: assert that board code set
 system_clock_scale
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b3568805adc48cff"
Received-SPF: pass client-ip=209.85.218.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 05:36:09
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b3568805adc48cff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 25 ao=C3=BBt 2020 18:09, Peter Maydell <peter.maydell@linaro.org> a
=C3=A9crit :

> It is the responsibility of board code for an armv7m system to set
> system_clock_scale appropriately for the CPU speed of the core.
> If it forgets to do this, then QEMU will hang if the guest tries
> to use the systick timer in the "tick at the CPU clock frequency" mode.
>
> We forgot that in a couple of our boards (see commits ce4f70e81ed23c93f,
> e7e5a9595ab1136). Add an assertion in the systick reset method so
> we don't let any new boards in with the same bug.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>


Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
> In the longer term we should make this a clocktree input and
> plumb it through the armv7m container and so on, but for the
> moment this assert() improves the current situation.
> ---
>  hw/timer/armv7m_systick.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
> index 74c58bcf245..a8cec7eb56b 100644
> --- a/hw/timer/armv7m_systick.c
> +++ b/hw/timer/armv7m_systick.c
> @@ -202,6 +202,14 @@ static void systick_reset(DeviceState *dev)
>  {
>      SysTickState *s =3D SYSTICK(dev);
>
> +    /*
> +     * Forgetting to set system_clock_scale is always a board code
> +     * bug. We can't check this earlier because for some boards
> +     * (like stellaris) it is not yet configured at the point where
> +     * the systick device is realized.
> +     */
> +    assert(system_clock_scale !=3D 0);
> +
>      s->control =3D 0;
>      s->reload =3D 0;
>      s->tick =3D 0;
> --
> 2.20.1
>
>
>

--000000000000b3568805adc48cff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le mar. 25 ao=C3=BBt 2020 18:09, Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; a =C3=A9c=
rit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">It is the responsibility=
 of board code for an armv7m system to set<br>
system_clock_scale appropriately for the CPU speed of the core.<br>
If it forgets to do this, then QEMU will hang if the guest tries<br>
to use the systick timer in the &quot;tick at the CPU clock frequency&quot;=
 mode.<br>
<br>
We forgot that in a couple of our boards (see commits ce4f70e81ed23c93f,<br=
>
e7e5a9595ab1136). Add an assertion in the systick reset method so<br>
we don&#39;t let any new boards in with the same bug.<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br =
style=3D"font-family:sans-serif;font-size:13.696px"><span style=3D"font-fam=
ily:sans-serif;font-size:13.696px">Reviewed-by: Philippe Mathieu-Daud=C3=A9=
 &lt;</span><a href=3D"mailto:f4bug@amsat.org" style=3D"text-decoration:non=
e;color:rgb(66,133,244);font-family:sans-serif;font-size:13.696px">f4bug@am=
sat.org</a><span style=3D"font-family:sans-serif;font-size:13.696px">&gt;</=
span><br></div><div dir=3D"auto"><span style=3D"font-family:sans-serif;font=
-size:13.696px"><br></span></div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
---<br>
In the longer term we should make this a clocktree input and<br>
plumb it through the armv7m container and so on, but for the<br>
moment this assert() improves the current situation.<br>
---<br>
=C2=A0hw/timer/armv7m_systick.c | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c<br>
index 74c58bcf245..a8cec7eb56b 100644<br>
--- a/hw/timer/armv7m_systick.c<br>
+++ b/hw/timer/armv7m_systick.c<br>
@@ -202,6 +202,14 @@ static void systick_reset(DeviceState *dev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SysTickState *s =3D SYSTICK(dev);<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Forgetting to set system_clock_scale is always a boa=
rd code<br>
+=C2=A0 =C2=A0 =C2=A0* bug. We can&#39;t check this earlier because for som=
e boards<br>
+=C2=A0 =C2=A0 =C2=A0* (like stellaris) it is not yet configured at the poi=
nt where<br>
+=C2=A0 =C2=A0 =C2=A0* the systick device is realized.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 assert(system_clock_scale !=3D 0);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;control =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;reload =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;tick =3D 0;<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000b3568805adc48cff--

