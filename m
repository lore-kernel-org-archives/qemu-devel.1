Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4CF221E3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfa3dhOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4CF221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3kmW-0002I9-Jm
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 14:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1k3klU-0000yt-5e
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:37:20 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1k3klS-0001um-0f
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:37:19 -0400
Received: by mail-qt1-x843.google.com with SMTP id h21so30723546qtp.11
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L1le5HsdRi7cM68Z6GHVYdzjL/kotlE6jAt60dVyjuI=;
 b=dfa3dhOMnMH1L5IVj2oy8BSuk3NX9wXEbwNHIbY9Z4K16uvpGEeP3EdEXHgjPEqPNE
 s0bm7z11uwUztgIqpUrag3ntcYBU0EG59RFuQn/vLAUZX3+aZiVos4CGeU+16+UZa/WM
 SVuyNuZ0zx1MgUo63NCTrMXJInsQaNsmKP1vBLdU4RG3jgWeEKF1VVswVxAq5Q6g+jLE
 mc5b/5HT5A4Oz7fTtH8yL6EV4lvJblBGpNS6LAFx0XUJZsCZz9pBU8l8lcJtHrXbgT8o
 qwzEZn9TCoxfuQEYKz+uN6/CZfb4H3KE/n6R780IA25rJwJDvX7yX/mn6WncpjEnJ8yk
 H//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L1le5HsdRi7cM68Z6GHVYdzjL/kotlE6jAt60dVyjuI=;
 b=M7rOpbNXzSVMZEjx2sjKzQaRtEw3CpTQyDZCUukTVwWUR+QvS3V4I6Mrp5m5nABx77
 /S33syzkK5qZ+iFoo+hG8K++pevOlN3KdjrNuRNpCqe+33DHum4vktc92h7NcTLbiWJb
 gUrMbYCG4f3bNy0Z8qVEiT1KfZxuManr3ZLIYfbC5Tud6v6MpOH5V9YBK/PufLSevCVd
 xl6+yasVD9rpSDxdgd9lShyHo6r8TwiS23bQki2TuAxPjNAIhJGwZ9LdQ2VnoFBeU1Ny
 gcH/aAT7DEQTEwEIPe8yDIadolWH1szbmaiDA3+EV5UK7AW9wNiwwwpNf+T5KMval0TB
 yibg==
X-Gm-Message-State: AOAM531Wnvz+sr7OTPhApA00AZNRs6MjKYl2OQ1Lz1wZku1lKoeJiSaz
 4NZu784t52KDNs7NJ9PdH6Tlt9GjfXCmsFEIfIE=
X-Google-Smtp-Source: ABdhPJz9156LU2nIWS349u96bnjI6JM7uG6WZc/+pQC1TFVffYNeC0w68bQLtsyrteNsxWuj7ZMexDGgk8brZ8q43ic=
X-Received: by 2002:ac8:4514:: with SMTP id q20mr10656509qtn.122.1596739035222; 
 Thu, 06 Aug 2020 11:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-5-robert.foley@linaro.org>
In-Reply-To: <20200805181303.7822-5-robert.foley@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 6 Aug 2020 21:36:37 +0300
Message-ID: <CAK4993h0ieEuV3wimiy1HRjcS1nYkHAQ-qYmiEyEp6=2aBCr0g@mail.gmail.com>
Subject: Re: [PATCH v1 04/21] target/avr: add BQL to do_interrupt and
 cpu_exec_interrupt
To: Robert Foley <robert.foley@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fe563105ac39c680"
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=mrolnik@gmail.com; helo=mail-qt1-x843.google.com
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, cota@braap.org,
 peter.puhov@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fe563105ac39c680
Content-Type: text/plain; charset="UTF-8"

Hi Robert.

I am sorry but how can I apply it? following this what I get

error: patch failed: accel/tcg/cpu-exec.c:558
error: accel/tcg/cpu-exec.c: patch does not apply
error: patch failed: target/arm/helper.c:9808
error: target/arm/helper.c: patch does not apply
error: patch failed: target/ppc/excp_helper.c:1056
error: target/ppc/excp_helper.c: patch does not apply
error: patch failed: target/sh4/helper.c:62
error: target/sh4/helper.c: patch does not apply
error: patch failed: target/unicore32/softmmu.c:118
error: target/unicore32/softmmu.c: patch does not apply



On Wed, Aug 5, 2020 at 9:17 PM Robert Foley <robert.foley@linaro.org> wrote:

