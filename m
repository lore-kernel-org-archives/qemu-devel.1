Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A171CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2262070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2262070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyXO-0006Kb-Dz
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNyW9-00052V-LR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNyW7-0005pR-Q7
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:16:33 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:39229)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iNyW7-0005nd-Gr
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:16:31 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MKsWr-1ij5Ed2b3F-00LCuf; Fri, 25 Oct 2019 14:16:26 +0200
Subject: Re: [PATCH v2 05/12] linux-user/sparc: Begin using WREG constants in
 sparc/signal.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-6-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <6b50b5f9-d4c3-7ee8-0651-ef4cbae99d64@vivier.eu>
Date: Fri, 25 Oct 2019 14:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pq6gasmxy1J7ofEty4AYvx1/bH91HB8xVKJRzc0Hme0tQB8dp9D
 EJUnbJ/UA2hAmExsipDhPXbX/aH1jtAjXdVAtBzfQv77F3VSs6ZJOPvbuf/TZ5iUEPn7z03
 70FWPM7uMMAsHlDwnIy7oO1uH1rJCfMQwODYoovRp65LBZjGlySEVtDC77/AHBjE6BsCs2k
 fLHJrRDJDRuHkmXEwyH/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RjSRW0OBHsU=:yE7Z5iJKjawKRyM9KbFX0V
 CFd181HvqjWvS8sIbvOfByZbnwunA51jQyoRMUD1QVQ3bhfoVgwqvmOpuAS90PJ3kQohwuOWD
 ZpM/011EjmJNEldhlvcz2C/WEGIYF6uVoN604ubBSFfNeG+9b2/YVp1bfEokGb5xKmKpJSMtc
 1754aNrqkUVxAVRdnEA7B/vDL+deTwJtZ3G4eFsxd0G+35nYwYQF0ssQa3sEziN3zX0V9ir0q
 lpdxT3a6tw90VRiQs9jw90+7EP+DEfrrQhLdqDgdzl8Dk1hNNDptviRdQkX7Tb4/8AoIcoTye
 d7S8aZ27a8CT4u/s80e5D8TuRqO4qea1HdfaOPhJDpeQ/3BMNYi42JJDTXyhdLnm/br+L8o0T
 JJLiXAkPVR63uZkKY0ylFltUgHbj3OvcluPaY6yurDMwfSZJO8wqgcir/vY08s94aDKfIAPAh
 ITwErnxKo22Yi3x9Vul/cC9RWMdWDWx/SWNOp7TmCNp2lCYg3IQlMOrO1s1rDCsAr3K3gj7i6
 jfd6ONqVdTowvnfCQC13OZVzy7xI/x4YLF2mM+8JK4qfZ9YQW19FQWfDxWfQoGELtLsfs2H3G
 aZkF6Udh+7Pfnr0dODWpPq/JHh5x8EvIcuL5faNseXC6GgE1vZytohXROqg9mxdX/X3q8f8wy
 OAo/3pMGrWfCieJcYZg0FHM3ZzKiFoM/I3YEBlJDtKYZKrTF3/Npp/uctHYNNag2gKo0V6FLs
 9XriO3bepztlMS8Saf9mIck3f5JN6dq0O4kjOAOJh9N+LKcmMxUCX8xhlCjFv7bhlA2AHiVzR
 8C5fM0eGAya4ROF6xMLmxA//ohSdRNWABJBrcLmeH9rFXAYeF6YCfWelrysDIeTZcMEHujsBO
 T6xBG67HzBTG4wa7ipuxVzmVk3rWEUrmQYPJrx2pM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/10/2019 à 13:39, Richard Henderson a écrit :
