Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A43C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CE920812
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CE920812
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc2T1-0005YN-Qn
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 03:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jc2SW-00056R-4g; Fri, 22 May 2020 03:51:12 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jc2ST-0003lM-Js; Fri, 22 May 2020 03:51:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.04873125|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_alarm|0.00744927-0.000133353-0.992417; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01a16367; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.Hc2qMLJ_1590133855; 
Received: from 30.225.208.54(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Hc2qMLJ_1590133855)
 by smtp.aliyun-inc.com(10.147.42.241);
 Fri, 22 May 2020 15:50:57 +0800
Subject: Re: [PATCH v3 3/9] target/riscv: Add the lowRISC Ibex CPU
To: Alistair Francis <Alistair.Francis@wdc.com>
References: <cover.1589923785.git.alistair.francis@wdc.com>
 <24ba2634ff761e7a1e6b28b15929b03db3f59008.1589923785.git.alistair.francis@wdc.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <2c695b2b-a292-61ff-bd2b-5f2ff2b48271@c-sky.com>
Date: Fri, 22 May 2020 15:50:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <24ba2634ff761e7a1e6b28b15929b03db3f59008.1589923785.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 03:51:00
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
Cc: philmd@redhat.com, Palmer Dabbelt <palmer@dabbelt.com>, bmeng.cn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/5/20 5:31, Alistair Francis wrote:
> Ibex is a small and efficient, 32-bit, in-order RISC-V core with
> a 2-stage pipeline that implements the RV32IMC instruction set
> architecture.
>
> For more details on lowRISC see here:
> https://github.com/lowRISC/ibex
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> ---
>   target/riscv/cpu.h |  1 +
>   target/riscv/cpu.c | 10 ++++++++++
>   2 files changed, 11 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d0e7f5b9c5..8733d7467f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -35,6 +35,7 @@
>   #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
>   #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>   #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
> +#define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>   #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
>   #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
>   #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5eb3c02735..eb2bbc87ae 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -156,6 +156,15 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>       set_feature(env, RISCV_FEATURE_PMP);
>   }
>   
> +static void rv32imcu_nommu_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
> +    set_priv_version(env, PRIV_VERSION_1_10_0);
> +    set_resetvec(env, 0x8090);
Hi Alistair,

I see all RISC-V cpus  have an reset vector which acts as the first pc 
when machine boots up.
However, the first pc is more like an attribute of a machine, not a cpu.

Another reason is that the cpu names are a combination of ISA.
Then the cpus from different vendors may have same ISA, with different 
reset vectors.

Do you think so?

Zhiwei
> +    set_feature(env, RISCV_FEATURE_PMP);
> +}
> +
>   static void rv32imacu_nommu_cpu_init(Object *obj)
>   {
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
> @@ -619,6 +628,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
>   #if defined(TARGET_RISCV32)
>       DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
>       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
>       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
>       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),


