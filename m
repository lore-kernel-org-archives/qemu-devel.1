Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDF5C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2912070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iV7Of39N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2912070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0R2Y-0001gW-Lr
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0R1s-000193-DP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:56:32 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0R1q-00057t-9z
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:56:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id f18so18617449wrs.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ADsNwkMwyGYgF8tYpWp43S0PB7ds15u46boJ/Mprkg8=;
 b=iV7Of39NVJ6n5LNfnZhtVB1YhZjhwZoxJpycKuGNZmrX/q9JmI0wXSvh5/ammsxEi8
 iLMwMSSeHkfdpcp4olZpKNm3prkA3zXrBRpUrsYAb/KtWG83QiwnU4ckmOik5kv6TM7u
 +lAdDKL+Y9N17diaoe+JECnVCW9MGZ35AMMUaqcAwBMmCMYJJtJGA6HgxFpVs68ffW8Y
 JdKEevDjeOMgWRRW1dH5igroLvkbROC8RHEqPhjKlz3Uoyd8SfRvE0O/FS3xTDtdWn07
 T9kluPYJ1ICAu32v1UAaQ0PBzlozwvaRbtHhw4omStvjro2buKLo+/ROoNTqBD3CeqQP
 0PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ADsNwkMwyGYgF8tYpWp43S0PB7ds15u46boJ/Mprkg8=;
 b=rllyO7SckUgJeO8IHctGaavybHvfzSdCYEtCOcgUHUcFUyYQfXg09e0aZsyjNAP2t2
 C9vxudj69TfNiAtNLWIKOPmDm/jhB1rZ7k47pXdZ2KhkyYXLeUUUeAPlwwuYdLp5vosq
 wog4kAq/eBB7cVeLK49y6L1CHGkptEjt1TvV/5Jj8jxNdlWO1I9WPA/D334CbvGahr1I
 eBcuhTcFGNB4VSaOaiHNHBV5jv8Aouz8266wxnqbURrCS8MnMdKHzrRRTx2tHtTVkkot
 /dW3otVJPbMFXA3fmJu3LDAMFT5K39WCZIjLHY+V6FrJ01iDROHyvjcuMX0mOC6Ebc4a
 1Z1A==
X-Gm-Message-State: AOAM530kniJjHgJTVJ8CTJoSNQuDntVHKi7mo5e3mid5a+uR6KZVOhRh
 mIpVcIhwISzwceYQdAUDc3vDEQ==
X-Google-Smtp-Source: ABdhPJyR+0VhYIMKW5d6ST95ptYrVWA60f8KkLO0w2aCe9F8ulZ5sk9qbU/H95KMMmPT+yWsK0EX6Q==
X-Received: by 2002:adf:f008:: with SMTP id j8mr24158325wro.385.1595948188313; 
 Tue, 28 Jul 2020 07:56:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j5sm4782712wmb.15.2020.07.28.07.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 07:56:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 41B151FF7E;
 Tue, 28 Jul 2020 15:56:26 +0100 (BST)
References: <20200724195128.2373212-1-scw@google.com>
 <20200727185147.1017900-1-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] cputlb: Make store_helper less fragile to compiler
 optimizations
