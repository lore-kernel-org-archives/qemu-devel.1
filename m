Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1BEC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F5D21773
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F5D21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbiz0-0006ZK-FW
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hbii0-00088k-5T
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hbihy-00062J-Ub
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:41:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hbihy-00061T-OB
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:41:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so1814455wrv.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=sEWBGp8G/UULxSDitnnJIXQ9jsKma8nu50a+q3IMm4U=;
 b=olYFF63vzbsBDrn93Bv7dkTnf7Eb8/FgH2v6IpHvn8WicWKj97G8JN63RuRvq++tZ0
 T5pM3qsjifLSSEnmTdrkDw+qpClplhlA+51RbOk0PE+y2EvoE8F01RJoO/zS2Ag/9LYf
 DbmvsvvOUzR9Zp4k0ASLvczwhv3VoYcFtM6kLVxT++65Zp1iSOsyz3q7FAscJnvoIYXD
 m3tX5la3/A5VA4pMrpKrA4zfbaXB25vAFaSgV5pk5+FL57w0CVY40a8D9n2Zvll/cZCj
 IEsdqkziOq/TD+qibP8nkcrXSS9KnBWEaZ+h2GCu0kg2GAVA0jip5kGLjZt0gLMFgM4x
 mrTA==
X-Gm-Message-State: APjAAAUXyJkdE7IYpqNpClLpyrE2h7W6DzU8FJjY5pga5Qishshbveh+
 f/RZHo6111E9/pmr0pNzoIL6+lTWSCUYDg==
X-Google-Smtp-Source: APXvYqwZv/gF4TSR9gcOXHS6hnSKTL8pP1mtl+OC3fesqqwNdXY7i5zFjtIZXyGtCKwIO4kXumC/8w==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr122790wrw.131.1560505277063; 
 Fri, 14 Jun 2019 02:41:17 -0700 (PDT)
Received: from localhost ([83.137.6.186])
 by smtp.gmail.com with ESMTPSA id k125sm3380586wmf.41.2019.06.14.02.41.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 02:41:16 -0700 (PDT)
Date: Fri, 14 Jun 2019 02:41:16 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Jun 2019 02:41:10 PDT (-0700)
In-Reply-To: <7e9b4a6cc07a931e62da9c18c40849690eef7150.1558131003.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-d2259f3e-29d6-47f5-b6a8-7b9224ae7a4e@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v1 4/4] target/riscv: Implement
 riscv_cpu_unassigned_access
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 15:11:06 PDT (-0700), Alistair Francis wrote:
> From: Michael Clark <mjc@sifive.com>
>
> This patch adds support for the riscv_cpu_unassigned_access call
> and will raise a load or store access fault.
>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> [Changes by AF:
>  - Squash two patches and rewrite commit message
>  - Set baddr to the access address
> ]
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c        |  1 +
>  target/riscv/cpu.h        |  2 ++
>  target/riscv/cpu_helper.c | 16 ++++++++++++++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b7675707e0..bfe92235d3 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -356,6 +356,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
>      cc->gdb_stop_before_watchpoint = true;
>      cc->disas_set_info = riscv_cpu_disas_set_info;
>  #ifndef CONFIG_USER_ONLY
> +    cc->do_unassigned_access = riscv_cpu_unassigned_access;
>      cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
>      cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
>  #endif
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c17184f4e4..8250175811 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -264,6 +264,8 @@ void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>  bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                          MMUAccessType access_type, int mmu_idx,
>                          bool probe, uintptr_t retaddr);
> +void riscv_cpu_unassigned_access(CPUState *cpu, hwaddr addr, bool is_write,
> +                                 bool is_exec, int unused, unsigned size);
>  char *riscv_isa_string(RISCVCPU *cpu);
>  void riscv_cpu_list(void);
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 41d6db41c3..202b6f021d 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -356,6 +356,22 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      return phys_addr;
>  }
>
> +void riscv_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
> +                                 bool is_exec, int unused, unsigned size)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +
> +    if (is_write) {
> +        cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +    } else {
> +        cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
> +    }
> +
> +    env->badaddr = addr;
> +    riscv_raise_exception(&cpu->env, cs->exception_index, GETPC());
> +}
> +
>  void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                     MMUAccessType access_type, int mmu_idx,
>                                     uintptr_t retaddr)

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

