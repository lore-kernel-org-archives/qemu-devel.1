Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B001C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A5E2083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A5E2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrYX-0003jv-94
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrEJ-0004ue-2y
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrEG-0001cf-UX
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id v54so4430267qtj.7
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eJzzCTrk+7q5S4zJmdo7Nw9Q+2ipEDrmPVAZujxkOHk=;
 b=iaUz4VzD8+tkUwWhnmJUhtxFoLyGIfZmif+ES3EZe5E/yzADCkK20yZp61XcAPqRyO
 MyO+jA05mgp/fFH9wpyhH19lgzN2xOV8uHl/xvZdxxlI91igHIR8SCeExXdGO7AkhHkt
 pJcsEFBeC+hWr6jQbnFbukwkTrGjxMI5249iK/7p96q0Cm4N29kZN3/xxPRnG5tvXxVS
 muN87uYL/kFru9zeuuIwP1Qi6swAbQQfnKg/sYJH8vv2ah9AREFszYzHsF4JWLx5UjKp
 UiEgLpP0sqV4YWowNxm1a2wYk2XUHM+q0rjJDaoCdboJCKxiKXf0ow0P+VngoPoUspC8
 kcJw==
X-Gm-Message-State: AOAM531AXBwO/IX9gIgt/LbdeI0wsxHCflTprJj4g4qOhYpfwBXnk8u8
 QjkS+M5uufinbf291rnLxiiVo3h+i/XnQh3h4Ek=
X-Google-Smtp-Source: ABdhPJw6j8aQodSC4ICdU5XoSv/NYXdqvpAYGhO4ofgJ3mY1oypRU83yK4kFkez8abJmXqL2mL+poRONP9MM7UCnhJA=
X-Received: by 2002:aed:2794:: with SMTP id a20mr3312439qtd.387.1598908840222; 
 Mon, 31 Aug 2020 14:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-24-richard.henderson@linaro.org>
In-Reply-To: <20200828141929.77854-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 23:11:36 +0200
Message-ID: <CAAdtpL4vC_v0Ut634hziTHftvjBp77dZAOG+vfCjUyerQAWwSQ@mail.gmail.com>
Subject: Re: [PATCH v2 23/76] target/microblaze: Rename env_* tcg variables to
 cpu_*
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000073235f05ae32f9df"
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

