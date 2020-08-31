Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CA1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA6B2083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA6B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrVd-0007PP-Ej
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrED-0004oY-1d
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrEB-0001bj-8w
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id 60so5861710qtc.9
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pCmtxGndWY1jSvNkpUW/5RRpw0F/DVmJxZUZIEWA+0w=;
 b=We2ZjqrZvBC2aUasptLNBEShrMCzzCjlknl1eVOCKjGeQ7hz/Ltr8O+FKtdbO9y2Dz
 qEsN/Ym6Jhs6fGHtHJmdrGJgfP2RFszrK0pP/oEyY9/HAhiWaDfsSxFy4u5PA3/MpIYR
 TrxadtruupQjn2++Y23LNLRxHIU/IFfu3NhsjIDzUuiiSGTqtW8q5ifZ7mZQGbqWbbU0
 gux1geLuuL9Cnvyvm/2pt34I8mfga1cv9gQhcoMeTbCkT0uc63jPW0xy6hJtspKHINE0
 0UuQxwH3l1DBA3xYYfLUsruzMOmN0mpGQD70zbsAtKlxPGCx6gjtukbN2ryza6E5rjDB
 ChIA==
X-Gm-Message-State: AOAM532WNlYZOyaliZxo1TR6cWB6SPQL+g2wEgF/Yv9HIjqOI3TDctm8
 ffXAadsxqQnOANsj495kOQIDCkZ+iG5RKEyN5Sg=
X-Google-Smtp-Source: ABdhPJzigCQzvuejF9XV3oHnOQqhQeMe+CjsI6SBO8tw2waK9flMTGis5hO1EaOCkhL3TkUxCnZHl2mq9xeIuBq8dsc=
X-Received: by 2002:aed:21a6:: with SMTP id l35mr3339526qtc.178.1598908830310; 
 Mon, 31 Aug 2020 14:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-63-richard.henderson@linaro.org>
In-Reply-To: <20200828141929.77854-63-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 23:08:14 +0200
Message-ID: <CAAdtpL5PueR0ezHJ7ATH-qD6K+8OaSGqqd4jBSy+D6+9CCaSaw@mail.gmail.com>
Subject: Re: [PATCH v2 62/76] target/microblaze: Tidy mb_cpu_dump_state
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000dbe80d05ae32f84d"
Received-SPF: pass client-ip=209.85.160.193;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qt1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:20:30
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dbe80d05ae32f84d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Le ven. 28 ao=C3=BBt 2020 16:46, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> Using lookup_symbol is quite slow; remove that.  Decode the
>

Can we add some runtime option to enable its use instead?

