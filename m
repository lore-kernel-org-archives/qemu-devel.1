Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D498EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6262084A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfYvCPx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6262084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOpYq-0002BP-NB
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:22:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpWT-0008Tq-H8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpWR-0000FA-RC
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:20:09 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOpWR-0000E7-GP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:20:07 -0400
Received: by mail-lj1-x242.google.com with SMTP id 14so3153666ljj.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=kfiOuFrU0ZZ9u3k/uowoOH/A1MPUvYoz5U9GOfrlfQM=;
	b=nfYvCPx6lnnKN710BplZkR3wV5bPo/tU31WaOnqhP8thM1tyrcalI/L1rjb+Ze0yb7
	/JK2l+yXgjDJtZOkuzinc4Vr+hEOrE38YuFrf3bK0T+Ce2ldfYpZfw1h65fMGNt8lG43
	7H0dfs6wVzsHr7c8NpBRjaM2r0CJn0dcm3xSJK93ow/47TpeheepUIDbcW1wtsaWe0FH
	q6JHNRDrNEpRv40pQ3nBeGODco/AjBqUqz2kpQ+UR3Jzr9fiJyxcgnopO/YHqOeQUFCu
	maSOfvkKlQ0XbLYspEUsQ8WcYPPyZoM6uaLbX6r/1/EL5SVQKCQFwmMR0N98Oy9rX9MS
	hW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=kfiOuFrU0ZZ9u3k/uowoOH/A1MPUvYoz5U9GOfrlfQM=;
	b=pOA90/+kYoSJwb8G4q7WK37ctklnGfXkuqrI0W68Dye1qthIGEIzhzaDJX+uiUIk3k
	QZcQBjbnRzRybH0XLrZ3AQzurNyCZqYn4RaCeJmQbaZGbH8G6kV1cmFMoWY7agoKeNjO
	7UtDh7I2sZ7xW8e77P4LaDle2/2mjXaCZ/Ltl4aa0hLxuj6RvaGRGfTgG5IiRn//UMOK
	+JQY/6RgJtUu1QZv6t72j27zCYKVzbbYZF9dWe8Ajknrx4JGODJYStkmegDk3nCt9yFg
	gXGdhdUiApFkhTopkdYS3EJRgaLgbXDLwbWwCw6wAdXBuDNzkrvpFklaCiibHTcW23eI
	a82Q==
X-Gm-Message-State: APjAAAVKgvThf+eOgHGeF+Y8XTPBHR3YgysNKmZq6HkZfSzbV+Med6CJ
	/dUHbQPSP0Csab3VP3QpbXOOhQsX05NJCGcyZyM=
X-Google-Smtp-Source: APXvYqyAbVTBcOjoBJu2WqRF9bOjkhbOaM/npUwLY2vA2cqjlQ9Ce2NNX7jO9e+VUfLQt4JDv5VjpwVR81v4SbLWIF0=
X-Received: by 2002:a2e:8709:: with SMTP id m9mr3505339lji.140.1557433205584; 
	Thu, 09 May 2019 13:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-30-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-30-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 13:17:58 -0700
Message-ID: <CAKmqyKNTk_UQgYqfiQ9He10EdQfGMeZ-gNq8TjpiNqWCq3Dddw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3 29/39] target/unicore32: Use env_cpu,
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

