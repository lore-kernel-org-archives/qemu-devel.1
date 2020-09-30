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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EFEC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4182076A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAdImrJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4182076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNgab-00029P-3k
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 14:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kNgYQ-0000nk-BV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:10:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kNgYK-0006eb-F0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:10:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id g4so2846549wrs.5
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=6eoc0Os8U/KFwF0LS4uVDsYzl4Wo5Iufzv71Q4cIKwU=;
 b=gAdImrJYKt2Q9qCFrnlVhTgqReeNybwEmGW6aDAAA6S9S7D1xSqTAbNPp5rZeCdRfX
 9cTzhKw2rxJQ+iaMdoPR95a6TgXIW4KqOCHmJpp+YafeXqPOwOLPbxisDAJCeGq90hYD
 IiWisviU1jDg3Zyp20D3u35p4WzMe239mMBhFCN7FnyfOFoM2wDnfVoJa2QHRE5DInwr
 KKtqsoUR57cdCznTexaKxrBc5N19ePNLm3djcQGu3NlfP0UWfFXhBmEXONEUil5jLihg
 UEP9F5hQFcqz0LQ5p3H6j2Oz9diKIy0S6teej1a4CRi94evW9fuYR8OI74oDtJtJIVGZ
 0CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=6eoc0Os8U/KFwF0LS4uVDsYzl4Wo5Iufzv71Q4cIKwU=;
 b=j3FW7QQt6GbYmRiUobNuQS7T9HwJ0UEMUDMrzsdnFcpDQbP0jDsPVqg2JDfwIOcvlm
 pQIpdrIzQVFo25u25NAh51IxCgXt0uUdm+P/lqpYfzm5ksDSPysiHd7P0C8exeGaxdGv
 7dsTKKHcnfCNn2bwzSQ04JFc8qNtr1snpeCn5IYsNsuCKyY5YfEf1H2OjKX6eB0HGVLd
 z3gFqfqugdQC66Qmd1lqBynVHgxFIXNxeGYaqHGPhdNWMTDbgERkY0w7hDcVbJQQ8FjQ
 uwnhZLaquEXOY2VaVUBhvsGyWHSW1gCjzShIJvxNRYhr2mICOvTViR15YEHY8mHr889t
 59eg==
X-Gm-Message-State: AOAM533L/LoRr1VV6Du43thd291MP1C0QN6+5cOcifvjoNpNDbTeeQeb
 HB0ZunM+xAX204Y/BRNNYf4DLSWdSSvUFnLrni4=
X-Google-Smtp-Source: ABdhPJxKl6aLcEBu4BIDQiAo59eu+xOoGfObhkN5fW5vKknzThzNK+IguWvscQpjIU6km5fXUrDrAb90jr7o96Hok/U=
X-Received: by 2002:a5d:470f:: with SMTP id y15mr4408798wrq.420.1601489405739; 
 Wed, 30 Sep 2020 11:10:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7504:0:0:0:0:0 with HTTP; Wed, 30 Sep 2020 11:10:05
 -0700 (PDT)
In-Reply-To: <20200928171539.788309-4-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-4-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 30 Sep 2020 20:10:05 +0200
Message-ID: <CAHiYmc6AfcERT1+Wg6r+qzZ1SdXdD95GOR2cq98hvEW0ttYEGw@mail.gmail.com>
Subject: Re: [PATCH 03/16] target/mips/cp0_timer: Explicit unit in variable
 name
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000002403d505b08bcf2f"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
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

--0000000000002403d505b08bcf2f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, September 28, 2020, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> Name variables holding nanoseconds with the '_ns' suffix.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---


Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>


