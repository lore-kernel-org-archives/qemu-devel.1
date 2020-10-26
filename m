Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E5FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B0F20759
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMGnJ8ZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B0F20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyds-0007Pn-O3
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWyZw-0005MQ-SI
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWyZu-0003dV-91
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603703649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOW6+K1biILrj0EugTCpJRoF8uUvYY1q4DYcH00OQZY=;
 b=SMGnJ8ZYQiw/4Ymzm40/MUFt4hmG+L1IfsTZY6TO77jiB4/aB8E6Tmu8bxjNpkgv6Fqs65
 l2EnDkS7dJOFiu00zDA7EhTwk2lxcsLdpQsznriesSqL0VeSBF5PF8YWCoGj5M34Vr0gB7
 HFlrbiiRp6/g6qrfEZRuG1weJ0fDaf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-eWl1OFNuO5W-ClfpGr56Wg-1; Mon, 26 Oct 2020 05:14:05 -0400
X-MC-Unique: eWl1OFNuO5W-ClfpGr56Wg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE4B61239;
 Mon, 26 Oct 2020 09:14:03 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADC406EF5F;
 Mon, 26 Oct 2020 09:14:01 +0000 (UTC)
Subject: Re: [PATCH V2 02/14] ppc/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20201009064449.2336-1-zhaolichang@huawei.com>
 <20201009064449.2336-3-zhaolichang@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <20ff189b-0d88-8c5c-c132-1bb33714dcaa@redhat.com>
