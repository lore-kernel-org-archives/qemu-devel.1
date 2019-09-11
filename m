Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFB8C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B55206CD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B55206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i80IO-0006YE-Mo
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 06:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i80HV-000622-IA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i80HT-0001mx-LX
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:55:25 -0400
Received: from nsstlmta03p.bpe.bigpond.com ([203.38.21.3]:33388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i80HS-0001lS-O5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:55:23 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep03p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190911105513.LENY11604.nsstlfep03p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Wed, 11 Sep 2019 20:55:13 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepihhmrggtrdhlohgtrghlpdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoehmrghrkhdrtggrvhgvqdgrhihlrghnugesihhlrghnuggvrdgtohdruhhkqedprhgtphhtthhopeeophgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from imac.local (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D2D1175169589C4; Wed, 11 Sep 2019 20:55:13 +1000
Date: Wed, 11 Sep 2019 20:55:09 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190911105509.GA42643@imac.local>
References: <20190911014353.5926-1-richard.henderson@linaro.org>
 <20190911014353.5926-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911014353.5926-3-richard.henderson@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.3
Subject: Re: [Qemu-devel] [PATCH 2/3] cputlb: Replace switches in
 load/store_helper with callback
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 09:43:52PM -0400, Richard Henderson wrote:
> Add a function parameter to perform the actual load/store to ram.
> With optimization, this results in identical code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/cputlb.c | 157 +++++++++++++++++++++++----------------------
>  1 file changed, 81 insertions(+), 76 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 909f01ebcc..e6229d100a 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1292,11 +1292,37 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
>  
>  typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
>                                  TCGMemOpIdx oi, uintptr_t retaddr);
> +typedef uint64_t DirectLoadHelper(const void *);

Would 'Load' instead of 'DirectLoadHelper' have enough clarity?

If so, consider also dropping the 'direct_' prefix in the functions below.

> +
> +static inline uint64_t direct_ldub(const void *haddr)
> +{
> +    return *(uint8_t *)haddr;
> +}
> +
> +static inline uint64_t direct_lduw_be(const void *haddr)
> +{
> +    return lduw_be_p(haddr);
> +}
> +
> +static inline uint64_t direct_lduw_le(const void *haddr)
> +{
> +    return lduw_le_p(haddr);
> +}
> +
> +static inline uint64_t direct_ldul_be(const void *haddr)
> +{
> +    return (uint32_t)ldl_be_p(haddr);
> +}
> +
> +static inline uint64_t direct_ldul_le(const void *haddr)
> +{
> +    return (uint32_t)ldl_le_p(haddr);
> +}
>  
>  static inline uint64_t ALWAYS_INLINE
>  load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>              uintptr_t retaddr, MemOp op, bool code_read,
> -            FullLoadHelper *full_load)
> +            FullLoadHelper *full_load, DirectLoadHelper *direct)
>  {
>      uintptr_t mmu_idx = get_mmuidx(oi);
>      uintptr_t index = tlb_index(env, mmu_idx, addr);
> @@ -1385,33 +1411,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
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
> @@ -1427,7 +1427,8 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>  static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
>                                TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    return load_helper(env, addr, oi, retaddr, MO_UB, false, full_ldub_mmu);
> +    return load_helper(env, addr, oi, retaddr, MO_UB, false,
> +                       full_ldub_mmu, direct_ldub);
>  }
>  
>  tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
> @@ -1440,7 +1441,7 @@ static uint64_t full_le_lduw_mmu(CPUArchState *env, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
> -                       full_le_lduw_mmu);
> +                       full_le_lduw_mmu, direct_lduw_le);
>  }
>  
>  tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
> @@ -1453,7 +1454,7 @@ static uint64_t full_be_lduw_mmu(CPUArchState *env, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUW, false,
> -                       full_be_lduw_mmu);
> +                       full_be_lduw_mmu, direct_lduw_be);
>  }
>  
>  tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
> @@ -1466,7 +1467,7 @@ static uint64_t full_le_ldul_mmu(CPUArchState *env, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUL, false,
> -                       full_le_ldul_mmu);
> +                       full_le_ldul_mmu, direct_ldul_le);
>  }
>  
>  tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
> @@ -1479,7 +1480,7 @@ static uint64_t full_be_ldul_mmu(CPUArchState *env, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUL, false,
> -                       full_be_ldul_mmu);
> +                       full_be_ldul_mmu, direct_ldul_be);
>  }
>  
>  tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
> @@ -1492,14 +1493,14 @@ uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
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
> @@ -1542,9 +1543,37 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
>   * Store Helpers
>   */
>  
> +typedef void DirectStoreHelper(void *, uint64_t);

Like 'Load', would 'Store' instead of 'DirectStoreHelper' have enough clarity?

> +
> +static inline void direct_stb(void *haddr, uint64_t val)
> +{
> +    *(uint8_t *)haddr = val;
> +}
> +
> +static inline void direct_stw_be(void *haddr, uint64_t val)
> +{
> +    stw_be_p(haddr, val);
> +}
> +
> +static inline void direct_stw_le(void *haddr, uint64_t val)
> +{
> +    stw_le_p(haddr, val);
> +}
> +
> +static inline void direct_stl_be(void *haddr, uint64_t val)
> +{
> +    stl_be_p(haddr, val);
> +}
> +
> +static inline void direct_stl_le(void *haddr, uint64_t val)
> +{
> +    stl_le_p(haddr, val);
> +}
> +
>  static inline void ALWAYS_INLINE
>  store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
> -             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
> +             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op,
> +             DirectStoreHelper *direct)
>  {
>      uintptr_t mmu_idx = get_mmuidx(oi);
>      uintptr_t index = tlb_index(env, mmu_idx, addr);
> @@ -1669,74 +1698,49 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
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
> +    store_helper(env, addr, val, oi, retaddr, MO_UB, direct_stb);
>  }
>  
>  void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_LEUW);
> +    store_helper(env, addr, val, oi, retaddr, MO_LEUW, direct_stw_le);
>  }
>  
>  void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_BEUW);
> +    store_helper(env, addr, val, oi, retaddr, MO_BEUW, direct_stw_be);
>  }
>  
>  void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_LEUL);
> +    store_helper(env, addr, val, oi, retaddr, MO_LEUL, direct_stl_le);
>  }
>  
>  void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_BEUL);
> +    store_helper(env, addr, val, oi, retaddr, MO_BEUL, direct_stl_be);
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
> @@ -1801,7 +1805,8 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
>  static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
>                                 TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_cmmu);
> +    return load_helper(env, addr, oi, retaddr, MO_8, true,
> +                       full_ldub_cmmu, direct_ldub);
>  }
>  
>  uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1814,7 +1819,7 @@ static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
> -                       full_le_lduw_cmmu);
> +                       full_le_lduw_cmmu, direct_lduw_le);
>  }
>  
>  uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1827,7 +1832,7 @@ static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
> -                       full_be_lduw_cmmu);
> +                       full_be_lduw_cmmu, direct_lduw_be);
>  }
>  
>  uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1840,7 +1845,7 @@ static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
> -                       full_le_ldul_cmmu);
> +                       full_le_ldul_cmmu, direct_ldul_le);
>  }
>  
>  uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1853,7 +1858,7 @@ static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
> -                       full_be_ldul_cmmu);
> +                       full_be_ldul_cmmu, direct_ldul_be);
>  }
>  
>  uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1866,12 +1871,12 @@ uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
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
> -- 
> 2.17.1
> 
> 

Reviewed-by: Tony Nguyen <tony.nguyen@bt.com>

