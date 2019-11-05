Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F35C49EAD
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EF420869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EF420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvVF-0005LE-4x
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRvTe-00047G-LB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRvTd-0007uO-FO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:50:18 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55089)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iRvTd-0007se-6d
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:50:17 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MfbwW-1hzUTe2abY-00g2x3; Tue, 05 Nov 2019 10:50:14 +0100
Subject: Re: [PATCH v2 06/12] linux-user/sparc: Use WREG_SP constant in
 sparc/signal.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-7-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <eb2f67f4-f7eb-d46e-02f1-fd0c424fc0d9@vivier.eu>
Date: Tue, 5 Nov 2019 10:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:z6BiZqjfCxD622/lbd5W2yv/Sm+tEHolzlkYyrq2ziCiP+iOsRr
 PKqpM1Fo+Wswe0PpXvG+Rd7HQu5AL0aqt+N6r2hLHN1udX/dMKjFxG7IFnnnd25YYWn/Yzo
 OXFkEOBJHdt8/5kt/Xm7yZWFsJCcW8lq9OCAFfd8KKHbkXmPogPc2+9X8Mlnb7Xxz4E2zfT
 Dk3GMPWZ1DHdJ8M1p/9gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8M7HQOfCyXE=:7QCcunf8t9uP1WbMsntDEY
 wCotTnzC49pTWY8qtECcJzz9Q+bF+wimutMZTxbwuEnE6i/ytjfyP7hA1Txcl62LWhMUmVWxR
 PL3eUa5ghCelcyF3jh9x+HCyGi6+vu40F+McESWL7Q0ZHq8YHGs6L5z9OpM9O5mt2gD1O8yu/
 fLUyjBPBUfaBgiVknymIvPKumDuEs6FI8G1iQE+u0D+uunPgSRblhjFDN2oKBbYvda/w/Dtou
 Oka8ZhCC143N1xSWcO0rXWOh0t1uhlvrvruHNoSzUKIBKyaMv2hhHw14UcngCFSZiOIS1sNGu
 n39rumqekn57iBIG++vFXbn2Ynq9m/+UQBwLBwajxFL7C5lrbVTq88Xwh6dmSQhuvjeq80652
 DX76J76xz/NViPg5RvWAduQuzHdA2qup/YrzCtivxLhj/KDqm0UYwixkty6qWgtI8Gvms+QOM
 nEbmCQALOE8+DqpxEweOweJIWGMmMDGnnJACkttG2gubJJLts1SlYc65phahN2UjKnLFFfha5
 Hkwm7cSoGV+XIZMbfaMf7qvuEEMhMy3ZD26BLgoS5nRpF05dth9RvRcDmUvRDD24TTUDW3ljc
 AC1KPsMhTpBl/gin1PpqwK5zCTZ4JQ9RISdurKkWpqrZ49ddNhzdLNiqecUPjxzsBJZeCAy8/
 j48Px8mD8rJItP1UTSMvPTVXcW6/UcTlpqljtB74sZQ5caZU8xmWJxt3NJYhHPYBss/nYW4Nl
 IOVXlOa7VGY6bC0oRtA09vmCkkSG9xdSo8pW+mEd0k69gQEBaRff9zL4xlF3wj6heWz2zmP9D
 3wQzB1+UL/OFupJFnE2VFwDaCDrn/KBNMMIgF3kWm62PewKGCiddUFAD3TW7MBbrj37cDWdiY
 bVFaHMgzjSMIoULY0xX5lUIW9YdE+tywBzsuyutRM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
> s/UREG_FP/WREG_SP/g
> 
> This is non-obvious because the UREG_FP constant is fact wrong.
> However, the previous search-and-replace patch made it clear that
> UREG_FP expands to WREG_O6, and we can see from the enumeration in
> target/sparc/cpu.h that WREG_O6 is in fact WREG_SP, the stack pointer.
> 
> The UREG_SP define is unused; remove it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/sparc/signal.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
> index a967e2db73..0db4c5f84f 100644
> --- a/linux-user/sparc/signal.c
> +++ b/linux-user/sparc/signal.c
> @@ -104,9 +104,6 @@ struct target_rt_signal_frame {
>      qemu_siginfo_fpu_t  fpu_state;
>  };
>  
> -#define UREG_FP        WREG_O6
> -#define UREG_SP        WREG_I6
> -
>  static inline abi_ulong get_sigframe(struct target_sigaction *sa, 
>                                       CPUSPARCState *env,
>                                       unsigned long framesize)
> @@ -201,7 +198,7 @@ void setup_frame(int sig, struct target_sigaction *ka,
>          goto sigsegv;
>  
>      /* 3. signal handler back-trampoline and parameters */
> -    env->regwptr[UREG_FP] = sf_addr;
> +    env->regwptr[WREG_SP] = sf_addr;
>      env->regwptr[WREG_O0] = sig;
>      env->regwptr[WREG_O1] = sf_addr +
>              offsetof(struct target_signal_frame, info);
> @@ -255,7 +252,7 @@ long do_sigreturn(CPUSPARCState *env)
>      sigset_t host_set;
>      int i;
>  
> -    sf_addr = env->regwptr[UREG_FP];
> +    sf_addr = env->regwptr[WREG_SP];
>      trace_user_do_sigreturn(env, sf_addr);
>      if (!lock_user_struct(VERIFY_READ, sf, sf_addr, 1)) {
>          goto segv_and_exit;
> 

Applied to my linux-user branch.

Thanks,
Laurent