Date: Mon, 26 Oct 2020 10:14:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201009064449.2336-3-zhaolichang@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: David Edmondson <david.edmondson@oracle.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/2020 08.44, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target/ppc.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> ---
>  target/ppc/cpu.h                | 6 +++---
>  target/ppc/excp_helper.c        | 6 +++---
>  target/ppc/fpu_helper.c         | 2 +-
>  target/ppc/internal.h           | 2 +-
>  target/ppc/kvm.c                | 2 +-
>  target/ppc/machine.c            | 2 +-
>  target/ppc/mmu-hash64.c         | 2 +-
>  target/ppc/mmu_helper.c         | 4 ++--
>  target/ppc/translate_init.c.inc | 2 +-
>  9 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 766e9c5c26..ba5ebb13fc 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -615,7 +615,7 @@ enum {
>  #define FPSCR_VXCVI  8  /* Floating-point invalid operation exception (int)  */
>  #define FPSCR_VE     7  /* Floating-point invalid operation exception enable */
>  #define FPSCR_OE     6  /* Floating-point overflow exception enable          */
> -#define FPSCR_UE     5  /* Floating-point undeflow exception enable          */
> +#define FPSCR_UE     5  /* Floating-point underflow exception enable          */
>  #define FPSCR_ZE     4  /* Floating-point zero divide exception enable       */
>  #define FPSCR_XE     3  /* Floating-point inexact exception enable           */
>  #define FPSCR_NI     2  /* Floating-point non-IEEE mode                      */
> @@ -2331,13 +2331,13 @@ enum {
>      /* Internal hardware exception sources */
>      PPC_INTERRUPT_DECR,           /* Decrementer exception                */
>      PPC_INTERRUPT_HDECR,          /* Hypervisor decrementer exception     */
> -    PPC_INTERRUPT_PIT,            /* Programmable inteval timer interrupt */
> +    PPC_INTERRUPT_PIT,            /* Programmable interval timer interrupt */
>      PPC_INTERRUPT_FIT,            /* Fixed interval timer interrupt       */
>      PPC_INTERRUPT_WDT,            /* Watchdog timer interrupt             */
>      PPC_INTERRUPT_CDOORBELL,      /* Critical doorbell interrupt          */
>      PPC_INTERRUPT_DOORBELL,       /* Doorbell interrupt                   */
>      PPC_INTERRUPT_PERFM,          /* Performance monitor interrupt        */
> -    PPC_INTERRUPT_HMI,            /* Hypervisor Maintainance interrupt    */
> +    PPC_INTERRUPT_HMI,            /* Hypervisor Maintenance interrupt    */
>      PPC_INTERRUPT_HDOORBELL,      /* Hypervisor Doorbell interrupt        */
>      PPC_INTERRUPT_HVIRT,          /* Hypervisor virtualization interrupt  */
>  };
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index a988ba15f4..d7411bcc81 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -231,7 +231,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
>      }
>  
>      /*
> -     * Exception targetting modifiers
> +     * Exception targeting modifiers
>       *
>       * LPES0 is supported on POWER7/8/9
>       * LPES1 is not supported (old iSeries mode)
> @@ -1015,7 +1015,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>           * This means we will incorrectly execute past the power management
>           * instruction instead of triggering a reset.
>           *
> -         * It generally means a discrepancy between the wakup conditions in the
> +         * It generally means a discrepancy between the wakeup conditions in the
>           * processor has_work implementation and the logic in this function.
>           */
>          cpu_abort(env_cpu(env),
> @@ -1191,7 +1191,7 @@ void helper_rfi(CPUPPCState *env)
>  void helper_rfid(CPUPPCState *env)
>  {
>      /*
> -     * The architeture defines a number of rules for which bits can
> +     * The architecture defines a number of rules for which bits can
>       * change but in practice, we handle this in hreg_store_msr()
>       * which will be called by do_rfi(), so there is no need to filter
>       * here
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index ae43b08eb5..9b8c8b70b6 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -1804,7 +1804,7 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t op1, uint64_t op2)
>  
>  
>  /*
> - * VSX_ADD_SUB - VSX floating point add/subract
> + * VSX_ADD_SUB - VSX floating point add/subtract
>   *   name  - instruction mnemonic
>   *   op    - operation (add or sub)
>   *   nels  - number of elements (1, 2 or 4)
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 15d655b356..b4df127f4a 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -1,5 +1,5 @@
>  /*
> - *  PowerPC interal definitions for qemu.
> + *  PowerPC internal definitions for qemu.
>   *
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d85ba8ffe0..e85ef2ea9e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -487,7 +487,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              /*
>               * KVM-HV has transactional memory on POWER8 also without
>               * the KVM_CAP_PPC_HTM extension, so enable it here
> -             * instead as long as it's availble to userspace on the
> +             * instead as long as it's available to userspace on the
>               * host.
>               */
>              if (qemu_getauxval(AT_HWCAP2) & PPC_FEATURE2_HAS_HTM) {
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 109d071162..f6a24a9c9a 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -337,7 +337,7 @@ static int cpu_post_load(void *opaque, int version_id)
>  
>      /*
>       * If we're operating in compat mode, we should be ok as long as
> -     * the destination supports the same compatiblity mode.
> +     * the destination supports the same compatibility mode.
>       *
>       * Otherwise, however, we require that the destination has exactly
>       * the same CPU model as the source.
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index c31d21e6a9..977b2d1561 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -883,7 +883,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>      /*
>       * Note on LPCR usage: 970 uses HID4, but our special variant of
>       * store_spr copies relevant fields into env->spr[SPR_LPCR].
> -     * Similarily we filter unimplemented bits when storing into LPCR
> +     * Similarly we filter unimplemented bits when storing into LPCR
>       * depending on the MMU version. This code can thus just use the
>       * LPCR "as-is".
>       */
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 8972714775..50aa18a763 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -179,7 +179,7 @@ static inline int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
>              }
>              /* Compute access rights */
>              access = pp_check(ctx->key, pp, ctx->nx);
> -            /* Keep the matching PTE informations */
> +            /* Keep the matching PTE information */
>              ctx->raddr = pte1;
>              ctx->prot = access;
>              ret = check_prot(ctx->prot, rw, type);
> @@ -2176,7 +2176,7 @@ void helper_store_sr(CPUPPCState *env, target_ulong srnum, target_ulong value)
>          env->sr[srnum] = value;
>          /*
>           * Invalidating 256MB of virtual memory in 4kB pages is way
> -         * longer than flusing the whole TLB.
> +         * longer than flushing the whole TLB.
>           */
>  #if !defined(FLUSH_ALL_TLBS) && 0
>          {
> diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.inc
> index bb66526280..3e0810fd6d 100644
> --- a/target/ppc/translate_init.c.inc
> +++ b/target/ppc/translate_init.c.inc
> @@ -792,7 +792,7 @@ static void gen_spr_generic(CPUPPCState *env)
>                   &spr_read_xer, &spr_write_xer,
>                   &spr_read_xer, &spr_write_xer,
>                   0x00000000);
> -    /* Branch contol */
> +    /* Branch control */
>      spr_register(env, SPR_LR, "LR",
>                   &spr_read_lr, &spr_write_lr,
>                   &spr_read_lr, &spr_write_lr,
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


