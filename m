Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0817C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE6620882
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6f1vCr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE6620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50063 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCoA-0003fH-Ao
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 17:11:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCnN-0002du-NC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCnM-0001Pc-CC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:11:09 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hPCnM-0001ON-0t
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:11:08 -0400
Received: by mail-lf1-x143.google.com with SMTP id n134so5080262lfn.11
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/TsjlCV7nKjVAO81o4XXTTUsPZ/gKrLiGkPWWVdur/I=;
	b=f6f1vCr1yXcj50GSi14jE4tl5tENH+hiFqn8d4Aicr3dcctucfRXdwY1LhsK4BPT2O
	dOVp2bCuxuRrySTfxEo35bS0hbIex+HdcoMWuyle8Ti21CaGtWek+B3J4+Z4RYMYSVPc
	u+NSMQFPu0vLCW9jQpkqjhZoVFwGmusry7hvLXE7RygtSNRZ8nCA8BeaQMlxMnI3Ebec
	oIINiQgiaG0Mwkfr/zjOTWIjbUR0g50gl+46HaYjoDlzGRQJKPPaxgblE4cpSAlm464Z
	tTq0tcT/wPBvXapFLaEQjNwftYMKq6DXi/7e3jJGCMoS9TYfzPK/PqEI0zUkW4XnAZJJ
	6dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/TsjlCV7nKjVAO81o4XXTTUsPZ/gKrLiGkPWWVdur/I=;
	b=dtP5wRndfDTZ6fo2JBv3RPPszeaC+6Uk7DUB8U+9/qjBabP4Ycwnn+ZJCad37NUVux
	6LH6UWrV6k+2eVtO+xHHYqGcIe1pU2aZ5d36ucs4aE4dc3pR6tQAKsi5dhVqbFLWY5eR
	rROfte4lLoUYh3aP7ow7E+Ze3hk9se8upI+JHj6zTNyBEEU18XSCherXClPfDNQ4PDbs
	zWGyqGSKH1/ofgI+Em30g9EnBvbs9SEfy8IOO5Z+eLLKxW05351y+XuRZOBFWMUQScDq
	I06WTDvDGMG1baeZnazubaGsSVV30JMzWXikx1857QddrotaZm2pUvDiRdrfr+5ii8WQ
	q7JA==
X-Gm-Message-State: APjAAAUHA6Tq6oWz+G/qVFN0aox/gWzyVcxIE2KOtCfx8E0ZLuEFcAvR
	FYG0Nni+sfmGFzGRvTlCIZt/xlZpb8f5j587Q9GKwomhpqE=
X-Google-Smtp-Source: APXvYqxZc5G1vSymxDtreWJUChH902GEmoSLDnXeRS40GMqLdlfUsIAm0pj5co4hHMyzBvS9dFAtyABmxy5QEi5QgAI=
X-Received: by 2002:ac2:4205:: with SMTP id y5mr6992029lfh.15.1557522666326;
	Fri, 10 May 2019 14:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-39-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-39-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 May 2019 14:08:58 -0700
Message-ID: <CAKmqyKN5BmdUwv92UzCVZzNQsykeFSq_TwTvb7h5Ld9UWBuyyw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v3 38/39] tcg/arm: Use LDRD to load tlb
 mask+table
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

