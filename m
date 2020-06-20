Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB51C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 01:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D80A221EC
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 01:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D80A221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmS1u-00047R-MA
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 21:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jmS1C-0003K3-6H; Fri, 19 Jun 2020 21:10:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jmS19-0007BG-BC; Fri, 19 Jun 2020 21:10:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07633813|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0470644-0.00117123-0.951764;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03303; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.HpT75jx_1592615386; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HpT75jx_1592615386)
 by smtp.aliyun-inc.com(10.147.40.44); Sat, 20 Jun 2020 09:09:47 +0800
Subject: Re: [PATCH v9 57/61] target/riscv: floating-point scalar move
 instructions
To: Alistair Francis <alistair23@gmail.com>
References: <20200610113748.4754-1-zhiwei_liu@c-sky.com>
 <20200610113748.4754-58-zhiwei_liu@c-sky.com>
 <CAKmqyKN4pk=XgO-v-grTRvrQY-DEKap_Kouko6-gM-r3HynSjQ@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <6fdd0b58-3ea0-1052-feed-d2bf8312f211@c-sky.com>
Date: Sat, 20 Jun 2020 09:09:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKN4pk=XgO-v-grTRvrQY-DEKap_Kouko6-gM-r3HynSjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 21:09:48
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/6/20 8:44, Alistair Francis wrote:
> On Wed, Jun 10, 2020 at 6:44 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Hello,
>
> This patch fails to compile with this error:
>
> target/riscv/insn32.decode:566: error: undefined format @r2rd
>
> Do you mind looking into why this test fails?
Sorry, it's a mistake.

the @r2rd is defined in the next patch  "[PATCH v9 58/61] target/riscv: 
vector slide instructions",  where doesn't need the definition at all.

When I split patch set, I must make a mistake here. After that I only 
build  and tested the whole patch set.

Thanks for pointing it.

Zhiwei
>
> Alistair
>
>
>> ---
>>   target/riscv/insn32.decode              |  2 +
>>   target/riscv/insn_trans/trans_rvv.inc.c | 49 +++++++++++++++++++++++++
>>   2 files changed, 51 insertions(+)
>>
>> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>> index 0741a25540..79f9b37b29 100644
>> --- a/target/riscv/insn32.decode
>> +++ b/target/riscv/insn32.decode
>> @@ -563,6 +563,8 @@ viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
>>   vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
>>   vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
>>   vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
>> +vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
>> +vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
>>
>>   vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>>   vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
>> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
>> index e67eff0a7f..884ad910b1 100644
>> --- a/target/riscv/insn_trans/trans_rvv.inc.c
>> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
>> @@ -2709,3 +2709,52 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
>>       }
>>       return false;
>>   }
>> +
>> +/* Floating-Point Scalar Move Instructions */
>> +static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
>> +{
>> +    if (!s->vill && has_ext(s, RVF) &&
>> +        (s->mstatus_fs != 0) && (s->sew != 0)) {
>> +        unsigned int len = 8 << s->sew;
>> +
>> +        vec_element_loadi(s, cpu_fpr[a->rd], a->rs2, 0);
>> +        if (len < 64) {
>> +            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
>> +                            MAKE_64BIT_MASK(len, 64 - len));
>> +        }
>> +
>> +        mark_fs_dirty(s);
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>> +/* vfmv.s.f vd, rs1 # vd[0] = rs1 (vs2=0) */
>> +static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
>> +{
>> +    if (!s->vill && has_ext(s, RVF) && (s->sew != 0)) {
>> +        TCGv_i64 t1;
>> +        /* The instructions ignore LMUL and vector register group. */
>> +        uint32_t vlmax = s->vlen >> 3;
>> +
>> +        /* if vl == 0, skip vector register write back */
>> +        TCGLabel *over = gen_new_label();
>> +        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
>> +
>> +        /* zeroed all elements */
>> +        tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd), vlmax, vlmax, 0);
>> +
>> +        /* NaN-box f[rs1] as necessary for SEW */
>> +        t1 = tcg_temp_new_i64();
>> +        if (s->sew == MO_64 && !has_ext(s, RVD)) {
>> +            tcg_gen_ori_i64(t1, cpu_fpr[a->rs1], MAKE_64BIT_MASK(32, 32));
>> +        } else {
>> +            tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
>> +        }
>> +        vec_element_storei(s, a->rd, 0, t1);
>> +        tcg_temp_free_i64(t1);
>> +        gen_set_label(over);
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> --
>> 2.23.0
>>
>>


