Return-Path: <SRS0=MlkC=2P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8813CC2D0DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2019 09:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7D820643
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2019 09:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7D820643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ik367-00026l-EQ
	for qemu-devel@archiver.kernel.org; Wed, 25 Dec 2019 04:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1ik35W-0001h7-Ob
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 04:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1ik35U-00005e-O0
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 04:36:18 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1ik35U-0008WL-62
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 04:36:16 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.220315-0.00657933-0.773106;
 DS=CONTINUE|ham_social|0.00983276-0.00084915-0.989318; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01a16368; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.GOmHThH_1577266567; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GOmHThH_1577266567)
 by smtp.aliyun-inc.com(10.147.43.95); Wed, 25 Dec 2019 17:36:07 +0800
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
To: Richard Henderson <richard.henderson@linaro.org>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <ba8c7451-b0a7-0405-f881-0c6d0d8574fb@linaro.org>
 <1b1826c3-50e4-2481-56a2-4ebb01e04498@c-sky.com>
 <fe1a210e-e4cf-f62a-a39f-2818358d53c9@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <ea5d5926-48ba-e204-cad8-7e5260b2e2ee@c-sky.com>
Date: Wed, 25 Dec 2019 17:36:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <fe1a210e-e4cf-f62a-a39f-2818358d53c9@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------4CF8EEA363978DF672D10357"
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
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, qemu-devel@nongnu.org,
 Chih-Min Chao <chihmin.chao@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------4CF8EEA363978DF672D10357
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2019/12/20 4:38, Richard Henderson wrote:
> On 12/18/19 11:11 PM, LIU Zhiwei wrote:
>> I'm sorry that it's really hard to absorb your opinion. I don't know why clang
>> will fail
>>
>> when index beyond the end of vreg[n] into vreg[n+1].
> I thought sure one of the address sanitizer checks would detect array bounds
> overrun.  But it becomes irrelevant
>
>> As Chih-Min Chao said in another part of PATCH V2 thread,  VLEN will be a
>> property which can be
>>
>> specified from command line.  So the sub-struct maybe defined as
>>
>> struct {
>>      union{
>>          uint64_t *u64 ;
>>          int64_t  *s64;
>>          uint32_t *u32;
>>          int32_t  *s32;
>>          uint16_t *u16;
>>          int16_t  *s16;
>>          uint8_t  *u8;
>>          int8_t   *s8;
>>      } mem;
>>      target_ulong vxrm;
>>      target_ulong vxsat;
>>      target_ulong vl;
>>      target_ulong vstart;
>>      target_ulong vtype;
>> } vext;
>>
>> Will that be OK?
> Pointers have consequences.  It can be done, but I don't think it is ideal.
>
>> The (ill, lmul, sew ) of vtype  will be placed within tb_flags, also the bit of
>> (VSTART == 0 && VL == VLMAX).
>>
>> So it will take 8 bits of tb flags for vector extension at least.
> Good.
>> However, I have one problem to support both command line VLEN and vreg_ofs.
>>
>> As in SVE,  vreg ofs is the offset from cpu_env. If the structure of vector
>> extension (to support command line VLEN） is
>>
>> struct {
>>      union{
>>          uint64_t *u64 ;
>>          int64_t  *s64;
>>          uint32_t *u32;
>>          int32_t  *s32;
>>          uint16_t *u16;
>>          int16_t  *s16;
>>          uint8_t  *u8;
>>          int8_t   *s8;
>>      } mem;
>>      target_ulong vxrm;
>>      target_ulong vxsat;
>>      target_ulong vl;
>>      target_ulong vstart;
>>      target_ulong vtype;
>> } vext
>>
>> I can't find the way to get the direct offset of vreg from cpu_env.
>>
>> Maybe I should specify a max VLEN like the way of SVE?
> I think a maximum vlen is best.  A command-line option to adjust vlen is all
> well and good, but there's no reason to have to support vlen=(1<<29).
>
> Oh, and you probably need a minimum vlen of 16 bytes as well, otherwise you
> will run afoul of the assert in tcg-op-gvec.c that requires gvec operations to
> be aligned mod 16.
>
> I think that all you need is
>
>      uint64_t vreg[32 * MAX_VLEN / 8] QEMU_ALIGNED(16);
>
> which gives us
>
> uint32_t vreg_ofs(DisasContext *ctx, int reg)
> {
>      return offsetof(CPURISCVState, vreg) + reg * ctx->vlen;
> }

struct {

         uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
         target_ulong vxrm;
         target_ulong vxsat;
         target_ulong vl;
         target_ulong vstart;
         target_ulong vtype;
     } vext;

Is it OK?

> I don't see the point of a union for vreg.  I don't think you'll find that you
> actually use it at all.

I think I can move most of execution check to translate time like SVE 
now. However, there are still some differences from SVE.

1)cpu_env must be used as a parameter for helper function.

     The helpers need  use env->vext.vl and env->vext.vstart.  Thus it 
