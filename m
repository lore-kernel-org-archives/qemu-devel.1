Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BFDC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F722087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F722087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hta7h-00073j-AQ
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hta6c-0004v0-29
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hta6Y-0002uf-GO
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:08:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hta6Y-0002tV-9X
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:08:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so72806982edd.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PmcxLtiieGLRzL5rIEcHI0v84Y1wQ83aJZqoLV6Ssms=;
 b=fHrIumXemVhoSh5UOYwYbJ+KcNZ0nFWEXA/33NHGTOtSmO45wiMjdi1hF/WtdhQu9s
 UbqQrDPZKBzwI/D5os4byrQ5HEAq7AV6chf9sGfnXPQPNHLM+EdHpwixiWUgYTunlKRy
 JX3aEJ2eta4p4UVRjZU8fhhZRuDucNdblCICitQaparIG/WHU28HrvW1aDgmvmmbfklN
 TmEdR8uUFDUnxLT9/2UX6CnZpL0T1pswlHjz6D5KeCd8TiO1+ZHVX5o6+F7jiK7lql0A
 /sXbjI4IJb7CxRFBsCyVt9gRuc09S1OZkDpMHyEsUPLiL4OBOauvkxWHAdWl3gQSejX7
 axFA==
X-Gm-Message-State: APjAAAXIng1VIHqGfyCl1brgzBNbTgyNwQD1dm9yQICkysYzEPtf96ve
 HWiSvJUXjWZamQs32HtPXWkm7ndts+ShpA==
X-Google-Smtp-Source: APXvYqyTnkeBRc8njG/gHu+Miep0dfDNr61pbD34e61vEv1OgFzMfsneSKJV4nA1KkAHokrgL0irvw==
X-Received: by 2002:aa7:d404:: with SMTP id z4mr119931319edq.131.1564762109341; 
 Fri, 02 Aug 2019 09:08:29 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id h2sm17538689edq.33.2019.08.02.09.08.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:08:28 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1564677923-23173-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564677923-23173-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0e631e4b-9a8c-c83e-6d7f-f0a1612603a6@redhat.com>
Date: Fri, 2 Aug 2019 18:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564677923-23173-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.67
Subject: Re: [Qemu-devel] [PATCH for 4.2 v5 06/12] target/mips: Style
 improvements in cp0_timer.c
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/1/19 6:45 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Fixes mostly errors and warings reported by 'checkpatch.pl -f'.

"warnings"

> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/cp0_timer.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
> index f471639..b5f3560 100644
> --- a/target/mips/cp0_timer.c
> +++ b/target/mips/cp0_timer.c
> @@ -29,7 +29,7 @@
>  #define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
>  
>  /* XXX: do not use a global */
> -uint32_t cpu_mips_get_random (CPUMIPSState *env)
> +uint32_t cpu_mips_get_random(CPUMIPSState *env)
>  {
>      static uint32_t seed = 1;
>      static uint32_t prev_idx = 0;
> @@ -42,8 +42,10 @@ uint32_t cpu_mips_get_random (CPUMIPSState *env)
>  
>      /* Don't return same value twice, so get another value */
>      do {
> -        /* Use a simple algorithm of Linear Congruential Generator
> -         * from ISO/IEC 9899 standard. */
> +        /*
> +         * Use a simple algorithm of Linear Congruential Generator
> +         * from ISO/IEC 9899 standard.
> +         */
>          seed = 1103515245 * seed + 12345;
>          idx = (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
>      } while (idx == prev_idx);
> @@ -73,7 +75,7 @@ static void cpu_mips_timer_expire(CPUMIPSState *env)
>      qemu_irq_raise(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
>  }
>  
> -uint32_t cpu_mips_get_count (CPUMIPSState *env)
> +uint32_t cpu_mips_get_count(CPUMIPSState *env)
>  {
>      if (env->CP0_Cause & (1 << CP0Ca_DC)) {
>          return env->CP0_Count;
> @@ -91,16 +93,16 @@ uint32_t cpu_mips_get_count (CPUMIPSState *env)
>      }
>  }
>  
> -void cpu_mips_store_count (CPUMIPSState *env, uint32_t count)
> +void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
>  {
>      /*
>       * This gets called from cpu_state_reset(), potentially before timer init.
>       * So env->timer may be NULL, which is also the case with KVM enabled so
>       * treat timer as disabled in that case.
>       */
> -    if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer)
> +    if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer) {
>          env->CP0_Count = count;
> -    else {
> +    } else {
>          /* Store new count register */
>          env->CP0_Count = count -
>                 (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_PERIOD);
> @@ -109,13 +111,15 @@ void cpu_mips_store_count (CPUMIPSState *env, uint32_t count)
>      }
>  }
>  
> -void cpu_mips_store_compare (CPUMIPSState *env, uint32_t value)
> +void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value)
>  {
>      env->CP0_Compare = value;
> -    if (!(env->CP0_Cause & (1 << CP0Ca_DC)))
> +    if (!(env->CP0_Cause & (1 << CP0Ca_DC))) {
>          cpu_mips_timer_update(env);
> -    if (env->insn_flags & ISA_MIPS32R2)
> +    }
> +    if (env->insn_flags & ISA_MIPS32R2) {
>          env->CP0_Cause &= ~(1 << CP0Ca_TI);
> +    }
>      qemu_irq_lower(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
>  }
>  
> @@ -131,27 +135,27 @@ void cpu_mips_stop_count(CPUMIPSState *env)
>                                   TIMER_PERIOD);
>  }
>  
> -static void mips_timer_cb (void *opaque)
> +static void mips_timer_cb(void *opaque)
>  {
>      CPUMIPSState *env;
>  
>      env = opaque;
> -#if 0
> -    qemu_log("%s\n", __func__);
> -#endif
>  
> -    if (env->CP0_Cause & (1 << CP0Ca_DC))
> +    if (env->CP0_Cause & (1 << CP0Ca_DC)) {
>          return;
> +    }
>  
> -    /* ??? This callback should occur when the counter is exactly equal to
> -       the comparator value.  Offset the count by one to avoid immediately
> -       retriggering the callback before any virtual time has passed.  */
> +    /*
> +     * ??? This callback should occur when the counter is exactly equal to
> +     * the comparator value.  Offset the count by one to avoid immediately
> +     * retriggering the callback before any virtual time has passed.
> +     */
>      env->CP0_Count++;
>      cpu_mips_timer_expire(env);
>      env->CP0_Count--;
>  }
>  
> -void cpu_mips_clock_init (MIPSCPU *cpu)
> +void cpu_mips_clock_init(MIPSCPU *cpu)
>  {
>      CPUMIPSState *env = &cpu->env;
>  
> 