On Tue, May 7, 2019 at 5:32 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This changes the code generation for the tlb from e.g.
>
>         ldr      ip, [r6, #-0x10]
>         ldr      r2, [r6, #-0xc]
>         and      ip, ip, r4, lsr #8
>         ldrd     r0, r1, [r2, ip]!
>         ldr      r2, [r2, #0x18]
>
> to
>
>         ldrd     r0, r1, [r6, #-0x10]
>         and      r0, r0, r4, lsr #8
>         ldrd     r2, r3, [r1, r0]!
>         ldr      r1, [r1, #0x18]
>
> for armv7 hosts.  Rearranging the register allocation in
> order to avoid overlap between the two ldrd pairs causes
> the patch to be larger than it ordinarily would be.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Add QEMU_BUILD_BUG_ON for mask/table ordering; comment fixes.
> ---
>  tcg/arm/tcg-target.inc.c | 92 +++++++++++++++++++++++-----------------
>  1 file changed, 53 insertions(+), 39 deletions(-)
>
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index ad32b04e13..ac813abfb8 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -267,6 +267,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
>          tcg_regset_reset_reg(ct->u.regs, TCG_REG_R0);
>          tcg_regset_reset_reg(ct->u.regs, TCG_REG_R1);
>          tcg_regset_reset_reg(ct->u.regs, TCG_REG_R2);
> +        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
>          tcg_regset_reset_reg(ct->u.regs, TCG_REG_R14);
>  #endif
>          break;
> @@ -1224,6 +1225,10 @@ static TCGReg tcg_out_arg_reg64(TCGContext *s, TCGReg argreg,
>  QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
>  QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -256);
>
> +/* These offsets are built into the LDRD below.  */
> +QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
> +QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
> +
>  /* Load and compare a TLB entry, leaving the flags set.  Returns the register
>     containing the addend of the tlb entry.  Clobbers R0, R1, R2, TMP.  */
>
> @@ -1238,47 +1243,54 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
>      unsigned s_bits = opc & MO_SIZE;
>      unsigned a_bits = get_alignment_bits(opc);
>
> -    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
> -    tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP, TCG_AREG0, mask_off);
> -    tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R2, TCG_AREG0, table_off);
> -
> -    /* Extract the tlb index from the address into TMP.  */
> -    tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_TMP, TCG_REG_TMP, addrlo,
> -                    SHIFT_IMM_LSR(TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS));
> -
>      /*
> -     * Add the tlb_table pointer, creating the CPUTLBEntry address in R2.
> -     * Load the tlb comparator into R0/R1 and the fast path addend into R2.
> +     * We don't support inline unaligned acceses, but we can easily
> +     * support overalignment checks.
>       */
> -    if (cmp_off == 0) {
> -       if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
> -            tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R0, TCG_REG_R2, TCG_REG_TMP);
> -        } else {
> -            tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R0, TCG_REG_R2, TCG_REG_TMP);
> -        }
> -    } else {
> -        tcg_out_dat_reg(s, COND_AL, ARITH_ADD,
> -                       TCG_REG_R2, TCG_REG_R2, TCG_REG_TMP, 0);
> -        if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
> -            tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_REG_R2, cmp_off);
> -        } else {
> -            tcg_out_ld32_12(s, COND_AL, TCG_REG_R0, TCG_REG_R2, cmp_off);
> -       }
> -    }
> -    if (!use_armv6_instructions && TARGET_LONG_BITS == 64) {
> -        tcg_out_ld32_12(s, COND_AL, TCG_REG_R1, TCG_REG_R2, cmp_off + 4);
> -    }
> -
> -    /* Load the tlb addend.  */
> -    tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R2,
> -                    offsetof(CPUTLBEntry, addend));
> -
> -    /* Check alignment.  We don't support inline unaligned acceses,
> -       but we can easily support overalignment checks.  */
>      if (a_bits < s_bits) {
>          a_bits = s_bits;
>      }
>
> +    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {r0,r1}.  */
> +    if (use_armv6_instructions) {
> +        tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
> +    } else {
> +        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R0, TCG_AREG0, mask_off);
> +        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R1, TCG_AREG0, table_off);
> +    }
> +
> +    /* Extract the tlb index from the address into R0.  */
> +    tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_R0, TCG_REG_R0, addrlo,
> +                    SHIFT_IMM_LSR(TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS));
> +
> +    /*
> +     * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
> +     * Load the tlb comparator into R2/R3 and the fast path addend into R1.
> +     */
> +    if (cmp_off == 0) {
> +        if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
> +            tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
> +        } else {
> +            tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
> +        }
> +    } else {
> +        tcg_out_dat_reg(s, COND_AL, ARITH_ADD,
> +                        TCG_REG_R1, TCG_REG_R1, TCG_REG_R0, 0);
> +        if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
> +            tcg_out_ldrd_8(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
> +        } else {
> +            tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
> +        }
> +    }
> +    if (!use_armv6_instructions && TARGET_LONG_BITS == 64) {
> +        tcg_out_ld32_12(s, COND_AL, TCG_REG_R3, TCG_REG_R1, cmp_off + 4);
> +    }
> +
> +    /* Load the tlb addend.  */
> +    tcg_out_ld32_12(s, COND_AL, TCG_REG_R1, TCG_REG_R1,
> +                    offsetof(CPUTLBEntry, addend));
> +
> +    /* Check alignment, check comparators.  */
>      if (use_armv7_instructions) {
>          tcg_target_ulong mask = ~(TARGET_PAGE_MASK | ((1 << a_bits) - 1));
>          int rot = encode_imm(mask);
> @@ -1291,22 +1303,24 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
>              tcg_out_dat_reg(s, COND_AL, ARITH_BIC, TCG_REG_TMP,
>                              addrlo, TCG_REG_TMP, 0);
>          }
> -        tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, TCG_REG_R0, TCG_REG_TMP, 0);
> +        tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, TCG_REG_R2, TCG_REG_TMP, 0);
>      } else {
>          if (a_bits) {
>              tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo,
>                              (1 << a_bits) - 1);
>          }
> +        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0, addrlo,
> +                        SHIFT_IMM_LSR(TARGET_PAGE_BITS));
>          tcg_out_dat_reg(s, (a_bits ? COND_EQ : COND_AL), ARITH_CMP,
> -                        0, TCG_REG_R0, TCG_REG_TMP,
> +                        0, TCG_REG_R2, TCG_REG_TMP,
>                          SHIFT_IMM_LSL(TARGET_PAGE_BITS));
>      }
>
>      if (TARGET_LONG_BITS == 64) {
> -        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R1, addrhi, 0);
> +        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R3, addrhi, 0);

This is complex and I'm probably misunderstanding something but isn't
it possible for TCG_REG_R3 to not be set if use_armv6_instructions is
true and TARGET_LONG_BITS is 64?

Alistair

>      }
>
> -    return TCG_REG_R2;
> +    return TCG_REG_R1;
>  }
>
>  /* Record the context of a call to the out of line helper code for the slow
> --
> 2.17.1
>
>

