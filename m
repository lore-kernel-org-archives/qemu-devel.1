Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21E0C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7291A2084E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI7gmOIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7291A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnSz-0007TK-NS
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:08:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnRd-0006sh-JH
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnRZ-00069v-Tu
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:06:59 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOnRY-000660-GZ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:06:57 -0400
Received: by mail-lj1-x242.google.com with SMTP id e13so2794186ljl.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ZfWh3hn7XdtWPXpXIFsMxCHsaiCtxUTDYMziiCaEFVI=;
	b=bI7gmOIPvhriDzpF7qM4VQGkWPAkeihkNRyytCS5dtpabt02ifXNL0MVrM9xMbNIRf
	i3KgwFCHIxyv2cNepziHpd6WCjo6pvFA3yTS2cHX1g7c7ffJASEKYea1Ddbkb8Jp9e77
	fi1TNd8hS/VEexj/wGUueSmcvOpn5XBbMozo9mXpfM1X6TIY548xG5wYKx03rXpLJDyR
	tVpqqCMr/fpTXM1qfenLH6Bq9jaKFdT1K3kpKIUfYVWKMRFAyeOINZueNw9NEz7X1MT7
	WD1Hz/pTMUWTfItc/RZ+99p+0ANNlbfZwqq9CqTwIExuY0Yodn1utTCCxhDKHh0E6O2v
	pBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ZfWh3hn7XdtWPXpXIFsMxCHsaiCtxUTDYMziiCaEFVI=;
	b=OfC3+eDQQc7w9Trj/MSm3xXGRWlhATpxrd402IaJ/GAmaK3GEVZa+GWykON4pihiYW
	juqAeyI37FZj0/NmqFpC9A88tyzdRwmeWVKrZBPjlfU1mz5MxGVDFpo445HEicX+xY6Y
	LYbmND7PJi+I0ksNkj+Ty0gpNy0EhQe9YV2/pfTL+bRoiBDESv3nk0aW1IvQScgVhQeX
	rgE9vxckcVJ7mMZ0HmTLCetCYN1cmoeE9IzNCKhlAIx9GTXy7RPeMTLVGe2WF66LT7aw
	TMq9DPqPxGRJoMnkT6HxxsW04sykhWPCgKYJ9yjVsemRyj+Vk68uy6eAoTQbLNa3S9L0
	fG1g==
X-Gm-Message-State: APjAAAWIRKt7cCHNA8Sl7aH5MC7xrDxZYFM3cHEzAOV2eDCw175GtIPI
	XdzFnX9gHfctOHSzWirXR+7Ihg9J0klUvtDpSKz1442b
X-Google-Smtp-Source: APXvYqz2iGCsNlJxVI7G3wJebiGmSz1Xvrm7zN4bv2zbymomGFaHAw8JDSnau3H3+bGVmylOxYhwnQbodhkSiT9D/8A=
X-Received: by 2002:a2e:5b92:: with SMTP id m18mr3353189lje.115.1557425214251; 
	Thu, 09 May 2019 11:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-13-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-13-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 11:04:46 -0700
Message-ID: <CAKmqyKPRcpmOXcP9eAiRCq-NtFfZvw3U4+Xh6N02HUuXoQjzhw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3 12/39] target/cris: Use env_cpu,
 env_archcpu
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:10 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/cris/cpu.h          |  5 -----
>  linux-user/cris/cpu_loop.c |  2 +-
>  target/cris/mmu.c          |  3 +--
>  target/cris/op_helper.c    | 10 +++-------
>  target/cris/translate.c    |  2 +-
>  5 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/target/cris/cpu.h b/target/cris/cpu.h
> index 883799b463..7f244ad545 100644
> --- a/target/cris/cpu.h
> +++ b/target/cris/cpu.h
> @@ -183,11 +183,6 @@ struct CRISCPU {
>      CPUCRISState env;
>  };
>
> -static inline CRISCPU *cris_env_get_cpu(CPUCRISState *env)
> -{
> -    return container_of(env, CRISCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(CRISCPU, env)
>
>  #ifndef CONFIG_USER_ONLY
> diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
> index 7ec36cb0b5..86e711108d 100644
> --- a/linux-user/cris/cpu_loop.c
> +++ b/linux-user/cris/cpu_loop.c
> @@ -23,7 +23,7 @@
>
>  void cpu_loop(CPUCRISState *env)
>  {
> -    CPUState *cs = CPU(cris_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int trapnr, ret;
>      target_siginfo_t info;
>
> diff --git a/target/cris/mmu.c b/target/cris/mmu.c
> index 9cb73bbfec..2acbcfd1c7 100644
> --- a/target/cris/mmu.c
> +++ b/target/cris/mmu.c
> @@ -288,7 +288,6 @@ static int cris_mmu_translate_page(struct cris_mmu_result *res,
>
>  void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
>  {
> -    CRISCPU *cpu = cris_env_get_cpu(env);
>      target_ulong vaddr;
>      unsigned int idx;
>      uint32_t lo, hi;
> @@ -312,7 +311,7 @@ void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
>                  if (tlb_v && !tlb_g && (tlb_pid == pid)) {
>                      vaddr = tlb_vpn << TARGET_PAGE_BITS;
>                      D_LOG("flush pid=%x vaddr=%x\n", pid, vaddr);
> -                    tlb_flush_page(CPU(cpu), vaddr);
> +                    tlb_flush_page(env_cpu(env), vaddr);
>                  }
>              }
>          }
> diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
> index d4479167a5..0e323c1dd7 100644
> --- a/target/cris/op_helper.c
> +++ b/target/cris/op_helper.c
> @@ -67,7 +67,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
>
>  void helper_raise_exception(CPUCRISState *env, uint32_t index)
>  {
> -    CPUState *cs = CPU(cris_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = index;
>      cpu_loop_exit(cs);
> @@ -86,8 +86,7 @@ void helper_tlb_flush_pid(CPUCRISState *env, uint32_t pid)
>  void helper_spc_write(CPUCRISState *env, uint32_t new_spc)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    CRISCPU *cpu = cris_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>
>      tlb_flush_page(cs, env->pregs[PR_SPC]);
>      tlb_flush_page(cs, new_spc);
> @@ -100,9 +99,6 @@ void helper_spc_write(CPUCRISState *env, uint32_t new_spc)
>
>  void helper_movl_sreg_reg(CPUCRISState *env, uint32_t sreg, uint32_t reg)
>  {
> -#if !defined(CONFIG_USER_ONLY)
> -    CRISCPU *cpu = cris_env_get_cpu(env);
> -#endif
>      uint32_t srs;
>      srs = env->pregs[PR_SRS];
>      srs &= 3;
> @@ -140,7 +136,7 @@ void helper_movl_sreg_reg(CPUCRISState *env, uint32_t sreg, uint32_t reg)
>              D_LOG("tlb flush vaddr=%x v=%d pc=%x\n",
>                    vaddr, tlb_v, env->pc);
>              if (tlb_v) {
> -                tlb_flush_page(CPU(cpu), vaddr);
> +                tlb_flush_page(env_cpu(env), vaddr);
>              }
>          }
>      }
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index b005a5c20e..c0af9665fc 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -3104,7 +3104,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
>       * delayslot, like in real hw.
>       */
>      pc_start = tb->pc & ~1;
> -    dc->cpu = cris_env_get_cpu(env);
> +    dc->cpu = env_archcpu(env);
>      dc->tb = tb;
>
>      dc->is_jmp = DISAS_NEXT;
> --
> 2.17.1
>
>

