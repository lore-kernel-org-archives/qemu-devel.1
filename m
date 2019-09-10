Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9203C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF62421479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF62421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hcA-00041Z-BP
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7hRE-0000OG-I6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7hRC-0006QO-Rl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7hRC-0006Px-MW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so20858140wra.6
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=WH1RsL+ZdVST+XzQbljMHQiP6aO83DLlrXgF51Tok1Q=;
 b=ASclyyPBKgJJhrcmxMU9Maph8p5kChbfkUTtTGfu4N6t5DeRWF43lkSZvlQ+SoMVId
 KmRbTsUhcJvoRsXNTUmOLHBpD12fFPMKSQfDRfvZk/Do54uj8FFOoQ96nvaQZt9Kgk15
 JCwzJ9jMr2LI1n6Gsw1fJ0qUZ6tSY9W9K3UE0itxSlAsqA/6hagYCqmnywF0SK9QNLJh
 JhXg0cwe/FQ71dYV2Va0SbK6i2/gNn/bM20R35BuPJGwQPqecAwJzwj3N8SDpmj91gZJ
 eDA5zpr20Vs91DE3sVLBKrh8fgQIDGI9/Pc8QN0smuBthUn+za/Jp/l2AUCuBJB1ihCI
 5OuA==
X-Gm-Message-State: APjAAAWoJiqN8QMBBVp1Nehw0SBiytCNP8QQQaDfimH5ICiSfWIB8XIb
 HwrEaj0eHoWWiN3E6GeIw3n7038ft2C01g==
X-Google-Smtp-Source: APXvYqy0ERn8EWjnKJ+uVA3LC+L1HtJOv1RwmuEivZgZtzMDHMyefIKZQ49uutQWMDqP9QZNVmBwUQ==
X-Received: by 2002:a5d:5606:: with SMTP id l6mr3720814wrv.108.1568126889190; 
 Tue, 10 Sep 2019 07:48:09 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id k9sm34089428wrd.7.2019.09.10.07.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:48:08 -0700 (PDT)
Date: Tue, 10 Sep 2019 07:48:08 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 07:44:11 PDT (-0700)
In-Reply-To: <47e7fd90ce1d2373824799274376b29d751d56c3.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-a0b8f877-5b70-413f-8f5f-5912f49ffcfd@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v1 07/28] target/riscv: Dump Hypervisor
 registers if enabled
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:07 PDT (-0700), Alistair Francis wrote:
> Dump the Hypervisor registers and the current Hypervisor state.
>
> While we are editing this code let's also dump stvec and scause.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  target/riscv/cpu.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f13e298a36..be8f643fc2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -220,18 +220,52 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>      CPURISCVState *env = &cpu->env;
>      int i;
>
> +#if !defined(CONFIG_USER_ONLY)
> +    if (riscv_has_ext(env, RVH)) {
> +        qemu_fprintf(f, " %s %d\n", "V      =  ", riscv_cpu_virt_enabled(env));
> +    }
> +#endif
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
>  #ifndef CONFIG_USER_ONLY
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> +    if (riscv_has_ext(env, RVH)) {
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bstatus ", env->vsstatus);
> +    }
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
>                   (target_ulong)atomic_read(&env->mip));
> +    if (riscv_has_ext(env, RVH)) {
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsip    ",
> +                     (target_ulong)atomic_read(&env->vsip));
> +    }
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
> +    if (riscv_has_ext(env, RVH)) {
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsie    ", env->vsie);
> +    }
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
> +    if (riscv_has_ext(env, RVH)) {
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hideleg ", env->hideleg);
> +    }
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
> +    if (riscv_has_ext(env, RVH)) {
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hedeleg ", env->hedeleg);
> +    }
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtvec   ", env->mtvec);
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "stvec   ", env->stvec);
> +    if (riscv_has_ext(env, RVH)) {
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vstvec  ", env->vstvec);
> +    }
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mepc    ", env->mepc);
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "sepc    ", env->sepc);
> +    if (riscv_has_ext(env, RVH)) {
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsepc   ", env->vsepc);
> +    }
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mcause  ", env->mcause);
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "scause  ", env->scause);
> +    if (riscv_has_ext(env, RVH)) {
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vscause ", env->vscause);
> +    }
>  #endif
>
>      for (i = 0; i < 32; i++) {

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

