Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2257C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68A620661
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68A620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1n0Q-0001Eu-VN
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 03:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j1mza-0000md-KD
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j1mzZ-0001DN-E6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:03:30 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j1mzY-000164-U6; Wed, 12 Feb 2020 03:03:29 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436807|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.420848-0.005378-0.573774;
 DS=CONTINUE|ham_regular_dialog|0.347987-0.000716277-0.651297;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03307; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.GnCK7Sq_1581494594; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GnCK7Sq_1581494594)
 by smtp.aliyun-inc.com(10.147.42.22); Wed, 12 Feb 2020 16:03:15 +0800
Subject: Re: [PATCH v4 4/4] target/riscv: add vector configure instruction
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
 <20200210081240.11481-5-zhiwei_liu@c-sky.com>
 <053777e2-7180-5584-cf7f-7876800d9dc8@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <bb1f595d-fbe8-93a2-c67c-25be7996aec3@c-sky.com>
Date: Wed, 12 Feb 2020 16:09:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <053777e2-7180-5584-cf7f-7876800d9dc8@linaro.org>
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/12 0:56, Richard Henderson wrote:
> On 2/10/20 8:12 AM, LIU Zhiwei wrote:
>>   static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>> -                                        target_ulong *cs_base, uint32_t *flags)
>> +                                        target_ulong *cs_base, uint32_t *pflags)
>>   {
>> +    uint32_t flags = 0;
>> +    uint32_t vlmax;
>> +    uint8_t vl_eq_vlmax;
> bool.
OK.

Is it clearer to use "bool" here? Or it's wrong to use "uint8_t "?
>
>> +
>>       *pc = env->pc;
>>       *cs_base = 0;
>> +
>> +    if (env->misa & RVV) {
>> +        vlmax = vext_get_vlmax(env_archcpu(env), env->vext.vtype);
>> +        vl_eq_vlmax = (env->vext.vstart == 0) && (vlmax == env->vext.vl);
> You might as well move the variable declarations inside this block.
OK.
>
>> +target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>> +     target_ulong s2)
> Indentation.
OK.
>
>> +{
>> +    int vlmax, vl;
>> +    RISCVCPU *cpu = env_archcpu(env);
>> +    uint16_t sew = 1 << FIELD_EX64(s2, VTYPE, SEW);
>> +
>> +    if (sew > cpu->cfg.elen) { /* only set vill bit. */
>> +        env->vext.vtype = FIELD_DP64(0, VTYPE, VILL, 1);
>> +        env->vext.vl = 0;
>> +        env->vext.vstart = 0;
>> +        return 0;
>> +    }
> You're missing checks against EDIV, VILL and the RESERVED field == 0.
This implementation does not support "Zvediv" . So I did not check it. 
I'm not sure if I should check(ediv==0).

I missed check  "VILL" filed.  Fix up it next patch.

I'm not quite sure if I should set VILL if  the RESERVED field != 0.

>
>> +
>> +    vlmax = vext_get_vlmax(cpu, s2);
>> +    if (s1 <= vlmax) {
>> +        vl = s1;
>> +    } else {
>> +        vl = vlmax;
>> +    }
>> +    env->vext.vl = vl;
>> +    env->vext.vtype = s2;
>> +    env->vext.vstart = 0;
>> +    return vl;
>> +}
>>
>
> r~


