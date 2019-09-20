Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F07FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA075208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA075208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBOab-0007PP-6j
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 15:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iBOZH-0006ib-O0
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iBOZG-0008P3-Kl
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:27:47 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44787)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iBOZG-0008OH-C3; Fri, 20 Sep 2019 15:27:46 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M1JJC-1iE8eh0JBK-002oJ8; Fri, 20 Sep 2019 21:27:29 +0200
Subject: Re: [PATCH v2 06/16] target/ppc: fix signal delivery for ppc64abi32
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190919171015.12681-1-alex.bennee@linaro.org>
 <20190919171015.12681-7-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3a341d3e-ff80-2af5-8163-da6469d89d6e@vivier.eu>
Date: Fri, 20 Sep 2019 21:27:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919171015.12681-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nxZl/62RJ0y43RIGrlYlNwhTB6TEv6JQ/X7nkTGgsXplZWufv49
 YRZZi2IjYtrc8d1isdlcDG8XQajcO6bpMizb1CWYuflVngJerLFYiO6NA9P6tSiE8xhonng
 MYCN2UB00J3dqnRHOax2XkkeOmS+LGBB2zMjY/J55TZtQimXjCO19a1kaLjKd9FSBRl/jGh
 vorgUKwpHIhfKVqWpIRqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1aVzMhnyIRY=:ntk5TOdy9Dk+KiqR8hBP4/
 ZEX5CO/573aED8IvjDXO+r3qJW7HriEeV7T6eKdFKPmqLEQlU//HITUZZHkDb4rZdJO2et2JJ
 /6gyXD1S0bO47oKsPEgyTuAHKXpDDca6SsI2SGiUGdlb/x8mmvrfwsFohHu8iH87PQRkenWbu
 Q0s6+WWPssKFwCeOVnA1j3CSrcmIqu5a4KKvJHh11WPMqNAWsGbmlAvBaWX+ET2Gwm8KrulbT
 TIx0q987vgVFlEhSOEI36sGiBDPVfXYNQYPq8rxgz+epspXN6g9PNnMysmEFy76HczYiMT9oE
 /FALlJUkvAoSvlrxek34srQXLQpMCowvwkrvbAaJ3BdzNcZ8QT+7GqnN/6V9xLAv6EzjUrgHk
 6/b2b1j8Loz8Es5pX9Gzkq3F2bsYokHDm+mN3JkTKhyZq9uFZOEjQAEprr2IiyZ34hyO0Jgqw
 /hSJeuGN6HS9A0OhjShWs5dlYAZK6Liowt+hzDlPtxYgsmoRx1oP5hkwIJ4gQJeaq5pkjtU6f
 rpVcl2jGTR/5fk8RqOky5L1eD5blgaXrDYK7KvzwQ70PZKCMoZzS8AmxcmNzRurBdisaTHgrU
 YnQSN/lUqe3hXUJESwPgs0l6MEOpg6XU2BKFWiYRUIJMVlNYmDWMvq5Cb9s2xufqqKxq0p2i5
 XuBflIiG/8uvx9WncP0xswOyHM5nll2Lj5nwRxGW45lpjubzNGCorsCLpAN99aaVuYfdp82nA
 6gnC1Q6xkZVwsTQb67UhmPTUVtIJP0xPwbJT6g6CN2PHqgfaCclRxsH29nC/prNi/xnJG7s+U
 rG0ClQLiK4cE1PeB3iy2L/fczQmjfbUpvDXZJ8lVe9ltZr6gniiPe5umMaWWe/uBm+QcCl4aH
 DT88S7A5qf/hp2eRXiubHnc9MeETG4DM7oWU+g8cw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/09/2019 à 19:10, Alex Bennée a écrit :
> We were incorrectly using the 64-bit AIX ABI instead of the 32-bit
> SYSV ABI for setting NIP for the signal handler.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> v2
>    - change to wording
> ---
>   linux-user/ppc/signal.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> index 619a56950df..5b82af6cb62 100644
> --- a/linux-user/ppc/signal.c
> +++ b/linux-user/ppc/signal.c
> @@ -501,7 +501,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>       int i, err = 0;
>   #if defined(TARGET_PPC64)
>       struct target_sigcontext *sc = 0;
> +#if !defined(TARGET_ABI32)
>       struct image_info *image = ((TaskState *)thread_cpu->opaque)->info;
> +#endif
>   #endif
>   
>       rt_sf_addr = get_sigframe(ka, env, sizeof(*rt_sf));
> @@ -557,7 +559,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>       env->gpr[5] = (target_ulong) h2g(&rt_sf->uc);
>       env->gpr[6] = (target_ulong) h2g(rt_sf);
>   
> -#if defined(TARGET_PPC64)
> +#if defined(TARGET_PPC64) && !defined(TARGET_ABI32)
>       if (get_ppc64_abi(image) < 2) {
>           /* ELFv1 PPC64 function pointers are pointers to OPD entries. */
>           struct target_func_ptr *handler =
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

