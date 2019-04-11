Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49284C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0A42084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0A42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWQv-00057O-CA
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:55:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWPn-0004Lh-B9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWPl-0007jM-LU
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:54:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWPl-0007ix-8g
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:54:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so5888684wml.4
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=BPE0au2UpYBZsLx6RVExM5RpiZo23ka8Kqqss3beCs0=;
	b=k5vey+fFHST1c/e6L/teXKX7GKS0kSUByUTuT/sse3QcBBZtQVtEiGFiItaiUUly2R
	Rl1bASIjHzD57Vsy/n+K93yuqyk29PwDZFMpfrffML/k5paI2WXCEx1930cf+WewW1xc
	1NxmkIxmeQZfMvOzLfkaNeAMlDPOa7sNDGMK6mt+PM2Q/OHrHeaXMR8EQXoy5K7aCrjO
	DymQYgzAo4xyqs2e7N/JSbQ4XllG2R955gr/u1+hmINq+s2ldmsu086ckOAvaEHpPGwx
	kofKfGEcBQ7T7Ob54m7byUwfXoh5J+582JTB2uDQSCeiLyqQ0Ose59etcz0pzCS0yCnd
	Jk/A==
X-Gm-Message-State: APjAAAUKipj7yDQxtp4UTK+LymUIMM2jMSPZyzyo+obmbLBFIVcNnS8h
	nfGRVydDqRpajY6syg5dRoDNL12gCfA=
X-Google-Smtp-Source: APXvYqzUhT3o/3bQb8AhGCoQRtDpy21XraB3OVIzTHM7kc9RprcHNBAdgXh0nBMuvNo0wyXnIke/Eg==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr6257047wma.129.1554976476068;
	Thu, 11 Apr 2019 02:54:36 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v16sm53704994wru.76.2019.04.11.02.54.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:54:35 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <377f5d9a-328b-ebee-4ad7-807c37bffe22@redhat.com>
Date: Thu, 11 Apr 2019 11:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 20/23] target/arm: Put all PAC keys into
 a structure
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411095435.qLs5K-JAMyXiJyebYduUiM1J-l1H_YAT1c8A8V8txIc@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> This allows us to use a single syscall to initialize them all.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h              | 12 +++++++-----
>  linux-user/aarch64/cpu_loop.c |  6 +-----
>  linux-user/syscall.c          | 10 +++++-----
>  target/arm/helper.c           | 20 ++++++++++----------
>  target/arm/pauth_helper.c     | 18 +++++++++---------
>  5 files changed, 32 insertions(+), 34 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 5f23c62132..ae2381e222 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -628,11 +628,13 @@ typedef struct CPUARMState {
>      } iwmmxt;
>  
>  #ifdef TARGET_AARCH64
> -    ARMPACKey apia_key;
> -    ARMPACKey apib_key;
> -    ARMPACKey apda_key;
> -    ARMPACKey apdb_key;
> -    ARMPACKey apga_key;
> +    struct {
> +        ARMPACKey apia;
> +        ARMPACKey apib;
> +        ARMPACKey apda;
> +        ARMPACKey apdb;
> +        ARMPACKey apga;
> +    } keys;

