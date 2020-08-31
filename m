Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69288C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D2D206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D2D206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrEZ-0004wD-Ay
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9X-0007D0-TM
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:47 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9W-00017a-0V
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:47 -0400
Received: by mail-ej1-f67.google.com with SMTP id q13so6921266ejo.9
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9W8NNLK/TmUATKVgycZSdsnaRkDE8aQGo8xB4Pn3WQI=;
 b=E4T0k3nknNMqMcqEcxEL+dmqqSpNYNdPgGy1JNSq8o+fpH7UK9ujUskmCS14MCq5Mg
 8++p1nPmGszJ279s5VBDC+bsGa5i5fZyB8234uHqkw2C5KqSVEXx5PSV7zbexyNVxXEz
 XMRpHsRvMMODsXeI6dCzQ2gVOu9CFpzzgV9LjxD3xSoYDZ0lifL35zVNLmU3Y1NlGyYa
 ZTmkURCBZFwbsahwmk6JJp2aZCS+2gxvcFj/jkVHQ4RHdrvDVZYSzS/+e45mtceUipIu
 8RE9zxxVdVve7v501CAmpNWQTRtiGP99QcKuFm96mNd/RYCiwENl/Yy9szxUvZDuggG6
 dCgw==
X-Gm-Message-State: AOAM532wBzhkg1dxjNZSR76a2aB4LIPK+FcpCdQORNQwseZhpyAWJg18
 /u98EdjypWSemjSVurhKrQuS4nh7Vtn5Sp0yPX0=
X-Google-Smtp-Source: ABdhPJxj/Mlz5MCddPjxP+idWFKoMC0qb9xn85E2hCad9zflUpEwPi7baXwjZvEzIZeaMfbAzkZEc/vanjp9+o0BtzE=
X-Received: by 2002:a17:906:454a:: with SMTP id
 s10mr2682321ejq.138.1598908543551; 
 Mon, 31 Aug 2020 14:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200828180243.443016-1-richard.henderson@linaro.org>
 <20200828180243.443016-2-richard.henderson@linaro.org>
In-Reply-To: <20200828180243.443016-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 19:17:13 +0200
Message-ID: <CAAdtpL6q35O3Z4cDfuStAfiXN4m42MoE9B2UK6MPyaM0iesB4w@mail.gmail.com>
Subject: Re: [PATCH 1/3] softmmu/cpus: Only set parallel_cpus for SMP
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c44b0105ae32e75d"
Received-SPF: pass client-ip=209.85.218.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c44b0105ae32e75d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 20:04, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> Do not set parallel_cpus if there is only one cpu instantiated.
> This will allow tcg to use serial code to implement atomics.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  softmmu/cpus.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index a802e899ab..e3b98065c9 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -1895,6 +1895,16 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>      if (!tcg_region_inited) {
>          tcg_region_inited =3D 1;
>          tcg_region_init();
> +        /*
> +         * If MTTCG, and we will create multiple cpus,
> +         * then we will have cpus running in parallel.
> +         */
> +        if (qemu_tcg_mttcg_enabled()) {
> +            MachineState *ms =3D MACHINE(qdev_get_machine());
> +            if (ms->smp.max_cpus > 1) {
> +                parallel_cpus =3D true;
> +            }
> +        }
>      }
>
>      if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
> @@ -1904,7 +1914,6 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>
>          if (qemu_tcg_mttcg_enabled()) {
>              /* create a thread per vCPU with TCG (MTTCG) */
> -            parallel_cpus =3D true;
>              snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
>                   cpu->cpu_index);
>
> --
> 2.25.1
>
>
>

--000000000000c44b0105ae32e75d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 20:04, Richard Henderson &lt;<a =
href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</=
a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Do not s=
et parallel_cpus if there is only one cpu instantiated.<br>
This will allow tcg to use serial code to implement atomics.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">Reviewe=
d-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.=
org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:sans-s=
erif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-family:sans=
-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><span sty=
le=3D"font-family:sans-serif;font-size:13.696px"><br></span></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0softmmu/cpus.c | 11 ++++++++++-<br>
=C2=A01 file changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/softmmu/cpus.c b/softmmu/cpus.c<br>
index a802e899ab..e3b98065c9 100644<br>
--- a/softmmu/cpus.c<br>
+++ b/softmmu/cpus.c<br>
@@ -1895,6 +1895,16 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0if (!tcg_region_inited) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_region_inited =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_region_init();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If MTTCG, and we will create multiple =
cpus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* then we will have cpus running in para=
llel.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_tcg_mttcg_enabled()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MachineState *ms =3D MACHINE(qde=
v_get_machine());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ms-&gt;smp.max_cpus &gt; 1) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parallel_cpus =3D =
true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread)=
 {<br>
@@ -1904,7 +1914,6 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qemu_tcg_mttcg_enabled()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* create a thread per vCPU=
 with TCG (MTTCG) */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parallel_cpus =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(thread_name, VCPU_=
THREAD_NAME_SIZE, &quot;CPU %d/TCG&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cpu_=
index);<br>
<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000c44b0105ae32e75d--

