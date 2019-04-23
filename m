Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7EEC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5802077C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5802077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIqQn-0001Xw-OK
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 04:05:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqPM-0000s7-Qn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqPL-0002yO-BQ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:04:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hIqPL-0002yB-3A
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:04:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A2C081F0C;
	Tue, 23 Apr 2019 08:04:02 +0000 (UTC)
Received: from [10.36.117.135] (ovpn-117-135.ams2.redhat.com [10.36.117.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79C3260C62;
	Tue, 23 Apr 2019 08:04:00 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-3-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <834f5c7b-c6b5-87b8-2154-3a3875726343@redhat.com>
Date: Tue, 23 Apr 2019 10:03:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 23 Apr 2019 08:04:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/38] tcg: Assert fixed_reg is read-only
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
Message-ID: <20190423080359.ZHhgm_jAXr5ZF0g7IWiJKP1t6wu-TftfA1rprNxMIHA@z>

On 20.04.19 09:34, Richard Henderson wrote:
> The only fixed_reg is cpu_env, and it should not be modified
> during any TB.  Therefore code that tries to special-case moves
> into a fixed_reg is dead.  Remove it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c | 85 +++++++++++++++++++++++++------------------------------
>  1 file changed, 38 insertions(+), 47 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index ade6050982..4f77a957b0 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3279,11 +3279,8 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
>                                    tcg_target_ulong val, TCGLifeData arg_life,
>                                    TCGRegSet preferred_regs)
>  {
> -    if (ots->fixed_reg) {
> -        /* For fixed registers, we do not do any constant propagation.  */
> -        tcg_out_movi(s, ots->type, ots->reg, val);
> -        return;
> -    }
> +    /* ENV should not be modified.  */
> +    tcg_debug_assert(!ots->fixed_reg);
>  
>      /* The movi is not explicitly generated here.  */
>      if (ots->val_type == TEMP_VAL_REG) {
> @@ -3319,6 +3316,9 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>      ots = arg_temp(op->args[0]);
>      ts = arg_temp(op->args[1]);
>  
> +    /* ENV should not be modified.  */
> +    tcg_debug_assert(!ots->fixed_reg);
> +
>      /* Note that otype != itype for no-op truncation.  */
>      otype = ots->type;
>      itype = ts->type;
> @@ -3343,7 +3343,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>      }
>  
>      tcg_debug_assert(ts->val_type == TEMP_VAL_REG);
> -    if (IS_DEAD_ARG(0) && !ots->fixed_reg) {
> +    if (IS_DEAD_ARG(0)) {
>          /* mov to a non-saved dead register makes no sense (even with
>             liveness analysis disabled). */
>          tcg_debug_assert(NEED_SYNC_ARG(0));
> @@ -3356,7 +3356,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>          }
>          temp_dead(s, ots);
>      } else {
> -        if (IS_DEAD_ARG(1) && !ts->fixed_reg && !ots->fixed_reg) {
> +        if (IS_DEAD_ARG(1) && !ts->fixed_reg) {
>              /* the mov can be suppressed */
>              if (ots->val_type == TEMP_VAL_REG) {
>                  s->reg_to_temp[ots->reg] = NULL;
> @@ -3509,6 +3509,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>              arg = op->args[i];
>              arg_ct = &def->args_ct[i];
>              ts = arg_temp(arg);
> +
> +            /* ENV should not be modified.  */
> +            tcg_debug_assert(!ts->fixed_reg);
> +
>              if ((arg_ct->ct & TCG_CT_ALIAS)
>                  && !const_args[arg_ct->alias_index]) {
>                  reg = new_args[arg_ct->alias_index];
> @@ -3517,29 +3521,19 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>                                      i_allocated_regs | o_allocated_regs,
>                                      op->output_pref[k], ts->indirect_base);
>              } else {
> -                /* if fixed register, we try to use it */
> -                reg = ts->reg;
> -                if (ts->fixed_reg &&
> -                    tcg_regset_test_reg(arg_ct->u.regs, reg)) {
> -                    goto oarg_end;
> -                }
>                  reg = tcg_reg_alloc(s, arg_ct->u.regs, o_allocated_regs,
>                                      op->output_pref[k], ts->indirect_base);
>              }
>              tcg_regset_set_reg(o_allocated_regs, reg);
> -            /* if a fixed register is used, then a move will be done afterwards */
> -            if (!ts->fixed_reg) {
> -                if (ts->val_type == TEMP_VAL_REG) {
> -                    s->reg_to_temp[ts->reg] = NULL;
> -                }
> -                ts->val_type = TEMP_VAL_REG;
> -                ts->reg = reg;
> -                /* temp value is modified, so the value kept in memory is
> -                   potentially not the same */
> -                ts->mem_coherent = 0;
> -                s->reg_to_temp[reg] = ts;
> +            if (ts->val_type == TEMP_VAL_REG) {
> +                s->reg_to_temp[ts->reg] = NULL;
>              }
> -        oarg_end:
> +            ts->val_type = TEMP_VAL_REG;
> +            ts->reg = reg;
> +            /* temp value is modified, so the value kept in memory is
> +               potentially not the same */
> +            ts->mem_coherent = 0;
> +            s->reg_to_temp[reg] = ts;
>              new_args[i] = reg;
>          }
>      }
> @@ -3555,10 +3549,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>      /* move the outputs in the correct register if needed */
>      for(i = 0; i < nb_oargs; i++) {
>          ts = arg_temp(op->args[i]);
> -        reg = new_args[i];
> -        if (ts->fixed_reg && ts->reg != reg) {
> -            tcg_out_mov(s, ts->type, ts->reg, reg);
> -        }
> +
> +        /* ENV should not be modified.  */
> +        tcg_debug_assert(!ts->fixed_reg);
> +
>          if (NEED_SYNC_ARG(i)) {
>              temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
>          } else if (IS_DEAD_ARG(i)) {
> @@ -3679,26 +3673,23 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
>      for(i = 0; i < nb_oargs; i++) {
>          arg = op->args[i];
>          ts = arg_temp(arg);
> +
> +        /* ENV should not be modified.  */
> +        tcg_debug_assert(!ts->fixed_reg);
> +
>          reg = tcg_target_call_oarg_regs[i];
>          tcg_debug_assert(s->reg_to_temp[reg] == NULL);
> -
> -        if (ts->fixed_reg) {
> -            if (ts->reg != reg) {
> -                tcg_out_mov(s, ts->type, ts->reg, reg);
> -            }
> -        } else {
> -            if (ts->val_type == TEMP_VAL_REG) {
> -                s->reg_to_temp[ts->reg] = NULL;
> -            }
> -            ts->val_type = TEMP_VAL_REG;
> -            ts->reg = reg;
> -            ts->mem_coherent = 0;
> -            s->reg_to_temp[reg] = ts;
> -            if (NEED_SYNC_ARG(i)) {
> -                temp_sync(s, ts, allocated_regs, 0, IS_DEAD_ARG(i));
> -            } else if (IS_DEAD_ARG(i)) {
> -                temp_dead(s, ts);
> -            }
> +        if (ts->val_type == TEMP_VAL_REG) {
> +            s->reg_to_temp[ts->reg] = NULL;
> +        }
> +        ts->val_type = TEMP_VAL_REG;
> +        ts->reg = reg;
> +        ts->mem_coherent = 0;
> +        s->reg_to_temp[reg] = ts;
> +        if (NEED_SYNC_ARG(i)) {
> +            temp_sync(s, ts, allocated_regs, 0, IS_DEAD_ARG(i));
> +        } else if (IS_DEAD_ARG(i)) {
> +            temp_dead(s, ts);
>          }
>      }
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

