Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5115FC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AFE2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkN0vcxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AFE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih037-00021h-06
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 18:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ih02C-000141-Li
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ih02B-0000j6-9B
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:44:16 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ih028-0000hz-5W; Mon, 16 Dec 2019 18:44:12 -0500
Received: by mail-il1-x144.google.com with SMTP id x5so3910375ila.6;
 Mon, 16 Dec 2019 15:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EZ/NWv3PxRZMK4GHKDW0UhZhqP3Ch9MknrvNeXjNmbU=;
 b=JkN0vcxLG4pScgBg+KCMmRrOUv2Q9njz8ci63ZMTHLCktAFlrE9h97ME8AQ/EcJrt2
 HHjtHDzBeLUUXyI7+WbrOkDSpXN4XVftNA5Puyr4PNnL12wTPg3BJmqp+gc9R3AIW5Z4
 vSUaZPY5btkx+S0UiGpds/+w2i6V/OWjiZfPg0BIkGfpVFtr06iuWhCfz19PrKjl/sWp
 HP/60WlxpJxUN8DGxVJEVeRXWTBnBzic0fMjtmMIjNdi50vM/nhO2AWbd+4C8r14ZH1C
 C2+3V8dCOV9Jwm5vyxnEsYCxjfsRsE7giWZQTxj2zwMqVOlm9kngdbOqdbXlNax9QROt
 7+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EZ/NWv3PxRZMK4GHKDW0UhZhqP3Ch9MknrvNeXjNmbU=;
 b=RgXHYjD9Uimj5Sz0mmr3bpkjM+gmMVZTryvSLDQ7yPwycxmroQqJrLPPOMC7rV8Oej
 +2gINhz/2FNHRLvp/t7S+LopRhZMrj7cJTLI4uarlJm55zbyWWH0T4+CRl6/hf2CqxgM
 ZjgfDYmMFiy77Tz6fItHIqPVkKdUPS4dbTF6W+cdG8W09Pt87W7VCTTn2JET+Tnwhwp8
 w/fS46LODtKy/ZEtDZQ0O+ZTipO6/SAISJU+tNRPpPas/5Z1+9cmaJ3HNp8pveZcZMq7
 5zwE0UxldOiFHiKjqJ1Lc57NaKZmPo6dj+hi30MIBckbQF9Q6CuvryskNwfqOieanHgb
 XuqA==
X-Gm-Message-State: APjAAAXeeCZs8CVFaqXoRy80URb7Q4sCpufShmb09Y+Nter94O8RdfbX
 GDlFvHCe9Y4fT3amOleGpAB7O+8u2rKpdxGmNQI=
X-Google-Smtp-Source: APXvYqwZk1jjYR5ZZvZBJsfPIAWM/xhvq4L0OgWekTThJiZnCRgKf/FUiW0M+woH9EQ099t409vWK7WOLLRANml3Oow=
X-Received: by 2002:a92:5a45:: with SMTP id o66mr13929682ilb.67.1576539851325; 
 Mon, 16 Dec 2019 15:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <20191216233519.29030-7-nieklinnenbank@gmail.com>
In-Reply-To: <20191216233519.29030-7-nieklinnenbank@gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 17 Dec 2019 00:44:00 +0100
Message-ID: <CAPan3WpW1Q3zpnqgk=MWRWe99=MQ4XoW2kw8L3tioFxfEBXd+Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] arm/arm-powerctl: rebuild hflags after setting
 CP15 bits in arm_set_cpu_on()
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d007770599dac93a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d007770599dac93a
Content-Type: text/plain; charset="UTF-8"

Hello Peter,

In the previous version of this patch series I included the fix for setting
CP10,CP11 bits
in arm_set_cpu_on(), which is now in master (0c7f8c43daf65560). While that
worked, I did not
realize that setting those bits require rebuilding the flags. Philippe
reported this [1] initially,
later on during review we discussed [2] and attempted to correct it [3].

Could you please have a short look at this? Right now I don't see anymore
issues, but I'm just not very familiar with this area of the code.

