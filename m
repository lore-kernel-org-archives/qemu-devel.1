Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F68C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E992076A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKS0n7Qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E992076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNgYP-0000St-Fw
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 14:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kNgTA-0004AU-RX
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:04:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kNgT4-00066i-G1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:04:48 -0400
Received: by mail-wm1-x342.google.com with SMTP id t17so427669wmi.4
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 11:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=IO0i6mgnG+29fMwbBaHwXiTUvnXwVlZR+MvZslEKGfE=;
 b=iKS0n7QsD+iu0beYXiut6pHTHkBmOEzRO9Smq3vnVVOiHziXIRfxWTiitlSV7sHpge
 otjfbl0n19OBeERy5DzDNRjcW220oxQ/DDF6M465oFj4DyT6P/0kOxiyurhKT2kUckXk
 uM+y4dlyoeIsq4lOCFsX9kKw9y8OYfSvrFY6E55GfBJ+9K0mRX6KaMT0nF+B8wkyIQx/
 Yu2S8yHYyrlHrXTxUqzLzlWTFpWa5VAvwyFzEBRb1tBVHd5gVmOd9we4gH9xPi7VJRo9
 QLlyiNc4QShOmmpBmo4Onqp3eBeFfnIJGBr+YrGYXKIVHNek1lVGtKpe6Bs7YD0gQNFS
 3o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=IO0i6mgnG+29fMwbBaHwXiTUvnXwVlZR+MvZslEKGfE=;
 b=jS2SL/JCnigLe/PCi4A/eF116TKTpjUdBZgH0Iu/HMJxxR1sNVqv5u7d0e8bNLA15M
 6pi4bXe0kZvhEYazIkL3Xgth214/lJAF+xJaxi2jqSO7ohMH8XB4fx5VtGT29NQYkw+Q
 NGSds44xjljeaUvKfn+lTp5Ydj1kSgIpRsCLsFw3VZLE/8ThXsCO7PXiFSiEx4BBZpZM
 QuTdzhexHQuG7DATOqHxmEV1ORtuTG+jrW3J2fRhBDv9+z1Yg5BkRnyftQC6WcbFuwNP
 01tvQMJmKwP7jSlJZx3KZI/CieLOFIApelczz6ypVkPLCwdSar418RrrJYtJLlfl1iMR
 xm7A==
X-Gm-Message-State: AOAM532lNN6ZoTtcxZVSf5FKVHuiIaiN/vvO431fT2X7/qLuFevhDYnO
 2pv5ZM6XGXSDynpjMhLuqNpYnrNZD+1kXim+FM0=
X-Google-Smtp-Source: ABdhPJzLRLa/KEIs2PtA7OPbFo9LRvIieE8x3F/04oCX6pumzWKBs7bxJ4he6K5jz0e1sCS474JTkFBZZm0qnObv7RI=
X-Received: by 2002:a7b:c958:: with SMTP id i24mr4531932wml.50.1601489078664; 
 Wed, 30 Sep 2020 11:04:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7504:0:0:0:0:0 with HTTP; Wed, 30 Sep 2020 11:04:38
 -0700 (PDT)
In-Reply-To: <20200928171539.788309-3-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-3-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 30 Sep 2020 20:04:38 +0200
Message-ID: <CAHiYmc7RMHycfhzkLD6Q=aXast3cdO6qcjOQQordzsr4dQuFzg@mail.gmail.com>
Subject: Re: [PATCH 02/16] target/mips: Move cpu_mips_get_random() with CP0
 helpers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000a5445405b08bbbbf"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a5445405b08bbbbf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, September 28, 2020, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> The get_random() helper uses the CP0_Wired register, which is
> unrelated to the CP0_Count register use as timer.
> Commit e16fe40c872 ("Move the MIPS CPU timer in a separate file")
> incorrectly moved this get_random() helper with timer specific
> code. Move it back to generic CP0 helpers.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---


Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>


