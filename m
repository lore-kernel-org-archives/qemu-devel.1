Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DCFC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C311206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C311206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOfo7-00042t-JT
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 05:57:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOfnK-0003iU-UJ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOfnJ-0002PZ-Fn
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:56:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOfnJ-0002Ow-8p
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:56:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id e11so2166296wrs.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 02:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4Wk87tsMXunMp2IbUHif9dlZ5+xg/y2zw5sLtTMUzxE=;
	b=RF5o8cxVtRCFJMDRp/QLr2UmHsXumRxXNFhYdAs6iXf3cYsKk90QCdJRG9xXfXbe5M
	3nc2KmaqEKYyDTdQVAGoVnhhY8ukcJn7Fsp901jipeSZJsTalYKUy30AOqpmxboLXUxD
	UZQHZjejsF9ZiWOlWUYXyrQ/erL7Lj3GtH3KQB69nDRJPWPPavUQp8FWFbA4MT8TNM5p
	oFn92HyRT1IUwXQ6dxWF1KVBrNKmesigH19UHjHOSgikrTvtmpFY0ysHBrlffJOscJwl
	Wdr253QFkTib0tw8rHi7z7XKRH1VkPbj/SH9aPPPHAwUQHjeeM0q2j6TAcYHVuBqVaBT
	jFNQ==
X-Gm-Message-State: APjAAAXluiAPw+xivo674iMeiOmnAwiIsuW+4nZabDc3iLK0fljz9q9f
	GSIcC5Qd1WzQS1VOA6s5yeqleOPxMjo=
X-Google-Smtp-Source: APXvYqx7A3xJdhR6JVM8u1f7zpjkINTQ3YzIbnUEh63l8iDb4qUBqXCvSMBbg0K9mVM4vKVU6MPEbA==
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr2407703wrn.289.1557395811942; 
	Thu, 09 May 2019 02:56:51 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id i17sm7554655wmb.0.2019.05.09.02.56.51
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 02:56:51 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190509060246.4031-1-richard.henderson@linaro.org>
	<20190509060246.4031-28-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e5f8ae6c-07a8-33b6-0537-388db2bc0998@redhat.com>
