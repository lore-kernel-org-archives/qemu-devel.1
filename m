Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD7FC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 13:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA95206E6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 13:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA95206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIBiB-0002ec-HA
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 09:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIBhK-000260-DI
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 09:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIBhH-0008SN-KY
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 09:40:25 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jIBhG-0008LG-By; Sat, 28 Mar 2020 09:40:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0760825|-1; BR=01201311R201ec; CH=green;
 DM=|CONTINUE|false|; DS=SPAM|spam_ad|0.89338-0.000160426-0.106459;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03278; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H6gzWJ5_1585402810; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H6gzWJ5_1585402810)
 by smtp.aliyun-inc.com(10.147.44.145);
 Sat, 28 Mar 2020 21:40:11 +0800
Subject: Re: [PATCH v6 58/61] target/riscv: vector slide instructions
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-59-zhiwei_liu@c-sky.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <b9b0393a-4be4-6f23-6cd7-a44b3c8a5b9a@c-sky.com>
Date: Sat, 28 Mar 2020 21:40:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-59-zhiwei_liu@c-sky.com>
Content-Type: multipart/alternative;
 boundary="------------639803C6FE5626DE060B0306"
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
--------------639803C6FE5626DE060B0306
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/3/17 23:06, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>   target/riscv/helper.h                   |  17 ++++
>   target/riscv/insn32.decode              |   7 ++
>   target/riscv/insn_trans/trans_rvv.inc.c |  17 ++++
>   target/riscv/vector_helper.c            | 128 ++++++++++++++++++++++++
>   4 files changed, 169 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 044538aef9..3b1612012c 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1118,3 +1118,20 @@ DEF_HELPER_3(vmv_s_x_d, void, ptr, tl, env)
>   DEF_HELPER_3(vfmv_s_f_h, void, ptr, i64, env)
>   DEF_HELPER_3(vfmv_s_f_w, void, ptr, i64, env)
>   DEF_HELPER_3(vfmv_s_f_d, void, ptr, i64, env)
> +
> +DEF_HELPER_6(vslideup_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslideup_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslideup_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslideup_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslidedown_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslidedown_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslidedown_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslidedown_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 79f9b37b29..34ccad53a9 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -72,6 +72,7 @@
>   @r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
>   @r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
>   @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
> +@r2rd    .......   ..... ..... ... ..... ....... %rs2 %rd
>   @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
>   @r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
>   @r_vm_0  ...... . ..... ..... ... ..... .......    &rmrr vm=0 %rs2 %rs1 %rd
> @@ -565,6 +566,12 @@ vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
>   vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
>   vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
>   vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
> +vslideup_vx     001110 . ..... ..... 100 ..... 1010111 @r_vm
> +vslideup_vi     001110 . ..... ..... 011 ..... 1010111 @r_vm
> +vslide1up_vx    001110 . ..... ..... 110 ..... 1010111 @r_vm
> +vslidedown_vx   001111 . ..... ..... 100 ..... 1010111 @r_vm
> +vslidedown_vi   001111 . ..... ..... 011 ..... 1010111 @r_vm
> +vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
>   
>   vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>   vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 07033662c3..10482fd1d4 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2536,3 +2536,20 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
>       }
>       return false;
>   }
> +
> +/* Vector Slide Instructions */
> +static bool slideup_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            (a->rd != a->rs2));
> +}
> +GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
> +GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
> +GEN_OPIVI_TRANS(vslideup_vi, 1, vslideup_vx, slideup_check)
> +
> +GEN_OPIVX_TRANS(vslidedown_vx, opivx_check)
> +GEN_OPIVX_TRANS(vslide1down_vx, opivx_check)
> +GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, opivx_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 723e15a670..b0439ac3d1 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4706,3 +4706,131 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env)            \
>   GEN_VEXT_VFMV_S_F(vfmv_s_f_h, uint16_t, H2, clearh)
>   GEN_VEXT_VFMV_S_F(vfmv_s_f_w, uint32_t, H4, clearl)
>   GEN_VEXT_VFMV_S_F(vfmv_s_f_d, uint64_t, H8, clearq)
> +
> +/* Vector Slide Instructions */
> +#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                    \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
> +        CPURISCVState *env, uint32_t desc)                                \
> +{                                                                         \
> +    uint32_t mlen = vext_mlen(desc);                                      \
> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
> +    uint32_t vm = vext_vm(desc);                                          \
> +    uint32_t vl = env->vl;                                                \
> +    target_ulong offset = s1, i;                                          \
> +                                                                          \
> +    if (vl == 0) {                                                        \
> +        return;                                                           \
> +    }                                                                     \
> +    for (i = offset; i < vl; i++) {                                       \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
> +            continue;                                                     \
> +        }                                                                 \
> +        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
> +    }                                                                     \
> +    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
> +}
> +
> +/* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
> +GEN_VEXT_VSLIDEUP_VX(vslideup_vx_b, uint8_t, H1, clearb)
> +GEN_VEXT_VSLIDEUP_VX(vslideup_vx_h, uint16_t, H2, clearh)
> +GEN_VEXT_VSLIDEUP_VX(vslideup_vx_w, uint32_t, H4, clearl)
> +GEN_VEXT_VSLIDEUP_VX(vslideup_vx_d, uint64_t, H8, clearq)
> +
> +#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
> +        CPURISCVState *env, uint32_t desc)                                \
> +{                                                                         \
> +    uint32_t mlen = vext_mlen(desc);                                      \
> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
> +    uint32_t vm = vext_vm(desc);                                          \
> +    uint32_t vl = env->vl;                                                \
> +    target_ulong offset = s1, i, max;                                     \
> +                                                                          \
> +    if (vl == 0) {                                                        \
> +        return;                                                           \
> +    }                                                                     \
> +    if (offset >= vlmax) {                                                \
> +        max = 0;                                                          \
> +    } else {                                                              \
> +        max = MIN(vl, vlmax - offset);                                    \
> +    }                                                                     \
> +    for (i = 0; i < max; ++i) {                                           \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
> +            continue;                                                     \
> +        }                                                                 \
> +        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + offset));          \
> +    }                                                                     \
> +    CLEAR_FN(vd, max, max * sizeof(ETYPE), vlmax * sizeof(ETYPE));        \
> +}
> +
There is a mistake when vlmax - offset < vl.

The elements between (vlmax - offset) and vl should  be 
unchanged(masked) or zeroed(unmasked).
However, in this implementation, these elements are always zeroed.

I will fix it in v7 like

#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         CPURISCVState *env, uint32_t desc)                                \
{                                                                         \
     uint32_t mlen = vext_mlen(desc);                                      \
     uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     target_ulong offset = s1, i;                                          \
                                                                           \
     if (vl == 0) {                                                        \
         return;                                                           \
     }                                                                     \
     for (i = 0; i < vl; ++i) {                                            \
         target_ulong j = i + offset;                                      \
         if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = j >= vlmax ? 0 : *((ETYPE *)vs2 + H(j));  \
     }                                                                     \
     CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
}

Zhiwei
> +/* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
> +GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_b, uint8_t, H1, clearb)
> +GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_h, uint16_t, H2, clearh)
> +GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_w, uint32_t, H4, clearl)
> +GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_d, uint64_t, H8, clearq)
> +
> +#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H, CLEAR_FN)                   \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
> +        CPURISCVState *env, uint32_t desc)                                \
> +{                                                                         \
> +    uint32_t mlen = vext_mlen(desc);                                      \
> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
> +    uint32_t vm = vext_vm(desc);                                          \
> +    uint32_t vl = env->vl;                                                \
> +    uint32_t i;                                                           \
> +                                                                          \
> +    if (vl == 0) {                                                        \
> +        return;                                                           \
> +    }                                                                     \
> +    for (i = 0; i < vl; i++) {                                            \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
> +            continue;                                                     \
> +        }                                                                 \
> +        if (i == 0) {                                                     \
> +            *((ETYPE *)vd + H(i)) = s1;                                   \
> +        } else {                                                          \
> +            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
> +        }                                                                 \
> +    }                                                                     \
> +    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
> +}
> +
> +/* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
> +GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_b, uint8_t, H1, clearb)
> +GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_h, uint16_t, H2, clearh)
> +GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_w, uint32_t, H4, clearl)
> +GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_d, uint64_t, H8, clearq)
> +
> +#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H, CLEAR_FN)                 \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
> +        CPURISCVState *env, uint32_t desc)                                \
> +{                                                                         \
> +    uint32_t mlen = vext_mlen(desc);                                      \
> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
> +    uint32_t vm = vext_vm(desc);                                          \
> +    uint32_t vl = env->vl;                                                \
> +    uint32_t i;                                                           \
> +                                                                          \
> +    if (vl == 0) {                                                        \
> +        return;                                                           \
> +    }                                                                     \
> +    for (i = 0; i < vl; i++) {                                            \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
> +            continue;                                                     \
> +        }                                                                 \
> +        if (i == vl - 1) {                                                \
> +            *((ETYPE *)vd + H(i)) = s1;                                   \
> +        } else {                                                          \
> +            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));           \
> +        }                                                                 \
> +    }                                                                     \
> +    if (i == 0) {                                                         \
> +        return;                                                           \
> +    }                                                                     \
> +    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
> +}
> +/* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
> +GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t, H1, clearb)
> +GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2, clearh)
> +GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4, clearl)
> +GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)


--------------639803C6FE5626DE060B0306
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/3/17 23:06, LIU Zhiwei wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20200317150653.9008-59-zhiwei_liu@c-sky.com">
      <pre class="moz-quote-pre" wrap="">Signed-off-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com">&lt;zhiwei_liu@c-sky.com&gt;</a>
---
 target/riscv/helper.h                   |  17 ++++
 target/riscv/insn32.decode              |   7 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  17 ++++
 target/riscv/vector_helper.c            | 128 ++++++++++++++++++++++++
 4 files changed, 169 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 044538aef9..3b1612012c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1118,3 +1118,20 @@ DEF_HELPER_3(vmv_s_x_d, void, ptr, tl, env)
 DEF_HELPER_3(vfmv_s_f_h, void, ptr, i64, env)
 DEF_HELPER_3(vfmv_s_f_w, void, ptr, i64, env)
 DEF_HELPER_3(vfmv_s_f_d, void, ptr, i64, env)
+
+DEF_HELPER_6(vslideup_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslideup_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslideup_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslideup_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslidedown_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslidedown_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslidedown_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslidedown_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 79f9b37b29..34ccad53a9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -72,6 +72,7 @@
 @r2_vm   ...... vm:1 ..... ..... ... ..... ....... &amp;rmr %rs2 %rd
 @r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &amp;rnfvm %nf %rs2 %rs1 %rd
+@r2rd    .......   ..... ..... ... ..... ....... %rs2 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &amp;rmrr %rs2 %rs1 %rd
 @r_vm_1  ...... . ..... ..... ... ..... .......    &amp;rmrr vm=1 %rs2 %rs1 %rd
 @r_vm_0  ...... . ..... ..... ... ..... .......    &amp;rmrr vm=0 %rs2 %rs1 %rd
@@ -565,6 +566,12 @@ vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
 vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
+vslideup_vx     001110 . ..... ..... 100 ..... 1010111 @r_vm
+vslideup_vi     001110 . ..... ..... 011 ..... 1010111 @r_vm
+vslide1up_vx    001110 . ..... ..... 110 ..... 1010111 @r_vm
+vslidedown_vx   001111 . ..... ..... 100 ..... 1010111 @r_vm
+vslidedown_vi   001111 . ..... ..... 011 ..... 1010111 @r_vm
+vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 07033662c3..10482fd1d4 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2536,3 +2536,20 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
     }
     return false;
 }
+
+/* Vector Slide Instructions */
+static bool slideup_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &amp;&amp;
+            vext_check_overlap_mask(s, a-&gt;rd, a-&gt;vm, true) &amp;&amp;
+            vext_check_reg(s, a-&gt;rd, false) &amp;&amp;
+            vext_check_reg(s, a-&gt;rs2, false) &amp;&amp;
+            (a-&gt;rd != a-&gt;rs2));
+}
+GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
+GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
+GEN_OPIVI_TRANS(vslideup_vi, 1, vslideup_vx, slideup_check)
+
+GEN_OPIVX_TRANS(vslidedown_vx, opivx_check)
+GEN_OPIVX_TRANS(vslide1down_vx, opivx_check)
+GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 723e15a670..b0439ac3d1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4706,3 +4706,131 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env)            \
 GEN_VEXT_VFMV_S_F(vfmv_s_f_h, uint16_t, H2, clearh)
 GEN_VEXT_VFMV_S_F(vfmv_s_f_w, uint32_t, H4, clearl)
 GEN_VEXT_VFMV_S_F(vfmv_s_f_d, uint64_t, H8, clearq)
