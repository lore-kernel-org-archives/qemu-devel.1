Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E89C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6602083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6602083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrTQ-00047R-BE
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDp-0004a9-DZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:13 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDm-0001ZQ-F7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:13 -0400
Received: by mail-qv1-f66.google.com with SMTP id h1so1796429qvo.9
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MzfXW+TMY6CFyIVBla0E0+8dA5AuvzaqhAaHY6HHukE=;
 b=CKnBbizgUxqg43epZ/J2PpwWu6TZXsn6204Phe6jr34muPEaCNujZ0dGlOmfA5Z5eg
 EOym+4Gz0aCV5ivuYbUaoL8vDazdffB8EHHyoZHHvOEJGundp6fFmxrnftbmlbyRj0Dx
 vXhOEwAy1vtChr2hoV/+WsspvJ1DkSlXmHERGj3bmnXNkKYCALsuf8pQObIBDkE7WN8R
 +Lyvfle27SJRcPtOk2EKYSlkCZETfm3yeVKJJ+z20sVzcp/GWVXHP9zQPS+NFk8roYaT
 HCBHyVVienECwTAwbkEYkSrFZSBp2gxzvjoZM3fSOvJHyLMOTJoqsmjTurtfYZzO49nx
 eqMw==
X-Gm-Message-State: AOAM532WigqB7JXHdsT9hf9Mpo+xh/eHzXhg+NOVJKEGXSQvC6wUzEBk
 MogYEXaaZajXTxrlTl4Xxo02OkV6o7N7I0TzjNY=
X-Google-Smtp-Source: ABdhPJwajZYKO8UNA/Jgc7aLJDD+DsHjVMf3ZwM1pZGwjKvrJ9bQiw6aaReecbHJVVGoYrU2v9FHXsv/17Py9/kY8Wg=
X-Received: by 2002:a0c:f9cd:: with SMTP id j13mr2960363qvo.227.1598908809546; 
 Mon, 31 Aug 2020 14:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-11-richard.henderson@linaro.org>
