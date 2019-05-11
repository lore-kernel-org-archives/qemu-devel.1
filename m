Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5A6C04AB1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 13:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1745920989
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 13:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSXwghe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1745920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPRxL-0006L4-1M
	for qemu-devel@archiver.kernel.org; Sat, 11 May 2019 09:22:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hPRwS-000623-Kd
	for qemu-devel@nongnu.org; Sat, 11 May 2019 09:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hPRwQ-000459-1Y
	for qemu-devel@nongnu.org; Sat, 11 May 2019 09:21:32 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hPRwP-00044o-Po
	for qemu-devel@nongnu.org; Sat, 11 May 2019 09:21:29 -0400
Received: by mail-oi1-x244.google.com with SMTP id v10so6452585oib.1
	for <qemu-devel@nongnu.org>; Sat, 11 May 2019 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=gwCQIs3SZ7XWutnattAw76CGgjnbTSw6RvTsRHo+v7Y=;
	b=iSXwghe6Ww5JFMxRlLkbDqLUGdkpdA56osVmY8p7JpZO+NQN2VSS8U17CF1ATuNpXM
	T0AXBPqIk6oNOEpeVtHmUw0a/4B/WAhOL7zL0wTFRj+bpphCN27EG8srhvtCFGCqZQjq
	sHJZTygOkf1QA+mTGrzc3Kc/cHhx63AUMsIY8OIHPzT12mNaiVSp7FnKvU3rrsw3OTYo
	SFNS12rp85YU//UGPO0WGcoC8eidQFDbdzvNUlXMeVSFKS73eDt+ZILgm5H2fvmekiTJ
	CL/8trfCzg3vGk6d8CgPzN4urPzIao9fhj4foOU9UbuJxPKRG8QfOJ5UkaD8yccN8t2s
	FBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=gwCQIs3SZ7XWutnattAw76CGgjnbTSw6RvTsRHo+v7Y=;
	b=IxQOYb0jhUdJEqfRZR+/5e94NDJR7vwVmbmU6fXb61iV+evu9nOEduusauRtSUPZIq
	EMeuXZ9odmjzzq5s/Us+U2kqE0WI3L23l038seV/KEMEaydr4a7PtokqFZ/OEBIjHJ/f
	+589k519HtiojiiKmVvwvk1HtkhAeYxj3/155jHYoHz77km4/18nEngaWpP2yf6edi2+
	9MVd1djeUOheZV+6ZOJTGPoL8EPL4YYLpfM2ux7v6fD1mQOUQvLzLYmXXBAzFiK3jLCH
	Fs8EsJxr/ClDT7EsgzJ9Hfi7ub/z29MzkdTcHMi4qu4UfqdRA6q8JxLYtPWHZfucQb2Y
	1Nzg==
X-Gm-Message-State: APjAAAX1bUdt9Xl8s+NRo7PvdrNcbrl0y85U80D3MD15wLeANchWJKdS
	qpiXXpFw8G/Z/PsFMtsc/uRFHv6UvSeZICn1KpU=
X-Google-Smtp-Source: APXvYqyz3NO7tJfcvlcPbU9m6vwSj1YnBTtVXdG0NEILKqVOQMPc6zqlrJ5Rt/QhtnsFf00HoicO91yH96TtMZMeGO4=
X-Received: by 2002:aca:6086:: with SMTP id u128mr7616672oib.79.1557580888616; 
	Sat, 11 May 2019 06:21:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 11 May 2019 06:21:27
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 11 May 2019 06:21:27
	-0700 (PDT)
In-Reply-To: <20190508000641.19090-37-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-37-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 11 May 2019 15:21:27 +0200
Message-ID: <CAL1e-=jBvmqxMHUaQQ_cfNJ42UO4j8q-UeKHzfhydx+HSQHk9w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 8, 2019 2:32 AM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> This macro is now always empty, so remove it.  This leaves the
> entire contents of CPUArchState under the control of the guest
> architecture.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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

Why is this comment line deleted in this patch? If you want to delete this
line, you should do it in a separate patch, with a separate explanation, as
the comment has nothing to do with CPU_COMMON.

Thanks,
Aleksandar

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
