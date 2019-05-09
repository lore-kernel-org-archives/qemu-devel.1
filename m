Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3F0C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF00E2177B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp3ek8bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF00E2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60427 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOpTe-0006ME-La
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:17:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpSm-0005qv-MV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpSl-0006nj-CS
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:16:20 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOpSl-0006mr-4A
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:16:19 -0400
Received: by mail-lj1-x241.google.com with SMTP id 14so3145197ljj.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ZJlI2N8lB+d8tORZgVVETPX1evpasmNl+s2qFq3D1xE=;
	b=mp3ek8bC7/AO6x1Qda2h7808o4aSTUUuV2C8uo4WcLIlIjgsmtPbJjO0nFfXkpPAC6
	KTdweQus1+ER0OAif2EJ+xmWPVELQpk2aj+5Ou1weiJ5TZv4nikoKp7xcZN8VDTwTnUb
	Sw19ZZw9QFBEydTIqAOMSP/78k0zjHvBaKGN471oiSbx2LsZSGPOFoJVZodmBpAqC9WL
	ZRPJ5M6axMVPGhtNdeixFVc8NBIw7f3kyqdWcGajxYFm5qFyZbr1TOFmVGG6AHXv27JW
	Sy056xV1e6VhHMyts8nO945bwNwYQ2ju/K8K+F5gD6Gsq8d76o6yBPlw/qkp/HtjCHXW
	5ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ZJlI2N8lB+d8tORZgVVETPX1evpasmNl+s2qFq3D1xE=;
	b=B1f4xsjhi7UAtO160GKYOdClVNjtbLXkx40dkddiAbA9lqWY7kSC5OxSV14sg/doeB
	zlgEYIPD81OKfUqpdX0Ln8GtDnuYM8FzOa3waJEK5QfhuSkFIdDRp7FvGc8vOiuj2eTz
	JRMMMay5QvsRr7bscKwBu/V06AGuIPKS/0NfBaHtluZ0sCmmBABVPikID7bKkykBHVJK
	k0lRZVojg9gCUGuAc3Vez+Uca8BUEwmzTY00YWZt+ZANgG+IaLpq7xDdgNKyMYsqIopG
	dtc4tzh/+kUl6EEDZF4gY1hU+7DxuU/GrVgCWowwBY9DevWq1kS1jWauBEQtC350+x/2
	Hkrw==
X-Gm-Message-State: APjAAAXx0sz5acmfo11VK5n+U9/l4CU0Jk9KxXXPColEcqJsivwgYOd+
	YdR0xkDFHOnThHGJGHi+IpaYDkC2lHGf760wAwU=
X-Google-Smtp-Source: APXvYqx31g1Zm8DaOc/3iSYih5IlzVXEuRp08m5MXoOyLobx7Rwt8wioD90G8ALl89G3NK0hxUqHcNyv/mJjDVzXSCw=
X-Received: by 2002:a2e:5b92:: with SMTP id m18mr3693928lje.115.1557432977652; 
	Thu, 09 May 2019 13:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-26-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-26-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 13:14:10 -0700
Message-ID: <CAKmqyKN1V8JoCr=L75DOv9ZaMOVxkgUei8Xz5Enjb-zHci3Xzg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v3 25/39] target/sh4: Use env_cpu,
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

