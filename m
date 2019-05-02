Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E4DC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6FC206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3s7LkR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6FC206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48399 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM8GL-0007T4-UE
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 05:44:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM8Fd-00079y-13
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM8FY-0003eZ-BY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:43:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hM8FV-0003Kg-TW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:43:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id f7so2415082wrs.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:subject:in-reply-to:date:message-id
	:mime-version:content-transfer-encoding;
	bh=XRBlt+4inYH/0rSaUqt0ddg65tKLPpJYxDNU8NCr5BE=;
	b=T3s7LkR5JVOupeEIEBpqABZXC/WahP8dmGYqlBQYPQ2P7Djd5XDiKo/+KA/yotfjOA
	gjz/JWxFdKoCyPDY0Dvu0Dprk7AIJKvIKonx1f2a2bKYz4OpEIkpX/54tSj6Sd4qOtfJ
	gd3SFbH8A6HhLG0L/1k5TLjf3wTX/XD49FfaMlrNQHR0IgR6tYpwI/hLo35MMLzZTiqc
	g3ykBW7T6PLdyMACMywzxT2qvBdVRo69TokH+ymfxZWyHEPDxV3uD2DR+umRZRdbgCkM
	ikFX2Vb3p7U7klINXm+gpW5tawvTey0qPVpjw69bjI0T8p2XXRtNwdi3ed+QfKS5b5jy
	2xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=XRBlt+4inYH/0rSaUqt0ddg65tKLPpJYxDNU8NCr5BE=;
	b=nqKN482SV+8rX879++EQ0le1SMiUVe3nV5r1EaJVSsw20Wrb/Ie5zbwlJtEMHu20iI
	9gVOHRTfKRpKql0RuZbWvYNo7dVWByNvXmUaHRiOO9R+/Q16uRf94yDq8KqxWcH7r1cC
	zBjrktm5MbRpuFKNlZCVphtSQUGr0127uWUqtnMUOqtsar6JTETOVibGdWyGbnxnUJES
	YFpwO7hfJ83F/REWxQdtCBBq5Qqwy30/+sDf41LmDvQjts8WZMb2hEEhoQK6vcAa+GZz
	0jzRVvp/JXTGhc0IlGYCtgb9f0v1mCw84Zepbw6FXbE8gpLZ2G5TjOnAIqPNMSQkYa5+
	4MEA==
X-Gm-Message-State: APjAAAXpOwPa0xIsb7H8gJiM+XyOoqmgadPiKZkJM2lXG4O1wGHdvbJi
	zbg9ZtQZ/4AbPBDF5xNy41Wy0bSncgA=
