Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81093C47404
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 02:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D55A214E0
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 02:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFQivVQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D55A214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ7Ih-0003L3-H3
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 22:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fintelia@gmail.com>) id 1iJ7Hy-0002tv-LV
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1iJ7Hx-0000TV-89
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:37:50 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1iJ7Hw-0000Su-S4; Fri, 11 Oct 2019 22:37:49 -0400
Received: by mail-lj1-x242.google.com with SMTP id y23so11544663lje.9;
 Fri, 11 Oct 2019 19:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dH6nweyXDZwh9MuDSAoQ45VYUXjhi2cI7rMQsrP8mRM=;
 b=UFQivVQXuuPAg/ehz7TvWSFq1rcEb7BhTn+xAP838ROTbVgDW35it0OMbvCCqdfrCw
 f/xJfb3tOFk9gW783NTERP87yQj2naU4cFddjMSf+zenwd4u6u0Rt8OhuSc/JYsRNuvE
 VgsM8NJVn4NlfR6brePF+28U3A3oWmHRwMOsTGukDc19K9lBX+YImHyKDcAdEo9AkQJE
 a8dCWvg5XpFu/BDHBbCusQ0/GQiO91qsd/s5rq+MZ1oxgWv8Qxzy3Eo2ENuEBS69SKJS
 Gt/5E1WurfcliJUHmm5mhfGNZl0b9p3Sf5cguwELbxiWlagev6FhG7WUXXICniQN1wzA
 nekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dH6nweyXDZwh9MuDSAoQ45VYUXjhi2cI7rMQsrP8mRM=;
 b=RDGLYvdZofgUz84SdE8i3SOypo2c8mxnZPZ323Kh/+yiQcdAs2V2BP5I1QsyEQsV6u
 /2qJ0HYYs2Y6mrvQPyD+uWG21cDc7gyzEaiS6+I+XpzLrsuBPSqFpVhgL3l7/VgtroQD
 iVMOiwAgLHPfSzoJEA1+KXY+M/yTZJclbu3ElkpYdlEvaeackfs9c70MiYPCscZLjk1A
 cfjWsXRPJ0JP1txjlIa5RLaWIhGzvskedNMsscA20Gk3cec9vcS0ZRieMGlg/Zki0tKZ
 W7Xqpq7Mu+ZqQWoGatnpItCk5jX9CltlzAvKT0peCEhGxZRPgQ4LP1dYuK3rih9djkMC
 Qr8w==
X-Gm-Message-State: APjAAAUEsd1urxUAm5vs6pmnD6kpzqC4dWIKojvmgHQai5mGa7Um/x56
 wA5vMDDo8TRAShsr57WAgVeUIXFHn0OhcUea24k=
X-Google-Smtp-Source: APXvYqz/IZhJyp1593/qW6QnCjIFS3ZzsY3+clpdzyK/3upPjJ62wst7cbFBJwL5f/HanqwtJ2lMtoF1IVBHOzzlBRo=
X-Received: by 2002:a2e:7404:: with SMTP id p4mr10770351ljc.47.1570847866023; 
 Fri, 11 Oct 2019 19:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191011231406.9808-1-dayeol@berkeley.edu>
In-Reply-To: <20191011231406.9808-1-dayeol@berkeley.edu>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Fri, 11 Oct 2019 22:37:19 -0400
Message-ID: <CANnJOVHy8TuitQHBQ=+uh6ZKB=5iEZaE2CsLosti5mHQvRi_KA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: PMP violation due to wrong size parameter
To: Dayeol Lee <dayeol@berkeley.edu>
Content-Type: multipart/alternative; boundary="0000000000000cf1e80594ad8566"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, diodesign@tuta.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000cf1e80594ad8566
Content-Type: text/plain; charset="UTF-8"

How do you know that the access won't straddle a page boundary? Is there a
guarantee somewhere that size=0 means that the access is naturally aligned?

Jonathan


On Fri, Oct 11, 2019 at 7:14 PM Dayeol Lee <dayeol@berkeley.edu> wrote:

