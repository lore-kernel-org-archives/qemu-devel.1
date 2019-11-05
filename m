Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DC3C49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CE120869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CE120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvaf-0002sx-Ox
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRvVa-0006LU-LL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRvVY-0002Ca-Jm
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:52:18 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:47499)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iRvVY-0002CL-6Q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:52:16 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MI41P-1igXyU04Xf-00FCRZ; Tue, 05 Nov 2019 10:52:13 +0100
Subject: Re: [PATCH v2 09/12] linux-user: Rename cpu_clone_regs to
 cpu_clone_regs_child
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-10-richard.henderson@linaro.org>
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
Message-ID: <dab77b9f-aa74-13a2-baa4-37801ec06503@vivier.eu>
Date: Tue, 5 Nov 2019 10:52:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wDxyxvX5iu5PRqqWHF4M1aa4sjt7+1lVXTAgz1oTeP3YdaAEFfY
 W8RNPX4If2SBCxGFF35d209Qi8318yF2SJISo9rfhWIKcgH1CHEXLySOknSMbyaWxpu4xca
 Sh5mLH3K+RlG+Vp3XhGktciDvBQUx3l/2LNNbh1x5b+pJ48cNopJduRfrhBeTZpJbRakgrr
 EvIQZhsc4tBMNLMgjkFCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YOPKXDkP/dg=:2Si0tL6ia/JR1hHGpv/P/E
 KuKjArfo1gJUwjSAvKIjTMdaRtt2zCJ3DUV37auYZdv3nn0nAUAocbluyG63zcUP6sAPOxB4n
 Ct1tZIV22BOZqGZ2l4fwTZETkXJ01hTtI20sXGQZgvVd42Jbh+5xD1GXolD50Y7mEhgDO6LOl
 BntgsZqp4e64mJi5zTTumvHZWrDKwhGklkoh7uPR8o+iwzUaMHx4bdX8U1PkSuryTdZdlP4S6
 GGXana+u23qfoRTyKpRiM2gP9aDlPHOqOdVr+JPQyqKPwLwH5uDRKAiDHWQwtvDo7WIhckTN6
 QYXGuynCgxoc6GQe+Wm0TmJPhLBwTShNXWPw3jlePxfl61YSjEpjwZEyfk1G6fPeVdYiuWhG8
 lTUS+tLK5TVoekHLHk6Rs0TMkr7MeLAoT9pPg+hUxkToAoISMGOMC6oPkWLGXLT4HDc9r4VDA
 81xWpFbM1t38I25OhIQoXZZhVdBrbheNkc4ewJLqYJv21bxynnkfNFjNgi7j0y5bqZ0PwVxJn
 HEYNIqpsNz6ytWgw21evhX2Evtk4M0QCLUCxEuL6FSuO34aXpA2rwyvUJgA/XTXaD4m/TaDBv
 /4BJws6VLl0lHd6KANj+w1F9Iu43UnYfHGAxBq3se1GlVwGXvmNI1nTArgXj0Z+c2proTZ7yD
 cKcFjQdiWwj0agpwUSlVDdbCW6UAuErKAzBzDZ1axREJk8m1e6tPOKXNf6n9fzKOxpmGBiewg
 cIJKnPkGEtqQTKjQb0G1bt5E53g7LRqXAR9jNgMz7ZrpTZJ1dcnQem6k+nFyIatCLnZsPbNn4
 i4ujeIazflKqqcz1dd6KuPFwuv2c5Bdpd3A5002iaWm71rpTa+VszzFDVQBQ+zU8smbdjZ5zt
 ueKT9F5kF+39wCB6DmAA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
