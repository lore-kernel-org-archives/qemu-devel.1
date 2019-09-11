Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807EBC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B36206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B36206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82N2-000472-7v
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i82LH-0002mI-9u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i82LF-0008Uz-Dn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:07:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i82LF-0008UG-4r
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:07:25 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59EE4C05168C
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 13:07:23 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id e7so684200wme.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 06:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FhhR4TpTv1V7iDu4VLPssZo9rykysISWpacyf3FypLI=;
 b=f4XGdj1HyM4/OK1hIHj2LeWD5p0uMPT9kmoHJvxn2JarowSLLUwwU0AZINWiiP68NW
 x09MYClxiNphjKV1n8fx02xjTOikHmG6CrZeEkmFJfEPubrv6oAZjd41DJTDDIEevHHz
 aJUdFisqJszKDUrH+czYhWB+EoGQSsXMmjaFPHK5r21CaZOzHEmVN1x96AlTun04N2X1
 66sOg3DnhZYqE3NNIoJrfo+RXXhPB+NZTr/hrhrV/SH3GL98/TjmI1rI/7vGUkSJeQZv
 +inw/KQNbejz3ANwMMzH2OacWK8K2TB3qvovPxkLqo8uY6sZeZKHDvMCaHesceyT/PwR
 eJpQ==
X-Gm-Message-State: APjAAAVQHQLtsui4/WOdkfDN8sr0kY0SrWI4atJ8OR0sctKlEl0yeaHw
 POpuN1ReADi607uJiq/hUzfl3uLpSdhP0MA35cR4jNXx/eEE1PL41bKXyiVSXsOcySGHTlpldYd
 mZRl4mU12b+2GzbE=
X-Received: by 2002:adf:f085:: with SMTP id n5mr4058101wro.88.1568207242092;
 Wed, 11 Sep 2019 06:07:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqztxGymaJ1bZ5bvI5e0nDvKLY3Ku4FdOV6ebTD7DOTjh0BgxRN/CcLppz3k7ixeZQrX2aP0zA==
X-Received: by 2002:adf:f085:: with SMTP id n5mr4058068wro.88.1568207241801;
 Wed, 11 Sep 2019 06:07:21 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id i73sm3085338wmg.33.2019.09.11.06.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2019 06:07:21 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190911014353.5926-1-richard.henderson@linaro.org>
 <20190911014353.5926-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <500ed763-5c50-0be5-993d-9b8b1b68b932@redhat.com>
Date: Wed, 11 Sep 2019 15:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190911014353.5926-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, tony.nguyen@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 3:43 AM, Richard Henderson wrote:
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

Why not cast lduw_be_p? (except for direct_ldub).

      return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
                       full_le_lduw_mmu, (DirectLoadHelper)lduw_be_p);

Useful to set breakpoint while debugging?

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

Ditto, why not cast with DirectStoreHelper? (except for direct_stb).

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
> 

