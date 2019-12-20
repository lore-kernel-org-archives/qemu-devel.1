Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFB0C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CCA206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4Vo/DSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CCA206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLlV-0008U3-JZ
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiLko-0007yK-81
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiLkl-0007Qp-S3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:07:53 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiLkl-0007Pa-Ig
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:07:51 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so10112658wrw.8
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=twiiBpvBOWZBlKH9vLdT8EhzXSGQGHyaONrNgZ4Tiu8=;
 b=a4Vo/DSfs722oAbj95ZmhxSs1p3tCXzjx8xCzhT4VAJFBndoy1WvRDI3r32Ism6I/j
 qofKEL6pbpJJ68HqIFVRCVkSWBmGW4hdqJDfeNPnPoPKaEruMeWPm8jXR6mkSYRyblf0
 tolo+07M/Tfd7f5TD2rQq/jDrN3GV/tGMQE5R+rRqJxxn+dXWj9anJtyugtFwFpY5mpj
 bO/Z8rMhZS8jYt9ePfz9HTB6JVWd0zUQgU/38lqJtSwIIsn0reKPe1r9gYXaR1pcitSe
 ry4ixC9tSe4wScVZap2YVAqvgOwI4y06O4MomYiisX1a7TL6jmPZZG0epgQC3utQxJBV
 ClPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=twiiBpvBOWZBlKH9vLdT8EhzXSGQGHyaONrNgZ4Tiu8=;
 b=FPMg/SzuwTRvH8htm73N0WjnjOpLxeevJYm4H4L2b5dxXFnVCyC4L7nv85NTCF0S/E
 A98FIVC4z2UM2QG33LylUGEwzng4dPaNU7J7AKT4peToeSm6xL6++e10ze/zUcqj8j9T
 RTl4bMerGhM3XLV7wQbmDzXcJrY1Ij2GkHFihYyPNhexEMMfIhZNY3lQEIiQmNPeDAMd
 NcjSXhQgKLoGnKnoyOR8kueBXyDkLOFCh3P7QVujQxToCStickWRut4vyEOzQY4/clUc
 uIo7Ny4GZd6K9QxLORfLVkpv05Enzk/9vLPUInBlJZ52jsxTWHJwpPoktxEcItJeX0sD
 maaQ==
X-Gm-Message-State: APjAAAUnZzdVUSgWxoTFfjksvY+5eR3uvIxX/nnpcHXRAgIkTqg/CvRv
 w2nk295RZvvoO+nqKWg6oWfInxOXzR0=
X-Google-Smtp-Source: APXvYqzhw9B6lUUQUeZ1/iT+RnI+yVWQ7DK535nJHDqtA3JGy4sykQjn0c1EdX3U8wq+qfzueY22CA==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr15787612wrr.252.1576861669482; 
 Fri, 20 Dec 2019 09:07:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n8sm10661883wrx.42.2019.12.20.09.07.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 09:07:47 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0BE8B1FF87
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:07:47 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 04/28] cputlb: Move body of cpu_ldst_template.h out
 of line
