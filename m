Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD8CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8617420820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8617420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCK6N-000374-6g
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iCJlr-0000Td-KL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iCJlp-0000Rm-Hs
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:32:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iCJlp-0000RK-9L
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:32:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9BC2318C8923;
 Mon, 23 Sep 2019 08:32:32 +0000 (UTC)
Received: from [10.36.116.207] (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48FF9601A3;
 Mon, 23 Sep 2019 08:32:28 +0000 (UTC)
Subject: Re: [PATCH v3 09/20] cputlb: Replace switches in load/store_helper
 with callback
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-10-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <d2784556-7064-04ae-4d43-7a448ec77dba@redhat.com>
Date: Mon, 23 Sep 2019 10:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 23 Sep 2019 08:32:32 +0000 (UTC)
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
> Add a function parameter to perform the actual load/store to ram.
> With optimization, this results in identical code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/cputlb.c | 159 +++++++++++++++++++++++----------------------
>  1 file changed, 83 insertions(+), 76 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 2222b87764..b4a63d3928 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1280,11 +1280,38 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
>  
>  typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
>                                  TCGMemOpIdx oi, uintptr_t retaddr);
> +typedef uint64_t LoadHelper(const void *);
> +
> +/* Wrap the unaligned load helpers to that they have a common signature.  */
> +static inline uint64_t wrap_ldub(const void *haddr)
> +{
> +    return ldub_p(haddr);
> +}
> +
> +static inline uint64_t wrap_lduw_be(const void *haddr)
> +{
> +    return lduw_be_p(haddr);
> +}
> +
> +static inline uint64_t wrap_lduw_le(const void *haddr)
> +{
> +    return lduw_le_p(haddr);
> +}
> +
> +static inline uint64_t wrap_ldul_be(const void *haddr)
> +{
> +    return (uint32_t)ldl_be_p(haddr);
> +}
> +
> +static inline uint64_t wrap_ldul_le(const void *haddr)
> +{
> +    return (uint32_t)ldl_le_p(haddr);
> +}
>  
>  static inline uint64_t QEMU_ALWAYS_INLINE
>  load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>              uintptr_t retaddr, MemOp op, bool code_read,
> -            FullLoadHelper *full_load)
> +            FullLoadHelper *full_load, LoadHelper *direct)
>  {
>      uintptr_t mmu_idx = get_mmuidx(oi);
>      uintptr_t index = tlb_index(env, mmu_idx, addr);
> @@ -1373,33 +1400,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>  
>   do_aligned_access:
>      haddr = (void *)((uintptr_t)addr + entry->addend);
> -    switch (op) {
> -    case MO_UB:
> -        res = ldub_p(haddr);
> -        break;
> -    case MO_BEUW:
> -        res = lduw_be_p(haddr);
> -        break;
> -    case MO_LEUW:
> -        res = lduw_le_p(haddr);
> -        break;
> -    case MO_BEUL:
> -        res = (uint32_t)ldl_be_p(haddr);
> -        break;
> -    case MO_LEUL:
> -        res = (uint32_t)ldl_le_p(haddr);
> -        break;
> -    case MO_BEQ:
> -        res = ldq_be_p(haddr);
> -        break;
> -    case MO_LEQ:
> -        res = ldq_le_p(haddr);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
> -    return res;
> +    return direct(haddr);
>  }
>  
>  /*
> @@ -1415,7 +1416,8 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>  static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
>                                TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    return load_helper(env, addr, oi, retaddr, MO_UB, false, full_ldub_mmu);
> +    return load_helper(env, addr, oi, retaddr, MO_UB, false,
> +                       full_ldub_mmu, wrap_ldub);
>  }
>  
>  tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
> @@ -1428,7 +1430,7 @@ static uint64_t full_le_lduw_mmu(CPUArchState *env, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
> -                       full_le_lduw_mmu);
> +                       full_le_lduw_mmu, wrap_lduw_le);
>  }
>  
>  tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
> @@ -1441,7 +1443,7 @@ static uint64_t full_be_lduw_mmu(CPUArchState *env, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUW, false,
> -                       full_be_lduw_mmu);
> +                       full_be_lduw_mmu, wrap_lduw_be);
>  }
>  
>  tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
> @@ -1454,7 +1456,7 @@ static uint64_t full_le_ldul_mmu(CPUArchState *env, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUL, false,
> -                       full_le_ldul_mmu);
> +                       full_le_ldul_mmu, wrap_ldul_le);
>  }
>  
>  tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
> @@ -1467,7 +1469,7 @@ static uint64_t full_be_ldul_mmu(CPUArchState *env, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUL, false,
> -                       full_be_ldul_mmu);
> +                       full_be_ldul_mmu, wrap_ldul_be);
>  }
>  
>  tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
> @@ -1480,14 +1482,14 @@ uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
>                             TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEQ, false,
> -                       helper_le_ldq_mmu);
> +                       helper_le_ldq_mmu, ldq_le_p);
>  }
>  
>  uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
>                             TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEQ, false,
> -                       helper_be_ldq_mmu);
> +                       helper_be_ldq_mmu, ldq_be_p);
>  }
>  
>  /*
> @@ -1530,9 +1532,38 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
>   * Store Helpers
>   */
>  
> +typedef void StoreHelper(void *, uint64_t);
> +
> +/* Wrap the unaligned store helpers to that they have a common signature.  */
> +static inline void wrap_stb(void *haddr, uint64_t val)
> +{
> +    stb_p(haddr, val);
> +}
> +
> +static inline void wrap_stw_be(void *haddr, uint64_t val)
> +{
> +    stw_be_p(haddr, val);
> +}
> +
> +static inline void wrap_stw_le(void *haddr, uint64_t val)
> +{
> +    stw_le_p(haddr, val);
> +}
> +
> +static inline void wrap_stl_be(void *haddr, uint64_t val)
> +{
> +    stl_be_p(haddr, val);
> +}
> +
> +static inline void wrap_stl_le(void *haddr, uint64_t val)
> +{
> +    stl_le_p(haddr, val);
> +}
> +
>  static inline void QEMU_ALWAYS_INLINE
>  store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
> -             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
> +             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op,
> +             StoreHelper *direct)
>  {
>      uintptr_t mmu_idx = get_mmuidx(oi);
>      uintptr_t index = tlb_index(env, mmu_idx, addr);
> @@ -1657,74 +1688,49 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>  
>   do_aligned_access:
>      haddr = (void *)((uintptr_t)addr + entry->addend);
> -    switch (op) {
> -    case MO_UB:
> -        stb_p(haddr, val);
> -        break;
> -    case MO_BEUW:
> -        stw_be_p(haddr, val);
> -        break;
> -    case MO_LEUW:
> -        stw_le_p(haddr, val);
> -        break;
> -    case MO_BEUL:
> -        stl_be_p(haddr, val);
> -        break;
> -    case MO_LEUL:
> -        stl_le_p(haddr, val);
> -        break;
> -    case MO_BEQ:
> -        stq_be_p(haddr, val);
> -        break;
> -    case MO_LEQ:
> -        stq_le_p(haddr, val);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -        break;
> -    }
> +    direct(haddr, val);
>  }
>  
>  void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
>                          TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_UB);
> +    store_helper(env, addr, val, oi, retaddr, MO_UB, wrap_stb);
>  }
>  
>  void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_LEUW);
> +    store_helper(env, addr, val, oi, retaddr, MO_LEUW, wrap_stw_le);
>  }
>  
>  void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_BEUW);
> +    store_helper(env, addr, val, oi, retaddr, MO_BEUW, wrap_stw_be);
>  }
>  
>  void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_LEUL);
> +    store_helper(env, addr, val, oi, retaddr, MO_LEUL, wrap_stl_le);
>  }
>  
>  void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_BEUL);
> +    store_helper(env, addr, val, oi, retaddr, MO_BEUL, wrap_stl_be);
>  }
>  
>  void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_LEQ);
> +    store_helper(env, addr, val, oi, retaddr, MO_LEQ, stq_le_p);
>  }
>  
>  void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_BEQ);
> +    store_helper(env, addr, val, oi, retaddr, MO_BEQ, stq_be_p);
>  }
>  
>  /* First set of helpers allows passing in of OI and RETADDR.  This makes
> @@ -1789,7 +1795,8 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
>  static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
>                                 TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_cmmu);
> +    return load_helper(env, addr, oi, retaddr, MO_8, true,
> +                       full_ldub_cmmu, wrap_ldub);
>  }
>  
>  uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1802,7 +1809,7 @@ static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
> -                       full_le_lduw_cmmu);
> +                       full_le_lduw_cmmu, wrap_lduw_le);
>  }
>  
>  uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1815,7 +1822,7 @@ static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
> -                       full_be_lduw_cmmu);
> +                       full_be_lduw_cmmu, wrap_lduw_be);
>  }
>  
>  uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1828,7 +1835,7 @@ static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
> -                       full_le_ldul_cmmu);
> +                       full_le_ldul_cmmu, wrap_ldul_le);
>  }
>  
>  uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1841,7 +1848,7 @@ static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
> -                       full_be_ldul_cmmu);
> +                       full_be_ldul_cmmu, wrap_ldul_be);
>  }
>  
>  uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1854,12 +1861,12 @@ uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
>                              TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEQ, true,
> -                       helper_le_ldq_cmmu);
> +                       helper_le_ldq_cmmu, ldq_le_p);
>  }
>  
>  uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
>                              TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEQ, true,
> -                       helper_be_ldq_cmmu);
> +                       helper_be_ldq_cmmu, ldq_be_p);
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