Regards,
Niek

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01920.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg02784.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg02785.html


On Tue, Dec 17, 2019 at 12:36 AM Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

> After setting CP15 bits in arm_set_cpu_on() the cached hflags must
> be rebuild to reflect the changed processor state. Without rebuilding,
> the cached hflags would be inconsistent until the next call to
> arm_rebuild_hflags(). When QEMU is compiled with debugging enabled
> (--enable-debug), this problem is captured shortly after the first
> call to arm_set_cpu_on() for CPUs running in ARM 32-bit non-secure mode:
>
>   qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state:
>   Assertion `flags == rebuild_hflags_internal(env)' failed.
>   Aborted (core dumped)
>
> Fixes: 0c7f8c43daf65
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  target/arm/arm-powerctl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index b064513d44..b75f813b40 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -127,6 +127,9 @@ static void arm_set_cpu_on_async_work(CPUState
> *target_cpu_state,
>          target_cpu->env.regs[0] = info->context_id;
>      }
>
> +    /* CP15 update requires rebuilding hflags */
> +    arm_rebuild_hflags(&target_cpu->env);
> +
>      /* Start the new CPU at the requested address */
>      cpu_set_pc(target_cpu_state, info->entry);
>
> --
> 2.17.1
>
>

-- 
Niek Linnenbank

--000000000000d007770599dac93a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Peter,</div><div><br></div><div>In the previous=
 version of this patch series I included the fix for setting CP10,CP11 bits=
</div><div>in arm_set_cpu_on(), which is now in master (0c7f8c43daf65560). =
While that worked, I did not</div><div>realize that setting those bits requ=
ire rebuilding the flags. Philippe reported this [1] initially,</div><div>l=
ater on during review we discussed [2] and attempted to correct it [3].</di=
v><div><br></div><div>Could you please have a short look at this? Right now=
 I don&#39;t see anymore</div><div>issues, but I&#39;m just not very famili=
ar with this area of the code. <br></div><div><br></div><div>Regards,</div>=
<div>Niek<br></div><div><span style=3D"font-family:arial,sans-serif"><br></=
span></div><div><pre><span style=3D"font-family:arial,sans-serif">[1] <a hr=
ef=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01920.html">=
https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01920.html</a>
[2] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg027=
84.html">https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg02784.htm=
l</a>
[3] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg027=
85.html">https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg02785.htm=
l</a></span></pre><span style=3D"font-family:arial,sans-serif"></span></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Dec 17, 2019 at 12:36 AM Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com">nieklinnenbank@gmail.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">After setting CP15 bits in arm_set=
_cpu_on() the cached hflags must<br>
be rebuild to reflect the changed processor state. Without rebuilding,<br>
the cached hflags would be inconsistent until the next call to<br>
arm_rebuild_hflags(). When QEMU is compiled with debugging enabled<br>
(--enable-debug), this problem is captured shortly after the first<br>
call to arm_set_cpu_on() for CPUs running in ARM 32-bit non-secure mode:<br=
>
<br>
=C2=A0 qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state:<br=
>
=C2=A0 Assertion `flags =3D=3D rebuild_hflags_internal(env)&#39; failed.<br=
>
=C2=A0 Aborted (core dumped)<br>
<br>
Fixes: 0c7f8c43daf65<br>
Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/arm/arm-powerctl.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c<br>
index b064513d44..b75f813b40 100644<br>
--- a/target/arm/arm-powerctl.c<br>
+++ b/target/arm/arm-powerctl.c<br>
@@ -127,6 +127,9 @@ static void arm_set_cpu_on_async_work(CPUState *target_=
cpu_state,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_cpu-&gt;env.regs[0] =3D info-&gt;c=
ontext_id;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /* CP15 update requires rebuilding hflags */<br>
+=C2=A0 =C2=A0 arm_rebuild_hflags(&amp;target_cpu-&gt;env);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Start the new CPU at the requested address */<br>
=C2=A0 =C2=A0 =C2=A0cpu_set_pc(target_cpu_state, info-&gt;entry);<br>
<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000d007770599dac93a--

