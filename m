Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4500FC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 17:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102CA2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 17:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102CA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVflG-0005p8-7N
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 13:19:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hVfjw-00053f-L0
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hVfju-0001B5-5C
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:18:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hVfjr-00015W-Mq
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:18:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so11365608pgv.10
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 10:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=ynqteHpaI18mvzVpqabF5CifMGbrBuDWqWx964didfw=;
	b=dDX9qvSfggGF9uVkymLj2L72pDjwcJ72ywzu2gJkuyhnJf78eIAkQlnBCT0M2A6/R5
	kFAXT30mOx4bPAqVeVC920+AK3D3EzXzc4jE7BCO67ADXwGbecZGgPRkPWpzT2I78Pd0
	LCrx8HniqCYrnMcmJdnHfB/ErQlAQCRMnIQTuFaAJRRC3E7uNgrWGvpA100OiQO3XLUd
	RhwHqhE22x/GQ1I8XgDFqxN/1iMT+Kh0M9lwbUfacjb0/vpFbE7VT746+JAOQing3lzN
	S88qDn9nxKm0v+8eqgO3xeYnbXB3DPQG/9gP45Yk+7uyDq0vsDYOloNxrTuLOVsXq2w8
	tNWQ==
X-Gm-Message-State: APjAAAWfb93gQg06nrbSquzmulE1fUSYkeSbA3bTXlO9CBr68CYwmI8Y
	Rl//ten6MDeCapoxRUh9bWTtKGrw0XU=
X-Google-Smtp-Source: APXvYqxrx3RdmluU8QWqv0XreCz+NTmdeff9YquhmuPtVyAQspuCIeGoSi2/4scrpqT3FpZQh8qAfQ==
X-Received: by 2002:a63:fc61:: with SMTP id r33mr26554880pgk.294.1559063889507;
	Tue, 28 May 2019 10:18:09 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	f38sm11763026pgm.85.2019.05.28.10.18.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 10:18:07 -0700 (PDT)
Date: Tue, 28 May 2019 10:18:07 -0700 (PDT)
X-Google-Original-Date: Tue, 28 May 2019 10:17:56 PDT (-0700)
In-Reply-To: <a95544549f6205d1da5c9efa69fed4f9a89f5866.1557182815.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-4345b03b-e9cb-4dfb-8807-4245659eca20@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH v1 1/1] target/riscv: Allow setting ISA
 extensions via CPU props
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 06 May 2019 15:49:53 PDT (-0700), Alistair Francis wrote:
> This patch allows us to enable/disable the RISC-V ISA extensions from
> the QEMU command line. This works with the rv32 and rv64 machines. The
> idea is that in the future we can now add extensions and leave them
> disabled by default until enabled by the user.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> Based-on: <cover.1555726824.git.alistair.francis@wdc.com>
>
> This is based on my previous series: "RISC-V: Add properties to the
> CPUs" which has been merged into the RISC-V tree.
>
>  target/riscv/cpu.c | 70 ++++++++++++++++++++++++++++++++++++++++++++--
>  target/riscv/cpu.h | 11 ++++++++
>  2 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2db173801f..41afed3140 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -23,6 +23,7 @@
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "qapi/error.h"
> +#include "qemu/error-report.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>
> @@ -118,7 +119,8 @@ static void riscv_any_cpu_init(Object *obj)
>  static void riscv_base32_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> +    /* We set this in the realise function */
> +    set_misa(env, 0);
>  }
>
>  static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
> @@ -155,7 +157,8 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>  static void riscv_base64_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> +    /* We set this in the realise function */
> +    set_misa(env, 0);
>  }
>
>  static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
> @@ -314,6 +317,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>      int priv_version = PRIV_VERSION_1_10_0;
>      int user_version = USER_VERSION_2_02_0;
> +    target_ulong target_misa = 0;
>      Error *local_err = NULL;
>
>      cpu_exec_realizefn(cs, &local_err);
> @@ -357,6 +361,58 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>          set_feature(env, RISCV_FEATURE_PMP);
>      }
>
> +    /* If misa isn't set (rv32 and rv64 machines) set it here */
> +    if (!env->misa) {
> +        /* Do some ISA extension error checking */
> +        if (cpu->cfg.ext_i && cpu->cfg.ext_e) {
> +            error_setg(errp,
> +                       "I and E extensions are incompatible");
> +                       return;
> +       }
> +
> +       if (cpu->cfg.ext_g && !(cpu->cfg.ext_i & cpu->cfg.ext_m &
> +                               cpu->cfg.ext_a & cpu->cfg.ext_f &
> +                               cpu->cfg.ext_d)) {
> +            warn_report("Setting G will also set IMAFD");
> +            cpu->cfg.ext_i = true;
> +            cpu->cfg.ext_m = true;
> +            cpu->cfg.ext_a = true;
> +            cpu->cfg.ext_f = true;
> +            cpu->cfg.ext_d = true;
> +        }
> +
> +        /* Set the ISA extensions, checks should have happened above */
> +        if (cpu->cfg.ext_i) {
> +            target_misa |= RVI;
> +        }
> +        if (cpu->cfg.ext_e) {
> +            target_misa |= RVE;
> +        }
> +        if (cpu->cfg.ext_m) {
> +            target_misa |= RVM;
> +        }
> +        if (cpu->cfg.ext_a) {
> +            target_misa |= RVA;
> +        }
> +        if (cpu->cfg.ext_f) {
> +            target_misa |= RVF;
> +        }
> +        if (cpu->cfg.ext_d) {
> +            target_misa |= RVD;
> +        }
> +        if (cpu->cfg.ext_c) {
> +            target_misa |= RVC;
> +        }
> +        if (cpu->cfg.ext_s) {
> +            target_misa |= RVS;
> +        }
> +        if (cpu->cfg.ext_u) {
> +            target_misa |= RVU;
> +        }
> +
> +        set_misa(env, RVXLEN | target_misa);
> +    }
> +
>      riscv_cpu_register_gdb_regs_for_features(cs);
>
>      qemu_init_vcpu(cs);
> @@ -379,6 +435,16 @@ static const VMStateDescription vmstate_riscv_cpu = {
>  };
>
>  static Property riscv_cpu_properties[] = {
> +    DEFINE_PROP_BOOL("i", RISCVCPU, cfg.ext_i, true),
> +    DEFINE_PROP_BOOL("e", RISCVCPU, cfg.ext_e, false),
> +    DEFINE_PROP_BOOL("g", RISCVCPU, cfg.ext_g, true),
> +    DEFINE_PROP_BOOL("m", RISCVCPU, cfg.ext_m, true),
> +    DEFINE_PROP_BOOL("a", RISCVCPU, cfg.ext_a, true),
> +    DEFINE_PROP_BOOL("f", RISCVCPU, cfg.ext_f, true),
> +    DEFINE_PROP_BOOL("d", RISCVCPU, cfg.ext_d, true),
> +    DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
> +    DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
> +    DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>      DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
>      DEFINE_PROP_STRING("user_spec", RISCVCPU, cfg.user_spec),
>      DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 67d27f45f6..9805e65065 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -229,6 +229,17 @@ typedef struct RISCVCPU {
>
>      /* Configuration Settings */
>      struct {
> +        bool ext_i;
> +        bool ext_e;
> +        bool ext_g;
> +        bool ext_m;
> +        bool ext_a;
> +        bool ext_f;
> +        bool ext_d;
> +        bool ext_c;
> +        bool ext_s;
> +        bool ext_u;
> +
>          char *priv_spec;
>          char *user_spec;
>          bool mmu;

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

