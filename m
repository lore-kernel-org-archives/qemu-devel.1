Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A2C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F58420736
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F58420736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGIAo-0003uk-L9
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jGIAA-00039f-96
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jGIA7-0005BJ-O2
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:10:21 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58465)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jGIA6-00051Y-R0; Mon, 23 Mar 2020 04:10:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0760844|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.794627-0.00125244-0.204121;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03297; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H3tu-Zx_1584951008; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H3tu-Zx_1584951008)
 by smtp.aliyun-inc.com(10.147.40.233);
 Mon, 23 Mar 2020 16:10:09 +0800
Subject: Re: [PATCH v5 09/60] target/riscv: vector single-width integer add
 and subtract
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-10-zhiwei_liu@c-sky.com>
 <49490839-077a-5bb6-c56e-95298c5ef74f@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <f742e1d1-05ba-f051-a2bb-d8da15e7e947@c-sky.com>
Date: Mon, 23 Mar 2020 16:10:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <49490839-077a-5bb6-c56e-95298c5ef74f@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------B9E4F2AB57269D21D3B90957"
Content-Language: en-US
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------B9E4F2AB57269D21D3B90957
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/3/14 13:25, Richard Henderson wrote:
> On 3/12/20 7:58 AM, LIU Zhiwei wrote:
>> +    if (a->vm && s->vl_eq_vlmax) {                                 \
>> +        tcg_gen_gvec_##GVSUF(8 << s->sew, vreg_ofs(s, a->rd),      \
>> +            vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),              \
>> +            MAXSZ(s), MAXSZ(s));                                   \
> The first argument here should be just s->sew.
> You should have see the assert fire:
>
>      tcg_debug_assert(vece <= MO_64);
>
> It would be nice to pull out the bulk of GEN_OPIVV_GVEC_TRANS as a function,
> and pass in tcg_gen_gvec_* as a function pointer, and fns as a pointer.
>
> In general, I prefer the functions that are generated by macros like this to
> have exactly one executable statement -- the call to the helper that does all
> of the work using the arguments provided.  That way a maximum number of lines
> are available for stepping with the debugger.
>
>> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);                        \
>> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                            \
>> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                        \
> Why are these replicated in each trans_* function, and not done in opiv?_trans,
> where the rest of the descriptor is created?
>
>> +/* OPIVX without GVEC IR */
>> +#define GEN_OPIVX_TRANS(NAME, CHECK)                                     \
>> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
>> +{                                                                        \
>> +    if (CHECK(s, a)) {                                                   \
>> +        uint32_t data = 0;                                               \
>> +        static gen_helper_opivx const fns[4] = {                         \
>> +            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                \
>> +            gen_helper_##NAME##_w, gen_helper_##NAME##_d,                \
>> +        };                                                               \
>> +                                                                         \
>> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);                   \
>> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                       \
>> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                   \
>> +        return opivx_trans(a->rd, a->rs1, a->rs2, data, fns[s->sew], s); \
>> +    }                                                                    \
>> +    return false;                                                        \
>> +}
>> +
>> +GEN_OPIVX_TRANS(vrsub_vx, opivx_check)
> Note that you *can* generate vector code for this,
> you just have to write your own helpers.
>
> E.g.
>
> static void gen_vec_rsub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 a)
> {
>      tcg_gen_vec_sub8_i64(d, b, a);
> }
> // etc, reversing the arguments and passing on to sub.
>
> static const GVecGen2s rsub_op[4] = {
>      { .fni8 = tcg_gen_vec_rsub8_i64,
>        .fniv = tcg_gen_rsub_vec,
>        .fno = gen_helper_gvec_rsubs8,
>        .opt_opc = vecop_list_sub,
>        .vece = MO_8 },
>      { .fni8 = tcg_gen_vec_rsub16_i64,
>        .fniv = tcg_gen_rsub_vec,
>        .fno = gen_helper_gvec_rsubs16,
>        .opt_opc = vecop_list_sub,
>        .vece = MO_16 },
>      { .fni4 = tcg_gen_rsub_i32,
>        .fniv = tcg_gen_rsub_vec,
>        .fno = gen_helper_gvec_rsubs32,
>        .opt_opc = vecop_list_sub,
>        .vece = MO_32 },
>      { .fni8 = tcg_gen_rsub_i64,
>        .fniv = tcg_gen_rsub_vec,
>        .fno = gen_helper_gvec_rsubs64,
>        .opt_opc = vecop_list_sub,
>        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
>        .vece = MO_64 },
> };
>
> static void gen_gvec_rsubs(unsigned vece, uint32_t dofs,
>      uint32_t aofs, TCGv_i64 c,
>      uint32_t oprsz, uint32_t maxsz)
> {
>      tcg_debug_assert(vece <= MO_64);
>      tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &rsub_op[vece]);
> }
>
> static void gen_gvec_rsubi(unsigned vece, uint32_t dofs,
>      uint32_t aofs, int64_t c,
>      uint32_t oprsz, uint32_t maxsz)
> {
>      tcg_debug_assert(vece <= MO_64);
>      tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, c, &rsub_op[vece]);
> }
Hi Richard,