> riscv_cpu_tlb_fill() uses the `size` parameter to check PMP violation
> using pmp_hart_has_privs().
> However, if the size is unknown (=0), the ending address will be
> `addr - 1` as it is `addr + size - 1` in `pmp_hart_has_privs()`.
> This always causes a false PMP violation on the starting address of the
> range, as `addr - 1` is not in the range.
>
> In order to fix, we just assume that all bytes from addr to the end of
> the page will be accessed if the size is unknown.
>
> Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/cpu_helper.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e32b6126af..7d9a22b601 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -441,6 +441,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,
> int size,
>      CPURISCVState *env = &cpu->env;
>      hwaddr pa = 0;
>      int prot;
> +    int pmp_size = 0;
>      bool pmp_violation = false;
>      int ret = TRANSLATE_FAIL;
>      int mode = mmu_idx;
> @@ -460,9 +461,19 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,
> int size,
>                    "%s address=%" VADDR_PRIx " ret %d physical "
> TARGET_FMT_plx
>                    " prot %d\n", __func__, address, ret, pa, prot);
>
> +    /*
> +     * if size is unknown (0), assume that all bytes
> +     * from addr to the end of the page will be accessed.
> +     */
> +    if (size == 0) {
> +        pmp_size = -(address | TARGET_PAGE_MASK);
> +    } else {
> +        pmp_size = size;
> +    }
> +
>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>          (ret == TRANSLATE_SUCCESS) &&
> -        !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
> +        !pmp_hart_has_privs(env, pa, pmp_size, 1 << access_type, mode)) {
>          ret = TRANSLATE_PMP_FAIL;
>      }
>      if (ret == TRANSLATE_PMP_FAIL) {
> --
> 2.20.1
>
>
>

--0000000000000cf1e80594ad8566
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>How do you know that the access won&#39;t straddle a =
page boundary? Is there a guarantee somewhere that size=3D0 means that the =
access is naturally aligned?</div><div><br></div><div>Jonathan<br></div><br=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Fri, Oct 11, 2019 at 7:14 PM Dayeol Lee &lt;<a href=3D"mailto:dayeol@be=
rkeley.edu">dayeol@berkeley.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">riscv_cpu_tlb_fill() uses the `size` param=
eter to check PMP violation<br>
using pmp_hart_has_privs().<br>
However, if the size is unknown (=3D0), the ending address will be<br>
`addr - 1` as it is `addr + size - 1` in `pmp_hart_has_privs()`.<br>
This always causes a false PMP violation on the starting address of the<br>
range, as `addr - 1` is not in the range.<br>
<br>
In order to fix, we just assume that all bytes from addr to the end of<br>
the page will be accessed if the size is unknown.<br>
<br>
Signed-off-by: Dayeol Lee &lt;<a href=3D"mailto:dayeol@berkeley.edu" target=
=3D"_blank">dayeol@berkeley.edu</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/riscv/cpu_helper.c | 13 ++++++++++++-<br>
=C2=A01 file changed, 12 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
index e32b6126af..7d9a22b601 100644<br>
--- a/target/riscv/cpu_helper.c<br>
+++ b/target/riscv/cpu_helper.c<br>
@@ -441,6 +441,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, in=
t size,<br>
=C2=A0 =C2=A0 =C2=A0CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
=C2=A0 =C2=A0 =C2=A0hwaddr pa =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int prot;<br>
+=C2=A0 =C2=A0 int pmp_size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0bool pmp_violation =3D false;<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D TRANSLATE_FAIL;<br>
=C2=A0 =C2=A0 =C2=A0int mode =3D mmu_idx;<br>
@@ -460,9 +461,19 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
%s address=3D%&quot; VADDR_PRIx &quot; ret %d physical &quot; TARGET_FMT_pl=
x<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
 prot %d\n&quot;, __func__, address, ret, pa, prot);<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* if size is unknown (0), assume that all bytes<br>
+=C2=A0 =C2=A0 =C2=A0* from addr to the end of the page will be accessed.<b=
r>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (size =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pmp_size =3D -(address | TARGET_PAGE_MASK);<br=
>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pmp_size =3D size;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (riscv_feature(env, RISCV_FEATURE_PMP) &amp;&amp;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ret =3D=3D TRANSLATE_SUCCESS) &amp;&amp;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 !pmp_hart_has_privs(env, pa, size, 1 &lt;&lt; =
access_type, mode)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !pmp_hart_has_privs(env, pa, pmp_size, 1 &lt;&=
lt; access_type, mode)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D TRANSLATE_PMP_FAIL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (ret =3D=3D TRANSLATE_PMP_FAIL) {<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div>

--0000000000000cf1e80594ad8566--