+
+/* Vector Slide Instructions */
+#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)-&gt;cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env-&gt;vl;                                                \
+    target_ulong offset = s1, i;                                          \
+                                                                          \
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
+    for (i = offset; i &lt; vl; i++) {                                       \
+        if (!vm &amp;&amp; !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+/* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_d, uint64_t, H8, clearq)
+
+#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)-&gt;cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env-&gt;vl;                                                \
+    target_ulong offset = s1, i, max;                                     \
+                                                                          \
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
+    if (offset &gt;= vlmax) {                                                \
+        max = 0;                                                          \
+    } else {                                                              \
+        max = MIN(vl, vlmax - offset);                                    \
+    }                                                                     \
+    for (i = 0; i &lt; max; ++i) {                                           \
+        if (!vm &amp;&amp; !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + offset));          \
+    }                                                                     \
+    CLEAR_FN(vd, max, max * sizeof(ETYPE), vlmax * sizeof(ETYPE));        \
+}
+</pre>
    </blockquote>
    There is a mistake when vlmax - offset &lt; vl. <br>
    <br>
    The elements between (vlmax - offset) and vl should  be
    unchanged(masked) or zeroed(unmasked).<br>
    However, in this implementation, these elements are always zeroed.<br>
    <br>
    I will fix it in v7 like<br>
    <pre>#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
        CPURISCVState *env, uint32_t desc)                                \
{                                                                         \
    uint32_t mlen = vext_mlen(desc);                                      \
    uint32_t vlmax = env_archcpu(env)-&gt;cfg.vlen / mlen;                   \
    uint32_t vm = vext_vm(desc);                                          \
    uint32_t vl = env-&gt;vl;                                                \
    target_ulong offset = s1, i;                                          \
                                                                          \
    if (vl == 0) {                                                        \
        return;                                                           \
    }                                                                     \
    for (i = 0; i &lt; vl; ++i) {                                            \
        target_ulong j = i + offset;                                      \
        if (!vm &amp;&amp; !vext_elem_mask(v0, mlen, i)) {                        \
            continue;                                                     \
        }                                                                 \
        *((ETYPE *)vd + H(i)) = j &gt;= vlmax ? 0 : *((ETYPE *)vs2 + H(j));  \
    }                                                                     \
    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
}

</pre>
    Zhiwei<br>
    <blockquote type="cite"
      cite="mid:20200317150653.9008-59-zhiwei_liu@c-sky.com">
      <pre class="moz-quote-pre" wrap="">
+/* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_d, uint64_t, H8, clearq)
+
+#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H, CLEAR_FN)                   \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)-&gt;cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env-&gt;vl;                                                \
+    uint32_t i;                                                           \
+                                                                          \
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
+    for (i = 0; i &lt; vl; i++) {                                            \
+        if (!vm &amp;&amp; !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        if (i == 0) {                                                     \
+            *((ETYPE *)vd + H(i)) = s1;                                   \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
+        }                                                                 \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+/* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_d, uint64_t, H8, clearq)
+
+#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H, CLEAR_FN)                 \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
+        CPURISCVState *env, uint32_t desc)                                \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)-&gt;cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env-&gt;vl;                                                \
+    uint32_t i;                                                           \
+                                                                          \
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
+    for (i = 0; i &lt; vl; i++) {                                            \
+        if (!vm &amp;&amp; !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        if (i == vl - 1) {                                                \
+            *((ETYPE *)vd + H(i)) = s1;                                   \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));           \
+        }                                                                 \
+    }                                                                     \
+    if (i == 0) {                                                         \
+        return;                                                           \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+/* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t, H1, clearb)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2, clearh)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4, clearl)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------639803C6FE5626DE060B0306--