Yay!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  #endif
>  
>  #if defined(CONFIG_USER_ONLY)
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
> index cedad39ca0..2f2f63e3e8 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -175,11 +175,7 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
>  #endif
>  
>      if (cpu_isar_feature(aa64_pauth, cpu)) {
> -        qemu_guest_getrandom_nofail(&env->apia_key, sizeof(ARMPACKey));
> -        qemu_guest_getrandom_nofail(&env->apib_key, sizeof(ARMPACKey));
> -        qemu_guest_getrandom_nofail(&env->apda_key, sizeof(ARMPACKey));
> -        qemu_guest_getrandom_nofail(&env->apdb_key, sizeof(ARMPACKey));
> -        qemu_guest_getrandom_nofail(&env->apga_key, sizeof(ARMPACKey));
> +        qemu_guest_getrandom_nofail(&env->keys, sizeof(env->keys));
>      }
>  
>      ts->stack_base = info->start_stack;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index c2168db1c8..ebbda9e470 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9741,23 +9741,23 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                          return -TARGET_EINVAL;
>                      }
>                      if (arg2 & TARGET_PR_PAC_APIAKEY) {
> -                        ret |= qemu_guest_getrandom(&env->apia_key,
> +                        ret |= qemu_guest_getrandom(&env->keys.apia,
>                                                      sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APIBKEY) {
> -                        ret |= qemu_guest_getrandom(&env->apib_key,
> +                        ret |= qemu_guest_getrandom(&env->keys.apib,
>                                                      sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APDAKEY) {
> -                        ret |= qemu_guest_getrandom(&env->apda_key,
> +                        ret |= qemu_guest_getrandom(&env->keys.apda,
>                                                      sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APDBKEY) {
> -                        ret |= qemu_guest_getrandom(&env->apdb_key,
> +                        ret |= qemu_guest_getrandom(&env->keys.apdb,
>                                                      sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APGAKEY) {
> -                        ret |= qemu_guest_getrandom(&env->apga_key,
> +                        ret |= qemu_guest_getrandom(&env->keys.apga,
>                                                      sizeof(ARMPACKey), &err);
>                      }
>                      if (ret != 0) {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2607d39ad1..7b5d63f894 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5678,43 +5678,43 @@ static const ARMCPRegInfo pauth_reginfo[] = {
>      { .name = "APDAKEYLO_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 0,
>        .access = PL1_RW, .accessfn = access_pauth,
> -      .fieldoffset = offsetof(CPUARMState, apda_key.lo) },
> +      .fieldoffset = offsetof(CPUARMState, keys.apda.lo) },
>      { .name = "APDAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 1,
>        .access = PL1_RW, .accessfn = access_pauth,
> -      .fieldoffset = offsetof(CPUARMState, apda_key.hi) },
> +      .fieldoffset = offsetof(CPUARMState, keys.apda.hi) },
>      { .name = "APDBKEYLO_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 2,
>        .access = PL1_RW, .accessfn = access_pauth,
> -      .fieldoffset = offsetof(CPUARMState, apdb_key.lo) },
> +      .fieldoffset = offsetof(CPUARMState, keys.apdb.lo) },
>      { .name = "APDBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 3,
>        .access = PL1_RW, .accessfn = access_pauth,
> -      .fieldoffset = offsetof(CPUARMState, apdb_key.hi) },
> +      .fieldoffset = offsetof(CPUARMState, keys.apdb.hi) },
>      { .name = "APGAKEYLO_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 0,
>        .access = PL1_RW, .accessfn = access_pauth,
> -      .fieldoffset = offsetof(CPUARMState, apga_key.lo) },
> +      .fieldoffset = offsetof(CPUARMState, keys.apga.lo) },
>      { .name = "APGAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 1,
>        .access = PL1_RW, .accessfn = access_pauth,
> -      .fieldoffset = offsetof(CPUARMState, apga_key.hi) },
> +      .fieldoffset = offsetof(CPUARMState, keys.apga.hi) },
>      { .name = "APIAKEYLO_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 0,
>        .access = PL1_RW, .accessfn = access_pauth,
> -      .fieldoffset = offsetof(CPUARMState, apia_key.lo) },
> +      .fieldoffset = offsetof(CPUARMState, keys.apia.lo) },
>      { .name = "APIAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 1,
>        .access = PL1_RW, .accessfn = access_pauth,
> -      .fieldoffset = offsetof(CPUARMState, apia_key.hi) },
> +      .fieldoffset = offsetof(CPUARMState, keys.apia.hi) },
>      { .name = "APIBKEYLO_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 2,
>        .access = PL1_RW, .accessfn = access_pauth,
> -      .fieldoffset = offsetof(CPUARMState, apib_key.lo) },
> +      .fieldoffset = offsetof(CPUARMState, keys.apib.lo) },
>      { .name = "APIBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 3,
>        .access = PL1_RW, .accessfn = access_pauth,
> -      .fieldoffset = offsetof(CPUARMState, apib_key.hi) },
> +      .fieldoffset = offsetof(CPUARMState, keys.apib.hi) },
>      REGINFO_SENTINEL
>  };
>  #endif
> diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
> index d750f96edf..7f30ae7395 100644
> --- a/target/arm/pauth_helper.c
> +++ b/target/arm/pauth_helper.c
> @@ -403,7 +403,7 @@ uint64_t HELPER(pacia)(CPUARMState *env, uint64_t x, uint64_t y)
>          return x;
>      }
>      pauth_check_trap(env, el, GETPC());
> -    return pauth_addpac(env, x, y, &env->apia_key, false);
> +    return pauth_addpac(env, x, y, &env->keys.apia, false);
>  }
>  
>  uint64_t HELPER(pacib)(CPUARMState *env, uint64_t x, uint64_t y)
> @@ -413,7 +413,7 @@ uint64_t HELPER(pacib)(CPUARMState *env, uint64_t x, uint64_t y)
>          return x;
>      }
>      pauth_check_trap(env, el, GETPC());
> -    return pauth_addpac(env, x, y, &env->apib_key, false);
> +    return pauth_addpac(env, x, y, &env->keys.apib, false);
>  }
>  
>  uint64_t HELPER(pacda)(CPUARMState *env, uint64_t x, uint64_t y)
> @@ -423,7 +423,7 @@ uint64_t HELPER(pacda)(CPUARMState *env, uint64_t x, uint64_t y)
>          return x;
>      }
>      pauth_check_trap(env, el, GETPC());
> -    return pauth_addpac(env, x, y, &env->apda_key, true);
> +    return pauth_addpac(env, x, y, &env->keys.apda, true);
>  }
>  
>  uint64_t HELPER(pacdb)(CPUARMState *env, uint64_t x, uint64_t y)
> @@ -433,7 +433,7 @@ uint64_t HELPER(pacdb)(CPUARMState *env, uint64_t x, uint64_t y)
>          return x;
>      }
>      pauth_check_trap(env, el, GETPC());
> -    return pauth_addpac(env, x, y, &env->apdb_key, true);
> +    return pauth_addpac(env, x, y, &env->keys.apdb, true);
>  }
>  
>  uint64_t HELPER(pacga)(CPUARMState *env, uint64_t x, uint64_t y)
> @@ -441,7 +441,7 @@ uint64_t HELPER(pacga)(CPUARMState *env, uint64_t x, uint64_t y)
>      uint64_t pac;
>  
>      pauth_check_trap(env, arm_current_el(env), GETPC());
> -    pac = pauth_computepac(x, y, env->apga_key);
> +    pac = pauth_computepac(x, y, env->keys.apga);
>  
>      return pac & 0xffffffff00000000ull;
>  }
> @@ -453,7 +453,7 @@ uint64_t HELPER(autia)(CPUARMState *env, uint64_t x, uint64_t y)
>          return x;
>      }
>      pauth_check_trap(env, el, GETPC());
> -    return pauth_auth(env, x, y, &env->apia_key, false, 0);
> +    return pauth_auth(env, x, y, &env->keys.apia, false, 0);
>  }
>  
>  uint64_t HELPER(autib)(CPUARMState *env, uint64_t x, uint64_t y)
> @@ -463,7 +463,7 @@ uint64_t HELPER(autib)(CPUARMState *env, uint64_t x, uint64_t y)
>          return x;
>      }
>      pauth_check_trap(env, el, GETPC());
> -    return pauth_auth(env, x, y, &env->apib_key, false, 1);
> +    return pauth_auth(env, x, y, &env->keys.apib, false, 1);
>  }
>  
>  uint64_t HELPER(autda)(CPUARMState *env, uint64_t x, uint64_t y)
> @@ -473,7 +473,7 @@ uint64_t HELPER(autda)(CPUARMState *env, uint64_t x, uint64_t y)
>          return x;
>      }
>      pauth_check_trap(env, el, GETPC());
> -    return pauth_auth(env, x, y, &env->apda_key, true, 0);
> +    return pauth_auth(env, x, y, &env->keys.apda, true, 0);
>  }
>  
>  uint64_t HELPER(autdb)(CPUARMState *env, uint64_t x, uint64_t y)
> @@ -483,7 +483,7 @@ uint64_t HELPER(autdb)(CPUARMState *env, uint64_t x, uint64_t y)
>          return x;
>      }
>      pauth_check_trap(env, el, GETPC());
> -    return pauth_auth(env, x, y, &env->apdb_key, true, 1);
> +    return pauth_auth(env, x, y, &env->keys.apdb, true, 1);
>  }
>  
>  uint64_t HELPER(xpaci)(CPUARMState *env, uint64_t a)
> 

