Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7912EC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287A220989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3PNS14Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287A220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49964 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCeo-0007fQ-HV
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 17:02:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCdP-0006WS-Tp
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCdO-00089p-11
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:00:51 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hPCdN-00086U-KC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:00:49 -0400
Received: by mail-lj1-x242.google.com with SMTP id z1so6224848ljb.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=MYHj9Dbdit1cXIh7hx+IMUwz06aV7NYzbZYioQsb2Ps=;
	b=i3PNS14Y9BG2os/R4t82u0msCO3tOdcFnOyZetoMbujDaV63ET9N+/p4NpyfWGOAvS
	bu1SZG6dxciXxeQJ581JtBWzcBb75W43E8JEsFW/RqxBAsEO2KF2lqFtp8JHM+6MeC+R
	4rPrYJE5U7/HtB0fXpV3coSXQxfO+OXVd8kFJvNEEUydbGvjhZw4Dvk6q53CuiQ/w72m
	jIcm03L+0woTBGFV1rM34LsW/BRU6IxHps3pyHLD9GdSMXxYUuzoxQLk7EGTqt2d4tM6
	G9yWAXltNRc47F4EEY9wzw2T+YzwcJpEm4vRLqRkdBBT9U1K0NhJjr2YA2tdbQtzcjmr
	rfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=MYHj9Dbdit1cXIh7hx+IMUwz06aV7NYzbZYioQsb2Ps=;
	b=s5Lot+Ry8Vr8FcH+oYeHq2YaWlICIJ/R6PfxXVZB18zvlqUCQ6Lywb3iNe0U6w6uFQ
	GFEhrjvVFUkLXNE9//WOW9P4BOcxD7pG6VCypjIG6KlLan1RwhSCvINZR2fCFC7q7J/3
	RXTcbEFxUQuVtN7x9uM0d+2IMuH8zeIJhQ/jkQeoKLLHXHtqoQSdGVlekIwySymCin1E
	QP2Nj6GHrIfYa7Ulzf1by9392+3AoKJSojnxNjfrvrDp8P5eoNQKG1xFecuOVIrVmcA1
	FlDtckKUQbGk4dy/p3SJWQ8s7U30LVVFGzbmdhxrTHQLagnmHMkkoYYqGduPav/1En5Q
	m/oA==
X-Gm-Message-State: APjAAAXAi3BnGWjN4NSpmVpP2WgALYAo2GxREIYoirQfUocncK2qX50+
	WSiW8wqa3iXecdKDtzQXJYPkBU7URvRHdDbkUrK91Tzs
X-Google-Smtp-Source: APXvYqwu9AO+PjLuBJN0AFsakf99YdE5a2lZ3BEYwDBiy0+eShIwcIydo98XoY76+iYhv9CK9l0fSN4akb7+q5O9vNs=
X-Received: by 2002:a2e:824b:: with SMTP id j11mr6848747ljh.197.1557522047948; 
	Fri, 10 May 2019 14:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-37-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-37-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 May 2019 13:58:39 -0700
Message-ID: <CAKmqyKNy4o2MqD4wBSUOhbU0FXTD8e7BRuapPQZkFvUsoaHtUw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3 36/39] cpu: Remove CPU_COMMON
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

