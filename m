Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D205C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D40217D6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/VZlo/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D40217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60677 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOppv-0002mq-VU
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:40:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpoI-0001zZ-EL
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpoF-0007P1-OS
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:38:34 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOpoD-0007N7-DZ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:38:30 -0400
Received: by mail-lj1-x241.google.com with SMTP id w1so628379ljw.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=w/+zCG/HTYnuP54zXDikeHz5BqH+bYNP3/1n3M/MzBc=;
	b=k/VZlo/3T7veOfOQ2b6UQKyS1XZomvoAxuMXFIH08DkeCMc36ViLf96ryT1zQ5Zb1Y
	Mpz4TIC+Ut7mU1L5DcPOaIQeWNCiVLNOufRn4Dvd3YhoOoWwvfixThX7gWfoFGmoqWWs
	nCm3BIbAKK/fo6hgozBVIQsPQXUbl/c4CmKSdm6448P9kU615d29XuGOp0f4Aysno+Zn
	UnArNweEacBmXc0gEwTlf+1L8vHmBFu6cATaL7LT4YUtZRWFRFTT5guRZV7IZe71SCO1
	9zmHvmj3nCsk5a8YFplWAvwkUZgKFCfUcFMjvYMMa1kzNpjbOuV86Af7/++Y+tkFuYv/
	O2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=w/+zCG/HTYnuP54zXDikeHz5BqH+bYNP3/1n3M/MzBc=;
	b=M+bPqsh5gfj2uQecyEVTdEvwODDQiVhjp3xz4F48HKLk7Asb6oQxdDayncE/g+2NPw
	QM0WiRfvf+X2zU9PbrwUkrDxZ2GHUsZ45PMh3zD+ExbSjhDsV5lWr9PMA880R2LeETfV
	3HgW6eWhFo0nj//HvI0N3vhuBwT2JYmJ0zn2YTHkKXZ4kEJm1MUg5JWujSDZLm0MGkbO
	ds8uCKHlAd/Eqyx6UeiCrB1y5ebuDlWcZlCkj1pDBuQDnKe/Vk7PU8x/M/bj4m67Y/HY
	Sg5nsIxxSJdjRZ9mLko4QAIKrRLSFkB+FdVBIJ7oUUoLmKDcu+u5GGKt/nxn4Yho6008
	oLlg==
X-Gm-Message-State: APjAAAVmrntOlDDb+j7uYojdqaMG8QjtqTGQMiADBjyd4eqlSucuQBiI
	MEtH7KI2tpuNr+ZC45oA8s1YVMiTpcO3YUGmVdI=
X-Google-Smtp-Source: APXvYqwjRhdeHOQPk9IDT5/kdHEow1zIloJtNlxcbgXkVdycEjDO+3jvBdKqUCsNxa39EqHc5zZZAcD4exMlQi/Zxcs=
X-Received: by 2002:a2e:9c89:: with SMTP id x9mr3510559lji.28.1557434308059;
	Thu, 09 May 2019 13:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-34-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-34-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 13:36:21 -0700
