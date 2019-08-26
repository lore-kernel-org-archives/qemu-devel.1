Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FACC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FAC20874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FAC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2AW9-0000Bg-Uj
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 04:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i2AUo-0007ie-8T
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i2AUm-0007ar-Jr
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:37:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1i2AUm-0007aa-BX
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:37:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DC994ACA7;
 Mon, 26 Aug 2019 08:36:59 +0000 (UTC)
Received: from [10.36.116.227] (ovpn-116-227.ams2.redhat.com [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B47C5D704;
 Mon, 26 Aug 2019 08:36:58 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190824213451.31118-1-richard.henderson@linaro.org>
 <20190824213451.31118-4-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <4a9697ec-dad4-db33-5a43-569093f0742a@redhat.com>
Date: Mon, 26 Aug 2019 10:36:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824213451.31118-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 26 Aug 2019 08:36:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/6] cputlb: Fold TLB_RECHECK into
 TLB_INVALID_MASK
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.08.19 23:34, Richard Henderson wrote:
> We had two different mechanisms to force a recheck of the tlb.
> 
> Before TLB_RECHECK was introduced, we had a PAGE_WRITE_INV bit
> that would immediate set TLB_INVALID_MASK, which automatically
> means that a second check of the tlb entry fails.
> 
> We can use the same mechanism to handle small pages.
> Conserve TLB_* bits by removing TLB_RECHECK.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h |  5 +--
>  accel/tcg/cputlb.c     | 86 +++++++++++-------------------------------
>  2 files changed, 24 insertions(+), 67 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 8323094648..8d07ae23a5 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -329,14 +329,11 @@ CPUArchState *cpu_copy(CPUArchState *env);
>  #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS - 2))
>  /* Set if TLB entry is an IO callback.  */
>  #define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
> -/* Set if TLB entry must have MMU lookup repeated for every access */
> -#define TLB_RECHECK         (1 << (TARGET_PAGE_BITS - 4))
>  
>  /* Use this mask to check interception with an alignment mask
>   * in a TCG backend.
>   */
> -#define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
> -                         | TLB_RECHECK)
> +#define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO)
>  
>  /**
>   * tlb_hit_page: return true if page aligned @addr is a hit against the
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d9787cc893..c9576bebcf 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -732,11 +732,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
>  
>      address = vaddr_page;
>      if (size < TARGET_PAGE_SIZE) {
> -        /*
> -         * Slow-path the TLB entries; we will repeat the MMU check and TLB
> -         * fill on every access.
> -         */
> -        address |= TLB_RECHECK;
> +        /* Repeat the MMU check and TLB fill on every access.  */
> +        address |= TLB_INVALID_MASK;
>      }
>      if (attrs.byte_swap) {
>          /* Force the access through the I/O slow path.  */
> @@ -1026,10 +1023,15 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
>    victim_tlb_hit(env, mmu_idx, index, offsetof(CPUTLBEntry, TY), \
>                   (ADDR) & TARGET_PAGE_MASK)
>  
> -/* NOTE: this function can trigger an exception */
> -/* NOTE2: the returned address is not exactly the physical address: it
> - * is actually a ram_addr_t (in system mode; the user mode emulation
> - * version of this function returns a guest virtual address).
> +/*
> + * Return a ram_addr_t for the virtual address for execution.
> + *
> + * Return -1 if we can't translate and execute from an entire page
> + * of RAM.  This will force us to execute by loading and translating
> + * one insn at a time, without caching.
> + *
> + * NOTE: This function will trigger an exception if the page is
> + * not executable.
>   */
>  tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>  {
> @@ -1043,19 +1045,20 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>              tlb_fill(env_cpu(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
>              index = tlb_index(env, mmu_idx, addr);
>              entry = tlb_entry(env, mmu_idx, addr);
> +
> +            if (unlikely(entry->addr_code & TLB_INVALID_MASK)) {
> +                /*
> +                 * The MMU protection covers a smaller range than a target
> +                 * page, so we must redo the MMU check for every insn.
> +                 */
> +                return -1;
> +            }
>          }
>          assert(tlb_hit(entry->addr_code, addr));
>      }
>  
> -    if (unlikely(entry->addr_code & (TLB_RECHECK | TLB_MMIO))) {
> -        /*
> -         * Return -1 if we can't translate and execute from an entire
> -         * page of RAM here, which will cause us to execute by loading
> -         * and translating one insn at a time, without caching:
> -         *  - TLB_RECHECK: means the MMU protection covers a smaller range
> -         *    than a target page, so we must redo the MMU check every insn
> -         *  - TLB_MMIO: region is not backed by RAM
> -         */
> +    if (unlikely(entry->addr_code & TLB_MMIO)) {
> +        /* The region is not backed by RAM.  */
>          return -1;
>      }
>  
> @@ -1180,7 +1183,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
>      }
>  
>      /* Notice an IO access or a needs-MMU-lookup access */
> -    if (unlikely(tlb_addr & (TLB_MMIO | TLB_RECHECK))) {
> +    if (unlikely(tlb_addr & TLB_MMIO)) {
>          /* There's really nothing that can be done to
>             support this apart from stop-the-world.  */
>          goto stop_the_world;
> @@ -1258,6 +1261,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>              entry = tlb_entry(env, mmu_idx, addr);
>          }
>          tlb_addr = code_read ? entry->addr_code : entry->addr_read;
> +        tlb_addr &= ~TLB_INVALID_MASK;
>      }
>  
>      /* Handle an IO access.  */
> @@ -1265,27 +1269,6 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>          if ((addr & (size - 1)) != 0) {
>              goto do_unaligned_access;
>          }
> -
> -        if (tlb_addr & TLB_RECHECK) {
> -            /*
> -             * This is a TLB_RECHECK access, where the MMU protection
> -             * covers a smaller range than a target page, and we must
> -             * repeat the MMU check here. This tlb_fill() call might
> -             * longjump out if this access should cause a guest exception.
> -             */
> -            tlb_fill(env_cpu(env), addr, size,
> -                     access_type, mmu_idx, retaddr);
> -            index = tlb_index(env, mmu_idx, addr);
> -            entry = tlb_entry(env, mmu_idx, addr);
> -
> -            tlb_addr = code_read ? entry->addr_code : entry->addr_read;
> -            tlb_addr &= ~TLB_RECHECK;
> -            if (!(tlb_addr & ~TARGET_PAGE_MASK)) {
> -                /* RAM access */
> -                goto do_aligned_access;
> -            }
> -        }
> -
>          return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
>                          mmu_idx, addr, retaddr, access_type, op);
>      }
> @@ -1314,7 +1297,6 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>          return res & MAKE_64BIT_MASK(0, size * 8);
>      }
>  
> - do_aligned_access:
>      haddr = (void *)((uintptr_t)addr + entry->addend);
>      switch (op) {
>      case MO_UB:
> @@ -1509,27 +1491,6 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>          if ((addr & (size - 1)) != 0) {
>              goto do_unaligned_access;
>          }
> -
> -        if (tlb_addr & TLB_RECHECK) {
> -            /*
> -             * This is a TLB_RECHECK access, where the MMU protection
> -             * covers a smaller range than a target page, and we must
> -             * repeat the MMU check here. This tlb_fill() call might
> -             * longjump out if this access should cause a guest exception.
> -             */
> -            tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
> -                     mmu_idx, retaddr);
> -            index = tlb_index(env, mmu_idx, addr);
> -            entry = tlb_entry(env, mmu_idx, addr);
> -
> -            tlb_addr = tlb_addr_write(entry);
> -            tlb_addr &= ~TLB_RECHECK;
> -            if (!(tlb_addr & ~TARGET_PAGE_MASK)) {
> -                /* RAM access */
> -                goto do_aligned_access;
> -            }
> -        }
> -
>          io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
>                    val, addr, retaddr, op);
>          return;
> @@ -1579,7 +1540,6 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>          return;
>      }
>  
> - do_aligned_access:
>      haddr = (void *)((uintptr_t)addr + entry->addend);
>      switch (op) {
>      case MO_UB:
> 

Much better

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

