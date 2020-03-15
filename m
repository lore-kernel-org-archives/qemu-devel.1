Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CF8C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 06:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C29F206E9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 06:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C29F206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDMYU-0001Gw-Ph
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 02:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDMXH-0000jZ-KV
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDMXF-00062U-Vp
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:14:07 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jDMXF-0005Gj-FJ; Sun, 15 Mar 2020 02:14:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07456715|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.0925119-0.000771813-0.906716;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03309; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H.gtnoy_1584252835; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H.gtnoy_1584252835)
 by smtp.aliyun-inc.com(10.147.40.200);
 Sun, 15 Mar 2020 14:13:55 +0800
Subject: Re: [PATCH v5 56/60] target/riscv: floating-point scalar move
 instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-57-zhiwei_liu@c-sky.com>
 <8b9161d1-f64f-5677-70a7-ec197d9d3d43@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <04119654-2741-5bdb-a764-457dbc04161d@c-sky.com>
Date: Sun, 15 Mar 2020 14:13:54 +0800
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
I agree. But I didn't find a reference in Section 17.3 both in v0.7.1 
and v0.8.

Perhaps I should refer

"If the current SEW does not correspond to a supported IEEE floating-point
type, an illegal instruction exception is raised."(Section 14)


> Need a check for fp enabled.  Presumably
>
>      if (s->mstatus_fs == 0 || !has_ext(s, RVF)) {
>          return false;
>      }
>
> Need to mark_fs_dirty().
Yes, I should.
>
> Like integer vmv.x.s, this can be done inline.  The nan-boxing is trivial as well.
>
> For 0.8, we will have to validate the nan-boxing for SEW=MO_64 && !RVD.  That's
> still not hard to do inline.
>
I see it. Thanks.
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
There is a mistake here.

fns[s->sew](dest, cpu_fpr[a->rs1], cpu_env);
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
Reasonable.
>
> Missing nan-boxing for SEW==MO_64 && FLEN==32 (!RVD).  Which I think should be
> done here inline, so that the uint64_t passed to the helper is always correct.
I think all float registers have been NAN-boxed in QEMU target/riscv.

As float registers are  always 64bits.  If FLEN is 32, a float register 
has been NAN-boxed in FLW or VFMV.F.S

Should I NAN-boxed the float register explicitly here ?

Zhiwei
>
> r~