> We will need a target-specific hook for adjusting registers
> in the parent during clone.  To avoid confusion, rename the
> one we have to make it clear it affects the child.
> 
> At the same time, pass in the flags from the clone syscall.
> We will need them for correct behaviour for Sparc.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Add flags parameter.
> ---
>  linux-user/aarch64/target_cpu.h    | 3 ++-
>  linux-user/alpha/target_cpu.h      | 3 ++-
>  linux-user/arm/target_cpu.h        | 3 ++-
>  linux-user/cris/target_cpu.h       | 3 ++-
>  linux-user/hppa/target_cpu.h       | 3 ++-
>  linux-user/i386/target_cpu.h       | 3 ++-
>  linux-user/m68k/target_cpu.h       | 3 ++-
>  linux-user/microblaze/target_cpu.h | 3 ++-
>  linux-user/mips/target_cpu.h       | 3 ++-
>  linux-user/nios2/target_cpu.h      | 3 ++-
>  linux-user/openrisc/target_cpu.h   | 4 +++-
>  linux-user/ppc/target_cpu.h        | 3 ++-
>  linux-user/riscv/target_cpu.h      | 3 ++-
>  linux-user/s390x/target_cpu.h      | 3 ++-
>  linux-user/sh4/target_cpu.h        | 3 ++-
>  linux-user/sparc/target_cpu.h      | 3 ++-
>  linux-user/tilegx/target_cpu.h     | 3 ++-
>  linux-user/xtensa/target_cpu.h     | 4 +++-
>  linux-user/syscall.c               | 4 ++--
>  19 files changed, 40 insertions(+), 20 deletions(-)
> 
> diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
> index a021c95fa4..cd012e0dc1 100644
> --- a/linux-user/aarch64/target_cpu.h
> +++ b/linux-user/aarch64/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef AARCH64_TARGET_CPU_H
>  #define AARCH64_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->xregs[31] = newsp;
> diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
> index ac4d255ae7..37ba00cf41 100644
> --- a/linux-user/alpha/target_cpu.h
> +++ b/linux-user/alpha/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef ALPHA_TARGET_CPU_H
>  #define ALPHA_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUAlphaState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->ir[IR_SP] = newsp;
> diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
> index 3f79356a07..6e2ba8ad4b 100644
> --- a/linux-user/arm/target_cpu.h
> +++ b/linux-user/arm/target_cpu.h
> @@ -41,7 +41,8 @@ static inline unsigned long arm_max_reserved_va(CPUState *cs)
>  }
>  #define MAX_RESERVED_VA  arm_max_reserved_va
>  
> -static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->regs[13] = newsp;
> diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
> index 2309343979..eacc4d8d13 100644
> --- a/linux-user/cris/target_cpu.h
> +++ b/linux-user/cris/target_cpu.h
> @@ -20,7 +20,8 @@
>  #ifndef CRIS_TARGET_CPU_H
>  #define CRIS_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUCRISState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUCRISState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->regs[14] = newsp;
> diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
> index 1c539bdbd6..f250770790 100644
> --- a/linux-user/hppa/target_cpu.h
> +++ b/linux-user/hppa/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef HPPA_TARGET_CPU_H
>  #define HPPA_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUHPPAState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUHPPAState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->gr[30] = newsp;
> diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
> index ece04d0966..1fadbf57c3 100644
> --- a/linux-user/i386/target_cpu.h
> +++ b/linux-user/i386/target_cpu.h
> @@ -20,7 +20,8 @@
>  #ifndef I386_TARGET_CPU_H
>  #define I386_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUX86State *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUX86State *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->regs[R_ESP] = newsp;
> diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
> index bc7446fbaf..57b647bc07 100644
> --- a/linux-user/m68k/target_cpu.h
> +++ b/linux-user/m68k/target_cpu.h
> @@ -21,7 +21,8 @@
>  #ifndef M68K_TARGET_CPU_H
>  #define M68K_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUM68KState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUM68KState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->aregs[7] = newsp;
> diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
> index 73e139938c..e9bc0fce65 100644
> --- a/linux-user/microblaze/target_cpu.h
> +++ b/linux-user/microblaze/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef MICROBLAZE_TARGET_CPU_H
>  #define MICROBLAZE_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUMBState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUMBState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->regs[R_SP] = newsp;
> diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
> index 02cf5eeff7..8601f712e0 100644
> --- a/linux-user/mips/target_cpu.h
> +++ b/linux-user/mips/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef MIPS_TARGET_CPU_H
>  #define MIPS_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUMIPSState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUMIPSState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->active_tc.gpr[29] = newsp;
> diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
> index 5596c05c9c..fe5de7a9e3 100644
> --- a/linux-user/nios2/target_cpu.h
> +++ b/linux-user/nios2/target_cpu.h
> @@ -20,7 +20,8 @@
>  #ifndef NIOS2_TARGET_CPU_H
>  #define NIOS2_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUNios2State *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUNios2State *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->regs[R_SP] = newsp;
> diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
> index 32ff135089..309cf3eeb7 100644
> --- a/linux-user/openrisc/target_cpu.h
> +++ b/linux-user/openrisc/target_cpu.h
> @@ -20,7 +20,9 @@
>  #ifndef OPENRISC_TARGET_CPU_H
>  #define OPENRISC_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUOpenRISCState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUOpenRISCState *env,
> +                                        target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          cpu_set_gpr(env, 1, newsp);
> diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
> index c4641834e7..028b28312c 100644
> --- a/linux-user/ppc/target_cpu.h
> +++ b/linux-user/ppc/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef PPC_TARGET_CPU_H
>  #define PPC_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUPPCState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUPPCState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->gpr[1] = newsp;
> diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
> index 90f9a4171e..26dcafab1c 100644
> --- a/linux-user/riscv/target_cpu.h
> +++ b/linux-user/riscv/target_cpu.h
> @@ -1,7 +1,8 @@
>  #ifndef RISCV_TARGET_CPU_H
>  #define RISCV_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->gpr[xSP] = newsp;
> diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
> index aa181ceaee..0b19e42f75 100644
> --- a/linux-user/s390x/target_cpu.h
> +++ b/linux-user/s390x/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef S390X_TARGET_CPU_H
>  #define S390X_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUS390XState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUS390XState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->regs[15] = newsp;
> diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
> index b0be9a2c1b..857af43ee3 100644
> --- a/linux-user/sh4/target_cpu.h
> +++ b/linux-user/sh4/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef SH4_TARGET_CPU_H
>  #define SH4_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUSH4State *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUSH4State *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->gregs[15] = newsp;
> diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
> index b30fbc72c4..029b0fc547 100644
> --- a/linux-user/sparc/target_cpu.h
> +++ b/linux-user/sparc/target_cpu.h
> @@ -20,7 +20,8 @@
>  #ifndef SPARC_TARGET_CPU_H
>  #define SPARC_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUSPARCState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->regwptr[22] = newsp;
> diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
> index d1aa5824f2..0523dc414c 100644
> --- a/linux-user/tilegx/target_cpu.h
> +++ b/linux-user/tilegx/target_cpu.h
> @@ -19,7 +19,8 @@
>  #ifndef TILEGX_TARGET_CPU_H
>  #define TILEGX_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUTLGState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUTLGState *env, target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->regs[TILEGX_R_SP] = newsp;
> diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
> index e31efe3ea0..84f67d469e 100644
> --- a/linux-user/xtensa/target_cpu.h
> +++ b/linux-user/xtensa/target_cpu.h
> @@ -4,7 +4,9 @@
>  #ifndef XTENSA_TARGET_CPU_H
>  #define XTENSA_TARGET_CPU_H
>  
> -static inline void cpu_clone_regs(CPUXtensaState *env, target_ulong newsp)
> +static inline void cpu_clone_regs_child(CPUXtensaState *env,
> +                                        target_ulong newsp,
> +                                        unsigned flags)
>  {
>      if (newsp) {
>          env->regs[1] = newsp;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f1ab81b917..a07d4b4774 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5718,7 +5718,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>          /* we create a new CPU instance. */
>          new_env = cpu_copy(env);
>          /* Init regs that differ from the parent.  */
> -        cpu_clone_regs(new_env, newsp);
> +        cpu_clone_regs_child(new_env, newsp, flags);
>          new_cpu = env_cpu(new_env);
>          new_cpu->opaque = ts;
>          ts->bprm = parent_ts->bprm;
> @@ -5797,7 +5797,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>          ret = fork();
>          if (ret == 0) {
>              /* Child Process.  */
> -            cpu_clone_regs(env, newsp);
> +            cpu_clone_regs_child(env, newsp, flags);
>              fork_end(1);
>              /* There is a race condition here.  The parent process could
>                 theoretically read the TID in the child process before the child
> 

Applied to my linux-user branch.

Thanks,
Laurent