When I try to add GVEC IR rsubs，I find it is some difficult to keep it 
separate from tcg-runtime-gvec.c.

The .fno functions, e.g.,  gen_helper_gvec_rsubs8 need to be defined like

    void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)

    {

         intptr_t oprsz = simd_oprsz(desc);

         vec8 vecb = (vec8)DUP16(b);

         intptr_t i;

         for (i = 0; i < oprsz; i += sizeof(vec8)) {

             *(vec8 *)(d + i) = vecb - *(vec8 *)(a + i);

         }

         clear_high(d, oprsz, desc);

    }


The vec8 and DUP are defined in tcg-runtime-gvec.c.

Should I declare them  in somewhere else, or just put HELPER(gvec_subs8) 
into tcg-runtime-gvec.c?

Zhiwei

>> +/* generate the helpers for OPIVV */
>> +#define GEN_VEXT_VV(NAME, ESZ, DSZ, CLEAR_FN)             \
>> +void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>> +        void *vs2, CPURISCVState *env, uint32_t desc)     \
>> +{                                                         \
>> +    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
>> +    uint32_t mlen = vext_mlen(desc);                      \
>> +    uint32_t vm = vext_vm(desc);                          \
>> +    uint32_t vl = env->vl;                                \
>> +    uint32_t i;                                           \
>> +    for (i = 0; i < vl; i++) {                            \
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
>> +            continue;                                     \
>> +        }                                                 \
>> +        do_##NAME(vd, vs1, vs2, i);                       \
>> +    }                                                     \
>> +    if (i != 0) {                                         \
>> +        CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);         \
>> +    }                                                     \
>> +}
>> +
>> +GEN_VEXT_VV(vadd_vv_b, 1, 1, clearb)
>> +GEN_VEXT_VV(vadd_vv_h, 2, 2, clearh)
>> +GEN_VEXT_VV(vadd_vv_w, 4, 4, clearl)
>> +GEN_VEXT_VV(vadd_vv_d, 8, 8, clearq)
>> +GEN_VEXT_VV(vsub_vv_b, 1, 1, clearb)
>> +GEN_VEXT_VV(vsub_vv_h, 2, 2, clearh)
>> +GEN_VEXT_VV(vsub_vv_w, 4, 4, clearl)
>> +GEN_VEXT_VV(vsub_vv_d, 8, 8, clearq)
> The body of GEN_VEXT_VV can be an inline function, calling the helper functions
> that you generated above.
>
>> +/*
>> + * If XLEN < SEW, the value from the x register is sign-extended to SEW bits.
>> + * So (target_long)s1 is need. (T1)(target_long)s1 gives the real operator type.
>> + * (TX1)(T1)(target_long)s1 expands the operator type of widen operations
>> + * or narrow operations
>> + */
>> +#define OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
>> +static void do_##NAME(void *vd, target_ulong s1, void *vs2, int i)  \
>> +{                                                                   \
>> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
>> +    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)(target_long)s1);         \
>> +}
> Why not just make the type of s1 be target_long in the parameter?
>
>> +/* generate the helpers for instructions with one vector and one sclar */
>> +#define GEN_VEXT_VX(NAME, ESZ, DSZ, CLEAR_FN)             \
>> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
>> +        void *vs2, CPURISCVState *env, uint32_t desc)     \
>> +{                                                         \
>> +    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
>> +    uint32_t mlen = vext_mlen(desc);                      \
>> +    uint32_t vm = vext_vm(desc);                          \
>> +    uint32_t vl = env->vl;                                \
>> +    uint32_t i;                                           \
>> +                                                          \
>> +    for (i = 0; i < vl; i++) {                            \
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
>> +            continue;                                     \
>> +        }                                                 \
>> +        do_##NAME(vd, s1, vs2, i);                        \
>> +    }                                                     \
>> +    if (i != 0) {                                         \
>> +        CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);         \
>> +    }                                                     \
>> +}
> Likewise an inline function.
>
>
> r~