>  target/mips/cp0_timer.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
> index 9c38e9da1c8..5194c967ae3 100644
> --- a/target/mips/cp0_timer.c
> +++ b/target/mips/cp0_timer.c
> @@ -32,13 +32,14 @@
>  /* MIPS R4K timer */
>  static void cpu_mips_timer_update(CPUMIPSState *env)
>  {
> -    uint64_t now, next;
> +    uint64_t now_ns, next_ns;
>      uint32_t wait;
>
> -    now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    wait =3D env->CP0_Compare - env->CP0_Count - (uint32_t)(now /
> TIMER_PERIOD);
> -    next =3D now + (uint64_t)wait * TIMER_PERIOD;
> -    timer_mod(env->timer, next);
> +    now_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    wait =3D env->CP0_Compare - env->CP0_Count -
> +           (uint32_t)(now_ns / TIMER_PERIOD);
> +    next_ns =3D now_ns + (uint64_t)wait * TIMER_PERIOD;
> +    timer_mod(env->timer, next_ns);
>  }
>
>  /* Expire the timer.  */
> @@ -56,16 +57,16 @@ uint32_t cpu_mips_get_count(CPUMIPSState *env)
>      if (env->CP0_Cause & (1 << CP0Ca_DC)) {
>          return env->CP0_Count;
>      } else {
> -        uint64_t now;
> +        uint64_t now_ns;
>
> -        now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        now_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>          if (timer_pending(env->timer)
> -            && timer_expired(env->timer, now)) {
> +            && timer_expired(env->timer, now_ns)) {
>              /* The timer has already expired.  */
>              cpu_mips_timer_expire(env);
>          }
>
> -        return env->CP0_Count + (uint32_t)(now / TIMER_PERIOD);
> +        return env->CP0_Count + (uint32_t)(now_ns / TIMER_PERIOD);
>      }
>  }
>
> --
> 2.26.2
>
>

--0000000000002403d505b08bcf2f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, September 28, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Name variables holding nanoseconds with the &#39;_ns&#=
39; suffix.<br>
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
=C2=A0target/mips/cp0_timer.c | 19 ++++++++++---------<br>
=C2=A01 file changed, 10 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c<br>
index 9c38e9da1c8..5194c967ae3 100644<br>
--- a/target/mips/cp0_timer.c<br>
+++ b/target/mips/cp0_timer.c<br>
@@ -32,13 +32,14 @@<br>
=C2=A0/* MIPS R4K timer */<br>
=C2=A0static void cpu_mips_timer_update(<wbr>CPUMIPSState *env)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 uint64_t now, next;<br>
+=C2=A0 =C2=A0 uint64_t now_ns, next_ns;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t wait;<br>
<br>
-=C2=A0 =C2=A0 now =3D qemu_clock_get_ns(QEMU_CLOCK_<wbr>VIRTUAL);<br>
-=C2=A0 =C2=A0 wait =3D env-&gt;CP0_Compare - env-&gt;CP0_Count - (uint32_t=
)(now / TIMER_PERIOD);<br>
-=C2=A0 =C2=A0 next =3D now + (uint64_t)wait * TIMER_PERIOD;<br>
-=C2=A0 =C2=A0 timer_mod(env-&gt;timer, next);<br>
+=C2=A0 =C2=A0 now_ns =3D qemu_clock_get_ns(QEMU_CLOCK_<wbr>VIRTUAL);<br>
+=C2=A0 =C2=A0 wait =3D env-&gt;CP0_Compare - env-&gt;CP0_Count -<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint32_t)(now_ns / TIMER_PERIOD)=
;<br>
+=C2=A0 =C2=A0 next_ns =3D now_ns + (uint64_t)wait * TIMER_PERIOD;<br>
+=C2=A0 =C2=A0 timer_mod(env-&gt;timer, next_ns);<br>
=C2=A0}<br>
<br>
=C2=A0/* Expire the timer.=C2=A0 */<br>
@@ -56,16 +57,16 @@ uint32_t cpu_mips_get_count(<wbr>CPUMIPSState *env)<br>
=C2=A0 =C2=A0 =C2=A0if (env-&gt;CP0_Cause &amp; (1 &lt;&lt; CP0Ca_DC)) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return env-&gt;CP0_Count;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t now;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t now_ns;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 now =3D qemu_clock_get_ns(QEMU_CLOCK_<wbr>VIRT=
UAL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 now_ns =3D qemu_clock_get_ns(QEMU_CLOCK_<wbr>V=
IRTUAL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (timer_pending(env-&gt;timer)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; timer_expired(env-&gt=
;timer, now)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; timer_expired(env-&gt=
;timer, now_ns)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The timer has already ex=
pired.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_mips_timer_expire(env);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return env-&gt;CP0_Count + (uint32_t)(now / TI=
MER_PERIOD);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return env-&gt;CP0_Count + (uint32_t)(now_ns /=
 TIMER_PERIOD);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
=C2=A0<br>
-- <br>
2.26.2<br>
<br>
</blockquote>

--0000000000002403d505b08bcf2f--