--00000000000073235f05ae32f9df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 16:36, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> This is cpu_imm, cpu_btaken, cpu_iflags, cpu_res_addr and cpu_res_val.
> It is standard for these file-scope globals to begin with cpu_*.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  target/microblaze/translate.c | 54 +++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index ecfa6b86a4..9aa63ddcc5 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -56,12 +56,12 @@
>  static TCGv_i32 cpu_R[32];
>  static TCGv_i32 cpu_pc;
>  static TCGv_i32 cpu_msr;
> -static TCGv_i32 env_imm;
> -static TCGv_i32 env_btaken;
> +static TCGv_i32 cpu_imm;
> +static TCGv_i32 cpu_btaken;
>  static TCGv_i32 cpu_btarget;
> -static TCGv_i32 env_iflags;
> -static TCGv env_res_addr;
> -static TCGv_i32 env_res_val;
> +static TCGv_i32 cpu_iflags;
> +static TCGv cpu_res_addr;
> +static TCGv_i32 cpu_res_val;
>
>  #include "exec/gen-icount.h"
>
> @@ -107,7 +107,7 @@ static inline void t_sync_flags(DisasContext *dc)
>  {
>      /* Synch the tb dependent flags between translator and runtime.  */
>      if (dc->tb_flags !=3D dc->synced_flags) {
> -        tcg_gen_movi_i32(env_iflags, dc->tb_flags);
> +        tcg_gen_movi_i32(cpu_iflags, dc->tb_flags);
>          dc->synced_flags =3D dc->tb_flags;
>      }
>  }
> @@ -222,10 +222,10 @@ static inline TCGv_i32 *dec_alu_op_b(DisasContext
> *dc)
>  {
>      if (dc->type_b) {
>          if (dc->tb_flags & IMM_FLAG)
> -            tcg_gen_ori_i32(env_imm, env_imm, dc->imm);
> +            tcg_gen_ori_i32(cpu_imm, cpu_imm, dc->imm);
>          else
> -            tcg_gen_movi_i32(env_imm, (int32_t)((int16_t)dc->imm));
> -        return &env_imm;
> +            tcg_gen_movi_i32(cpu_imm, (int32_t)((int16_t)dc->imm));
> +        return &cpu_imm;
>      } else
>          return &cpu_R[dc->rb];
>  }
> @@ -859,7 +859,7 @@ static inline void sync_jmpstate(DisasContext *dc)
>  {
>      if (dc->jmp =3D=3D JMP_DIRECT || dc->jmp =3D=3D JMP_DIRECT_CC) {
>          if (dc->jmp =3D=3D JMP_DIRECT) {
> -            tcg_gen_movi_i32(env_btaken, 1);
> +            tcg_gen_movi_i32(cpu_btaken, 1);
>          }
>          dc->jmp =3D JMP_INDIRECT;
>          tcg_gen_movi_i32(cpu_btarget, dc->jmp_pc);
> @@ -869,7 +869,7 @@ static inline void sync_jmpstate(DisasContext *dc)
>  static void dec_imm(DisasContext *dc)
>  {
>      LOG_DIS("imm %x\n", dc->imm << 16);
> -    tcg_gen_movi_i32(env_imm, (dc->imm << 16));
> +    tcg_gen_movi_i32(cpu_imm, (dc->imm << 16));
>      dc->tb_flags |=3D IMM_FLAG;
>      dc->clear_imm =3D 0;
>  }
> @@ -1040,8 +1040,8 @@ static void dec_load(DisasContext *dc)
>      }
>
>      if (ex) {
> -        tcg_gen_mov_tl(env_res_addr, addr);
> -        tcg_gen_mov_i32(env_res_val, v);
> +        tcg_gen_mov_tl(cpu_res_addr, addr);
> +        tcg_gen_mov_i32(cpu_res_val, v);
>      }
>      if (dc->rd) {
>          tcg_gen_mov_i32(cpu_R[dc->rd], v);
> @@ -1103,7 +1103,7 @@ static void dec_store(DisasContext *dc)
>
>          write_carryi(dc, 1);
>          swx_skip =3D gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_NE, env_res_addr, addr, swx_skip);
> +        tcg_gen_brcond_tl(TCG_COND_NE, cpu_res_addr, addr, swx_skip);
>
>          /*
>           * Compare the value loaded at lwx with current contents of
> @@ -1111,11 +1111,11 @@ static void dec_store(DisasContext *dc)
>           */
>          tval =3D tcg_temp_new_i32();
>
> -        tcg_gen_atomic_cmpxchg_i32(tval, addr, env_res_val,
> +        tcg_gen_atomic_cmpxchg_i32(tval, addr, cpu_res_val,
>                                     cpu_R[dc->rd], mem_index,
>                                     mop);
>
> -        tcg_gen_brcond_i32(TCG_COND_NE, env_res_val, tval, swx_skip);
> +        tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_skip);
>          write_carryi(dc, 0);
>          tcg_temp_free_i32(tval);
>      }
> @@ -1204,7 +1204,7 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i3=
2
> pc_true, TCGv_i32 pc_false)
>      TCGv_i32 zero =3D tcg_const_i32(0);
>
>      tcg_gen_movcond_i32(TCG_COND_NE, cpu_pc,
> -                        env_btaken, zero,
> +                        cpu_btaken, zero,
>                          pc_true, pc_false);
>
>      tcg_temp_free_i32(zero);
> @@ -1245,7 +1245,7 @@ static void dec_bcc(DisasContext *dc)
>          dc->jmp =3D JMP_INDIRECT;
>          tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->pc);
>      }
> -    eval_cc(dc, cc, env_btaken, cpu_R[dc->ra]);
> +    eval_cc(dc, cc, cpu_btaken, cpu_R[dc->ra]);
>  }
>
>  static void dec_br(DisasContext *dc)
> @@ -1311,7 +1311,7 @@ static void dec_br(DisasContext *dc)
>
>      dc->jmp =3D JMP_INDIRECT;
>      if (abs) {
> -        tcg_gen_movi_i32(env_btaken, 1);
> +        tcg_gen_movi_i32(cpu_btaken, 1);
>          tcg_gen_mov_i32(cpu_btarget, *(dec_alu_op_b(dc)));
>          if (link && !dslot) {
>              if (!(dc->tb_flags & IMM_FLAG) &&
> @@ -1330,7 +1330,7 @@ static void dec_br(DisasContext *dc)
>              dc->jmp =3D JMP_DIRECT;
>              dc->jmp_pc =3D dc->pc + (int32_t)((int16_t)dc->imm);
>          } else {
> -            tcg_gen_movi_i32(env_btaken, 1);
> +            tcg_gen_movi_i32(cpu_btaken, 1);
>              tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->pc);
>          }
>      }
> @@ -1419,7 +1419,7 @@ static void dec_rts(DisasContext *dc)
>          LOG_DIS("rts ir=3D%x\n", dc->ir);
>
>      dc->jmp =3D JMP_INDIRECT;
> -    tcg_gen_movi_i32(env_btaken, 1);
> +    tcg_gen_movi_i32(cpu_btaken, 1);
>      tcg_gen_add_i32(cpu_btarget, cpu_R[dc->ra], *dec_alu_op_b(dc));
>  }
>
> @@ -1722,7 +1722,7 @@ void gen_intermediate_code(CPUState *cs,
> TranslationBlock *tb, int max_insns)
>                      TCGLabel *l1 =3D gen_new_label();
>                      t_sync_flags(dc);
>                      /* Conditional jmp.  */
> -                    tcg_gen_brcondi_i32(TCG_COND_NE, env_btaken, 0, l1);
> +                    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_btaken, 0, l1);
>                      gen_goto_tb(dc, 1, dc->pc);
>                      gen_set_label(l1);
>                      gen_goto_tb(dc, 0, dc->jmp_pc);
> @@ -1848,22 +1848,22 @@ void mb_tcg_init(void)
>  {
>      int i;
>
> -    env_iflags =3D tcg_global_mem_new_i32(cpu_env,
> +    cpu_iflags =3D tcg_global_mem_new_i32(cpu_env,
>                      offsetof(CPUMBState, iflags),
>                      "iflags");
> -    env_imm =3D tcg_global_mem_new_i32(cpu_env,
> +    cpu_imm =3D tcg_global_mem_new_i32(cpu_env,
>                      offsetof(CPUMBState, imm),
>                      "imm");
>      cpu_btarget =3D tcg_global_mem_new_i32(cpu_env,
>                       offsetof(CPUMBState, btarget),
>                       "btarget");
> -    env_btaken =3D tcg_global_mem_new_i32(cpu_env,
> +    cpu_btaken =3D tcg_global_mem_new_i32(cpu_env,
>                       offsetof(CPUMBState, btaken),
>                       "btaken");
> -    env_res_addr =3D tcg_global_mem_new(cpu_env,
> +    cpu_res_addr =3D tcg_global_mem_new(cpu_env,
>                       offsetof(CPUMBState, res_addr),
>                       "res_addr");
> -    env_res_val =3D tcg_global_mem_new_i32(cpu_env,
> +    cpu_res_val =3D tcg_global_mem_new_i32(cpu_env,
>                       offsetof(CPUMBState, res_val),
>                       "res_val");
>      for (i =3D 0; i < ARRAY_SIZE(cpu_R); i++) {
> --
> 2.25.1
>
>
>

--00000000000073235f05ae32f9df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 16:36, Richard Henderson &lt=
;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.o=
rg</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This=
 is cpu_imm, cpu_btaken, cpu_iflags, cpu_res_addr and cpu_res_val.<br>
It is standard for these file-scope globals to begin with cpu_*.<br>
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
=C2=A0target/microblaze/translate.c | 54 +++++++++++++++++-----------------=
-<br>
=C2=A01 file changed, 27 insertions(+), 27 deletions(-)<br>
<br>
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c<=
br>
index ecfa6b86a4..9aa63ddcc5 100644<br>
--- a/target/microblaze/translate.c<br>
+++ b/target/microblaze/translate.c<br>
@@ -56,12 +56,12 @@<br>
=C2=A0static TCGv_i32 cpu_R[32];<br>
=C2=A0static TCGv_i32 cpu_pc;<br>
=C2=A0static TCGv_i32 cpu_msr;<br>
-static TCGv_i32 env_imm;<br>
-static TCGv_i32 env_btaken;<br>
+static TCGv_i32 cpu_imm;<br>
+static TCGv_i32 cpu_btaken;<br>
=C2=A0static TCGv_i32 cpu_btarget;<br>
-static TCGv_i32 env_iflags;<br>
-static TCGv env_res_addr;<br>
-static TCGv_i32 env_res_val;<br>
+static TCGv_i32 cpu_iflags;<br>
+static TCGv cpu_res_addr;<br>
+static TCGv_i32 cpu_res_val;<br>
<br>
=C2=A0#include &quot;exec/gen-icount.h&quot;<br>
<br>
@@ -107,7 +107,7 @@ static inline void t_sync_flags(DisasContext *dc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Synch the tb dependent flags between translator and =
runtime.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (dc-&gt;tb_flags !=3D dc-&gt;synced_flags) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(env_iflags, dc-&gt;tb_flags);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(cpu_iflags, dc-&gt;tb_flags);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;synced_flags =3D dc-&gt;tb_flags;<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
@@ -222,10 +222,10 @@ static inline TCGv_i32 *dec_alu_op_b(DisasContext *dc=
)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (dc-&gt;type_b) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dc-&gt;tb_flags &amp; IMM_FLAG)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_ori_i32(env_imm, env_imm=
, dc-&gt;imm);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_ori_i32(cpu_imm, cpu_imm=
, dc-&gt;imm);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(env_imm, (int32=
_t)((int16_t)dc-&gt;imm));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;env_imm;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(cpu_imm, (int32=
_t)((int16_t)dc-&gt;imm));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;cpu_imm;<br>
=C2=A0 =C2=A0 =C2=A0} else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &amp;cpu_R[dc-&gt;rb];<br>
=C2=A0}<br>
@@ -859,7 +859,7 @@ static inline void sync_jmpstate(DisasContext *dc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (dc-&gt;jmp =3D=3D JMP_DIRECT || dc-&gt;jmp =3D=3D J=
MP_DIRECT_CC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dc-&gt;jmp =3D=3D JMP_DIRECT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(env_btaken, 1);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(cpu_btaken, 1);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;jmp =3D JMP_INDIRECT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_movi_i32(cpu_btarget, dc-&gt;jmp_=
pc);<br>
@@ -869,7 +869,7 @@ static inline void sync_jmpstate(DisasContext *dc)<br>
=C2=A0static void dec_imm(DisasContext *dc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0LOG_DIS(&quot;imm %x\n&quot;, dc-&gt;imm &lt;&lt; 16);<=
br>
-=C2=A0 =C2=A0 tcg_gen_movi_i32(env_imm, (dc-&gt;imm &lt;&lt; 16));<br>
+=C2=A0 =C2=A0 tcg_gen_movi_i32(cpu_imm, (dc-&gt;imm &lt;&lt; 16));<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;tb_flags |=3D IMM_FLAG;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;clear_imm =3D 0;<br>
=C2=A0}<br>
@@ -1040,8 +1040,8 @@ static void dec_load(DisasContext *dc)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ex) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(env_res_addr, addr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i32(env_res_val, v);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_res_addr, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i32(cpu_res_val, v);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (dc-&gt;rd) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_i32(cpu_R[dc-&gt;rd], v);<br>
@@ -1103,7 +1103,7 @@ static void dec_store(DisasContext *dc)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0write_carryi(dc, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0swx_skip =3D gen_new_label();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_brcond_tl(TCG_COND_NE, env_res_addr, a=
ddr, swx_skip);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_brcond_tl(TCG_COND_NE, cpu_res_addr, a=
ddr, swx_skip);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Compare the value loaded at lwx with c=
urrent contents of<br>
@@ -1111,11 +1111,11 @@ static void dec_store(DisasContext *dc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tval =3D tcg_temp_new_i32();<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_atomic_cmpxchg_i32(tval, addr, env_res=
_val,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_atomic_cmpxchg_i32(tval, addr, cpu_res=
_val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_R[dc-&gt;rd], mem_=
index,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mop);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_brcond_i32(TCG_COND_NE, env_res_val, t=
val, swx_skip);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, t=
val, swx_skip);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0write_carryi(dc, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i32(tval);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1204,7 +1204,7 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 =
pc_true, TCGv_i32 pc_false)<br>
=C2=A0 =C2=A0 =C2=A0TCGv_i32 zero =3D tcg_const_i32(0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_movcond_i32(TCG_COND_NE, cpu_pc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env_btaken, zero,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cpu_btaken, zero,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pc_true, pc_false);<br>
<br>
=C2=A0 =C2=A0 =C2=A0tcg_temp_free_i32(zero);<br>
@@ -1245,7 +1245,7 @@ static void dec_bcc(DisasContext *dc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;jmp =3D JMP_INDIRECT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_i32(cpu_btarget, *dec_alu_op=
_b(dc), dc-&gt;pc);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 eval_cc(dc, cc, env_btaken, cpu_R[dc-&gt;ra]);<br>
+=C2=A0 =C2=A0 eval_cc(dc, cc, cpu_btaken, cpu_R[dc-&gt;ra]);<br>
=C2=A0}<br>
<br>
=C2=A0static void dec_br(DisasContext *dc)<br>
@@ -1311,7 +1311,7 @@ static void dec_br(DisasContext *dc)<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;jmp =3D JMP_INDIRECT;<br>
=C2=A0 =C2=A0 =C2=A0if (abs) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(env_btaken, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(cpu_btaken, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_i32(cpu_btarget, *(dec_alu_op=
_b(dc)));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (link &amp;&amp; !dslot) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(dc-&gt;tb_flags &amp;=
 IMM_FLAG) &amp;&amp;<br>
@@ -1330,7 +1330,7 @@ static void dec_br(DisasContext *dc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;jmp =3D JMP_DIRECT;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;jmp_pc =3D dc-&gt;pc=
 + (int32_t)((int16_t)dc-&gt;imm);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(env_btaken, 1);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(cpu_btaken, 1);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_i32(cpu_btarge=
t, *dec_alu_op_b(dc), dc-&gt;pc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1419,7 +1419,7 @@ static void dec_rts(DisasContext *dc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LOG_DIS(&quot;rts ir=3D%x\n&quot;, dc-&gt=
;ir);<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;jmp =3D JMP_INDIRECT;<br>
-=C2=A0 =C2=A0 tcg_gen_movi_i32(env_btaken, 1);<br>
+=C2=A0 =C2=A0 tcg_gen_movi_i32(cpu_btaken, 1);<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_add_i32(cpu_btarget, cpu_R[dc-&gt;ra], *dec_alu=
_op_b(dc));<br>
=C2=A0}<br>
<br>
@@ -1722,7 +1722,7 @@ void gen_intermediate_code(CPUState *cs, TranslationB=
lock *tb, int max_insns)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0TCGLabel *l1 =3D gen_new_label();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0t_sync_flags(dc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Conditional jmp.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_=
gen_brcondi_i32(TCG_COND_NE, env_btaken, 0, l1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_=
gen_brcondi_i32(TCG_COND_NE, cpu_btaken, 0, l1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0gen_goto_tb(dc, 1, dc-&gt;pc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0gen_set_label(l1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0gen_goto_tb(dc, 0, dc-&gt;jmp_pc);<br>
@@ -1848,22 +1848,22 @@ void mb_tcg_init(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
-=C2=A0 =C2=A0 env_iflags =3D tcg_global_mem_new_i32(cpu_env,<br>
+=C2=A0 =C2=A0 cpu_iflags =3D tcg_global_mem_new_i32(cpu_env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0offsetof(CPUMBState, iflags),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;iflags&quot;);<br>
-=C2=A0 =C2=A0 env_imm =3D tcg_global_mem_new_i32(cpu_env,<br>
+=C2=A0 =C2=A0 cpu_imm =3D tcg_global_mem_new_i32(cpu_env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0offsetof(CPUMBState, imm),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;imm&quot;);<br>
=C2=A0 =C2=A0 =C2=A0cpu_btarget =3D tcg_global_mem_new_i32(cpu_env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 offsetof(CPUMBState, btarget),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;btarget&quot;);<br>
-=C2=A0 =C2=A0 env_btaken =3D tcg_global_mem_new_i32(cpu_env,<br>
+=C2=A0 =C2=A0 cpu_btaken =3D tcg_global_mem_new_i32(cpu_env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 offsetof(CPUMBState, btaken),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;btaken&quot;);<br>
-=C2=A0 =C2=A0 env_res_addr =3D tcg_global_mem_new(cpu_env,<br>
+=C2=A0 =C2=A0 cpu_res_addr =3D tcg_global_mem_new(cpu_env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 offsetof(CPUMBState, res_addr),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;res_addr&quot;);<br>
-=C2=A0 =C2=A0 env_res_val =3D tcg_global_mem_new_i32(cpu_env,<br>
+=C2=A0 =C2=A0 cpu_res_val =3D tcg_global_mem_new_i32(cpu_env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 offsetof(CPUMBState, res_val),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;res_val&quot;);<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(cpu_R); i++) {<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000073235f05ae32f9df--