On Tue, May 7, 2019 at 5:24 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/sh4/cpu.h          |  5 -----
>  linux-user/sh4/cpu_loop.c |  2 +-
>  target/sh4/helper.c       | 26 ++++++++++++--------------
>  target/sh4/op_helper.c    |  9 +++------
>  4 files changed, 16 insertions(+), 26 deletions(-)
>
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index c1a9e4f981..2ed942ca47 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -207,11 +207,6 @@ struct SuperHCPU {
>      CPUSH4State env;
>  };
>
> -static inline SuperHCPU *sh_env_get_cpu(CPUSH4State *env)
> -{
> -    return container_of(env, SuperHCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(SuperHCPU, env)
>
>  void superh_cpu_do_interrupt(CPUState *cpu);
> diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
> index 59cbbeda7e..add8817d86 100644
> --- a/linux-user/sh4/cpu_loop.c
> +++ b/linux-user/sh4/cpu_loop.c
> @@ -23,7 +23,7 @@
>
>  void cpu_loop(CPUSH4State *env)
>  {
> -    CPUState *cs =3D CPU(sh_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      int trapnr, ret;
>      target_siginfo_t info;
>
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index 2ff0cf4060..5240da715e 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -238,8 +238,6 @@ static void update_itlb_use(CPUSH4State * env, int it=
lbnb)
>
>  static int itlb_replacement(CPUSH4State * env)
>  {
> -    SuperHCPU *cpu =3D sh_env_get_cpu(env);
> -
>      if ((env->mmucr & 0xe0000000) =3D=3D 0xe0000000) {
>         return 0;
>      }
> @@ -252,7 +250,7 @@ static int itlb_replacement(CPUSH4State * env)
>      if ((env->mmucr & 0x2c000000) =3D=3D 0x00000000) {
>         return 3;
>      }
> -    cpu_abort(CPU(cpu), "Unhandled itlb_replacement");
> +    cpu_abort(env_cpu(env), "Unhandled itlb_replacement");
>  }
>
>  /* Find the corresponding entry in the right TLB
> @@ -308,7 +306,7 @@ static int copy_utlb_entry_itlb(CPUSH4State *env, int=
 utlb)
>      itlb =3D itlb_replacement(env);
>      ientry =3D &env->itlb[itlb];
>      if (ientry->v) {
> -        tlb_flush_page(CPU(sh_env_get_cpu(env)), ientry->vpn << 10);
> +        tlb_flush_page(env_cpu(env), ientry->vpn << 10);
>      }
>      *ientry =3D env->utlb[utlb];
>      update_itlb_use(env, itlb);
> @@ -533,14 +531,14 @@ hwaddr superh_cpu_get_phys_page_debug(CPUState *cs,=
 vaddr addr)
>
>  void cpu_load_tlb(CPUSH4State * env)
>  {
> -    SuperHCPU *cpu =3D sh_env_get_cpu(env);
> +    CPUState *cs =3D env_cpu(env);
>      int n =3D cpu_mmucr_urc(env->mmucr);
>      tlb_t * entry =3D &env->utlb[n];
>
>      if (entry->v) {
>          /* Overwriting valid entry in utlb. */
>          target_ulong address =3D entry->vpn << 10;
> -        tlb_flush_page(CPU(cpu), address);
> +        tlb_flush_page(cs, address);
>      }
>
>      /* Take values into cpu status from registers. */
> @@ -563,7 +561,7 @@ void cpu_load_tlb(CPUSH4State * env)
>          entry->size =3D 1024 * 1024; /* 1M */
>          break;
>      default:
> -        cpu_abort(CPU(cpu), "Unhandled load_tlb");
> +        cpu_abort(cs, "Unhandled load_tlb");
>          break;
>      }
>      entry->sh   =3D (uint8_t)cpu_ptel_sh(env->ptel);
> @@ -590,7 +588,7 @@ void cpu_load_tlb(CPUSH4State * env)
>          entry->v =3D 0;
>      }
>
> -    tlb_flush(CPU(sh_env_get_cpu(s)));
> +    tlb_flush(env_cpu(s));
>  }
>
>  uint32_t cpu_sh4_read_mmaped_itlb_addr(CPUSH4State *s,
> @@ -616,7 +614,7 @@ void cpu_sh4_write_mmaped_itlb_addr(CPUSH4State *s, h=
waddr addr,
>      if (entry->v) {
>          /* Overwriting valid entry in itlb. */
>          target_ulong address =3D entry->vpn << 10;
> -        tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
> +        tlb_flush_page(env_cpu(s), address);
>      }
>      entry->asid =3D asid;
>      entry->vpn =3D vpn;
> @@ -658,7 +656,7 @@ void cpu_sh4_write_mmaped_itlb_data(CPUSH4State *s, h=
waddr addr,
>          if (entry->v) {
>              /* Overwriting valid entry in utlb. */
>              target_ulong address =3D entry->vpn << 10;
> -            tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
> +            tlb_flush_page(env_cpu(s), address);
>          }
>          entry->ppn =3D (mem_value & 0x1ffffc00) >> 10;
>          entry->v   =3D (mem_value & 0x00000100) >> 8;
> @@ -711,7 +709,7 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, h=
waddr addr,
>              if (entry->vpn =3D=3D vpn
>                  && (!use_asid || entry->asid =3D=3D asid || entry->sh)) =
{
>                 if (utlb_match_entry) {
> -                    CPUState *cs =3D CPU(sh_env_get_cpu(s));
> +                    CPUState *cs =3D env_cpu(s);
>
>                     /* Multiple TLB Exception */
>                      cs->exception_index =3D 0x140;
> @@ -743,14 +741,14 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s,=
 hwaddr addr,
>         }
>
>          if (needs_tlb_flush) {
> -            tlb_flush_page(CPU(sh_env_get_cpu(s)), vpn << 10);
> +            tlb_flush_page(env_cpu(s), vpn << 10);
>          }
>
>      } else {
>          int index =3D (addr & 0x00003f00) >> 8;
>          tlb_t * entry =3D &s->utlb[index];
>         if (entry->v) {
> -            CPUState *cs =3D CPU(sh_env_get_cpu(s));
> +            CPUState *cs =3D env_cpu(s);
>
>             /* Overwriting valid entry in utlb. */
>              target_ulong address =3D entry->vpn << 10;
> @@ -805,7 +803,7 @@ void cpu_sh4_write_mmaped_utlb_data(CPUSH4State *s, h=
waddr addr,
>          if (entry->v) {
>              /* Overwriting valid entry in utlb. */
>              target_ulong address =3D entry->vpn << 10;
> -            tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
> +            tlb_flush_page(env_cpu(s), address);
>          }
>          entry->ppn =3D (mem_value & 0x1ffffc00) >> 10;
>          entry->v   =3D (mem_value & 0x00000100) >> 8;
> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
> index 12fba6fc78..11cb68cc1c 100644
> --- a/target/sh4/op_helper.c
> +++ b/target/sh4/op_helper.c
> @@ -58,10 +58,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int siz=
e,
>  void helper_ldtlb(CPUSH4State *env)
>  {
>  #ifdef CONFIG_USER_ONLY
> -    SuperHCPU *cpu =3D sh_env_get_cpu(env);
> -
> -    /* XXXXX */
> -    cpu_abort(CPU(cpu), "Unhandled ldtlb");
> +    cpu_abort(env_cpu(env), "Unhandled ldtlb");
>  #else
>      cpu_load_tlb(env);
>  #endif
> @@ -70,7 +67,7 @@ void helper_ldtlb(CPUSH4State *env)
>  static inline void QEMU_NORETURN raise_exception(CPUSH4State *env, int i=
ndex,
>                                                   uintptr_t retaddr)
>  {
> -    CPUState *cs =3D CPU(sh_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      cs->exception_index =3D index;
>      cpu_loop_exit_restore(cs, retaddr);
> @@ -103,7 +100,7 @@ void helper_debug(CPUSH4State *env)
>
>  void helper_sleep(CPUSH4State *env)
>  {
> -    CPUState *cs =3D CPU(sh_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      cs->halted =3D 1;
>      env->in_sleep =3D 1;
> --
> 2.17.1
>
>

