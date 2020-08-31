Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774E8C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D803206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D803206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrRh-0000VS-8q
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDl-0004WM-CY
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDj-0001ZC-CI
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id b14so7620371qkn.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yZj7fgCqRc45SieCqSQ1vPHsS1TiflEUOLZi5cJUNc0=;
 b=SBrRnQWI0ZzhD1f/FmMxS1lLeq75eCJu0tywnlhnPDTtKLEGggVBkKDCjF+R00fUA1
 Oqxo2FGaD1g67pZlTyz0Vqm+mgq4nVOpkG/q3uXn6/GDKb8FW0l3yykSf2EOtIKX2lGH
 h/E4rL8gimuNpgI2Oi4jac6OOH5DHBGW+eKmQ6KoSkeKxvaBjiUuPWBzRX1q4nMWOs7C
 9kNGmaAhAVQ/HZhPb6swneHYMOKMTvudk6eRTBgwx10Yu4JSePmUtYDKCn4si0+dqk5H
 D8tBjlcwpu6IQMVql24yMcjRcrIJvLj8ewTxGYeCXrXFGFPVmmRQdxc2CSbW+HkXl0U0
 wfdw==
X-Gm-Message-State: AOAM531iBKN3DC1x8RyXBPHXVuuuucihJO6mJGwRGLoM+1pYh+OW0iLp
 TMpa9ogsyvDKkHhQBVZNToE1S285B0aZkW8HUVyFyRzI
X-Google-Smtp-Source: ABdhPJwSSobqmCrNg8HyyqJaUhwRreivS24Y2HcRrdLmstuQNDnZiZH4/GA/RGtcS+61HPr521QtiTQyEU/hO6VJLVA=
X-Received: by 2002:a37:a250:: with SMTP id l77mr3324192qke.219.1598908806531; 
 Mon, 31 Aug 2020 14:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-8-richard.henderson@linaro.org>
In-Reply-To: <20200828141929.77854-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:50:30 +0200
Message-ID: <CAAdtpL7bPuURFaX5FdoViC2_bC=jd_+GoS0q_yJykwEhDDaq4w@mail.gmail.com>
Subject: Re: [PATCH v2 07/76] target/microblaze: Split out EAR from env->sregs
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000071169005ae32f759"
Received-SPF: pass client-ip=209.85.222.195;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qk1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:16:55
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

