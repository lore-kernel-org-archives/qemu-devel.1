Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816E2C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5436521479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5436521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hVh-0004bf-TL
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7hR8-0000IC-AZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7hR6-0006Mm-Ry
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7hR6-0006ML-Mb
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so20857433wra.6
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=SNqQ5iSCtzp/WVbo2V5ehi/imLB/wYtVNdyCk97INlY=;
 b=IL4CViR7l1uGMMfG7npP5u0TjXCWaR51a/2+1JsF0JxwuXDaF2+rn973cysEvsQKAu
 8ZwDxwRNFEpLpiIIv8MmQAqdQnMstA16tfvKLLO3xRhUW/PmyEfamOBKRrfxnvg9q46Z
 esGgrGPwJlhALW4EboecbCKh2PgfWnkCJb8Ab7HIIPNINZJe7XcwweSjh5X8HOmlJaz/
 aMZhG3lIcggF8XdIF/jnqAU3c/a6SV3Rdwbp7Ryk8S3vQhshDdVNsFKU+2bBKvynPkYd
 h/oTqwJ+SzXBMdiCROtcfpBucLCug2b9O/be5n7Jq31L7GqNgSRXHIBxFD2sp62GLDQD
 WysQ==
X-Gm-Message-State: APjAAAWoto4kvqGx/lDceLZnuL0DkXebLoccmdd8BdCFofI1qjAi5uiK
 kjrSfE9Z9W+14jAlX/V/JFq+OSRZE/bj8A==
X-Google-Smtp-Source: APXvYqxOQWTiFTDBNpQ8QWTAiBllYYUNBOREQyUcxzSfN4Z7kRfiD46MIiQJEghwqFk6BlgFTSHC1w==
X-Received: by 2002:a05:6000:152:: with SMTP id
 r18mr17461067wrx.153.1568126883156; 
 Tue, 10 Sep 2019 07:48:03 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id z17sm15741391wrw.23.2019.09.10.07.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:48:02 -0700 (PDT)
Date: Tue, 10 Sep 2019 07:48:02 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 07:17:44 PDT (-0700)
In-Reply-To: <9db2403d223b3e6d2d20086176a975dffabb175b.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-6653e02a-9a32-4c17-b9dc-9375e22fe7d1@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v1 03/28] target/riscv: Add the force HS
 exception mode
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

On Fri, 23 Aug 2019 16:37:57 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

There's really no description of what this does, either in the commit message
or as a comment.

> ---
>  target/riscv/cpu.h        |  2 ++
>  target/riscv/cpu_bits.h   |  6 ++++++
>  target/riscv/cpu_helper.c | 23 +++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0ef1ecb0e0..3a95c41428 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -261,6 +261,8 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
>  bool riscv_cpu_fp_enabled(CPURISCVState *env);
>  bool riscv_cpu_virt_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
> +bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
> +void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
>  int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
>  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 1fbde516be..204d9d9a79 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -428,6 +428,12 @@
>  #define VIRT_MODE_SHIFT     0
>  #define VIRT_MODE_MASK      (1 << VIRT_MODE_SHIFT)
>
> +/* HS-level exception modes */
> +#define CLEAR_HS_EXCEP        0
> +#define FORCE_HS_EXCEP        1
> +#define FORCE_HS_EXCEP_SHIFT  1
> +#define FORCE_HS_EXCEP_MASK   (1 << FORCE_HS_EXCEP_SHIFT)
> +
>  /* RV32 satp CSR field masks */
>  #define SATP32_MODE         0x80000000
>  #define SATP32_ASID         0x7fc00000
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 7b0bb14c01..5bcfc2e090 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -104,6 +104,29 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
>      env->virt |= enable << VIRT_MODE_SHIFT;
>  }
>
> +bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env)
> +{
> +    bool tmp;
> +
> +    if (!riscv_has_ext(env, RVH)) {
> +        return false;
> +    }
> +
> +    tmp = (env->virt & FORCE_HS_EXCEP_MASK) >> FORCE_HS_EXCEP_SHIFT;
> +
> +    return tmp == FORCE_HS_EXCEP;
> +}
> +
> +void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
> +{
> +    if (!riscv_has_ext(env, RVH)) {
> +        return;
> +    }
> +
> +    env->virt &= ~FORCE_HS_EXCEP_MASK;
> +    env->virt |= enable << FORCE_HS_EXCEP_SHIFT;
> +}
> +
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
>  {
>      CPURISCVState *env = &cpu->env;

