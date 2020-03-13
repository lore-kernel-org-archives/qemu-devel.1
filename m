Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7526FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAE12074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAE12074E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsEj-0006DA-Er
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCsE6-0005l1-Rw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCsE5-0006xI-Bp
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:52:18 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45701)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCsE5-0006QV-14; Fri, 13 Mar 2020 17:52:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07437152|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.0519413-0.000440764-0.947618;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03296; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H.3bSUR_1584136328; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H.3bSUR_1584136328) by smtp.aliyun-inc.com(10.147.40.7);
 Sat, 14 Mar 2020 05:52:08 +0800
Subject: Re: [PATCH v5 60/60] target/riscv: configure and turn on vector
 extension from command line
To: Alistair Francis <alistair23@gmail.com>
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-61-zhiwei_liu@c-sky.com>
 <CAKmqyKMJb=6GgtEToPvv+6AArmvmJ5PkjAdr_1j+evYurjf7MQ@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <b009548f-3a43-6bcc-e5fe-cfa007204195@c-sky.com>
Date: Sat, 14 Mar 2020 05:52:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMJb=6GgtEToPvv+6AArmvmJ5PkjAdr_1j+evYurjf7MQ@mail.gmail.com>
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
Cc: guoren@linux.alibaba.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/14 5:41, Alistair Francis wrote:
> On Thu, Mar 12, 2020 at 10:00 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>> Vector extension is default off. The only way to use vector extension is
>> 1. use cpu rv32 or rv64
>> 2. turn on it by command line
>> "-cpu rv64,v=true,vlen=128,elen=64,vext_spec=v0.7.1".
>>
>> vlen is the vector register length, default value is 128 bit.
>> elen is the max operator size in bits, default value is 64 bit.
>> vext_spec is the vector specification version, default value is v0.7.1.
>> These properties can be specified with other values.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>   target/riscv/cpu.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>>   target/riscv/cpu.h |  2 ++
>>   2 files changed, 45 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 6e4135583d..5f1cdd4f2b 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -395,7 +395,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>>       }
>>
>>       set_priv_version(env, priv_version);
>> -    set_vext_version(env, vext_version);
>>       set_resetvec(env, DEFAULT_RSTVEC);
>>
>>       if (cpu->cfg.mmu) {
>> @@ -463,6 +462,45 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>>           if (cpu->cfg.ext_h) {
>>               target_misa |= RVH;
>>           }
>> +        if (cpu->cfg.ext_v) {
>> +            target_misa |= RVV;
>> +            if (!is_power_of_2(cpu->cfg.vlen)) {
>> +                error_setg(errp,
>> +                        "Vector extension VLEN must be power of 2");
>> +                return;
>> +            }
>> +            if (cpu->cfg.vlen > RV_VLEN_MAX || cpu->cfg.vlen < 128) {
>> +                error_setg(errp,
>> +                        "Vector extension implementation only supports VLEN "
>> +                        "in the range [128, %d]", RV_VLEN_MAX);
>> +                return;
>> +            }
>> +            if (!is_power_of_2(cpu->cfg.elen)) {
>> +                error_setg(errp,
>> +                        "Vector extension ELEN must be power of 2");
>> +                return;
>> +            }
>> +            if (cpu->cfg.elen > 64 || cpu->cfg.vlen < 8) {
>> +                error_setg(errp,
>> +                        "Vector extension implementation only supports ELEN "
>> +                        "in the range [8, 64]");
>> +                return;
>> +            }
>> +            if (cpu->cfg.vext_spec) {
>> +                if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
>> +                    vext_version = VEXT_VERSION_0_07_1;
>> +                } else {
>> +                    error_setg(errp,
>> +                           "Unsupported vector spec version '%s'",
>> +                           cpu->cfg.vext_spec);
>> +                    return;
>> +                }
>> +            } else {
>> +                qemu_log("vector verison is not specified, "
>> +                        "use the default value v0.7.1\n");
>> +            }
>> +            set_vext_version(env, vext_version);
>> +        }
>>
>>           set_misa(env, RVXLEN | target_misa);
>>       }
>> @@ -500,10 +538,14 @@ static Property riscv_cpu_properties[] = {
>>       DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>>       /* This is experimental so mark with 'x-' */
>>       DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
>> +    DEFINE_PROP_BOOL("v", RISCVCPU, cfg.ext_v, false),
> This should be x-v as it's experimental.
>
> Alistair
Yes. I will fix it next patch set.

Zhiwei
>
>>       DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>>       DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>>       DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
>>       DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
>> +    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
>> +    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
>> +    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
>>       DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
>>       DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
>>       DEFINE_PROP_END_OF_LIST(),
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index e069e55e81..36ead8d6d5 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -285,12 +285,14 @@ typedef struct RISCVCPU {
>>           bool ext_s;
>>           bool ext_u;
>>           bool ext_h;
>> +        bool ext_v;
>>           bool ext_counters;
>>           bool ext_ifencei;
>>           bool ext_icsr;
>>
>>           char *priv_spec;
>>           char *user_spec;
>> +        char *vext_spec;
>>           uint16_t vlen;
>>           uint16_t elen;
>>           bool mmu;
>> --
>> 2.23.0
>>


