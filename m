Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1581EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 09:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B9121655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 09:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYwk8Li+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B9121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifKr0-0001eQ-OX
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 04:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ifKqL-0001AH-K0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ifKqI-0002eD-Uf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:33:09 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ifKqI-0002cU-Ob
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:33:06 -0500
Received: by mail-ot1-x342.google.com with SMTP id p8so1150516oth.10
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 01:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dvL35+kdbwH9Vov4fGIckykUEz1oBeNPDpK9537sA0Y=;
 b=lYwk8Li+haVxVtjRZf+Deo4WleMPG6NtT/suAoABTFC7+2u4enTTxPoA0RcuDnUhjC
 t7HORxrgMANNlqk91TkOBhbB4XNFKhoye5QBylCjtErrl1eP0gpGL+TfAU+7Qn6o/J3q
 sk9A1XUDpzUH/CrZnZ30K+/hE/pXVGhMsVkcL4Dx9/4CCD8x7fzT1zQzIEw0CsHFJAo3
 3pPq3mXr6bkeZmY+oY/M8hpBOf6clxMSXLn2vmUEAT/I65hNPn9nk+iaVZGsQiAQA1w7
 VceM7YmqyUAIeR5N5i9J0QwToOZeqkToJLQLkTOk5fRJzXUoDMPsXiJaWiKBfLy4Rw27
 kk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dvL35+kdbwH9Vov4fGIckykUEz1oBeNPDpK9537sA0Y=;
 b=N3A9yBRcOTsH4/sNqEOmB8JVnvK4DrKRWJNUKJbGGQaM2M44fPF3wGkd7ZILq6eHQU
 +C9D6p5h+aepxYmE1mLDE+x0jkQEtZG62G6fx1zoSnjDKlvgm5LSe/LHNqfLKfsSzwwb
 TvZo1dQIpjfCRanRSwjO9bDIoSQkVmf5t4WsA/Bcbli2+a3KWZuFafeuOpytbAKSAfGS
 zbGjMFym1l/DLnq7bMCSQNIDpZb5u9uOYV91xbYwpSBDmcU7KGtWQLK1omGYSx8uKxdN
 MAI47qdALA8EicRFcpEQeucBlx6JEcvkleGbfS3dMnkNQ2SEasUKbZYzDVAEtAGauwaR
 7QHA==
X-Gm-Message-State: APjAAAUfIW1mmpLaHptjwnUR8JfBXruiMh4sTYrHftV6DtA9avRT3cdA
 Q629JmblceLS6ANPIO0+N/pK3zx4sq6gqcQCMEM=
X-Google-Smtp-Source: APXvYqyMW+wX/IrLfaMsp4efGyw45AW9M5hKgmd14xrzfiQe4sp7IRV7JrlHWx2mgKcZsFioTPlFEssWjk2RyiuJs1I=
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr7420256otn.341.1576143185970; 
 Thu, 12 Dec 2019 01:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20191212040039.26546-1-richard.henderson@linaro.org>
 <20191212040039.26546-25-richard.henderson@linaro.org>
