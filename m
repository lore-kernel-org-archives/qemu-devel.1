Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5169FC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 00:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5D5206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 00:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPv0beQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5D5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57187 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGBtP-0005SJ-UR
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 20:24:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hGBsg-00059L-81
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 20:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hGBsc-00015n-OJ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 20:23:22 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hGBsc-000143-Bj; Mon, 15 Apr 2019 20:23:18 -0400
Received: by mail-lf1-x142.google.com with SMTP id u17so14529396lfi.3;
	Mon, 15 Apr 2019 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=fzBFY8uhtToBEgg6zq34CnLkRBXtozoWkO12/xnHxfU=;
	b=YPv0beQiYUBRhA7GQEM+3Ua/bXdEdsCdFgF5qskWDML35aVHdGdiRN69bkiDSQykZ2
	pVjybVpCs5vj1PzLMUd1e9OME/kka//n16ugHcYSuTIVHz91crL1UNmcwbeMQ8JHKvLE
	TRaIu/KDrO3Y77QWRsZuASdQMPlvZb8nxDNIPHOlIvV3/Y6HpFE1RlydqFVMUajE4T+4
	Y1DKnCiZfYRFPauqIYS4NwB1LmM4068h9IxnVPhkX++NuusXmDFJGst8Jg5yjVfieF6J
	gebKB3le7UO1OSZVKXkWmjxkOA9m0RiTh9Xtsp/gj4TUyuTWJxIGvqSYs9iL2KTwkIxy
	mX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=fzBFY8uhtToBEgg6zq34CnLkRBXtozoWkO12/xnHxfU=;
	b=J0HDKWVIJwiT7Jg01IImHI/wsoNhGOv1+NuI4bu7H2H8uUVgQnXdgj8K61cmCnBG8h
	CopZJ9QNvRsIN23bHEbh/xdbWuFd3uj3UV8zq+g+fR8X8Ljnb25H7/f72mnGfwDH9cEr
	sWAqAsZYv6rVm1MNQfmEAwhpBKQ8u2HIyEH5Km5d5zYKUYjlRIRt1ub3ayZvLk4llQJj
	qRJwFT3gOu6gejrRqIWAc2gb2glNyLjUAdcqk5V3zSoEa0YD7Gyz4UX1jzl/E46opav+
	hTRvV5hqR6YsfhM/4jNl0Au7XLCU/EnxA/gtbE7CxCxSV7W0GK8Bdm2l/myotrgKCy00
	558g==
X-Gm-Message-State: APjAAAXzkSqcbybEOJ3DvasUh3QapKXK9uG4NYGsXmH29KUAzbSRSbpU
	pHhoHObHwrrBZqhxG20Fzgu3vaV2VsSj/fZPJPA=
X-Google-Smtp-Source: APXvYqz7mGPP+9qpULGFlmFC5c6vLVo/7+DzeixiQxjLjhKQTxgSjwVI9B8gg5/iazhwpRo9MdwBTtc5KgGqTUOMdss=
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr26261627lfi.56.1555374196335; 
	Mon, 15 Apr 2019 17:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <CANnJOVEkpkBAOo566s1BJk9YQBVeNkf2kpbS_kdjkn9j=3i1VA@mail.gmail.com>
In-Reply-To: <CANnJOVEkpkBAOo566s1BJk9YQBVeNkf2kpbS_kdjkn9j=3i1VA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Apr 2019 17:21:36 -0700
Message-ID:
 <CAKmqyKPM=XUyF+KweO2CLBQ3bEuu_BTU2fu+R7R09rV-1O9TkQ@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Expose time CSRs when
 allowed by [m|s]counteren
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416002136.kWPsHo8ZTv32kCsdAzPFAb8qP9rTbAxsrgQRIo50vRs@z>

