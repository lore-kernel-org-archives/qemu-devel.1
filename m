Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F7C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522A121874
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522A121874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3OCt-0008CT-FH
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3OC3-0007c3-Vh
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3OC2-0003zF-Ja
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:26:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3OC2-0003yn-A8
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:26:42 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 315FA3C928
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 17:26:41 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id f18so1633590wro.19
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I8ihsqUTb7XVlB3tBrGNmPgrnLt4U+vM4XK7+I83nv0=;
 b=Y15156gj8Rqi6IORQpRkrCgfk3MQ9ZILZC1JFBpPZUeUbclbE+fZE4i5M+1ZpNlMqt
 0tBKrXHreB0B1k3ThTH0fsbtQPzQ+5CGoqs1dWWWRGmmqcr5aNr/hdLglM1tZh6QFS2m
 LzLJtV1rtiY9laWGV3CL6IP0IeZi0SQZct78koMxD57+ndBjRnKcvX7cxfEvOY2oZoLv
 4vJcGtrPDiLrsHi/h8ocofNCrBmB0qIsUW/xpjLeFKtMQufznHPeWBfcmTIFI8P46CLY
 pZYI+4eIPMgAOsNfV4repc42bqpSPgzzwkGw14lTxx2lM7+HPPsuKpYMOH22HumBEjEz
 eURA==
X-Gm-Message-State: APjAAAV19C9B9eaWUd8Sed0do+RhBt3qTksWM9UidjwOkXf0cJK++ORR
 NrWWUWg8xYUZtkv002TsZTx1HAwgR7o16l/hHCSXjhJKvFN1iP6Sp6BPBkSKITabhONmnmrdODl
 DUY/Fmy19umbgqdY=
X-Received: by 2002:a1c:1fc7:: with SMTP id f190mr6072793wmf.62.1567099599831; 
 Thu, 29 Aug 2019 10:26:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwLLxWDmSL+l2F1lEjtiaQ+BfBBiAgWXLPFIDYiH4HOmI2DCZDCSU+cRu2lM2doyCYY2YpoVg==
X-Received: by 2002:a1c:1fc7:: with SMTP id f190mr6072656wmf.62.1567099598671; 
 Thu, 29 Aug 2019 10:26:38 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id f10sm2448607wrm.31.2019.08.29.10.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 10:26:37 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828231651.17176-1-richard.henderson@linaro.org>
 <20190828231651.17176-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a7cf962f-eeb3-3628-4f33-c02292d4f07a@redhat.com>
Date: Thu, 29 Aug 2019 19:26:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828231651.17176-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/8] exec: Factor out core logic of
 check_watchpoint()
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard, David,

On 8/29/19 1:16 AM, Richard Henderson wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> We want to perform the same checks in probe_write() to trigger a cpu
> exit before doing any modifications. We'll have to pass a PC.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20190823100741.9621-9-david@redhat.com>
> [rth: Use vaddr for len, like other watchpoint functions;
> Move user-only stub to static inline.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/hw/core/cpu.h |  7 +++++++
>  exec.c                | 26 ++++++++++++++++++--------
>  2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 6de688059d..7bd8bed5b2 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1091,6 +1091,11 @@ static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
>  static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
>  {
>  }
> +
> +static inline void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
> +                                        MemTxAttrs atr, int fl, uintptr_t ra)
> +{
> +}
>  #else
>  int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>                            int flags, CPUWatchpoint **watchpoint);
> @@ -1098,6 +1103,8 @@ int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
>                            vaddr len, int flags);
>  void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
>  void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
> +void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
> +                          MemTxAttrs attrs, int flags, uintptr_t ra);
>  #endif
>  
>  /**
> diff --git a/exec.c b/exec.c
> index 31fb75901f..cb6f5763dc 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2789,11 +2789,10 @@ static const MemoryRegionOps notdirty_mem_ops = {
>  };
>  
>  /* Generate a debug exception if a watchpoint has been hit.  */
> -static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
> +void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
> +                          MemTxAttrs attrs, int flags, uintptr_t ra)
>  {
> -    CPUState *cpu = current_cpu;
>      CPUClass *cc = CPU_GET_CLASS(cpu);
> -    target_ulong vaddr;
>      CPUWatchpoint *wp;
>  
>      assert(tcg_enabled());
> @@ -2804,17 +2803,17 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
>          cpu_interrupt(cpu, CPU_INTERRUPT_DEBUG);
>          return;
>      }
> -    vaddr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
> -    vaddr = cc->adjust_watchpoint_address(cpu, vaddr, len);
> +
> +    addr = cc->adjust_watchpoint_address(cpu, addr, len);
>      QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
> -        if (cpu_watchpoint_address_matches(wp, vaddr, len)
> +        if (cpu_watchpoint_address_matches(wp, addr, len)
>              && (wp->flags & flags)) {
>              if (flags == BP_MEM_READ) {
>                  wp->flags |= BP_WATCHPOINT_HIT_READ;
>              } else {
>                  wp->flags |= BP_WATCHPOINT_HIT_WRITE;
>              }
> -            wp->hitaddr = vaddr;
> +            wp->hitaddr = MAX(addr, wp->vaddr);

When is addr > wp->vaddr?

>              wp->hitattrs = attrs;
>              if (!cpu->watchpoint_hit) {
>                  if (wp->flags & BP_CPU &&
> @@ -2829,11 +2828,14 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
>                  if (wp->flags & BP_STOP_BEFORE_ACCESS) {
>                      cpu->exception_index = EXCP_DEBUG;
>                      mmap_unlock();
> -                    cpu_loop_exit(cpu);
> +                    cpu_loop_exit_restore(cpu, ra);
>                  } else {
>                      /* Force execution of one insn next time.  */
>                      cpu->cflags_next_tb = 1 | curr_cflags();
>                      mmap_unlock();
> +                    if (ra) {
> +                        cpu_restore_state(cpu, ra, true);
> +                    }
>                      cpu_loop_exit_noexc(cpu);
>                  }
>              }
> @@ -2843,6 +2845,14 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
>      }
>  }
>  
> +static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
> +{
> +    CPUState *cpu = current_cpu;
> +    vaddr addr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
> +
> +    cpu_check_watchpoint(cpu, addr, len, attrs, flags, 0);
> +}
> +
>  /* Watchpoint access routines.  Watchpoints are inserted using TLB tricks,
>     so these check for a hit then pass through to the normal out-of-line
>     phys routines.  */
> 

