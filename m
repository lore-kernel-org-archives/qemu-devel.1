Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB16C46486
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A8221852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGR+ECs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A8221852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj3r1-0003Bv-7R
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 11:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40034)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hj3pj-00026v-53
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hj3ph-0006cp-IZ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:39:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hj3ph-0006aa-9s
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:39:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so7116522wrs.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9MnL5cheB9+5pL1sWlszx4ycg3+IZNVj4jNi8PkEipw=;
 b=iGR+ECs8ZJiNzhRNXoL7+RV4IoQDz4JO781EuA34y3T8Aa4j2NI9k36AapmbCAjMlK
 ZxzhHzFAgzSt5XSgJ1To7QJ5IOEJ/GPqyJm3TlznRhgDcEySFRUQAn4k8i53stoxjOk/
 WhhVSPaJKQh0mhLWJqJdN/HzVeiDGz0/1A81SHCeu4H1jD7wbNUxToECtKh7c/i5MNXa
 TEns6huGvXkq++DW8MQMa92gn29xpso1ZFJxWBqj0gCMlmWevhYjmd3YfSIYpbTS5aZ1
 bCe3h4xAj8dtxgW/hn736WSgEyj0xjWMvkYa6XierzSn/dbK8kI97qv5DVJ5FuaI+o8F
 /kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9MnL5cheB9+5pL1sWlszx4ycg3+IZNVj4jNi8PkEipw=;
 b=QwQOJW36ZgNkkT5q5hs5qGd0eJVg+ZAJjKeX54XA+DLTeNsi2UCuWJdBwpR4rljCQT
 +e8KgFRtrjKQHmDmlS8sPafBMzLspzVG9xv9G7AKvAwaYgO8ixA4NlTxlwmXjOtljhVu
 U0zaB/eM9+qdrHU9X+ivytQDwItSmeSbfF4bPu6lqY02pnGVwCjRXcl0DhE/tIAcGSOb
 BbucJURg+qvDWM2LdXMK97rAIoXB6NyR4y8n8f05CGyJwQO+W/HLl4Qs96IrzSAcdpBx
 6suo6Apwfw0OyHbuXL7tk/p6LG6KBDoUuRCbSbF1WBrWYHpZQc5mzphQUXZnIWleyXFr
 qNKA==
X-Gm-Message-State: APjAAAU01rYMJKeO6Vq3h9NCqdDrHUvkb9rAo3oDegu+sYCva0dMiir1
 QyCdSDssqkWM4tQ180FB7cNUtw==
X-Google-Smtp-Source: APXvYqwgZW25sBUV94adMj79+tLOsQ43i1RyU18MBpPOjOC4iYkxJ3Cm1L32ju5sLbz76MQpsKa4UQ==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr2859940wrq.81.1562254775535; 
 Thu, 04 Jul 2019 08:39:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j189sm5489260wmb.48.2019.07.04.08.39.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 08:39:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34E9D1FF87;
 Thu,  4 Jul 2019 16:39:34 +0100 (BST)
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
 <20190702210017.4275-3-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190702210017.4275-3-vandersonmr2@gmail.com>
