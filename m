Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE07C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4CA217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzYqbK/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4CA217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnhk-0008Vz-3C
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:23:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOngH-0007fX-TR
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOngG-0008K9-S4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:22:09 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOngG-0008Ji-Kk
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:22:08 -0400
Received: by mail-lj1-x242.google.com with SMTP id 14so2865847ljj.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Z4c+B7Dfuc0ihZX8rcpziDT4KmaolrJowl2mlcwK0dg=;
	b=TzYqbK/w8zCh+wuvK7r+x1xJ6BqMW3Xwx0Smf2C+KSDwntWzB7eRylTkKGoCq+1rc+
	y1D8R2qgsBp61ctIiAp1UYar3tK84y3ywp+paRhBO70WERrc2Y5j4E19y6O8NpiBsZmS
	mGRJxEkogX/HAiP5GPs+iYVTrTq61DB21OF2PGGjya1fEx8iDyKMagjVlKI5s30YXw96
	HvZrFqz3Ktzr6GetZoBBvbvkSmPLgThcNnHNBs93RzGX7+wKU7ltX37Ckp23iMYJ7SnT
	Peojx0WwzYp4cvxYOzpAn9SyRLD2zWyCdaYisQmTzrAOBPfn6U2bXGtw8rq4xCw+EXRP
	B14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Z4c+B7Dfuc0ihZX8rcpziDT4KmaolrJowl2mlcwK0dg=;
	b=Y1bbp5kqH8/mnPgLjWegzdF+k9KZjeyMcuO+VWEpaF6TPlmYNTjNtitDWUmBok/hEE
	zbGh3xR4zk+O06ICPgNZH18Uhi7QmOsWbvnVnE8fxFeSOecAZfyzhNLQGWYguEMm8Uou
	I5gE2Ty5/u8fJIT8cRpwJ77bHO4qclHW9+7+2c7oxbSzyPVTd5HIu9IvVVeQpN6f0ZjB
	jCWQmodXhfFqYjOEQA4/JPBkDuo9nS5AoYf10ZNB6cf6SM9q9SUj6QjXsFDXtBf8M4Su
	WxArG4VRr+5WnB1HVuwwteNXSOajLtcewRcDyKkqLzDp5WNhxyomzDyRxFcHRpacw8wm
	wIZA==
X-Gm-Message-State: APjAAAV33cwK21/zIl6oty36rAD+ah+D0JeiOZRhpBcVbsoxcP+Kt4+y
	+8z0iAgf+pyaES6RRKNmaAlqoXqOxAsG0OrCqeQFk3kp
X-Google-Smtp-Source: APXvYqzNhbRXB4hUVFV3c9aDIpRNh6moUIpDCJkdTXVWQ+0b0C+EoA/x7Et2Hc00hOhPdsTb/EQKsbTpq0MViYhcY8U=
X-Received: by 2002:a2e:9c89:: with SMTP id x9mr3185319lji.28.1557426127475;
	Thu, 09 May 2019 11:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-21-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-21-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 11:20:01 -0700
Message-ID: <CAKmqyKN-wtQk8uKV_yHJyg8T+fFFUeWM2dsK9QxAQu1hLfGifA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3 20/39] target/nios2: Use env_cpu,
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

On Tue, May 7, 2019 at 5:22 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/nios2/cpu.h |  5 -----
>  hw/nios2/cpu_pic.c |  5 +----
>  target/nios2/mmu.c | 10 +++++-----
>  3 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> index b14095b8dc..f2ffc1469f 100644
> --- a/target/nios2/cpu.h
> +++ b/target/nios2/cpu.h
> @@ -193,11 +193,6 @@ typedef struct Nios2CPU {
>      uint32_t fast_tlb_miss_addr;
>  } Nios2CPU;
>
> -static inline Nios2CPU *nios2_env_get_cpu(CPUNios2State *env)
> -{
> -    return NIOS2_CPU(container_of(env, Nios2CPU, env));
> -}
> -
>  #define ENV_OFFSET offsetof(Nios2CPU, env)
>
>  void nios2_tcg_init(void);
> diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
> index 6bccce2f32..9e39955bd1 100644
> --- a/hw/nios2/cpu_pic.c
> +++ b/hw/nios2/cpu_pic.c
> @@ -54,12 +54,9 @@ static void nios2_pic_cpu_handler(void *opaque, int irq, int level)
>
>  void nios2_check_interrupts(CPUNios2State *env)
>  {
> -    Nios2CPU *cpu = nios2_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> -
>      if (env->irq_pending) {
>          env->irq_pending = 0;
> -        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +        cpu_interrupt(env_cpu(env), CPU_INTERRUPT_HARD);
>      }
>  }
>
> diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
> index 33382bad1b..61eaa06b3e 100644
> --- a/target/nios2/mmu.c
> +++ b/target/nios2/mmu.c
> @@ -73,7 +73,7 @@ unsigned int mmu_translate(CPUNios2State *env,
>                             Nios2MMULookup *lu,
>                             target_ulong vaddr, int rw, int mmu_idx)
>  {
> -    Nios2CPU *cpu = nios2_env_get_cpu(env);
> +    Nios2CPU *cpu = env_archcpu(env);
>      int pid = (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4;
>      int vpn = vaddr >> 12;
>
> @@ -115,7 +115,7 @@ unsigned int mmu_translate(CPUNios2State *env,
>  static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
>  {
>      CPUState *cs = env_cpu(env);
> -    Nios2CPU *cpu = nios2_env_get_cpu(env);
> +    Nios2CPU *cpu = env_archcpu(env);
>      int idx;
>      MMU_LOG(qemu_log("TLB Flush PID %d\n", pid));
>
> @@ -139,7 +139,7 @@ static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
>  void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
>  {
>      CPUState *cs = env_cpu(env);
> -    Nios2CPU *cpu = nios2_env_get_cpu(env);
> +    Nios2CPU *cpu = env_archcpu(env);
>
>      MMU_LOG(qemu_log("mmu_write %08X = %08X\n", rn, v));
>
> @@ -256,7 +256,7 @@ void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
>
>  void mmu_init(CPUNios2State *env)
>  {
> -    Nios2CPU *cpu = nios2_env_get_cpu(env);
> +    Nios2CPU *cpu = env_archcpu(env);
>      Nios2MMU *mmu = &env->mmu;
>
>      MMU_LOG(qemu_log("mmu_init\n"));
> @@ -267,7 +267,7 @@ void mmu_init(CPUNios2State *env)
>
>  void dump_mmu(CPUNios2State *env)
>  {
> -    Nios2CPU *cpu = nios2_env_get_cpu(env);
> +    Nios2CPU *cpu = env_archcpu(env);
>      int i;
>
>      qemu_printf("MMU: ways %d, entries %d, pid bits %d\n",
> --
> 2.17.1
>
>

