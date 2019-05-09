Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1293DC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5462085A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geecjAVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5462085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58932 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnMg-0002ud-RE
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:01:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnJ3-0007Wy-Rw
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnJ2-0000fp-DC
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:58:09 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOnJ2-0000fR-5b
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:58:08 -0400
Received: by mail-lf1-x141.google.com with SMTP id u27so2194806lfg.10
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=tzmKJLehJT89eW8ekZejP+oZP8e9ssWy9e+lkPe1YPU=;
	b=geecjAVu6XtVVJ9NjC32Lg2uO8BCwpNod8Dd0N4vPPjkMPXdICiPMJgkcMWGGafByQ
	XH9zT+061WAayNujJd1IkzKXBA7GYQIfgvlB6sMn7dJPZUJKpcOLbWWzZnMA1QM52anZ
	2oj7aKRgZFAkfZAa3gOR85FptuhVstC65Rc3IdxCgYYP27YGhPcrh6AodXmVg5rEppTt
	VycTIm4Ub5lgLu/2PFPRajMu11NvSW+u/8WFlKSyeUoucNjldA97etaiK2WgMVNrwKlY
	bD12VZid9YfYwX5PI0LK2399LdE/kzGyFgOtTkSxj9AJM9BZS3iGr6ooigaPQh175TW5
	3x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=tzmKJLehJT89eW8ekZejP+oZP8e9ssWy9e+lkPe1YPU=;
	b=NuVLSHU9eehu3dXGTvOa9kSsiESH/uldt5L9JoFCZZSWbCnEnipl9/YGZlKkMHaayg
	vJBjJl3b+sUOAGfP2YJdjkzvKEHMCXcsDYkcmFLU5OYULNIHqX36vuZTBwDTDNzWIYwo
	UNNToZeyHafR70EvjD2mDmcxZswcXmaP8nBmMClgVx0cMf6RextoDcWXxGJpTY5jpchY
	OTPCaUuzKq9To4y+Ycjq2vs1Bj81HiKzBfiF2uNgztcRTihf4TSHniS/796vEoyrtvAt
	9Lu6maDeF6hcvS95j0pvvi0v6DcFshwhgBNRowueNzGkn/jvjEhrlmyKl+lF6ZL6j9ZR
	XLJw==
X-Gm-Message-State: APjAAAVukPUn16nAEYJNB7kiFSlU4bkEeWGZkd3Jn0EDRz49cJ6YtV5/
	x07KLtrZ93eK/CjwETLx11IJuCBWm+Bkq9qA/QA=
X-Google-Smtp-Source: APXvYqwIK87BsG80P0J+UHWh21fKL9UpyH5MzA505bvQFZYSSSHXmp8OjnP8CbQHP+Z8lchPG23l0ipswWAO30N2C04=
X-Received: by 2002:a19:189:: with SMTP id 131mr3206800lfb.74.1557424686827;
	Thu, 09 May 2019 10:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-9-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-9-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 10:56:00 -0700
Message-ID: <CAKmqyKP8Qgbzv3V=hq4zktd0bDs-EnXRS_p=t6agd=CT37pjkQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v3 08/39] target/alpha: Use env_cpu,
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

On Tue, May 7, 2019 at 5:07 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With exactly one exception, most uses of alpha_env_get_cpu
> were failures to use the more proper, ENV_GET_CPU macro,
> now replaced by env_cpu.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/alpha/cpu.h          | 5 -----
>  linux-user/alpha/cpu_loop.c | 2 +-
>  target/alpha/helper.c       | 8 +++-----
>  target/alpha/sys_helper.c   | 8 ++++----
>  4 files changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 2c7f75f584..53c085f691 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -273,11 +273,6 @@ struct AlphaCPU {
>      QEMUTimer *alarm_timer;
>  };
>
> -static inline AlphaCPU *alpha_env_get_cpu(CPUAlphaState *env)
> -{
> -    return container_of(env, AlphaCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(AlphaCPU, env)
>
>  #ifndef CONFIG_USER_ONLY
> diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
> index 61992571e1..7a94eee84c 100644
> --- a/linux-user/alpha/cpu_loop.c
> +++ b/linux-user/alpha/cpu_loop.c
> @@ -23,7 +23,7 @@
>
>  void cpu_loop(CPUAlphaState *env)
>  {
> -    CPUState *cs = CPU(alpha_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int trapnr;
>      target_siginfo_t info;
>      abi_long sysret;
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 7201576aae..08dfb834a5 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -119,7 +119,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
>                                  int prot_need, int mmu_idx,
>                                  target_ulong *pphys, int *pprot)
>  {
> -    CPUState *cs = CPU(alpha_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      target_long saddr = addr;
>      target_ulong phys = 0;
>      target_ulong L1pte, L2pte, L3pte;
> @@ -463,8 +463,7 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>     We expect that ENV->PC has already been updated.  */
>  void QEMU_NORETURN helper_excp(CPUAlphaState *env, int excp, int error)
>  {
> -    AlphaCPU *cpu = alpha_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = excp;
>      env->error_code = error;
> @@ -475,8 +474,7 @@ void QEMU_NORETURN helper_excp(CPUAlphaState *env, int excp, int error)
>  void QEMU_NORETURN dynamic_excp(CPUAlphaState *env, uintptr_t retaddr,
>                                  int excp, int error)
>  {
> -    AlphaCPU *cpu = alpha_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = excp;
>      env->error_code = error;
> diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
> index ac22323191..f9c34b1144 100644
> --- a/target/alpha/sys_helper.c
> +++ b/target/alpha/sys_helper.c
> @@ -44,17 +44,17 @@ uint64_t helper_load_pcc(CPUAlphaState *env)
>  #ifndef CONFIG_USER_ONLY
>  void helper_tbia(CPUAlphaState *env)
>  {
> -    tlb_flush(CPU(alpha_env_get_cpu(env)));
> +    tlb_flush(env_cpu(env));
>  }
>
>  void helper_tbis(CPUAlphaState *env, uint64_t p)
>  {
> -    tlb_flush_page(CPU(alpha_env_get_cpu(env)), p);
> +    tlb_flush_page(env_cpu(env), p);
>  }
>
>  void helper_tb_flush(CPUAlphaState *env)
>  {
> -    tb_flush(CPU(alpha_env_get_cpu(env)));
> +    tb_flush(env_cpu(env));
>  }
>
>  void helper_halt(uint64_t restart)
> @@ -78,7 +78,7 @@ uint64_t helper_get_walltime(void)
>
>  void helper_set_alarm(CPUAlphaState *env, uint64_t expire)
>  {
> -    AlphaCPU *cpu = alpha_env_get_cpu(env);
> +    AlphaCPU *cpu = env_archcpu(env);
>
>      if (expire) {
>          env->alarm_expire = expire;
> --
> 2.17.1
>
>