On Fri, Apr 12, 2019 at 12:04 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>
> Currently mcounteren.TM acts as though it is hardwired to zero, even though
> QEMU
> allows it to be set. This change resolves the issue by allowing reads to the
> time and timeh control registers when running in a privileged mode where
> such
> accesses are allowed.
>
> Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
> ---
>  hw/riscv/sifive_clint.c |  1 +
>  target/riscv/cpu.c      | 14 ++++++++++++++
>  target/riscv/cpu.h      |  2 ++
>  target/riscv/csr.c      | 17 +++++++++++------
>  4 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> index d4c159e937..3ad4fe6139 100644
> --- a/hw/riscv/sifive_clint.c
> +++ b/hw/riscv/sifive_clint.c
> @@ -237,6 +237,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr
> size, uint32_t num_harts,
>          env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                    &sifive_clint_timer_cb, cpu);
>          env->timecmp = 0;
> +        env->time_freq = SIFIVE_CLINT_TIMEBASE_FREQ;

Why do you need to set this here?

Alistair

>      }
>
>      DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_CLINT);
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d61bce6d55..ff17d54691 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -103,12 +103,20 @@ static void set_resetvec(CPURISCVState *env, int
> resetvec)
>  #endif
>  }
>
> +static void set_time_freq(CPURISCVState *env, uint64_t freq)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    env->time_freq = freq;
> +#endif
> +}
> +
>  static void riscv_any_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
> +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>  }
>
>  #if defined(TARGET_RISCV32)
> @@ -121,6 +129,7 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
>      set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>      set_feature(env, RISCV_FEATURE_PMP);
> +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>  }
>
>  static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
> @@ -131,6 +140,7 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>      set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>      set_feature(env, RISCV_FEATURE_PMP);
> +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>  }
>
>  static void rv32imacu_nommu_cpu_init(Object *obj)
> @@ -140,6 +150,7 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_PMP);
> +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>  }
>
>  #elif defined(TARGET_RISCV64)
> @@ -152,6 +163,7 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
>      set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>      set_feature(env, RISCV_FEATURE_PMP);
> +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>  }
>
>  static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
> @@ -162,6 +174,7 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>      set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>      set_feature(env, RISCV_FEATURE_PMP);
> +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>  }
>
>  static void rv64imacu_nommu_cpu_init(Object *obj)
> @@ -171,6 +184,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_PMP);
> +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>  }
>
>  #endif
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 20bce8742e..67b1769ad3 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -173,7 +173,9 @@ struct CPURISCVState {
>      /* temporary htif regs */
>      uint64_t mfromhost;
>      uint64_t mtohost;
> +
>      uint64_t timecmp;
> +    uint64_t time_freq;
>
>      /* physical memory protection */
>      pmp_table_t pmp_state;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e1d91b6c60..6083c782a1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -191,22 +191,31 @@ static int read_instreth(CPURISCVState *env, int
> csrno, target_ulong *val)
>  }
>  #endif /* TARGET_RISCV32 */
>
> -#if defined(CONFIG_USER_ONLY)
>  static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> +#if !defined(CONFIG_USER_ONLY)
> +    *val = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                    env->time_freq, NANOSECONDS_PER_SECOND);
> +#else
>      *val = cpu_get_host_ticks();
> +#endif
>      return 0;
>  }
>
>  #if defined(TARGET_RISCV32)
>  static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> +#if !defined(CONFIG_USER_ONLY)
> +    *val = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                    env->time_freq, NANOSECONDS_PER_SECOND) >> 32;
> +#else
>      *val = cpu_get_host_ticks() >> 32;
> +#endif
>      return 0;
>  }
>  #endif
>
> -#else /* CONFIG_USER_ONLY */
> +#if !defined(CONFIG_USER_ONLY)
>
>  /* Machine constants */
>
> @@ -854,14 +863,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =
> {
>      [CSR_INSTRETH] =            { ctr,
> read_instreth                       },
>  #endif
>
> -    /* User-level time CSRs are only available in linux-user
> -     * In privileged mode, the monitor emulates these CSRs */
> -#if defined(CONFIG_USER_ONLY)
>      [CSR_TIME] =                { ctr,
> read_time                           },
>  #if defined(TARGET_RISCV32)
>      [CSR_TIMEH] =               { ctr,
> read_timeh                          },
>  #endif
> -#endif
>
>  #if !defined(CONFIG_USER_ONLY)
>      /* Machine Timers and Counters */
> --
> 2.20.1

