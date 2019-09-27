Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD96FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF3F207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF3F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDq5V-0004kW-Fr
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iDpqh-0002KK-56
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iDpqd-0002zA-8m
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:59:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iDpqc-0002x3-4k; Fri, 27 Sep 2019 08:59:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 519C518C428C;
 Fri, 27 Sep 2019 11:05:39 +0000 (UTC)
Received: from [10.36.116.169] (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7500A4510;
 Fri, 27 Sep 2019 11:05:38 +0000 (UTC)
Subject: Re: [PATCH v3 18/18] target/s390x: Remove ilen argument from
 trigger_pgm_exception
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190926162615.31168-1-richard.henderson@linaro.org>
 <20190926162615.31168-19-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <b6ea753b-af08-5432-5b11-c9da57cfee5d@redhat.com>
Date: Fri, 27 Sep 2019 13:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926162615.31168-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 27 Sep 2019 11:05:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26.09.19 18:26, Richard Henderson wrote:
> All but one caller passes ILEN_UNWIND, which is not stored.
> For the one use case in s390_cpu_tlb_fill, set int_pgm_ilen
> directly, simply to avoid the assert within do_program_interrupt.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/internal.h    | 2 +-
>  target/s390x/excp_helper.c | 7 ++++---
>  target/s390x/interrupt.c   | 7 ++-----
>  target/s390x/mmu_helper.c  | 2 +-
>  4 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index c993c3ef40..d37816104d 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -317,7 +317,7 @@ void cpu_unmap_lowcore(LowCore *lowcore);
>  
>  
>  /* interrupt.c */
> -void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
> +void trigger_pgm_exception(CPUS390XState *env, uint32_t code);
>  void cpu_inject_clock_comparator(S390CPU *cpu);
>  void cpu_inject_cpu_timer(S390CPU *cpu);
>  void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index c252e9a7d8..e70c20d363 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -42,7 +42,7 @@ void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
>      cpu_restore_state(cs, ra, true);
>      qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
>                    env->psw.addr);
> -    trigger_pgm_exception(env, code, ILEN_UNWIND);
> +    trigger_pgm_exception(env, code);
>      cpu_loop_exit(cs);
>  }
>  
> @@ -96,7 +96,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>  {
>      S390CPU *cpu = S390_CPU(cs);
>  
> -    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_UNWIND);
> +    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING);
>      /* On real machines this value is dropped into LowMem.  Since this
>         is userland, simply put this someplace that cpu_loop can find it.  */
>      cpu->env.__excp_addr = address;
> @@ -186,7 +186,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       * and so unwinding will not occur.  However, ILEN is also undefined
>       * for that case -- we choose to set ILEN = 2.
>       */
> -    trigger_pgm_exception(env, excp, 2);
> +    env->int_pgm_ilen = 2;
> +    trigger_pgm_exception(env, excp);
>      cpu_loop_exit_restore(cs, retaddr);
>  }
>  
> diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
> index 2b71e03914..4cdbbc8849 100644
> --- a/target/s390x/interrupt.c
> +++ b/target/s390x/interrupt.c
> @@ -22,16 +22,13 @@
>  #endif
>  
>  /* Ensure to exit the TB after this call! */
> -void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
> +void trigger_pgm_exception(CPUS390XState *env, uint32_t code)
>  {
>      CPUState *cs = env_cpu(env);
>  
>      cs->exception_index = EXCP_PGM;
>      env->int_pgm_code = code;
> -    /* If ILEN_UNWIND, int_pgm_ilen already has the correct value.  */
> -    if (ilen != ILEN_UNWIND) {
> -        env->int_pgm_ilen = ilen;
> -    }
> +    /* env->int_pgm_ilen is already set, or will be set during unwinding */
>  }
>  
>  void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra)
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index e6c3139c57..ba02d33e86 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -44,7 +44,7 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
>          if (type != PGM_ADDRESSING) {
>              stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
>          }
> -        trigger_pgm_exception(env, type, ILEN_UNWIND);
> +        trigger_pgm_exception(env, type);
>      }
>  }
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

