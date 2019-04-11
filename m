Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48116C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0FB2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0FB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWN7-00025W-9t
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:51:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWM7-0001gK-El
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWM6-0005I4-13
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:50:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWM5-0005Ho-K8
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:50:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so1783845wrx.10
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=555AL4MT/4zLMNmjypFZI18OLvHI8Hl870OEAsf6smM=;
	b=tB6BYHkcVAbwuB11Jh+bpa9d5ZtZpQHAEXlqrBgD/Oetj1eUJCTeFUS2SNmsoDXW/J
	3MJ9MvnWhsNjJOIIYDV17ml5iGy2Pjh41SbCtdlhz1zHLxlhBlL10YT10KiCPcQJsNE1
	EyTZCQfsP0MB7+JWtAp4fkjlmyzb8QaFKmY8oJnj21TQjEavz/Qycf3cB+voTKdBUXrd
	8zr3axzdgnfLUtza8ZGLf/eeSJ4BN4Db/AdYamvPQFKUFXsJs+zXl+PRwRxdeBr3HngB
	/MTUCjR2pB9zfcUFoIiLQhGVhuLeSHNrJ7aOpdK1W2nZJ+Q7O/S+RC+ORJw6bfXIOtA4
	04SQ==
X-Gm-Message-State: APjAAAXUkuvATjCN6og0spMjDFBZFU7Xf6VWTDL/H9vz4D0xi6m5YGJI
	3IkOghHscN/gOQwH8YVAV5U3FskFGM4=
X-Google-Smtp-Source: APXvYqxMTNqXMMA11bykJ6g3I3yXUIZ2quLlEuZ/zozl2raJi3KytMFi1mrTyD/C1quxadkHppwTGw==
X-Received: by 2002:adf:ed90:: with SMTP id c16mr32723011wro.74.1554976248650; 
	Thu, 11 Apr 2019 02:50:48 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	192sm8591569wme.13.2019.04.11.02.50.47
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:50:47 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c807dc5a-14f0-0845-3d9d-f52d88a6f2ef@redhat.com>
Date: Thu, 11 Apr 2019 11:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 14/23] linux-user/aarch64: Use
 qemu_guest_getrandom for PAUTH keys
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411095047.EooI5BWB5X_muNsUtZD9u_k6D7jRA4cBjj_rzeiai7I@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> Use a better interface for random numbers than rand() * 3.
> 
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_syscall.h |  2 --
>  linux-user/aarch64/cpu_loop.c       | 29 ++++++---------------------
>  linux-user/syscall.c                | 31 ++++++++++++++++++++++++-----
>  3 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
> index b595e5da82..995e475c73 100644
> --- a/linux-user/aarch64/target_syscall.h
> +++ b/linux-user/aarch64/target_syscall.h
> @@ -29,6 +29,4 @@ struct target_pt_regs {
>  # define TARGET_PR_PAC_APDBKEY   (1 << 3)
>  # define TARGET_PR_PAC_APGAKEY   (1 << 4)
>  
> -void arm_init_pauth_key(ARMPACKey *key);
> -
>  #endif /* AARCH64_TARGET_SYSCALL_H */
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
> index d75fd9d3e2..cedad39ca0 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu.h"
>  #include "cpu_loop-common.h"
> +#include "qemu/guest-random.h"
>  
>  #define get_user_code_u32(x, gaddr, env)                \
>      ({ abi_long __r = get_user_u32((x), (gaddr));       \
> @@ -147,24 +148,6 @@ void cpu_loop(CPUARMState *env)
>      }
>  }
>  
> -static uint64_t arm_rand64(void)
> -{
> -    int shift = 64 - clz64(RAND_MAX);
> -    int i, n = 64 / shift + (64 % shift != 0);
> -    uint64_t ret = 0;
> -
> -    for (i = 0; i < n; i++) {
> -        ret = (ret << shift) | rand();
> -    }
> -    return ret;
> -}
> -
> -void arm_init_pauth_key(ARMPACKey *key)
> -{
> -    key->lo = arm_rand64();
> -    key->hi = arm_rand64();
> -}
> -
>  void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
>  {
>      ARMCPU *cpu = arm_env_get_cpu(env);
> @@ -192,11 +175,11 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
>  #endif
>  
>      if (cpu_isar_feature(aa64_pauth, cpu)) {
> -        arm_init_pauth_key(&env->apia_key);
> -        arm_init_pauth_key(&env->apib_key);
> -        arm_init_pauth_key(&env->apda_key);
> -        arm_init_pauth_key(&env->apdb_key);
> -        arm_init_pauth_key(&env->apga_key);
> +        qemu_guest_getrandom_nofail(&env->apia_key, sizeof(ARMPACKey));
> +        qemu_guest_getrandom_nofail(&env->apib_key, sizeof(ARMPACKey));
> +        qemu_guest_getrandom_nofail(&env->apda_key, sizeof(ARMPACKey));
> +        qemu_guest_getrandom_nofail(&env->apdb_key, sizeof(ARMPACKey));
> +        qemu_guest_getrandom_nofail(&env->apga_key, sizeof(ARMPACKey));
>      }
>  
>      ts->stack_base = info->start_stack;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8f7125cd67..c2168db1c8 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -111,6 +111,7 @@
>  
>  #include "qemu.h"
>  #include "qemu/guest-random.h"
> +#include "qapi/error.h"
>  #include "fd-trans.h"
>  
>  #ifndef CLONE_IO
> @@ -9731,25 +9732,45 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                      int all = (TARGET_PR_PAC_APIAKEY | TARGET_PR_PAC_APIBKEY |
>                                 TARGET_PR_PAC_APDAKEY | TARGET_PR_PAC_APDBKEY |
>                                 TARGET_PR_PAC_APGAKEY);
> +                    int ret = 0;
> +                    Error *err = NULL;
> +
>                      if (arg2 == 0) {
>                          arg2 = all;
>                      } else if (arg2 & ~all) {
>                          return -TARGET_EINVAL;
>                      }
>                      if (arg2 & TARGET_PR_PAC_APIAKEY) {
> -                        arm_init_pauth_key(&env->apia_key);
> +                        ret |= qemu_guest_getrandom(&env->apia_key,
> +                                                    sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APIBKEY) {
> -                        arm_init_pauth_key(&env->apib_key);
> +                        ret |= qemu_guest_getrandom(&env->apib_key,
> +                                                    sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APDAKEY) {
> -                        arm_init_pauth_key(&env->apda_key);
> +                        ret |= qemu_guest_getrandom(&env->apda_key,
> +                                                    sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APDBKEY) {
> -                        arm_init_pauth_key(&env->apdb_key);
> +                        ret |= qemu_guest_getrandom(&env->apdb_key,
> +                                                    sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APGAKEY) {
> -                        arm_init_pauth_key(&env->apga_key);
> +                        ret |= qemu_guest_getrandom(&env->apga_key,
> +                                                    sizeof(ARMPACKey), &err);
> +                    }
> +                    if (ret != 0) {
> +                        /*
> +                         * Some unknown failure in the crypto.  The best
> +                         * we can do is log it and fail the syscall.
> +                         * The real syscall cannot fail this way.
> +                         */
> +                        qemu_log_mask(LOG_UNIMP,
> +                                      "PR_PAC_RESET_KEYS: Crypto failure: %s",
> +                                      error_get_pretty(err));
> +                        error_free(err);
> +                        return -TARGET_EIO;

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>                      }
>                      return 0;
>                  }
> 

