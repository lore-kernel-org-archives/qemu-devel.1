Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57597C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A3221744
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8nft5W6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A3221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOpZc-0002uz-9x
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:23:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpXv-0001dV-OX
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpXu-0001BF-5a
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:21:39 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOpXt-0001A0-QX
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:21:38 -0400
Received: by mail-lf1-x144.google.com with SMTP id f1so2501451lfl.6
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=5V8CGAZUKoneeInpLwrREswWIgAZgpT0F8Q0YwmaUVE=;
	b=q8nft5W6XbPJSmfrAzh2c+L7jN6WT2U4wZBPEEwqisF7fMiVNdDimGFSezlrgbDtuK
	wNCUKLg3OyujViUOaYYp7MvPT+ib6pyqx8pzUUJcplqdlziv3jBR77vQp1dEpn1dqGFn
	tjYY6UT9WXJ6j70oVipnGrJzZmXYEFCDe2j31YMVXAv6CaNngZjQEwmuhgmsI8hGa2EV
	de0M/zN8PmuBo8IXs4YcLTXpkuIxKFs/MYesbIc8tKOBAcOsBJJk8To7RAE/5hs/kcgB
	afUR9hexgbiolbxGaRXKBrrkXo4KvmBMhPGu24vlfQ90vv5Og4eFkDNN2pVGT1Rc3meZ
	dICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=5V8CGAZUKoneeInpLwrREswWIgAZgpT0F8Q0YwmaUVE=;
	b=NenbY9ZCSbQmdwQ/sZuGGMrcPTnLazWAtaJ0ap4CQ/+E/8jXVUHofzXpcd3xzZLg7Y
	+PrihN3r1lxLKSjR97TWwDL0G64R7BEQkXOBEWWnQlv8saVsV+OAFRgrFvUDJAhRz8Fj
	6h2GT1VcR3Ksj0QfpHA1iX9rOpHCEbWPKDKQw0UbZvCRJjILaVG960BzJFFQzTkIdC3K
	kq5sRhcGbvU1SzWlsk8cppFaTeto9VXGi/oetBb5ZuBPLyfDU/fJkkHBPvSl8dVwz6Q5
	vvsAL/DQVSU1H6knT0VYaTYVXkAA8ptCEc1ZVWs10vaJcv7HBBxZqPNLTFKObos56GXm
	rwkQ==
X-Gm-Message-State: APjAAAXFtbv+UBNHTcnVVlEoMjSu/5TNH9u0wRlKzdYDDpoX03on1RrU
	UE01rmLa0n1zD7H1/iJfWGst1m3jBWdlnyZpw18=
X-Google-Smtp-Source: APXvYqzpkK8U+25e8Ay6D08CRuUt2t+ptKbepSOyld5IgdSRGAK/mVa4374X9aNYnC+CpVAy3lkG0D5WjrHmH/2pprg=
X-Received: by 2002:a19:4a04:: with SMTP id x4mr3535006lfa.124.1557433296699; 
	Thu, 09 May 2019 13:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-31-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-31-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 13:19:29 -0700
Message-ID: <CAKmqyKP1hzToUyq0uHjP20i86D1j+3R7vwtz_5Vi7xOyZdiiZg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v3 30/39] target/xtensa: Use env_cpu,
 env_archcpu
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