Message-ID: <CAKmqyKNyQNvivOsGAPtzJAXkbfX2xEga-XbF+7NjXUHZsnKDeQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v3 33/39] cpu: Introduce
 CPUNegativeOffsetState
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:26 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Nothing in there so far, but all of the plumbing done
> within the target ArchCPU state.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/exec/cpu-all.h  | 24 ++++++++++++++++++++++++
>  include/exec/cpu-defs.h |  8 ++++++++
>  target/alpha/cpu.h      |  1 +
>  target/arm/cpu.h        |  1 +
>  target/cris/cpu.h       |  1 +
>  target/hppa/cpu.h       |  1 +
>  target/i386/cpu.h       |  1 +
>  target/lm32/cpu.h       |  1 +
>  target/m68k/cpu.h       |  1 +
>  target/microblaze/cpu.h |  5 +++--
>  target/mips/cpu.h       |  1 +
>  target/moxie/cpu.h      |  1 +
>  target/nios2/cpu.h      |  2 ++
>  target/openrisc/cpu.h   |  2 +-
>  target/ppc/cpu.h        |  2 ++
>  target/riscv/cpu.h      |  1 +
>  target/s390x/cpu.h      |  1 +
>  target/sh4/cpu.h        |  1 +
>  target/sparc/cpu.h      |  1 +
>  target/tilegx/cpu.h     |  1 +
>  target/tricore/cpu.h    |  1 +
>  target/unicore32/cpu.h  |  1 +
>  target/xtensa/cpu.h     |  1 +
>  23 files changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 71154070a7..5ae83405c8 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -404,4 +404,28 @@ static inline CPUState *env_cpu(CPUArchState *env)
>      return &env_archcpu(env)->parent_obj;
>  }
>
> +/**
> + * env_neg(env)
> + * @env: The architecture environment
> + *
> + * Return the CPUNegativeOffsetState associated with the environment.
> + */
> +static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
> +{
> +    ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
> +    return &arch_cpu->neg;
> +}
> +
> +/**
> + * cpu_neg(cpu)
> + * @cpu: The generic CPUState
> + *
> + * Return the CPUNegativeOffsetState associated with the cpu.
> + */
> +static inline CPUNegativeOffsetState *cpu_neg(CPUState *cpu)
> +{
> +    ArchCPU *arch_cpu = container_of(cpu, ArchCPU, parent_obj);
> +    return &arch_cpu->neg;
> +}
> +
>  #endif /* CPU_ALL_H */
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index fbe8945606..ad97991faf 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -227,4 +227,12 @@ typedef struct CPUTLB {
>
>  #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
>
> +/*
> + * This structure must be placed in ArchCPU immedately
> + * before CPUArchState, as a field named "neg".
> + */
> +typedef struct CPUNegativeOffsetState {
> +    /* Empty */
> +} CPUNegativeOffsetState;
> +
>  #endif
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 66782cf5d4..f4bb67c101 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -267,6 +267,7 @@ struct AlphaCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUAlphaState env;
>
>      /* This alarm doesn't exist in real hardware; we wish it did.  */
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 23beb1de9a..909cb4604d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -719,6 +719,7 @@ struct ARMCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUARMState env;
>
>      /* Coprocessor information */
> diff --git a/target/cris/cpu.h b/target/cris/cpu.h
> index c19fdcec1e..eeab483dba 100644
> --- a/target/cris/cpu.h
> +++ b/target/cris/cpu.h
> @@ -180,6 +180,7 @@ struct CRISCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUCRISState env;
>  };
>
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 58b2bf2933..0661ff60c1 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -218,6 +218,7 @@ struct HPPACPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUHPPAState env;
>      QEMUTimer *alarm_timer;
>  };
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index a9cfb42b22..43bb6ab841 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1368,6 +1368,7 @@ struct X86CPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUX86State env;
>
>      bool hyperv_vapic;
> diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
> index 4234a439a3..0ec898eb1d 100644
> --- a/target/lm32/cpu.h
> +++ b/target/lm32/cpu.h
> @@ -186,6 +186,7 @@ struct LM32CPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPULM32State env;
>
>      uint32_t revision;
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 02fbff3625..096d1eb588 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -160,6 +160,7 @@ struct M68kCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUM68KState env;
>  };
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 1becb9270b..732653caed 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -287,6 +287,9 @@ struct MicroBlazeCPU {
>
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
> +    CPUMBState env;
> +
>      /* Microblaze Configuration Settings */
>      struct {
>          bool stackprot;
> @@ -306,8 +309,6 @@ struct MicroBlazeCPU {
>          char *version;
>          uint8_t pvr;
>      } cfg;
> -
> -    CPUMBState env;
>  };
>
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 52286fcb0e..2d9c5f26eb 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1048,6 +1048,7 @@ struct MIPSCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUMIPSState env;
>  };
>
> diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
> index ebe1c66f52..f5ee8a02f4 100644
> --- a/target/moxie/cpu.h
> +++ b/target/moxie/cpu.h
> @@ -87,6 +87,7 @@ typedef struct MoxieCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUMoxieState env;
>  } MoxieCPU;
>
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> index 96c8193179..cd06a2ef41 100644
> --- a/target/nios2/cpu.h
> +++ b/target/nios2/cpu.h
> @@ -181,7 +181,9 @@ typedef struct Nios2CPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUNios2State env;
> +
>      bool mmu_present;
>      uint32_t pid_num_bits;
>      uint32_t tlb_num_ways;
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index 150227d450..e1acd48652 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -313,8 +313,8 @@ typedef struct OpenRISCCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUOpenRISCState env;
> -
>  } OpenRISCCPU;
>
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f970853556..bb57496212 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1184,7 +1184,9 @@ struct PowerPCCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUPPCState env;
> +
>      int vcpu_id;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 818692dde5..30a01e8386 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -208,6 +208,7 @@ typedef struct RISCVCPU {
>      /*< private >*/
>      CPUState parent_obj;
>      /*< public >*/
> +    CPUNegativeOffsetState neg;
>      CPURISCVState env;
>  } RISCVCPU;
>
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 971dc0ccbd..ebcf7863e4 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -156,6 +156,7 @@ struct S390CPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUS390XState env;
>      S390CPUModel *model;
>      /* needed for live migration */
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index 3f2f4043e0..944854dbe0 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -204,6 +204,7 @@ struct SuperHCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUSH4State env;
>  };
>
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index b170dd592e..ae9ac07a9d 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -529,6 +529,7 @@ struct SPARCCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUSPARCState env;
>  };
>
> diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
> index 643b7dbd17..deb3e836ea 100644
> --- a/target/tilegx/cpu.h
> +++ b/target/tilegx/cpu.h
> @@ -135,6 +135,7 @@ typedef struct TileGXCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUTLGState env;
>  } TileGXCPU;
>
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index 581e68e37c..43ef29b6bd 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -205,6 +205,7 @@ struct TriCoreCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUTriCoreState env;
>  };
>
> diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
> index abb36b5d48..140c590ec1 100644
> --- a/target/unicore32/cpu.h
> +++ b/target/unicore32/cpu.h
> @@ -73,6 +73,7 @@ struct UniCore32CPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUUniCore32State env;
>  };
>
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 748b6fca25..1bbb839bed 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -526,6 +526,7 @@ struct XtensaCPU {
>      CPUState parent_obj;
>      /*< public >*/
>
> +    CPUNegativeOffsetState neg;
>      CPUXtensaState env;
>  };
>
> --
> 2.17.1
>
>

