Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A4C32771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 02:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D4B2051A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 02:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D4B2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioeNU-0005sO-FR
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 21:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1ioeLU-0004BY-Jd
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 21:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1ioeLR-0007f1-52
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 21:11:48 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1ioeLQ-0007W9-Hf; Mon, 06 Jan 2020 21:11:45 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436288|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.254382-0.0116724-0.733945;
 DS=CONTINUE|ham_regular_dialog|0.712369-0.00131796-0.286313;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03306; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.GXbeIzi_1578363098; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GXbeIzi_1578363098)
 by smtp.aliyun-inc.com(10.147.40.44); Tue, 07 Jan 2020 10:11:38 +0800
Subject: Re: [PATCH v3 4/4] RISC-V: add vector extension configure instruction
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200103033347.20909-1-zhiwei_liu@c-sky.com>
 <20200103033347.20909-5-zhiwei_liu@c-sky.com>
 <94fd7ef0-3ee7-d836-3feb-00a8b93ab585@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <d49e779c-57e5-114b-3e14-96d7e98144b5@c-sky.com>
Date: Tue, 7 Jan 2020 10:11:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <94fd7ef0-3ee7-d836-3feb-00a8b93ab585@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------8D66D43FB19310A341D75560"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------8D66D43FB19310A341D75560
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Richard,

Thanks for the comments of the part 1.  It's really very helpful.
I accept most of the comments.

