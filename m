Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B09C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7894721D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7894721D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j77Fz-0005Hm-Lr
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 19:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j77F1-0004NO-3V
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j77Ez-00070w-Ew
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:41:26 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j77Ez-0006gc-2f; Wed, 26 Feb 2020 19:41:25 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.745074-0.00627842-0.248648;
 DS=CONTINUE|ham_system_inform|0.548379-0.000194022-0.451427;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16384; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.Gsxg7DS_1582764073; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Gsxg7DS_1582764073)
 by smtp.aliyun-inc.com(10.147.41.178);
 Thu, 27 Feb 2020 08:41:13 +0800
Subject: Re: [PATCH v5 3/4] target/riscv: support vector extension csr
To: Alistair Francis <alistair23@gmail.com>
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
 <20200221094531.61894-4-zhiwei_liu@c-sky.com>
 <CAKmqyKP7pOnG4LU-1gvY1h1TMuKQVEMSeAcCs1LKxKU61jELCQ@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <279e3359-0fb0-e925-eb35-8970e1b71ad4@c-sky.com>
Date: Thu, 27 Feb 2020 08:41:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAKmqyKP7pOnG4LU-1gvY1h1TMuKQVEMSeAcCs1LKxKU61jELCQ@mail.gmail.com>
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/27 2:42, Alistair Francis wrote:
> On Fri, Feb 21, 2020 at 1:45 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>> The v0.7.1 specification does not define vector status within mstatus.
>> A future revision will define the privileged portion of the vector status.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>   target/riscv/cpu_bits.h | 15 +++++++++
>>   target/riscv/csr.c      | 75 ++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 89 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index e99834856c..1f588ebc14 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -29,6 +29,14 @@
>>   #define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
>>   #define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR_NXA)
>>
>> +/* Vector Fixed-Point round model */
>> +#define FSR_VXRM_SHIFT      9
>> +#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
> Shouldn't these be FSCR_*?
Like other fields in fcsr, they all have been named by FSR_*, so I just 
name it like before.
>> +
>> +/* Vector Fixed-Point saturation flag */
>> +#define FSR_VXSAT_SHIFT     8
>> +#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)
> Same here, FCSR_*
>
>> +
>>   /* Control and Status Registers */
>>
>>   /* User Trap Setup */
>> @@ -48,6 +56,13 @@
>>   #define CSR_FRM             0x002
>>   #define CSR_FCSR            0x003
>>
>> +/* User Vector CSRs */
>> +#define CSR_VSTART          0x008
>> +#define CSR_VXSAT           0x009
>> +#define CSR_VXRM            0x00a
>> +#define CSR_VL              0xc20
>> +#define CSR_VTYPE           0xc21
>> +
>>   /* User Timers and Counters */
>>   #define CSR_CYCLE           0xc00
>>   #define CSR_TIME            0xc01
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index 0e34c292c5..9cd2b418bf 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -46,6 +46,10 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
>>   static int fs(CPURISCVState *env, int csrno)
>>   {
>>   #if !defined(CONFIG_USER_ONLY)
>> +    /* loose check condition for fcsr in vector extension */
>> +    if ((csrno == CSR_FCSR) && (env->misa & RVV)) {
>> +        return 0;
>> +    }
>>       if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>>           return -1;
>>       }
>> @@ -53,6 +57,14 @@ static int fs(CPURISCVState *env, int csrno)
>>       return 0;
>>   }
>>
>> +static int vs(CPURISCVState *env, int csrno)
>> +{
>> +    if (env->misa & RVV) {
>> +        return 0;
>> +    }
>> +    return -1;
>> +}
>> +
>>   static int ctr(CPURISCVState *env, int csrno)
>>   {
>>   #if !defined(CONFIG_USER_ONLY)
>> @@ -160,6 +172,10 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
>>   #endif
>>       *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
>>           | (env->frm << FSR_RD_SHIFT);
>> +    if (vs(env, csrno) >= 0) {
>> +        *val |= (env->vxrm << FSR_VXRM_SHIFT)
>> +                | (env->vxsat << FSR_VXSAT_SHIFT);
>> +    }
>>       return 0;
>>   }
>>
>> @@ -172,10 +188,62 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>>       env->mstatus |= MSTATUS_FS;
>>   #endif
>>       env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
>> +    if (vs(env, csrno) >= 0) {
>> +        env->vxrm = (val & FSR_VXRM) >> FSR_VXRM_SHIFT;
>> +        env->vxsat = (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
>> +    }
>>       riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
>>       return 0;
>>   }
>>
>> +static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
>> +{
>> +    *val = env->vtype;
>> +    return 0;
>> +}
>> +
>> +static int read_vl(CPURISCVState *env, int csrno, target_ulong *val)
>> +{
>> +    *val = env->vl;
>> +    return 0;
>> +}
>> +
>> +static int read_vxrm(CPURISCVState *env, int csrno, target_ulong *val)
>> +{
>> +    *val = env->vxrm;
>> +    return 0;
>> +}
>> +
>> +static int read_vxsat(CPURISCVState *env, int csrno, target_ulong *val)
>> +{
>> +    *val = env->vxsat;
>> +    return 0;
>> +}
>> +
>> +static int read_vstart(CPURISCVState *env, int csrno, target_ulong *val)
>> +{
>> +    *val = env->vstart;
>> +    return 0;
>> +}
>> +
>> +static int write_vxrm(CPURISCVState *env, int csrno, target_ulong val)
>> +{
>> +    env->vxrm = val;
>> +    return 0;
>> +}
>> +
>> +static int write_vxsat(CPURISCVState *env, int csrno, target_ulong val)
>> +{
>> +    env->vxsat = val;
>> +    return 0;
>> +}
>> +
>> +static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
>> +{
>> +    env->vstart = val;
>> +    return 0;
>> +}
> Can you keep these in read/write order? So read_vxrm() then
> write_vxrm() for example.
OK.
> Otherwise the patch looks good :)
>
> Alistair
>
>> +
>>   /* User Timers and Counters */
>>   static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
>>   {
>> @@ -877,7 +945,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>>       [CSR_FFLAGS] =              { fs,   read_fflags,      write_fflags      },
>>       [CSR_FRM] =                 { fs,   read_frm,         write_frm         },
>>       [CSR_FCSR] =                { fs,   read_fcsr,        write_fcsr        },
>> -
>> +    /* Vector CSRs */
>> +    [CSR_VSTART] =              { vs,   read_vstart,      write_vstart      },
>> +    [CSR_VXSAT] =               { vs,   read_vxsat,       write_vxsat       },
>> +    [CSR_VXRM] =                { vs,   read_vxrm,        write_vxrm        },
>> +    [CSR_VL] =                  { vs,   read_vl                             },
>> +    [CSR_VTYPE] =               { vs,   read_vtype                          },
>>       /* User Timers and Counters */
>>       [CSR_CYCLE] =               { ctr,  read_instret                        },
>>       [CSR_INSTRET] =             { ctr,  read_instret                        },
>> --
>> 2.23.0
>>


