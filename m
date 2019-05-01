Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89252C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3945B2075E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFPOEBZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3945B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLt1B-0007Es-GM
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 13:27:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLt0E-0005dh-Tl
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLt0D-0001gJ-ES
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:26:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLt0D-0001e0-52
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:26:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id n25so7694254wmk.4
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:subject:in-reply-to:date:message-id
	:mime-version:content-transfer-encoding;
	bh=uMPGYUgTyiwfgPNUcPgtB09Iv1BGZouhictmutLTguc=;
	b=zFPOEBZy3jwkdw7ZA50vBhame9EXPfQ6qJgx1SPn6XFohs/w6pZKLday4pwRzbmR7f
	QzFjOJotW1XUzsVL2+8evu1+qxSl6LUwUWI5BjVwEdvO0XYFDYExnvOKbCybmjI+4h21
	NE4jlOovRldCD2QVyyEFs2JfbRN9xg2d/0LZEThbSxwrBa8XY6I8dq7ENM8yoPw4RStR
	tWrOUdI8zrieImL1Te5wfAclzwZGoy9ySNNs3IXgGus526FSbEdZHKIUgVFy7l0zomKI
	j2cRpNYBvod51uZFLzQ71jfuEoqLagX4zxnhX1qsWAPCDcZ98SbBq0C1Foz3oEcd0Nv2
	CfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=uMPGYUgTyiwfgPNUcPgtB09Iv1BGZouhictmutLTguc=;
	b=eepQJ93MbkB7X8DaLGNnTB849cbBpwPsQ8f70jXxPM+rCydZB629UYkCNXAWuD47Dp
	eu3lCZwiR1ic+B5gLwp2Q+9I0VhfZx0RwEVYljJ35U+wMoO83TLIJojlG4GZs77gNeb4
	DztIUF8nvPfzY7Ksx9FciLnbmw6htMxL3BvwLQqTfc8k6oAwhe1QUxy5ucun5wFyLR8D
	5eRdq6TPK2Ga9x7ou1c+9/ZD8OR3v4LOf9+sw0i1bdnFAjFK6/Uhnvi2f4XseJ/IH4H9
	V/raK4vwNhJshz/Q5kVG5P5eXhJfqEezb/FsyyIgHAn2KxovygQYZ6qdbzMRn+/OSEbR
	f19Q==
X-Gm-Message-State: APjAAAXYzsYb/cM6jPrUVd3dhDSZvVUijjNONLOJqYfksz7aYr/NcFur
	Wr7hKx1nQH075EmEcxJ1RxXnUM6YN58=
X-Google-Smtp-Source: APXvYqwe67+9lFSym9D9G8lfSzK8YQ7y/LVnKGni7fVzyhxQmwSby2xTYU+X44oXPJgj8HZHrcVcxw==
X-Received: by 2002:a1c:1941:: with SMTP id 62mr7044854wmz.100.1556731599600; 
	Wed, 01 May 2019 10:26:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	v17sm4345537wmc.30.2019.05.01.10.26.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 10:26:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 6CF881FF87
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 18:26:38 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190501050536.15580-6-richard.henderson@linaro.org>
Date: Wed, 01 May 2019 18:26:38 +0100
Message-ID: <87pnp25bn5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 05/29] tcg: Assert fixed_reg is read-only
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
Message-ID: <20190501172638.G6hjwogJserSkUWTTX21yOhdQMePb8awnK2rkZM2ZV4@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> The only fixed_reg is cpu_env, and it should not be modified
> during any TB.  Therefore code that tries to special-case moves
> into a fixed_reg is dead.  Remove it.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg.c | 87 +++++++++++++++++++++++++------------------------------
>  1 file changed, 40 insertions(+), 47 deletions(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index f7bef51de8..70ca113c26 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3274,11 +3274,8 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, T=
CGTemp *ots,
>                                    tcg_target_ulong val, TCGLifeData arg_=
life,
>                                    TCGRegSet preferred_regs)
>  {
> -    if (ots->fixed_reg) {
> -        /* For fixed registers, we do not do any constant propagation.  =
*/
> -        tcg_out_movi(s, ots->type, ots->reg, val);
> -        return;
> -    }
> +    /* ENV should not be modified.  */
> +    tcg_debug_assert(!ots->fixed_reg);
>
>      /* The movi is not explicitly generated here.  */
>      if (ots->val_type =3D=3D TEMP_VAL_REG) {
> @@ -3314,6 +3311,9 @@ static void tcg_reg_alloc_mov(TCGContext *s, const =
TCGOp *op)
>      ots =3D arg_temp(op->args[0]);
>      ts =3D arg_temp(op->args[1]);
>
> +    /* ENV should not be modified.  */
> +    tcg_debug_assert(!ots->fixed_reg);
> +
>      /* Note that otype !=3D itype for no-op truncation.  */
>      otype =3D ots->type;
>      itype =3D ts->type;
> @@ -3338,7 +3338,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const =
TCGOp *op)
>      }
>
>      tcg_debug_assert(ts->val_type =3D=3D TEMP_VAL_REG);
> -    if (IS_DEAD_ARG(0) && !ots->fixed_reg) {
> +    if (IS_DEAD_ARG(0)) {
>          /* mov to a non-saved dead register makes no sense (even with
>             liveness analysis disabled). */
>          tcg_debug_assert(NEED_SYNC_ARG(0));
> @@ -3351,7 +3351,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const =
TCGOp *op)
>          }
>          temp_dead(s, ots);
>      } else {
> -        if (IS_DEAD_ARG(1) && !ts->fixed_reg && !ots->fixed_reg) {
> +        if (IS_DEAD_ARG(1) && !ts->fixed_reg) {
>              /* the mov can be suppressed */
>              if (ots->val_type =3D=3D TEMP_VAL_REG) {
>                  s->reg_to_temp[ots->reg] =3D NULL;
> @@ -3504,6 +3504,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const =
TCGOp *op)
>              arg =3D op->args[i];
>              arg_ct =3D &def->args_ct[i];
>              ts =3D arg_temp(arg);
> +
> +            /* ENV should not be modified.  */
> +            tcg_debug_assert(!ts->fixed_reg);
> +
>              if ((arg_ct->ct & TCG_CT_ALIAS)
>                  && !const_args[arg_ct->alias_index]) {
>                  reg =3D new_args[arg_ct->alias_index];
> @@ -3512,29 +3516,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const=
 TCGOp *op)
>                                      i_allocated_regs | o_allocated_regs,
>                                      op->output_pref[k], ts->indirect_bas=
e);
>              } else {
> -                /* if fixed register, we try to use it */
> -                reg =3D ts->reg;
> -                if (ts->fixed_reg &&
> -                    tcg_regset_test_reg(arg_ct->u.regs, reg)) {
> -                    goto oarg_end;
> -                }
>                  reg =3D tcg_reg_alloc(s, arg_ct->u.regs, o_allocated_reg=
s,
>                                      op->output_pref[k], ts->indirect_bas=
e);
>              }
>              tcg_regset_set_reg(o_allocated_regs, reg);
> -            /* if a fixed register is used, then a move will be done aft=
erwards */
> -            if (!ts->fixed_reg) {
> -                if (ts->val_type =3D=3D TEMP_VAL_REG) {
> -                    s->reg_to_temp[ts->reg] =3D NULL;
> -                }
> -                ts->val_type =3D TEMP_VAL_REG;
> -                ts->reg =3D reg;
> -                /* temp value is modified, so the value kept in memory is
> -                   potentially not the same */
> -                ts->mem_coherent =3D 0;
> -                s->reg_to_temp[reg] =3D ts;
> +            if (ts->val_type =3D=3D TEMP_VAL_REG) {
> +                s->reg_to_temp[ts->reg] =3D NULL;
>              }
> -        oarg_end:
> +            ts->val_type =3D TEMP_VAL_REG;
> +            ts->reg =3D reg;
> +            /*
> +             * Temp value is modified, so the value kept in memory is
> +             * potentially not the same.
> +             */
> +            ts->mem_coherent =3D 0;
> +            s->reg_to_temp[reg] =3D ts;
>              new_args[i] =3D reg;
>          }
>      }
> @@ -3550,10 +3546,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const=
 TCGOp *op)
