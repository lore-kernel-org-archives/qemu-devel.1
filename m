Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C04C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9ABE20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9ABE20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnqYN-00066t-SM
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 17:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnqXR-0005IK-UP; Tue, 23 Jun 2020 17:33:05 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnqXH-00060x-Tw; Tue, 23 Jun 2020 17:33:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07688387|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.00282055-0.00018749-0.996992;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03303; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.HrQVq6x_1592947959; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HrQVq6x_1592947959)
 by smtp.aliyun-inc.com(10.147.44.118);
 Wed, 24 Jun 2020 05:32:39 +0800
Subject: Re: [PATCH v10 06/61] target/riscv: add vector stride load and store
 instructions
To: Alistair Francis <alistair23@gmail.com>
References: <20200620043701.1323-1-zhiwei_liu@c-sky.com>
 <20200620043701.1323-7-zhiwei_liu@c-sky.com>
 <CAKmqyKMN_PMJrwT3HvWryWaaWHhbQZkhO3y-NVk_OyEfgT8H4g@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <52471447-9a3c-b4df-f45c-788e52ea5409@c-sky.com>
Date: Wed, 24 Jun 2020 05:32:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMN_PMJrwT3HvWryWaaWHhbQZkhO3y-NVk_OyEfgT8H4g@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------F9932249F3BA5470D9D6E329"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 17:32:41
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------F9932249F3BA5470D9D6E329
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/6/24 0:52, Alistair Francis wrote:
> On Fri, Jun 19, 2020 at 9:49 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>> Vector strided operations access the first memory element at the base address,
>> and then access subsequent elements at address increments given by the byte
>> offset contained in the x register specified by rs2.
>>
>> Vector unit-stride operations access elements stored contiguously in memory
>> starting from the base effective address. It can been seen as a special
>> case of strided operations.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/helper.h                   | 105 ++++++
>>   target/riscv/insn32.decode              |  32 ++
>>   target/riscv/insn_trans/trans_rvv.inc.c | 355 ++++++++++++++++++++
>>   target/riscv/internals.h                |   5 +
>>   target/riscv/translate.c                |   7 +
>>   target/riscv/vector_helper.c            | 410 ++++++++++++++++++++++++
>>   6 files changed, 914 insertions(+)
>>
>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>> index 8e81ff440b..f03b3d52f5 100644
>> --- a/target/riscv/helper.h
>> +++ b/target/riscv/helper.h
>> @@ -84,3 +84,108 @@ DEF_HELPER_1(hyp_tlb_flush, void, env)
>>
>>   /* Vector functions */
>>   DEF_HELPER_3(vsetvl, tl, env, tl, tl)
>> +DEF_HELPER_5(vlb_v_b, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlb_v_b_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlb_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlb_v_h_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlb_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlb_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlb_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlb_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlh_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlh_v_h_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlh_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlh_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlh_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlh_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlw_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlw_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlw_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlw_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vle_v_b, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vle_v_b_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vle_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vle_v_h_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vle_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vle_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vle_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vle_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbu_v_b, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbu_v_b_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbu_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbu_v_h_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbu_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbu_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbu_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbu_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhu_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhu_v_h_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhu_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhu_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhu_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhu_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlwu_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlwu_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlwu_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlwu_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsb_v_b, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsb_v_b_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsb_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsb_v_h_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsb_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsb_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsb_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsb_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsh_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsh_v_h_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsh_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsh_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsh_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsh_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsw_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsw_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsw_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vsw_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vse_v_b, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vse_v_b_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vse_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vse_v_h_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vse_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vse_v_w_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vse_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vse_v_d_mask, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_6(vlsb_v_b, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsb_v_h, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsb_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsb_v_d, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsh_v_h, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsh_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsh_v_d, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsw_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsw_v_d, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlse_v_b, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlse_v_h, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlse_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlse_v_d, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsbu_v_b, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsbu_v_h, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsbu_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlsbu_v_d, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlshu_v_h, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlshu_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlshu_v_d, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlswu_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vlswu_v_d, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vssb_v_b, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vssb_v_h, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vssb_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vssb_v_d, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vssh_v_h, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vssh_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vssh_v_d, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vssw_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vssw_v_d, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vsse_v_b, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vsse_v_h, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vsse_v_w, void, ptr, ptr, tl, tl, env, i32)
>> +DEF_HELPER_6(vsse_v_d, void, ptr, ptr, tl, tl, env, i32)
>> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>> index 1916cf331d..58b95792e6 100644
>> --- a/target/riscv/insn32.decode
>> +++ b/target/riscv/insn32.decode
>> @@ -25,6 +25,7 @@
>>   %sh10    20:10
>>   %csr    20:12
>>   %rm     12:3
>> +%nf     29:3                     !function=ex_plus_1
>>
>>   # immediates:
>>   %imm_i    20:s12
>> @@ -43,6 +44,8 @@
>>   &u    imm rd
>>   &shift     shamt rs1 rd
>>   &atomic    aq rl rs2 rs1 rd
>> +&r2nfvm    vm rd rs1 nf
>> +&rnfvm     vm rd rs1 rs2 nf
>>
>>   # Formats 32:
>>   @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
>> @@ -62,6 +65,8 @@
>>   @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
>>   @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
>>   @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
>> +@r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
>> +@r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
>>   @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
>>
>>   @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
>> @@ -212,5 +217,32 @@ hfence_gvma 0110001  .....  ..... 000 00000 1110011 @hfence_gvma
>>   hfence_vvma 0010001  .....  ..... 000 00000 1110011 @hfence_vvma
>>
>>   # *** RV32V Extension ***
>> +
>> +# *** Vector loads and stores are encoded within LOADFP/STORE-FP ***
>> +vlb_v      ... 100 . 00000 ..... 000 ..... 0000111 @r2_nfvm
>> +vlh_v      ... 100 . 00000 ..... 101 ..... 0000111 @r2_nfvm
>> +vlw_v      ... 100 . 00000 ..... 110 ..... 0000111 @r2_nfvm
>> +vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
>> +vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
>> +vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
>> +vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
>> +vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
>> +vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
>> +vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
>> +vse_v      ... 000 . 00000 ..... 111 ..... 0100111 @r2_nfvm
>> +
>> +vlsb_v     ... 110 . ..... ..... 000 ..... 0000111 @r_nfvm
>> +vlsh_v     ... 110 . ..... ..... 101 ..... 0000111 @r_nfvm
>> +vlsw_v     ... 110 . ..... ..... 110 ..... 0000111 @r_nfvm
>> +vlse_v     ... 010 . ..... ..... 111 ..... 0000111 @r_nfvm
>> +vlsbu_v    ... 010 . ..... ..... 000 ..... 0000111 @r_nfvm
>> +vlshu_v    ... 010 . ..... ..... 101 ..... 0000111 @r_nfvm
>> +vlswu_v    ... 010 . ..... ..... 110 ..... 0000111 @r_nfvm
>> +vssb_v     ... 010 . ..... ..... 000 ..... 0100111 @r_nfvm
>> +vssh_v     ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
>> +vssw_v     ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
>> +vsse_v     ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
>> +
>> +# *** new major opcode OP-V ***
>>   vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>>   vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
>> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
>> index c82fdf013e..f9950ad5a0 100644
>> --- a/target/riscv/insn_trans/trans_rvv.inc.c
>> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
>> @@ -15,6 +15,9 @@
>>    * You should have received a copy of the GNU General Public License along with
>>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>>    */
>> +#include "tcg/tcg-op-gvec.h"
>> +#include "tcg/tcg-gvec-desc.h"
>> +#include "internals.h"
>>
>>   static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
>>   {
>> @@ -77,3 +80,355 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
>>       tcg_temp_free(dst);
>>       return true;
>>   }
>> +
>> +/* vector register offset from env */
>> +static uint32_t vreg_ofs(DisasContext *s, int reg)
>> +{
>> +    return offsetof(CPURISCVState, vreg) + reg * s->vlen / 8;
>> +}
>> +
>> +/* check functions */
>> +
>> +/*
>> + * In cpu_get_tb_cpu_state(), set VILL if RVV was not present.
>> + * So RVV is also be checked in this function.
>> + */
>> +static bool vext_check_isa_ill(DisasContext *s)
>> +{
>> +    return !s->vill;
>> +}
>> +
>> +/*
>> + * There are two rules check here.
>> + *
>> + * 1. Vector register numbers are multiples of LMUL. (Section 3.2)
>> + *
>> + * 2. For all widening instructions, the destination LMUL value must also be
>> + *    a supported LMUL value. (Section 11.2）
> There is some strange UTF encoding on this line according to
> checkpatch. Do you mind running checkpatch on the patches and fix any
> issues?
Hi Alistair,

Yes, it's a non-ASCII character here and in comments.

I once used the checkpatch.pl to check the whole patch set, but it can't 
detect the encoding problems.

If I use a "--8bit-encoding" option in the git send-email, it will 
encodes the non-ASCII in UTF-8. So that you can git am the email.

But I will try to find and fix all the non-ASCII characters.

Zhiwei

> checkpatch seems to have some false positives (it confusing pointer *
> and multiply *) they don't need to be fixed.
>
> Alistair
>
>


--------------F9932249F3BA5470D9D6E329
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/6/24 0:52, Alistair Francis
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKmqyKMN_PMJrwT3HvWryWaaWHhbQZkhO3y-NVk_OyEfgT8H4g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Fri, Jun 19, 2020 at 9:49 PM LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com">&lt;zhiwei_liu@c-sky.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Vector strided operations access the first memory element at the base address,
and then access subsequent elements at address increments given by the byte
offset contained in the x register specified by rs2.

Vector unit-stride operations access elements stored contiguously in memory
starting from the base effective address. It can been seen as a special
case of strided operations.

Signed-off-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com">&lt;zhiwei_liu@c-sky.com&gt;</a>
Reviewed-by: Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a>
Reviewed-by: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>
---
 target/riscv/helper.h                   | 105 ++++++
 target/riscv/insn32.decode              |  32 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 355 ++++++++++++++++++++
 target/riscv/internals.h                |   5 +
 target/riscv/translate.c                |   7 +
 target/riscv/vector_helper.c            | 410 ++++++++++++++++++++++++
 6 files changed, 914 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8e81ff440b..f03b3d52f5 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -84,3 +84,108 @@ DEF_HELPER_1(hyp_tlb_flush, void, env)

 /* Vector functions */
 DEF_HELPER_3(vsetvl, tl, env, tl, tl)
+DEF_HELPER_5(vlb_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlb_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlh_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlw_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwu_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsb_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsh_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vsw_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_b_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_h_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_w_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vse_v_d_mask, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_6(vlsb_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsb_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsb_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsb_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsh_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsh_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsh_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsw_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsw_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlse_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlsbu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlshu_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlshu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlshu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlswu_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlswu_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssb_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssh_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssh_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssh_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssw_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vssw_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_b, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_h, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_w, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vsse_v_d, void, ptr, ptr, tl, tl, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1916cf331d..58b95792e6 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -25,6 +25,7 @@
 %sh10    20:10
 %csr    20:12
 %rm     12:3
+%nf     29:3                     !function=ex_plus_1

 # immediates:
 %imm_i    20:s12
@@ -43,6 +44,8 @@
 &amp;u    imm rd
 &amp;shift     shamt rs1 rd
 &amp;atomic    aq rl rs2 rs1 rd
+&amp;r2nfvm    vm rd rs1 nf
+&amp;rnfvm     vm rd rs1 rs2 nf

 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &amp;r                %rs2 %rs1 %rd
@@ -62,6 +65,8 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &amp;r2nfvm %nf %rs1 %rd
+@r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &amp;rnfvm %nf %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd

 @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -212,5 +217,32 @@ hfence_gvma 0110001  .....  ..... 000 00000 1110011 @hfence_gvma
 hfence_vvma 0010001  .....  ..... 000 00000 1110011 @hfence_vvma

 # *** RV32V Extension ***
+
+# *** Vector loads and stores are encoded within LOADFP/STORE-FP ***
+vlb_v      ... 100 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+vlh_v      ... 100 . 00000 ..... 101 ..... 0000111 @r2_nfvm
+vlw_v      ... 100 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
+vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
+vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
+vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
+vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
+vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
+vse_v      ... 000 . 00000 ..... 111 ..... 0100111 @r2_nfvm
+
+vlsb_v     ... 110 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlsh_v     ... 110 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlsw_v     ... 110 . ..... ..... 110 ..... 0000111 @r_nfvm
+vlse_v     ... 010 . ..... ..... 111 ..... 0000111 @r_nfvm
+vlsbu_v    ... 010 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlshu_v    ... 010 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlswu_v    ... 010 . ..... ..... 110 ..... 0000111 @r_nfvm
+vssb_v     ... 010 . ..... ..... 000 ..... 0100111 @r_nfvm
+vssh_v     ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
+vssw_v     ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
+vsse_v     ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
+
+# *** new major opcode OP-V ***
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c82fdf013e..f9950ad5a0 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -15,6 +15,9 @@
  * You should have received a copy of the GNU General Public License along with
  * this program.  If not, see <a class="moz-txt-link-rfc2396E" href="http://www.gnu.org/licenses/">&lt;http://www.gnu.org/licenses/&gt;</a>.
  */
+#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "internals.h"

 static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
 {
@@ -77,3 +80,355 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
     tcg_temp_free(dst);
     return true;
 }
+
+/* vector register offset from env */
+static uint32_t vreg_ofs(DisasContext *s, int reg)
+{
+    return offsetof(CPURISCVState, vreg) + reg * s-&gt;vlen / 8;
+}
+
+/* check functions */
+
+/*
+ * In cpu_get_tb_cpu_state(), set VILL if RVV was not present.
+ * So RVV is also be checked in this function.
+ */
+static bool vext_check_isa_ill(DisasContext *s)
+{
+    return !s-&gt;vill;
+}
+
+/*
+ * There are two rules check here.
+ *
+ * 1. Vector register numbers are multiples of LMUL. (Section 3.2)
+ *
+ * 2. For all widening instructions, the destination LMUL value must also be
+ *    a supported LMUL value. (Section 11.2）
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
There is some strange UTF encoding on this line according to
checkpatch. Do you mind running checkpatch on the patches and fix any
issues?
</pre>
    </blockquote>
    Hi Alistair,<br>
    <br>
    Yes, it's a non-ASCII character here and in comments.<br>
    <br>
    I once used the checkpatch.pl to check the whole patch set, but it
    can't detect the encoding problems.<br>
    <br>
    If I use a  <span style="color: rgb(78, 68, 60); font-family:
      Courier, monospace; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 700; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(252, 252, 250); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;">"--8bit-encoding" </span>option in the
    git send-email, it will encodes the non-ASCII in UTF-8. So that you
    can git am the email.<br>
    <br>
    But I will try to find and fix all the non-ASCII characters.<br>
    <br>
    Zhiwei<br>
    <br>
    <blockquote type="cite"
cite="mid:CAKmqyKMN_PMJrwT3HvWryWaaWHhbQZkhO3y-NVk_OyEfgT8H4g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
checkpatch seems to have some false positives (it confusing pointer *
and multiply *) they don't need to be fixed.

Alistair

</pre>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------F9932249F3BA5470D9D6E329--

