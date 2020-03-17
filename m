Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4432C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C39A205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C39A205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE5JW-000870-KP
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 02:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jE5Im-0007Z1-O3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jE5Il-0004A4-46
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:02:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jE5Ih-0002hu-JL; Tue, 17 Mar 2020 02:02:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07475197|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.124753-0.000316872-0.87493;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03309; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H0l2.4l_1584424905; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H0l2.4l_1584424905)
 by smtp.aliyun-inc.com(10.147.41.137);
 Tue, 17 Mar 2020 14:01:46 +0800
Subject: Re: [PATCH v5 56/60] target/riscv: floating-point scalar move
 instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-57-zhiwei_liu@c-sky.com>
 <8b9161d1-f64f-5677-70a7-ec197d9d3d43@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <f09dfcee-3ac3-80f0-938f-30654d418605@c-sky.com>
Date: Tue, 17 Mar 2020 14:01:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8b9161d1-f64f-5677-70a7-ec197d9d3d43@linaro.org>
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



On 2020/3/15 12:39, Richard Henderson wrote:
> On 3/12/20 7:58 AM, LIU Zhiwei wrote:
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>   target/riscv/helper.h                   |  9 +++++
>>   target/riscv/insn32.decode              |  2 ++
>>   target/riscv/insn_trans/trans_rvv.inc.c | 47 +++++++++++++++++++++++++
>>   target/riscv/vector_helper.c            | 36 +++++++++++++++++++
>>   4 files changed, 94 insertions(+)
>>
>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>> index 41cecd266c..7a689a5c07 100644
>> --- a/target/riscv/helper.h
>> +++ b/target/riscv/helper.h
>> @@ -1111,3 +1111,12 @@ DEF_HELPER_3(vmv_s_x_b, void, ptr, tl, env)
>>   DEF_HELPER_3(vmv_s_x_h, void, ptr, tl, env)
>>   DEF_HELPER_3(vmv_s_x_w, void, ptr, tl, env)
>>   DEF_HELPER_3(vmv_s_x_d, void, ptr, tl, env)
>> +
>> +DEF_HELPER_2(vfmv_f_s_b, i64, ptr, env)
>> +DEF_HELPER_2(vfmv_f_s_h, i64, ptr, env)
>> +DEF_HELPER_2(vfmv_f_s_w, i64, ptr, env)
>> +DEF_HELPER_2(vfmv_f_s_d, i64, ptr, env)
>> +DEF_HELPER_3(vfmv_s_f_b, void, ptr, i64, env)
>> +DEF_HELPER_3(vfmv_s_f_h, void, ptr, i64, env)
>> +DEF_HELPER_3(vfmv_s_f_w, void, ptr, i64, env)
>> +DEF_HELPER_3(vfmv_s_f_d, void, ptr, i64, env)
>> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>> index 7e1efeec05..bfdce0979c 100644
>> --- a/target/riscv/insn32.decode
>> +++ b/target/riscv/insn32.decode
>> @@ -557,6 +557,8 @@ viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
>>   vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
>>   vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
>>   vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
>> +vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
>> +vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
>>   
>>   vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>>   vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
>> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
>> index 7720ffecde..99cd45b0aa 100644
>> --- a/target/riscv/insn_trans/trans_rvv.inc.c
>> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
>> @@ -2269,3 +2269,50 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
>>       }
>>       return false;
>>   }
>> +
>> +/* Floating-Point Scalar Move Instructions */
>> +typedef void (* gen_helper_vfmv_f_s)(TCGv_i64, TCGv_ptr, TCGv_env);
>> +static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
>> +{
>> +    if (vext_check_isa_ill(s, RVV)) {
>> +        TCGv_ptr src2;
>> +        gen_helper_vfmv_f_s fns[4] = {
>> +            gen_helper_vfmv_f_s_b, gen_helper_vfmv_f_s_h,
>> +            gen_helper_vfmv_f_s_w, gen_helper_vfmv_f_s_d
>> +        };
>> +
>> +        src2 = tcg_temp_new_ptr();
>> +        tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, a->rs2));
>> +
>> +        fns[s->sew](cpu_fpr[a->rd], src2, cpu_env);
>> +
>> +        tcg_temp_free_ptr(src2);
>> +        return true;
>> +    }
>> +    return false;
>> +}
> SEW == MO_8 should raise illegal instruction exception.
>
> Need a check for fp enabled.  Presumably
>
>      if (s->mstatus_fs == 0 || !has_ext(s, RVF)) {
>          return false;
>      }
Hi  Richard,

Two questions here. I don't find the answer in the specification.

1. Should  I check RVF if the instruction uses float register,  such as 
all float point instructions and some other instructions?

2. Should I check mstatus_fs if the instruction uses float registers, or 
just for instructions that write float point register?

Zhiwei

> Need to mark_fs_dirty().
>
> Like integer vmv.x.s, this can be done inline.  The nan-boxing is trivial as well.
>
> For 0.8, we will have to validate the nan-boxing for SEW=MO_64 && !RVD.  That's
> still not hard to do inline.
>
>
>
>> +
>> +typedef void (* gen_helper_vfmv_s_f)(TCGv_ptr, TCGv_i64, TCGv_env);
>> +static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
>> +{
>> +    if (vext_check_isa_ill(s, RVV | RVF) ||
>> +        vext_check_isa_ill(s, RVV | RVD)) {
>> +        TCGv_ptr dest;
>> +        TCGv_i64 src1;
>> +        gen_helper_vfmv_s_f fns[4] = {
>> +            gen_helper_vfmv_s_f_b, gen_helper_vfmv_s_f_h,
>> +            gen_helper_vfmv_s_f_w, gen_helper_vfmv_s_f_d
>> +        };
>> +
>> +        src1 = tcg_temp_new_i64();
>> +        dest = tcg_temp_new_ptr();
>> +        tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
>> +
>> +        fns[s->sew](dest, src1, cpu_env);
>> +
>> +        tcg_temp_free_i64(src1);
>> +        tcg_temp_free_ptr(dest);
>> +        return true;
>> +    }
>> +    return false;
>> +}
> Again, SEW == MO_8 is illegal.  Missing fp enable check.
>
> I don't believe RVD without RVF is legal; you should not need to check for both.
>
> Missing nan-boxing for SEW==MO_64 && FLEN==32 (!RVD).  Which I think should be
> done here inline, so that the uint64_t passed to the helper is always correct.
>
>
> r~


