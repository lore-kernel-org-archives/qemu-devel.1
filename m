Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBCDC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9A2206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9A2206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLm7j-0006DJ-Bq
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jLm77-0005dI-8Q
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jLm75-0005Ur-Bk
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:09:53 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59919)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jLm75-0005Tv-3D; Tue, 07 Apr 2020 07:09:51 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MVdYY-1jl2Br2HsS-00RcHp; Tue, 07 Apr 2020 13:09:47 +0200
Subject: Re: [PATCH for-5.0?] linux-user/ppc: Fix padding in mcontext_t for
 ppc64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200407032105.26711-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9115bbab-4ce9-dae0-9f93-b1c5eaab20c3@vivier.eu>
Date: Tue, 7 Apr 2020 13:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407032105.26711-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Igae+lQ42nG4nKhIetoWv3264+AzUO0WYQzLLbQ1xqlCBILRUEt
 Bp8Ji7hqLGIwvnGTS92G8TDQVoUoi1nvzqMD1jKQdXXoMXgwiKMq4J33EebSlVt1DQXOrgr
 DGcYS6fwvtRvZB+OJbxFbI4tyCtHyMyWF73RWmPChXj0vaM8AyhHt3ABhU8v+Y8NGA1Hsgc
 VnF5/3kyBOyLNTXWLtuLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pMEdrysY1Tc=:H8IzW7jpeDS8YuIzFoktWz
 f5Ouu9s+lp1y1S1lSOvnJpYMQ/J61cmnxcy5tRKfKj08th4CTfC4jUFAqkCBSCCqE/DXgw7H8
 QIHFsCHiCZPU+FDY/Ta5c1/trntwG1zpsFOu382qVo/BE44oePoGKxlSNJ2l5WyIfSQNR8Wuc
 xtoWl363v3pjAEYCgDlhSvN/wPUi+//fhHS8WpJY/hgqwAnFKyQtGiUf9u0Ptd/faVTO2JPZP
 y85mPrQ2v81Rjwhce33GIG0ZTdoFHXz+z4Fefd2T3//LxLkc83s5RHr+JjxsRZBCZkatvSsQE
 kJLwVwURF6TMuvjyhAFkszu3QvJsS4yfRLSo3oQVVZg+2xdj9WORv6ydCRpf2J3DYMvajsBBF
 Oe+HH8FsQlMHgRS+cMrIxZIzueBsH4om4YjYD8qRdBCkQc+iZ+j/PKU41WsVITfnRJRdfAdgy
 36Go0yr97h2CCzswmh1aM2KOd+gV1YWWrieRfMR6vFn0NQeds95rMFpbtENGsSEy3tXrOGbNa
 XVCJT0UKfy9y+7Ys8P/5h8WDcU2brBmQdd8ZhsvUZPt+GRTJd1w1ycKoeEmnZz4rruvBPlq3j
 ZOIYQbQDlpc9mtY0rJ+zM5mrvuM7E/THT4Sm1d6afGHZixKGAKpQhA44Xs1IGDVIOBXLMQ7UN
 h4f994HDT141EQkZicK3ClzCIopXSk8Yoycer+zZlq0YJY0tGeKzbO74fITU0KHKDl0jQIxFR
 4vPQqr2hnkF7WVPYmIGmNrOFmf1yWfq8zfIpiVJbj5k8EdryYJDZrIXiA9+TDHkgaHpX46XRc
 yJQMMBNTJBS0aifBJT+dsXQLXbxco70fOnQVeXylIuSkjX7KvoNV1y/foc9J3v0QX/RG/s4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: qemu-ppc@nongnu.org, alex.bennee@linaro.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/04/2020 à 05:21, Richard Henderson a écrit :
