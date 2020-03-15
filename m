Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E03C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 05:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C78320722
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 05:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C78320722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDLeF-0008CA-Lm
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 01:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDLcw-0007jK-S8
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDLcv-0000Kf-F3
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:15:54 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50731)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jDLcu-0008WV-F4; Sun, 15 Mar 2020 01:15:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07465673|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_alarm|0.559617-0.000340995-0.440042; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03268; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=9; RT=9; SR=0;
 TI=SMTPD_---.H.g-xDz_1584249340; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H.g-xDz_1584249340)
 by smtp.aliyun-inc.com(10.147.40.44); Sun, 15 Mar 2020 13:15:40 +0800
Subject: Re: [PATCH v5 54/60] target/riscv: integer extract instruction
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-55-zhiwei_liu@c-sky.com>
 <de89d8bc-f578-ac42-58f3-4f5822c8fcfb@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <9687510d-ff07-b200-b597-1405b1ff828d@c-sky.com>
Date: Sun, 15 Mar 2020 13:15:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <de89d8bc-f578-ac42-58f3-4f5822c8fcfb@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 2020/3/15 10:53, Richard Henderson wrote:
> On 3/12/20 7:58 AM, LIU Zhiwei wrote:
>> +static bool trans_vext_x_v(DisasContext *s, arg_r *a)
>> +{
>> +    if (vext_check_isa_ill(s, RVV)) {
>> +        TCGv_ptr src2;
>> +        TCGv dest, src1;
>> +        gen_helper_vext_x_v fns[4] = {
>> +            gen_helper_vext_x_v_b, gen_helper_vext_x_v_h,
>> +            gen_helper_vext_x_v_w, gen_helper_vext_x_v_d
>> +        };
>> +
>> +        dest = tcg_temp_new();
>> +        src1 = tcg_temp_new();
>> +        src2 = tcg_temp_new_ptr();
>> +
>> +        gen_get_gpr(src1, a->rs1);
>> +        tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, a->rs2));
>> +
>> +        fns[s->sew](dest, src2, src1, cpu_env);
>> +        gen_set_gpr(a->rd, dest);
>> +
>> +        tcg_temp_free(dest);
>> +        tcg_temp_free(src1);
>> +        tcg_temp_free_ptr(src2);
>> +        return true;
>> +    }
>> +    return false;
>> +}
> This entire operation can be performed inline easily.
>
> static void extract_element(TCGv dest, TCGv_ptr base,
>                              int ofs, int sew)
> {
>      switch (sew) {
>      case MO_8:
>          tcg_gen_ld8u_tl(dest, base, ofs);
>          break;
>      case MO_16:
>          tcg_gen_ld16u_tl(dest, base, ofs);
>          break;
>      default:
>          tcg_gen_ld32u_tl(dest, base, ofs);
>          break;
> #if TARGET_LONG_BITS == 64
>      case MO_64:
>          tcg_gen_ld_i64(dest, base, ofs);
>          break;
> #endif
>      }
> }
>
> static bool trans_vext_x_v(DisasContext *s, arg_r *a)
> {
> ...
>      if (a->rs1 == 0) {
>          /* Special case vmv.x.s rd, vs2. */
>          do_extract(dest, cpu_env,
>                     vreg_ofs(s, a->rs2), s->sew);
>      } else {
>          int vlen = s->vlen >> (3 + s->sew);
>          TCGv_i32 ofs = tcg_temp_new_i32();
>          TCGv_ptr  base = tcg_temp_new_ptr();
>          TCGv t_vlen, t_zero;
>
>          /* Mask the index to the length so that we do
>             not produce an out-of-range load. */
>          tcg_gen_trunc_tl_i32(ofs, cpu_gpr[a->rs1]);
>          tcg_gen_andi_i32(ofs, ofs, vlen - 1);
>
>          /* Convert the index to an offset.  */
>          tcg_gen_shli_i32(ofs, ofs, s->sew);

In  big endianess host, should I convert the index first before this 
statement.

#ifdef HOST_WORDS_BIGENDIAN
static void convert_idx(TCGv_i32 idx, int sew)
{
     switch (sew) {
     case MO_8:
         tcg_gen_xori_i32(idx, idx, 7);
         break;
     case MO_16:
         tcg_gen_xori_i32(idx, idx, 3);
         break;
     case MO_32:
         tcg_gen_xori_i32(idx, idx, 1);
         break;
     default:
         break;
     }
}
#endif


When convert the index to an offset, use this function first

#ifdef HOST_WORDS_BIGENDIAN
     convert_idx(ofs, s->sew)
#endif
/* Convert the index to an offset.  */
tcg_gen_shli_i32(ofs, ofs, s->sew)

Zhiwei
>          /* Convert the index to a pointer. */
>          tcg_gen_extu_i32_ptr(base, ofs);
>          tcg_gen_add_ptr(base, base, cpu_env);
>
>          /* Perform the load. */
>          do_extract(dest, base,
>                     vreg_ofs(s, a->rs2), s->sew);
>          tcg_temp_free_ptr(base);
>          tcg_temp_free_i32(ofs);
>
>          /* Flush out-of-range indexing to zero.  */
>          t_vlen = tcg_const_tl(vlen);
>          t_zero = tcg_const_tl(0);
>          tcg_gen_movcond_tl(TCG_COND_LTU, dest, cpu_gpr[a->rs1],
>                             t_vlen, dest, t_zero);
>          tcg_temp_free(t_vlen);
>          tcg_temp_free(t_zero);
>      }
>
> r~