>  target/mips/internal.h   |  2 +-
>  target/mips/cp0_helper.c | 25 +++++++++++++++++++++++++
>  target/mips/cp0_timer.c  | 25 -------------------------
>  3 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 7f159a9230c..087cabaa6d4 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -144,6 +144,7 @@ void r4k_helper_tlbr(CPUMIPSState *env);
>  void r4k_helper_tlbinv(CPUMIPSState *env);
>  void r4k_helper_tlbinvf(CPUMIPSState *env);
>  void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
> +uint32_t cpu_mips_get_random(CPUMIPSState *env);
>
>  void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>                                      vaddr addr, unsigned size,
> @@ -209,7 +210,6 @@ void cpu_state_reset(CPUMIPSState *s);
>  void cpu_mips_realize_env(CPUMIPSState *env);
>
>  /* cp0_timer.c */
> -uint32_t cpu_mips_get_random(CPUMIPSState *env);
>  uint32_t cpu_mips_get_count(CPUMIPSState *env);
>  void cpu_mips_store_count(CPUMIPSState *env, uint32_t value);
>  void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value);
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index de64add038b..12143ac55b9 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -203,6 +203,31 @@ static void sync_c0_entryhi(CPUMIPSState *cpu, int t=
c)
>      *tcst |=3D asid;
>  }
>
> +/* XXX: do not use a global */
> +uint32_t cpu_mips_get_random(CPUMIPSState *env)
> +{
> +    static uint32_t seed =3D 1;
> +    static uint32_t prev_idx;
> +    uint32_t idx;
> +    uint32_t nb_rand_tlb =3D env->tlb->nb_tlb - env->CP0_Wired;
> +
> +    if (nb_rand_tlb =3D=3D 1) {
> +        return env->tlb->nb_tlb - 1;
> +    }
> +
> +    /* Don't return same value twice, so get another value */
> +    do {
> +        /*
> +         * Use a simple algorithm of Linear Congruential Generator
> +         * from ISO/IEC 9899 standard.
> +         */
> +        seed =3D 1103515245 * seed + 12345;
> +        idx =3D (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
> +    } while (idx =3D=3D prev_idx);
> +    prev_idx =3D idx;
> +    return idx;
> +}
> +
>  /* CP0 helpers */
>  target_ulong helper_mfc0_mvpcontrol(CPUMIPSState *env)
>  {
> diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
> index bd7efb152dd..9c38e9da1c8 100644
> --- a/target/mips/cp0_timer.c
> +++ b/target/mips/cp0_timer.c
> @@ -29,31 +29,6 @@
>
>  #define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
>
> -/* XXX: do not use a global */
> -uint32_t cpu_mips_get_random(CPUMIPSState *env)
> -{
> -    static uint32_t seed =3D 1;
> -    static uint32_t prev_idx =3D 0;
> -    uint32_t idx;
> -    uint32_t nb_rand_tlb =3D env->tlb->nb_tlb - env->CP0_Wired;
> -
> -    if (nb_rand_tlb =3D=3D 1) {
> -        return env->tlb->nb_tlb - 1;
> -    }
> -
> -    /* Don't return same value twice, so get another value */
> -    do {
> -        /*
> -         * Use a simple algorithm of Linear Congruential Generator
> -         * from ISO/IEC 9899 standard.
> -         */
> -        seed =3D 1103515245 * seed + 12345;
> -        idx =3D (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
> -    } while (idx =3D=3D prev_idx);
> -    prev_idx =3D idx;
> -    return idx;
> -}
> -
>  /* MIPS R4K timer */
>  static void cpu_mips_timer_update(CPUMIPSState *env)
>  {
> --
> 2.26.2
>
>

--000000000000a5445405b08bbbbf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, September 28, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">The get_random() helper uses the CP0_Wired register, w=
hich is<br>
unrelated to the CP0_Count register use as timer.<br>
Commit e16fe40c872 (&quot;Move the MIPS CPU timer in a separate file&quot;)=
<br>
incorrectly moved this get_random() helper with timer specific<br>
code. Move it back to generic CP0 helpers.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
---</blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);font=
-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovic=
 &lt;</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_b=
lank" style=3D"font-size:14px;line-height:22.1200008392334px">aleksandar.qe=
mu.devel@gmail.c<wbr>om</a><span style=3D"color:rgb(34,34,34);font-size:14p=
x;line-height:22.1200008392334px">&gt;</span><br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
=C2=A0target/mips/internal.h=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0target/mips/cp0_helper.c | 25 +++++++++++++++++++++++++<br>
=C2=A0target/mips/cp0_timer.c=C2=A0 | 25 -------------------------<br>
=C2=A03 files changed, 26 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/target/mips/internal.h b/target/mips/internal.h<br>
index 7f159a9230c..087cabaa6d4 100644<br>
--- a/target/mips/internal.h<br>
+++ b/target/mips/internal.h<br>
@@ -144,6 +144,7 @@ void r4k_helper_tlbr(CPUMIPSState *env);<br>
=C2=A0void r4k_helper_tlbinv(CPUMIPSState *env);<br>
=C2=A0void r4k_helper_tlbinvf(<wbr>CPUMIPSState *env);<br>
=C2=A0void r4k_invalidate_tlb(<wbr>CPUMIPSState *env, int idx, int use_extr=
a);<br>
+uint32_t cpu_mips_get_random(<wbr>CPUMIPSState *env);<br>
<br>
=C2=A0void mips_cpu_do_transaction_<wbr>failed(CPUState *cs, hwaddr physadd=
r,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vaddr addr, unsi=
gned size,<br>
@@ -209,7 +210,6 @@ void cpu_state_reset(CPUMIPSState *s);<br>
=C2=A0void cpu_mips_realize_env(<wbr>CPUMIPSState *env);<br>
<br>
=C2=A0/* cp0_timer.c */<br>
-uint32_t cpu_mips_get_random(<wbr>CPUMIPSState *env);<br>
=C2=A0uint32_t cpu_mips_get_count(<wbr>CPUMIPSState *env);<br>
=C2=A0void cpu_mips_store_count(<wbr>CPUMIPSState *env, uint32_t value);<br=
>
=C2=A0void cpu_mips_store_compare(<wbr>CPUMIPSState *env, uint32_t value);<=
br>
diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c<br>
index de64add038b..12143ac55b9 100644<br>
--- a/target/mips/cp0_helper.c<br>
+++ b/target/mips/cp0_helper.c<br>
@@ -203,6 +203,31 @@ static void sync_c0_entryhi(CPUMIPSState *cpu, int tc)=
<br>
=C2=A0 =C2=A0 =C2=A0*tcst |=3D asid;<br>
=C2=A0}<br>
<br>
+/* XXX: do not use a global */<br>
+uint32_t cpu_mips_get_random(<wbr>CPUMIPSState *env)<br>
+{<br>
+=C2=A0 =C2=A0 static uint32_t seed =3D 1;<br>
+=C2=A0 =C2=A0 static uint32_t prev_idx;<br>
+=C2=A0 =C2=A0 uint32_t idx;<br>
+=C2=A0 =C2=A0 uint32_t nb_rand_tlb =3D env-&gt;tlb-&gt;nb_tlb - env-&gt;CP=
0_Wired;<br>
+<br>
+=C2=A0 =C2=A0 if (nb_rand_tlb =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return env-&gt;tlb-&gt;nb_tlb - 1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Don&#39;t return same value twice, so get another value *=
/<br>
+=C2=A0 =C2=A0 do {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Use a simple algorithm of Linear Congr=
uential Generator<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* from ISO/IEC 9899 standard.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 seed =3D 1103515245 * seed + 12345;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 idx =3D (seed &gt;&gt; 16) % nb_rand_tlb + env=
-&gt;CP0_Wired;<br>
+=C2=A0 =C2=A0 } while (idx =3D=3D prev_idx);<br>
+=C2=A0 =C2=A0 prev_idx =3D idx;<br>
+=C2=A0 =C2=A0 return idx;<br>
+}<br>
+<br>
=C2=A0/* CP0 helpers */<br>
=C2=A0target_ulong helper_mfc0_mvpcontrol(<wbr>CPUMIPSState *env)<br>
=C2=A0{<br>
diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c<br>
index bd7efb152dd..9c38e9da1c8 100644<br>
--- a/target/mips/cp0_timer.c<br>
+++ b/target/mips/cp0_timer.c<br>
@@ -29,31 +29,6 @@<br>
<br>
=C2=A0#define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */<br>
<br>
-/* XXX: do not use a global */<br>
-uint32_t cpu_mips_get_random(<wbr>CPUMIPSState *env)<br>
-{<br>
-=C2=A0 =C2=A0 static uint32_t seed =3D 1;<br>
-=C2=A0 =C2=A0 static uint32_t prev_idx =3D 0;<br>
-=C2=A0 =C2=A0 uint32_t idx;<br>
-=C2=A0 =C2=A0 uint32_t nb_rand_tlb =3D env-&gt;tlb-&gt;nb_tlb - env-&gt;CP=
0_Wired;<br>
-<br>
-=C2=A0 =C2=A0 if (nb_rand_tlb =3D=3D 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return env-&gt;tlb-&gt;nb_tlb - 1;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /* Don&#39;t return same value twice, so get another value *=
/<br>
-=C2=A0 =C2=A0 do {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Use a simple algorithm of Linear Congr=
uential Generator<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* from ISO/IEC 9899 standard.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 seed =3D 1103515245 * seed + 12345;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 idx =3D (seed &gt;&gt; 16) % nb_rand_tlb + env=
-&gt;CP0_Wired;<br>
-=C2=A0 =C2=A0 } while (idx =3D=3D prev_idx);<br>
-=C2=A0 =C2=A0 prev_idx =3D idx;<br>
-=C2=A0 =C2=A0 return idx;<br>
-}<br>
-<br>
=C2=A0/* MIPS R4K timer */<br>
=C2=A0static void cpu_mips_timer_update(<wbr>CPUMIPSState *env)<br>
=C2=A0{<br>
-- <br>
2.26.2<br>
<br>
</blockquote>

--000000000000a5445405b08bbbbf--