In-reply-to: <20191216221158.29572-5-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 17:07:47 +0000
Message-ID: <87zhfnc4d8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> With the tracing hooks, the inline functions are no longer
> so simple.  Once out-of-line, the current tlb_entry lookup
> is redundant with the one in the main load/store_helper.
>
> This also begins the introduction of a new target facing
> interface, with suffix *_mmuidx_ra.  This is not yet
> official because the interface is not done for user-only.
>
> Use abi_ptr instead of target_ulong in preparation for
> user-only; the two types are identical for softmmu.
>
> What remains in cpu_ldst_template.h are the expansions
> for _code, _data, and MMU_MODE<N>_SUFFIX.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/cpu_ldst.h          |  25 ++++++-
>  include/exec/cpu_ldst_template.h | 125 +++++++------------------------
>  accel/tcg/cputlb.c               | 116 ++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+), 100 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index fd499f7e2f..cf8af36dbc 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -152,7 +152,7 @@ static inline void clear_helper_retaddr(void)
>=20=20
>  #else
>=20=20
> -/* The memory helpers for tcg-generated code need tcg_target_long etc.  =
*/
> +/* Needed for TCG_OVERSIZED_GUEST */
>  #include "tcg.h"
>=20=20
>  static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
> @@ -185,6 +185,29 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *e=
nv, uintptr_t mmu_idx,
>      return &env_tlb(env)->f[mmu_idx].table[tlb_index(env, mmu_idx, addr)=
];
>  }
>=20=20
> +uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                            int mmu_idx, uintptr_t ra);
> +uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                            int mmu_idx, uintptr_t ra);
> +uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                           int mmu_idx, uintptr_t ra);
> +uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                           int mmu_idx, uintptr_t ra);
> +
> +int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                       int mmu_idx, uintptr_t ra);
> +int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                       int mmu_idx, uintptr_t ra);
> +
> +void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
> +                       int mmu_idx, uintptr_t retaddr);
> +void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
> +                       int mmu_idx, uintptr_t retaddr);
> +void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
> +                       int mmu_idx, uintptr_t retaddr);
> +void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
> +                       int mmu_idx, uintptr_t retaddr);
> +
>  #ifdef MMU_MODE0_SUFFIX
>  #define CPU_MMU_INDEX 0
>  #define MEMSUFFIX MMU_MODE0_SUFFIX
> diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_tem=
plate.h
> index 0ad5de3ef9..ea39e29c19 100644
> --- a/include/exec/cpu_ldst_template.h
> +++ b/include/exec/cpu_ldst_template.h
> @@ -24,13 +24,6 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
>=20=20
> -#if !defined(SOFTMMU_CODE_ACCESS)
> -#include "trace-root.h"
> -#endif
> -
> -#include "qemu/plugin.h"
> -#include "trace/mem.h"
> -
>  #if DATA_SIZE =3D=3D 8
>  #define SUFFIX q
>  #define USUFFIX q
> @@ -63,56 +56,40 @@
>  #define RES_TYPE uint32_t
>  #endif
>=20=20
> +/* generic load/store macros */
> +
>  #ifdef SOFTMMU_CODE_ACCESS
> -#define ADDR_READ addr_code
> -#define MMUSUFFIX _cmmu
> -#define URETSUFFIX USUFFIX
> -#define SRETSUFFIX glue(s, SUFFIX)
> -#else
> -#define ADDR_READ addr_read
> -#define MMUSUFFIX _mmu
> -#define URETSUFFIX USUFFIX
> -#define SRETSUFFIX glue(s, SUFFIX)
> +
> +static inline RES_TYPE
> +glue(glue(cpu_ld, USUFFIX), _code)(CPUArchState *env, target_ulong ptr)
> +{
> +    TCGMemOpIdx oi =3D make_memop_idx(MO_TE | SHIFT, CPU_MMU_INDEX);
> +    return glue(glue(helper_ret_ld, USUFFIX), _cmmu)(env, ptr, oi, 0);
> +}
> +
> +#if DATA_SIZE <=3D 2
> +static inline int
> +glue(glue(cpu_lds, SUFFIX), _code)(CPUArchState *env, target_ulong ptr)
> +{
> +    return (DATA_STYPE)glue(glue(cpu_ld, USUFFIX), _code)(env, ptr);
> +}
>  #endif
>=20=20
> -/* generic load/store macros */
> +#else
>=20=20
>  static inline RES_TYPE
>  glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
>                                                    target_ulong ptr,
>                                                    uintptr_t retaddr)
>  {
> -    CPUTLBEntry *entry;
> -    RES_TYPE res;
> -    target_ulong addr;
> -    int mmu_idx =3D CPU_MMU_INDEX;
> -    MemOp op =3D MO_TE | SHIFT;
> -#if !defined(SOFTMMU_CODE_ACCESS)
> -    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, false);
> -    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> -#endif
> -
> -    addr =3D ptr;
> -    entry =3D tlb_entry(env, mmu_idx, addr);
> -    if (unlikely(entry->ADDR_READ !=3D
> -                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
> -        TCGMemOpIdx oi =3D make_memop_idx(op, mmu_idx);
> -        res =3D glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, ad=
dr,
> -                                                               oi, retad=
dr);
> -    } else {
> -        uintptr_t hostaddr =3D addr + entry->addend;
> -        res =3D glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
> -    }
> -#ifndef SOFTMMU_CODE_ACCESS
> -    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> -#endif
> -    return res;
> +    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_IND=
EX,
> +                                                   retaddr);
>  }
>=20=20
>  static inline RES_TYPE
>  glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong p=
tr)
>  {
> -    return glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(env, ptr, 0=
);
> +    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_IND=
EX, 0);
>  }
>=20=20
>  #if DATA_SIZE <=3D 2
> @@ -121,42 +98,17 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CP=
UArchState *env,
>                                                    target_ulong ptr,
>                                                    uintptr_t retaddr)
>  {
> -    CPUTLBEntry *entry;
> -    int res;
> -    target_ulong addr;
> -    int mmu_idx =3D CPU_MMU_INDEX;
> -    MemOp op =3D MO_TE | MO_SIGN | SHIFT;
> -#ifndef SOFTMMU_CODE_ACCESS
> -    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, false);
> -    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> -#endif
> -
> -    addr =3D ptr;
> -    entry =3D tlb_entry(env, mmu_idx, addr);
> -    if (unlikely(entry->ADDR_READ !=3D
> -                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
> -        TCGMemOpIdx oi =3D make_memop_idx(op & ~MO_SIGN, mmu_idx);
> -        res =3D (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
> -                               MMUSUFFIX)(env, addr, oi, retaddr);
> -    } else {
> -        uintptr_t hostaddr =3D addr + entry->addend;
> -        res =3D glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
> -    }
> -#ifndef SOFTMMU_CODE_ACCESS
> -    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> -#endif
> -    return res;
> +    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_IND=
EX,
> +                                                   retaddr);
>  }
>=20=20
>  static inline int
>  glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong p=
tr)
>  {
> -    return glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(env, ptr, 0=
);
> +    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_IND=
EX, 0);
>  }
>  #endif
>=20=20
> -#ifndef SOFTMMU_CODE_ACCESS
> -
>  /* generic store macro */
>=20=20
>  static inline void
> @@ -164,36 +116,15 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CP=
UArchState *env,
>                                                   target_ulong ptr,
>                                                   RES_TYPE v, uintptr_t r=
etaddr)
>  {
> -    CPUTLBEntry *entry;
> -    target_ulong addr;
> -    int mmu_idx =3D CPU_MMU_INDEX;
> -    MemOp op =3D MO_TE | SHIFT;
> -#if !defined(SOFTMMU_CODE_ACCESS)
> -    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, true);
> -    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> -#endif
> -
> -    addr =3D ptr;
> -    entry =3D tlb_entry(env, mmu_idx, addr);
> -    if (unlikely(tlb_addr_write(entry) !=3D
> -                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
> -        TCGMemOpIdx oi =3D make_memop_idx(op, mmu_idx);
> -        glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
> -                                                     retaddr);
> -    } else {
> -        uintptr_t hostaddr =3D addr + entry->addend;
> -        glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
> -    }
> -#ifndef SOFTMMU_CODE_ACCESS
> -    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> -#endif
> +    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX,
> +                                           retaddr);
>  }
>=20=20
>  static inline void
>  glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong pt=
r,
>                                        RES_TYPE v)
>  {
> -    glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(env, ptr, v, 0);
> +    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX, 0=
);
>  }
>=20=20
>  #endif /* !SOFTMMU_CODE_ACCESS */
> @@ -204,8 +135,4 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *e=
nv, target_ulong ptr,
>  #undef SUFFIX
>  #undef USUFFIX
>  #undef DATA_SIZE
> -#undef MMUSUFFIX
> -#undef ADDR_READ
> -#undef URETSUFFIX
> -#undef SRETSUFFIX
>  #undef SHIFT
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 98221948d6..ddd19718bf 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -34,6 +34,9 @@
>  #include "qemu/atomic.h"
>  #include "qemu/atomic128.h"
>  #include "translate-all.h"
> +#include "trace-root.h"
> +#include "qemu/plugin.h"
> +#include "trace/mem.h"
>  #ifdef CONFIG_PLUGIN
>  #include "qemu/plugin-memory.h"
>  #endif
> @@ -1625,6 +1628,75 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *=
env, target_ulong addr,
>      return (int32_t)helper_be_ldul_mmu(env, addr, oi, retaddr);
>  }
>=20=20
> +/*
> + * Load helpers for cpu_ldst.h.
> + */
> +
> +static inline uint64_t cpu_load_helper(CPUArchState *env, abi_ptr addr,
> +                                       int mmu_idx, uintptr_t retaddr,
> +                                       MemOp op, FullLoadHelper *full_lo=
ad)
> +{
> +    uint16_t meminfo;
> +    TCGMemOpIdx oi;
> +    uint64_t ret;
> +
> +    meminfo =3D trace_mem_get_info(op, mmu_idx, false);
> +    trace_guest_mem_before_exec(env_cpu(env), addr, meminfo);
> +
> +    op &=3D ~MO_SIGN;
> +    oi =3D make_memop_idx(op, mmu_idx);
> +    ret =3D full_load(env, addr, oi, retaddr);
> +
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, meminfo);
> +
> +    return ret;
> +}
> +
> +uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                            int mmu_idx, uintptr_t ra)
> +{
> +    return cpu_load_helper(env, addr, mmu_idx, ra, MO_UB, full_ldub_mmu);
> +}
> +
> +int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                       int mmu_idx, uintptr_t ra)
> +{
> +    return (int8_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_SB,
> +                                   full_ldub_mmu);
> +}
> +
> +uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                            int mmu_idx, uintptr_t ra)
> +{
> +    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEUW,
> +                           MO_TE =3D=3D MO_LE
> +                           ? full_le_lduw_mmu : full_be_lduw_mmu);
> +}
> +
> +int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                       int mmu_idx, uintptr_t ra)
> +{
> +    return (int16_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_TESW,
> +                                    MO_TE =3D=3D MO_LE
> +                                    ? full_le_lduw_mmu : full_be_lduw_mm=
u);
> +}
> +
> +uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                           int mmu_idx, uintptr_t ra)
> +{
> +    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEUL,
> +                           MO_TE =3D=3D MO_LE
> +                           ? full_le_ldul_mmu : full_be_ldul_mmu);
> +}
> +
> +uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                           int mmu_idx, uintptr_t ra)
> +{
> +    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEQ,
> +                           MO_TE =3D=3D MO_LE
> +                           ? helper_le_ldq_mmu : helper_be_ldq_mmu);
> +}
> +
>  /*
>   * Store Helpers
>   */
> @@ -1854,6 +1926,50 @@ void helper_be_stq_mmu(CPUArchState *env, target_u=
long addr, uint64_t val,
>      store_helper(env, addr, val, oi, retaddr, MO_BEQ);
>  }
>=20=20
> +/*
> + * Store Helpers for cpu_ldst.h
> + */
> +
> +static inline void QEMU_ALWAYS_INLINE
> +cpu_store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
> +                 int mmu_idx, uintptr_t retaddr, MemOp op)
> +{
> +    TCGMemOpIdx oi;
> +    uint16_t meminfo;
> +
> +    meminfo =3D trace_mem_get_info(op, mmu_idx, true);
> +    trace_guest_mem_before_exec(env_cpu(env), addr, meminfo);
> +
> +    oi =3D make_memop_idx(op, mmu_idx);
> +    store_helper(env, addr, val, oi, retaddr, op);
> +
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, meminfo);
> +}
> +
> +void cpu_stb_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t va=
l,
> +                       int mmu_idx, uintptr_t retaddr)
> +{
> +    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_UB);
> +}
> +
> +void cpu_stw_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t va=
l,
> +                       int mmu_idx, uintptr_t retaddr)
> +{
> +    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEUW);
> +}
> +
> +void cpu_stl_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t va=
l,
> +                       int mmu_idx, uintptr_t retaddr)
> +{
> +    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEUL);
> +}
> +
> +void cpu_stq_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t va=
l,
> +                       int mmu_idx, uintptr_t retaddr)
> +{
> +    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEQ);
> +}
> +
>  /* First set of helpers allows passing in of OI and RETADDR.  This makes
>     them callable from other helpers.  */


--=20
Alex Benn=C3=A9e