X-Google-Smtp-Source: APXvYqy4M8IgnSM7Wd2blk1WUe9GEyA5mELcgsYALVGLi/Y726kv9dga51nAy9vhIR3ZuD50GOV83w==
X-Received: by 2002:adf:9301:: with SMTP id 1mr2075586wro.231.1556790156569;
	Thu, 02 May 2019 02:42:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s18sm6484964wmc.41.2019.05.02.02.42.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 02:42:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 934BA1FF87
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 10:42:35 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-10-richard.henderson@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190501050536.15580-10-richard.henderson@linaro.org>
Date: Thu, 02 May 2019 10:42:35 +0100
Message-ID: <87imut5h10.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: Re: [Qemu-devel] [PATCH v2 09/29] tcg: Manually expand
 INDEX_op_dup_vec
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
Message-ID: <20190502094235.ohUKSnVqJq92xSqB3IuLo_ss6jH3KrQT0SWFXYnsDyI@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> This case is similar to INDEX_op_mov_* in that we need to do
> different things depending on the current location of the source.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
<snip>
>
> +static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
> +{
> +    const TCGLifeData arg_life =3D op->life;
> +    TCGRegSet dup_out_regs, dup_in_regs;
> +    TCGTemp *its, *ots;
> +    TCGType itype, vtype;
> +    unsigned vece;
> +    bool ok;
> +
> +    ots =3D arg_temp(op->args[0]);
> +    its =3D arg_temp(op->args[1]);
> +
> +    /* There should be no fixed vector registers.  */
> +    tcg_debug_assert(!ots->fixed_reg);

This threw me slightly. I guess you only really duplicate vectors so I'm
wondering if this should be called tcg_vec_reg_alloc_dup? Or maybe just
a bit of verbiage in a block comment above the helper?

> +
> +    itype =3D its->type;
> +    vece =3D TCGOP_VECE(op);
> +    vtype =3D TCGOP_VECL(op) + TCG_TYPE_V64;
> +
> +    if (its->val_type =3D=3D TEMP_VAL_CONST) {
> +        /* Propagate constant via movi -> dupi.  */
> +        tcg_target_ulong val =3D its->val;
> +        if (IS_DEAD_ARG(1)) {
> +            temp_dead(s, its);
> +        }
> +        tcg_reg_alloc_do_movi(s, ots, val, arg_life, op->output_pref[0]);
> +        return;
> +    }
> +
> +    dup_out_regs =3D tcg_op_defs[INDEX_op_dup_vec].args_ct[0].u.regs;
> +    dup_in_regs =3D tcg_op_defs[INDEX_op_dup_vec].args_ct[1].u.regs;
> +
> +    /* Allocate the output register now.  */
> +    if (ots->val_type !=3D TEMP_VAL_REG) {
> +        TCGRegSet allocated_regs =3D s->reserved_regs;
> +
> +        if (!IS_DEAD_ARG(1) && its->val_type =3D=3D TEMP_VAL_REG) {
> +            /* Make sure to not spill the input register. */
> +            tcg_regset_set_reg(allocated_regs, its->reg);
> +        }
> +        ots->reg =3D tcg_reg_alloc(s, dup_out_regs, allocated_regs,
> +                                 op->output_pref[0], ots->indirect_base);
> +        ots->val_type =3D TEMP_VAL_REG;
> +        ots->mem_coherent =3D 0;
> +        s->reg_to_temp[ots->reg] =3D ots;
> +    }
> +
> +    switch (its->val_type) {
> +    case TEMP_VAL_REG:
> +        /*
> +         * The dup constriaints must be broad, covering all possible VEC=
E.
> +         * However, tcg_op_dup_vec() gets to see the VECE and we allow it
> +         * to fail, indicating that extra moves are required for that ca=
se.
> +         */
> +        if (tcg_regset_test_reg(dup_in_regs, its->reg)) {
> +            if (tcg_out_dup_vec(s, vtype, vece, ots->reg, its->reg)) {
> +                goto done;
> +            }
> +            /* Try again from memory or a vector input register.  */
> +        }
> +        if (!its->mem_coherent) {
> +            /*
> +             * The input register is not synced, and so an extra store
> +             * would be required to use memory.  Attempt an integer-vect=
or
> +             * register move first.  We do not have a TCGRegSet for this.
> +             */
> +            if (tcg_out_mov(s, itype, ots->reg, its->reg)) {
> +                break;
> +            }
> +            /* Sync the temp back to its slot and load from there.  */
> +            temp_sync(s, its, s->reserved_regs, 0, 0);
> +        }
> +        /* fall through */
> +
> +    case TEMP_VAL_MEM:
> +        /* TODO: dup from memory */
> +        tcg_out_ld(s, itype, ots->reg, its->mem_base->reg,
> its->mem_offset);

Should we be aborting here? That said it looks like you are loading
something directly from the register memory address here...

> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /* We now have a vector input register, so dup must succeed. */
> +    ok =3D tcg_out_dup_vec(s, vtype, vece, ots->reg, ots->reg);
> +    tcg_debug_assert(ok);
> +
> + done:
> +    if (IS_DEAD_ARG(1)) {
> +        temp_dead(s, its);
> +    }
> +    if (NEED_SYNC_ARG(0)) {
> +        temp_sync(s, ots, s->reserved_regs, 0, 0);
> +    }
> +    if (IS_DEAD_ARG(0)) {
> +        temp_dead(s, ots);
> +    }
> +}
> +
>  static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>  {
>      const TCGLifeData arg_life =3D op->life;
> @@ -3981,6 +4080,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *t=
b)
>          case INDEX_op_dupi_vec:
>              tcg_reg_alloc_movi(s, op);
>              break;
> +        case INDEX_op_dup_vec:
> +            tcg_reg_alloc_dup(s, op);
> +            break;
>          case INDEX_op_insn_start:
>              if (num_insns >=3D 0) {
>                  size_t off =3D tcg_current_code_size(s);


--
Alex Benn=C3=A9e

