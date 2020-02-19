Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E734DC34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DFC24654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DFC24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4DWK-0007Zc-Vd
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 19:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j4DVh-0007A0-LC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j4DVf-0000iW-0I
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:46:41 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48236)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j4DVe-0000ez-F6; Tue, 18 Feb 2020 19:46:38 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436292|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.348929-0.0276323-0.623439;
 DS=CONTINUE|ham_system_inform|0.536313-0.000101925-0.463585;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03297; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.GpVazkk_1582073190; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GpVazkk_1582073190)
 by smtp.aliyun-inc.com(10.147.41.121);
 Wed, 19 Feb 2020 08:46:31 +0800
Subject: Re: [PATCH v4 2/4] target/riscv: configure and turn on vector
 extension from command line
To: Alistair Francis <alistair23@gmail.com>
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
 <20200210081240.11481-3-zhiwei_liu@c-sky.com>
 <CAKmqyKORm9dfkgSOe0WR1aDBzJyMq9YP9+bBPwkeX2J2jYmLAg@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <0eb6836a-b133-b3b1-6ef6-74dd341b1dd5@c-sky.com>
Date: Wed, 19 Feb 2020 08:46:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKORm9dfkgSOe0WR1aDBzJyMq9YP9+bBPwkeX2J2jYmLAg@mail.gmail.com>
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Alistair

On 2020/2/19 6:34, Alistair Francis wrote:
> On Mon, Feb 10, 2020 at 12:12 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>> Vector extension is default on only for "any" cpu. It can be turned
>> on by command line "-cpu rv64,v=true,vlen=128,elen=64,vext_spec=v0.7.1".
>>
>> vlen is the vector register length, default value is 128 bit.
>> elen is the max operator size in bits, default value is 64 bit.
>> vext_spec is the vector specification version, default value is v0.7.1.
>> Thest properties and cpu can be specified with other values.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> This looks fine to me. Shouldn't this be the last patch though?
Yes， it should be the last patch.
> As in
> once the vector extension has been added to QEMU you can turn it on
> from the command line. Right now this turns it on but it isn't
> implemented.
Maybe I should just add fields in RISCVCPU structure. And never open the
vector extension on or add configure properties until the implementation 
is ready.

It's still a little awkward as the reviewers will not be able to test 
the patch until the
last patch.

> Alistair
>
>> ---
>>   target/riscv/cpu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++--
>>   target/riscv/cpu.h |  8 ++++++++
>>   2 files changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 8c86ebc109..95fdb6261e 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -98,6 +98,11 @@ static void set_priv_version(CPURISCVState *env, int priv_ver)
>>       env->priv_ver = priv_ver;
>>   }
>>
>> +static void set_vext_version(CPURISCVState *env, int vext_ver)
>> +{
>> +    env->vext_ver = vext_ver;
>> +}
>> +
>>   static void set_feature(CPURISCVState *env, int feature)
>>   {
>>       env->features |= (1ULL << feature);
>> @@ -113,7 +118,7 @@ static void set_resetvec(CPURISCVState *env, int resetvec)
>>   static void riscv_any_cpu_init(Object *obj)
>>   {
>>       CPURISCVState *env = &RISCV_CPU(obj)->env;
>> -    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
>> +    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU | RVV);
>>       set_priv_version(env, PRIV_VERSION_1_11_0);
>>       set_resetvec(env, DEFAULT_RSTVEC);
>>   }
>> @@ -320,6 +325,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>>       CPURISCVState *env = &cpu->env;
>>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>>       int priv_version = PRIV_VERSION_1_11_0;
>> +    int vext_version = VEXT_VERSION_0_07_1;
>>       target_ulong target_misa = 0;
>>       Error *local_err = NULL;
>>
>> @@ -343,8 +349,18 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>>               return;
>>           }
>>       }
>> -
>> +    if (cpu->cfg.vext_spec) {
>> +        if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
>> +            vext_version = VEXT_VERSION_0_07_1;
>> +        } else {
>> +            error_setg(errp,
>> +                       "Unsupported vector spec version '%s'",
>> +                       cpu->cfg.vext_spec);
>> +            return;
>> +        }
>> +    }
>>       set_priv_version(env, priv_version);
>> +    set_vext_version(env, vext_version);
>>       set_resetvec(env, DEFAULT_RSTVEC);
>>
>>       if (cpu->cfg.mmu) {
>> @@ -409,6 +425,30 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>>           if (cpu->cfg.ext_u) {
>>               target_misa |= RVU;
>>           }
>> +        if (cpu->cfg.ext_v) {
>> +            target_misa |= RVV;
>> +            if (!is_power_of_2(cpu->cfg.vlen)) {
>> +                error_setg(errp,
>> +                       "Vector extension VLEN must be power of 2");
>> +                return;
>> +            }
>> +            if (cpu->cfg.vlen > RV_VLEN_MAX || cpu->cfg.vlen < 128) {
>> +                error_setg(errp,
>> +                       "Vector extension implementation only supports VLEN "
>> +                       "in the range [128, %d]", RV_VLEN_MAX);
>> +                return;
>> +            }
>> +            if (!is_power_of_2(cpu->cfg.elen)) {
>> +                error_setg(errp,
>> +                       "Vector extension ELEN must be power of 2");
>> +                return;
>> +            }
>> +            if (cpu->cfg.elen > 64) {
>> +                error_setg(errp,
>> +                       "Vector extension ELEN must <= 64");
>> +                return;
>> +            }
>> +        }
>>
>>           set_misa(env, RVXLEN | target_misa);
>>       }
>> @@ -444,10 +484,14 @@ static Property riscv_cpu_properties[] = {
>>       DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
>>       DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
>>       DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>> +    DEFINE_PROP_BOOL("v", RISCVCPU, cfg.ext_v, false),
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
>> index 07e63016a7..bf2b4b55af 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -64,6 +64,7 @@
>>   #define RVA RV('A')
>>   #define RVF RV('F')
>>   #define RVD RV('D')
>> +#define RVV RV('V')
>>   #define RVC RV('C')
>>   #define RVS RV('S')
>>   #define RVU RV('U')
>> @@ -82,6 +83,8 @@ enum {
>>   #define PRIV_VERSION_1_10_0 0x00011000
>>   #define PRIV_VERSION_1_11_0 0x00011100
>>
>> +#define VEXT_VERSION_0_07_1 0x00000701
>> +
>>   #define TRANSLATE_PMP_FAIL 2
>>   #define TRANSLATE_FAIL 1
>>   #define TRANSLATE_SUCCESS 0
>> @@ -118,6 +121,7 @@ struct CPURISCVState {
>>       target_ulong badaddr;
>>
>>       target_ulong priv_ver;
>> +    target_ulong vext_ver;
>>       target_ulong misa;
>>       target_ulong misa_mask;
>>
>> @@ -226,12 +230,16 @@ typedef struct RISCVCPU {
>>           bool ext_c;
>>           bool ext_s;
>>           bool ext_u;
>> +        bool ext_v;
>>           bool ext_counters;
>>           bool ext_ifencei;
>>           bool ext_icsr;
>>
>>           char *priv_spec;
>>           char *user_spec;
>> +        char *vext_spec;
>> +        uint16_t vlen;
>> +        uint16_t elen;
>>           bool mmu;
>>           bool pmp;
>>       } cfg;
>> --
>> 2.23.0
>>