On Tue, May 7, 2019 at 5:30 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/unicore32/cpu.h          |  5 -----
>  hw/unicore32/puv3.c             |  2 +-
>  target/unicore32/helper.c       |  8 ++------
>  target/unicore32/op_helper.c    |  2 +-
>  target/unicore32/softmmu.c      | 11 ++++-------
>  target/unicore32/translate.c    | 26 ++------------------------
>  target/unicore32/ucf64_helper.c |  2 +-
>  7 files changed, 11 insertions(+), 45 deletions(-)
>
> diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
> index 22e22345dc..2dd1b34765 100644
> --- a/target/unicore32/cpu.h
> +++ b/target/unicore32/cpu.h
> @@ -76,11 +76,6 @@ struct UniCore32CPU {
>      CPUUniCore32State env;
>  };
>
> -static inline UniCore32CPU *uc32_env_get_cpu(CPUUniCore32State *env)
> -{
> -    return container_of(env, UniCore32CPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(UniCore32CPU, env)
>
>  void uc32_cpu_do_interrupt(CPUState *cpu);
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index b42e600f74..132e6086ee 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -56,7 +56,7 @@ static void puv3_soc_init(CPUUniCore32State *env)
>
>      /* Initialize interrupt controller */
>      cpu_intc = qemu_allocate_irq(puv3_intc_cpu_handler,
> -                                 uc32_env_get_cpu(env), 0);
> +                                 env_archcpu(env), 0);
>      dev = sysbus_create_simple("puv3_intc", PUV3_INTC_BASE, cpu_intc);
>      for (i = 0; i < PUV3_IRQS_NR; i++) {
>          irqs[i] = qdev_get_gpio_in(dev, i);
> diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
> index a5ff2ddb74..19ba865482 100644
> --- a/target/unicore32/helper.c
> +++ b/target/unicore32/helper.c
> @@ -31,8 +31,6 @@
>  void helper_cp0_set(CPUUniCore32State *env, uint32_t val, uint32_t creg,
>          uint32_t cop)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
> -
>      /*
>       * movc pp.nn, rn, #imm9
>       *      rn: UCOP_REG_D
> @@ -101,7 +99,7 @@ void helper_cp0_set(CPUUniCore32State *env, uint32_t val, uint32_t creg,
>      case 6:
>          if ((cop <= 6) && (cop >= 2)) {
>              /* invalid all tlb */
> -            tlb_flush(CPU(cpu));
> +            tlb_flush(env_cpu(env));
>              return;
>          }
>          break;
> @@ -218,10 +216,8 @@ void helper_cp1_putc(target_ulong x)
>  #ifdef CONFIG_USER_ONLY
>  void switch_mode(CPUUniCore32State *env, int mode)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
> -
>      if (mode != ASR_MODE_USER) {
> -        cpu_abort(CPU(cpu), "Tried to switch out of user mode\n");
> +        cpu_abort(env_cpu(env), "Tried to switch out of user mode\n");
>      }
>  }
>
> diff --git a/target/unicore32/op_helper.c b/target/unicore32/op_helper.c
> index e0a15882d3..44ff84420e 100644
> --- a/target/unicore32/op_helper.c
> +++ b/target/unicore32/op_helper.c
> @@ -19,7 +19,7 @@
>
>  void HELPER(exception)(CPUUniCore32State *env, uint32_t excp)
>  {
> -    CPUState *cs = CPU(uc32_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = excp;
>      cpu_loop_exit(cs);
> diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
> index 00c7e0d028..2f31592faf 100644
> --- a/target/unicore32/softmmu.c
> +++ b/target/unicore32/softmmu.c
> @@ -36,8 +36,6 @@
>  /* Map CPU modes onto saved register banks.  */
>  static inline int bank_number(CPUUniCore32State *env, int mode)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
> -
>      switch (mode) {
>      case ASR_MODE_USER:
>      case ASR_MODE_SUSR:
> @@ -51,7 +49,7 @@ static inline int bank_number(CPUUniCore32State *env, int mode)
>      case ASR_MODE_INTR:
>          return 4;
>      }
> -    cpu_abort(CPU(cpu), "Bad mode %x\n", mode);
> +    cpu_abort(env_cpu(env), "Bad mode %x\n", mode);
>      return -1;
>  }
>
> @@ -126,8 +124,7 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
>          int access_type, int is_user, uint32_t *phys_ptr, int *prot,
>          target_ulong *page_size)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>      int code;
>      uint32_t table;
>      uint32_t desc;
> @@ -174,11 +171,11 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
>              *page_size = TARGET_PAGE_SIZE;
>              break;
>          default:
> -            cpu_abort(CPU(cpu), "wrong page type!");
> +            cpu_abort(cs, "wrong page type!");
>          }
>          break;
>      default:
> -        cpu_abort(CPU(cpu), "wrong page type!");
> +        cpu_abort(cs, "wrong page type!");
>      }
>
>      *phys_ptr = phys_addr;
> diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
> index 89b02d1c3c..d27451eed3 100644
> --- a/target/unicore32/translate.c
> +++ b/target/unicore32/translate.c
> @@ -180,7 +180,7 @@ static void store_reg(DisasContext *s, int reg, TCGv var)
>  #define UCOP_SET_L              UCOP_SET(24)
>  #define UCOP_SET_S              UCOP_SET(24)
>
> -#define ILLEGAL         cpu_abort(CPU(cpu),                             \
> +#define ILLEGAL         cpu_abort(env_cpu(env),                         \
>                          "Illegal UniCore32 instruction %x at line %d!", \
>                          insn, __LINE__)
>
> @@ -188,7 +188,6 @@ static void store_reg(DisasContext *s, int reg, TCGv var)
>  static void disas_cp0_insn(CPUUniCore32State *env, DisasContext *s,
>          uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      TCGv tmp, tmp2, tmp3;
>      if ((insn & 0xfe000000) == 0xe0000000) {
>          tmp2 = new_tmp();
> @@ -214,7 +213,6 @@ static void disas_cp0_insn(CPUUniCore32State *env, DisasContext *s,
>  static void disas_ocd_insn(CPUUniCore32State *env, DisasContext *s,
>          uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      TCGv tmp;
>
>      if ((insn & 0xff003fff) == 0xe1000400) {
> @@ -682,7 +680,6 @@ static inline long ucf64_reg_offset(int reg)
>  /* UniCore-F64 single load/store I_offset */
>  static void do_ucf64_ldst_i(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      int offset;
>      TCGv tmp;
>      TCGv addr;
> @@ -729,7 +726,6 @@ static void do_ucf64_ldst_i(CPUUniCore32State *env, DisasContext *s, uint32_t in
>  /* UniCore-F64 load/store multiple words */
>  static void do_ucf64_ldst_m(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      unsigned int i;
>      int j, n, freg;
>      TCGv tmp;
> @@ -815,7 +811,6 @@ static void do_ucf64_ldst_m(CPUUniCore32State *env, DisasContext *s, uint32_t in
>  /* UniCore-F64 mrc/mcr */
>  static void do_ucf64_trans(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      TCGv tmp;
>
>      if ((insn & 0xfe0003ff) == 0xe2000000) {
> @@ -880,8 +875,6 @@ static void do_ucf64_trans(CPUUniCore32State *env, DisasContext *s, uint32_t ins
>  /* UniCore-F64 convert instructions */
>  static void do_ucf64_fcvt(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
> -
>      if (UCOP_UCF64_FMT == 3) {
>          ILLEGAL;
>      }
> @@ -948,8 +941,6 @@ static void do_ucf64_fcvt(CPUUniCore32State *env, DisasContext *s, uint32_t insn
>  /* UniCore-F64 compare instructions */
>  static void do_ucf64_fcmp(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
> -
>      if (UCOP_SET(25)) {
>          ILLEGAL;
>      }
> @@ -1028,8 +1019,6 @@ static void do_ucf64_fcmp(CPUUniCore32State *env, DisasContext *s, uint32_t insn
>  /* UniCore-F64 data processing */
>  static void do_ucf64_datap(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
> -
>      if (UCOP_UCF64_FMT == 3) {
>          ILLEGAL;
>      }
> @@ -1063,8 +1052,6 @@ static void do_ucf64_datap(CPUUniCore32State *env, DisasContext *s, uint32_t ins
>  /* Disassemble an F64 instruction */
>  static void disas_ucf64_insn(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
> -
>      if (!UCOP_SET(29)) {
>          if (UCOP_SET(26)) {
>              do_ucf64_ldst_m(env, s, insn);
> @@ -1162,8 +1149,6 @@ static void gen_exception_return(DisasContext *s, TCGv pc)
>  static void disas_coproc_insn(CPUUniCore32State *env, DisasContext *s,
>          uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
> -
>      switch (UCOP_CPNUM) {
>  #ifndef CONFIG_USER_ONLY
>      case 0:
> @@ -1178,14 +1163,13 @@ static void disas_coproc_insn(CPUUniCore32State *env, DisasContext *s,
>          break;
>      default:
>          /* Unknown coprocessor. */
> -        cpu_abort(CPU(cpu), "Unknown coprocessor!");
> +        cpu_abort(env_cpu(env), "Unknown coprocessor!");
>      }
>  }
>
>  /* data processing instructions */
>  static void do_datap(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      TCGv tmp;
>      TCGv tmp2;
>      int logic_cc;
> @@ -1419,7 +1403,6 @@ static void do_mult(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  /* miscellaneous instructions */
>  static void do_misc(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      unsigned int val;
>      TCGv tmp;
>
> @@ -1545,7 +1528,6 @@ static void do_ldst_ir(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  /* SWP instruction */
>  static void do_swap(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      TCGv addr;
>      TCGv tmp;
>      TCGv tmp2;
> @@ -1573,7 +1555,6 @@ static void do_swap(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  /* load/store hw/sb */
>  static void do_ldst_hwsb(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      TCGv addr;
>      TCGv tmp;
>
> @@ -1626,7 +1607,6 @@ static void do_ldst_hwsb(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  /* load/store multiple words */
>  static void do_ldst_m(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      unsigned int val, i, mmu_idx;
>      int j, n, reg, user, loaded_base;
>      TCGv tmp;
> @@ -1768,7 +1748,6 @@ static void do_ldst_m(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  /* branch (and link) */
>  static void do_branch(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      unsigned int val;
>      int32_t offset;
>      TCGv tmp;
> @@ -1798,7 +1777,6 @@ static void do_branch(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
>
>  static void disas_uc32_insn(CPUUniCore32State *env, DisasContext *s)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
>      unsigned int insn;
>
>      insn = cpu_ldl_code(env, s->pc);
> diff --git a/target/unicore32/ucf64_helper.c b/target/unicore32/ucf64_helper.c
> index fad3fa6618..e078e84437 100644
> --- a/target/unicore32/ucf64_helper.c
> +++ b/target/unicore32/ucf64_helper.c
> @@ -78,7 +78,7 @@ static inline int ucf64_exceptbits_to_host(int target_bits)
>
>  void HELPER(ucf64_set_fpscr)(CPUUniCore32State *env, uint32_t val)
>  {
> -    UniCore32CPU *cpu = uc32_env_get_cpu(env);
> +    UniCore32CPU *cpu = env_archcpu(env);
>      int i;
>      uint32_t changed;
>
> --
> 2.17.1
>
>

