Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82D1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E87E20872
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E87E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTL2W-0006wi-14
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTL1l-0006VW-Cj
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:23:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTL1j-0000AR-SO
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:23:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id l24so1394691edj.8
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 01:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jbT90Zqzdpwm3mrnrSOYC1zNBorESeBlWn8+Bp+WRmo=;
 b=AOUZTJvQ9iiWxzkEmI0XNiRl3/6MxzySbPPcHVLFkyBqHs6Rb5HTPR6ESwRP0+nkhb
 wMT9tgaP/2MaKaDEeebo+cGLcj5xmOTMY2R1+Cactt0RevSCvP1n+4J50I03D7OY8XcT
 gJ/ivl689xXqnEeEuBHgIcVt/2tINzDTpLwy8InPr1n3ZK87BIgz+bMVyncWA1pA1RA0
 P3EExIvqz3aOstiWDJWFS6CAvXH2QLWmZBzvFmzTv08JEL4hH13POafjDg/VmQcJbeL9
 /Q6ojj0/2e+dHvEKBCLw2rJ8/jZIIdr8kQ7AJqtpE5PoVcreyiyEzB8Mk45J3aQnKErF
 Eicw==
X-Gm-Message-State: AOAM531XtPi7iC5E+RHbhBlkU0oCG6Aud3xCO529PhpmU+p1kInsXv1u
 tn7FYr6cJ83aCytRnrzak2/9O9hPQx7HXGg3xPc=
X-Google-Smtp-Source: ABdhPJzFvXbDogdpiqEsRx0OSmgFAwJpm3c7LmB7aOGU0ommrJMCk6yHmcJyM6Hv7YQVjFFaoKtAh0WlBnlPJswHvxk=
X-Received: by 2002:aa7:d64e:: with SMTP id v14mr2699384edr.66.1602836630467; 
 Fri, 16 Oct 2020 01:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201016080032.13914-1-cfontana@suse.de>
In-Reply-To: <20201016080032.13914-1-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Oct 2020 10:23:31 +0200
Message-ID: <CAAdtpL48PZTjMHiZe8bHzf06GEYynmXvcuyHM8TUb6ekGGd5kg@mail.gmail.com>
Subject: Re: [PATCH] hax: unbreak accelerator cpu code after cpus.c split
To: Claudio Fontana <cfontana@suse.de>
Content-Type: multipart/alternative; boundary="000000000000fdf8c605b1c57b77"
Received-SPF: pass client-ip=209.85.208.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 04:23:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, haxm-team@intel.com,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fdf8c605b1c57b77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2020 10:03, Claudio Fontana <cfontana@suse.de> a =C3=A9crit=
 :

> during my split of cpus.c, code line
> "current_cpu =3D cpu"
> was removed by mistake, causing hax to break.
>
> This commit fixes the situation restoring it.
>
> Reported-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> Fixes: e92558e4bf8059ce4f0b310afe218802b72766bc
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  target/i386/hax-cpus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/i386/hax-cpus.c b/target/i386/hax-cpus.c
> index 99770e590c..f72c85bd49 100644
> --- a/target/i386/hax-cpus.c
> +++ b/target/i386/hax-cpus.c
> @@ -38,6 +38,7 @@ static void *hax_cpu_thread_fn(void *arg)
>      qemu_thread_get_self(cpu->thread);
>
>      cpu->thread_id =3D qemu_get_thread_id();
> +    current_cpu =3D cpu;
>      hax_init_vcpu(cpu);
>      cpu_thread_signal_created(cpu);
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
> --
> 2.26.2
>
>
>

--000000000000fdf8c605b1c57b77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le ven. 16 oct. 2020 10:03, Claudio Fontana &lt;<a href=3D"mai=
lto:cfontana@suse.de">cfontana@suse.de</a>&gt; a =C3=A9crit=C2=A0:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">during my split of cpus.c, code line<br>
&quot;current_cpu =3D cpu&quot;<br>
was removed by mistake, causing hax to break.<br>
<br>
This commit fixes the situation restoring it.<br>
<br>
Reported-by: Volker R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de"=
 target=3D"_blank" rel=3D"noreferrer">vr_qemu@t-online.de</a>&gt;<br>
Fixes: e92558e4bf8059ce4f0b310afe218802b72766bc<br>
Signed-off-by: Claudio Fontana &lt;<a href=3D"mailto:cfontana@suse.de" targ=
et=3D"_blank" rel=3D"noreferrer">cfontana@suse.de</a>&gt;<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt;<br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0target/i386/hax-cpus.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/target/i386/hax-cpus.c b/target/i386/hax-cpus.c<br>
index 99770e590c..f72c85bd49 100644<br>
--- a/target/i386/hax-cpus.c<br>
+++ b/target/i386/hax-cpus.c<br>
@@ -38,6 +38,7 @@ static void *hax_cpu_thread_fn(void *arg)<br>
=C2=A0 =C2=A0 =C2=A0qemu_thread_get_self(cpu-&gt;thread);<br>
<br>
=C2=A0 =C2=A0 =C2=A0cpu-&gt;thread_id =3D qemu_get_thread_id();<br>
+=C2=A0 =C2=A0 current_cpu =3D cpu;<br>
=C2=A0 =C2=A0 =C2=A0hax_init_vcpu(cpu);<br>
=C2=A0 =C2=A0 =C2=A0cpu_thread_signal_created(cpu);<br>
=C2=A0 =C2=A0 =C2=A0qemu_guest_random_seed_thread_part2(cpu-&gt;random_seed=
);<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000fdf8c605b1c57b77--

