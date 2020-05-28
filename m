Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063DEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D281020721
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D281020721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeM6h-00087Z-0n
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeM5f-0007Be-Hu
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:13:11 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeM5e-0002kX-IX
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:13:11 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N2Ujn-1is0WT2jU7-013zP8; Thu, 28 May 2020 19:13:06 +0200
Subject: Re: [PATCH] linux-user/sparc64: Translate flushw opcode
To: LemonBoy <thatlemon@gmail.com>
References: <894ec93e-05dd-2110-a0c2-e0afa2fa6fd5@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <61e6f953-8b6c-a10b-8604-92e300146a93@vivier.eu>
Date: Thu, 28 May 2020 19:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <894ec93e-05dd-2110-a0c2-e0afa2fa6fd5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:B4xSfI1dCuTqroBHIkiRmix8Vp3SrlhM9ZzhVU2gtijBObtk1ef
 t9j6+6T/AwyKfTDGqNT1RMCWtkl6cjXhFIA03iRzZRTA+2eL/ymHloe8EmDYv6ly5DIpCRK
 4wS3lz/cfKUR1YBNcq/FvVnCESgxc4qF2tj7zGyh6G0wbJwEjpzefzjgiLFriOLER3B7Brb
 PK7YIOXb7r62OFML7DQMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Egk2p3E59A=:t96YE1PdauF9uBkMrpU+bo
 K8RonRdDygAFywOFhwlGj3pwWReldDLAIGORA5DlNWQ2V0shreHgv+ul0A0EZe7K/PE/auZip
 n2wn3tklWaRfZ8IjKAlDWNXo8yO8vwzGW1qGecQMyh5b7nuC4K83a6RBCzm0e9NqhEy0/k0is
 vicM6tPbiicwDOvEujy6unDZXBNdNPqnQyE2suZJ84XR1OoTJLLDHeeANN34cMua/DKBvhiSb
 Fhm2A1FU0w36m1yMWRSqJaAY32bvAt+xS4zksLj0s2OEIFmd2rGzwxel7peGPkM0sjmgX8gtM
 yhAgZQ1aQuuMXMC5roXU67KqGDU7NeucPCrkyfUbwqrTUDjPjBHYsTRDO0Vo3VCEn8au3y5MS
 agWyyS+ZtH2Ak+TYeTNlU68xnpZI91NtOqRYnp/1Uh0/8qGkAvOxqdz1pElX4r+saDWHCnaAL
 DZ8NBrigkX+vR2UJxFaKrAJxI7bHtsU4kmwNs4km3Rj97F38AG/br8oIm45vYI89QUifqgi2h
 eAKHTqb/7mxHXkX5mJUkK+3EAksWpMuX6KU+3TNoJRZi1mvqxYs+WQNaeWzTfzTJyU4j47RLi
 FmNPgAvWgSve4JN8tOzU35EIkcVMr6oIwsTl5gSY05Zif4G2/dvAZEUll9UN53VSP1iQeL5fo
 EwSZd5DDMQInOirdgKwvwcG8IPwQdfNleVIAYYwslMduH1kUaz0H/fV4TVBDx82Of4vtaC0k+
 mCCB1hp+g0Xl3Fc08Pkj0ucvz4303dkNy0kyZGnSE0gcJi29REoUTEVbaIeHZj6emhk+WmVO1
 yJR9DDnXQJyKg3JOrTCJmbskNvHD6xtWN4/LM3rQnAWTc2KhwjjU9i6BYG+M/kOrvlCttpX
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 13:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

LemonBoy,

could you resend a series of two patches modified as said by Richard?

Changes should be only cosmetic.

Thanks,
Laurent

Le 10/04/2020 à 23:14, LemonBoy a écrit :
> From 11d0cfe58d12e0f191b435ade88622cfceb2098a Mon Sep 17 00:00:00 2001
> From: LemonBoy <thatlemon@gmail.com>
> Date: Fri, 10 Apr 2020 22:55:26 +0200
> Subject: [PATCH] linux-user/sparc64: Translate flushw opcode
> 
> The ifdef logic should unconditionally compile in the `xop == 0x2b` case
> when targeting sparc64.
> 
> Fix the handling of window spill traps by keeping cansave into account
> when calculating the new CWP.
> 
> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> ---
>  bsd-user/main.c             | 4 +++-
>  linux-user/sparc/cpu_loop.c | 4 +++-
>  target/sparc/translate.c    | 2 ++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 770c2b267a..d6b1c997e3 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -413,7 +413,9 @@ static void save_window(CPUSPARCState *env)
>      save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
>      env->wim = new_wim;
>  #else
> -    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
> +    /* cansave is zero if the spill trap handler is triggered by `save` and */
> +    /* nonzero if triggered by a `flushw` */
> +    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
>      env->cansave++;
>      env->canrestore--;
>  #endif
> diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
> index 7645cc04ca..20a7401126 100644
> --- a/linux-user/sparc/cpu_loop.c
> +++ b/linux-user/sparc/cpu_loop.c
> @@ -69,7 +69,9 @@ static void save_window(CPUSPARCState *env)
>      save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
>      env->wim = new_wim;
>  #else
> -    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
> +    /* cansave is zero if the spill trap handler is triggered by `save` and */
> +    /* nonzero if triggered by a `flushw` */
> +    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
>      env->cansave++;
>      env->canrestore--;
>  #endif
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 9416a551cf..1a4efd4ed6 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -3663,6 +3663,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
>  #endif
>                  gen_store_gpr(dc, rd, cpu_tmp0);
>                  break;
> +#endif
> +#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
>              } else if (xop == 0x2b) { /* rdtbr / V9 flushw */
>  #ifdef TARGET_SPARC64
>                  gen_helper_flushw(cpu_env);
> 