--------------B9E4F2AB57269D21D3B90957
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/3/14 13:25, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:49490839-077a-5bb6-c56e-95298c5ef74f@linaro.org">
      <pre class="moz-quote-pre" wrap="">On 3/12/20 7:58 AM, LIU Zhiwei wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    if (a-&gt;vm &amp;&amp; s-&gt;vl_eq_vlmax) {                                 \
+        tcg_gen_gvec_##GVSUF(8 &lt;&lt; s-&gt;sew, vreg_ofs(s, a-&gt;rd),      \
+            vreg_ofs(s, a-&gt;rs2), vreg_ofs(s, a-&gt;rs1),              \
+            MAXSZ(s), MAXSZ(s));                                   \
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The first argument here should be just s-&gt;sew.
You should have see the assert fire:

    tcg_debug_assert(vece &lt;= MO_64);

It would be nice to pull out the bulk of GEN_OPIVV_GVEC_TRANS as a function,
and pass in tcg_gen_gvec_* as a function pointer, and fns as a pointer.

In general, I prefer the functions that are generated by macros like this to
have exactly one executable statement -- the call to the helper that does all
of the work using the arguments provided.  That way a maximum number of lines
are available for stepping with the debugger.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+        data = FIELD_DP32(data, VDATA, MLEN, s-&gt;mlen);                        \
+        data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                            \
+        data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);                        \
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Why are these replicated in each trans_* function, and not done in opiv?_trans,
where the rest of the descriptor is created?

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+/* OPIVX without GVEC IR */
+#define GEN_OPIVX_TRANS(NAME, CHECK)                                     \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (CHECK(s, a)) {                                                   \
+        uint32_t data = 0;                                               \
+        static gen_helper_opivx const fns[4] = {                         \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,                \
+        };                                                               \
+                                                                         \
+        data = FIELD_DP32(data, VDATA, MLEN, s-&gt;mlen);                   \
+        data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                       \
+        data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);                   \
+        return opivx_trans(a-&gt;rd, a-&gt;rs1, a-&gt;rs2, data, fns[s-&gt;sew], s); \
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_OPIVX_TRANS(vrsub_vx, opivx_check)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Note that you *can* generate vector code for this,
you just have to write your own helpers.

E.g.

static void gen_vec_rsub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 a)
{
    tcg_gen_vec_sub8_i64(d, b, a);
}
// etc, reversing the arguments and passing on to sub.

static const GVecGen2s rsub_op[4] = {
    { .fni8 = tcg_gen_vec_rsub8_i64,
      .fniv = tcg_gen_rsub_vec,
      .fno = gen_helper_gvec_rsubs8,
      .opt_opc = vecop_list_sub,
      .vece = MO_8 },
    { .fni8 = tcg_gen_vec_rsub16_i64,
      .fniv = tcg_gen_rsub_vec,
      .fno = gen_helper_gvec_rsubs16,
      .opt_opc = vecop_list_sub,
      .vece = MO_16 },
    { .fni4 = tcg_gen_rsub_i32,
      .fniv = tcg_gen_rsub_vec,
      .fno = gen_helper_gvec_rsubs32,
      .opt_opc = vecop_list_sub,
      .vece = MO_32 },
    { .fni8 = tcg_gen_rsub_i64,
      .fniv = tcg_gen_rsub_vec,
      .fno = gen_helper_gvec_rsubs64,
      .opt_opc = vecop_list_sub,
      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
      .vece = MO_64 },
};

static void gen_gvec_rsubs(unsigned vece, uint32_t dofs,
    uint32_t aofs, TCGv_i64 c,
    uint32_t oprsz, uint32_t maxsz)
{
    tcg_debug_assert(vece &lt;= MO_64);
    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &amp;rsub_op[vece]);
}