In-reply-to: <20200727185147.1017900-1-richard.henderson@linaro.org>
Date: Tue, 28 Jul 2020 15:56:26 +0100
Message-ID: <87tuxr3cyt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: scw@google.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/24/20 12:51 PM, Shu-Chun Weng wrote:
>> This change has no functional change.
>>=20
>> There is a potential link error with "undefined symbol:
>> qemu_build_not_reached" due to how `store_helper` is structured.
>> This does not produce at current QEMU head, but was reproducible at
>> v4.2.0 with `clang-10 -O2 -fexperimental-new-pass-manager`.
>
> Thanks for the hint -- so far I had not been able to reproduce the
> problem with any of clang 10, 11, or head (12), with default options.
>
>> The current function structure is:
>>=20
>>     inline QEMU_ALWAYSINLINE
>>     store_memop() {
>>         switch () {
>>             ...
>>         default:
>>             qemu_build_not_reached();
>>         }
>>     }
>>     inline QEMU_ALWAYSINLINE
>>     store_helper() {
>>         ...
>>         if (span_two_pages_or_io) {
>>             ...
>>             helper_rst_stb_mmu();
>>         }
>>         store_memop();
>>     }
>>     helper_rst_stb_mmu() {
>>         store_helper();
>>     }
> ...
>> The new structure is:
>>=20
>>     inline QEMU_ALWAYSINLINE
>>     store_memop() {
>>         switch () {
>>             ...
>>         default:
>>             qemu_build_not_reached();
>>         }
>>     }
>>     inline QEMU_ALWAYSINLINE
>>     store_helper_size_aligned()() {
>>         ...
>>         if (span_two_pages_or_io) {
>>             return false;
>>         }
>>         store_memoop();
>>         return true;
>>     }
>>     inline QEMU_ALWAYSINLINE
>>     store_helper() {
>>         if (store_helper_size_aligned() {
>>             return;
>>         }
>>         helper_rst_stb_mmu();
>>     }
>>     helper_rst_stb_mmu() {
>>         store_helper_size_aligned()();
>>     }
>
> Reasonable, I guess.
>
> I did some experimenting though, and if I pull out the unaligned
> portion into a noinline function, I can save about 6k code size.
>
> Thoughts?

I think on balance I prefers having the unaligned helper out of line.
AFAICT they both perform just as well and it must surely help to have
the uncommon case both out of the hotpath and shared with the other
implementations.

For this version:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>
> r~
>
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 5698292749..7e603d6666 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2009,6 +2009,80 @@ store_memop(void *haddr, uint64_t val, MemOp op)
>      }
>  }
>=20=20
> +static void __attribute__((noinline))
> +store_helper_unaligned(CPUArchState *env, target_ulong addr, uint64_t va=
l,
> +                       uintptr_t retaddr, size_t size, uintptr_t mmu_idx,
> +                       bool big_endian)
> +{
> +    const size_t tlb_off =3D offsetof(CPUTLBEntry, addr_write);
> +    uintptr_t index, index2;
> +    CPUTLBEntry *entry, *entry2;
> +    target_ulong page2, tlb_addr, tlb_addr2;
> +    TCGMemOpIdx oi;
> +    size_t size2;
> +    int i;
> +
> +    /*
> +     * Ensure the second page is in the TLB.  Note that the first page
> +     * is already guaranteed to be filled, and that the second page
> +     * cannot evict the first.
> +     */
> +    page2 =3D (addr + size) & TARGET_PAGE_MASK;
> +    size2 =3D (addr + size) & ~TARGET_PAGE_MASK;
> +    index2 =3D tlb_index(env, mmu_idx, page2);
> +    entry2 =3D tlb_entry(env, mmu_idx, page2);
> +
> +    tlb_addr2 =3D tlb_addr_write(entry2);
> +    if (!tlb_hit_page(tlb_addr2, page2)) {
> +        if (!victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
> +            tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
> +                     mmu_idx, retaddr);
> +            index2 =3D tlb_index(env, mmu_idx, page2);
> +            entry2 =3D tlb_entry(env, mmu_idx, page2);
> +        }
> +        tlb_addr2 =3D tlb_addr_write(entry2);
> +    }
> +
> +    index =3D tlb_index(env, mmu_idx, addr);
> +    entry =3D tlb_entry(env, mmu_idx, addr);
> +    tlb_addr =3D tlb_addr_write(entry);
> +
> +    /*
> +     * Handle watchpoints.  Since this may trap, all checks
> +     * must happen before any store.
> +     */
> +    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> +        cpu_check_watchpoint(env_cpu(env), addr, size - size2,
> +                             env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
> +                             BP_MEM_WRITE, retaddr);
> +    }
> +    if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
> +        cpu_check_watchpoint(env_cpu(env), page2, size2,
> +                             env_tlb(env)->d[mmu_idx].iotlb[index2].attr=
s,
> +                             BP_MEM_WRITE, retaddr);
> +    }
> +
> +    /*
> +     * XXX: not efficient, but simple.
> +     * This loop must go in the forward direction to avoid issues
> +     * with self-modifying code in Windows 64-bit.
> +     */
> +    oi =3D make_memop_idx(MO_UB, mmu_idx);
> +    if (big_endian) {
> +        for (i =3D 0; i < size; ++i) {
> +            /* Big-endian extract.  */
> +            uint8_t val8 =3D val >> (((size - 1) * 8) - (i * 8));
> +            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
> +        }
> +    } else {
> +        for (i =3D 0; i < size; ++i) {
> +            /* Little-endian extract.  */
> +            uint8_t val8 =3D val >> (i * 8);
> +            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
> +        }
> +    }
> +}
> +
>  static inline void QEMU_ALWAYS_INLINE
>  store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>               TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
> @@ -2097,64 +2171,9 @@ store_helper(CPUArchState *env, target_ulong addr,=
 uint64_t val,
>      if (size > 1
>          && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
>                       >=3D TARGET_PAGE_SIZE)) {
> -        int i;
> -        uintptr_t index2;
> -        CPUTLBEntry *entry2;
> -        target_ulong page2, tlb_addr2;
> -        size_t size2;
> -
>      do_unaligned_access:
> -        /*
> -         * Ensure the second page is in the TLB.  Note that the first pa=
ge
> -         * is already guaranteed to be filled, and that the second page
> -         * cannot evict the first.
> -         */
> -        page2 =3D (addr + size) & TARGET_PAGE_MASK;
> -        size2 =3D (addr + size) & ~TARGET_PAGE_MASK;
> -        index2 =3D tlb_index(env, mmu_idx, page2);
> -        entry2 =3D tlb_entry(env, mmu_idx, page2);
> -        tlb_addr2 =3D tlb_addr_write(entry2);
> -        if (!tlb_hit_page(tlb_addr2, page2)) {
> -            if (!victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
> -                tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
> -                         mmu_idx, retaddr);
> -                index2 =3D tlb_index(env, mmu_idx, page2);
> -                entry2 =3D tlb_entry(env, mmu_idx, page2);
> -            }
> -            tlb_addr2 =3D tlb_addr_write(entry2);
> -        }
> -
> -        /*
> -         * Handle watchpoints.  Since this may trap, all checks
> -         * must happen before any store.
> -         */
> -        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> -            cpu_check_watchpoint(env_cpu(env), addr, size - size2,
> -                                 env_tlb(env)->d[mmu_idx].iotlb[index].a=
ttrs,
> -                                 BP_MEM_WRITE, retaddr);
> -        }
> -        if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
> -            cpu_check_watchpoint(env_cpu(env), page2, size2,
> -                                 env_tlb(env)->d[mmu_idx].iotlb[index2].=
attrs,
> -                                 BP_MEM_WRITE, retaddr);
> -        }
> -
> -        /*
> -         * XXX: not efficient, but simple.
> -         * This loop must go in the forward direction to avoid issues
> -         * with self-modifying code in Windows 64-bit.
> -         */
> -        for (i =3D 0; i < size; ++i) {
> -            uint8_t val8;
> -            if (memop_big_endian(op)) {
> -                /* Big-endian extract.  */
> -                val8 =3D val >> (((size - 1) * 8) - (i * 8));
> -            } else {
> -                /* Little-endian extract.  */
> -                val8 =3D val >> (i * 8);
> -            }
> -            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
> -        }
> +        store_helper_unaligned(env, addr, val, retaddr, size,
> +                               mmu_idx, memop_big_endian(op));
>          return;
>      }
>=20=20
> @@ -2162,8 +2181,9 @@ store_helper(CPUArchState *env, target_ulong addr, =
uint64_t val,
>      store_memop(haddr, val, op);
>  }
>=20=20
> -void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t va=
l,
> -                        TCGMemOpIdx oi, uintptr_t retaddr)
> +void __attribute__((noinline))
> +helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
> +                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      store_helper(env, addr, val, oi, retaddr, MO_UB);
>  }


--=20
Alex Benn=C3=A9e