will be difficult to use out of line tcg_gen_gvec_ool.

     void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,

                         uint32_t oprsz, uint32_t maxsz, int32_t data,
                         gen_helper_gvec_2 *fn)
     {
         ......
         fn(a0, a1, desc);
          ......
      }
     Maybe I have to write  something similar to tcg_gen_gvec_ool in 
trans_rvv.inc.c.  But it will be redundant.

2）simd_desc is not proper.

     I also need to transfer some members of DisasContext to helpers.

     (Data, Vlmax, Mlen) is my current choice. Vlmax is the num of 
elements of this operation, so it will defined as ctx->lmul * ctx->vlen 
/ ctx->sew;

Data is reserved to expand.  Mlen is mask length for one elment, so it 
will defined as ctx->sew/ctx->lmul. As with Mlen, a active element will

be selected by

    static inline int vext_elem_mask(void *v0, int mlen, int index)
    {
         int idx = (index * mlen) / 8;
         int pos = (index * mlen) % 8;

         return (v0[idx] >> pos) & 0x1;
    }

     So I may have to implement vext_desc instead of use the simd_desc, 
which will be another redundant. Maybe a better way to mask elements?

> You do need to document the element ordering that you're going to use for vreg.
>   I.e. the mapping between the architectural vector register state and the
> emulation state.  You have two choices:
>
> (1) all bytes in host endianness (e.g. target/ppc)
> (2) bytes within each uint64_t in host endianness,
>      but each uint64_t is little-endian (e.g. target/arm).
>
> Both require some fixup when running on a big-endian host.

Yes, I will take (2).


Best Regards,

Zhiwei

>
> r~

--------------4CF8EEA363978DF672D10357
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2019/12/20 4:38, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:fe1a210e-e4cf-f62a-a39f-2818358d53c9@linaro.org">
      <pre class="moz-quote-pre" wrap="">On 12/18/19 11:11 PM, LIU Zhiwei wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">I'm sorry that it's really hard to absorb your opinion. I don't know why clang
will fail

when index beyond the end of vreg[n] into vreg[n+1].
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I thought sure one of the address sanitizer checks would detect array bounds
overrun.  But it becomes irrelevant

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">As Chih-Min Chao said in another part of PATCH V2 thread,  VLEN will be a
property which can be

specified from command line.  So the sub-struct maybe defined as

struct {
    union{
        uint64_t *u64 ;
        int64_t  *s64;
        uint32_t *u32;
        int32_t  *s32;
        uint16_t *u16;
        int16_t  *s16;
        uint8_t  *u8;
        int8_t   *s8;
    } mem;
    target_ulong vxrm;
    target_ulong vxsat;
    target_ulong vl;
    target_ulong vstart;
    target_ulong vtype;
} vext;

Will that be OK?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Pointers have consequences.  It can be done, but I don't think it is ideal.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The (ill, lmul, sew ) of vtype  will be placed within tb_flags, also the bit of
(VSTART == 0 &amp;&amp; VL == VLMAX).

So it will take 8 bits of tb flags for vector extension at least.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Good.
</pre>
    </blockquote>
    <blockquote type="cite"
      cite="mid:fe1a210e-e4cf-f62a-a39f-2818358d53c9@linaro.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">However, I have one problem to support both command line VLEN and vreg_ofs.