On Tue, May 7, 2019 at 5:32 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This macro is now always empty, so remove it.  This leaves the
> entire contents of CPUArchState under the control of the guest
> architecture.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/exec/cpu-defs.h | 2 --
>  target/alpha/cpu.h      | 3 ---
>  target/arm/cpu.h        | 4 +---
>  target/cris/cpu.h       | 2 --
>  target/hppa/cpu.h       | 3 ---
>  target/i386/cpu.h       | 4 +---
>  target/lm32/cpu.h       | 2 --
>  target/m68k/cpu.h       | 2 --
>  target/microblaze/cpu.h | 2 --
>  target/mips/cpu.h       | 2 --
>  target/moxie/cpu.h      | 3 ---
>  target/nios2/cpu.h      | 2 --
>  target/openrisc/cpu.h   | 2 --
>  target/ppc/cpu.h        | 2 --
>  target/riscv/cpu.h      | 4 ----
>  target/s390x/cpu.h      | 2 --
>  target/sh4/cpu.h        | 2 --
>  target/sparc/cpu.h      | 2 --
>  target/tilegx/cpu.h     | 2 --
>  target/tricore/cpu.h    | 2 --
>  target/unicore32/cpu.h  | 2 --
>  target/xtensa/cpu.h     | 2 --
>  22 files changed, 2 insertions(+), 51 deletions(-)
>
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index 4cde7d611c..1f75a97701 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -233,8 +233,6 @@ typedef struct CPUTLB { } CPUTLB;
>
>  #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
>
> -#define CPU_COMMON  /* Nothing */
> -
>  /*
>   * This structure must be placed in ArchCPU immedately
>   * before CPUArchState, as a field named "neg".
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index f4bb67c101..5bd90b7ce5 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -246,9 +246,6 @@ struct CPUAlphaState {
>      /* This alarm doesn't exist in real hardware; we wish it did.  */
>      uint64_t alarm_expire;
>
> -    /* Those resources are used only in QEMU core */
> -    CPU_COMMON
> -
>      int error_code;
>
>      uint32_t features;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 909cb4604d..135a16a351 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -643,9 +643,7 @@ typedef struct CPUARMState {
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> -    CPU_COMMON
> -
> -    /* Fields after CPU_COMMON are preserved across CPU reset. */
> +    /* Fields after this point are preserved across CPU reset. */
>
>      /* Internal CPU feature flags.  */
>      uint64_t features;
> diff --git a/target/cris/cpu.h b/target/cris/cpu.h
> index eeab483dba..6dc4502e9a 100644
> --- a/target/cris/cpu.h
> +++ b/target/cris/cpu.h
> @@ -163,8 +163,6 @@ typedef struct CPUCRISState {
>          /* Fields up to this point are cleared by a CPU reset */
>          struct {} end_reset_fields;
>
> -        CPU_COMMON
> -
>          /* Members from load_info on are preserved across resets.  */
>          void *load_info;
>  } CPUCRISState;
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 0661ff60c1..3ed2ac3c25 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -197,9 +197,6 @@ struct CPUHPPAState {
>      target_ureg cr_back[2];  /* back of cr17/cr18 */
>      target_ureg shadow[7];   /* shadow registers */
>
> -    /* Those resources are used only in QEMU core */
> -    CPU_COMMON
> -
>      /* ??? The number of entries isn't specified by the architecture.  */
>      /* ??? Implement a unified itlb/dtlb for the moment.  */
>      /* ??? We should use a more intelligent data structure.  */
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 43bb6ab841..8069e5b19d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1288,9 +1288,7 @@ typedef struct CPUX86State {
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> -    CPU_COMMON
> -
> -    /* Fields after CPU_COMMON are preserved across CPU reset. */
> +    /* Fields after this point are preserved across CPU reset. */
>
>      /* processor features (e.g. for CPUID insn) */
>      /* Minimum level/xlevel/xlevel2, based on CPU model + features */
> diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
> index 0ec898eb1d..563600a30a 100644
> --- a/target/lm32/cpu.h
> +++ b/target/lm32/cpu.h
> @@ -159,8 +159,6 @@ struct CPULM32State {
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> -    CPU_COMMON
> -
>      /* Fields from here on are preserved across CPU reset. */
>      uint32_t eba;       /* exception base address */
>      uint32_t deba;      /* debug exception base address */
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 096d1eb588..4e27ff677f 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -143,8 +143,6 @@ typedef struct CPUM68KState {
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> -    CPU_COMMON
> -
>      /* Fields from here on are preserved across CPU reset. */
>      uint32_t features;
>  } CPUM68KState;
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 732653caed..6a470a2492 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -266,8 +266,6 @@ struct CPUMBState {
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> -    CPU_COMMON
> -
>      /* These fields are preserved on reset.  */
>
>      struct {
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 2d9c5f26eb..b9e58ed883 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1021,8 +1021,6 @@ struct CPUMIPSState {
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> -    CPU_COMMON
> -
>      /* Fields from here on are preserved across CPU reset. */
>      CPUMIPSMVPContext *mvp;
>  #if !defined(CONFIG_USER_ONLY)
> diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
> index f5ee8a02f4..a62cca1817 100644
> --- a/target/moxie/cpu.h
> +++ b/target/moxie/cpu.h
> @@ -45,9 +45,6 @@ typedef struct CPUMoxieState {
>
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
> -
> -    CPU_COMMON
> -
>  } CPUMoxieState;
>
>  #include "qom/cpu.h"
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> index cd06a2ef41..75ea964632 100644
> --- a/target/nios2/cpu.h
> +++ b/target/nios2/cpu.h
> @@ -166,8 +166,6 @@ struct CPUNios2State {
>
>      uint32_t irq_pending;
>  #endif
> -
> -    CPU_COMMON
>  };
>
>  /**
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index e1acd48652..e3ffa618c9 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -286,8 +286,6 @@ typedef struct CPUOpenRISCState {
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> -    CPU_COMMON
> -
>      /* Fields from here on are preserved across CPU reset. */
>      uint32_t cpucfgr;         /* CPU configure register */
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index bb57496212..bbc8eb0cfc 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -999,8 +999,6 @@ struct CPUPPCState {
>      /* when a memory exception occurs, the access type is stored here */
>      int access_type;
>
> -    CPU_COMMON
> -
>      /* MMU context - only relevant for full system emulation */
>  #if !defined(CONFIG_USER_ONLY)
>  #if defined(TARGET_PPC64)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 30a01e8386..7086b336c6 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -169,10 +169,6 @@ struct CPURISCVState {
>
>      float_status fp_status;
>
> -    /* QEMU */
> -    CPU_COMMON
> -
> -    /* Fields from here on are preserved across CPU reset. */
>      QEMUTimer *timer; /* Internal timer */
>  };
>
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index ebcf7863e4..17d54f9587 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -114,8 +114,6 @@ struct CPUS390XState {
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> -    CPU_COMMON
> -
>  #if !defined(CONFIG_USER_ONLY)
>      uint32_t core_id; /* PoP "CPU address", same as cpu_index */
>      uint64_t cpuid;
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index 944854dbe0..974d46aae1 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -179,8 +179,6 @@ typedef struct CPUSH4State {
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> -    CPU_COMMON
> -
>      /* Fields from here on are preserved over CPU reset. */
>      int id;                    /* CPU model */
>
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index ae9ac07a9d..69e2199569 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -446,8 +446,6 @@ struct CPUSPARCState {
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> -    CPU_COMMON
> -
>      /* Fields from here on are preserved across CPU reset. */
>      target_ulong version;
>      uint32_t nwindows;
> diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
> index deb3e836ea..c2acb43c2b 100644
> --- a/target/tilegx/cpu.h
> +++ b/target/tilegx/cpu.h
> @@ -93,8 +93,6 @@ typedef struct CPUTLGState {
>
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
> -
> -    CPU_COMMON
>  } CPUTLGState;
>
>  #include "qom/cpu.h"
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index 43ef29b6bd..9fe501f98f 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -184,8 +184,6 @@ struct CPUTriCoreState {
>      int error_code;
>      uint32_t hflags;    /* CPU State */
>
> -    CPU_COMMON
> -
>      /* Internal CPU feature flags.  */
>      uint64_t features;
>
> diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
> index 140c590ec1..1ae0d78f4f 100644
> --- a/target/unicore32/cpu.h
> +++ b/target/unicore32/cpu.h
> @@ -55,8 +55,6 @@ typedef struct CPUUniCore32State {
>          float_status fp_status;
>      } ucf64;
>
> -    CPU_COMMON
> -
>      /* Internal CPU feature flags.  */
>      uint32_t features;
>
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 1bbb839bed..4e289dfa6e 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -511,8 +511,6 @@ typedef struct CPUXtensaState {
>
>      /* Watchpoints for DBREAK registers */
>      struct CPUWatchpoint *cpu_watchpoint[MAX_NDBREAK];
> -
> -    CPU_COMMON
>  } CPUXtensaState;
>
>  /**
> --
> 2.17.1
>
>