static void gen_gvec_rsubi(unsigned vece, uint32_t dofs,
    uint32_t aofs, int64_t c,
    uint32_t oprsz, uint32_t maxsz)
{
    tcg_debug_assert(vece &lt;= MO_64);
    tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, c, &amp;rsub_op[vece]);
}
</pre>
    </blockquote>
    Hi Richard,<br>
    <br>
    When I try to add GVEC IR rsubs，I find it is some difficult to keep
    it separate from tcg-runtime-gvec.c.<br>
    <br>
    The .fno functions, e.g.,  gen_helper_gvec_rsubs8 
    need to be defined like<br>
    <br>
    <blockquote>
      <pre>void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)</pre>
      <pre>{</pre>
      <pre>    intptr_t oprsz = simd_oprsz(desc);</pre>
      <pre>    vec8 vecb = (vec8)DUP16(b);</pre>
      <pre>    intptr_t i;</pre>
      <pre>
    for (i = 0; i &lt; oprsz; i += sizeof(vec8)) {</pre>
      <pre>        *(vec8 *)(d + i) = vecb - *(vec8 *)(a + i);</pre>
      <pre>    }</pre>
      <pre>    clear_high(d, oprsz, desc);</pre>
      <pre>}</pre>
    </blockquote>
        <br>
    The vec8 and DUP are defined in tcg-runtime-gvec.c.  <br>
    <br>
    Should I declare them  in somewhere else, or just put
    HELPER(gvec_subs8) into tcg-runtime-gvec.c?<br>
    <br>
    Zhiwei<br>
    <br>
    <blockquote type="cite"
      cite="mid:49490839-077a-5bb6-c56e-95298c5ef74f@linaro.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+/* generate the helpers for OPIVV */
+#define GEN_VEXT_VV(NAME, ESZ, DSZ, CLEAR_FN)             \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
+        void *vs2, CPURISCVState *env, uint32_t desc)     \
+{                                                         \
+    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
+    uint32_t mlen = vext_mlen(desc);                      \
+    uint32_t vm = vext_vm(desc);                          \
+    uint32_t vl = env-&gt;vl;                                \
+    uint32_t i;                                           \
+    for (i = 0; i &lt; vl; i++) {                            \
+        if (!vm &amp;&amp; !vext_elem_mask(v0, mlen, i)) {        \
+            continue;                                     \
+        }                                                 \
+        do_##NAME(vd, vs1, vs2, i);                       \
+    }                                                     \
+    if (i != 0) {                                         \
+        CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);         \
+    }                                                     \
+}
+
+GEN_VEXT_VV(vadd_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vadd_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vsub_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vsub_vv_d, 8, 8, clearq)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The body of GEN_VEXT_VV can be an inline function, calling the helper functions
that you generated above.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+/*
+ * If XLEN &lt; SEW, the value from the x register is sign-extended to SEW bits.
+ * So (target_long)s1 is need. (T1)(target_long)s1 gives the real operator type.
+ * (TX1)(T1)(target_long)s1 expands the operator type of widen operations
+ * or narrow operations
+ */
+#define OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
+static void do_##NAME(void *vd, target_ulong s1, void *vs2, int i)  \
+{                                                                   \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)(target_long)s1);         \
+}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Why not just make the type of s1 be target_long in the parameter?

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+/* generate the helpers for instructions with one vector and one sclar */
+#define GEN_VEXT_VX(NAME, ESZ, DSZ, CLEAR_FN)             \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
+        void *vs2, CPURISCVState *env, uint32_t desc)     \
+{                                                         \
+    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
+    uint32_t mlen = vext_mlen(desc);                      \
+    uint32_t vm = vext_vm(desc);                          \
+    uint32_t vl = env-&gt;vl;                                \
+    uint32_t i;                                           \
+                                                          \
+    for (i = 0; i &lt; vl; i++) {                            \
+        if (!vm &amp;&amp; !vext_elem_mask(v0, mlen, i)) {        \
+            continue;                                     \
+        }                                                 \
+        do_##NAME(vd, s1, vs2, i);                        \
+    }                                                     \
+    if (i != 0) {                                         \
+        CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);         \
+    }                                                     \
+}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Likewise an inline function.


r~
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------B9E4F2AB57269D21D3B90957--