Date: Thu, 04 Jul 2019 16:39:34 +0100
Message-ID: <877e8xx0zt.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 3/6] accel/tcg: Collecting
 translation/code quality measurements
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> Filling other tb statistics such as number of times the
> tb is compiled, its number of guest/host/IR instructions...
>
> Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
> ---
>  accel/tcg/translate-all.c |  14 +++++
>  accel/tcg/translator.c    |   4 ++
>  disas.c                   | 107 ++++++++++++++++++++++++++++++++++++++
>  include/disas/disas.h     |   1 +
>  tcg/tcg.c                 |   8 +++
>  5 files changed, 134 insertions(+)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index d05803a142..9ee7232bb8 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1865,6 +1865,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      atomic_set(&prof->search_out_len, prof->search_out_len + search_size=
);
>  #endif
>
> +    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) &&
> qemu_log_in_addr_range(tb->pc)) {

This should be a different flag - CPU_LOG_JIT_STATS? Also enable on the
TBstats creation and check the per-TB flag (tb_stats_enabled(tb,
JIT_STATS)).

> +        size_t code_size =3D gen_code_size;
> +        if (tcg_ctx->data_gen_ptr) {
> +            code_size =3D tcg_ctx->data_gen_ptr - tb->tc.ptr;
> +        }
> +        qemu_log_lock();

Wrong lock, and not needed if you are using atomics. If you did want a
lock you can move get_num_insts out of the lock as it doesn't need
protection and reduce the contention on the lock.

> +        atomic_set(&tb->tb_stats->code.num_host_inst,
> +                    get_num_insts(tb->tc.ptr, code_size));

atomic_add and then later when we present the data / by the number of trans=
lations?

> +        qemu_log_unlock();
> +    }
> +
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
>          qemu_log_in_addr_range(tb->pc)) {
> @@ -1922,6 +1933,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      phys_page2 =3D -1;
>      if ((pc & TARGET_PAGE_MASK) !=3D virt_page2) {
>          phys_page2 =3D get_page_addr_code(env, virt_page2);
> +        if (tb->tb_stats) {
> +            atomic_inc(&tb->tb_stats->translations.spanning);
> +        }
>      }
>      /*
>       * No explicit memory barrier is required -- tb_link_page() makes the
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index cc06070e7e..d2529ca97d 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -117,6 +117,10 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
>      db->tb->size =3D db->pc_next - db->pc_first;
>      db->tb->icount =3D db->num_insns;
>
> +    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) && qemu_log_in_addr_range(tb=
->pc)) {
> +        db->tb->tb_stats->code.num_guest_inst =3D db->num_insns;
> +    }

Leave the in_addr range check to the TBStats creation, use
tb_stats_enabled(tb, JIT_STATS).

> +
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>          && qemu_log_in_addr_range(db->pc_first)) {
> diff --git a/disas.c b/disas.c
> index 3e2bfa572b..f5ae9c009a 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -475,6 +475,113 @@ void target_disas(FILE *out, CPUState *cpu, target_=
ulong code,
>      }
>  }
>
> +
> +static int fprintf_fake(struct _IO_FILE *a, const char *b, ...)
> +{
> +    return 1;
> +}
> +
> +/*
> + * This is a work around to get the number of host instructions with
> + * a small effort. It reuses the disas function with a fake printf to
> + * print nothing but count the number of instructions.
> + *
> + */
> +unsigned get_num_insts(void *code, unsigned long size)
> +{
> +    uintptr_t pc;
> +    int count;
> +    CPUDebug s;
> +    int (*print_insn)(bfd_vma pc, disassemble_info *info) =3D NULL;
> +
> +    INIT_DISASSEMBLE_INFO(s.info, NULL, fprintf_fake);
> +    s.info.print_address_func =3D generic_print_host_address;
> +
> +    s.info.buffer =3D code;
> +    s.info.buffer_vma =3D (uintptr_t)code;
> +    s.info.buffer_length =3D size;
> +    s.info.cap_arch =3D -1;
> +    s.info.cap_mode =3D 0;
> +    s.info.cap_insn_unit =3D 4;
> +    s.info.cap_insn_split =3D 4;
> +
> +#ifdef HOST_WORDS_BIGENDIAN
> +    s.info.endian =3D BFD_ENDIAN_BIG;
> +#else
> +    s.info.endian =3D BFD_ENDIAN_LITTLE;
> +#endif
> +#if defined(CONFIG_TCG_INTERPRETER)
> +    print_insn =3D print_insn_tci;
> +#elif defined(__i386__)
> +    s.info.mach =3D bfd_mach_i386_i386;
> +    print_insn =3D print_insn_i386;
> +    s.info.cap_arch =3D CS_ARCH_X86;
> +    s.info.cap_mode =3D CS_MODE_32;
> +    s.info.cap_insn_unit =3D 1;
> +    s.info.cap_insn_split =3D 8;
> +#elif defined(__x86_64__)
> +    s.info.mach =3D bfd_mach_x86_64;
> +    print_insn =3D print_insn_i386;
> +    s.info.cap_arch =3D CS_ARCH_X86;
> +    s.info.cap_mode =3D CS_MODE_64;
> +    s.info.cap_insn_unit =3D 1;
> +    s.info.cap_insn_split =3D 8;
> +#elif defined(_ARCH_PPC)
> +    s.info.disassembler_options =3D (char *)"any";
> +    print_insn =3D print_insn_ppc;
> +    s.info.cap_arch =3D CS_ARCH_PPC;
> +# ifdef _ARCH_PPC64
> +    s.info.cap_mode =3D CS_MODE_64;
> +# endif
> +#elif defined(__riscv) && defined(CONFIG_RISCV_DIS)
> +#if defined(_ILP32) || (__riscv_xlen =3D=3D 32)
> +    print_insn =3D print_insn_riscv32;
> +#elif defined(_LP64)
> +    print_insn =3D print_insn_riscv64;
> +#else
> +#error unsupported RISC-V ABI
> +#endif
> +#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
> +    print_insn =3D print_insn_arm_a64;
> +    s.info.cap_arch =3D CS_ARCH_ARM64;
> +#elif defined(__alpha__)
> +    print_insn =3D print_insn_alpha;
> +#elif defined(__sparc__)
> +    print_insn =3D print_insn_sparc;
> +    s.info.mach =3D bfd_mach_sparc_v9b;
> +#elif defined(__arm__)
> +    print_insn =3D print_insn_arm;
> +    s.info.cap_arch =3D CS_ARCH_ARM;
> +    /* TCG only generates code for arm mode.  */
> +#elif defined(__MIPSEB__)
> +    print_insn =3D print_insn_big_mips;
> +#elif defined(__MIPSEL__)
> +    print_insn =3D print_insn_little_mips;
> +#elif defined(__m68k__)
> +    print_insn =3D print_insn_m68k;
> +#elif defined(__s390__)
> +    print_insn =3D print_insn_s390;
> +#elif defined(__hppa__)
> +    print_insn =3D print_insn_hppa;
> +#endif
> +
> +    if (print_insn =3D=3D NULL) {
> +        print_insn =3D print_insn_od_host;
> +    }

I feel the above should probably be wrapped in a function and called
from the various disas functions to initialise the data. DRY.

> +
> +    s.info.fprintf_func =3D fprintf_fake;
> +    unsigned num_insts =3D 0;
> +    for (pc =3D (uintptr_t)code; size > 0; pc +=3D count, size -=3D coun=
t) {
> +        num_insts++;
> +        count =3D print_insn(pc, &s.info);
> +        if (count < 0) {
> +            break;
> +        }
> +    }
> +    return num_insts;
> +}
> +
> +
>  /* Disassemble this for me please... (debugging). */
>  void disas(FILE *out, void *code, unsigned long size)
>  {
> diff --git a/include/disas/disas.h b/include/disas/disas.h
> index 15da511f49..9797ae7cfa 100644
> --- a/include/disas/disas.h
> +++ b/include/disas/disas.h
> @@ -7,6 +7,7 @@
>
>  /* Disassemble this for me please... (debugging). */
>  void disas(FILE *out, void *code, unsigned long size);
> +unsigned get_num_insts(void *code, unsigned long size);
>  void target_disas(FILE *out, CPUState *cpu, target_ulong code,
>                    target_ulong size);
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 02a2680169..bd57bb642b 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4072,6 +4072,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *=
tb)
>      atomic_set(&prof->la_time, prof->la_time + profile_getclock());
>  #endif
>
> +    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) &&
> qemu_log_in_addr_range(tb->pc)) {

local tb flag check

> +        int n =3D 0;
> +        QTAILQ_FOREACH(op, &s->ops, link) {
> +            n++;
> +        }
> +        tb->tb_stats->code.num_tcg_inst =3D n;

atomic_add and maybe num_tcg_ops? It would probably be worth checking
the op count before and after optimisation.

> +    }
> +
>  #ifdef DEBUG_DISAS
>      if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
>                   && qemu_log_in_addr_range(tb->pc))) {


--
Alex Benn=C3=A9e