In-Reply-To: <20191212040039.26546-25-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 12 Dec 2019 10:32:55 +0100
Message-ID: <CAL1e-=jDG7ytDfdcu+cgSFyb+E5rJemUvY3zcF6iHNSRD_zVwg@mail.gmail.com>
Subject: Re: [PATCH 24/28] target/mips: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 5:21 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The separate suffixed functions were used to construct
> some do_##insn function switched on mmu_idx.  The interface
> is exactly identical to the *_mmuidx_ra functions.  Replace
> them directly and remove the constructions.
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/mips/cpu.h       |   4 -
>  target/mips/op_helper.c | 182 +++++++++++++---------------------------
>  2 files changed, 60 insertions(+), 126 deletions(-)
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index ca00f41daf..c218ccc4a8 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1147,10 +1147,6 @@ extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
>   * MMU modes definitions. We carefully match the indices with our
>   * hflags layout.
>   */
> -#define MMU_MODE0_SUFFIX _kernel
> -#define MMU_MODE1_SUFFIX _super
> -#define MMU_MODE2_SUFFIX _user
> -#define MMU_MODE3_SUFFIX _error
>  #define MMU_USER_IDX 2
>
>  static inline int hflags_mmu_index(uint32_t hflags)
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 18fcee4a78..79d44da6fa 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -52,69 +52,6 @@ static void raise_exception(CPUMIPSState *env, uint32_t exception)
>      do_raise_exception(env, exception, 0);
>  }
>
> -#if defined(CONFIG_USER_ONLY)
> -#define HELPER_LD(name, insn, type)                                     \
> -static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             int mem_idx, uintptr_t retaddr)            \
> -{                                                                       \
> -    return (type) cpu_##insn##_data_ra(env, addr, retaddr);             \
> -}
> -#else
> -#define HELPER_LD(name, insn, type)                                     \
> -static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             int mem_idx, uintptr_t retaddr)            \
> -{                                                                       \
> -    switch (mem_idx) {                                                  \
> -    case 0: return (type) cpu_##insn##_kernel_ra(env, addr, retaddr);   \
> -    case 1: return (type) cpu_##insn##_super_ra(env, addr, retaddr);    \
> -    default:                                                            \
> -    case 2: return (type) cpu_##insn##_user_ra(env, addr, retaddr);     \
> -    case 3: return (type) cpu_##insn##_error_ra(env, addr, retaddr);    \
> -    }                                                                   \
> -}
> -#endif
> -HELPER_LD(lw, ldl, int32_t)
> -#if defined(TARGET_MIPS64)
> -HELPER_LD(ld, ldq, int64_t)
> -#endif
> -#undef HELPER_LD
> -
> -#if defined(CONFIG_USER_ONLY)
> -#define HELPER_ST(name, insn, type)                                     \
> -static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             type val, int mem_idx, uintptr_t retaddr)  \
> -{                                                                       \
> -    cpu_##insn##_data_ra(env, addr, val, retaddr);                      \
> -}
> -#else
> -#define HELPER_ST(name, insn, type)                                     \
> -static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             type val, int mem_idx, uintptr_t retaddr)  \
> -{                                                                       \
> -    switch (mem_idx) {                                                  \
> -    case 0:                                                             \
> -        cpu_##insn##_kernel_ra(env, addr, val, retaddr);                \
> -        break;                                                          \
> -    case 1:                                                             \
> -        cpu_##insn##_super_ra(env, addr, val, retaddr);                 \
> -        break;                                                          \
> -    default:                                                            \
> -    case 2:                                                             \
> -        cpu_##insn##_user_ra(env, addr, val, retaddr);                  \
> -        break;                                                          \
> -    case 3:                                                             \
> -        cpu_##insn##_error_ra(env, addr, val, retaddr);                 \
> -        break;                                                          \
> -    }                                                                   \
> -}
> -#endif
> -HELPER_ST(sb, stb, uint8_t)
> -HELPER_ST(sw, stl, uint32_t)
> -#if defined(TARGET_MIPS64)
> -HELPER_ST(sd, stq, uint64_t)
> -#endif
> -#undef HELPER_ST
> -
>  /* 64 bits arithmetic for 32 bits hosts */
>  static inline uint64_t get_HILO(CPUMIPSState *env)
>  {
> @@ -379,12 +316,12 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
>      }                                                                         \
>      env->CP0_LLAddr = do_translate_address(env, arg, 0, GETPC());             \
>      env->lladdr = arg;                                                        \
> -    env->llval = do_##insn(env, arg, mem_idx, GETPC());                       \
> +    env->llval = cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GETPC());          \
>      return env->llval;                                                        \
>  }
> -HELPER_LD_ATOMIC(ll, lw, 0x3)
> +HELPER_LD_ATOMIC(ll, ldl, 0x3)
>  #ifdef TARGET_MIPS64
> -HELPER_LD_ATOMIC(lld, ld, 0x7)
> +HELPER_LD_ATOMIC(lld, ldq, 0x7)
>  #endif
>  #undef HELPER_LD_ATOMIC
>  #endif
> @@ -400,42 +337,42 @@ HELPER_LD_ATOMIC(lld, ld, 0x7)
>  void helper_swl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC());
>
>      if (GET_LMASK(arg2) <= 2) {
> -        do_sb(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 16),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK(arg2) <= 1) {
> -        do_sb(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 8),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK(arg2) == 0) {
> -        do_sb(env, GET_OFFSET(arg2, 3), (uint8_t)arg1, mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 3), (uint8_t)arg1,
> +                          mem_idx, GETPC());
>      }
>  }
>
>  void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
>
>      if (GET_LMASK(arg2) >= 1) {
> -        do_sb(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK(arg2) >= 2) {
> -        do_sb(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK(arg2) == 3) {
> -        do_sb(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24),
> +                          mem_idx, GETPC());
>      }
>  }
>
> @@ -453,82 +390,82 @@ void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>  void helper_sdl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC());
>
>      if (GET_LMASK64(arg2) <= 6) {
> -        do_sb(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 48), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 48),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) <= 5) {
> -        do_sb(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 40), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 40),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) <= 4) {
> -        do_sb(env, GET_OFFSET(arg2, 3), (uint8_t)(arg1 >> 32), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 3), (uint8_t)(arg1 >> 32),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) <= 3) {
> -        do_sb(env, GET_OFFSET(arg2, 4), (uint8_t)(arg1 >> 24), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 4), (uint8_t)(arg1 >> 24),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) <= 2) {
> -        do_sb(env, GET_OFFSET(arg2, 5), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 5), (uint8_t)(arg1 >> 16),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) <= 1) {
> -        do_sb(env, GET_OFFSET(arg2, 6), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 6), (uint8_t)(arg1 >> 8),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) <= 0) {
> -        do_sb(env, GET_OFFSET(arg2, 7), (uint8_t)arg1, mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 7), (uint8_t)arg1,
> +                          mem_idx, GETPC());
>      }
>  }
>
>  void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
>
>      if (GET_LMASK64(arg2) >= 1) {
> -        do_sb(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) >= 2) {
> -        do_sb(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) >= 3) {
> -        do_sb(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) >= 4) {
> -        do_sb(env, GET_OFFSET(arg2, -4), (uint8_t)(arg1 >> 32), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -4), (uint8_t)(arg1 >> 32),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) >= 5) {
> -        do_sb(env, GET_OFFSET(arg2, -5), (uint8_t)(arg1 >> 40), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -5), (uint8_t)(arg1 >> 40),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) >= 6) {
> -        do_sb(env, GET_OFFSET(arg2, -6), (uint8_t)(arg1 >> 48), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -6), (uint8_t)(arg1 >> 48),
> +                          mem_idx, GETPC());
>      }
>
>      if (GET_LMASK64(arg2) == 7) {
> -        do_sb(env, GET_OFFSET(arg2, -7), (uint8_t)(arg1 >> 56), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -7), (uint8_t)(arg1 >> 56),
> +                          mem_idx, GETPC());
>      }
>  }
>  #endif /* TARGET_MIPS64 */
> @@ -546,14 +483,14 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>
>          for (i = 0; i < base_reglist; i++) {
>              env->active_tc.gpr[multiple_regs[i]] =
> -                (target_long)do_lw(env, addr, mem_idx, GETPC());
> +                (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
>              addr += 4;
>          }
>      }
>
>      if (do_r31) {
> -        env->active_tc.gpr[31] = (target_long)do_lw(env, addr, mem_idx,
> -                                                    GETPC());
> +        env->active_tc.gpr[31] =
> +            (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
>      }
>  }
>
> @@ -567,14 +504,14 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>          target_ulong i;
>
>          for (i = 0; i < base_reglist; i++) {
> -            do_sw(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_idx,
> -                  GETPC());
> +            cpu_stw_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
> +                              mem_idx, GETPC());
>              addr += 4;
>          }
>      }
>
>      if (do_r31) {
> -        do_sw(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
> +        cpu_stw_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
>      }
>  }
>
> @@ -589,14 +526,15 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>          target_ulong i;
>
>          for (i = 0; i < base_reglist; i++) {
> -            env->active_tc.gpr[multiple_regs[i]] = do_ld(env, addr, mem_idx,
> -                                                         GETPC());
> +            env->active_tc.gpr[multiple_regs[i]] =
> +                cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
>              addr += 8;
>          }
>      }
>
>      if (do_r31) {
> -        env->active_tc.gpr[31] = do_ld(env, addr, mem_idx, GETPC());
> +        env->active_tc.gpr[31] =
> +            cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
>      }
>  }
>
> @@ -610,14 +548,14 @@ void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>          target_ulong i;
>
>          for (i = 0; i < base_reglist; i++) {
> -            do_sd(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_idx,
> -                  GETPC());
> +            cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
> +                              mem_idx, GETPC());
>              addr += 8;
>          }
>      }
>
>      if (do_r31) {
> -        do_sd(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
> +        cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
>      }
>  }
>  #endif
> --
> 2.20.1
>
>