>      /* move the outputs in the correct register if needed */
>      for(i =3D 0; i < nb_oargs; i++) {
>          ts =3D arg_temp(op->args[i]);
> -        reg =3D new_args[i];
> -        if (ts->fixed_reg && ts->reg !=3D reg) {
> -            tcg_out_mov(s, ts->type, ts->reg, reg);
> -        }
> +
> +        /* ENV should not be modified.  */
> +        tcg_debug_assert(!ts->fixed_reg);
> +
>          if (NEED_SYNC_ARG(i)) {
>              temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
>          } else if (IS_DEAD_ARG(i)) {
> @@ -3674,26 +3670,23 @@ static void tcg_reg_alloc_call(TCGContext *s, TCG=
Op *op)
>      for(i =3D 0; i < nb_oargs; i++) {
>          arg =3D op->args[i];
>          ts =3D arg_temp(arg);
> +
> +        /* ENV should not be modified.  */
> +        tcg_debug_assert(!ts->fixed_reg);
> +
>          reg =3D tcg_target_call_oarg_regs[i];
>          tcg_debug_assert(s->reg_to_temp[reg] =3D=3D NULL);
> -
> -        if (ts->fixed_reg) {
> -            if (ts->reg !=3D reg) {
> -                tcg_out_mov(s, ts->type, ts->reg, reg);
> -            }
> -        } else {
> -            if (ts->val_type =3D=3D TEMP_VAL_REG) {
> -                s->reg_to_temp[ts->reg] =3D NULL;
> -            }
> -            ts->val_type =3D TEMP_VAL_REG;
> -            ts->reg =3D reg;
> -            ts->mem_coherent =3D 0;
> -            s->reg_to_temp[reg] =3D ts;
> -            if (NEED_SYNC_ARG(i)) {
> -                temp_sync(s, ts, allocated_regs, 0, IS_DEAD_ARG(i));
> -            } else if (IS_DEAD_ARG(i)) {
> -                temp_dead(s, ts);
> -            }
> +        if (ts->val_type =3D=3D TEMP_VAL_REG) {
> +            s->reg_to_temp[ts->reg] =3D NULL;
> +        }
> +        ts->val_type =3D TEMP_VAL_REG;
> +        ts->reg =3D reg;
> +        ts->mem_coherent =3D 0;
> +        s->reg_to_temp[reg] =3D ts;
> +        if (NEED_SYNC_ARG(i)) {
> +            temp_sync(s, ts, allocated_regs, 0, IS_DEAD_ARG(i));
> +        } else if (IS_DEAD_ARG(i)) {
> +            temp_dead(s, ts);
>          }
>      }
>  }


--
Alex Benn=C3=A9e