On 2020/1/4 7:41, Richard Henderson wrote:
> On 1/3/20 2:33 PM, LIU Zhiwei wrote:
>> vsetvl and vsetvli are two configure instructions for vl, vtype. TB flags
>> should update after configure instructions. The (ill, lmul, sew ) of vtype
>> and the bit of (VSTART == 0 && VL == VLMAX) will be placed within tb_flags.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>   target/riscv/Makefile.objs              |  2 +-
>>   target/riscv/cpu.c                      |  1 +
>>   target/riscv/cpu.h                      | 55 ++++++++++++++++++++-----
>>   target/riscv/helper.h                   |  2 +
>>   target/riscv/insn32.decode              |  5 +++
>>   target/riscv/insn_trans/trans_rvv.inc.c | 52 +++++++++++++++++++++++
>>   target/riscv/translate.c                | 17 +++++++-
>>   target/riscv/vector_helper.c            | 51 +++++++++++++++++++++++
>>   8 files changed, 172 insertions(+), 13 deletions(-)
>>   create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>>   create mode 100644 target/riscv/vector_helper.c
>>
>> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
>> index b1c79bc1d1..d577cef9e0 100644
>> --- a/target/riscv/Makefile.objs
>> +++ b/target/riscv/Makefile.objs
>> @@ -1,4 +1,4 @@
>> -obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o pmp.o
>> +obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o vector_helper.o gdbstub.o pmp.o
>>   
>>   DECODETREE = $(SRC_PATH)/scripts/decodetree.py
>>   
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index c2370a0a57..3ff7b50bff 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -347,6 +347,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>>           }
>>       }
>>       if (cpu->cfg.vext_spec) {
>> +        env->vext.vtype = ~((target_ulong)-1 >> 1);
> Better as FIELD_DP64(0, VTYPE, VILL, 1),
>
>
>> +struct VTYPE {
>> +#ifdef HOST_WORDS_BIGENDIAN
>> +    target_ulong vill:1;
>> +    target_ulong reserved:sizeof(target_ulong) * 8 - 7;
>> +    target_ulong sew:3;
>> +    target_ulong lmul:2;
>> +#else
>> +    target_ulong lmul:2;
>> +    target_ulong sew:3;
>> +    target_ulong reserved:sizeof(target_ulong) * 8 - 7;
>> +    target_ulong vill:1;
>> +#endif
>> +};
> Do not use bit fields to describe target register layout.
> Use FIELD().
OK. I think there is no need to the handle endianess here.  FIELD() is good.

>> -#define TB_FLAGS_MMU_MASK   3
>> -#define TB_FLAGS_MSTATUS_FS MSTATUS_FS
>> +typedef CPURISCVState CPUArchState;
>> +typedef RISCVCPU ArchCPU;
>> +#include "exec/cpu-all.h"
>> +
>> +FIELD(TB_FLAGS, MMU, 0, 2)
>> +FIELD(TB_FLAGS, FS, 13, 2)
> The change to use FIELD for MMU and FS should be made separately from adding
> the vector state.
>
>> +FIELD(TB_FLAGS, VL_EQ_VLMAX, 16, 1)
>> +FIELD(TB_FLAGS, LMUL, 17, 2)
>> +FIELD(TB_FLAGS, SEW, 19, 3)
>> +FIELD(TB_FLAGS, VILL, 22, 1)
> Why are you leaving holes in TB_FLAGS?  I know why the original hole was there,
> since it corresponded to simple masks on other registers.
>
>> +    vlmax = (1 << vtype->lmul) * cpu->cfg.vlen / (8 * (1 << vtype->sew));
> Wow, this can be simplified a lot.
>
>     (1 << LMUL) * VLEN / (8 * (1 << SEW))
>   = (VLEN << LMUL) / (8 << SEW)
>   = (VLEN << LMUL) >> (SEW + 3)
>   = VLEN >> (SEW + 3 - LMUL)
>
Good.
>> +    vl_eq_vlmax = (env->vext.vstart == 0) && (vlmax == env->vext.vl);
>> +
>> +    flags = FIELD_DP32(flags, TB_FLAGS, VILL, vtype->vill);
>> +    flags = FIELD_DP32(flags, TB_FLAGS, SEW, vtype->sew);
>> +    flags = FIELD_DP32(flags, TB_FLAGS, LMUL, vtype->lmul);
>> +    flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
> I wonder if perhaps this all ought to be nested under
>
>    if (env->misa & RVV) {
>        ...
>    } else {
>        flag = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
>    }
>
> so that, for the normal case when RVV is disabled, we don't bother computing
> all of those bits.
>
>> +static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
>> +{
>> +    TCGv s1, s2, d;
>> +    d = tcg_temp_new();
>> +    s1 = tcg_temp_new();
>> +    s2 = tcg_temp_new();
>> +    gen_get_gpr(s1, a->rs1);
>> +    gen_get_gpr(s2, a->rs2);
>> +    gen_helper_vector_vsetvli(d, cpu_env, s1, s2);
>> +    tcg_gen_st_tl(d, cpu_env, offsetof(CPURISCVState, vext.vl));
> Why are you performing the store to vl inline, as opposed to within the helper
> funtion?
>
>> +    exit_tb(ctx);
> A normal exit is correct for vsetvl, because the new state is variable.
>
>> +static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
>> +{
>> +    TCGv s1, s2, d;
>> +    d = tcg_temp_new();
>> +    s1 = tcg_temp_new();
>> +    s2 = tcg_const_tl(a->zimm);
>> +    gen_get_gpr(s1, a->rs1);
>> +    gen_helper_vector_vsetvli(d, cpu_env, s1, s2);
>> +    tcg_gen_st_tl(d, cpu_env, offsetof(CPURISCVState, vext.vl));
>> +    exit_tb(ctx);
> You could use
>
>    gen_goto_tb(ctx, 0, ctx->base.pc_next)
>
> here, because the new state is unknown but constant.  It will be the same every
> time the instruction is executed, and thus can compute the new state only once,
> saving that computation in the link to the next tb.
>
>> +target_ulong VECTOR_HELPER(vsetvli)(CPURISCVState *env, target_ulong s1,
>> +    target_ulong s2)
>> +{
>> +    int vlmax, vl;
>> +    RISCVCPU *cpu = env_archcpu(env);
>> +    struct VTYPE *vtype = (struct VTYPE *)&s2;
> FIELD_EX64 for all uses of VTYPE.
>
>> +
>> +    if (vtype->sew > cpu->cfg.elen) { /* only set vill bit. */
>> +        env->vext.vtype = ~((target_ulong)-1 >> 1);
> FIELD_DP64.
>
>> +    vlmax = (1 << vtype->lmul) * cpu->cfg.vlen / (8 * (1 << vtype->sew));
> Same simplification as before.  Perhaps extract this to an inline function for
> clarity, documenting the algebraic simplification only once.
>
> r~
Best Regards,
Zhiwei


--------------8D66D43FB19310A341D75560
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi Richard,<br>
    <br>
    Thanks for the comments of the part 1.  It's really very helpful. <br>
    I accept most of the comments.<span style="color: rgb(51, 51, 51);
      font-family: arial; font-size: 13px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      left; text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"></span><br>
    <br>
    <div class="moz-cite-prefix">On 2020/1/4 7:41, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:94fd7ef0-3ee7-d836-3feb-00a8b93ab585@linaro.org">
      <pre class="moz-quote-pre" wrap="">On 1/3/20 2:33 PM, LIU Zhiwei wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">vsetvl and vsetvli are two configure instructions for vl, vtype. TB flags
should update after configure instructions. The (ill, lmul, sew ) of vtype
and the bit of (VSTART == 0 &amp;&amp; VL == VLMAX) will be placed within tb_flags.

Signed-off-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com">&lt;zhiwei_liu@c-sky.com&gt;</a>
---
 target/riscv/Makefile.objs              |  2 +-
 target/riscv/cpu.c                      |  1 +
 target/riscv/cpu.h                      | 55 ++++++++++++++++++++-----
 target/riscv/helper.h                   |  2 +
 target/riscv/insn32.decode              |  5 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 52 +++++++++++++++++++++++
 target/riscv/translate.c                | 17 +++++++-
 target/riscv/vector_helper.c            | 51 +++++++++++++++++++++++
 8 files changed, 172 insertions(+), 13 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
 create mode 100644 target/riscv/vector_helper.c

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index b1c79bc1d1..d577cef9e0 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o pmp.o
+obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o vector_helper.o gdbstub.o pmp.o
 
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c2370a0a57..3ff7b50bff 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -347,6 +347,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         }
     }
     if (cpu-&gt;cfg.vext_spec) {
+        env-&gt;vext.vtype = ~((target_ulong)-1 &gt;&gt; 1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Better as FIELD_DP64(0, VTYPE, VILL, 1),


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+struct VTYPE {
+#ifdef HOST_WORDS_BIGENDIAN
+    target_ulong vill:1;
+    target_ulong reserved:sizeof(target_ulong) * 8 - 7;
+    target_ulong sew:3;
+    target_ulong lmul:2;
+#else
+    target_ulong lmul:2;
+    target_ulong sew:3;
+    target_ulong reserved:sizeof(target_ulong) * 8 - 7;
+    target_ulong vill:1;
+#endif
+};
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Do not use bit fields to describe target register layout.
Use FIELD().
</pre>
    </blockquote>
    OK. I think there is no need to the handle endianess here.  FIELD()
    is good.<br>
    <br>
    <blockquote type="cite"
      cite="mid:94fd7ef0-3ee7-d836-3feb-00a8b93ab585@linaro.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-#define TB_FLAGS_MMU_MASK   3
-#define TB_FLAGS_MSTATUS_FS MSTATUS_FS
+typedef CPURISCVState CPUArchState;
+typedef RISCVCPU ArchCPU;
+#include "exec/cpu-all.h"
+
+FIELD(TB_FLAGS, MMU, 0, 2)
+FIELD(TB_FLAGS, FS, 13, 2)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The change to use FIELD for MMU and FS should be made separately from adding
the vector state.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+FIELD(TB_FLAGS, VL_EQ_VLMAX, 16, 1)
+FIELD(TB_FLAGS, LMUL, 17, 2)
+FIELD(TB_FLAGS, SEW, 19, 3)
+FIELD(TB_FLAGS, VILL, 22, 1)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Why are you leaving holes in TB_FLAGS?  I know why the original hole was there,
since it corresponded to simple masks on other registers.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    vlmax = (1 &lt;&lt; vtype-&gt;lmul) * cpu-&gt;cfg.vlen / (8 * (1 &lt;&lt; vtype-&gt;sew));
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Wow, this can be simplified a lot.

   (1 &lt;&lt; LMUL) * VLEN / (8 * (1 &lt;&lt; SEW))
 = (VLEN &lt;&lt; LMUL) / (8 &lt;&lt; SEW)
 = (VLEN &lt;&lt; LMUL) &gt;&gt; (SEW + 3)
 = VLEN &gt;&gt; (SEW + 3 - LMUL)

</pre>
    </blockquote>
    Good.<br>
    <blockquote type="cite"
      cite="mid:94fd7ef0-3ee7-d836-3feb-00a8b93ab585@linaro.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    vl_eq_vlmax = (env-&gt;vext.vstart == 0) &amp;&amp; (vlmax == env-&gt;vext.vl);
+
+    flags = FIELD_DP32(flags, TB_FLAGS, VILL, vtype-&gt;vill);
+    flags = FIELD_DP32(flags, TB_FLAGS, SEW, vtype-&gt;sew);
+    flags = FIELD_DP32(flags, TB_FLAGS, LMUL, vtype-&gt;lmul);
+    flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I wonder if perhaps this all ought to be nested under

  if (env-&gt;misa &amp; RVV) {
      ...
  } else {
      flag = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
  }

so that, for the normal case when RVV is disabled, we don't bother computing
all of those bits.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
+{
+    TCGv s1, s2, d;
+    d = tcg_temp_new();
+    s1 = tcg_temp_new();
+    s2 = tcg_temp_new();
+    gen_get_gpr(s1, a-&gt;rs1);
+    gen_get_gpr(s2, a-&gt;rs2);
+    gen_helper_vector_vsetvli(d, cpu_env, s1, s2);
+    tcg_gen_st_tl(d, cpu_env, offsetof(CPURISCVState, vext.vl));
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Why are you performing the store to vl inline, as opposed to within the helper
funtion?

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    exit_tb(ctx);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
A normal exit is correct for vsetvl, because the new state is variable.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
+{
+    TCGv s1, s2, d;
+    d = tcg_temp_new();
+    s1 = tcg_temp_new();
+    s2 = tcg_const_tl(a-&gt;zimm);
+    gen_get_gpr(s1, a-&gt;rs1);
+    gen_helper_vector_vsetvli(d, cpu_env, s1, s2);
+    tcg_gen_st_tl(d, cpu_env, offsetof(CPURISCVState, vext.vl));
+    exit_tb(ctx);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
You could use

  gen_goto_tb(ctx, 0, ctx-&gt;base.pc_next)

here, because the new state is unknown but constant.  It will be the same every
time the instruction is executed, and thus can compute the new state only once,
saving that computation in the link to the next tb.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+target_ulong VECTOR_HELPER(vsetvli)(CPURISCVState *env, target_ulong s1,
+    target_ulong s2)
+{
+    int vlmax, vl;
+    RISCVCPU *cpu = env_archcpu(env);
+    struct VTYPE *vtype = (struct VTYPE *)&amp;s2;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
FIELD_EX64 for all uses of VTYPE.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
+    if (vtype-&gt;sew &gt; cpu-&gt;cfg.elen) { /* only set vill bit. */
+        env-&gt;vext.vtype = ~((target_ulong)-1 &gt;&gt; 1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
FIELD_DP64.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    vlmax = (1 &lt;&lt; vtype-&gt;lmul) * cpu-&gt;cfg.vlen / (8 * (1 &lt;&lt; vtype-&gt;sew));
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Same simplification as before.  Perhaps extract this to an inline function for
clarity, documenting the algebraic simplification only once.
</pre>
    </blockquote>
    <blockquote type="cite"
      cite="mid:94fd7ef0-3ee7-d836-3feb-00a8b93ab585@linaro.org">
      <pre class="moz-quote-pre" wrap="">

r~</pre>
    </blockquote>
    Best Regards,<br>
    Zhiwei<br>
    <blockquote type="cite"
      cite="mid:94fd7ef0-3ee7-d836-3feb-00a8b93ab585@linaro.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------8D66D43FB19310A341D75560--