> This is part of a series of changes to remove the implied BQL
> from the common code of cpu_handle_interrupt and
> cpu_handle_exception.  As part of removing the implied BQL
> from the common code, we are pushing the BQL holding
> down into the per-arch implementation functions of
> do_interrupt and cpu_exec_interrupt.
>
> The purpose of this set of changes is to set the groundwork
> so that an arch could move towards removing
> the BQL from the cpu_handle_interrupt/exception paths.
>
> This approach was suggested by Paolo Bonzini.
> For reference, here are two key posts in the discussion, explaining
> the reasoning/benefits of this approach.
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  target/avr/helper.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index d96d14372b..f0d625c195 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -30,6 +30,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int
> interrupt_request)
>      CPUClass *cc = CPU_GET_CLASS(cs);
>      AVRCPU *cpu = AVR_CPU(cs);
>      CPUAVRState *env = &cpu->env;
> +    qemu_mutex_lock_iothread();
>
>      if (interrupt_request & CPU_INTERRUPT_RESET) {
>          if (cpu_interrupts_enabled(env)) {
> @@ -53,6 +54,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int
> interrupt_request)
>              ret = true;
>          }
>      }
> +    qemu_mutex_unlock_iothread();
>      return ret;
>  }
>
> @@ -61,10 +63,15 @@ void avr_cpu_do_interrupt(CPUState *cs)
>      AVRCPU *cpu = AVR_CPU(cs);
>      CPUAVRState *env = &cpu->env;
>
> -    uint32_t ret = env->pc_w;
> +    uint32_t ret;
>      int vector = 0;
>      int size = avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2 : 1;
>      int base = 0;
> +    bool bql = !qemu_mutex_iothread_locked();
> +    if (bql) {
> +        qemu_mutex_lock_iothread();
> +    }
> +    ret = env->pc_w;
>
>      if (cs->exception_index == EXCP_RESET) {
>          vector = 0;
> @@ -87,6 +94,9 @@ void avr_cpu_do_interrupt(CPUState *cs)
>      env->sregI = 0; /* clear Global Interrupt Flag */
>
>      cs->exception_index = -1;
> +    if (bql) {
> +        qemu_mutex_unlock_iothread();
> +    }
>  }
>
>  int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
> --
> 2.17.1
>
>

-- 
Best Regards,
Michael Rolnik

--000000000000fe563105ac39c680
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Robert.<div><br></div><div>I am sorry but how can I app=
ly it? following this what I get</div><div><br></div><div><font face=3D"mon=
ospace">error: patch failed: accel/tcg/cpu-exec.c:558<br>error: accel/tcg/c=
pu-exec.c: patch does not apply<br>error: patch failed: target/arm/helper.c=
:9808<br>error: target/arm/helper.c: patch does not apply<br>error: patch f=
ailed: target/ppc/excp_helper.c:1056<br>error: target/ppc/excp_helper.c: pa=
tch does not apply<br>error: patch failed: target/sh4/helper.c:62<br>error:=
 target/sh4/helper.c: patch does not apply<br>error: patch failed: target/u=
nicore32/softmmu.c:118<br>error: target/unicore32/softmmu.c: patch does not=
 apply</font><br></div><div><br></div><div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 5, 2020 =
at 9:17 PM Robert Foley &lt;<a href=3D"mailto:robert.foley@linaro.org">robe=
rt.foley@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">This is part of a series of changes to remove the implie=
d BQL<br>
from the common code of cpu_handle_interrupt and<br>
cpu_handle_exception.=C2=A0 As part of removing the implied BQL<br>
from the common code, we are pushing the BQL holding<br>
down into the per-arch implementation functions of<br>
do_interrupt and cpu_exec_interrupt.<br>
<br>
The purpose of this set of changes is to set the groundwork<br>
so that an arch could move towards removing<br>
the BQL from the cpu_handle_interrupt/exception paths.<br>
<br>
This approach was suggested by Paolo Bonzini.<br>
For reference, here are two key posts in the discussion, explaining<br>
the reasoning/benefits of this approach.<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archive/htm=
l/qemu-devel/2020-07/msg08731.html</a><br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archive/htm=
l/qemu-devel/2020-08/msg00044.html</a><br>
<br>
Signed-off-by: Robert Foley &lt;<a href=3D"mailto:robert.foley@linaro.org" =
target=3D"_blank">robert.foley@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/avr/helper.c | 12 +++++++++++-<br>
=C2=A01 file changed, 11 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/target/avr/helper.c b/target/avr/helper.c<br>
index d96d14372b..f0d625c195 100644<br>
--- a/target/avr/helper.c<br>
+++ b/target/avr/helper.c<br>
@@ -30,6 +30,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_r=
equest)<br>
=C2=A0 =C2=A0 =C2=A0CPUClass *cc =3D CPU_GET_CLASS(cs);<br>
=C2=A0 =C2=A0 =C2=A0AVRCPU *cpu =3D AVR_CPU(cs);<br>
=C2=A0 =C2=A0 =C2=A0CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+=C2=A0 =C2=A0 qemu_mutex_lock_iothread();<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (interrupt_request &amp; CPU_INTERRUPT_RESET) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_interrupts_enabled(env)) {<br>
@@ -53,6 +54,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_r=
equest)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 qemu_mutex_unlock_iothread();<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
@@ -61,10 +63,15 @@ void avr_cpu_do_interrupt(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0AVRCPU *cpu =3D AVR_CPU(cs);<br>
=C2=A0 =C2=A0 =C2=A0CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
<br>
-=C2=A0 =C2=A0 uint32_t ret =3D env-&gt;pc_w;<br>
+=C2=A0 =C2=A0 uint32_t ret;<br>
=C2=A0 =C2=A0 =C2=A0int vector =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int size =3D avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2=
 : 1;<br>
=C2=A0 =C2=A0 =C2=A0int base =3D 0;<br>
+=C2=A0 =C2=A0 bool bql =3D !qemu_mutex_iothread_locked();<br>
+=C2=A0 =C2=A0 if (bql) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock_iothread();<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D env-&gt;pc_w;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (cs-&gt;exception_index =3D=3D EXCP_RESET) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vector =3D 0;<br>
@@ -87,6 +94,9 @@ void avr_cpu_do_interrupt(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;sregI =3D 0; /* clear Global Interrupt Flag */<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0cs-&gt;exception_index =3D -1;<br>
+=C2=A0 =C2=A0 if (bql) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock_iothread();<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,<b=
r>
-- <br>
2.17.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000fe563105ac39c680--