On Tue, May 7, 2019 at 5:37 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move cpu_get_tb_cpu_state below the include of "exec/cpu-all.h"
> so that the definition of env_cpu is available.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/xtensa/cpu.h          | 17 ++++++-----------
>  hw/xtensa/pic_cpu.c          |  2 +-
>  linux-user/xtensa/cpu_loop.c |  2 +-
>  target/xtensa/dbg_helper.c   |  4 ++--
>  target/xtensa/exc_helper.c   |  9 ++++-----
>  target/xtensa/helper.c       |  2 +-
>  target/xtensa/mmu_helper.c   | 11 ++++-------
>  target/xtensa/xtensa-semi.c  |  2 +-
>  8 files changed, 20 insertions(+), 29 deletions(-)
>
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index a20541b5d6..86c88eae40 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -529,11 +529,6 @@ struct XtensaCPU {
>      CPUXtensaState env;
>  };
>
> -static inline XtensaCPU *xtensa_env_get_cpu(const CPUXtensaState *env)
> -{
> -    return container_of(env, XtensaCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(XtensaCPU, env)
>
>
> @@ -711,10 +706,15 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
>  #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
>  #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
>
> +typedef CPUXtensaState CPUArchState;
> +typedef XtensaCPU ArchCPU;
> +
> +#include "exec/cpu-all.h"
> +
>  static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
>          target_ulong *cs_base, uint32_t *flags)
>  {
> -    CPUState *cs = CPU(xtensa_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      *pc = env->pc;
>      *cs_base = 0;
> @@ -784,9 +784,4 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
>      }
>  }
>
> -typedef CPUXtensaState CPUArchState;
> -typedef XtensaCPU ArchCPU;
> -
> -#include "exec/cpu-all.h"
> -
>  #endif
> diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
> index a8939f5e58..df3acbb541 100644
> --- a/hw/xtensa/pic_cpu.c
> +++ b/hw/xtensa/pic_cpu.c
> @@ -33,7 +33,7 @@
>
>  void check_interrupts(CPUXtensaState *env)
>  {
> -    CPUState *cs = CPU(xtensa_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int minlevel = xtensa_get_cintlevel(env);
>      uint32_t int_set_enabled = env->sregs[INTSET] & env->sregs[INTENABLE];
>      int level;
> diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
> index bee78edb8a..64831c9199 100644
> --- a/linux-user/xtensa/cpu_loop.c
> +++ b/linux-user/xtensa/cpu_loop.c
> @@ -123,7 +123,7 @@ static void xtensa_underflow12(CPUXtensaState *env)
>
>  void cpu_loop(CPUXtensaState *env)
>  {
> -    CPUState *cs = CPU(xtensa_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      target_siginfo_t info;
>      abi_ulong ret;
>      int trapnr;
> diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
> index cd8fbd653a..be1f81107b 100644
> --- a/target/xtensa/dbg_helper.c
> +++ b/target/xtensa/dbg_helper.c
> @@ -71,7 +71,7 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
>  static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
>          uint32_t dbreakc)
>  {
> -    CPUState *cs = CPU(xtensa_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
>      uint32_t mask = dbreakc | ~DBREAKC_MASK;
>
> @@ -118,7 +118,7 @@ void HELPER(wsr_dbreakc)(CPUXtensaState *env, uint32_t i, uint32_t v)
>              set_dbreak(env, i, env->sregs[DBREAKA + i], v);
>          } else {
>              if (env->cpu_watchpoint[i]) {
> -                CPUState *cs = CPU(xtensa_env_get_cpu(env));
> +                CPUState *cs = env_cpu(env);
>
>                  cpu_watchpoint_remove_by_ref(cs, env->cpu_watchpoint[i]);
>                  env->cpu_watchpoint[i] = NULL;
> diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
> index 4a1f7aef5d..601341d13a 100644
> --- a/target/xtensa/exc_helper.c
> +++ b/target/xtensa/exc_helper.c
> @@ -34,7 +34,7 @@
>
>  void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
>  {
> -    CPUState *cs = CPU(xtensa_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = excp;
>      if (excp == EXCP_YIELD) {
> @@ -100,7 +100,7 @@ void HELPER(debug_exception)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
>
>  void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
>  {
> -    CPUState *cpu;
> +    CPUState *cpu = env_cpu(env);
>
>      env->pc = pc;
>      env->sregs[PS] = (env->sregs[PS] & ~PS_INTLEVEL) |
> @@ -111,11 +111,10 @@ void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
>      qemu_mutex_unlock_iothread();
>
>      if (env->pending_irq_level) {
> -        cpu_loop_exit(CPU(xtensa_env_get_cpu(env)));
> +        cpu_loop_exit(cpu);
>          return;
>      }
>
> -    cpu = CPU(xtensa_env_get_cpu(env));
>      cpu->halted = 1;
>      HELPER(exception)(env, EXCP_HLT);
>  }
> @@ -165,7 +164,7 @@ static void handle_interrupt(CPUXtensaState *env)
>          (env->config->level_mask[level] &
>           env->sregs[INTSET] &
>           env->sregs[INTENABLE])) {
> -        CPUState *cs = CPU(xtensa_env_get_cpu(env));
> +        CPUState *cs = env_cpu(env);
>
>          if (level > 1) {
>              env->sregs[EPC1 + level - 1] = env->pc;
> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> index 5f37f378a3..7e5c10e098 100644
> --- a/target/xtensa/helper.c
> +++ b/target/xtensa/helper.c
> @@ -316,7 +316,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>
>  void xtensa_runstall(CPUXtensaState *env, bool runstall)
>  {
> -    CPUState *cpu = CPU(xtensa_env_get_cpu(env));
> +    CPUState *cpu = env_cpu(env);
>
>      env->runstall = runstall;
>      cpu->halted = runstall;
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index 79a10da231..2603f43807 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -46,12 +46,10 @@ void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
>
>  void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)
>  {
> -    XtensaCPU *cpu = xtensa_env_get_cpu(env);
> -
>      v = (v & 0xffffff00) | 0x1;
>      if (v != env->sregs[RASID]) {
>          env->sregs[RASID] = v;
> -        tlb_flush(CPU(cpu));
> +        tlb_flush(env_cpu(env));
>      }
>  }
>
> @@ -250,7 +248,7 @@ void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
>          uint32_t wi;
>          xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
>          if (entry->variable && entry->asid) {
> -            tlb_flush_page(CPU(xtensa_env_get_cpu(env)), entry->vaddr);
> +            tlb_flush_page(env_cpu(env), entry->vaddr);
>              entry->asid = 0;
>          }
>      }
> @@ -296,8 +294,7 @@ void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
>  void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
>                            unsigned wi, unsigned ei, uint32_t vpn, uint32_t pte)
>  {
> -    XtensaCPU *cpu = xtensa_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>      xtensa_tlb_entry *entry = xtensa_tlb_get_entry(env, dtlb, wi, ei);
>
>      if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
> @@ -652,7 +649,7 @@ static int get_physical_addr_mmu(CPUXtensaState *env, bool update_tlb,
>
>  static bool get_pte(CPUXtensaState *env, uint32_t vaddr, uint32_t *pte)
>  {
> -    CPUState *cs = CPU(xtensa_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      uint32_t paddr;
>      uint32_t page_size;
>      unsigned access;
> diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
> index 5f5ce4f344..bb29adc921 100644
> --- a/target/xtensa/xtensa-semi.c
> +++ b/target/xtensa/xtensa-semi.c
> @@ -197,7 +197,7 @@ void xtensa_sim_open_console(Chardev *chr)
>
>  void HELPER(simcall)(CPUXtensaState *env)
>  {
> -    CPUState *cs = CPU(xtensa_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      uint32_t *regs = env->regs;
>
>      switch (regs[2]) {
> --
> 2.17.1
>
>

