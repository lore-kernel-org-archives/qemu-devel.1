Received: from eggs.gnu.org ([2001:4830:134:3::10]:47796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhjP-00085D-Nh
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhjM-0003mQ-KQ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:57:47 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhjM-0003le-ES
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:57:44 -0400
Received: by mail-qt0-x242.google.com with SMTP id c8-v6so6491405qtp.10
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 17:57:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe8cd74b-e9b3-06cd-48c2-b3daeedcb869@amsat.org>
Date: Thu, 28 Jun 2018 21:57:40 -0300
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/6] target/arm: Add ID_ISAR6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hi Richard,

On 06/28/2018 09:15 PM, Richard Henderson wrote:
> This register was added to aa32 state by ARMv8.2.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 1 +
>  target/arm/cpu.c    | 4 ++++
>  target/arm/cpu64.c  | 2 ++
>  target/arm/helper.c | 5 ++---
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 6a8441c2dd..1505ac936e 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -813,6 +813,7 @@ struct ARMCPU {
>      uint32_t id_isar3;
>      uint32_t id_isar4;
>      uint32_t id_isar5;
> +    uint32_t id_isar6;
>      uint64_t id_aa64pfr0;
>      uint64_t id_aa64pfr1;
>      uint64_t id_aa64dfr0;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 878cc6c7e8..de1a07a9f1 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1262,6 +1262,7 @@ static void cortex_m3_initfn(Object *obj)
>      cpu->id_isar3 = 0x01111110;
>      cpu->id_isar4 = 0x01310102;
>      cpu->id_isar5 = 0x00000000;
> +    cpu->id_isar6 = 0x00000000;
>  }
>  
>  static void cortex_m4_initfn(Object *obj)
> @@ -1288,6 +1289,7 @@ static void cortex_m4_initfn(Object *obj)
>      cpu->id_isar3 = 0x01111110;
>      cpu->id_isar4 = 0x01310102;
>      cpu->id_isar5 = 0x00000000;
> +    cpu->id_isar6 = 0x00000000;
>  }
>  
>  static void cortex_m33_initfn(Object *obj)
> @@ -1316,6 +1318,7 @@ static void cortex_m33_initfn(Object *obj)
>      cpu->id_isar3 = 0x01111131;
>      cpu->id_isar4 = 0x01310132;
>      cpu->id_isar5 = 0x00000000;
> +    cpu->id_isar6 = 0x00000000;
>      cpu->clidr = 0x00000000;
>      cpu->ctr = 0x8000c000;
>  }
> @@ -1366,6 +1369,7 @@ static void cortex_r5_initfn(Object *obj)
>      cpu->id_isar3 = 0x01112131;
>      cpu->id_isar4 = 0x0010142;
>      cpu->id_isar5 = 0x0;
> +    cpu->id_isar6 = 0x0;
>      cpu->mp_is_up = true;
>      cpu->pmsav7_dregion = 16;
>      define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 8040493d5c..d0581d59d8 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -139,6 +139,7 @@ static void aarch64_a57_initfn(Object *obj)
>      cpu->id_isar3 = 0x01112131;
>      cpu->id_isar4 = 0x00011142;
>      cpu->id_isar5 = 0x00011121;
> +    cpu->id_isar6 = 0;
>      cpu->id_aa64pfr0 = 0x00002222;
>      cpu->id_aa64dfr0 = 0x10305106;
>      cpu->pmceid0 = 0x00000000;
> @@ -199,6 +200,7 @@ static void aarch64_a53_initfn(Object *obj)
>      cpu->id_isar3 = 0x01112131;
>      cpu->id_isar4 = 0x00011142;
>      cpu->id_isar5 = 0x00011121;
> +    cpu->id_isar6 = 0;
>      cpu->id_aa64pfr0 = 0x00002222;
>      cpu->id_aa64dfr0 = 0x10305106;
>      cpu->id_aa64isar0 = 0x00011120;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a855da045b..e62f02d4e5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4851,11 +4851,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
>                .access = PL1_R, .type = ARM_CP_CONST,
>                .resetvalue = cpu->id_mmfr4 },
> -            /* 7 is as yet unallocated and must RAZ */
> -            { .name = "ID_ISAR7_RESERVED", .state = ARM_CP_STATE_BOTH,

You added this in

    if (arm_feature(env, ARM_FEATURE_V6)) {

Shouldn't this stay same and a new entry added later in

    if (arm_feature(env, ARM_FEATURE_V8)) {

?

> +            { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,

If added under ARM_FEATURE_V8, shouldn't this be ARM_CP_STATE_AA32?

>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
>                .access = PL1_R, .type = ARM_CP_CONST,
> -              .resetvalue = 0 },
> +              .resetvalue = cpu->id_isar6 },
>              REGINFO_SENTINEL
>          };
>          define_arm_cp_regs(cpu, v6_idregs);
> 