In-Reply-To: <20200828141929.77854-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:53:59 +0200
Message-ID: <CAAdtpL5kz4fBLDYp1mDg9YRRJX3FU8U+jzWdBdAnNysUxZrvMw@mail.gmail.com>
Subject: Re: [PATCH v2 10/76] target/microblaze: Split out BTR from env->sregs
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009f0fe805ae32f775"
Received-SPF: pass client-ip=209.85.219.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qv1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009f0fe805ae32f775
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 16:26, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> Continue eliminating the sregs array in favor of individual members.
> Does not correct the width of BTR, yet.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/gdbstub.c   | 4 ++--
>  target/microblaze/helper.c    | 4 ++--
>  target/microblaze/translate.c | 6 ++++--
>  4 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index bcafef99b0..deddb47abb 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -241,6 +241,7 @@ struct CPUMBState {
>      uint64_t ear;
>      uint64_t esr;
>      uint64_t fsr;
> +    uint64_t btr;
>      uint64_t sregs[14];
>      float_status fp_status;
>      /* Stack protectors. Yes, it's a hw feature.  */
> diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
> index 2634ce49fc..cde8c169bf 100644
> --- a/target/microblaze/gdbstub.c
> +++ b/target/microblaze/gdbstub.c
> @@ -74,7 +74,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray
> *mem_buf, int n)
>          val =3D env->fsr;
>          break;
>      case GDB_BTR:
> -        val =3D env->sregs[SR_BTR];
> +        val =3D env->btr;
>          break;
>      case GDB_PVR0 ... GDB_PVR11:
>          /* PVR12 is intentionally skipped */
> @@ -130,7 +130,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t
> *mem_buf, int n)
>          env->fsr =3D tmp;
>          break;
>      case GDB_BTR:
> -        env->sregs[SR_BTR] =3D tmp;
> +        env->btr =3D tmp;
>          break;
>      case GDB_PVR0 ... GDB_PVR11:
>          /* PVR12 is intentionally skipped */
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index ea290be780..b240dc76f6 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -132,7 +132,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
>              /* Exception breaks branch + dslot sequence?  */
>              if (env->iflags & D_FLAG) {
>                  env->esr |=3D 1 << 12 ;
> -                env->sregs[SR_BTR] =3D env->btarget;
> +                env->btr =3D env->btarget;
>              }
>
>              /* Disable the MMU.  */
> @@ -160,7 +160,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
>              if (env->iflags & D_FLAG) {
>                  D(qemu_log("D_FLAG set at exception bimm=3D%d\n",
> env->bimm));
>                  env->esr |=3D 1 << 12 ;
> -                env->sregs[SR_BTR] =3D env->btarget;
> +                env->btr =3D env->btarget;
>
>                  /* Reexecute the branch.  */
>                  env->regs[17] -=3D 4;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index c58c49ea8f..469e1f103a 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1811,7 +1811,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int
> flags)
>                   "rbtr=3D%" PRIx64 "\n",
>                   env->msr, env->esr, env->ear,
>                   env->debug, env->imm, env->iflags, env->fsr,
> -                 env->sregs[SR_BTR]);
> +                 env->btr);
>      qemu_fprintf(f, "btaken=3D%d btarget=3D%" PRIx64 " mode=3D%s(saved=
=3D%s) "
>                   "eip=3D%d ie=3D%d\n",
>                   env->btaken, env->btarget,
> @@ -1879,8 +1879,10 @@ void mb_tcg_init(void)
>          tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, esr),
> "resr");
>      cpu_SR[SR_FSR] =3D
>          tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr),
> "rfsr");
> +    cpu_SR[SR_BTR] =3D
> +        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, btr),
> "rbtr");
>
> -    for (i =3D SR_FSR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
> +    for (i =3D SR_BTR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
>          cpu_SR[i] =3D tcg_global_mem_new_i64(cpu_env,
>                            offsetof(CPUMBState, sregs[i]),
>                            special_regnames[i]);
> --
> 2.25.1
>
>
>

--0000000000009f0fe805ae32f775
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 16:26, Richard Henderson &lt=
;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.o=
rg</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Cont=
inue eliminating the sregs array in favor of individual members.<br>
Does not correct the width of BTR, yet.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">Reviewe=
d-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.=
org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:sans-s=
erif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-family:sans=
-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
---<br>
=C2=A0target/microblaze/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
=C2=A0target/microblaze/gdbstub.c=C2=A0 =C2=A0| 4 ++--<br>
=C2=A0target/microblaze/helper.c=C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0target/microblaze/translate.c | 6 ++++--<br>
=C2=A04 files changed, 9 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h<br>
index bcafef99b0..deddb47abb 100644<br>
--- a/target/microblaze/cpu.h<br>
+++ b/target/microblaze/cpu.h<br>
@@ -241,6 +241,7 @@ struct CPUMBState {<br>
=C2=A0 =C2=A0 =C2=A0uint64_t ear;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t esr;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t fsr;<br>
+=C2=A0 =C2=A0 uint64_t btr;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t sregs[14];<br>
=C2=A0 =C2=A0 =C2=A0float_status fp_status;<br>
=C2=A0 =C2=A0 =C2=A0/* Stack protectors. Yes, it&#39;s a hw feature.=C2=A0 =
*/<br>
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c<br>
index 2634ce49fc..cde8c169bf 100644<br>
--- a/target/microblaze/gdbstub.c<br>
+++ b/target/microblaze/gdbstub.c<br>
@@ -74,7 +74,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *me=
m_buf, int n)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D env-&gt;fsr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_BTR:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D env-&gt;sregs[SR_BTR];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D env-&gt;btr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_PVR0 ... GDB_PVR11:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* PVR12 is intentionally skipped */<br>
@@ -130,7 +130,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *me=
m_buf, int n)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;fsr =3D tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_BTR:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_BTR] =3D tmp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;btr =3D tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_PVR0 ... GDB_PVR11:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* PVR12 is intentionally skipped */<br>
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c<br>
index ea290be780..b240dc76f6 100644<br>
--- a/target/microblaze/helper.c<br>
+++ b/target/microblaze/helper.c<br>
@@ -132,7 +132,7 @@ void mb_cpu_do_interrupt(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Exception breaks branch =
+ dslot sequence?=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;iflags &amp; D_=
FLAG) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;esr |=
=3D 1 &lt;&lt; 12 ;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_B=
TR] =3D env-&gt;btarget;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;btr =3D en=
v-&gt;btarget;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Disable the MMU.=C2=A0 *=
/<br>
@@ -160,7 +160,7 @@ void mb_cpu_do_interrupt(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;iflags &amp; D_=
FLAG) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0D(qemu_log(&q=
uot;D_FLAG set at exception bimm=3D%d\n&quot;, env-&gt;bimm));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;esr |=
=3D 1 &lt;&lt; 12 ;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_B=
TR] =3D env-&gt;btarget;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;btr =3D en=
v-&gt;btarget;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Reexecute =
the branch.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;regs[=
17] -=3D 4;<br>
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c<=
br>
index c58c49ea8f..469e1f103a 100644<br>
--- a/target/microblaze/translate.c<br>
+++ b/target/microblaze/translate.c<br>
@@ -1811,7 +1811,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int fla=
gs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rbtr=
=3D%&quot; PRIx64 &quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;msr,=
 env-&gt;esr, env-&gt;ear,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;debu=
g, env-&gt;imm, env-&gt;iflags, env-&gt;fsr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sreg=
s[SR_BTR]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;btr)=
;<br>
=C2=A0 =C2=A0 =C2=A0qemu_fprintf(f, &quot;btaken=3D%d btarget=3D%&quot; PRI=
x64 &quot; mode=3D%s(saved=3D%s) &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;eip=3D=
%d ie=3D%d\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;btak=
en, env-&gt;btarget,<br>
@@ -1879,8 +1879,10 @@ void mb_tcg_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_global_mem_new_i64(cpu_env, offsetof(=
CPUMBState, esr), &quot;resr&quot;);<br>
=C2=A0 =C2=A0 =C2=A0cpu_SR[SR_FSR] =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_global_mem_new_i64(cpu_env, offsetof(=
CPUMBState, fsr), &quot;rfsr&quot;);<br>
+=C2=A0 =C2=A0 cpu_SR[SR_BTR] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_global_mem_new_i64(cpu_env, offsetof(CPUMB=
State, btr), &quot;rbtr&quot;);<br>
<br>
-=C2=A0 =C2=A0 for (i =3D SR_FSR + 1; i &lt; ARRAY_SIZE(cpu_SR); i++) {<br>
+=C2=A0 =C2=A0 for (i =3D SR_BTR + 1; i &lt; ARRAY_SIZE(cpu_SR); i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_SR[i] =3D tcg_global_mem_new_i64(cpu_=
env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0offsetof(CPUMBState, sregs[i]),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0special_regnames[i]);<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000009f0fe805ae32f775--