various bits of iflags; only show imm, btaken, btarget when
> they are relevant to iflags.  Improve formatting.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/translate.c | 67 +++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 26 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index 811c92d23b..3b63fd79e5 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1818,41 +1818,56 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int
> flags)
>  {
>      MicroBlazeCPU *cpu =3D MICROBLAZE_CPU(cs);
>      CPUMBState *env =3D &cpu->env;
> +    uint32_t iflags;
>      int i;
>
> -    if (!env) {
> -        return;
> -    }
> -
> -    qemu_fprintf(f, "IN: PC=3D%x %s\n",
> -                 env->pc, lookup_symbol(env->pc));
> -    qemu_fprintf(f, "rmsr=3D%x resr=3D%x rear=3D%" PRIx64 " "
> -                 "imm=3D%x iflags=3D%x fsr=3D%x rbtr=3D%x\n",
> -                 env->msr, env->esr, env->ear,
> -                 env->imm, env->iflags, env->fsr, env->btr);
> -    qemu_fprintf(f, "btaken=3D%d btarget=3D%x mode=3D%s(saved=3D%s) eip=
=3D%d
> ie=3D%d\n",
> -                 env->btaken, env->btarget,
> +    qemu_fprintf(f, "pc=3D0x%08x msr=3D0x%05x mode=3D%s(saved=3D%s) eip=
=3D%d
> ie=3D%d\n",
> +                 env->pc, env->msr,
>                   (env->msr & MSR_UM) ? "user" : "kernel",
>                   (env->msr & MSR_UMS) ? "user" : "kernel",
>                   (bool)(env->msr & MSR_EIP),
>                   (bool)(env->msr & MSR_IE));
> -    for (i =3D 0; i < 12; i++) {
> -        qemu_fprintf(f, "rpvr%2.2d=3D%8.8x ", i, env->pvr.regs[i]);
> -        if ((i + 1) % 4 =3D=3D 0) {
> -            qemu_fprintf(f, "\n");
> -        }
> +
> +    iflags =3D env->iflags;
> +    qemu_fprintf(f, "iflags: 0x%08x", iflags);
> +    if (iflags & IMM_FLAG) {
> +        qemu_fprintf(f, " IMM(0x%08x)", env->imm);
> +    }
> +    if (iflags & BIMM_FLAG) {
> +        qemu_fprintf(f, " BIMM");
> +    }
> +    if (iflags & D_FLAG) {
> +        qemu_fprintf(f, " D(btaken=3D%d btarget=3D0x%08x)",
> +                     env->btaken, env->btarget);
> +    }
> +    if (iflags & DRTI_FLAG) {
> +        qemu_fprintf(f, " DRTI");
> +    }
> +    if (iflags & DRTE_FLAG) {
> +        qemu_fprintf(f, " DRTE");
> +    }
> +    if (iflags & DRTB_FLAG) {
> +        qemu_fprintf(f, " DRTB");
> +    }
> +    if (iflags & ESR_ESS_FLAG) {
> +        qemu_fprintf(f, " ESR_ESS(0x%04x)", iflags & ESR_ESS_MASK);
> +    }
> +
> +    qemu_fprintf(f, "\nesr=3D0x%04x fsr=3D0x%02x btr=3D0x%08x edr=3D0x%x=
\n"
> +                 "ear=3D0x%016" PRIx64 " slr=3D0x%x shr=3D0x%x\n",
> +                 env->esr, env->fsr, env->btr, env->edr,
> +                 env->ear, env->slr, env->shr);
> +
> +    for (i =3D 0; i < 12; i++) {
> +        qemu_fprintf(f, "rpvr%-2d=3D%08x%c",
> +                     i, env->pvr.regs[i], i % 4 =3D=3D 3 ? '\n' : ' ');
>      }
>
> -    /* Registers that aren't modeled are reported as 0 */
> -    qemu_fprintf(f, "redr=3D%x rpid=3D0 rzpr=3D0 rtlbx=3D0 rtlbsx=3D0 "
> -                    "rtlblo=3D0 rtlbhi=3D0\n", env->edr);
> -    qemu_fprintf(f, "slr=3D%x shr=3D%x\n", env->slr, env->shr);
>      for (i =3D 0; i < 32; i++) {
> -        qemu_fprintf(f, "r%2.2d=3D%8.8x ", i, env->regs[i]);
> -        if ((i + 1) % 4 =3D=3D 0)
> -            qemu_fprintf(f, "\n");
> -        }
> -    qemu_fprintf(f, "\n\n");
> +        qemu_fprintf(f, "r%2.2d=3D%08x%c",
> +                     i, env->regs[i], i % 4 =3D=3D 3 ? '\n' : ' ');
> +    }
> +    qemu_fprintf(f, "\n");
>  }
>
>  void mb_tcg_init(void)
> --
> 2.25.1
>
>
>

--000000000000dbe80d05ae32f84d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Richard,=C2=A0<br><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 16:46, Rich=
ard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.h=
enderson@linaro.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Using lookup_symbol is quite slow; remove that.=C2=A0 Decode =
the<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Can we add some runtime option to enable its use instead?</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
various bits of iflags; only show imm, btaken, btarget when<br>
they are relevant to iflags.=C2=A0 Improve formatting.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br>
---<br>
=C2=A0target/microblaze/translate.c | 67 +++++++++++++++++++++-------------=
-<br>
=C2=A01 file changed, 41 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c<=
br>
index 811c92d23b..3b63fd79e5 100644<br>
--- a/target/microblaze/translate.c<br>
+++ b/target/microblaze/translate.c<br>
@@ -1818,41 +1818,56 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int f=
lags)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MicroBlazeCPU *cpu =3D MICROBLAZE_CPU(cs);<br>
=C2=A0 =C2=A0 =C2=A0CPUMBState *env =3D &amp;cpu-&gt;env;<br>
+=C2=A0 =C2=A0 uint32_t iflags;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
-=C2=A0 =C2=A0 if (!env) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 qemu_fprintf(f, &quot;IN: PC=3D%x %s\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pc, =
lookup_symbol(env-&gt;pc));<br>
-=C2=A0 =C2=A0 qemu_fprintf(f, &quot;rmsr=3D%x resr=3D%x rear=3D%&quot; PRI=
x64 &quot; &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;imm=3D=
%x iflags=3D%x fsr=3D%x rbtr=3D%x\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;msr,=
 env-&gt;esr, env-&gt;ear,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;imm,=
 env-&gt;iflags, env-&gt;fsr, env-&gt;btr);<br>
