Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364D9C10F26
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 07:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081AB20732
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 07:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081AB20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGHFC-00080x-31
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 03:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jGHEL-0007Jg-Nm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 03:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jGHEK-0001Ca-8D
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 03:10:37 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:32998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jGHEJ-0001C4-PT; Mon, 23 Mar 2020 03:10:36 -0400
X-Alimail-AntiSpam: AC=SUSPECT; BC=0.6466425|-1; BR=01201311R941b1; CH=blue;
 DM=||false|; DS=CONTINUE|ham_alarm|0.431571-0.000189887-0.568239;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03307; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=12; RT=12; SR=0; TI=SMTPD_---.H3rj3ad_1584947424; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H3rj3ad_1584947424)
 by smtp.aliyun-inc.com(10.147.44.129);
 Mon, 23 Mar 2020 15:10:24 +0800
Subject: Re: [PATCH v6 04/61] target/riscv: add vector configure instruction
To: Kito Cheng <kito.cheng@gmail.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-5-zhiwei_liu@c-sky.com>
 <CA+yXCZCWS2fF+LOi-4bUgNXrGm=v9yuYUQR5gpk7+230Z86ykw@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <769218a3-5409-9b6b-974d-193daed48ce6@c-sky.com>
Date: Mon, 23 Mar 2020 15:10:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+yXCZCWS2fF+LOi-4bUgNXrGm=v9yuYUQR5gpk7+230Z86ykw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: guoren@linux.alibaba.com, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Alistair Francis <alistair.francis@wdc.com>,
 alistair23@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/23 14:51, Kito Cheng wrote:
> Hi Zhiwei:
>
> vsetvl and vsetvli seems like missing ISA checking before translate,
> this cause those 2 instructions can be executed even RVV not enable.
> My testing env is qemu riscv64-linux-user mode.
Hi Kito,

I think you are right. Thanks for pointing that.

Zhiwei
>> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
>> new file mode 100644
>> index 0000000000..7381c24295
>> --- /dev/null
>> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
>> @@ -0,0 +1,69 @@
>> +/*
>> + * RISC-V translation routines for the RVV Standard Extension.
>> + *
>> + * Copyright (c) 2020 C-SKY Limited. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2 or later, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
>> +{
> Missing vext_check_isa_ill(s) check?
>
>> +    TCGv s1, s2, dst;
>> +    s2 = tcg_temp_new();
>> +    dst = tcg_temp_new();
>> +
>> +    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
>> +    if (a->rs1 == 0) {
>> +        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
>> +        s1 = tcg_const_tl(RV_VLEN_MAX);
>> +    } else {
>> +        s1 = tcg_temp_new();
>> +        gen_get_gpr(s1, a->rs1);
>> +    }
>> +    gen_get_gpr(s2, a->rs2);
>> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
>> +    gen_set_gpr(a->rd, dst);
>> +    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
>> +    lookup_and_goto_ptr(ctx);
>> +    ctx->base.is_jmp = DISAS_NORETURN;
>> +
>> +    tcg_temp_free(s1);
>> +    tcg_temp_free(s2);
>> +    tcg_temp_free(dst);
>> +    return true;
>> +}
>> +
>> +static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
>> +{
> Missing vext_check_isa_ill(s) check?
>
>
>> +    TCGv s1, s2, dst;
>> +    s2 = tcg_const_tl(a->zimm);
>> +    dst = tcg_temp_new();
>> +
>> +    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
>> +    if (a->rs1 == 0) {
>> +        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
>> +        s1 = tcg_const_tl(RV_VLEN_MAX);
>> +    } else {
>> +        s1 = tcg_temp_new();
>> +        gen_get_gpr(s1, a->rs1);
>> +    }
>> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
>> +    gen_set_gpr(a->rd, dst);
>> +    gen_goto_tb(ctx, 0, ctx->pc_succ_insn);
>> +    ctx->base.is_jmp = DISAS_NORETURN;
>> +
>> +    tcg_temp_free(s1);
>> +    tcg_temp_free(s2);
>> +    tcg_temp_free(dst);
>> +    return true;
>> +}