> This is non-obvious because the UREG constants are in fact wrong.
> 
> s/UREG_I/WREG_O/g
> s/UREG_O/WREG_I/g
> s/UREG_L/WREG_L/g
> 
> These substitutions have identical integer values.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/sparc/signal.c | 93 ++++++++++++++-------------------------
>  1 file changed, 32 insertions(+), 61 deletions(-)
> 
> diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
> index ead169fbaa..a967e2db73 100644
> --- a/linux-user/sparc/signal.c
> +++ b/linux-user/sparc/signal.c
> @@ -104,19 +104,8 @@ struct target_rt_signal_frame {
>      qemu_siginfo_fpu_t  fpu_state;
>  };
>  
> -#define UREG_O0        16
> -#define UREG_O6        22
> -#define UREG_I0        0
> -#define UREG_I1        1
> -#define UREG_I2        2
> -#define UREG_I3        3
> -#define UREG_I4        4
> -#define UREG_I5        5
> -#define UREG_I6        6
> -#define UREG_I7        7
> -#define UREG_L0        8
> -#define UREG_FP        UREG_I6
> -#define UREG_SP        UREG_O6
> +#define UREG_FP        WREG_O6
> +#define UREG_SP        WREG_I6
>  
>  static inline abi_ulong get_sigframe(struct target_sigaction *sa, 
>                                       CPUSPARCState *env,
> @@ -159,30 +148,12 @@ setup___siginfo(__siginfo_t *si, CPUSPARCState *env, abi_ulong mask)
>          __put_user(env->gregs[i], &si->si_regs.u_regs[i]);
>      }
>      for (i=0; i < 8; i++) {
> -        __put_user(env->regwptr[UREG_I0 + i], &si->si_regs.u_regs[i+8]);
> +        __put_user(env->regwptr[WREG_O0 + i], &si->si_regs.u_regs[i+8]);
>      }
>      __put_user(mask, &si->si_mask);
>      return err;
>  }
>  
> -#if 0
> -static int
> -setup_sigcontext(struct target_sigcontext *sc, /*struct _fpstate *fpstate,*/
> -                 CPUSPARCState *env, unsigned long mask)
> -{
> -    int err = 0;
> -
> -    __put_user(mask, &sc->sigc_mask);
> -    __put_user(env->regwptr[UREG_SP], &sc->sigc_sp);
> -    __put_user(env->pc, &sc->sigc_pc);
> -    __put_user(env->npc, &sc->sigc_npc);
> -    __put_user(env->psr, &sc->sigc_psr);
> -    __put_user(env->gregs[1], &sc->sigc_g1);
> -    __put_user(env->regwptr[UREG_O0], &sc->sigc_o0);
> -
> -    return err;
> -}
> -#endif
>  #define NF_ALIGNEDSZ  (((sizeof(struct target_signal_frame) + 7) & (~7)))
>  
>  void setup_frame(int sig, struct target_sigaction *ka,
> @@ -221,20 +192,20 @@ void setup_frame(int sig, struct target_sigaction *ka,
>      }
>  
>      for (i = 0; i < 8; i++) {
> -        __put_user(env->regwptr[i + UREG_L0], &sf->ss.locals[i]);
> +        __put_user(env->regwptr[i + WREG_L0], &sf->ss.locals[i]);
>      }
>      for (i = 0; i < 8; i++) {
> -        __put_user(env->regwptr[i + UREG_I0], &sf->ss.ins[i]);
> +        __put_user(env->regwptr[i + WREG_O0], &sf->ss.ins[i]);
>      }
>      if (err)
>          goto sigsegv;
>  
>      /* 3. signal handler back-trampoline and parameters */
>      env->regwptr[UREG_FP] = sf_addr;
> -    env->regwptr[UREG_I0] = sig;
> -    env->regwptr[UREG_I1] = sf_addr +
> +    env->regwptr[WREG_O0] = sig;
> +    env->regwptr[WREG_O1] = sf_addr +
>              offsetof(struct target_signal_frame, info);
> -    env->regwptr[UREG_I2] = sf_addr +
> +    env->regwptr[WREG_O2] = sf_addr +
>              offsetof(struct target_signal_frame, info);
>  
>      /* 4. signal handler */
> @@ -242,11 +213,11 @@ void setup_frame(int sig, struct target_sigaction *ka,
>      env->npc = (env->pc + 4);
>      /* 5. return to kernel instructions */
>      if (ka->ka_restorer) {
> -        env->regwptr[UREG_I7] = ka->ka_restorer;
> +        env->regwptr[WREG_O7] = ka->ka_restorer;
>      } else {
>          uint32_t val32;
>  
> -        env->regwptr[UREG_I7] = sf_addr +
> +        env->regwptr[WREG_O7] = sf_addr +
>                  offsetof(struct target_signal_frame, insns) - 2 * 4;
>  
>          /* mov __NR_sigreturn, %g1 */
> @@ -316,7 +287,7 @@ long do_sigreturn(CPUSPARCState *env)
>          __get_user(env->gregs[i], &sf->info.si_regs.u_regs[i]);
>      }
>      for (i=0; i < 8; i++) {
> -        __get_user(env->regwptr[i + UREG_I0], &sf->info.si_regs.u_regs[i+8]);
> +        __get_user(env->regwptr[i + WREG_O0], &sf->info.si_regs.u_regs[i+8]);
>      }
>  
>      /* FIXME: implement FPU save/restore:
> @@ -433,7 +404,7 @@ void sparc64_set_context(CPUSPARCState *env)
>      abi_ulong fp, i7, w_addr;
>      unsigned int i;
>  
> -    ucp_addr = env->regwptr[UREG_I0];
> +    ucp_addr = env->regwptr[WREG_O0];
>      if (!lock_user_struct(VERIFY_READ, ucp, ucp_addr, 1)) {
>          goto do_sigsegv;
>      }
> @@ -443,7 +414,7 @@ void sparc64_set_context(CPUSPARCState *env)
>      if ((pc | npc) & 3) {
>          goto do_sigsegv;
>      }
> -    if (env->regwptr[UREG_I1]) {
> +    if (env->regwptr[WREG_O1]) {
>          target_sigset_t target_set;
>          sigset_t set;
>  
> @@ -474,19 +445,19 @@ void sparc64_set_context(CPUSPARCState *env)
>      __get_user(env->gregs[5], (&(*grp)[SPARC_MC_G5]));
>      __get_user(env->gregs[6], (&(*grp)[SPARC_MC_G6]));
>      __get_user(env->gregs[7], (&(*grp)[SPARC_MC_G7]));
> -    __get_user(env->regwptr[UREG_I0], (&(*grp)[SPARC_MC_O0]));
> -    __get_user(env->regwptr[UREG_I1], (&(*grp)[SPARC_MC_O1]));
> -    __get_user(env->regwptr[UREG_I2], (&(*grp)[SPARC_MC_O2]));
> -    __get_user(env->regwptr[UREG_I3], (&(*grp)[SPARC_MC_O3]));
> -    __get_user(env->regwptr[UREG_I4], (&(*grp)[SPARC_MC_O4]));
> -    __get_user(env->regwptr[UREG_I5], (&(*grp)[SPARC_MC_O5]));
> -    __get_user(env->regwptr[UREG_I6], (&(*grp)[SPARC_MC_O6]));
> -    __get_user(env->regwptr[UREG_I7], (&(*grp)[SPARC_MC_O7]));
> +    __get_user(env->regwptr[WREG_O0], (&(*grp)[SPARC_MC_O0]));
> +    __get_user(env->regwptr[WREG_O1], (&(*grp)[SPARC_MC_O1]));
> +    __get_user(env->regwptr[WREG_O2], (&(*grp)[SPARC_MC_O2]));
> +    __get_user(env->regwptr[WREG_O3], (&(*grp)[SPARC_MC_O3]));
> +    __get_user(env->regwptr[WREG_O4], (&(*grp)[SPARC_MC_O4]));
> +    __get_user(env->regwptr[WREG_O5], (&(*grp)[SPARC_MC_O5]));
> +    __get_user(env->regwptr[WREG_O6], (&(*grp)[SPARC_MC_O6]));
> +    __get_user(env->regwptr[WREG_O7], (&(*grp)[SPARC_MC_O7]));
>  
>      __get_user(fp, &(ucp->tuc_mcontext.mc_fp));
>      __get_user(i7, &(ucp->tuc_mcontext.mc_i7));
>  
> -    w_addr = TARGET_STACK_BIAS+env->regwptr[UREG_I6];
> +    w_addr = TARGET_STACK_BIAS+env->regwptr[WREG_O6];
>      if (put_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
>                   abi_ulong) != 0) {
>          goto do_sigsegv;
> @@ -534,7 +505,7 @@ void sparc64_get_context(CPUSPARCState *env)
>      target_sigset_t target_set;
>      sigset_t set;
>  
> -    ucp_addr = env->regwptr[UREG_I0];
> +    ucp_addr = env->regwptr[WREG_O0];
>      if (!lock_user_struct(VERIFY_WRITE, ucp, ucp_addr, 0)) {
>          goto do_sigsegv;
>      }
> @@ -580,16 +551,16 @@ void sparc64_get_context(CPUSPARCState *env)
>      __put_user(env->gregs[5], &((*grp)[SPARC_MC_G5]));
>      __put_user(env->gregs[6], &((*grp)[SPARC_MC_G6]));
>      __put_user(env->gregs[7], &((*grp)[SPARC_MC_G7]));
> -    __put_user(env->regwptr[UREG_I0], &((*grp)[SPARC_MC_O0]));
> -    __put_user(env->regwptr[UREG_I1], &((*grp)[SPARC_MC_O1]));
> -    __put_user(env->regwptr[UREG_I2], &((*grp)[SPARC_MC_O2]));
> -    __put_user(env->regwptr[UREG_I3], &((*grp)[SPARC_MC_O3]));
> -    __put_user(env->regwptr[UREG_I4], &((*grp)[SPARC_MC_O4]));
> -    __put_user(env->regwptr[UREG_I5], &((*grp)[SPARC_MC_O5]));
> -    __put_user(env->regwptr[UREG_I6], &((*grp)[SPARC_MC_O6]));
> -    __put_user(env->regwptr[UREG_I7], &((*grp)[SPARC_MC_O7]));
> +    __put_user(env->regwptr[WREG_O0], &((*grp)[SPARC_MC_O0]));
> +    __put_user(env->regwptr[WREG_O1], &((*grp)[SPARC_MC_O1]));
> +    __put_user(env->regwptr[WREG_O2], &((*grp)[SPARC_MC_O2]));
> +    __put_user(env->regwptr[WREG_O3], &((*grp)[SPARC_MC_O3]));
> +    __put_user(env->regwptr[WREG_O4], &((*grp)[SPARC_MC_O4]));
> +    __put_user(env->regwptr[WREG_O5], &((*grp)[SPARC_MC_O5]));
> +    __put_user(env->regwptr[WREG_O6], &((*grp)[SPARC_MC_O6]));
> +    __put_user(env->regwptr[WREG_O7], &((*grp)[SPARC_MC_O7]));
>  
> -    w_addr = TARGET_STACK_BIAS+env->regwptr[UREG_I6];
> +    w_addr = TARGET_STACK_BIAS+env->regwptr[WREG_O6];
>      fp = i7 = 0;
>      if (get_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
>                   abi_ulong) != 0) {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


