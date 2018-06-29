Received: from eggs.gnu.org ([2001:4830:134:3::10]:60746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYoxj-0005uy-3E
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYoxi-0001z9-3r
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:41:03 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYoxh-0001y7-MF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:41:02 -0400
Received: by mail-ot0-x244.google.com with SMTP id w22-v6so9139253otk.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 01:41:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-6-richard.henderson@linaro.org>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 09:40:40 +0100
Message-ID: <CAFEAcA8zTOm6eesQVF_1_VY=JsVGpvoWstBwfL32ggARPPzOnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/6] target/arm: Add ID_ISAR6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 June 2018 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
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

The ARMCPU struct fields should all be initially cleared to
zero, so you don't really need to explicitly zero-initialize
isar6 all over the place like this. (Compare isar5, which is
I think only set in CPUs that are new enough that their TRMs
mentioned it.) In particular it's somewhat out of place to
zero it in the m3/m4/m33 initfns, since there is no such
register in the v8M Arm ARM. On the other hand it doesn't hurt.

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
> +            { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
>                .access = PL1_R, .type = ARM_CP_CONST,
> -              .resetvalue = 0 },
> +              .resetvalue = cpu->id_isar6 },
>              REGINFO_SENTINEL
>          };
>          define_arm_cp_regs(cpu, v6_idregs);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
