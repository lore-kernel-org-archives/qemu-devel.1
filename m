Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662D5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 09:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356DA214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 09:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356DA214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifL2H-0006PY-5I
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 04:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ifL1Q-0005hk-CA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ifL1P-0006SV-0W
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:44:36 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:52567)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ifL1O-0006Py-Mm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:44:34 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MbBUc-1i8TBA18xc-00bcVm; Thu, 12 Dec 2019 10:44:32 +0100
Subject: Re: [PATCH 23/28] target/m68k: Use cpu_*_mmuidx_ra instead of
 MMU_MODE{0, 1}_SUFFIX
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191212040039.26546-1-richard.henderson@linaro.org>
 <20191212040039.26546-24-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6162d8ab-b608-15e4-8e33-8a656afb304a@vivier.eu>
Date: Thu, 12 Dec 2019 10:44:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212040039.26546-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+ctxzit/VivpYT9XXvvcuQmjHSo6SgTV0n5Ab7MV7jwVyzbupV3
 AII27YfYZ5PolLhQaJzhk7m2FsLW+/bMHe+TDqBHbAvke6f4R3bWW1hFumZGjndWzyBKHAP
 +zAEV44nm0u9fAZ/4SjBNuYa5VDLnrHmzKL+5B5cNmMjuAKg4AZGcMR6rXkdvrhROP1lJp5
 Cz4zkNXB18oITJn60tOyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8gXAZszHdEg=:27tZBYa76X7gK1Mlh9XxJn
 zrSUYXt8oXh4BzNH3ck8LpC9NmTVOI4VHAB4PsY1GXK1el5M3kBNP8U1XaxP4HbIgml3QcR4w
 YFVMascPpxpieF4mmnJg0Lyt4Xwy8S7Sf8GAoxVgVqr0JGMJzGs+mnlTWYW9EGoEfHnOXU//C
 M0Hh06AJZqpIDjHF7v6agvQYJrO8ms57DVdacJQrKWuyqjuZN15elyJrXW3AbP6kt1TbN3xE+
 iT4dsaNWjvbZmrO0sdOvOqg622WjDGmurv/XYlY3sXPCnOU117/p9/AfpkdCcovtP4buuBah9
 geYDVDUxQ4+C8c7KHKPDg0CX9lGJoh1iBs4eOQhKao+26VIpaFW7rWB9oimN0ogc1tr/gJAWZ
 tZP0D3Sar8b/dYustWvA8Q4+G3zXCANAbXZKNTp1eKtZhAa2kboKGVSc4vV2qT+NiJ/fbQndZ
 jfOITT5IoAt44dbKWlXOD1s9RsLZbVbApQKCUcO0GElFKUpDmdE8acwiUpBQH6Juioiqsx15n
 vz2nYo6KtrJYJFph5mZCc5c9AgYhVZT1tCBrRS5h+mXD3MUqvBtBHtGQetjRQhOFYnS+YYAUW
 mdX6ZL4StRmCr9tABzNci7B3Hfyfl5zTHtOV9Czh19W4YnEs8TuG1JW44chHRK9MGO7jZo3H/
 uU47KLOM61YWr+l/EZYOPJHrn39UZ2B2OWWF0Rwl5rdNPhwnOWjAah0S4IN+tvnde/JrzIFCZ
 tZUViZ6Eu3i37tD+F3+3Ow+1iBXjEqEq8KOp7T3MikQSL1qFeXyDHcP4AiiHjfyEmDVlAp9iV
 w/TBXjVoMPqzhskby1NEe22ictmPlj+hX5dnhqYThw2iof2TsOK4miX4j6eiqKipKsKvPaUwf
 CEpGSJegNei67/fg8VaW0oF9T0+ydgXZYFJHdubz4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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

Le 12/12/2019 à 05:00, Richard Henderson a écrit :
> The generated *_user functions are unused.  The *_kernel functions
> have a couple of users in op_helper.c; use *_mmuidx_ra instead,
> with MMU_KERNEL_IDX.
> 
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/m68k/cpu.h       | 2 --
>  target/m68k/op_helper.c | 5 +++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 20de3c379a..89af14e899 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -516,8 +516,6 @@ enum {
>  #define cpu_list m68k_cpu_list
>  
>  /* MMU modes definitions */
> -#define MMU_MODE0_SUFFIX _kernel
> -#define MMU_MODE1_SUFFIX _user
>  #define MMU_KERNEL_IDX 0
>  #define MMU_USER_IDX 1
>  static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index bc4f845e3f..96a4951c21 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -36,6 +36,11 @@ static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
>  
>  #else
>  
> +#define cpu_lduw_kernel(e, p)    cpu_lduw_mmuidx_ra(e, p, MMU_KERNEL_IDX, 0)
> +#define cpu_ldl_kernel(e, p)     cpu_ldl_mmuidx_ra(e, p, MMU_KERNEL_IDX, 0)
> +#define cpu_stw_kernel(e, p, v)  cpu_stw_mmuidx_ra(e, p, v, MMU_KERNEL_IDX, 0)
> +#define cpu_stl_kernel(e, p, v)  cpu_stl_mmuidx_ra(e, p, v, MMU_KERNEL_IDX, 0)

Do you think it would be a reasonable cleanup to replace the _kernel
functions by the _mmuidx_ra functions directly in the code in a future
patch?

Thanks,
Laurent