-=C2=A0 =C2=A0 qemu_fprintf(f, &quot;btaken=3D%d btarget=3D%x mode=3D%s(sav=
ed=3D%s) eip=3D%d ie=3D%d\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;btak=
en, env-&gt;btarget,<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;pc=3D0x%08x msr=3D0x%05x mode=3D%s(sav=
ed=3D%s) eip=3D%d ie=3D%d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pc, =
env-&gt;msr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (env-&gt;msr=
 &amp; MSR_UM) ? &quot;user&quot; : &quot;kernel&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (env-&gt;msr=
 &amp; MSR_UMS) ? &quot;user&quot; : &quot;kernel&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (bool)(env-&=
gt;msr &amp; MSR_EIP),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (bool)(env-&=
gt;msr &amp; MSR_IE));<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; 12; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;rpvr%2.2d=3D%8.8x &quot;=
, i, env-&gt;pvr.regs[i]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i + 1) % 4 =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 iflags =3D env-&gt;iflags;<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;iflags: 0x%08x&quot;, iflags);<br>
+=C2=A0 =C2=A0 if (iflags &amp; IMM_FLAG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; IMM(0x%08x)&quot;, env-=
&gt;imm);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (iflags &amp; BIMM_FLAG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; BIMM&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (iflags &amp; D_FLAG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; D(btaken=3D%d btarget=
=3D0x%08x)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0env-&gt;btaken, env-&gt;btarget);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (iflags &amp; DRTI_FLAG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; DRTI&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (iflags &amp; DRTE_FLAG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; DRTE&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (iflags &amp; DRTB_FLAG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; DRTB&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (iflags &amp; ESR_ESS_FLAG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; ESR_ESS(0x%04x)&quot;, =
iflags &amp; ESR_ESS_MASK);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\nesr=3D0x%04x fsr=3D0x%02x btr=3D0x%0=
8x edr=3D0x%x\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ear=3D=
0x%016&quot; PRIx64 &quot; slr=3D0x%x shr=3D0x%x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;esr,=
 env-&gt;fsr, env-&gt;btr, env-&gt;edr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;ear,=
 env-&gt;slr, env-&gt;shr);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 12; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;rpvr%-2d=3D%08x%c&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0i, env-&gt;pvr.regs[i], i % 4 =3D=3D 3 ? &#39;\n&#39; : &#39; &#39;);<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* Registers that aren&#39;t modeled are reported as 0 */<br=
>
-=C2=A0 =C2=A0 qemu_fprintf(f, &quot;redr=3D%x rpid=3D0 rzpr=3D0 rtlbx=3D0 =
rtlbsx=3D0 &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;rtlblo=3D0 rtlbhi=3D0\n&quot;, env-&gt;edr);<br>
-=C2=A0 =C2=A0 qemu_fprintf(f, &quot;slr=3D%x shr=3D%x\n&quot;, env-&gt;slr=
, env-&gt;shr);<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;r%2.2d=3D%8.8x &quot;, i=
, env-&gt;regs[i]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i + 1) % 4 =3D=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot;r%2.2d=3D%08x%c&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0i, env-&gt;regs[i], i % 4 =3D=3D 3 ? &#39;\n&#39; : &#39; &#39;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 qemu_fprintf(f, &quot;\n&quot;);<br>
=C2=A0}<br>
<br>
=C2=A0void mb_tcg_init(void)<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000dbe80d05ae32f84d--

