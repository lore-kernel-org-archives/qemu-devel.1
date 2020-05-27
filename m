Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 01:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3969320899
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 01:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3969320899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdlLc-0006bJ-D2
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 21:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jdlL6-0005xI-B8; Tue, 26 May 2020 21:58:40 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jdlL3-0006hw-Tv; Tue, 26 May 2020 21:58:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.04467154|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00399701-0.00011231-0.995891;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03303; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=7; RT=7; SR=0; TI=SMTPD_---.He5taE4_1590544707; 
Received: from 30.225.208.79(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.He5taE4_1590544707)
 by smtp.aliyun-inc.com(10.147.42.253);
 Wed, 27 May 2020 09:58:27 +0800
Subject: Re: [PATCH v3 3/9] target/riscv: Add the lowRISC Ibex CPU
To: Alistair Francis <alistair23@gmail.com>
References: <cover.1589923785.git.alistair.francis@wdc.com>
 <24ba2634ff761e7a1e6b28b15929b03db3f59008.1589923785.git.alistair.francis@wdc.com>
 <2c695b2b-a292-61ff-bd2b-5f2ff2b48271@c-sky.com>
 <CAKmqyKMKGpNT+RRnNWCTzVjYppEpE+T2DZVDFiVcvnecYtu2kQ@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <27acc4bd-ae60-ad7e-0efb-105d4c20e132@c-sky.com>
Date: Wed, 27 May 2020 09:58:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMKGpNT+RRnNWCTzVjYppEpE+T2DZVDFiVcvnecYtu2kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 21:58:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, UNPARSEABLE_RELAY=0.001,
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/5/27 1:12, Alistair Francis wrote:
> On Fri, May 22, 2020 at 12:51 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>>
>>
>> On 2020/5/20 5:31, Alistair Francis wrote:
>>> Ibex is a small and efficient, 32-bit, in-order RISC-V core with
>>> a 2-stage pipeline that implements the RV32IMC instruction set
>>> architecture.
>>>
>>> For more details on lowRISC see here:
>>> https://github.com/lowRISC/ibex
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> Reviewed-by: Bin Meng <bin.meng@windriver.com>
>>> ---
>>>    target/riscv/cpu.h |  1 +
>>>    target/riscv/cpu.c | 10 ++++++++++
>>>    2 files changed, 11 insertions(+)
>>>
>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>> index d0e7f5b9c5..8733d7467f 100644
>>> --- a/target/riscv/cpu.h
>>> +++ b/target/riscv/cpu.h
>>> @@ -35,6 +35,7 @@
>>>    #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
>>>    #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>>>    #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>>> +#define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>>>    #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
>>>    #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
>>>    #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index 5eb3c02735..eb2bbc87ae 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -156,6 +156,15 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>>>        set_feature(env, RISCV_FEATURE_PMP);
>>>    }
>>>
>>> +static void rv32imcu_nommu_cpu_init(Object *obj)
>>> +{
>>> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
>>> +    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
>>> +    set_priv_version(env, PRIV_VERSION_1_10_0);
>>> +    set_resetvec(env, 0x8090);
>> Hi Alistair,
>>
>> I see all RISC-V cpus  have an reset vector which acts as the first pc
>> when machine boots up.
>> However, the first pc is more like an attribute of a machine, not a cpu.
> In general it seems to be a CPU property. I assume that some CPUs
> would allow the reset vector to be selectable though, in which case it
> becomes a board property.
>
>> Another reason is that the cpu names are a combination of ISA.
>> Then the cpus from different vendors may have same ISA, with different
>> reset vectors.
>>
>> Do you think so?
> If you are worried about CPUs with different vectors we could always
> make it a property in the future and have boards override it. I don't
> think we need that yet (only 1 CPU is different) but it is an easy
> future change.
I think your are right. A cpu reset vector property is better. If there 
is a conflict in the future,
we can add the property there.

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Zhiwei
> Alistair
>
>> Zhiwei
>>> +    set_feature(env, RISCV_FEATURE_PMP);
>>> +}
>>> +
>>>    static void rv32imacu_nommu_cpu_init(Object *obj)
>>>    {
>>>        CPURISCVState *env = &RISCV_CPU(obj)->env;
>>> @@ -619,6 +628,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>>        DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
>>>    #if defined(TARGET_RISCV32)
>>>        DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
>>> +    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
>>>        DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
>>>        DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
>>>        DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
>>


