Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42027C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064B4206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064B4206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbUX-0004Uq-AE
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:56:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbTi-0004BV-59
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbTg-0005tF-JN
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:56:06 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMbTd-0005mK-Kp
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:56:02 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MFK8N-1hXpsy3EL3-00Fi2Q; Fri, 03 May 2019 18:55:57 +0200
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20181210165636.28366-1-peter.maydell@linaro.org>
	<20181210165636.28366-4-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b1ac61d3-8a8e-0860-a5dd-f40f2fdbcf79@vivier.eu>
Date: Fri, 3 May 2019 18:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181210165636.28366-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RADh/u6PvZ60TJ43cUfrEb0A7yX4xaQAcCHQhWp6KUEw21Amh+t
	hAAS8pUWjxY8dsXDFBuLhxt0esMzMc8doofuahelFWPxbO8UmQT/mmnsXktVG4dUqhH9MLI
	+gU7Iuf0sqF+TsKial2c3lDldaf1v9hwwTRSih6jrqsSkYvN3Ro29T4OBuBquv2mpZOgWzg
	XKcDriZdl+F24ZqpF1Ldg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N79jVOmfP3w=:s1XRQvkVIUHbi2xY4M88SR
	CapITsEC/3+C/SB1IBczA1J/tkkpJVMDMH7rHGDYWw6z/u/Leda6EMv5c1RCQN6IIdAwFC2Or
	KLvfaOHqwo2BoGOsivBf4omoqTPsZHunTfXg+QVvz8vrYEfxNEbwkc1rDgj98B+5uil+7gqXN
	sLp+q7SPp0p3Laq7brjn5qdBQGrjqvvg768S+DbvWh61UtKvnVoidCvXBYTtOvqBFsI9hH8Sr
	NtjJEs+S5gIZ7V1V0ap2HHXJDEBsh0CTqjBOAdIhSKPzpyfYavrGB5oxC5p0WF8qCmFiorqph
	K8UbFyye9RoLR9d+F9MueokZwYlUNZvJX9/pDUgu4hurLN/hAthe85r9zYb00lzk21PUc/Qvo
	aO7I/LKERo8Nsf9dd6ykknMkwW2SO2JvEmx4AaEYP9QWp4BOc+wYJ4X95qSd558imedyl41CU
	48U+iovDSEmEPKvJKEVdhN+FdLo38ziTWfFQT5DoBum8RvZv/KCmRMvlOXUCd4G4a1jH9HPaU
	AnEEp76ruPtlTBypYJHkBzny+uGP/lilg7WtURBhBZy+XeXMaf+7pSEQ0D2jxLZ+Yj7U+dww2
	eF4BDEPDwIw8U3IgB+9mhDqwV0NqXoAqrnOdEvOpJ9iowoPKSaaOOxHyyo8oG9eutUOK5dc7P
	1kEaoMHcEdRdOeBjH9RQ/AnGXmyg7iTnFvMfPUms6itOSdr3c1v/jB7xAOhvFyZ9eIFaT7seR
	IXHUfjugekvXifR7DDY4+jODGvB1/khAzOvazitcCB9k5h4PcIDcSswBXTE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [RFC 3/3] target/m68k: Switch to
 transaction_failed hook
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, patches@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503165556.H-mCOuZ2HoVf8Sd6KvRhZTVSgBiQgGqGEiocwF8wy5g@z>

On 10/12/2018 17:56, Peter Maydell wrote:
> Switch the m68k target from the old unassigned_access hook
> to the transaction_failed hook.
> 
> The notable difference is that rather than it being called
> for all physical memory accesses which fail (including
> those made by DMA devices or by the gdbstub), it is only
> called for those made by the CPU via its MMU. (In previous
> commits we put in explicit checks for the direct physical
> loads made by the target/m68k code which will no longer
> be handled by calling the unassigned_access hook.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/m68k/cpu.h       |  7 ++++---
>   target/m68k/cpu.c       |  2 +-
>   target/m68k/op_helper.c | 20 ++++++++------------
>   3 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index b288a3864e0..08828b0581b 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -545,9 +545,10 @@ static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
>   
>   int m68k_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
>                                 int mmu_idx);
> -void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr,
> -                                bool is_write, bool is_exec, int is_asi,
> -                                unsigned size);
> +void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
> +                                 unsigned size, MMUAccessType access_type,
> +                                 int mmu_idx, MemTxAttrs attrs,
> +                                 MemTxResult response, uintptr_t retaddr);
>   
>   #include "exec/cpu-all.h"
>   
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 582e3a73b37..6d09c630b0e 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -271,7 +271,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
>       cc->gdb_write_register = m68k_cpu_gdb_write_register;
>       cc->handle_mmu_fault = m68k_cpu_handle_mmu_fault;
>   #if defined(CONFIG_SOFTMMU)
> -    cc->do_unassigned_access = m68k_cpu_unassigned_access;
> +    cc->do_transaction_failed = m68k_cpu_transaction_failed;
>       cc->get_phys_page_debug = m68k_cpu_get_phys_page_debug;
>   #endif
>       cc->disas_set_info = m68k_cpu_disas_set_info;
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 8d09ed91c49..6739ab8e436 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -454,19 +454,15 @@ static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
>       do_interrupt_all(env, 1);
>   }
>   
> -void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
> -                                bool is_exec, int is_asi, unsigned size)
> +void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
> +                                 unsigned size, MMUAccessType access_type,
> +                                 int mmu_idx, MemTxAttrs attrs,
> +                                 MemTxResult response, uintptr_t retaddr)
>   {
>       M68kCPU *cpu = M68K_CPU(cs);
>       CPUM68KState *env = &cpu->env;
> -#ifdef DEBUG_UNASSIGNED
> -    qemu_log_mask(CPU_LOG_INT, "Unassigned " TARGET_FMT_plx " wr=%d exe=%d\n",
> -             addr, is_write, is_exec);
> -#endif
> -    if (env == NULL) {
> -        /* when called from gdb, env is NULL */
> -        return;
> -    }
> +
> +    cpu_restore_state(cs, retaddr, true);
>   
>       if (m68k_feature(env, M68K_FEATURE_M68040)) {
>           env->mmu.mmusr = 0;
> @@ -476,7 +472,7 @@ void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
>           if (env->sr & SR_S) { /* SUPERVISOR */
>               env->mmu.ssw |= M68K_TM_040_SUPER;
>           }
> -        if (is_exec) { /* instruction or data */
> +        if (access_type == MMU_INST_FETCH) { /* instruction or data */
>               env->mmu.ssw |= M68K_TM_040_CODE;
>           } else {
>               env->mmu.ssw |= M68K_TM_040_DATA;
> @@ -494,7 +490,7 @@ void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
>               break;
>           }
>   
> -        if (!is_write) {
> +        if (access_type != MMU_DATA_STORE) {
>               env->mmu.ssw |= M68K_RW_040;
>           }
>   
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