--00000000000071169005ae32f759
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 16:23, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> Continue eliminating the sregs array in favor of individual members.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/gdbstub.c   | 4 ++--
>  target/microblaze/helper.c    | 6 +++---
>  target/microblaze/op_helper.c | 8 ++++----
>  target/microblaze/translate.c | 6 ++++--
>  5 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 36de61d9f9..c9035b410e 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -238,6 +238,7 @@ struct CPUMBState {
>      uint32_t regs[32];
>      uint64_t pc;
>      uint64_t msr;
> +    uint64_t ear;
>      uint64_t sregs[14];
>      float_status fp_status;
>      /* Stack protectors. Yes, it's a hw feature.  */
> diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
> index e4c4936a7a..e33a613efe 100644
> --- a/target/microblaze/gdbstub.c
> +++ b/target/microblaze/gdbstub.c
> @@ -65,7 +65,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray
> *mem_buf, int n)
>          val =3D env->msr;
>          break;
>      case GDB_EAR:
> -        val =3D env->sregs[SR_EAR];
> +        val =3D env->ear;
>          break;
>      case GDB_ESR:
>          val =3D env->sregs[SR_ESR];
> @@ -121,7 +121,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t
> *mem_buf, int n)
>          env->msr =3D tmp;
>          break;
>      case GDB_EAR:
> -        env->sregs[SR_EAR] =3D tmp;
> +        env->ear =3D tmp;
>          break;
>      case GDB_ESR:
>          env->sregs[SR_ESR] =3D tmp;
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index a18314540f..afe9634781 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -85,7 +85,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int
> size,
>      qemu_log_mask(CPU_LOG_MMU, "mmu=3D%d miss v=3D%" VADDR_PRIx "\n",
>                    mmu_idx, address);
>
> -    env->sregs[SR_EAR] =3D address;
> +    env->ear =3D address;
>      switch (lu.err) {
>      case ERR_PROT:
>          env->sregs[SR_ESR] =3D access_type =3D=3D MMU_INST_FETCH ? 17 : =
16;
> @@ -145,7 +145,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
>              qemu_log_mask(CPU_LOG_INT,
>                            "hw exception at pc=3D%" PRIx64 " ear=3D%" PRI=
x64 "
> "
>                            "esr=3D%" PRIx64 " iflags=3D%x\n",
> -                          env->pc, env->sregs[SR_EAR],
> +                          env->pc, env->ear,
>                            env->sregs[SR_ESR], env->iflags);
>              log_cpu_state_mask(CPU_LOG_INT, cs, 0);
>              env->iflags &=3D ~(IMM_FLAG | D_FLAG);
> @@ -188,7 +188,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
>              qemu_log_mask(CPU_LOG_INT,
>                            "exception at pc=3D%" PRIx64 " ear=3D%" PRIx64=
 " "
>                            "iflags=3D%x\n",
> -                          env->pc, env->sregs[SR_EAR], env->iflags);
> +                          env->pc, env->ear, env->iflags);
>              log_cpu_state_mask(CPU_LOG_INT, cs, 0);
>              env->iflags &=3D ~(IMM_FLAG | D_FLAG);
>              env->pc =3D cpu->cfg.base_vectors + 0x20;
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.=
c
> index 3668382d36..5bacd29663 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -78,7 +78,7 @@ void helper_debug(CPUMBState *env)
>      qemu_log("PC=3D%" PRIx64 "\n", env->pc);
>      qemu_log("rmsr=3D%" PRIx64 " resr=3D%" PRIx64 " rear=3D%" PRIx64 " "
>               "debug[%x] imm=3D%x iflags=3D%x\n",
> -             env->msr, env->sregs[SR_ESR], env->sregs[SR_EAR],
> +             env->msr, env->sregs[SR_ESR], env->ear,
>               env->debug, env->imm, env->iflags);
>      qemu_log("btaken=3D%d btarget=3D%" PRIx64 " mode=3D%s(saved=3D%s) ei=
p=3D%d
> ie=3D%d\n",
>               env->btaken, env->btarget,
> @@ -431,7 +431,7 @@ void helper_memalign(CPUMBState *env, target_ulong
> addr,
>                            "unaligned access addr=3D" TARGET_FMT_lx
>                            " mask=3D%x, wr=3D%d dr=3Dr%d\n",
>                            addr, mask, wr, dr);
> -            env->sregs[SR_EAR] =3D addr;
> +            env->ear =3D addr;
>              env->sregs[SR_ESR] =3D ESR_EC_UNALIGNED_DATA | (wr << 10) \
>                                   | (dr & 31) << 5;
>              if (mask =3D=3D 3) {
> @@ -450,7 +450,7 @@ void helper_stackprot(CPUMBState *env, target_ulong
> addr)
>          qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
>                        TARGET_FMT_lx " %x %x\n",
>                        addr, env->slr, env->shr);
> -        env->sregs[SR_EAR] =3D addr;
> +        env->ear =3D addr;
>          env->sregs[SR_ESR] =3D ESR_EC_STACKPROT;
>          helper_raise_exception(env, EXCP_HW_EXCP);
>      }
> @@ -488,7 +488,7 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr
> physaddr, vaddr addr,
>          return;
>      }
>
> -    env->sregs[SR_EAR] =3D addr;
> +    env->ear =3D addr;
>      if (access_type =3D=3D MMU_INST_FETCH) {
>          if ((env->pvr.regs[2] & PVR2_IOPB_BUS_EXC_MASK)) {
>              env->sregs[SR_ESR] =3D ESR_EC_INSN_BUS;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index 9f2dcd82cd..62747b02f3 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1809,7 +1809,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int
> flags)
>      qemu_fprintf(f, "rmsr=3D%" PRIx64 " resr=3D%" PRIx64 " rear=3D%" PRI=
x64 " "
>                   "debug=3D%x imm=3D%x iflags=3D%x fsr=3D%" PRIx64 " "
>                   "rbtr=3D%" PRIx64 "\n",
> -                 env->msr, env->sregs[SR_ESR], env->sregs[SR_EAR],
> +                 env->msr, env->sregs[SR_ESR], env->ear,
>                   env->debug, env->imm, env->iflags, env->sregs[SR_FSR],
>                   env->sregs[SR_BTR]);
>      qemu_fprintf(f, "btaken=3D%d btarget=3D%" PRIx64 " mode=3D%s(saved=
=3D%s) "
> @@ -1873,8 +1873,10 @@ void mb_tcg_init(void)
>          tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, pc), "rpc")=
;
>      cpu_SR[SR_MSR] =3D
>          tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, msr),
> "rmsr");
> +    cpu_SR[SR_EAR] =3D
> +        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear),
> "rear");
>
> -    for (i =3D SR_MSR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
> +    for (i =3D SR_EAR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
>          cpu_SR[i] =3D tcg_global_mem_new_i64(cpu_env,
>                            offsetof(CPUMBState, sregs[i]),
>                            special_regnames[i]);
> --
> 2.25.1
>
>
>

--00000000000071169005ae32f759
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 16:23, Richard Henderson &lt=
;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.o=
rg</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Cont=
inue eliminating the sregs array in favor of individual members.<br>
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
=C2=A0target/microblaze/helper.c=C2=A0 =C2=A0 | 6 +++---<br>
=C2=A0target/microblaze/op_helper.c | 8 ++++----<br>
=C2=A0target/microblaze/translate.c | 6 ++++--<br>
=C2=A05 files changed, 14 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h<br>
index 36de61d9f9..c9035b410e 100644<br>
--- a/target/microblaze/cpu.h<br>
+++ b/target/microblaze/cpu.h<br>
@@ -238,6 +238,7 @@ struct CPUMBState {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t regs[32];<br>
=C2=A0 =C2=A0 =C2=A0uint64_t pc;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t msr;<br>
+=C2=A0 =C2=A0 uint64_t ear;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t sregs[14];<br>
=C2=A0 =C2=A0 =C2=A0float_status fp_status;<br>
=C2=A0 =C2=A0 =C2=A0/* Stack protectors. Yes, it&#39;s a hw feature.=C2=A0 =
*/<br>
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c<br>
index e4c4936a7a..e33a613efe 100644<br>
--- a/target/microblaze/gdbstub.c<br>
+++ b/target/microblaze/gdbstub.c<br>
@@ -65,7 +65,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *me=
m_buf, int n)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D env-&gt;msr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_EAR:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D env-&gt;sregs[SR_EAR];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D env-&gt;ear;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_ESR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D env-&gt;sregs[SR_ESR];<br>
@@ -121,7 +121,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *me=
m_buf, int n)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;msr =3D tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_EAR:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_EAR] =3D tmp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;ear =3D tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_ESR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sregs[SR_ESR] =3D tmp;<br>
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c<br>
index a18314540f..afe9634781 100644<br>
--- a/target/microblaze/helper.c<br>
+++ b/target/microblaze/helper.c<br>
@@ -85,7 +85,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int siz=
e,<br>
=C2=A0 =C2=A0 =C2=A0qemu_log_mask(CPU_LOG_MMU, &quot;mmu=3D%d miss v=3D%&qu=
ot; VADDR_PRIx &quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmu_id=
x, address);<br>
<br>
-=C2=A0 =C2=A0 env-&gt;sregs[SR_EAR] =3D address;<br>
+=C2=A0 =C2=A0 env-&gt;ear =3D address;<br>
=C2=A0 =C2=A0 =C2=A0switch (lu.err) {<br>
=C2=A0 =C2=A0 =C2=A0case ERR_PROT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sregs[SR_ESR] =3D access_type =3D=
=3D MMU_INST_FETCH ? 17 : 16;<br>
@@ -145,7 +145,7 @@ void mb_cpu_do_interrupt(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(CPU_LOG_INT,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;hw exception at pc=3D%&quot; PRIx64 &quot; ea=
r=3D%&quot; PRIx64 &quot; &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;esr=3D%&quot; PRIx64 &quot; iflags=3D%x\n&quo=
t;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;pc, env-&gt;sregs[SR_EAR],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;pc, env-&gt;ear,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sregs[SR_ESR], env-&gt;iflags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_cpu_state_mask(CPU_LOG_=
INT, cs, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;iflags &amp;=3D ~(I=
MM_FLAG | D_FLAG);<br>
@@ -188,7 +188,7 @@ void mb_cpu_do_interrupt(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(CPU_LOG_INT,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;exception at pc=3D%&quot; PRIx64 &quot; ear=
=3D%&quot; PRIx64 &quot; &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;iflags=3D%x\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;pc, env-&gt;sregs[SR_EAR], env-&gt;iflags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;pc, env-&gt;ear, env-&gt;iflags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_cpu_state_mask(CPU_LOG_=
INT, cs, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;iflags &amp;=3D ~(I=
MM_FLAG | D_FLAG);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pc =3D cpu-&gt;cfg.=
base_vectors + 0x20;<br>
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c<=
br>
index 3668382d36..5bacd29663 100644<br>
--- a/target/microblaze/op_helper.c<br>
+++ b/target/microblaze/op_helper.c<br>
@@ -78,7 +78,7 @@ void helper_debug(CPUMBState *env)<br>
=C2=A0 =C2=A0 =C2=A0qemu_log(&quot;PC=3D%&quot; PRIx64 &quot;\n&quot;, env-=
&gt;pc);<br>
=C2=A0 =C2=A0 =C2=A0qemu_log(&quot;rmsr=3D%&quot; PRIx64 &quot; resr=3D%&qu=
ot; PRIx64 &quot; rear=3D%&quot; PRIx64 &quot; &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;debug[%x] imm=3D%x i=
flags=3D%x\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;msr, env-&gt;sregs=
[SR_ESR], env-&gt;sregs[SR_EAR],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;msr, env-&gt;sregs=
[SR_ESR], env-&gt;ear,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;debug, env-&gt;imm=
, env-&gt;iflags);<br>
=C2=A0 =C2=A0 =C2=A0qemu_log(&quot;btaken=3D%d btarget=3D%&quot; PRIx64 &qu=
ot; mode=3D%s(saved=3D%s) eip=3D%d ie=3D%d\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;btaken, env-&gt;bt=
arget,<br>
@@ -431,7 +431,7 @@ void helper_memalign(CPUMBState *env, target_ulong addr=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;unaligned access addr=3D&quot; TARGET_FMT_lx<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot; mask=3D%x, wr=3D%d dr=3Dr%d\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0addr, mask, wr, dr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_EAR] =3D addr;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;ear =3D addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sregs[SR_ESR] =3D E=
SR_EC_UNALIGNED_DATA | (wr &lt;&lt; 10) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | (dr &amp; 31) &lt;&lt; 5;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mask =3D=3D 3) {<br>
@@ -450,7 +450,7 @@ void helper_stackprot(CPUMBState *env, target_ulong add=
r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(CPU_LOG_INT, &quot;Stack pr=
otector violation at &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TARGET_FMT_lx &quot; %x %x\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0addr, env-&gt;slr, env-&gt;shr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_EAR] =3D addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;ear =3D addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sregs[SR_ESR] =3D ESR_EC_STACKPRO=
T;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0helper_raise_exception(env, EXCP_HW_EXCP)=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -488,7 +488,7 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr phy=
saddr, vaddr addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 env-&gt;sregs[SR_EAR] =3D addr;<br>
+=C2=A0 =C2=A0 env-&gt;ear =3D addr;<br>
=C2=A0 =C2=A0 =C2=A0if (access_type =3D=3D MMU_INST_FETCH) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env-&gt;pvr.regs[2] &amp; PVR2_IOPB_=
BUS_EXC_MASK)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sregs[SR_ESR] =3D E=
SR_EC_INSN_BUS;<br>
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c<=
br>
index 9f2dcd82cd..62747b02f3 100644<br>
--- a/target/microblaze/translate.c<br>
+++ b/target/microblaze/translate.c<br>
@@ -1809,7 +1809,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int fla=
gs)<br>
=C2=A0 =C2=A0 =C2=A0qemu_fprintf(f, &quot;rmsr=3D%&quot; PRIx64 &quot; resr=
=3D%&quot; PRIx64 &quot; rear=3D%&quot; PRIx64 &quot; &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;debug=
=3D%x imm=3D%x iflags=3D%x fsr=3D%&quot; PRIx64 &quot; &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rbtr=
=3D%&quot; PRIx64 &quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;msr,=
 env-&gt;sregs[SR_ESR], env-&gt;sregs[SR_EAR],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;msr,=
 env-&gt;sregs[SR_ESR], env-&gt;ear,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;debu=
g, env-&gt;imm, env-&gt;iflags, env-&gt;sregs[SR_FSR],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sreg=
s[SR_BTR]);<br>
=C2=A0 =C2=A0 =C2=A0qemu_fprintf(f, &quot;btaken=3D%d btarget=3D%&quot; PRI=
x64 &quot; mode=3D%s(saved=3D%s) &quot;<br>
@@ -1873,8 +1873,10 @@ void mb_tcg_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_global_mem_new_i64(cpu_env, offsetof(=
CPUMBState, pc), &quot;rpc&quot;);<br>
=C2=A0 =C2=A0 =C2=A0cpu_SR[SR_MSR] =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_global_mem_new_i64(cpu_env, offsetof(=
CPUMBState, msr), &quot;rmsr&quot;);<br>
+=C2=A0 =C2=A0 cpu_SR[SR_EAR] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_global_mem_new_i64(cpu_env, offsetof(CPUMB=
State, ear), &quot;rear&quot;);<br>
<br>
-=C2=A0 =C2=A0 for (i =3D SR_MSR + 1; i &lt; ARRAY_SIZE(cpu_SR); i++) {<br>
+=C2=A0 =C2=A0 for (i =3D SR_EAR + 1; i &lt; ARRAY_SIZE(cpu_SR); i++) {<br>
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

--00000000000071169005ae32f759--

