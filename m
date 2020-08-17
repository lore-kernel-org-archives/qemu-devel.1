Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAA9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 18:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB0D2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 18:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk8whBNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB0D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7jU3-0004cT-HD
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 14:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7jTK-0003xO-1C; Mon, 17 Aug 2020 14:03:02 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:35430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7jTI-000102-AD; Mon, 17 Aug 2020 14:03:01 -0400
Received: by mail-io1-xd44.google.com with SMTP id s189so18570014iod.2;
 Mon, 17 Aug 2020 11:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ydp4yj03rSRtMg3pQTIXz3zCvK2aqEAIfPDBqJROOuU=;
 b=kk8whBNxE4K1j/YS0SQGXl7iE18fEBsgiMgbuahX+5TExfCdwd3H3bkyLvld1QI7Ly
 9ge3G5H5BNUGDHOTBpZ1s4vQYvh8Aahl5ySaBi9rNO2RreLCzdHC72AG5EUxUjkhQaa9
 AU3KYetsCJ66VBzifU0pJnoEAUik9zv5dONyQjf/1VLGyw7xPmCARd8CeaFNgZzQMf9k
 tPgX0rnFMHPWxfWfhv9I4ppM1Jshr/Dd2AhBLGUahBKRqM2Y1Vx+JIkpSGw55A7SyRr1
 FmQPZZ+GB9Js+4/LirAi3YriaABHC6Z9xgpztLh3AurLJk/zEsiKJmSBk+Ma/HM3HxHG
 ic0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ydp4yj03rSRtMg3pQTIXz3zCvK2aqEAIfPDBqJROOuU=;
 b=fY2LYt7G9DXZ8+AYeq0JY1Rdi9btU3zGgWYvhehsvLtoDWgGrg9bpKEMD0FeiRrtPt
 bOreG7Rj69Rr2W/C69Fb1ScITnjvy5dAFAUMm3P/loE++iq1tZTwInp7aTCtmwNbIsXt
 ZVyWDQNjIBd96AcZZa7EjL9DK26sTy2vvjJfaTLwXNavkE373iTMQomRAIZlwx2609Pk
 H/M+TXNq74E0Xk2UaCjB4Hy8FoyCE3LqdwxUmgPVb3Gok3KzyNY5+KAEIAHHPIb8DA39
 hjajnJdir52d/hrgDFbND7UFULTjbzjQMcWeTSqhCgWvqVe3+341fbl4cvvAfIUwj3DH
 UHIw==
X-Gm-Message-State: AOAM530T4jIZBC5TaEd4Y4fu0qZByKPskskvq+OU6iAVabOmBsDj+0cf
 wmqyLiNZS8lDdzMpxlKOH5T7sW8u1PsR/J/XUY8=
X-Google-Smtp-Source: ABdhPJwk3Auvt5IQJ8DW97ui99D33DefoFs9vY0/LY8Nop9KzSwDjxNAH/VVHa6gazM62Gw9bDAIb9mRtfDTgwtmcZw=
X-Received: by 2002:a05:6638:1690:: with SMTP id
 f16mr15774877jat.91.1597687378827; 
 Mon, 17 Aug 2020 11:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-4-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1597423256-14847-4-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Aug 2020 10:52:27 -0700
Message-ID: <CAKmqyKMwCGUhr13mcNJvicMkYYwaduVVNh-rue7pqW1d7X3uXw@mail.gmail.com>
Subject: Re: [PATCH 03/18] target/riscv: cpu: Set reset vector based on the
 configured property value
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 9:45 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Now that we have the newly introduced 'resetvec' property in the
> RISC-V CPU and HART, instead of hard-coding the reset vector addr
> in the CPU's instance_init(), move that to riscv_cpu_realize()
> based on the configured property value from the RISC-V machines.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/opentitan.c | 1 +
>  hw/riscv/sifive_e.c  | 1 +
>  hw/riscv/sifive_u.c  | 2 ++
>  target/riscv/cpu.c   | 7 ++-----
>  4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index a8f0039..b0a4eae 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -111,6 +111,7 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
>                              &error_abort);
> +    object_property_set_int(OBJECT(&s->cpus), "resetvec", 0x8090, &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_abort);
>
>      /* Boot ROM */
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index c8b0604..c84d407 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -177,6 +177,7 @@ static void sifive_e_soc_init(Object *obj)
>      object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
>      object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
>                              &error_abort);
> +    object_property_set_int(OBJECT(&s->cpus), "resetvec", 0x1004, &error_abort);
>      object_initialize_child(obj, "riscv.sifive.e.gpio0", &s->gpio,
>                              TYPE_SIFIVE_GPIO);
>  }
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 18301e6..e256da2 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -611,6 +611,7 @@ static void sifive_u_soc_instance_init(Object *obj)
>      qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
>      qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
>      qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
> +    qdev_prop_set_uint64(DEVICE(&s->e_cpus), "resetvec", 0x1004);
>
>      object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);
>      qdev_prop_set_uint32(DEVICE(&s->u_cluster), "cluster-id", 1);
> @@ -620,6 +621,7 @@ static void sifive_u_soc_instance_init(Object *obj)
>      qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
>      qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
>      qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", SIFIVE_U_CPU);
> +    qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
>
>      object_initialize_child(obj, "prci", &s->prci, TYPE_SIFIVE_U_PRCI);
>      object_initialize_child(obj, "otp", &s->otp, TYPE_SIFIVE_U_OTP);
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8067a26..bd41286 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -128,7 +128,6 @@ static void riscv_any_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
>      set_priv_version(env, PRIV_VERSION_1_11_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
>  static void riscv_base_cpu_init(Object *obj)
> @@ -136,7 +135,6 @@ static void riscv_base_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      /* We set this in the realise function */
>      set_misa(env, 0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
>  static void rvxx_sifive_u_cpu_init(Object *obj)
> @@ -144,7 +142,6 @@ static void rvxx_sifive_u_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, 0x1004);
>  }
>
>  static void rvxx_sifive_e_cpu_init(Object *obj)
> @@ -152,7 +149,6 @@ static void rvxx_sifive_e_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, 0x1004);
>      qdev_prop_set_bit(DEVICE(obj), "mmu", false);
>  }
>
> @@ -163,7 +159,6 @@ static void rv32_ibex_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RV32 | RVI | RVM | RVC | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, 0x8090);
>      qdev_prop_set_bit(DEVICE(obj), "mmu", false);
>  }
>
> @@ -373,6 +368,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>          set_feature(env, RISCV_FEATURE_PMP);
>      }
>
> +    set_resetvec(env, cpu->cfg.resetvec);
> +
>      /* If misa isn't set (rv32 and rv64 machines) set it here */
>      if (!env->misa) {
>          /* Do some ISA extension error checking */
> --
> 2.7.4
>
>