Date: Thu, 9 May 2019 11:56:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509060246.4031-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 27/27] tcg: Use tlb_fill probe from
 tlb_vaddr_to_host
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 8:02 AM, Richard Henderson wrote:
> Most of the existing users would continue around a loop which
> would fault the tlb entry in via a normal load/store.  But for
> SVE we have a true non-faulting case which requires the new
> probing form of tlb_fill.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Update function docs comment.
> ---
>  include/exec/cpu_ldst.h | 50 ++++++-----------------------
>  accel/tcg/cputlb.c      | 69 ++++++++++++++++++++++++++++++++++++-----
>  target/arm/sve_helper.c |  6 +---
>  3 files changed, 72 insertions(+), 53 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index d78041d7a0..7b28a839d2 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -433,50 +433,20 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
>   * @mmu_idx: MMU index to use for lookup
>   *
>   * Look up the specified guest virtual index in the TCG softmmu TLB.
> - * If the TLB contains a host virtual address suitable for direct RAM
> - * access, then return it. Otherwise (TLB miss, TLB entry is for an
> - * I/O access, etc) return NULL.
> - *
> - * This is the equivalent of the initial fast-path code used by
> - * TCG backends for guest load and store accesses.
> + * If we can translate a host virtual address suitable for direct RAM
> + * access, without causing a guest exception, then return it.
> + * Otherwise (TLB entry is for an I/O access, guest software
> + * TLB fill required, etc) return NULL.
>   */
> +#ifdef CONFIG_USER_ONLY
>  static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
> -                                      int access_type, int mmu_idx)
> +                                      MMUAccessType access_type, int mmu_idx)
>  {
> -#if defined(CONFIG_USER_ONLY)
>      return g2h(addr);
> -#else
> -    CPUTLBEntry *tlbentry = tlb_entry(env, mmu_idx, addr);
> -    abi_ptr tlb_addr;
> -    uintptr_t haddr;
> -
> -    switch (access_type) {
> -    case 0:
> -        tlb_addr = tlbentry->addr_read;
> -        break;
> -    case 1:
> -        tlb_addr = tlb_addr_write(tlbentry);
> -        break;
> -    case 2:
> -        tlb_addr = tlbentry->addr_code;
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
> -    if (!tlb_hit(tlb_addr, addr)) {
> -        /* TLB entry is for a different page */
> -        return NULL;
> -    }
> -
> -    if (tlb_addr & ~TARGET_PAGE_MASK) {
> -        /* IO access */
> -        return NULL;
> -    }
> -
> -    haddr = addr + tlbentry->addend;
> -    return (void *)haddr;
> -#endif /* defined(CONFIG_USER_ONLY) */
>  }
> +#else
> +void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
> +                        MMUAccessType access_type, int mmu_idx);
> +#endif
>  
>  #endif /* CPU_LDST_H */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index dfcd9ae168..45a5c4e123 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1007,6 +1007,16 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      }
>  }
>  
> +static inline target_ulong tlb_read_ofs(CPUTLBEntry *entry, size_t ofs)
> +{
> +#if TCG_OVERSIZED_GUEST
> +    return *(target_ulong *)((uintptr_t)entry + ofs);
> +#else
> +    /* ofs might correspond to .addr_write, so use atomic_read */
> +    return atomic_read((target_ulong *)((uintptr_t)entry + ofs));
> +#endif
> +}
> +
>  /* Return true if ADDR is present in the victim tlb, and has been copied
>     back to the main tlb.  */
>  static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
> @@ -1017,14 +1027,7 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
>      assert_cpu_is_self(ENV_GET_CPU(env));
>      for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
>          CPUTLBEntry *vtlb = &env->tlb_v_table[mmu_idx][vidx];
> -        target_ulong cmp;
> -
> -        /* elt_ofs might correspond to .addr_write, so use atomic_read */
> -#if TCG_OVERSIZED_GUEST
> -        cmp = *(target_ulong *)((uintptr_t)vtlb + elt_ofs);
> -#else
> -        cmp = atomic_read((target_ulong *)((uintptr_t)vtlb + elt_ofs));
> -#endif
> +        target_ulong cmp = tlb_read_ofs(vtlb, elt_ofs);
>  
>          if (cmp == page) {
>              /* Found entry in victim tlb, swap tlb and iotlb.  */
> @@ -1108,6 +1111,56 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
>      }
>  }
>  
> +void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
> +                        MMUAccessType access_type, int mmu_idx)
> +{
> +    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
> +    uintptr_t tlb_addr, page;
> +    size_t elt_ofs;
> +
> +    switch (access_type) {
> +    case MMU_DATA_LOAD:
> +        elt_ofs = offsetof(CPUTLBEntry, addr_read);
> +        break;
> +    case MMU_DATA_STORE:
> +        elt_ofs = offsetof(CPUTLBEntry, addr_write);
> +        break;
> +    case MMU_INST_FETCH:
> +        elt_ofs = offsetof(CPUTLBEntry, addr_code);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    page = addr & TARGET_PAGE_MASK;
> +    tlb_addr = tlb_read_ofs(entry, elt_ofs);
> +
> +    if (!tlb_hit_page(tlb_addr, page)) {
> +        uintptr_t index = tlb_index(env, mmu_idx, addr);
> +
> +        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs, page)) {
> +            CPUState *cs = ENV_GET_CPU(env);
> +            CPUClass *cc = CPU_GET_CLASS(cs);
> +
> +            if (!cc->tlb_fill(cs, addr, 0, access_type, mmu_idx, true, 0)) {
> +                /* Non-faulting page table read failed.  */
> +                return NULL;
> +            }
> +
> +            /* TLB resize via tlb_fill may have moved the entry.  */
> +            entry = tlb_entry(env, mmu_idx, addr);
> +        }
> +        tlb_addr = tlb_read_ofs(entry, elt_ofs);
> +    }
> +
> +    if (tlb_addr & ~TARGET_PAGE_MASK) {
> +        /* IO access */
> +        return NULL;
> +    }
> +
> +    return (void *)(addr + entry->addend);
> +}
> +
>  /* Probe for a read-modify-write atomic operation.  Do not allow unaligned
>   * operations, or io operations to proceed.  Return the host address.  */
>  static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index bc847250dd..fd434c66ea 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -4598,11 +4598,7 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
>       * in the real world, obviously.)
>       *
>       * Then there are the annoying special cases with watchpoints...
> -     *
> -     * TODO: Add a form of tlb_fill that does not raise an exception,
> -     * with a form of tlb_vaddr_to_host and a set of loads to match.
> -     * The non_fault_vaddr_to_host would handle everything, usually,
> -     * and the loads would handle the iomem path for watchpoints.
> +     * TODO: Add a form of non-faulting loads using cc->tlb_fill(probe=true).
>       */
>      host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
>      split = max_for_page(addr, mem_off, mem_max);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