As in SVE,  vreg ofs is the offset from cpu_env. If the structure of vector
extension (to support command line VLEN） is

struct {
    union{
        uint64_t *u64 ;
        int64_t  *s64;
        uint32_t *u32;
        int32_t  *s32;
        uint16_t *u16;
        int16_t  *s16;
        uint8_t  *u8;
        int8_t   *s8;
    } mem;
    target_ulong vxrm;
    target_ulong vxsat;
    target_ulong vl;
    target_ulong vstart;
    target_ulong vtype;
} vext

I can't find the way to get the direct offset of vreg from cpu_env.

Maybe I should specify a max VLEN like the way of SVE?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think a maximum vlen is best.  A command-line option to adjust vlen is all
well and good, but there's no reason to have to support vlen=(1&lt;&lt;29).

Oh, and you probably need a minimum vlen of 16 bytes as well, otherwise you
will run afoul of the assert in tcg-op-gvec.c that requires gvec operations to
be aligned mod 16.

I think that all you need is

    uint64_t vreg[32 * MAX_VLEN / 8] QEMU_ALIGNED(16);

which gives us

uint32_t vreg_ofs(DisasContext *ctx, int reg)
{
    return offsetof(CPURISCVState, vreg) + reg * ctx-&gt;vlen;
}
</pre>
    </blockquote>
    <p>struct {</p>
            uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);<br>
            target_ulong vxrm;<br>
            target_ulong vxsat;<br>
            target_ulong vl;<br>
            target_ulong vstart;<br>
            target_ulong vtype;<br>
        } vext;
    <p>Is it OK?</p>
    <blockquote type="cite"
      cite="mid:fe1a210e-e4cf-f62a-a39f-2818358d53c9@linaro.org">
      <pre class="moz-quote-pre" wrap="">
I don't see the point of a union for vreg.  I don't think you'll find that you
actually use it at all.
</pre>
    </blockquote>
    <p>I think I can move most of execution check to translate time like
      SVE now. However, there are still some differences from SVE.</p>
    <p>1)cpu_env must be used as a parameter for helper function. <br>
    </p>
    <p>    The helpers need  use env-&gt;vext.vl and
      env-&gt;vext.vstart.  Thus it will be difficult to use out of line
      tcg_gen_gvec_ool.</p>
    <p>    void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,</p>
                            uint32_t oprsz, uint32_t maxsz, int32_t
    data,<br>
                            gen_helper_gvec_2 *fn)<br>
        {     <br>
            ......<br>
            fn(a0, a1, desc);<br>
             ......<br>
         }<br>
        Maybe I have to write  something similar to tcg_gen_gvec_ool in
    trans_rvv.inc.c.  But it will be redundant.<span style="color:
      rgb(51, 51, 51); font-family: arial; font-size: 13px; font-style:
      normal; font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"></span>
    <p>2）simd_desc is not proper. <br>
    </p>
    <p>    I also need to transfer some members of DisasContext to
      helpers.  <br>
    </p>
    <p>    (Data, Vlmax, Mlen) is my current choice. Vlmax is the num of
      elements of this operation, so it will defined as ctx-&gt;lmul *
      ctx-&gt;vlen / ctx-&gt;sew;</p>
    <p>Data is reserved to expand.  Mlen is mask length for one elment,
      so it will defined as ctx-&gt;sew/ctx-&gt;lmul. As with Mlen, a
      active element will</p>
    be selected by
    <blockquote>
      <p>static inline int vext_elem_mask(void *v0, int mlen, int index)<br>
        {<br>
            int idx = (index * mlen) / 8;<br>
            int pos = (index * mlen) % 8;<br>
        <br>
            return (v0[idx] &gt;&gt; pos) &amp; 0x1;<br>
        }<br>
      </p>
    </blockquote>
    <p>    So I may have to implement vext_desc instead of use the
      simd_desc, which will be another redundant. Maybe a better way to
      mask elements?<br>
    </p>
    <blockquote type="cite"
      cite="mid:fe1a210e-e4cf-f62a-a39f-2818358d53c9@linaro.org">
      <pre class="moz-quote-pre" wrap="">
You do need to document the element ordering that you're going to use for vreg.
 I.e. the mapping between the architectural vector register state and the
emulation state.  You have two choices:

(1) all bytes in host endianness (e.g. target/ppc)
(2) bytes within each uint64_t in host endianness,
    but each uint64_t is little-endian (e.g. target/arm).

Both require some fixup when running on a big-endian host.
</pre>
    </blockquote>
    <p>Yes, I will take (2).</p>
    <p><br>
    </p>
    <p>Best Regards,</p>
    <p>Zhiwei<br>
    </p>
    <blockquote type="cite"
      cite="mid:fe1a210e-e4cf-f62a-a39f-2818358d53c9@linaro.org">
      <pre class="moz-quote-pre" wrap="">

r~
</pre>
    </blockquote>
  </body>
</html>

--------------4CF8EEA363978DF672D10357--

