Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E4C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3412087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3412087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htaRV-00041W-D0
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37739)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1htaQy-00038m-Rn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1htaQx-0005xQ-Lv
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:29:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1htaQx-0005xG-FB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:29:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so38127386edo.5
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Gtr+PXuQmiP3euJicBT2c98KZiifLe98zMjXeKqqAg=;
 b=gIyK3zU8yBCYf4TmQO5dX4UJD6cz2hH7P7t3OC6dekRcbsbOLK+0eZG7/zFf6mXLy6
 /931UJ9tAq+O4BYdNQzZD37zESNXBrrfGVUaJIdj28Cb3lmpruDqIzT5jpR59Zr+QyJv
 INJLyhX4Ylhult/DiiKPS99n7qDInavnpDhc0t99q04s00D+w0cHZFV5YMbtNb0Jg3pF
 jGmSSKvhG5nw1w7W/tZPTegvxIKnG3HBU8No/Bqj+7NhPe7Xs29vNdaWtq/WCppwYbgh
 kLfbc8lPmQXitAWRkwOeApyIwwjdZwOrLIYmE1I3q6nX0osl56x7IRDcssZI5VEaaOSu
 K4Kw==
X-Gm-Message-State: APjAAAVWnjY5CTehZvuSaz+ejAE9oiKaBhems40I4tAv6I32m/P7T/8v
 H0i+h0d8D3bIHyeWxHp2e49oKQ==
X-Google-Smtp-Source: APXvYqyANeLKiZW+OVaYdWbhcEMF4stC9uPwSpDdM024N8uhDvGWAP4K9hMQOjVbXPeC37cj72/G+Q==
X-Received: by 2002:a50:8828:: with SMTP id
 b37mr119971503edb.266.1564763374631; 
 Fri, 02 Aug 2019 09:29:34 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id x12sm17777111edr.60.2019.08.02.09.29.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:29:34 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190802160458.25681-1-peter.maydell@linaro.org>
 <20190802160458.25681-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2a876aa1-31a7-bf10-7e40-004315ad5e56@redhat.com>
Date: Fri, 2 Aug 2019 18:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190802160458.25681-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.65
Subject: Re: [Qemu-devel] [PATCH 2/3] target/mips: Switch to
 do_transaction_failed() hook
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing James Hogan.

On 8/2/19 6:04 PM, Peter Maydell wrote:
> Switch the MIPS target from the old unassigned_access hook to the new
> do_transaction_failed hook.
> 
> Unlike the old hook, do_transaction_failed is only ever called from
> the TCG memory access paths, so there is no need for the "ignore this
> if we're using KVM" hack that we were previously using to work around
> the way unassigned_access was called for all kinds of memory accesses
> to unassigned physical addresses.
> 
> The MIPS target does not ever do direct memory reads by physical
> address (via either ldl_phys etc or address_space_ldl etc), so the
> only memory accesses this affects are the 'normal' guest loads and
> stores, which will be handled by the new hook; their behaviour is
> unchanged.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/mips/internal.h  |  8 +++++---
>  target/mips/cpu.c       |  2 +-
>  target/mips/op_helper.c | 24 ++++++++----------------
>  3 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index b2b41a51ab4..26533bb937d 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -138,9 +138,11 @@ void r4k_helper_tlbinv(CPUMIPSState *env);
>  void r4k_helper_tlbinvf(CPUMIPSState *env);
>  void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
>  
> -void mips_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
> -                                bool is_write, bool is_exec, int unused,
> -                                unsigned size);
> +void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> +                                    vaddr addr, unsigned size,
> +                                    MMUAccessType access_type,
> +                                    int mmu_idx, MemTxAttrs attrs,
> +                                    MemTxResult response, uintptr_t retaddr);
>  hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address,
>                                    int rw);
>  #endif
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 39eafafc5cd..a79badcb1a6 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -197,7 +197,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
>      cc->gdb_read_register = mips_cpu_gdb_read_register;
>      cc->gdb_write_register = mips_cpu_gdb_write_register;
>  #ifndef CONFIG_USER_ONLY
> -    cc->do_unassigned_access = mips_cpu_unassigned_access;
> +    cc->do_transaction_failed = mips_cpu_do_transaction_failed;
>      cc->do_unaligned_access = mips_cpu_do_unaligned_access;
>      cc->get_phys_page_debug = mips_cpu_get_phys_page_debug;
>      cc->vmsd = &vmstate_mips_cpu;
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 9e2e02f8586..65ff9f5b935 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2666,27 +2666,19 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>      do_raise_exception_err(env, excp, error_code, retaddr);
>  }
>  
> -void mips_cpu_unassigned_access(CPUState *cs, hwaddr addr,
> -                                bool is_write, bool is_exec, int unused,
> -                                unsigned size)
> +void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> +                                    vaddr addr, unsigned size,
> +                                    MMUAccessType access_type,
> +                                    int mmu_idx, MemTxAttrs attrs,
> +                                    MemTxResult response, uintptr_t retaddr)
>  {
>      MIPSCPU *cpu = MIPS_CPU(cs);
>      CPUMIPSState *env = &cpu->env;
>  
> -    /*
> -     * Raising an exception with KVM enabled will crash because it won't be from
> -     * the main execution loop so the longjmp won't have a matching setjmp.
> -     * Until we can trigger a bus error exception through KVM lets just ignore
> -     * the access.
> -     */
> -    if (kvm_enabled()) {
> -        return;

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> -    }
> -
> -    if (is_exec) {
> -        raise_exception(env, EXCP_IBE);
> +    if (access_type == MMU_INST_FETCH) {
> +        do_raise_exception(env, EXCP_IBE, retaddr);
>      } else {
> -        raise_exception(env, EXCP_DBE);
> +        do_raise_exception(env, EXCP_DBE, retaddr);
>      }
>  }
>  #endif /* !CONFIG_USER_ONLY */
> 