> The padding that was added in 95cda4c44ee was added to a union,
> and so it had no effect.  This fixes misalignment errors detected
> by clang sanitizers for ppc64 and ppc64le.
> 
> In addition, only ppc64 allocates space for VSX registers, so do
> not save them for ppc32.  The kernel only has references to
> CONFIG_SPE in signal_32.c, so do not attempt to save them for ppc64.
> 
> Fixes: 95cda4c44ee
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Note that ppc64abi32 is *not* fixed by this patch.  It looks to
> me that all of the defined(TARGET_PPC64) tests in this file are
> incorrect, and that we should instead be testing TARGET_ABI_BITS
> vs 32/64.  In addition, virtually all of the target_ulong structure
> members would need to be abi_ulong.
> 
> Should we in fact disable ppc64abi32?
> I can't see how it could work enough to be useful as-is.

Yes, this part needs definitively more cleanup, anyway:

Acked-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent
> 
> r~
> 
> ---
>  linux-user/ppc/signal.c | 69 +++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 40 deletions(-)
> 
> diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> index ecd99736b7..20a02c197c 100644
> --- a/linux-user/ppc/signal.c
> +++ b/linux-user/ppc/signal.c
> @@ -35,12 +35,26 @@ struct target_mcontext {
>      target_ulong mc_gregs[48];
>      /* Includes fpscr.  */
>      uint64_t mc_fregs[33];
> +
>  #if defined(TARGET_PPC64)
>      /* Pointer to the vector regs */
>      target_ulong v_regs;
> +    /*
> +     * On ppc64, this mcontext structure is naturally *unaligned*,
> +     * or rather it is aligned on a 8 bytes boundary but not on
> +     * a 16 byte boundary.  This pad fixes it up.  This is why we
> +     * cannot use ppc_avr_t, which would force alignment.  This is
> +     * also why the vector regs are referenced in the ABI by the
> +     * v_regs pointer above so any amount of padding can be added here.
> +     */
> +    target_ulong pad;
> +    /* VSCR and VRSAVE are saved separately.  Also reserve space for VSX. */
> +    struct {
> +        uint64_t altivec[34 + 16][2];
> +    } mc_vregs;
>  #else
>      target_ulong mc_pad[2];
> -#endif
> +
>      /* We need to handle Altivec and SPE at the same time, which no
>         kernel needs to do.  Fortunately, the kernel defines this bit to
>         be Altivec-register-large all the time, rather than trying to
> @@ -48,32 +62,14 @@ struct target_mcontext {
>      union {
>          /* SPE vector registers.  One extra for SPEFSCR.  */
>          uint32_t spe[33];
> -        /* Altivec vector registers.  The packing of VSCR and VRSAVE
> -           varies depending on whether we're PPC64 or not: PPC64 splits
> -           them apart; PPC32 stuffs them together.
> -           We also need to account for the VSX registers on PPC64
> -        */
> -#if defined(TARGET_PPC64)
> -#define QEMU_NVRREG (34 + 16)
> -        /* On ppc64, this mcontext structure is naturally *unaligned*,
> -         * or rather it is aligned on a 8 bytes boundary but not on
> -         * a 16 bytes one. This pad fixes it up. This is also why the
> -         * vector regs are referenced by the v_regs pointer above so
> -         * any amount of padding can be added here
> +        /*
> +         * Altivec vector registers.  One extra for VRSAVE.
> +         * On ppc32, we are already aligned to 16 bytes.  We could
> +         * use ppc_avr_t, but choose to share the same type as ppc64.
>           */
> -        target_ulong pad;
> -#else
> -        /* On ppc32, we are already aligned to 16 bytes */
> -#define QEMU_NVRREG 33
> -#endif
> -        /* We cannot use ppc_avr_t here as we do *not* want the implied
> -         * 16-bytes alignment that would result from it. This would have
> -         * the effect of making the whole struct target_mcontext aligned
> -         * which breaks the layout of struct target_ucontext on ppc64.
> -         */
> -        uint64_t altivec[QEMU_NVRREG][2];
> -#undef QEMU_NVRREG
> +        uint64_t altivec[33][2];
>      } mc_vregs;
> +#endif
>  };
>  
>  /* See arch/powerpc/include/asm/sigcontext.h.  */
> @@ -278,6 +274,7 @@ static void save_user_regs(CPUPPCState *env, struct target_mcontext *frame)
>          __put_user((uint32_t)env->spr[SPR_VRSAVE], vrsave);
>      }
>  
> +#if defined(TARGET_PPC64)
>      /* Save VSX second halves */
>      if (env->insns_flags2 & PPC2_VSX) {
>          uint64_t *vsregs = (uint64_t *)&frame->mc_vregs.altivec[34];
> @@ -286,6 +283,7 @@ static void save_user_regs(CPUPPCState *env, struct target_mcontext *frame)
>              __put_user(*vsrl, &vsregs[i]);
>          }
>      }
> +#endif
>  
>      /* Save floating point registers.  */
>      if (env->insns_flags & PPC_FLOAT) {
> @@ -296,22 +294,18 @@ static void save_user_regs(CPUPPCState *env, struct target_mcontext *frame)
>          __put_user((uint64_t) env->fpscr, &frame->mc_fregs[32]);
>      }
>  
> +#if !defined(TARGET_PPC64)
>      /* Save SPE registers.  The kernel only saves the high half.  */
>      if (env->insns_flags & PPC_SPE) {
> -#if defined(TARGET_PPC64)
> -        for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
> -            __put_user(env->gpr[i] >> 32, &frame->mc_vregs.spe[i]);
> -        }
> -#else
>          for (i = 0; i < ARRAY_SIZE(env->gprh); i++) {
>              __put_user(env->gprh[i], &frame->mc_vregs.spe[i]);
>          }
> -#endif
>          /* Set MSR_SPE in the saved MSR value to indicate that
>             frame->mc_vregs contains valid data.  */
>          msr |= MSR_SPE;
>          __put_user(env->spe_fscr, &frame->mc_vregs.spe[32]);
>      }
> +#endif
>  
>      /* Store MSR.  */
>      __put_user(msr, &frame->mc_gregs[TARGET_PT_MSR]);
> @@ -392,6 +386,7 @@ static void restore_user_regs(CPUPPCState *env,
>          __get_user(env->spr[SPR_VRSAVE], vrsave);
>      }
>  
> +#if defined(TARGET_PPC64)
>      /* Restore VSX second halves */
>      if (env->insns_flags2 & PPC2_VSX) {
>          uint64_t *vsregs = (uint64_t *)&frame->mc_vregs.altivec[34];
> @@ -400,6 +395,7 @@ static void restore_user_regs(CPUPPCState *env,
>              __get_user(*vsrl, &vsregs[i]);
>          }
>      }
> +#endif
>  
>      /* Restore floating point registers.  */
>      if (env->insns_flags & PPC_FLOAT) {
> @@ -412,22 +408,15 @@ static void restore_user_regs(CPUPPCState *env,
>          env->fpscr = (uint32_t) fpscr;
>      }
>  
> +#if !defined(TARGET_PPC64)
>      /* Save SPE registers.  The kernel only saves the high half.  */
>      if (env->insns_flags & PPC_SPE) {
> -#if defined(TARGET_PPC64)
> -        for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
> -            uint32_t hi;
> -
> -            __get_user(hi, &frame->mc_vregs.spe[i]);
> -            env->gpr[i] = ((uint64_t)hi << 32) | ((uint32_t) env->gpr[i]);
> -        }
> -#else
>          for (i = 0; i < ARRAY_SIZE(env->gprh); i++) {
>              __get_user(env->gprh[i], &frame->mc_vregs.spe[i]);
>          }
> -#endif
>          __get_user(env->spe_fscr, &frame->mc_vregs.spe[32]);
>      }
> +#endif
>  }
>  
>  #if !defined(TARGET_PPC64)
> 


