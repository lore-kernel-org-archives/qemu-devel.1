Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D35C4740C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CEA20882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CEA20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKQL-0003Vy-LW
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iCK6j-0003a0-JS
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iCK6e-0001bC-PK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:54:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iCK67-0001Vd-8s
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:54:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90BA4309BF09;
 Mon, 23 Sep 2019 08:53:30 +0000 (UTC)
Received: from [10.36.116.207] (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FA8860C80;
 Mon, 23 Sep 2019 08:53:26 +0000 (UTC)
Subject: Re: [PATCH v3 19/20] cputlb: Pass retaddr to
 tb_invalidate_phys_page_fast
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-20-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <aa6c5172-5d60-bb1f-ae14-38acd1e79f9b@redhat.com>
Date: Mon, 23 Sep 2019 10:53:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 23 Sep 2019 08:53:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.09.19 05:54, Richard Henderson wrote:
> Rather than rely on cpu->mem_io_pc, pass retaddr down directly.
> 
> Within tb_invalidate_phys_page_range__locked, the is_cpu_write_access
> parameter is non-zero exactly when retaddr would be non-zero, so that
> is a simple replacement.
> 
> Recognize that current_tb_not_found is true only when mem_io_pc
> (and now retaddr) are also non-zero, so remove a redundant test.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/translate-all.h |  3 ++-
>  accel/tcg/cputlb.c        |  6 +-----
>  accel/tcg/translate-all.c | 39 +++++++++++++++++++--------------------
>  3 files changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
> index 31f2117188..135c1ea96a 100644
> --- a/accel/tcg/translate-all.h
> +++ b/accel/tcg/translate-all.h
> @@ -27,7 +27,8 @@ struct page_collection *page_collection_lock(tb_page_addr_t start,
>                                               tb_page_addr_t end);
>  void page_collection_unlock(struct page_collection *set);
>  void tb_invalidate_phys_page_fast(struct page_collection *pages,
> -                                  tb_page_addr_t start, int len);
> +                                  tb_page_addr_t start, int len,
> +                                  uintptr_t retaddr);
>  void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end);
>  void tb_check_watchpoint(CPUState *cpu);
>  
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 257c59c08c..eff129447d 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1093,11 +1093,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
>      if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
>          struct page_collection *pages
>              = page_collection_lock(ram_addr, ram_addr + size);
> -
> -        /* We require mem_io_pc in tb_invalidate_phys_page_range.  */
> -        cpu->mem_io_pc = retaddr;
> -
> -        tb_invalidate_phys_page_fast(pages, ram_addr, size);
> +        tb_invalidate_phys_page_fast(pages, ram_addr, size, retaddr);
>          page_collection_unlock(pages);
>      }
>  
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index de4b697163..db77fb221b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1889,7 +1889,7 @@ static void
>  tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>                                        PageDesc *p, tb_page_addr_t start,
>                                        tb_page_addr_t end,
> -                                      int is_cpu_write_access)
> +                                      uintptr_t retaddr)
>  {
>      TranslationBlock *tb;
>      tb_page_addr_t tb_start, tb_end;
> @@ -1897,9 +1897,9 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>  #ifdef TARGET_HAS_PRECISE_SMC
>      CPUState *cpu = current_cpu;
>      CPUArchState *env = NULL;
> -    int current_tb_not_found = is_cpu_write_access;
> +    bool current_tb_not_found = retaddr != 0;
> +    bool current_tb_modified = false;
>      TranslationBlock *current_tb = NULL;
> -    int current_tb_modified = 0;
>      target_ulong current_pc = 0;
>      target_ulong current_cs_base = 0;
>      uint32_t current_flags = 0;
> @@ -1931,24 +1931,21 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>          if (!(tb_end <= start || tb_start >= end)) {
>  #ifdef TARGET_HAS_PRECISE_SMC
>              if (current_tb_not_found) {
> -                current_tb_not_found = 0;
> -                current_tb = NULL;
> -                if (cpu->mem_io_pc) {
> -                    /* now we have a real cpu fault */
> -                    current_tb = tcg_tb_lookup(cpu->mem_io_pc);
> -                }
> +                current_tb_not_found = false;
> +                /* now we have a real cpu fault */
> +                current_tb = tcg_tb_lookup(retaddr);
>              }
>              if (current_tb == tb &&
>                  (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {
> -                /* If we are modifying the current TB, we must stop
> -                its execution. We could be more precise by checking
> -                that the modification is after the current PC, but it
> -                would require a specialized function to partially
> -                restore the CPU state */
> -
> -                current_tb_modified = 1;
> -                cpu_restore_state_from_tb(cpu, current_tb,
> -                                          cpu->mem_io_pc, true);
> +                /*
> +                 * If we are modifying the current TB, we must stop
> +                 * its execution. We could be more precise by checking
> +                 * that the modification is after the current PC, but it
> +                 * would require a specialized function to partially
> +                 * restore the CPU state.
> +                 */
> +                current_tb_modified = true;
> +                cpu_restore_state_from_tb(cpu, current_tb, retaddr, true);
>                  cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
>                                       &current_flags);
>              }
> @@ -2042,7 +2039,8 @@ void tb_invalidate_phys_range(target_ulong start, target_ulong end)
>   * Call with all @pages in the range [@start, @start + len[ locked.
>   */
>  void tb_invalidate_phys_page_fast(struct page_collection *pages,
> -                                  tb_page_addr_t start, int len)
> +                                  tb_page_addr_t start, int len,
> +                                  uintptr_t retaddr)
>  {
>      PageDesc *p;
>  
> @@ -2069,7 +2067,8 @@ void tb_invalidate_phys_page_fast(struct page_collection *pages,
>          }
>      } else {
>      do_invalidate:
> -        tb_invalidate_phys_page_range__locked(pages, p, start, start + len, 1);
> +        tb_invalidate_phys_page_range__locked(pages, p, start, start + len,
> +                                              retaddr);
>      }
>  }
>  #else
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

